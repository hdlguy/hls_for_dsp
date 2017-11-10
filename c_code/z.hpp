// z.hpp
#include <complex>
#include <cstdint>

const uint32_t M = 8;  // number of sinusoids to sum.

typedef double fade_type;
typedef std::complex<fade_type> fade_cmplx_type;

typedef struct {
    double phi_real[M];
    double phi_imag[M];
    double theta;
    double cos_alpha[M];
    double sin_alpha[M];
} rand_state;

// function prototype.
fade_cmplx_type z(double fd, double time, rand_state state);

