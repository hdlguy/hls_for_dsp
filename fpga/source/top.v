
module top(  
    input logic clk                                              
);         

    logic agg_result_M_real_V_ap_vld;    
    logic agg_result_M_imag_V_ap_vld;    
    logic clk;                                                
    logic ap_start;                       
    logic ap_done ;                      
    logic ap_idle ;                      
    logic ap_ready ;                     
    logic [11 : 0] agg_result_M_real_V ; 
    logic [11 : 0] agg_result_M_imag_V ; 
    logic [11 : 0] bb_in_M_real_V;        
    logic [11 : 0] bb_in_M_imag_V ;       
    logic [11 : 0] ph_in_M_real_V ;       
    logic [11 : 0] ph_in_M_imag_V;
    
    logic [1:0] start_count;
    always_ff @(posedge clk) start_count = start_count - 1;
    always_ff @(posedge clk) if (start_count ==0) ap_start <= 1; else ap_start <= 0;
    
    phase_mod_0 phase_mod_inst (
        .agg_result_M_real_V_ap_vld(agg_result_M_real_V_ap_vld),  // output wire agg_result_M_real_V_ap_vld
        .agg_result_M_imag_V_ap_vld(agg_result_M_imag_V_ap_vld),  // output wire agg_result_M_imag_V_ap_vld
        .ap_clk(clk),                                          // input wire ap_clk
        .ap_rst(0),                                          // input wire ap_rst
        .ap_start(ap_start),                                      // input wire ap_start
        .ap_done(ap_done),                                        // output wire ap_done
        .ap_idle(ap_idle),                                        // output wire ap_idle
        .ap_ready(ap_ready),                                      // output wire ap_ready
        .agg_result_M_real_V(agg_result_M_real_V),                // output wire [11 : 0] agg_result_M_real_V
        .agg_result_M_imag_V(agg_result_M_imag_V),                // output wire [11 : 0] agg_result_M_imag_V
        .bb_in_M_real_V(bb_in_M_real_V),                          // input wire [11 : 0] bb_in_M_real_V
        .bb_in_M_imag_V(bb_in_M_imag_V),                          // input wire [11 : 0] bb_in_M_imag_V
        .ph_in_M_real_V(ph_in_M_real_V),                          // input wire [11 : 0] ph_in_M_real_V
        .ph_in_M_imag_V(ph_in_M_imag_V)                           // input wire [11 : 0] ph_in_M_imag_V
    );

endmodule
