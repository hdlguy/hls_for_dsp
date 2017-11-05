// main.cpp
#include <iostream>
#include <fstream>
#include <math.h>
#include "z.hpp"
//using namespace std;

int main()
{
    const int num_fades = 1000000;
    const double fd = 10;
    const double Fs = 1e6;

    // Initializing the random variables.
    rand_state state;
    for(int i=0; i<M; i++){
        state.phi_real[i] = 2*M_PI*rand();
        state.phi_imag[i] = 2*M_PI*rand();
    }
    state.theta = 2*M_PI*rand();


    // computing fades.
    //fade_cmplx_type fade[num_fades];
    fade_cmplx_type* fade = new fade_cmplx_type[num_fades];
    double t;
    for(int i=0; i<num_fades; i++){
        t = i/Fs;
        fade[i] = z(fd, t, state);
        //std::cout << t << ", " << fade[i] << "\n";
    }


    // write to file for analysis.
    std::ofstream fp("fade.dat");
    for(int i=0; i<num_fades; i++){
        fp << real(fade[i]) << "  " << imag(fade[i]) << "\n";
    }
    fp.close();
    delete[] fade;

    return(0);
    
}
