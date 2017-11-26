# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -force proj 
set_property part xc7z020clg484-1 [current_project]
set_property target_language Verilog [current_project]
set_property default_lib work [current_project]
load_features ipintegrator

# read cores
read_ip ../source/fade_ifft/fade_ifft.xci
upgrade_ip -quiet  [get_ips *]
generate_target {all} [get_ips *]

# Read in the hdl source.
read_verilog -sv  [glob ../source/win/win.sv]
read_verilog -sv  [glob ../source/fade_ifft_tb.sv]

current_fileset

set_property top fade_ifft_tb [get_filesets sim_1]
launch_simulation
open_wave_config fade_ifft_tb_behav.wcfg

start_gui

#close_project

