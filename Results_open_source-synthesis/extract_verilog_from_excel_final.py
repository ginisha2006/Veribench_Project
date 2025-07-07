import pandas as pd
import os
import re

# === Config ===
excel_path = "verilog_designs_combined_file_final.xlsx"  # Your Excel file
base_modules_dir = "Modules"  # Where all sheet folders will go

# Load the Excel workbook
xls = pd.ExcelFile(excel_path)
sheet_names = xls.sheet_names

# Sanitize any name (sheet or filename)
def clean_name(name):
    return re.sub(r'\W+', '_', name.strip().lower())

for sheet in sheet_names:
    # Cleaned sheet name → used as folder name
    sheet_clean = clean_name(sheet)
    sheet_dir = os.path.join(base_modules_dir, sheet_clean)
    os.makedirs(sheet_dir, exist_ok=True)

    df = pd.read_excel(xls, sheet_name=sheet)
    top_modules = []  # .v file names from this sheet

    for index, row in df.iterrows():
        try:
            design_name = row["Design Name"]
            verilog_code = row["Generated Verilog Code"]

            if pd.isna(design_name) or pd.isna(verilog_code):
                continue  # skip blank rows

            # Clean design name for filename (remove any unsafe characters like /, ?, etc.)
            design_clean = re.sub(r'[^a-zA-Z0-9_]', '_', design_name.split(".")[-1].strip().lower())
            filename = f"{design_clean}.v"
            filepath = os.path.join(sheet_dir, filename)

            with open(filepath, "w") as f:
                f.write(verilog_code)

            top_modules.append(filename)
        except Exception as e:
            print(f"⚠️ Failed to process row {index} in sheet '{sheet}': {e}")

    # Save list of filenames for this sheet
    list_file = os.path.join(sheet_dir, f"top_modules_list_{sheet_clean}.txt")
    with open(list_file, "w") as f:
        for mod in top_modules:
            f.write(mod + "\n")

    print(f"✅ {len(top_modules)} Verilog files saved to: {sheet_dir}")
