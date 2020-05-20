#include "convolution_encoder.h"

// The top-level function to synthesize
//
void convolution_encoder_top(hls::stream< ap_uint<1> > &inputData, hls::stream< ap_uint<OutputWidth> > &outputData) {
#pragma HLS INTERFACE axis register both port=outputData
#pragma HLS INTERFACE axis register both port=inputData
#pragma HLS INTERFACE ap_ctrl_none port=return

  // Create instance of convolution encoder class
  static hls::convolution_encoder<OutputWidth,
    Punctured,
    DualOutput,
    InputRate,
    OutputRate,
    ConstraintLength,
    PunctureCode0,
    PunctureCode1,
    ConvolutionCode0,
    ConvolutionCode1,
    ConvolutionCode2,
    ConvolutionCode3,
    ConvolutionCode4,
    ConvolutionCode5,
    ConvolutionCode6> encoder;

  // Call encoder
  encoder(inputData, outputData);

}


