// fader_tb.sv

module fader_tb ();

    logic        reset;
    logic        clk;
    logic [24:0] t_index;
    logic        start;
    logic        dv_out;
    logic [4:0]  chan_out;
    logic [15:0] Zc_imag, Zc_real;

    localparam clk_period = 10;

    initial forever begin
        clk = 0;
        #(clk_period/2);
        clk = 1;
        #(clk_period/2);
    end

    fader uut (.*);

endmodule

