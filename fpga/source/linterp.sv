// linterp.sv
// linear interpolator upsampler.

// This module takes a burst of samples from an IFFT and intepolates 
// against the previous burst of samples. The index_in signal indicates
// the position in the burst.

// The IFFT on the input produces a contiguous burst of samples in natural order.

// This first cut just accepts the burst ofNfft samples and latches them simultaineously on the output.

// Later we can do a 1st order interpolator.

module linterp #(
    parameter dwidth = 16,
    parameter Nfft   = 32,  // number of samples in ifft output burst.
    parameter iwidth = $clog2(Nfft)
) (
    input  logic              clk,
    input  logic              dv_in,
    input  logic [iwidth-1:0] index_in,
    input  logic [dwidth-1:0] din_real, din_imag,
    output logic              dv_out,
    input  logic [iwidth-1:0] index_out,
    output logic [Nfft-1:0][dwidth-1:0] dout_real, dout_imag
);

    logic [Nfft-1:0][dwidth-1:0] latch_real, latch_imag;

    always_ff @(posedge clk) begin
        // store the samples as they burst in.
        if (dv_in == 1) begin
            latch_imag[index_in] <= din_imag;
            latch_real[index_in] <= din_real;
        end
        // detect the last sample arriving.
        if ((index_in == Nfft-1) && (dv_in == 1)) begin
            bank_load <= 1;
        else
            bank_load <= 0;
        end 
        // bank load, all at once, the output from the stored samples.
        if (bank_load == 1) begin
            dout_imag <= latch_imag;
            dout_real <= latch_real;
        end
    end

endmodule
    
