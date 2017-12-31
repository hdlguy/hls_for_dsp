// fader_top.sv
// This module supports hardware testing of fader.sv.
// simple logic runs the fader and ILAs observer operation.

module fader_top(
    input logic clk_in
);

    logic clk;
    clk_wiz clk_wiz_inst ( .clk_out(clk), .locked(), .clk_in100(clk_in) );

    logic start, reset;
    assign reset = 0;
    logic [9:0] pulse_count;
    logic [24:0] t_index;
    always_ff @(posedge clk) begin
        pulse_count <= pulse_count - 1;
        if (pulse_count == 0) begin
            start <= 1;
            t_index <= t_index + 1;
        end else begin
            start <= 0;
        end
    end


    logic dv_out;
    logic [4:0]  chan_out;
    logic [15:0] Zc_imag, Zc_real;
    fader uut (
        .reset(reset),
        .clk(clk),
        .t_index(t_index),
        .start(start),
        .dv_out(dv_out),
        .chan_out(chan_out),
        .Zc_imag(Zc_imag),
        .Zc_real(Zc_real)
    );
        
    top_ila ila0 (.clk(clk), .probe0({t_index, start, dv_out, chan_out, Zc_imag, Zc_real}));

endmodule


