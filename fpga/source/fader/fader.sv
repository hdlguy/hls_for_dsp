//
module fader #(
    parameter M = 8,
    parameter N = 32,
    parameter Wpath = 3,
    parameter Wchan = 5
)(
    input  logic        reset,
    input  logic        clk,
    input  logic [24:0] t_index, // time index
    input  logic        start,
    //
    output logic        dv_out,
    output logic [4:0]  chan_out,
    output logic [15:0] Zc_imag,
    output logic [15:0] Zc_real
);

    logic [24:0] t_latch;
    logic [7:0] arg_count;
    always_ff @(posedge clk) begin
        if (start==1) begin
            t_latch <= t_index; // latch time argument.
            arg_count <= M*N-1; // The 3 lsb are the 0 to M-1. The 5 msb are the channel.
        end else begin
            arg_count <= arg_count-1;
        end
    end

    logic [2:0] M_index; // index into the 0 to M-1
    logic [4:0] N_index; // index into the 0 to N-1
    assign M_index = arg_count[2:0];
    assign N_index = arg_count[7:3];


    logic [17:0] wd_sin_alpha, wd_cos_alpha;
    logic [13:0] phi_imag, phi_real, phi_imag_reg, phi_real_reg;
    logic signed [41:0] prod_imag, prod_real;
    logic [13:0] arg_imag, arg_real;
    always_ff @(posedge clk) begin
        // get the fade parameters for this channel and reflector.
        wd_sin_alpha <= states.wd_sin_alpha[N_index][M_index];
        wd_cos_alpha <= states.wd_cos_alpha[N_index][M_index];
        phi_imag     <= states.phi_imag    [N_index][M_index];
        phi_real     <= states.phi_real    [N_index][M_index];

        // Multiply by the time index and pipeline.
        prod_imag <= signed'(wd_sin_alpha) * signed'(t_latch);
        prod_real <= signed'(wd_cos_alpha) * signed'(t_latch);
        phi_imag_reg <= phi_imag;
        phi_real_reg <= phi_real;

        // Add the time variant phase to the non-time variant (Phi).
        // This gives the input to the cosine roms.
        arg_imag <= signed'(prod_imag[42-2:42-2-13]) + signed'(phi_imag_reg);
        arg_real <= signed'(prod_real[42-2:42-2-13]) + signed'(phi_real_reg);        
    end

    // Now feed the cosine roms.

endmodule

    
