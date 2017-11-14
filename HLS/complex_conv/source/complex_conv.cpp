// complex_conv.cpp
#include "complex_conv.hpp"

bb_cplx_type complex_conv( bb_cplx_type x_in, coef_cplx_type (&coef)[num_coefs] )
{
#pragma HLS STREAM variable=x_in dim=1
#pragma HLS STREAM variable=coef dim=1
#pragma HLS PIPELINE II=4


    // Implement the data delay pipeline.
    bb_cplx_type x_delay[num_coefs];
    for(int i=0; i<num_coefs-1; i++){
        x_delay[i+1] = x_delay[i];
    }
    x_delay[0] = x_in;

    // Implement the convolution.
	bb_cplx_type conv_out = 0.0;
    for(int i=0; i<num_coefs; i++){
	    conv_out += x_delay[i] * coef[i];
    }

	return(conv_out);
}

