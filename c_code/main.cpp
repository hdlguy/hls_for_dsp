// main.cpp
#include <iostream>
#include <fstream>
#include <math.h>
#include <time.h>
#include "z.hpp"

    //const double fd = 10.0;               // doppler frequency.
    //const double Fs = 100e3;            // sample rate of fader function
    const double T = 1;                 // seconds.
    const int num_fades = (int)round((Fs*T));
    const int N = 4;                    // Number of carrier frequencies to fade.
    fade_cmplx_type fade[N][num_fades];

int main()
{

    const double rand_max = ((double)RAND_MAX) + 1.0;

    // Initializing the random variables.
    // These are computed once for each independent carrier to fade.
    rand_state state[N];
    srand (time(NULL));
    for(int j=0; j<N; j++){
        for(int i=0; i<M; i++){
            state[j].phi_real[i] = (2.0*M_PI/rand_max)*rand(); // uniformly random over [0, 2*M_PI].
            state[j].phi_imag[i] = (2.0*M_PI/rand_max)*rand();
        }
        state[j].theta = (2.0*M_PI/rand_max)*rand(); // uniformly random over [0, 2*M_PI].
        for(int i=0; i<M; i++){
            state[j].cos_alpha[i] = cos((2.0*M_PI*i - M_PI + state[j].theta)/(4*M)); // [-1.0, +1.0]
            state[j].sin_alpha[i] = sin((2.0*M_PI*i - M_PI + state[j].theta)/(4*M));
        }
    }

/*
    // print the random variables.
    for(int j=0; j<N; j++){
        for(int i=0; i<M; i++){
            std::cout << state[j].phi_real[i] << " " << state[j].phi_imag[i] << " ";
        }
        std::cout << state[j].theta << " ";
        std::cout << rand() << "\n";
    }
*/

    // computing fades.
    double time;
    for(int i=0; i<num_fades; i++){
        time = i/Fs;
        for(int j=0; j<N; j++){
            fade[j][i] = z(fd, time, state[j]);
        }
    }


    // write to file for analysis.
    std::ofstream fp("fade.dat");
    for(int i=0; i<num_fades; i++){
        for(int j=0; j<N; j++){
            fp << real(fade[j][i]) << " " << imag(fade[j][i]) << " ";
        }
        fp << "\n";
    }
    fp.close();

    return(0);
    
}
