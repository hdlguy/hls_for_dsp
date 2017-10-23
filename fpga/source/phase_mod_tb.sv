//
module phase_mod_tb(  
    input logic clk                                              
);         

    logic agg_result_M_real_V_ap_vld;    
    logic agg_result_M_imag_V_ap_vld;                                                    
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
    
    logic clk;
    localparam clk_period =10;
    initial forever begin
        clk = 0;
        #(clk_period/2);
        clk = 1;
        #(clk_period/2);
    end
    
    logic reset;    
    initial begin
        reset = 1; 
        #(clk_period*10);
        reset = 0;
        #(clk_period*10);
    end
    
    const real A = 2047.0;
    real bb_angle, ph_angle;
    always_ff @(posedge clk) begin
        if (1 == reset) begin
            bb_angle <= 0.0;
            ph_angle <= 0.0;
            bb_in_M_imag_V <= 0;        
            bb_in_M_real_V <= 0;   
            ph_in_M_imag_V <= 0;   
            ph_in_M_real_V <= 0;
        end else begin
            if (1 == ap_start) begin
                bb_in_M_imag_V <= A*$sin(bb_angle);
                bb_in_M_real_V <= A*$cos(bb_angle);
                ph_in_M_imag_V <= A*$sin(ph_angle);
                ph_in_M_real_V <= A*$cos(ph_angle);   
                ph_angle <= ph_angle + 0.01;
                bb_angle <= bb_angle - 0.03;
            end         
        end
    end  
    
    logic [1:0] start_count;
    always_ff @(posedge clk) begin
        if (reset == 1) begin
            start_count <= 0;
            ap_start <= 0;
        end else begin
            start_count <= start_count - 1;
            if (start_count == 0) ap_start <= 1; else ap_start <= 0;
        end
    end
    
    
    
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
    
    // latch the output
    logic [11:0] result_real, result_imag;
    always_ff @(posedge clk) begin
        if (1 == agg_result_M_imag_V_ap_vld) result_imag <= agg_result_M_imag_V;
        if (1 == agg_result_M_real_V_ap_vld) result_real <= agg_result_M_real_V;
    end        

endmodule
