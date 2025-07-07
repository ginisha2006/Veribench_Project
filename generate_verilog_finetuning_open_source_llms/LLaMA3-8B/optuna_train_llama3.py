import os
import json
import optuna
from transformers import (
    AutoTokenizer, AutoModelForCausalLM,
    BitsAndBytesConfig, TrainingArguments
)
from trl import SFTTrainer
from peft import LoraConfig, prepare_model_for_kbit_training
from datasets import load_dataset

# === CONFIG SECTION ===
MODEL_NAME = "meta-llama/Meta-Llama-3-8B-Instruct"
TARGET_MODULES = ["q_proj", "k_proj", "v_proj", "o_proj", "gate_proj", "up_proj", "down_proj"]

# === Load and preprocess dataset ===
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

dataset = load_dataset("GaTech-EIC/MG-Verilog", split="train[:500]")
dataset = dataset.map(format_prompt)

# === Load tokenizer ===
tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
tokenizer.pad_token = tokenizer.eos_token

def tokenize_function(example):
    return tokenizer(example["text"], truncation=True, padding="max_length", max_length=2048)

tokenized_dataset = dataset.map(tokenize_function, batched=True)
tokenized_dataset.set_format(type="torch", columns=["input_ids", "attention_mask"])

# === 4-bit quantization config ===
bnb_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_compute_dtype="float16",
    bnb_4bit_use_double_quant=True,
    bnb_4bit_quant_type="nf4"
)

# === Optuna objective function ===
def objective(trial):
    # Sample hyperparameters
    learning_rate = trial.suggest_float("learning_rate", 1e-6, 5e-5, log=True)
    per_device_train_batch_size = trial.suggest_categorical("per_device_train_batch_size", [2, 4])
    gradient_accumulation_steps = trial.suggest_categorical("gradient_accumulation_steps", [1, 2, 4])
    lora_r = trial.suggest_categorical("lora_r", [4, 8, 16, 32])
    lora_alpha = trial.suggest_categorical("lora_alpha", [16, 32, 64])
    lora_dropout = trial.suggest_float("lora_dropout", 0.0, 0.3)

    # Load base model
    model = AutoModelForCausalLM.from_pretrained(
        MODEL_NAME,
        quantization_config=bnb_config,
        device_map="auto",
        trust_remote_code=True,
        attn_implementation="eager"
    )
    model.config.use_cache = False
    model = prepare_model_for_kbit_training(model)

    # LoRA config
    lora_config = LoraConfig(
        r=lora_r,
        lora_alpha=lora_alpha,
        lora_dropout=lora_dropout,
        bias="none",
        task_type="CAUSAL_LM",
        target_modules=TARGET_MODULES
    )

    # Define unique output dir per trial
    output_dir = f"./optuna_trials/llama3/trial_{trial.number}"
    os.makedirs(output_dir, exist_ok=True)

    # Training arguments
    training_args = TrainingArguments(
        output_dir=output_dir,
        per_device_train_batch_size=per_device_train_batch_size,
        gradient_accumulation_steps=gradient_accumulation_steps,
        num_train_epochs=1,
        logging_steps=20,
        learning_rate=learning_rate,
        lr_scheduler_type="cosine",
        warmup_ratio=0.1,
        fp16=True,
        optim="adamw_torch_fused",
        save_strategy="epoch"
    )

    # Trainer
    trainer = SFTTrainer(
        model=model,
        args=training_args,
        train_dataset=tokenized_dataset,
        peft_config=lora_config,
    )

    # Train
    trainer.train()
    print(f"[INFO] Trial {trial.number} completed.")

    # Save model adapter
    trainer.model.save_pretrained(output_dir)
    print(f"[INFO] Adapter for trial {trial.number} saved at {output_dir}")

    # Use training loss as objective value (or replace with validation loss if you split)
    # === Extract last available training loss ===
    eval_loss = None
    for entry in reversed(trainer.state.log_history):
        if "loss" in entry:
            eval_loss = entry["loss"]
            break
    if eval_loss is None:
        raise ValueError("No loss found in log history.")
    return eval_loss

# === Launch Optuna Study ===
study = optuna.create_study(direction="minimize")
study.optimize(objective, n_trials=10)

# === Save best params ===
os.makedirs("optuna_trials/llama3", exist_ok=True)
with open("optuna_trials/llama3/best_params.json", "w") as f:
    json.dump(study.best_params, f, indent=4)

print("[INFO] Best hyperparameters:", study.best_params)

