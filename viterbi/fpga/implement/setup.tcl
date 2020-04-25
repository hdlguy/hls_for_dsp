# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -force proj 
#set_property board_part digilentinc.com:arty-a7-35:part0:1.0 [current_project]; # (xc7a35ticsg324-1l)
#set_property board_part digilentinc.com:arty-a7-35:part0:1.0 [current_project]
set_property part xc7a35ticsg324-1L [current_project]


set_property target_language Verilog [current_project]
set_property default_lib work [current_project]
load_features ipintegrator

set_property  ip_repo_paths  {../../viterbi_decoder/proj_viterbi_decoder/solution1/impl/ip ../../convolution_encoder/proj_convolution_encoder/solution1/impl/ip} [current_project]

read_ip ../source/viterbi_dec/viterbi_dec.xci
read_ip ../source/conv_encoder/conv_encoder.xci
read_ip ../source/conv_enc_ila/conv_enc_ila.xci

upgrade_ip -quiet  [get_ips *]
generate_target {all} [get_ips *]

# Read in the hdl source.
read_verilog -sv  ../source/top.sv

read_xdc ../source/top.xdc

close_project
