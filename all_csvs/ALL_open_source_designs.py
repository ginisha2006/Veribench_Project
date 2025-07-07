import os
import pandas as pd
# Base directory where all CSVs are stored
csv_folder = "/TVLSI_WORK/Sia/designs"
excel_file = "verilog_designs_combined_file_final.xlsx"

# All model, quant, and prompting combinations
models = ["Qwen2.5-14B", "LLaMA3-8B", "Gemma2-9B"]
quants = ["int4", "int8", "float16"]
prompting = ["zero_shot", "few_shot", "chain_of_thought"]

# Create a writer to write multiple sheets into one Excel file
with pd.ExcelWriter(excel_file) as writer:
    for model in models:
        for pt in prompting:
            for quant in quants:
                filename = f"{model}_final_verilogdesigns_{quant}_all/{pt}_results_.csv"
                filepath = os.path.join(csv_folder, filename)
                try:
                    df = pd.read_csv(filepath)
                    sheet_name = f"{pt}_{quant}_{model}" [:31]  # Limit sheet name to 31 characters
                    df.to_excel(writer, sheet_name=sheet_name, index=False)
                    print(f"✅ Added: {sheet_name}")
                except FileNotFoundError:
                    print(f"⚠ File not found: {filepath}")
                except Exception as e:
                    print(f"❌ Error with file {filepath}: {e}")

print(f"\n📁 Excel file created: {excel_file}")