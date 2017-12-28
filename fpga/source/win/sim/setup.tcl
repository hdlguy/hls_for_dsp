# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -force proj 
#set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property part xc7z020clg484-1 [current_project]
set_property target_language Verilog [current_project]
set_property default_lib work [current_project]

# Read in the hdl source.
read_verilog -sv  [glob ../win.sv]
read_verilog -sv  [glob ../win_tb.sv]

close_project
