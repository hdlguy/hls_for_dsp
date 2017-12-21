// main.cpp
#include <iostream>
#include <fstream>
#include <math.h>
#include <time.h>
#include "z.hpp"
#include <cstdlib>

const double fd = 100.0;   // doppler frequency.
const double Fs = 10e3;  // sample rate of fader function
const double T  = 4;                 // seconds.
const int num_fades = (int)round((Fs*T));
fade_cmplx_type fade[N][num_fades];

int main()
{

    const double rand_max = ((double)RAND_MAX) + 1.0;

    // Initializing the random variables.
    // These are computed once for each independent carrier to fade.
    rand_state state[N];
    //srand (time(NULL));
    srand (100);
    fade_type theta, alpha;
    for(int j=0; j<N; j++){
        for(int i=0; i<M; i++){
            state[j].phi_real[i] = (2.0*M_PI/rand_max)*rand() - M_PI; // uniformly random over [-M_pi, M_PI].
            state[j].phi_imag[i] = (2.0*M_PI/rand_max)*rand() - M_PI;
        }
        theta = (2.0*M_PI/rand_max)*rand() - M_PI; // uniformly random over [-M_PI, M_PI].
        for(int i=0; i<M; i++){
            alpha = (2.0*M_PI*(i+1) - M_PI + theta)/(4*M);
            state[j].cos_alpha[i] = cos(alpha); // [-1.0, +1.0]
            state[j].sin_alpha[i] = sin(alpha);
        }
    }

    std::cout << "computing fades\n";

    clock_t begin = clock();
    // computing fades.
    double time;
    for(int i=0; i<num_fades; i++){
        time = i/Fs;
        for(int j=0; j<N; j++){
            fade[j][i] = z(fd, time, state[j]);
        }
    }
    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;

    std::cout << "number of fades calculated = " << num_fades << ", execution time = " << time_spent << "\n";

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


