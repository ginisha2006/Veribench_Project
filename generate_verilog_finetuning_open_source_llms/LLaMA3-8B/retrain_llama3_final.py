import os
from transformers import AutoTokenizer, BitsAndBytesConfig, AutoModelForCausalLM, TrainingArguments
from peft import LoraConfig, prepare_model_for_kbit_training
from trl import SFTTrainer
from datasets import load_dataset

# === Best Params from Optuna (EDIT THESE) ===
best_params = {
    "learning_rate": 3.731496100664132e-05,
    "per_device_train_batch_size": 2,
    "gradient_accumulation_steps": 1,
    "lora_r": 16,
    "lora_alpha": 64,
    "lora_dropout": 0.006380028068034127
}

# === Config ===
model_name = "meta-llama/Meta-Llama-3-8B-Instruct"
target_modules = ["q_proj", "k_proj", "v_proj", "o_proj", "gate_proj", "up_proj", "down_proj"]
output_dir = "./llama3-8b-qlora-final"

# === Load dataset ===
def format_prompt(example):
    return {
        "text": (
            "<s>[INST] <<SYS>>\n"
            "You only complete chats with syntax correct Verilog code. End the Verilog module code completion with 'endmodule'. "
            "Do not include module, input and output definitions.\n"
            "<</SYS>>\n\n"
            "Implement the Verilog module based on the following block level summaries. "
            "Assume that signals are positive clock/clk edge triggered unless otherwise stated.\n\n"
            f"{example['description']['block_summary']}\n\n"
            "### Verilog Code:\n"
            f"{example['code']}\n"
            "[/INST]"
        )
    }

dataset = load_dataset("GaTech-EIC/MG-Verilog", split="train")
dataset = dataset.map(format_prompt)

# === Tokenizer ===
tokenizer = AutoTokenizer.from_pretrained(model_name)
tokenizer.pad_token = tokenizer.eos_token

# === BitsAndBytes 4-bit quantization ===
bnb_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_compute_dtype="float16",
    bnb_4bit_use_double_quant=True,
    bnb_4bit_quant_type="nf4"
)

# === Load model and prepare for LoRA ===
model = AutoModelForCausalLM.from_pretrained(
    model_name,
    quantization_config=bnb_config,
    device_map="auto",
    trust_remote_code=True,
    attn_implementation='eager'
)
model.config.use_cache = False
model = prepare_model_for_kbit_training(model)

# === LoRA config using best params ===
lora_config = LoraConfig(
    r=best_params["lora_r"],
    lora_alpha=best_params["lora_alpha"],
    lora_dropout=best_params["lora_dropout"],
    target_modules=target_modules,
    bias="none",
    task_type="CAUSAL_LM"
)

# === Training args ===
training_args = TrainingArguments(
    output_dir=output_dir,
    per_device_train_batch_size=best_params["per_device_train_batch_size"],
    gradient_accumulation_steps=best_params["gradient_accumulation_steps"],
    num_train_epochs=3,
    logging_steps=10,
    learning_rate=best_params["learning_rate"],
    lr_scheduler_type="cosine",
    warmup_ratio=0.1,
    fp16=True,
    optim="adamw_torch_fused",
    save_strategy="epoch"
)

# === Trainer ===
trainer = SFTTrainer(
    model=model,
    args=training_args,
    train_dataset=dataset,
    peft_config=lora_config,
)

# === Train ===
trainer.train()

# === Save model and tokenizer ===
trainer.model.save_pretrained(output_dir)
tokenizer.save_pretrained(output_dir)
print("[INFO] ✅ Final model and tokenizer saved to", output_dir)
