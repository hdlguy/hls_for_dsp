//
module fade_ifft_tb ();         

    logic clk;
    logic aresetn;
    logic [15 : 0] s_axis_config_tdata;
    logic s_axis_config_tvalid;
    logic s_axis_config_tready;
    logic [31 : 0] s_axis_data_tdata;
    logic s_axis_data_tvalid;
    logic s_axis_data_tready;
    logic s_axis_data_tlast;
    logic [31 : 0] m_axis_data_tdata;
    logic [7 : 0] m_axis_data_tuser;
    logic m_axis_data_tvalid;
    logic m_axis_data_tready;
    logic m_axis_data_tlast;
    logic event_frame_started;
    logic event_tlast_unexpected;
    logic event_tlast_missing;
    logic event_status_channel_halt;
    logic event_data_in_channel_halt;
    logic event_data_out_channel_halt;

    localparam clk_period =10;
    initial forever begin
        clk = 0;
        #(clk_period/2);
        clk = 1;
        #(clk_period/2);
    end
    
    typedef struct {
            logic signed [15:0] im, re;
            logic last; 
    } fft_data_type;

    const fft_data_type fft_data [0:31] = {
        //  imag,  real, tlast
        '{     0,     1023,    1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    1023},
        '{     0,       1023,       1023},
        '{     0,     1023,    1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    -1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    1023},
        '{     0,       1023,       1023},
        '{     0,     1023,    1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    1023},
        '{     0,       1023,       1023},
        '{     0,     1023,    -1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    1023},
        '{     0,    1023,     1023},
        '{     0,     1023,    1023},
        '{     0,       1023,       1023},
        '{     0,     1023,    1023},
        '{     0,    1023,     1023}};

    const logic FWD_INV = 0;
    const logic SCALE = 10'b0101010110;
    logic reset;   
    initial begin
        reset = 1; 
        s_axis_config_tvalid = 0;
        s_axis_config_tdata = {5'd0, SCALE, FWD_INV};
        s_axis_data_tvalid = 0;
        m_axis_data_tready = 0;
        #(clk_period*10);
        reset = 0;
        #(clk_period*10);
        s_axis_config_tvalid = 1;
        #(clk_period*1);
        s_axis_config_tvalid = 0;
        #(clk_period*10);
        m_axis_data_tready = 1;
        #(clk_period*10);
        s_axis_data_tvalid = 1;
    end
    assign aresetn = ~reset;

     
    const int fft_size = 32;
    int dindex;
    always_ff @(posedge clk) begin
        if (reset == 1) begin        
            s_axis_data_tdata <= 32'h00000000;
            s_axis_data_tlast <= 0;
            s_axis_data_tdata <= {fft_data[0].im, fft_data[0].re};
            s_axis_data_tlast <= fft_data[0].last;      
            dindex <= 1;
        end else begin
            if ((s_axis_data_tready == 1) && (s_axis_data_tvalid == 1)) begin                
                s_axis_data_tdata <= {fft_data[dindex].im, fft_data[dindex].re};
                s_axis_data_tlast <= fft_data[dindex].last;      
                if (dindex==fft_size-1) dindex<=0; else dindex<=dindex+1;
            end
        end
    end
    
    
    fade_ifft uut (
        .aclk(clk),                                              
        .aresetn(aresetn), 
        //                                      
        .s_axis_config_tdata(s_axis_config_tdata),               
        .s_axis_config_tvalid(s_axis_config_tvalid),             
        .s_axis_config_tready(s_axis_config_tready),             
        //
        .s_axis_data_tdata(s_axis_data_tdata),                   
        .s_axis_data_tvalid(s_axis_data_tvalid),                 
        .s_axis_data_tready(s_axis_data_tready),                 
        .s_axis_data_tlast(s_axis_data_tlast),
        //                   
        .m_axis_data_tdata(m_axis_data_tdata),                   
        .m_axis_data_tuser(m_axis_data_tuser),                   
        .m_axis_data_tvalid(m_axis_data_tvalid),                 
        .m_axis_data_tready(m_axis_data_tready),                 
        .m_axis_data_tlast(m_axis_data_tlast),
        //                   
        .event_frame_started(event_frame_started),               
        .event_tlast_unexpected(event_tlast_unexpected),         
        .event_tlast_missing(event_tlast_missing),               
        .event_status_channel_halt(event_status_channel_halt),   
        .event_data_in_channel_halt(event_data_in_channel_halt), 
        .event_data_out_channel_halt(event_data_out_channel_halt)
    );

    logic win_dv_in;
    assign win_dv_in = m_axis_data_tvalid;
    logic [4:0] win_index;
    assign win_index = m_axis_data_tuser[4:0];
    logic [16-1:0] win_din_imag, win_din_real;
    assign win_din_imag = m_axis_data_tdata[31:16];
    assign win_din_real = m_axis_data_tdata[15:0];
    logic  win_dv_out;
    logic [16-1:0] win_dout_imag, win_dout_real;
    win windower (
        .clk(clk),
        .dv_in(win_dv_in),
        .index(win_index),
        .din_imag(win_din_imag), 
        .din_real(win_din_real),
        .dv_out(win_dv_out),
        .dout_imag(win_dout_imag),
        .dout_real(win_dout_real)
    );

    
endmodule

