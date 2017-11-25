// win.sv

module #(
    parameter Dwidth = 16;
    parameter Nwin = 32;
    parameter Iwidth = $clog(Nwin);
) (
    input  logic              clk;
    input  logic              dv_in;
    input  logic [Iwidth-1:0] index;
    input  logic [Dwidth-1:0] din_imag, din_real;
    output logic              dv_out;
    output logic [Dwidth-1:0] dout_imag, dout_real
);


    // Hanning window
    const logic [Nwin-1:0][Dwidth-1:0] win = {
        0,
        335,
        1328,
        2937,
        5096,
        7717,
        10693,
        13903,
        17213,
        20490,
        23599,
        26412,
        28815,
        30708,
        32016,
        32683,
        32683,
        32016,
        30708,
        28815,
        26412,
        23599,
        20490,
        17213,
        13903,
        10693,
        7717,
        5096,
        2937,
        1328,
        335,
        0
    };

    // pipeline the multiplications.
    logic [Dwidth-1:0] din_imag_reg, din_real_reg;
    logic [Dwidth-1:0] win_reg;
    logic [Nwin-1:0] prod_imag, prod_real;
    always_ff @(posedge clk) begin
        din_imag_reg <= din_imag;
        din_real_reg <= din_real;
        win_reg <= win[index];
        prod_imag <= din_imag_reg * win_reg;
        prod_real <= din_real_reg * win_reg;
        dout_imag <= prod_imag[Dwidth*2-1-1:Dwidth*2-1-Dwidth];
        dout_real <= prod_real[Dwidth*2-1-1:Dwidth*2-1-Dwidth];
    end

endmodule

