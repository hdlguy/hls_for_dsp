// win.sv

module win #(
    parameter Dwidth = 16,
    parameter Nwin = 32,
    parameter Iwidth = 5
)  (
    input  logic              clk,
    input  logic              dv_in,
    input  logic [Iwidth-1:0] index_in,
    input  logic [Dwidth-1:0] din_imag, din_real,
    output logic              dv_out,
    output logic [Iwidth-1:0] index_out,
    output logic [Dwidth-1:0] dout_imag, dout_real
);


    // Hanning window
    const logic [Nwin-1:0][Dwidth-1:0] win = {
        16'd0,
        16'd335,
        16'd1328,
        16'd2937,
        16'd5096,
        16'd7717,
        16'd10693,
        16'd13903,
        16'd17213,
        16'd20490,
        16'd23599,
        16'd26412,
        16'd28815,
        16'd30708,
        16'd32016,
        16'd32683,
        16'd32683,
        16'd32016,
        16'd30708,
        16'd28815,
        16'd26412,
        16'd23599,
        16'd20490,
        16'd17213,
        16'd13903,
        16'd10693,
        16'd7717,
        16'd5096,
        16'd2937,
        16'd1328,
        16'd335,
        16'd0
    };

    // pipeline the multiplications.
    logic [Dwidth-1:0] din_imag_reg, din_real_reg;
    logic [Dwidth-1:0] win_reg;
    logic [Dwidth*2-1:0] prod_imag, prod_real;
    const logic [Dwidth*2-1:0] round_word = 2**(Dwidth-2);
    logic dv_in_reg, dv_in_reg_reg;
    logic [Iwidth-1:0] index_in_reg, index_in_reg_reg;
    always_ff @(posedge clk) begin
        // first pipeline.
        dv_in_reg <= dv_in; 
        index_in_reg <= index_in;
        din_imag_reg <= din_imag;
        din_real_reg <= din_real;
        win_reg <= win[index_in];
        // multiply pipeline.
        dv_in_reg_reg <= dv_in_reg; 
        index_in_reg_reg <= index_in_reg;
        prod_imag <= (signed'(din_imag_reg) * signed'(win_reg)) + signed'(round_word); // multiply and round.
        prod_real <= (signed'(din_real_reg) * signed'(win_reg)) + signed'(round_word);
        // output pipeline.
        dv_out <= dv_in_reg_reg;
        index_out <= index_in_reg_reg;
        dout_imag <= prod_imag[Dwidth*2-1-1:Dwidth*2-1-Dwidth]; 
        dout_real <= prod_real[Dwidth*2-1-1:Dwidth*2-1-Dwidth];
    end

endmodule

