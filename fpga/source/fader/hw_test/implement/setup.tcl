# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -force proj 
#set_property part xc7a50tftg256-1 [current_project]
set_property part xc7z020clg484-1 [current_project]
set_property target_language verilog [current_project]
set_property default_lib work [current_project]
load_features ipintegrator

set_property  ip_repo_paths ../../../../../HLS/complex_conv/csynth/solution1/impl/ip [current_project]
update_ip_catalog

read_ip ../source/complex_conv_0/complex_conv_0.xci
read_ip ../../../ifft/fade_ifft/fade_ifft.xci
read_ip ../source/linterp_ila/linterp_ila.xci
read_ip ../source/ifft_ila/ifft_ila.xci
read_ip ../../cos_rom/cos_rom.xci
read_ip ../source/top_ila/top_ila.xci
read_ip ../source/clk_wiz/clk_wiz.xci
upgrade_ip -quiet  [get_ips *]
generate_target {all} [get_ips *]

read_verilog -sv ../../../fader/states_pack.sv
read_verilog -sv [glob ../../fader.sv]
read_verilog -sv [glob ../source/complex_conv_wrap.sv]
read_verilog -sv [glob ../source/fader_top.sv]
read_verilog -sv ../../../linterp.sv
read_verilog -sv ../../../win/win.sv

read_xdc ../source/fader_top.xdc

#read_xdc ../source/artix_top_late.xdc
#set_property used_in_synthesis false [get_files  ../../source/artix_top_late.xdc]

close_project


