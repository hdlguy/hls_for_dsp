############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
open_project random_phase_modulator
set_top phase_mod
add_files random_phase_modulator/phase_mod.cpp
add_files random_phase_modulator/phase_mod.hpp
add_files -tb random_phase_modulator/phase_mod_tb.cpp
open_solution "solution1"
set_part {xc7z020clg484-1} -tool vivado
create_clock -period 8 -name default
#source "./random_phase_modulator/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -rtl verilog -format ip_catalog -description "a phase randomizer for fading application" -vendor "hdlguy" -display_name "phase_mod"
