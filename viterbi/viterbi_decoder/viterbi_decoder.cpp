#include "viterbi_decoder.h"

// The top-level function to synthesize
//
void viterbi_decoder_top(hls::stream< hls::viterbi_decoder_input<OutputRate,InputDataWidth,HasEraseInput> > &inputData,
                         hls::stream< ap_uint<1> > &outputData) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE axis register both port=outputData
#pragma HLS INTERFACE axis register both port=inputData
#pragma HLS PIPELINE II=1024
#pragma HLS LATENCY max=1024

  // Create instance of Viterbi Decoder class
  static hls::viterbi_decoder<ConstraintLength,
    TracebackLength,
    HasEraseInput,
    SoftData,
    InputDataWidth,
    SoftDataFormat,
    OutputRate,
    ConvolutionCode0,
    ConvolutionCode1,
    ConvolutionCode2,
    ConvolutionCode3,
    ConvolutionCode4,
    ConvolutionCode5,
    ConvolutionCode6> decoder;

  // Call decoder
  decoder(inputData, outputData);

}

