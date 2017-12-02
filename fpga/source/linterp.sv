// linterp.sv
// linear interpolator upsampler.

// This module takes a burst of samples from an IFFT and intepolates 
// against the previous burst of samples. The index_in signal indicates
// the position in the burst.

module linterp #(
    parameter dwidth = 16,
    parameter interp = 32,  
    parameter iwidth = $clog2(interp)
) (
    input  logic              clk,
    input  logic              dv_in,
    input  logic [iwidth-1:0] index_in,
    input  logic [dwidth-1:0] din_real, din_imag,
    output logic              dv_out,
    input  logic [iwidth-1:0] index_out,
    output logic [dwidth-1:0] din_real, din_imag
);

    logic [1:0][dwidth-1:0] 

    always_ff @(posedge clk) begin
    end

endmodule
    
