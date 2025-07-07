from transformers import AutoTokenizer, BitsAndBytesConfig, AutoModelForCausalLM, TrainingArguments
from peft import LoraConfig, prepare_model_for_kbit_training
from trl import SFTTrainer
from datasets import load_dataset

# === Load model with 4-bit quantization ===
model_name = "google/gemma-2-9b-it"

bnb_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_compute_dtype="float16",
    bnb_4bit_use_double_quant=True,
    bnb_4bit_quant_type="nf4"
)

model = AutoModelForCausalLM.from_pretrained(
    model_name,
    quantization_config=bnb_config,
    device_map="auto",
    trust_remote_code=True,
    attn_implementation='eager'
)

model.config.use_cache = False
# Disable cache to prevent issues with LoRA fine-tuning

# === Tokenizer ===
tokenizer = AutoTokenizer.from_pretrained(model_name)
tokenizer.pad_token = tokenizer.eos_token  # For padding support

# === Prepare model for LoRA-based fine-tuning ===
model = prepare_model_for_kbit_training(model)

lora_config = LoraConfig(
    r=16,
    lora_alpha=32,
    lora_dropout=0.1,
    target_modules=["q_proj", "k_proj", "v_proj", "o_proj"],
    bias="none",
    task_type="CAUSAL_LM"
)

# === Load Verilog code generation dataset ===
dataset = load_dataset("GaTech-EIC/MG-Verilog", split="train[:1000]")  # small subset for testing

# === Format examples into instruction-following prompts ===
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


dataset = dataset.map(format_prompt)

# === Training configuration ===
training_args = TrainingArguments(
    output_dir="./Gemma2-9b-qlora-adapter",
    per_device_train_batch_size=2,
    gradient_accumulation_steps=4,
    num_train_epochs=3,
    logging_steps=10,
    learning_rate=2e-5,
    lr_scheduler_type="cosine",
    warmup_ratio=0.1,
    fp16=True,
    optim="adamw_torch_fused",
    save_strategy="epoch"
)

# === SFT Trainer initialization ===
trainer = SFTTrainer(
    model=model,
    args=training_args,
    train_dataset=dataset,
    peft_config=lora_config,
)

# === Train the model ===
trainer.train()

# === Save final model and tokenizer ===
trainer.model.save_pretrained("./Gemma2-9b-qlora-adapter")
tokenizer.save_pretrained("./Gemma2-9b-qlora-adapter")
print("[INFO] Model and tokenizer saved successfully.")

