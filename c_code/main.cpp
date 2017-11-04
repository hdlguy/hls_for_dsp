// main.cpp
#include <iostream>
#include <fstream>
#include <math.h>
#include "z.hpp"
//using namespace std;

int main()
{
    const int num_fades = 100;
    const double fd = 10;
    const double Fs = 30.72e6;

    // Initializing the random variables.
    rand_state state;
    for(int i=0; i<M; i++){
        state.phi_real[i] = 2*M_PI*rand();
        state.phi_imag[i] = 2*M_PI*rand();
    }
    state.theta = 2*M_PI*rand();

    // computing fades.
    fade_cmplx_type Z[num_fades];
    double t;
    for(int i=0; i<num_fades; i++){
        t = i/Fs;
        Z[i] = z(fd, t, state);
    }

    // write to file for analysis.
    std::ofstream fp("fade.dat");
    for(int i=0; i<num_fades; i++){
        fp << Z[i] << "\n";
    }
    fp.close();

    return(0);
    
}
