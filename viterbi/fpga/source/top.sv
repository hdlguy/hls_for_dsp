//
module top (
    input   logic           clk
);
                                            
    logic ap_rst_n;                        
    logic inputData_V_V_TVALID;            
    logic inputData_V_V_TREADY;           
    logic [7 : 0] inputData_V_V_TDATA;     
    logic outputData_V_V_TVALID;          
    logic outputData_V_V_TREADY;           
    logic [7 : 0] outputData_V_V_TDATA;    
    
    logic[15:0] rst_count= 0;
    logic reset;
    always_ff @(posedge clk) rst_count <= rst_count + 1;
    assign reset = rst_count[15];
    
    logic[3:0] dv_count = 15;
    logic dv;
    always_ff @(posedge clk) begin
        dv_count <= dv_count - 1;
        if (0==dv_count) dv <= 1; else dv <= 0;
    end

    
    logic[0:31] d_array = 32'h0200af31; 
    logic din;     
    logic[4:0] d_count = 0;
    always_ff @(posedge clk) begin
        if (reset) begin
            d_count <= 0;
        end else begin
            if (dv) d_count <= d_count + 1;
        end  
        din <= d_array[d_count];        
    end      
    
    assign ap_rst_n = ~reset;        
    assign inputData_V_V_TDATA[0] = din;
    assign inputData_V_V_TVALID =  dv;
    //assign outputData_V_V_TREADY = 1;            
    conv_encoder conv_encoder_inst (
        .ap_clk(clk),                                  
        .ap_rst_n(ap_rst_n),                           
        .inputData_V_V_TVALID(inputData_V_V_TVALID),    // input  wire inputData_V_V_TVALID
        .inputData_V_V_TREADY(inputData_V_V_TREADY),    // output wire inputData_V_V_TREADY
        .inputData_V_V_TDATA(inputData_V_V_TDATA),      // input  wire [7 : 0] inputData_V_V_TDATA
        .outputData_V_V_TVALID(outputData_V_V_TVALID),  // output wire outputData_V_V_TVALID
        .outputData_V_V_TREADY(outputData_V_V_TREADY),  // input  wire outputData_V_V_TREADY
        .outputData_V_V_TDATA(outputData_V_V_TDATA)     // output wire [7 : 0] outputData_V_V_TDATA
    );
                
                       
    logic viterbi_inputData_V_data_V_TVALID;          
    logic viterbi_inputData_V_data_V_TREADY;          
    logic [7 : 0] viterbi_inputData_V_data_V_TDATA;   
    logic viterbi_outputData_V_V_TVALID;              
    logic viterbi_outputData_V_V_TREADY;              
    logic [7 : 0] viterbi_outputData_V_V_TDATA;       
    
    asssign viterbi_inputData_V_data_V_TVALID = outputData_V_V_TVALID;
    assign outputData_V_V_TREADY = viterbi_inputData_V_data_V_TREADY;
    assign viterbi_inputData_V_data_V_TDATA = outputData_V_V_TDATA;
    assign viterbi_outputData_V_V_TREADY = 1;
    viterbi_dec viterbi_dec_inst (
        .ap_clk(clk),                                          
        .ap_rst_n(ap_rst_n),                                   
        .inputData_V_data_V_TVALID(viterbi_inputData_V_data_V_TVALID),  // input  wire inputData_V_data_V_TVALID
        .inputData_V_data_V_TREADY(viterbi_inputData_V_data_V_TREADY),  // output wire inputData_V_data_V_TREADY
        .inputData_V_data_V_TDATA(viterbi_inputData_V_data_V_TDATA),    // input  wire [7 : 0] inputData_V_data_V_TDATA
        .outputData_V_V_TVALID(viterbi_outputData_V_V_TVALID),          // output wire outputData_V_V_TVALID
        .outputData_V_V_TREADY(viterbi_outputData_V_V_TREADY),          // input  wire outputData_V_V_TREADY
        .outputData_V_V_TDATA(viterbi_outputData_V_V_TDATA)             // output wire [7 : 0] outputData_V_V_TDATA
    );


    conv_enc_ila ila_inst (.clk(clk), .probe0({ap_rst_n, inputData_V_V_TVALID, inputData_V_V_TREADY, inputData_V_V_TDATA[0], outputData_V_V_TVALID, outputData_V_V_TREADY, outputData_V_V_TDATA[1:0],
        viterbi_outputData_V_V_TVALID, viterbi_outputData_V_V_TREADY, viterbi_outputData_V_V_TDATA[0]}) );  // 11


endmodule
