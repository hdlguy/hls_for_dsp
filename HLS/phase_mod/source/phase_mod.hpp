//
#include <ap_fixed.h>
#include <complex>

const int bb_width = 12;
typedef ap_fixed<bb_width, 1, AP_RND, AP_SAT, 2> bb_type;
typedef std::complex<bb_type> bb_cplx_type;

const int ph_width = 13;
typedef ap_fixed<ph_width, 4, AP_RND, AP_SAT, 2> ph_type;
typedef std::complex<ph_type> ph_cplx_type;

const int prod_width = 18;
typedef ap_fixed<prod_width, 4, AP_RND, AP_SAT, 2> prod_type;
typedef std::complex<prod_type> prod_cplx_type;


bb_cplx_type phase_mod( bb_cplx_type bb_in, bb_cplx_type ph_in);


