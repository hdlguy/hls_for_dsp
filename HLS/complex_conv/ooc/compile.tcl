# Script to compile the FPGA with zynq processor system all the way to bit file.
close_project -quiet
set outputDir ./results
file mkdir $outputDir
open_project proj.xpr

synth_ip [get_ips *]

synth_design -mode out_of_context -top complex_conv_0
write_checkpoint -force $outputDir/post_synth.dcp

opt_design
place_design
phys_opt_design
route_design

write_checkpoint -force $outputDir/post_route.dcp
report_utilization -file $outputDir/post_route_utilization.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt

close_project

