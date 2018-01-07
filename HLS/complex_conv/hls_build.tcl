open_project -reset csynth
set_top complex_conv
add_files source/complex_conv.cpp
add_files source/complex_conv.hpp
add_files -tb source/complex_conv_tb.cpp


open_solution -reset "solution1"
set_part {xc7z020clg484-1} -tool vivado
create_clock -period 6 -name default

csynth_design
export_design -rtl verilog -format ip_catalog -description "this is a complex convolver. input data is complex and N new complex coefficients are supplied for each sample." -vendor "hdlguy" -display_name "complex_conv"

exit

