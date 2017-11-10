// z.cpp
#include <complex>
#include <math.h>
#include "z.hpp"

// This function generates a single complex fade value for a 
// given time and doppler shift.
// Here are the equations 

// Z(t) = Zc(t) + j*Zs(t);
// Zc(t) = sqrt(2/M)*sum[n=1:M](cos(wd*t*cos(ALPHA(n)) + PHI_real(n));
// Zs(t) = sqrt(2/M)*sum[n=1:M](cos(wd*t*sin(ALPHA(n)) + PHI_imag(n));
// ALPHA(n) = (2*pi*n - pi + theta)/(4*M)
// PHI_real(n), PHI_imag(n) and theta are random variables on [0, 2*pi].


fade_cmplx_type z(  double fd,         // doppler frequency in Hz.
                    double time,       // time in seconds.
                    rand_state state)  // structure with random variables over 1:M.
{

    // sum over the M sinusoids
    //double alpha_n;
    fade_type Zc = 0.0;
    fade_type Zs = 0.0;
    for(int n=1; n<=M; n++){
        //alpha_n = (2*M_PI*n - M_PI + state.theta)/(4*M);   // the cos(alpha_n) and sin(alpha_n) can be pre-computed.
        //Zc += cos(2*M_PI*fd*time*cos(alpha_n) + state.phi_real[n]);
        //Zs += cos(2*M_PI*fd*time*sin(alpha_n) + state.phi_imag[n]);
        Zc += cos(2*M_PI*fd*time*state.cos_alpha[n] + state.phi_real[n]);
        Zs += cos(2*M_PI*fd*time*state.sin_alpha[n] + state.phi_imag[n]);
    }
    Zc *= sqrt(1.0/M);
    Zs *= sqrt(1.0/M);

    // return the complex fade
    fade_cmplx_type Z = fade_cmplx_type(Zc, Zs); 
    return(Z);
}

