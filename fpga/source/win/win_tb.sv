//
module win_tb();         

    localparam Dwidth = 16;
    localparam Nwin = 32;
    localparam Iwidth = 5;

    logic              clk;
    logic              dv_in;
    logic [Iwidth-1:0] index_in;
    logic [Dwidth-1:0] din_imag, din_real;
    logic              dv_out;
    logic [Iwidth-1:0] index_out;
    logic [Dwidth-1:0] dout_imag, dout_real;
    
    localparam clk_period =10;
    initial forever begin
        clk = 0;
        #(clk_period/2);
        clk = 1;
        #(clk_period/2);
    end
    
    initial begin
        dv_in = 0;
        index_in = 0;
        din_imag = 0;
        din_real = 0;
        #(clk_period*10);
        dv_in = 1;
        index_in = 0;
        din_imag = -32768;
        din_real = +32767;
        #(clk_period*1);
        forever begin
            dv_in = 1;
            index_in = index_in + 1;
            #(clk_period*1);
        end
    end

    win uut(.*);
    

endmodule

