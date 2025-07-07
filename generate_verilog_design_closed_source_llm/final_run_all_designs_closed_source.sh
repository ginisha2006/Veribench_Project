#!/bin/bash

# ==== All model + quant combinations ====
MODELS=("DeepSeek-6.7B")
QUANTS=("int4" "int8" "float16")
PROMPT_TECHNIQUES=("zero_shot" "few_shot" "chain_of_thought")
SCRIPT="/TVLSI_WORK/Sia/design_closed_source/final_generate_verilogdesigns_all.py"

# ==== Designs ====
designs=(
"1. Half Adder"
"2. Full Adder"
"3. Parameterized Adder"
"4. Parameterized Subtractor"
"5. Parameterized Multiplier"
"6. Parameterized Divider"
"7. 32-bit Register File"
"8. Parameterized Shift Register"
"9. 4-bit ALU"
"10. RAM"
"11. ROM"
"12. FSM (1100 pattern)"
"13. Fibonacci Number Generator"
"14. Binary Adder Tree"
"15. Ternary Adder Tree"
"16. Dual Clock Synchronous RAM"
"17. Single Clock Synchronous RAM"
"18. RAM with Separate I/O Ports"
"19. Single-Port RAM"
"20. Counter with Asynchronous Reset"
"21. Bidirectional Pin"
"22. UART (Universal Asynchronous Receiver-Transmitter)"
"23. FFT Module"
"24. Digital Filter"
"25. BCD to Gray Converter"
"26. 7 Segment LCD"
"27. Gray Counter (Design 1)"
"28. Behavioral Counter (Design 2)"
"29. Parameterized Comparator (Design 3)"
"30. Modulation and Demodulation (Design 4)"
"31. Parameterized Counter (Design 5)"
"32. True Dual-Port RAM with a Single Clock (Design 6)"
"33. 8x64 Shift Register with Taps"
)

# ==== Create timestamped log ====
timestamp=$(date +"%Y%m%d_%H%M%S")
nohup_log="nohup_output_$timestamp.log"
echo "Launching with nohup... Logging to: $nohup_log"

# ==== Main loop ====
for MODEL in "${MODELS[@]}"; do
    for QUANT in "${QUANTS[@]}"; do
        for PT in "${PROMPT_TECHNIQUES[@]}"; do
            OUTPUT_DIR="${MODEL}_final_verilogdesigns_${QUANT}_closed_source_${PT}"
            mkdir -p "$OUTPUT_DIR"
            LOG_FILE="$OUTPUT_DIR/${PT}_all_designs_closed_source_.log"
            echo "===== RUNNING $MODEL | $QUANT | $PT =====" > "$LOG_FILE"

            python3 "$SCRIPT" \
                --model_name "$MODEL" \
                --quantization "$QUANT" \
                --prompting_technique "$PT" \
                --designs "${designs[@]}" >> "$LOG_FILE" 2>&1

            CSV_FILE="output_csvs_designs_closed_source/${MODEL}_${PT}_${QUANT}_designs.csv"
            DEST_CSV="$OUTPUT_DIR/${PT}_results_.csv"
            if [ -f "$CSV_FILE" ]; then
                mv "$CSV_FILE" "$DEST_CSV"
                echo "📄 CSV saved to: $DEST_CSV"
            else
                echo "⚠️ CSV not found for $MODEL $QUANT $PT"
            fi

            echo "✅ Finished $MODEL | $QUANT | $PT"
        done
    done
done
echo "All runs completed. Check individual logs in their respective directories."


