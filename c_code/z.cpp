// z.cpp
#include <complex>
#include <math.h>
#include "z.hpp"

// This function generates a single complex fade value for a 
// given time and doppler frequency.
// Here are the equations 

// Z(t) = Zc(t) + j*Zs(t);
// Zc(t) = sqrt(2/M)*sum[n=1:M](cos(wd*t*cos(ALPHA(n)) + PHI_real(n));
// Zs(t) = sqrt(2/M)*sum[n=1:M](cos(wd*t*sin(ALPHA(n)) + PHI_imag(n));
// ALPHA(n) = (2*pi*n - pi + theta)/(4*M)
// PHI_real(n), PHI_imag(n) and theta are random variables on [0, 2*pi].


fade_cmplx_type z(  fade_type fd,     // doppler frequency in Hz.
                    fade_type time,   // time in seconds.
                    rand_state state) // structure with random variables over 1:M.
{
    const fade_type final_scale = sqrt(2.0/M);

    // sum over the M sinusoids
    fade_type Zc = 0.0;
    fade_type Zs = 0.0;
    for(int n=0; n<M; n++){
        Zc += cos(2*M_PI*fd*time*state.cos_alpha[n] + state.phi_real[n]);
        Zs += cos(2*M_PI*fd*time*state.sin_alpha[n] + state.phi_imag[n]);
    }
    Zc *= final_scale;
    Zs *= final_scale;

    // return the complex fade
    fade_cmplx_type Z = fade_cmplx_type(Zc, Zs); 
    return(Z);
}

