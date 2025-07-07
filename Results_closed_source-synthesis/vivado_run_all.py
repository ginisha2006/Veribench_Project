import os
import subprocess
import pandas as pd
import shutil
import numpy as np

vivado_path = r"C:\Xilinx\Vivado\2024.2\bin\vivado.bat"

def save_vivado_logs(flow_name, module_name):
    dest_dir = os.path.join("AllLogs", flow_name)
    os.makedirs(dest_dir, exist_ok=True)
    for ext in ["log", "jou"]:
        src = f"vivado.{ext}"
        if os.path.exists(src):
            shutil.copy(src, os.path.join(dest_dir, f"{module_name}_vivado.{ext}"))

# Read top-level modules
with open("top_modules_list.txt") as f:
    top_modules = [line.strip() for line in f if line.strip()]

modules_dir = "Modules"
output_dir = "AllCSVs"
os.makedirs(output_dir, exist_ok=True)

for subfolder in os.listdir(modules_dir):
    sub_path = os.path.join(modules_dir, subfolder)
    if not os.path.isdir(sub_path):
        continue

    print(f"\n🚀 Running flow for: {subfolder}")
    os.environ["MODULE_PATH"] = os.path.abspath(sub_path)

    # Initialize data containers
    design_names, datapath, logic, routing = [], [], [], []
    dyn, stat, signal, logic_p, io, total = [], [], [], [], [], []
    f7, mem, loglut, sl = [], [], [], []
    lut_vals = {f"lut{i}": [] for i in range(1, 8)}

    for mod in top_modules:
        print(f"⚙  Running: {mod} in {subfolder}")

        # Clean Automation directory
        if os.path.exists("Automation"):
            shutil.rmtree("Automation")
        os.makedirs("Automation", exist_ok=True)

        # Run setup and synthesis TCLs
        subprocess.call(f'"{vivado_path}" -mode batch -source Script/tcl_add.tcl', shell=True)
        subprocess.call(f'"{vivado_path}" -mode batch -source Script/tcl_run.tcl -tclargs {subfolder} {mod}', shell=True)

        # Save logs
        save_vivado_logs(subfolder, mod)
        design_names.append(mod)

        base = os.path.join("Results", subfolder, mod)
        synth_log = os.path.join("AllLogs", subfolder, f"{mod}_synth.log")
        is_synth_ok = False

        if os.path.exists(synth_log):
            with open(synth_log) as f:
                content = f.read().lower()
                if "synth_1 completed successfully" in content or "synthesize finished" in content:
                    is_synth_ok = True

        if not is_synth_ok:
            print(f"❌ Skipping {mod} (synthesis failed or incomplete).")
            for lst in [datapath, logic, routing, dyn, stat, signal, logic_p, io, total, f7, mem, loglut, sl]:
                lst.append(np.nan)
            for i in range(1, 8):
                lut_vals[f"lut{i}"].append(np.nan)
            continue

        # Parse TIMING
        try:
            with open(f"{base}/timing.txt") as f:
                line = next((l for l in f if "Data Path Delay" in l), "")
                parts = line.split()
                datapath.append(float(parts[3][:-2]))
                logic.append(float(parts[5][:-2]))
                routing.append(float(parts[8][:-2]))
        except Exception as e:
            datapath.append(np.nan)
            logic.append(np.nan)
            routing.append(np.nan)

        # Parse POWER
        try:
            with open(f"{base}/power.txt") as f:
                lines = f.read().splitlines()
            dyn.append(float(next(l for l in lines if "Dynamic" in l).split("|")[2].strip()))
            stat.append(float(next(l for l in lines if "Device Static" in l).split("|")[2].strip()))
            signal.append(float(next(l for l in lines if "Signals" in l).split("|")[2].strip()))
            logic_p.append(float(next(l for l in lines if "Slice Logic" in l).split("|")[2].strip()))
            io.append(float(next(l for l in lines if "I/O" in l).split("|")[2].strip()))
            total.append(float(next(l for l in lines if "Total On-Chip Power" in l).split("|")[2].strip()))
        except Exception as e:
            dyn.append(np.nan)
            stat.append(np.nan)
            signal.append(np.nan)
            logic_p.append(np.nan)
            io.append(np.nan)
            total.append(np.nan)

        # Parse UTILIZATION
        try:
            with open(f"{base}/utilization.txt") as f:
                lines = f.read().splitlines()

            def get_val(key, idx):
                for line in lines:
                    if key in line:
                        try:
                            return float(line.split()[idx])
                        except:
                            return np.nan
                return np.nan

            f7.append(get_val('F7 Muxes', 4))
            mem.append(get_val('LUT as Memory', 5))
            loglut.append(get_val('LUT as Logic', 5))
            sl.append(get_val('Slice LUTs', 4))
            for i in range(1, 8):
                lut_vals[f"lut{i}"].append(get_val(f"LUT{i}", 3))
        except:
            f7.append(np.nan)
            mem.append(np.nan)
            loglut.append(np.nan)
            sl.append(np.nan)
            for i in range(1, 8):
                lut_vals[f"lut{i}"].append(np.nan)

    # Final DataFrame creation
    df = pd.DataFrame({
        'DesignName': design_names,
        'DatapathDelay': datapath,
        'logic_delay': logic,
        'routing_delay': routing,
        'DynamicPower': dyn,
        'static_power': stat,
        'signal_power': signal,
        'logic_power': logic_p,
        'i_o_power': io,
        'total_power': total,
        'f7_muxes': f7,
        'lut_as_memory': mem,
        'lut_as_logic': loglut,
        'slice_lut': sl,
        **lut_vals
    })

    out_csv = os.path.join(output_dir, f"Results_{subfolder}.csv")
    df.to_csv(out_csv, index=False)
    print(f"✅ Saved: {out_csv} with {len(df)} rows")