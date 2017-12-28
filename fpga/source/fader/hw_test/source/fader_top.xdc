set_property PACKAGE_PIN Y9 [get_ports clk_in]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]
create_clock -period 10.0 [get_ports clk_in]

