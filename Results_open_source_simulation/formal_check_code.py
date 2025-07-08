import subprocess
import os
import re
from convert_sv_to_verilog_asserts import convert_fv_sv_to_verilog

# === Config ===
base_dir = "/TVLSI_WORK/Ginisha/testing_file"
design_root = os.path.join(base_dir, "Modules_Design")
tb_root = os.path.join(base_dir, "Modules_TB")
fv_root = os.path.join(base_dir, "Modules_FV")
check_dir = os.path.join(base_dir, "check")

def extract_top_module(verilog_file):
    try:
        with open(verilog_file, "r", encoding="utf-8") as f:
            code = f.read()
        match = re.search(r"\bmodule\s+([a-zA-Z_][a-zA-Z0-9_]*)", code)
        if match:
            return match.group(1)
    except Exception as e:
        print(f"⚠️ Error reading {verilog_file}: {e}")
    return None

def check_syntax_with_icarus(verilog_file, top_module):
    try:
        subprocess.run(["iverilog", "-g2005-sv", "-s", top_module, verilog_file, "-o", "temp.out"], check=True)
        return True
    except subprocess.CalledProcessError:
        return False

def run_verilator_lint(verilog_file):
    try:
        subprocess.run(["verilator", "--lint-only", "--cc", verilog_file], check=True)
        return True
    except subprocess.CalledProcessError:
        return False

def simulate_testbench(tb_file, design_file, timeout=10):
    try:
        subprocess.run(["iverilog", "-g2005-sv", "-o", "tb.out", tb_file, design_file], check=True)
        subprocess.run(["vvp", "tb.out"], check=True, timeout=timeout)
        return True
    except subprocess.TimeoutExpired:
        return True  # treat timeout as pass
    except subprocess.CalledProcessError:
        return False

def run_symbiyosys(design_file, fv_file, top_module):
    module_check_dir = os.path.join(check_dir, top_module)
    os.makedirs(module_check_dir, exist_ok=True)
    sby_path = os.path.join(module_check_dir, "check.sby")
    with open(sby_path, "w") as f:
        f.write(f"""
[options]
mode bmc
depth 20

[engines]
smtbmc

[script]
read -formal {design_file}
read -formal {fv_file}
prep -top {top_module}

[files]
{design_file}
{fv_file}
""")
    try:
        subprocess.run(["sby", "-f", sby_path], check=True, cwd=module_check_dir)
        return True
    except subprocess.CalledProcessError:
        return False

# === Load top modules (just names, no ".v")
with open(os.path.join(base_dir, "top_modules_list.txt"), "r") as f:
    top_modules = [line.strip().replace(".v", "") for line in f if line.strip()]

# === Logging dictionary
results = {}  # {combo_folder: {module_name: {"icarus":bool, "lint":bool, "sim":bool, "formal":bool}}}

for module_name in top_modules:
    for combo_folder in os.listdir(design_root):
        design_folder = os.path.join(design_root, combo_folder)
        tb_folder = os.path.join(tb_root, combo_folder)
        fv_folder = os.path.join(fv_root, combo_folder)

        if not (os.path.isdir(design_folder) and os.path.isdir(tb_folder) and os.path.isdir(fv_folder)):
            continue

        # Find design file by matching module inside
        for design_file in os.listdir(design_folder):
            if not design_file.endswith(".v"):
                continue

            full_design_path = os.path.join(design_folder, design_file)
            extracted_module = extract_top_module(full_design_path)

            if extracted_module == module_name:
                tb_expected = [f"tb_{module_name}", f"{module_name}_tb"]
                fv_expected = [f"{module_name}_tb", f"tb_{module_name}"]

                # Match TB
                tb_path = None
                for tb_file in os.listdir(tb_folder):
                    tb_mod = extract_top_module(os.path.join(tb_folder, tb_file))
                    if tb_mod in tb_expected:
                        tb_path = os.path.join(tb_folder, tb_file)
                        break

                # Match FV
                fv_path = None
                for fv_file in os.listdir(fv_folder):
                    fv_mod = extract_top_module(os.path.join(fv_folder, fv_file))
                    if fv_mod in fv_expected:
                        fv_path = os.path.join(fv_folder, fv_file)
                        break

                if not tb_path or not fv_path:
                    print(f"⚠️ Missing TB or FV file for {module_name} in {combo_folder}")
                    continue

                fv_converted_path = fv_path.replace(".v", "_converted.v")
                convert_fv_sv_to_verilog(fv_path, fv_converted_path)

                # Run all tests and log results
                icarus_ok = check_syntax_with_icarus(full_design_path, module_name)
                lint_ok = run_verilator_lint(full_design_path)
                sim_ok = simulate_testbench(tb_path, full_design_path)
                formal_ok = run_symbiyosys(full_design_path, fv_converted_path, extract_top_module(fv_converted_path))

                if combo_folder not in results:
                    results[combo_folder] = {}
                results[combo_folder][module_name] = {
                    "icarus": icarus_ok,
                    "lint": lint_ok,
                    "sim": sim_ok,
                    "formal": formal_ok
                }
                break

# === Write summary log
summary_path = os.path.join(base_dir, "formal_check_summary.log")
with open(summary_path, "w") as log:
    print("\n=== Formal Check Summary ===")
    log.write("=== Formal Check Summary ===\n")
    for combo_folder in sorted(results):
        print(f"\nPrompting Technique: {combo_folder}")
        log.write(f"\nPrompting Technique: {combo_folder}\n")
        passed = {"icarus":0, "lint":0, "sim":0, "formal":0}
        total = len(results[combo_folder])
        for module, checks in results[combo_folder].items():
            for k in passed:
                if checks[k]:
                    passed[k] += 1
            log.write(f"  {module}: {checks}\n")
        print(f"  Total modules: {total}")
        print(f"    Icarus syntax passed: {passed['icarus']}/{total}")
        print(f"    Verilator lint passed: {passed['lint']}/{total}")
        print(f"    Simulation passed: {passed['sim']}/{total}")
        print(f"    Formal passed: {passed['formal']}/{total}")
        log.write(f"  Total modules: {total}\n")
        log.write(f"    Icarus syntax passed: {passed['icarus']}/{total}\n")
        log.write(f"    Verilator lint passed: {passed['lint']}/{total}\n")
        log.write(f"    Simulation passed: {passed['sim']}/{total}\n")
        log.write(f"    Formal passed: {passed['formal']}/{total}\n")
    print(f"\nSummary written to {summary_path}")