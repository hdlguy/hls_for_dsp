// z.hpp
#include <ap_fixed.h>
#include <complex>
#include <cstdint>

const uint32_t N = 4;                    // Number of carrier frequencies to fade.
const uint32_t M = 8;      // number of sinusoids to sum.

typedef double fade_type;

typedef std::complex<fade_type> fade_cmplx_type;

typedef struct {
    fade_type phi_real[M];
    fade_type phi_imag[M];
    fade_type cos_alpha[M];
    fade_type sin_alpha[M];
} rand_state;

// function prototype.
fade_cmplx_type z(fade_type fd, fade_type time, rand_state state);

