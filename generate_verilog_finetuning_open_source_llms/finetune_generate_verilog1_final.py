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
from peft import PeftModel

from sample_codes import (
    half_adder_prompt, half_adder_module,
    param_adder_prompt, param_adder_module
)

# ------------------- Pydantic Config -------------------

class GenerationConfig(BaseModel):
    model_name: Literal["LLaMA3-8B", "Gemma2-9B", "Qwen2.5-14B"]
    model_type: Literal["qlora"]
    prompting_technique: Literal["zero_shot", "few_shot", "chain_of_thought"]
    designs: List[str]

    @validator("designs")
    def design_names_not_empty(cls, v):
        if not v:
            raise ValueError("Designs list cannot be empty")
        return [d.strip() for d in v if d.strip()]

# ------------------- Prompt Templates -------------------

system_prompt = (
    "You are a senior FPGA/ASIC engineer. "
    "Generate synthesizable, IEEE-compliant Verilog HDL modules. "
    "Follow best practices: use non-blocking assignments in sequential logic, "
    "Avoid latches in combinational logic, and use parameterization where appropriate. "
    "Output only the Verilog module. No explanations or testbench."
)

ZERO_SHOT_TEMPLATE = (
    "Write a synthesizable Verilog HDL module for the following design: {design_code}. "
    "Output only the Verilog code."
)

CHAIN_OF_THOUGHT_TEMPLATE = (
    "Step 1: Analyze the design requirements for {design_code}.\n"
    "Step 2: Write the synthesizable Verilog HDL code.\n"
    "Output only the Verilog module without explanations."
)

def build_few_shot_prompt(design_code):
    return [
        {"role": "user", "content": f"{system_prompt}\n\nGenerate Verilog module for:\n{half_adder_prompt}"},
        {"role": "assistant", "content": half_adder_module},
        {"role": "user", "content": f"Generate Verilog module for:\n{param_adder_prompt}"},
        {"role": "assistant", "content": param_adder_module},
        {"role": "user", "content": f"Generate Verilog module for:\n{design_code}"}
    ]

# ------------------- Clean Output -------------------

def clean_verilog_output(raw_output: str) -> str:
    cleaned = re.sub(r"```(?:verilog)?\s*", "", raw_output, flags=re.IGNORECASE)
    cleaned = re.sub(r"```", "", cleaned)
    cleaned = cleaned.replace("`", "")
    match = re.search(r"(module\s.*?endmodule)", cleaned, flags=re.DOTALL)
    return match.group(1).strip() if match else cleaned.strip()

# ------------------- Load Prompt -------------------

def load_design_prompt(design_name):
    with open("design_prompts_.json", "r", encoding="utf-8") as f:
        prompts = json.load(f)
    if design_name not in prompts:
        raise ValueError(f"Design prompt not found: {design_name}")
    return prompts[design_name]

# ------------------- Verilog Generation -------------------

def generate_verilog(model, tokenizer, config, design_name, design_prompt):
    print(f"\n[INFO] Generating Verilog for: {design_name}")

    if config.prompting_technique == "few_shot":
        messages = build_few_shot_prompt(design_prompt)
    else:
        user_prompt = {
            "zero_shot": ZERO_SHOT_TEMPLATE,
            "chain_of_thought": CHAIN_OF_THOUGHT_TEMPLATE
        }[config.prompting_technique].format(design_code=design_prompt)

        messages = [{"role": "user", "content": f"{system_prompt}\n\n{user_prompt}"}]

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
    parser = argparse.ArgumentParser()
    parser.add_argument("--model_name", required=True, choices=["Gemma2-9B", "Qwen2.5-14B", "LLaMA3-8B"])
    parser.add_argument("--model_type", required=True, choices=["qlora"])
    parser.add_argument("--prompting_technique", required=True, choices=["zero_shot", "few_shot", "chain_of_thought"])
    parser.add_argument("--designs", nargs="+", required=True)
    args = parser.parse_args()
    config = GenerationConfig(**vars(args))

    # --- Adapter path lookup ---
    ADAPTER_PATHS = {
        "LLaMA3-8B": "/TVLSI_WORK/Sia/finetuning_copy_2/llama3-8b-qlora-final",
        "Gemma2-9B": "/TVLSI_WORK/Sia/finetuning/Gemma2-9b-qlora-final",
        # "Qwen2.5-14B": "/TVLSI_WORK/Sia/Qwen2.5-qlora-adapter"
    }

    adapter_path = ADAPTER_PATHS.get(config.model_name)
    if not adapter_path or not os.path.exists(adapter_path):
        raise ValueError(f"Adapter path for model {config.model_name} not found or does not exist.")

    # --- Model config ---
    base_model_id = {
        "LLaMA3-8B": "meta-llama/Meta-Llama-3-8B-Instruct",
        "Gemma2-9B": "google/gemma-2-9b-it",
        "Qwen2.5-14B": "Qwen/Qwen2.5-14B-Instruct"
    }[config.model_name]

    quant_config = BitsAndBytesConfig(
        load_in_4bit=True,
        bnb_4bit_use_double_quant=True,
        bnb_4bit_quant_type="nf4",
        bnb_4bit_compute_dtype=torch.float16,
    )

    print(f"[INFO] Loading base model: {base_model_id} (QLoRA)")

    base_model = AutoModelForCausalLM.from_pretrained(
        base_model_id,
        device_map="auto",
        trust_remote_code=True,
        use_cache=False,
        attn_implementation="eager",
        quantization_config=quant_config
    )

    print(f"[INFO] Loading QLoRA adapter from: {adapter_path}")
    tokenizer = AutoTokenizer.from_pretrained(adapter_path, trust_remote_code=True)
    model = PeftModel.from_pretrained(base_model, adapter_path, device_map="auto")
    model.eval()

    os.makedirs("output_qlora_csvs_designs", exist_ok=True)
    results = []

    for idx, design_name in enumerate(config.designs, 1):
        try:
            design_prompt = load_design_prompt(design_name)
            verilog_code = generate_verilog(model, tokenizer, config, design_name, design_prompt)
            results.append((idx, design_name, design_prompt, verilog_code))

            print(f"\n--- Verilog Module for {design_name} ---\n")
            print(verilog_code)
            print("\n--- End ---\n")

        except Exception as e:
            print(f"[ERROR] {design_name}: {e}")

    csv_filename = f"{config.model_name}_{config.prompting_technique}_qlora_designs.csv"
    with open(os.path.join("output_qlora_csvs_designs", csv_filename), "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["Design Number", "Design Name", "Prompt Used", "Generated Verilog Code"])
        writer.writerows(results)

    print(f"[INFO] CSV saved to: output_qlora_csvs_designs/{csv_filename}")


if __name__ == "__main__":
    main()
