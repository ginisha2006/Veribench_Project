# Veribench_Project

# Verilog Design Generation and Synthesis using Large Language Models

This repository contains all scripts, results, and workflows associated with the benchmarking of open-source and closed-source Large Language Models (LLMs) for Verilog code generation, testbench synthesis, and formal verification.

The project evaluates the efficacy of various prompting strategies (zero-shot, few-shot, chain-of-thought), quantization settings (int4, int8, float16), and fine-tuning techniques to assess LLM performance across 33 Verilog designs.

---

##  Repository Structure

###  Generation Scripts
- **`generate_verilog_designs_open_source_llms/`**  
  Scripts for generating Verilog modules using open-source models like LLaMA3-8B, Gemma2-9B, Qwen2.5-14B (zero-shot, few-shot, CoT prompting).

- **`generate_verilog_design_closed_source_llm/`**  
  Verilog module generation using closed-source models such as DeepSeek, with different quantization and prompting settings.

- **`generate_testbench/`**  
  Scripts for generating testbenches for Verilog modules using open LLMs.

- **`generate_formal_verification/`**  
  Code for generating formal verification (FV) properties like assertions for each Verilog design.

- **`generate_verilog_finetuning_open_source_llms/`**  
  Scripts for fine-tuning open-source models (Gemma2-9B, LLaMA3-8B) using a custom dataset and Optuna-based hyperparameter tuning.

- **`all_csvs/`**  
  Contains the consolidated CSV files used for analysis, including generation codes.

---

###  Results
- **`Results_closed_source-synthesis/`**  
  Contains Vivado synthesis reports (power, timing, utilization) for Verilog modules generated using closed-source models and scripting and python codes for doing synthesis check and generating reports.

- **`Results_open_source-synthesis/`**  
  Synthesis reports for Verilog modules generated using open-source models (without fine-tuning) and scripting and python codes for doing synthesis check and generating reports.

- **`Results_open_source-finetuned-synthesis/`**  
  Synthesis reports for Verilog designs generated from fine-tuned open-source models and scripting and python codes for doing synthesis check and generating reports.

- **`Result_graphs/`**  
  Bar graphs used in the report/poster (e.g., synthesis success rate, power consumption, LUT usage, delay).



---

##  Summary
This repository explores whether fine-tuned, open-source LLMs can generate synthesizable Verilog designs and outperform or match proprietary baselines in power, timing, and utilization metrics. It also studies the impact of prompting strategies and quantization on synthesis success.

---

##  Models Used
- Open-Source: `LLaMA3-8B`, `Gemma2-9B`, `Qwen2.5-14B`
- Closed-Source: `DeepSeek-Coder-6.7B-Instruct`

---

##  Hardware & Tools
- Inference: NVIDIA RTX A6000 (48 GB VRAM)
- Quantization: `bitsandbytes`
- Fine-tuning: `transformers`, `accelerate`, `Optuna`
- Synthesis: Xilinx Vivado
- Dataset: [MG-Verilog](https://huggingface.co/datasets/GaTech-EIC/MG-Verilog)

---
