import os
import pandas as pd

# Root path where all result subfolders are stored
results_root = r"D:\College\SRIP\fpga-closed_source-synthesis-results\Results"

# Output paths
csv_output_dir = os.path.join(results_root, "aggregated_csvs")
os.makedirs(csv_output_dir, exist_ok=True)

excel_writer = pd.ExcelWriter("Results_closed_source.xlsx", engine='xlsxwriter')

# Loop over each subfolder (each method like chain_of_thought_xxx)
for subfolder in os.listdir(results_root):
    subfolder_path = os.path.join(results_root, subfolder)
    if not os.path.isdir(subfolder_path):
        continue

    print(f"\n📂 Processing synthesis folder: {subfolder}")

    # Containers for CSV
    designs = []
    datapath, logic, routing = [], [], []
    dynamic_pwr, static_pwr, signal_pwr, logic_pwr, io_pwr, total_pwr = [], [], [], [], [], []
    f7_mux, lut_mem, lut_logic, slice_lut = [], [], [], []
    lut_vals = {f'lut{i}': [] for i in range(1, 8)}

    # Iterate over each module
    for module in os.listdir(subfolder_path):
        mod_path = os.path.join(subfolder_path, module)
        if not os.path.isdir(mod_path):
            continue

        print(f"   📦 {module}")
        # Default values
        dpd = ld = rd = 0.0
        dp = sp = sig_p = io = lp = tp = 0.0
        fm = lam = lal = sl = 0.0
        luts = [0.0] * 7

        # === TIMING ===
        try:
            with open(os.path.join(mod_path, "timing.txt")) as f:
                lines = f.read().splitlines()
                info = [line for line in lines if "Data Path Delay" in line]
                if info:
                    parts = info[0].split()
                    dpd = float(parts[3][:-2])
                    ld = float(parts[5][:-2])
                    rd = float(parts[8][:-2])
        except:
            pass
        datapath.append(dpd)
        logic.append(ld)
        routing.append(rd)

        # === POWER ===
        try:
            with open(os.path.join(mod_path, "power.txt")) as f:
                lines = f.read().splitlines()
                get = lambda key, idx: float([line for line in lines if key in line][0].split()[idx])
                dp = get("Dynamic (W)", 4)
                sp = get("Static Power", 4)
                sig_p = get("Signals", 3)
                io = get("I/O", 3)
                lp = get("LUT as Logic", 5)
                tp = get("Total On-Chip Power (W)", 6)
        except:
            pass
        dynamic_pwr.append(dp)
        static_pwr.append(sp)
        signal_pwr.append(sig_p)
        io_pwr.append(io)
        logic_pwr.append(lp)
        total_pwr.append(tp)

        # === UTILIZATION ===
        try:
            with open(os.path.join(mod_path, "utilization.txt")) as f:
                lines = f.read().splitlines()
                get = lambda key, idx: float([line for line in lines if key in line][0].split()[idx])
                fm = get("F7 Muxes", 4)
                lam = get("LUT as Memory", 5)
                lal = get("LUT as Logic", 5)
                sl = get("Slice LUTs", 4)

                for i in range(1, 8):
                    try:
                        luts[i - 1] = get(f"LUT{i}", 3)
                    except:
                        luts[i - 1] = 0.0
        except:
            pass

        f7_mux.append(fm)
        lut_mem.append(lam)
        lut_logic.append(lal)
        slice_lut.append(sl)
        for i in range(1, 8):
            lut_vals[f'lut{i}'].append(luts[i - 1])

        designs.append(module)

    # === Build DataFrame ===
    df = pd.DataFrame({
        "DesignName": designs,
        "DatapathDelay": datapath,
        "logic_delay": logic,
        "routing_delay": routing,
        "DynamicPower": dynamic_pwr,
        "static_power": static_pwr,
        "signal_power": signal_pwr,
        "logic_power": logic_pwr,
        "i_o_power": io_pwr,
        "total_power": total_pwr,
        "f7_muxes": f7_mux,
        "lut_as_memory": lut_mem,
        "lut_as_logic": lut_logic,
        "slice_lut": slice_lut,
        **lut_vals
    })

    # Save CSV
    csv_file = os.path.join(csv_output_dir, f"{subfolder}.csv")
    df.to_csv(csv_file, index=False)

    # Add to Excel workbook
    safe_sheet_name = subfolder[:31]  # Excel limit
    df.to_excel(excel_writer, sheet_name=safe_sheet_name, index=False)

# Final save
excel_writer.close()
print("\n✅ All results saved as individual CSVs + combined Excel: All_Sheets_Combined.xlsx")
