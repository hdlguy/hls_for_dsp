open_project -reset csynth
set_top phase_mod
add_files source/phase_mod.cpp
add_files source/phase_mod.hpp
add_files -tb source/phase_mod_tb.cpp


open_solution -reset "solution1"
set_part {xc7z020clg484-1} -tool vivado
create_clock -period 8 -name default
#source "./directives.tcl"
csim_design
csynth_design
#cosim_design
export_design -rtl verilog -format ip_catalog -description "a phase randomizer for fading application" -vendor "hdlguy" -display_name "phase_mod"

exit


