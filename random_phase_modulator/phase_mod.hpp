//
#include <ap_fixed.h>
#include <complex>

const int bb_width = 12;
typedef ap_fixed<bb_width, 1, AP_RND, AP_SAT, 4> bb_type;

typedef std::complex<bb_type> bb_cplx_type;

bb_cplx_type phase_mod( bb_cplx_type bb_in, bb_cplx_type ph_in);


