#*******************************************************************************
set script_name [file normalize [info script]]
set example_dir [file dirname $script_name]
set example     [file tail $example_dir]

# Create a project
open_project -reset proj_${example}

# Add design files
add_files ${example_dir}/${example}.cpp
# Add test bench & files
add_files -tb ${example_dir}/${example}_tb.cpp
add_files -tb ${example_dir}/din.dat
add_files -tb ${example_dir}/dout.dat

# Set the top-level function
set_top ${example}_top

# Create a solution
open_solution -reset solution1
# Define technology and clock rate
set_part  {xc7a35ticsg324-1l}
create_clock -period 4

# Set any optimization directives
if { [file exists "${example_dir}/directives.tcl"] } {
  puts "  Sourcing directives.tcl...  "
  source "${example_dir}/directives.tcl"
}

csim_design
csynth_design
export_design -rtl verilog -format ip_catalog -description "convolutional encoder" -vendor "hdlguy" -display_name "conv_encoder"

exit

