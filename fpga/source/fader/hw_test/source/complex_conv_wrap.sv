// This wraps the complex convolver to make the coefficient ports arrays.

module complex_conv_wrap (
    input  logic reset,
    input  logic clk,
    input  logic [17:0] imag_in,
    input  logic [17:0] real_in,
    output logic [17:0] imag_out,
    output logic [17:0] real_out,
    
    input  logic [31:0][17:0] coef_imag,
    input  logic [31:0][17:0] coef_real
):

complex_conv_0 conv_inst (
  .agg_result_M_real_V_ap_vld(),  // output wire agg_result_M_real_V_ap_vld
  .agg_result_M_imag_V_ap_vld(),  // output wire agg_result_M_imag_V_ap_vld
  .ap_clk(clk),                                          // input wire ap_clk
  .ap_rst(reset),                                          // input wire ap_rst
  .ap_start(1'b1),                                      // input wire ap_start
  .ap_done(),                                        // output wire ap_done
  .ap_idle(),                                        // output wire ap_idle
  .ap_ready(),                                      // output wire ap_ready
  .agg_result_M_real_V(real_out),                // output wire [17 : 0] agg_result_M_real_V
  .agg_result_M_imag_V(imag_out),                // output wire [17 : 0] agg_result_M_imag_V
  .x_in_M_real_V(real_in),                            // input wire [17 : 0] x_in_M_real_V
  .x_in_M_imag_V(imag_in),                            // input wire [17 : 0] x_in_M_imag_V

  .coef_0_M_real_V(coef_real[0]),                        // input wire [17 : 0] coef_0_M_real_V
  .coef_1_M_real_V(coef_real[1]),                        // input wire [17 : 0] coef_1_M_real_V
  .coef_2_M_real_V(coef_real[2]),                        // input wire [17 : 0] coef_2_M_real_V
  .coef_3_M_real_V(coef_real[3]),                        // input wire [17 : 0] coef_3_M_real_V
  .coef_4_M_real_V(coef_real[4]),                        // input wire [17 : 0] coef_4_M_real_V
  .coef_5_M_real_V(coef_real[5]),                        // input wire [17 : 0] coef_5_M_real_V
  .coef_6_M_real_V(coef_real[6]),                        // input wire [17 : 0] coef_6_M_real_V
  .coef_7_M_real_V(coef_real[7]),                        // input wire [17 : 0] coef_7_M_real_V
  .coef_8_M_real_V(coef_real[8]),                        // input wire [17 : 0] coef_8_M_real_V
  .coef_9_M_real_V(coef_real[9]),                        // input wire [17 : 0] coef_9_M_real_V
  .coef_10_M_real_V(coef_real[10]),                      // input wire [17 : 0] coef_10_M_real_V
  .coef_11_M_real_V(coef_real[11]),                      // input wire [17 : 0] coef_11_M_real_V
  .coef_12_M_real_V(coef_real[12]),                      // input wire [17 : 0] coef_12_M_real_V
  .coef_13_M_real_V(coef_real[13]),                      // input wire [17 : 0] coef_13_M_real_V
  .coef_14_M_real_V(coef_real[14]),                      // input wire [17 : 0] coef_14_M_real_V
  .coef_15_M_real_V(coef_real[15]),                      // input wire [17 : 0] coef_15_M_real_V
  .coef_16_M_real_V(coef_real[16]),                      // input wire [17 : 0] coef_16_M_real_V
  .coef_17_M_real_V(coef_real[17]),                      // input wire [17 : 0] coef_17_M_real_V
  .coef_18_M_real_V(coef_real[18]),                      // input wire [17 : 0] coef_18_M_real_V
  .coef_19_M_real_V(coef_real[19]),                      // input wire [17 : 0] coef_19_M_real_V
  .coef_20_M_real_V(coef_real[20]),                      // input wire [17 : 0] coef_20_M_real_V
  .coef_21_M_real_V(coef_real[21]),                      // input wire [17 : 0] coef_21_M_real_V
  .coef_22_M_real_V(coef_real[22]),                      // input wire [17 : 0] coef_22_M_real_V
  .coef_23_M_real_V(coef_real[23]),                      // input wire [17 : 0] coef_23_M_real_V
  .coef_24_M_real_V(coef_real[24]),                      // input wire [17 : 0] coef_24_M_real_V
  .coef_25_M_real_V(coef_real[25]),                      // input wire [17 : 0] coef_25_M_real_V
  .coef_26_M_real_V(coef_real[26]),                      // input wire [17 : 0] coef_26_M_real_V
  .coef_27_M_real_V(coef_real[27]),                      // input wire [17 : 0] coef_27_M_real_V
  .coef_28_M_real_V(coef_real[28]),                      // input wire [17 : 0] coef_28_M_real_V
  .coef_29_M_real_V(coef_real[29]),                      // input wire [17 : 0] coef_29_M_real_V
  .coef_30_M_real_V(coef_real[30]),                      // input wire [17 : 0] coef_30_M_real_V
  .coef_31_M_real_V(coef_real[31]),                      // input wire [17 : 0] coef_31_M_real_V

  .coef_0_M_imag_V(coef_imag[0]),                        // input wire [17 : 0] coef_0_M_imag_V
  .coef_1_M_imag_V(coef_imag[1]),                        // input wire [17 : 0] coef_1_M_imag_V
  .coef_2_M_imag_V(coef_imag[2]),                        // input wire [17 : 0] coef_2_M_imag_V
  .coef_3_M_imag_V(coef_imag[3]),                        // input wire [17 : 0] coef_3_M_imag_V
  .coef_4_M_imag_V(coef_imag[4]),                        // input wire [17 : 0] coef_4_M_imag_V
  .coef_5_M_imag_V(coef_imag[5]),                        // input wire [17 : 0] coef_5_M_imag_V
  .coef_6_M_imag_V(coef_imag[6]),                        // input wire [17 : 0] coef_6_M_imag_V
  .coef_7_M_imag_V(coef_imag[7]),                        // input wire [17 : 0] coef_7_M_imag_V
  .coef_8_M_imag_V(coef_imag[8]),                        // input wire [17 : 0] coef_8_M_imag_V
  .coef_9_M_imag_V(coef_imag[9]),                        // input wire [17 : 0] coef_9_M_imag_V
  .coef_10_M_imag_V(coef_imag[10]),                      // input wire [17 : 0] coef_10_M_imag_V
  .coef_11_M_imag_V(coef_imag[11]),                      // input wire [17 : 0] coef_11_M_imag_V
  .coef_12_M_imag_V(coef_imag[12]),                      // input wire [17 : 0] coef_12_M_imag_V
  .coef_13_M_imag_V(coef_imag[13]),                      // input wire [17 : 0] coef_13_M_imag_V
  .coef_14_M_imag_V(coef_imag[14]),                      // input wire [17 : 0] coef_14_M_imag_V
  .coef_15_M_imag_V(coef_imag[15]),                      // input wire [17 : 0] coef_15_M_imag_V
  .coef_16_M_imag_V(coef_imag[16]),                      // input wire [17 : 0] coef_16_M_imag_V
  .coef_17_M_imag_V(coef_imag[17]),                      // input wire [17 : 0] coef_17_M_imag_V
  .coef_18_M_imag_V(coef_imag[18]),                      // input wire [17 : 0] coef_18_M_imag_V
  .coef_19_M_imag_V(coef_imag[19]),                      // input wire [17 : 0] coef_19_M_imag_V
  .coef_20_M_imag_V(coef_imag[20]),                      // input wire [17 : 0] coef_20_M_imag_V
  .coef_21_M_imag_V(coef_imag[21]),                      // input wire [17 : 0] coef_21_M_imag_V
  .coef_22_M_imag_V(coef_imag[22]),                      // input wire [17 : 0] coef_22_M_imag_V
  .coef_23_M_imag_V(coef_imag[23]),                      // input wire [17 : 0] coef_23_M_imag_V
  .coef_24_M_imag_V(coef_imag[24]),                      // input wire [17 : 0] coef_24_M_imag_V
  .coef_25_M_imag_V(coef_imag[25]),                      // input wire [17 : 0] coef_25_M_imag_V
  .coef_26_M_imag_V(coef_imag[26]),                      // input wire [17 : 0] coef_26_M_imag_V
  .coef_27_M_imag_V(coef_imag[27]),                      // input wire [17 : 0] coef_27_M_imag_V
  .coef_28_M_imag_V(coef_imag[28]),                      // input wire [17 : 0] coef_28_M_imag_V
  .coef_29_M_imag_V(coef_imag[29]),                      // input wire [17 : 0] coef_29_M_imag_V
  .coef_30_M_imag_V(coef_imag[30]),                      // input wire [17 : 0] coef_30_M_imag_V
  .coef_31_M_imag_V(coef_imag[31])                      // input wire [17 : 0] coef_31_M_imag_V
);

endmodule
