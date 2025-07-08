import pandas as pd
import os
import re

# === Config ===
base_dir = "/TVLSI_WORK"
excel_files = {
    "Modules_Design": "verilog_designs_combined_file_final.xlsx",
    "Modules_TB": "verilog_testbenches_combined_file.xlsx",
    "Modules_FV": "verilog_fv_combined_file.xlsx"
}

# Function to sanitize names
def clean_name(name):
    return re.sub(r'\W+', '_', name.strip().lower())

# ✅ Collect ALL top modules globally
top_modules = set()

# Process each file
for folder_name, excel_path in excel_files.items():
    print(f"\n📂 Processing: {excel_path} -> {folder_name}")

    try:
        xls = pd.ExcelFile(os.path.join(base_dir, excel_path))
    except Exception as e:
        print(f"❌ Failed to open {excel_path}: {e}")
        continue

    for sheet_index, sheet in enumerate(xls.sheet_names):
        sheet_clean = clean_name(sheet)
        sheet_dir = os.path.join(base_dir, folder_name, sheet_clean)
        os.makedirs(sheet_dir, exist_ok=True)

        df = pd.read_excel(xls, sheet_name=sheet)
        df.columns = [col.strip() for col in df.columns]

        for index, row in df.iterrows():
            try:
                design_name = row.get("Design Name")
                verilog_code = row.get("Generated Verilog Code")

                if pd.isna(design_name) or pd.isna(verilog_code):
                    continue

                design_clean = re.sub(r'[^a-zA-Z0-9_]', '_', design_name.split(".")[-1].strip().lower())
                filename = f"{design_clean}.v"
                filepath = os.path.join(sheet_dir, filename)

                with open(filepath, "w", encoding="utf-8") as f:
                    f.write(verilog_code.strip())

                top_modules.add(filename)

            except Exception as e:
                print(f"⚠️ Row {index} in sheet '{sheet}' failed: {e}")

# ✅ Save top_modules_list.txt inside base_dir
list_file = os.path.join(base_dir, "top_modules_list.txt")
with open(list_file, "w", encoding="utf-8") as f:
    for mod in sorted(top_modules):
        f.write(mod + "\n")
print(f"\n📄 Saved master top_modules_list.txt with {len(top_modules)} entries.")
print("🎉 All Excel files processed successfully!")
