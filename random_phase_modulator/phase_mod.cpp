// phase_mod.cpp
#include "phase_mod.hpp"

bb_cplx_type phase_mod( bb_cplx_type bb_in, bb_cplx_type ph_in)
{
#pragma HLS STREAM variable=bb_in dim=1
#pragma HLS STREAM variable=ph_in dim=1
#pragma HLS PIPELINE II=4

	bb_cplx_type mod_out;
	mod_out = bb_in * ph_in;
	return(mod_out);

}
