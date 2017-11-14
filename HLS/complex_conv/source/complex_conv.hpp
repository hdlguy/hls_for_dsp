// complex_conv.hpp
#include <ap_fixed.h>
#include <complex>

const int num_coefs = 32;

const int bb_width = 12;

typedef ap_fixed<bb_width, 1, AP_RND, AP_SAT, 2> bb_type;
typedef std::complex<bb_type> bb_cplx_type;

bb_cplx_type complex_conv( bb_cplx_type x_in, coef_cplx_type (&coef)[num_coefs] );


