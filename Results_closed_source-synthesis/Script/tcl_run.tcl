# tcl_run.tcl

# Open project
open_project [pwd]/Automation/Project_3.xpr

# Read args
set flow_name [lindex $argv 0]
set module [lindex $argv 1]

if {$module eq "" || $flow_name eq ""} {
    puts "❌ flow_name or module not passed to tcl_run.tcl"
    exit 1
}

puts "╢ Flow: $flow_name | Synthesizing module: $module"


# Set top
set_property top $module [current_fileset]
update_compile_order -fileset sources_1

# Get subfolder (flow name)
set base_log_dir "[file normalize ./AllLogs/$flow_name]"
file mkdir $base_log_dir

# Synthesis
reset_run synth_1
launch_runs synth_1 -jobs 40
wait_on_run synth_1

# Save synthesis log
set log_file "[file normalize ./Automation/Project_3.runs/synth_1/runme.log]"
set module_log_path "[file normalize $base_log_dir/${module}_synth.log]"
if {[file exists $log_file]} {
    file copy -force $log_file $module_log_path
} else {
    puts "⚠️ Log file not found for $module"
}

# Check status
set run_status [get_property STATUS [get_runs synth_1]]
if {[string match -nocase "*FAILED*" $run_status]} {
    puts "❌ Synthesis failed for $module"
    exit 1
}

# Implementation
reset_run impl_1
launch_runs impl_1 -jobs 40
wait_on_run impl_1

# Open implementation results
open_run impl_1

# Create result folder per flow and module
set result_dir "Results/$flow_name/$module"
file mkdir $result_dir

# Reports
report_power        > "$result_dir/power.txt"
report_timing       > "$result_dir/timing.txt"
report_utilization  > "$result_dir/utilization.txt"
