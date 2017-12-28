// main.cpp
#include <iostream>
#include <fstream>
#include <math.h>
#include <time.h>
#include "z.hpp"




int main()
{
    const float T = 1;                 // seconds.
    const int num_fades = (int)round((Fs*T));
    const int N = 4;                    // Number of carrier frequencies to fade.
    fade_cmplx_type fade[N][num_fades];

    // Initializing the random variables.
    // These are computed once for each independent carrier to fade.
    // They will be compiled into the FPGA hardware as constants.
    rand_state state[N];
    double theta, alpha;
    srand(100);
    for(int j=0; j<N; j++){
        for(int i=0; i<M; i++){
            state[j].phi_real[i] = (fade_type)(2.0*M_PI*(((double)rand())/rand_max) - M_PI); // uniformly random over [-M_PI, M_PI).
            state[j].phi_imag[i] = (fade_type)(2.0*M_PI*(((double)rand())/rand_max) - M_PI); // uniformly random over [-M_PI, M_PI).
        }
        for(int i=0; i<M; i++){
            theta = 2.0*M_PI*(((double)rand())/rand_max) - M_PI; // uniformly random over [-M_PI, M_PI).
            alpha = (2.0*M_PI*(i+1) - M_PI + theta)/(4.0*M);
            std::cout << j << ", " << i << " alpha = " << alpha << ", theta = " << theta << "\n";
            state[j].cos_alpha[i]    = (fade_type)cos(alpha); // [-1.0, +1.0]
            state[j].sin_alpha[i]    = (fade_type)sin(alpha);
            //state[j].wd_cos_alpha[i] = (fade_type)(2.0*M_PI*fd*Ts*cos(alpha));
            //state[j].wd_sin_alpha[i] = (fade_type)(2.0*M_PI*fd*Ts*sin(alpha));
        }
    }


    // print the random variables.
    for(int j=0; j<N; j++){
    	std::cout << "channel " << j << ":\nphi = ";
        for(int i=0; i<M; i++){
            std::cout << "(" << state[j].phi_real[i] << " " << state[j].phi_imag[i] << "), ";
        }
//        std::cout << "\n(cos_alpha, sin_alpha) = ";
//        for(int i=0; i<M; i++){
//            std::cout << "(" << state[j].cos_alpha[i] << " " << state[j].sin_alpha[i] << "), ";
//        }
//        std::cout << "\n(wd_cos_alpha, wd_sin_alpha) = ";
//        for(int i=0; i<M; i++){
//            std::cout << "(" << state[j].wd_cos_alpha[i] << " " << state[j].wd_sin_alpha[i] << "), ";
//        }
        std::cout << "\n\n";
    }


    // computing fades.
    float time;
    for(int i=0; i<num_fades; i++){
        time = i*Ts;
        for(int j=0; j<N; j++){
            fade[j][i] = z(fd, time, state[j]);
            //fade[j][i] = z(fd, i, state[j]);
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
