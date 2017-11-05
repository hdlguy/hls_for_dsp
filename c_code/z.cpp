// z.cpp
#include <complex>
#include <math.h>
#include "z.hpp"

// Z(t) = Zc(t) + j*Zs(t);
// Zc(t) = sqrt(2/M)*sum[n=1:M](cos(wd*t*cos(ALPHAn) + PHIn);
// Zs(t) = sqrt(2/M)*sum[n=1:M](cos(wd*t*sin(ALPHAn) + PHIn);


fade_cmplx_type z(  double fd, // doppler frequency in Hz.
                    double t,  // time in seconds.
                    rand_state state) // structure with random variables over 1:M.
{

    fade_type Zc = 0.0;
    fade_type Zs = 0.0;

    // sum over the M sinusoids
    double alpha_n;
    for(int n=1; n<=M; n++){
        alpha_n = (2*M_PI*n - M_PI + state.theta)/(4*M);
        Zc += cos(2*M_PI*fd*t*cos(alpha_n) + state.phi_real[n]);
        Zs += cos(2*M_PI*fd*t*sin(alpha_n) + state.phi_imag[n]);
    }
    Zc *= sqrt(1.0/M);
    Zs *= sqrt(1.0/M);

    // return the complex fade
    fade_cmplx_type Z = fade_cmplx_type(Zc, Zs); 
    return(Z);
}

