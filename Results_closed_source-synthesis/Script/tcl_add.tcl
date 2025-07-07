# Script/tcl_add.tcl

set folder_path $::env(MODULE_PATH)
create_project -force [pwd]/Automation/Project_3 -part xc7a200tfbg676-2
set_property board_part xilinx.com:ac701:part0:1.4 [current_project]

set file_list [glob -nocomplain -directory $folder_path *.v]
foreach file $file_list {
    add_files -norecurse $file
}

update_compile_order -fileset sources_1
close_project
puts "✅ Finished tcl_add.tcl"
