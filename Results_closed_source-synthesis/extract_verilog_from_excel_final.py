import pandas as pd
import os
import re

# === Config ===
base_dir = os.path.abspath(".")  # Use current working directory
excel_files = {
    "Modules_Design": "verilog_closed_source_designs_file.xlsx",
}

# === Function to sanitize sheet/module names ===
def clean_name(name):
    return re.sub(r'\W+', '_', name.strip().lower())

# ✅ Collect ALL top modules globally
top_modules = set()

# === Process each Excel file ===
for folder_name, excel_filename in excel_files.items():
    print(f"\n📂 Processing: {excel_filename} -> {folder_name}")

    excel_path = os.path.join(base_dir, excel_filename)
    try:
        xls = pd.ExcelFile(excel_path)
    except Exception as e:
        print(f"❌ Failed to open {excel_filename}: {e}")
        continue

    for sheet_index, sheet in enumerate(xls.sheet_names):
        sheet_clean = clean_name(sheet)
        sheet_dir = os.path.join(base_dir, folder_name, sheet_clean)
        os.makedirs(sheet_dir, exist_ok=True)

        try:
            df = pd.read_excel(xls, sheet_name=sheet)
        except Exception as e:
            print(f"❌ Failed to read sheet '{sheet}': {e}")
            continue

        df.columns = [col.strip() for col in df.columns]

        if "Design Name" not in df.columns or "Generated Verilog Code" not in df.columns:
            print(f"❌ Sheet '{sheet}' missing required columns. Skipping.")
            continue

        for index, row in df.iterrows():
            try:
                design_name = row.get("Design Name")
                verilog_code = row.get("Generated Verilog Code")

                if pd.isna(design_name) or pd.isna(verilog_code):
                    continue

                design_clean = re.sub(r'[^a-zA-Z0-9_]', '_', design_name.split(".")[-1].strip().lower())
                mod_name = f"{design_clean}.v"
                file_path = os.path.join(sheet_dir, mod_name)

                with open(file_path, "w", encoding="utf-8") as f:
                    f.write(verilog_code.strip())

                top_modules.add(mod_name)

            except Exception as e:
                print(f"⚠ Row {index} in sheet '{sheet}' failed: {e}")

# ✅ Save master top_modules_list.txt
list_file = os.path.join(base_dir, "top_modules_list.txt")
try:
    with open(list_file, "w", encoding="utf-8") as f:
        for mod in sorted(top_modules):
            f.write(mod + "\n")
    print(f"\n📄 Saved master top_modules_list.txt with {len(top_modules)} entries.")
except Exception as e:
    print(f"❌ Failed to write top_modules_list.txt: {e}")

print("🎉 All Excel files processed successfully!")
