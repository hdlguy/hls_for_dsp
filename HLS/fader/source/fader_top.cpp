// main.cpp
// This function computs N independent fade channels at time = i*Ts.

#include "z.hpp"

// This header file contains the random variables for each fade channel.
#include "fader_states.hpp"


void fader_top( int i, fade_cmplx_type (&fade)[N] )
{

    // computing the N fades.
    float time = i*Ts;
    for(int j=0; j<N; j++){
        fade[j] = z(fd, time, state[j]);
    }

    return(0);
    
}

