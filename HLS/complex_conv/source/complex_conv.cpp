// complex_conv.cpp
#include <iostream>
#include "complex_conv.hpp"

bb_cplx_type complex_conv( bb_cplx_type x_in, coef_cplx_type coef[num_coefs] )
{
#pragma HLS ARRAY_PARTITION variable=coef complete dim=1
#pragma HLS STREAM variable=x_in dim=1
#pragma HLS PIPELINE II=4

    // Implement the data delay pipeline.
	static bb_cplx_type x_delay[num_coefs];
    for(int i=num_coefs-1; i>0; i--) {
    	x_delay[i] = x_delay[i-1];
    }
    x_delay[0] = x_in;

    // Implement the multiplications.
	bb_cplx_type conv_out = bb_cplx_type(0.0, 0.0);
    for(int i=0; i<num_coefs; i++){
	    conv_out += x_delay[i] * coef[num_coefs-1-i];
    }

	return(conv_out);
}


