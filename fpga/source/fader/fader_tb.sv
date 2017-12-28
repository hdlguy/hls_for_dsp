// fader_tb.sv
import states_pack::*;

module fader_tb ();

    logic        reset;
    logic        clk;
    logic [24:0] t_index;
    logic        start;
    logic        dv_out;
    logic [4:0]  chan_out;
    logic [15:0] Zc_imag, Zc_real;

    fader uut (.*);

    localparam clk_period = 10;
    initial forever begin
        clk = 0;
        #(clk_period/2);
        clk = 1;
        #(clk_period/2);
    end

    initial begin
        reset = 1;
        start = 0;
        t_index = 0;
        //for(int i=0; i<8; i++) $display("phi_real[31][%d] = %d, ", i, states_pack::state[31].phi_real[i]); 
        //for(int i=0; i<8; i++) $display("phi_imag[31][%d] = %d, ", i, states_pack::state[31].phi_imag[i]); 
        #(clk_period*10);
        reset = 0;
        #(clk_period*10);
        forever begin
            start = 1;
            #(clk_period*1);
            start = 0;
            #(clk_period*299);
            t_index++;
        end
    end

endmodule

