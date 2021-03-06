// fader_top.sv
// This module supports hardware testing of fader.sv.
// simple logic runs the fader and ILAs observer operation.

module fader_top(
    input logic reset_in,
    input logic clk_in
);

    logic clk;
    clk_wiz clk_wiz_inst ( .clk_out(clk), .locked(), .clk_in100(clk_in) );

    // generate a reset.
    logic reset, aresetn;
    logic reset_in_reg, reset_in_reg_reg;
    always_ff @(posedge clk) begin
        reset_in_reg <= reset_in;
        reset_in_reg_reg <= reset_in_reg;
        reset   <=  reset_in_reg_reg;
        aresetn <= ~reset_in_reg_reg;
    end

    logic start;
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

    logic [15 : 0]  fft_s_axis_config_tdata;
    logic           fft_s_axis_config_tvalid;
    logic           fft_s_axis_config_tready;
    logic [31 : 0]  fft_s_axis_data_tdata;
    logic           fft_s_axis_data_tvalid;
    logic           fft_s_axis_data_tready;
    logic           fft_s_axis_data_tlast;
    logic [31 : 0]  fft_m_axis_data_tdata;
    logic [7 : 0]   fft_m_axis_data_tuser;
    logic           fft_m_axis_data_tvalid;
    logic           fft_m_axis_data_tready;
    logic           fft_m_axis_data_tlast;
    logic           fft_event_frame_started;
    logic           fft_event_tlast_unexpected;
    logic           fft_event_tlast_missing;
    logic           fft_event_status_channel_halt;
    logic           fft_event_data_in_channel_halt;
    logic           fft_event_data_out_channel_halt;


    const logic FWD_INV = 0;
    const logic SCALE = 10'b0101010110;

    assign fft_s_axis_data_tvalid = dv_out;
    assign fft_s_axis_data_tdata = {Zc_imag, Zc_real};
    assign fft_s_axis_data_tlast = ( (chan_out == 0) && (dv_out==1) ) ? 1'b1 : 1'b0;

    // little machine to make the config_tvalid for the fft.
    logic sr_config;
    always_ff @(posedge clk) begin
        if (reset == 1'b1) begin
            sr_config <= 1'b0;
            fft_s_axis_config_tvalid <= 1'b0;
        end else begin
            if ( (fft_s_axis_config_tready == 1'b1) && (sr_config==1'b0) ) begin
                sr_config <= 1'b1;
                fft_s_axis_config_tvalid <= 1'b1;
            end else begin
                fft_s_axis_config_tvalid <= 1'b0;
            end
        end
    end

    assign fft_s_axis_config_tdata = {5'd0, SCALE, FWD_INV};
    assign fft_m_axis_data_tready = 1'b1;
    fade_ifft ifft_uut (
        .aclk(clk),                                              
        .aresetn(aresetn), 
        //                                      
        .s_axis_config_tdata            (fft_s_axis_config_tdata),               
        .s_axis_config_tvalid           (fft_s_axis_config_tvalid),             
        .s_axis_config_tready           (fft_s_axis_config_tready),             
        //
        .s_axis_data_tdata              (fft_s_axis_data_tdata),                   
        .s_axis_data_tvalid             (fft_s_axis_data_tvalid),                 
        .s_axis_data_tready             (fft_s_axis_data_tready),                 
        .s_axis_data_tlast              (fft_s_axis_data_tlast),
        //                   
        .m_axis_data_tdata              (fft_m_axis_data_tdata),                   
        .m_axis_data_tuser              (fft_m_axis_data_tuser),                   
        .m_axis_data_tvalid             (fft_m_axis_data_tvalid),                 
        .m_axis_data_tready             (fft_m_axis_data_tready),                 
        .m_axis_data_tlast              (fft_m_axis_data_tlast),
        //                   
        .event_frame_started            (fft_event_frame_started),               
        .event_tlast_unexpected         (fft_event_tlast_unexpected),         
        .event_tlast_missing            (fft_event_tlast_missing),               
        .event_status_channel_halt      (fft_event_status_channel_halt),   
        .event_data_in_channel_halt     (fft_event_data_in_channel_halt), 
        .event_data_out_channel_halt    (fft_event_data_out_channel_halt)
    );


    logic win_dv_in;
    assign win_dv_in = fft_m_axis_data_tvalid;
    logic [4:0] win_index_in, win_index_out;
    assign win_index_in = fft_m_axis_data_tuser[4:0];
    logic [16-1:0] win_din_imag, win_din_real;
    assign win_din_imag = fft_m_axis_data_tdata[31:16];
    assign win_din_real = fft_m_axis_data_tdata[15:0];
    logic  win_dv_out;
    logic [16-1:0] win_dout_imag, win_dout_real;

    ifft_ila ifft_ila_i( .clk(clk), .probe0({win_dv_in, win_index_in}), .probe1({win_din_imag, win_din_real}) );

    win windower (
        .clk(clk),
        .dv_in(win_dv_in),
        .index_in(win_index_in),
        .din_imag(win_din_imag), 
        .din_real(win_din_real),
        .dv_out(win_dv_out),
        .index_out(win_index_out),
        .dout_imag(win_dout_imag),
        .dout_real(win_dout_real)
    );

    ifft_ila win_ila ( .clk(clk), .probe0({win_dv_out, win_index_out}), .probe1({win_dout_imag, win_dout_real}) );


    logic linterp_dv_out;
    logic [31:0][15:0] linterp_dout_real, linterp_dout_imag;
    linterp interpolator(
        .clk(clk),
        .dv_in(win_dv_out),
        .index_in(win_index_out),
        .din_real(win_dout_real),
        .din_imag(win_dout_imag),
        .dout_imag(linterp_dout_imag),
        .dout_real(linterp_dout_real)
    );

    linterp_ila linterp_ila_i ( .clk( clk ), .probe0( {linterp_dout_imag[1], linterp_dout_real[1], linterp_dout_imag[0], linterp_dout_real[0]}) );

    logic [31:0][17:0] coef_imag, coef_real;
    always_comb begin
        for(int i=0; i<32; i++) begin
            coef_imag[i] = {linterp_dout_imag[i], 2'b00};
            coef_real[i] = {linterp_dout_real[i], 2'b00};
        end
    end

    complex_conv_wrap conv_wrap_i (
        .reset(reset),
        .clk(clk),
        .imag_in(0),
        .real_in(0),
        .imag_out(),
        .real_out(),
    
        .coef_imag(coef_imag),
        .coef_real(coef_real)
    );

endmodule


