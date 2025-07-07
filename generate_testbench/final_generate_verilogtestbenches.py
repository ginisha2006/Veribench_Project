#!/usr/bin/env python3

import argparse
import json
import os
import csv
import re
import torch
from typing import Literal, List
from pydantic import BaseModel, validator
from transformers import AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig

from sample_codes import (
    half_adder_prompt, half_adder_tb,
    param_adder_prompt, param_adder_tb
)

# ------------------- Pydantic Config -------------------

class GenerationConfig(BaseModel):
    model_name: Literal["Qwen2.5-14B", "Gemma2-9B", "LLaMA3-8B"]
    quantization: Literal["int4", "int8", "float16"]
    designs: List[str]
    prompting_technique: Literal["zero_shot", "few_shot", "chain_of_thought"]

    @validator("designs")
    def design_names_not_empty(cls, v):
        if not v:
            raise ValueError("Designs list cannot be empty")
        return [d.strip() for d in v if d.strip()]

# ------------------- Prompt Templates -------------------

system_prompt = (
    "You are a senior FPGA/ASIC verification engineer. "
    "Write synthesizable and simulation-ready Verilog HDL testbenches to verify the functionality of given hardware modules. "
    "Use meaningful stimulus covering edge and corner cases. "
    "Do not include assert statements or formal verification constructs. "
    "Include appropriate signal observation using $monitor or $display. "
    "Output only the Verilog testbench module—no explanations, no comments, no extra text."
)

ZERO_SHOT_TEMPLATE = (
    "Write a Verilog HDL testbench to verify the functionality of the following module:\n\n{design_code}\n\n"
    "Only output the Verilog testbench code."
)

CHAIN_OF_THOUGHT_TEMPLATE = (
    "Step 1: Analyze the interface and functionality of the module below.\n"
    "Step 2: Write the Verilog HDL testbench code to simulate and verify its behavior.\n\n"
    "Module:\n{design_code}\n\n"
    "Output only the Verilog testbench module without explanations or comments."
)

def build_few_shot_prompt(design_code):
    return [
        {
            "role": "user",
            "content": (
                f"{system_prompt}\n\n"
                f"Write a Verilog HDL testbench for the following module:\n{half_adder_prompt}"
            )
        },
        {"role": "assistant", "content": half_adder_tb},
        {"role": "user", "content": f"Write a Verilog HDL testbench for the following module:\n{param_adder_prompt}"},
        {"role": "assistant", "content": param_adder_tb},
        {"role": "user", "content": f"Write a Verilog HDL testbench for the following module:\n{design_code}"}
    ]



# ------------------- Model Map -------------------

MODEL_MAP = {
    "Qwen2.5-14B": "Qwen/Qwen2.5-14B-Instruct",
    "Gemma2-9B": "google/gemma-2-9b-it",
    "LLaMA3-8B": "meta-llama/Meta-Llama-3-8B-Instruct"
}

QUANT_MAP = {
    "int4": BitsAndBytesConfig(
        load_in_4bit=True,
        bnb_4bit_use_double_quant=True,
        bnb_4bit_quant_type="nf4",
        bnb_4bit_compute_dtype=torch.float16,
    ),
    "int8": BitsAndBytesConfig(load_in_8bit=True),
    "float16": None
}

# ------------------- Utility: Clean the generated Verilog code -------------------

def clean_verilog_output(raw_output: str) -> str:
    cleaned = re.sub(r"```(?:verilog)?\s*", "", raw_output, flags=re.IGNORECASE)
    cleaned = re.sub(r"```", "", cleaned)
    cleaned = cleaned.replace("`", "")
    match = re.search(r"(module\s.*?endmodule)", cleaned, flags=re.DOTALL)
    if match:
        cleaned = match.group(1)
    return cleaned.strip()

# ------------------- Argument Parser -------------------

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--model_name", required=True, choices=MODEL_MAP.keys())
    parser.add_argument("--quantization", required=True, choices=QUANT_MAP.keys())
    parser.add_argument("--prompting_technique", required=True, choices=["zero_shot", "few_shot", "chain_of_thought"])
    parser.add_argument("--designs", nargs="+", required=True)
    return GenerationConfig(**vars(parser.parse_args()))

# ------------------- Load Prompt -------------------

def load_design_prompt(design_name):
    with open("golden_verilog_codes.json", "r", encoding="utf-8") as f:
        prompts = json.load(f)
    if design_name not in prompts:
        raise ValueError(f"Design prompt not found: {design_name}")
    return prompts[design_name]

# ------------------- Testbench Generation -------------------

def generate_testbench(model, tokenizer, config, design_name, design_code):
    print(f"\n[INFO] Generating testbench for: {design_name}")

    if config.prompting_technique == "few_shot":
        messages = build_few_shot_prompt(design_code)
    else:
        user_prompt = {
            "zero_shot": ZERO_SHOT_TEMPLATE,
            "chain_of_thought": CHAIN_OF_THOUGHT_TEMPLATE
        }[config.prompting_technique].format(design_code=design_code)

        messages = [
            {"role": "user", "content": f"{system_prompt}\n\n{user_prompt}"}
        ]

    # Apply chat template and generate response
    text = tokenizer.apply_chat_template(messages, tokenize=False, add_generation_prompt=True)
    inputs = tokenizer(text, return_tensors="pt").to(model.device)
    
    with torch.no_grad():
        outputs = model.generate(
            **inputs,
            max_new_tokens=1024,
            temperature=0.2,
            top_p=0.95,
            repetition_penalty=1.1,
            do_sample=False,
        )

    raw_output = tokenizer.decode(outputs[0][inputs.input_ids.shape[1]:], skip_special_tokens=True)
    return clean_verilog_output(raw_output)

# ------------------- Main -------------------

def main():
    config = parse_args()
    model_id = MODEL_MAP[config.model_name]
    quant_config = QUANT_MAP[config.quantization]

    print(f"[INFO] Loading model: {model_id} with {config.quantization} quantization.")
    tokenizer = AutoTokenizer.from_pretrained(model_id, trust_remote_code=True)
    model = AutoModelForCausalLM.from_pretrained(
        model_id,
        device_map="cuda:0",
        trust_remote_code=True,
        quantization_config=quant_config,
        torch_dtype=torch.float16 if config.quantization == "float16" else None
    )
    model.eval()

    os.makedirs("output_csvs_tb", exist_ok=True)
    results = []

    for idx, design_name in enumerate(config.designs, 1):
        try:
            design_code = load_design_prompt(design_name)
            tb_code = generate_testbench(model, tokenizer, config, design_name, design_code)
            results.append((idx, design_name, design_code, tb_code))

            print(f"\n--- Verilog Testbench for {design_name} ---\n")
            print(tb_code)
            print("\n--- End ---\n")

        except Exception as e:
            print(f"[ERROR] {design_name}: {e}")

    csv_filename = f"{config.model_name}_{config.prompting_technique}_{config.quantization}_testbench.csv"
    with open(os.path.join("output_csvs_tb", csv_filename), "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["Design Number", "Design Name", "Prompt Used", "Generated Verilog Code"])
        writer.writerows(results)

    print(f"[INFO] CSV saved to: output_csvs_tb/{csv_filename}")

if __name__ == "__main__":
    main()
