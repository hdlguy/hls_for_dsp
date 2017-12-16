// z.hpp
#include <ap_fixed.h>
#include <complex>
//#include <cstdint>


const int fade_width = 24;
typedef ap_fixed<fade_width, 6, AP_RND, AP_SAT, 2> fade_type;
//typedef double fade_type;
typedef std::complex<fade_type> fade_cmplx_type;

const uint32_t  M = 8;      // number of sinusoids to sum.
const double   fd = 10.0;   // doppler frequency.
const double   Fs = 10e3;  // sample rate of fader function
const double   Ts = (1.0/Fs);

const fade_type fade_pi = M_PI;
const double rand_max = ((double)RAND_MAX)+1.0;

typedef struct {
    fade_type phi_real[M];
    fade_type phi_imag[M];
//    double theta;
    fade_type cos_alpha[M];
    fade_type sin_alpha[M];
} rand_state;

// function prototype.
fade_cmplx_type z(fade_type fd, fade_type time, rand_state state);
//fade_cmplx_type z(fade_type fd, int t, rand_state state);

