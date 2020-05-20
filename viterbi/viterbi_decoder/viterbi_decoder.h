

#ifndef VITERBI_H
#define VITERBI_H

#include <hls_stream.h>
#include "ap_int.h"
#include "hls_dsp.h"

const int ConstraintLength = 7;
const int TracebackLength = 6*ConstraintLength; // Traceback length is at least 6x constraint length for non-punctured data
const bool HasEraseInput = false;
const bool SoftData = true; //false;
const int InputDataWidth = 3; //1;
const int SoftDataFormat = 0;
const int OutputRate = 2;
const int ConvolutionCode0 = 121;
const int ConvolutionCode1 = 91;
const int ConvolutionCode2 = 0;
const int ConvolutionCode3 = 0;
const int ConvolutionCode4 = 0;
const int ConvolutionCode5 = 0;
const int ConvolutionCode6 = 0;

void viterbi_decoder_top(hls::stream< hls::viterbi_decoder_input<OutputRate,InputDataWidth,HasEraseInput> > &inputData,
                         hls::stream< ap_uint<1> > &outputData);

#endif

