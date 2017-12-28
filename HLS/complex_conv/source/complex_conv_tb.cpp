#include <iostream>
#include <fstream>
#include <math.h>
#include "complex_conv.hpp"

int main()
{
	bb_cplx_type x_in, mod_out;
	std::complex<float> expected;

	coef_cplx_type coef[num_coefs];
/*
	// OK now let's try it with filter coefficients. N=32; b=fir1(N, 0.25); b'
    double b[num_coefs] = {
        -702.39481484748842e-06,
          -1.85093227764232e-03,
          -2.51659826744058e-03,
          -1.43978135943244e-03,
           2.57043307819121e-03,
           8.44104448209120e-03,
          11.65811205198107e-03,
           6.33240416867788e-03,
          -9.68282342905717e-03,
         -29.97342391966354e-03,
         -39.53553839514066e-03,
         -21.55754250942210e-03,
          31.83205787085752e-03,
         111.49768256380759e-03,
         192.09280575718753e-03,
         242.83449499985213e-03,
         242.83449499985215e-03,
         192.09280575718756e-03,
         111.49768256380763e-03,
          31.83205787085753e-03,
         -21.55754250942210e-03,
         -39.53553839514065e-03,
         -29.97342391966355e-03,
          -9.68282342905717e-03,
           6.33240416867787e-03,
          11.65811205198107e-03,
           8.44104448209120e-03,
           2.57043307819120e-03,
          -1.43978135943244e-03,
          -2.51659826744058e-03,
          -1.85093227764232e-03,
        -702.39481484748831e-06
    };
*/

    // complex offset passband = 0.0 to 0.2*Fs
    //clear; N=31; b=fir1(N, 0.20); b=b'; mix=exp(j*2*pi*0.1*(0:N)); b=mix.*b'; plot((-128:127)/256,fftshift(abs(fft(b,256)))); b'
	// Plot results with this:
	// load -ascii conv_out.dat; N=length(conv_out); s=conv_out(:,1)+j*conv_out(:,2); plot((-N/2:N/2-1)/N,abs(s));
    std::complex<double> b[num_coefs] = {
        std::complex<double>(-431.98694461593038e-06, +   0.00000000000000e+00),
        std::complex<double>( 556.38521053412376e-06, - 404.23751740625721e-06),
        std::complex<double>( 710.27223077062945e-06, -   2.18599315155551e-03),
        std::complex<double>(  -1.27522779130958e-03, -   3.92474757946187e-03),
        std::complex<double>(  -3.92883828387915e-03, -   2.85446809889380e-03),
        std::complex<double>(  -2.49841287312820e-03, - 305.96733280249873e-21),
        std::complex<double>(   3.46426889723389e-03, -   2.51693868228665e-03),
        std::complex<double>(   4.47886374624411e-03, -  13.78452521706658e-03),
        std::complex<double>(  -7.37549706547741e-03, -  22.69944589690422e-03),
        std::complex<double>( -20.66716703496155e-03, -  15.01557578429003e-03),
        std::complex<double>( -12.57240523911589e-03, -   3.07935116673334e-18),
        std::complex<double>(  15.12501633224374e-03, -  10.98896760215073e-03),
        std::complex<double>(  20.34420599327358e-03, -  62.61302786240015e-03),
        std::complex<double>( -37.02396849902217e-03, - 113.94805833033581e-03),
        std::complex<double>(-135.33829947525342e-03, -  98.32903023669728e-03),
        std::complex<double>(-195.09613889964200e-03, -  71.67715860883619e-18),
        std::complex<double>(-157.83609190674565e-03, + 114.67463322441337e-03),
        std::complex<double>( -51.69463041993482e-03, + 159.09971300379220e-03),
        std::complex<double>(  37.02396849902217e-03, + 113.94805833033587e-03),
        std::complex<double>(  53.26182276451948e-03, +  38.69697935750750e-03),
        std::complex<double>(  18.69554834744780e-03, +   9.15817737680262e-18),
        std::complex<double>( -10.17128949861338e-03, +   7.38987438539694e-03),
        std::complex<double>(  -7.89415535618395e-03, +  24.29571197963114e-03),
        std::complex<double>(   7.37549706547740e-03, +  22.69944589690424e-03),
        std::complex<double>(  11.72581751864676e-03, +   8.51930510292718e-03),
        std::complex<double>(   4.28207184931932e-03, +   2.62201279199395e-18),
        std::complex<double>(  -2.02125847332585e-03, +   1.46853024096242e-03),
        std::complex<double>(  -1.50068268814003e-03, +   4.61862640381247e-03),
        std::complex<double>(   1.27522779130958e-03, +   3.92474757946187e-03),
        std::complex<double>(   1.85951684142272e-03, +   1.35101806683581e-03),
        std::complex<double>( 687.72994189570989e-06, + 505.33576321222574e-21),
        std::complex<double>(-349.48477954239706e-06, + 253.91555522812897e-06)
    };

	for(int i=0; i<num_coefs; i++) coef[i] = b[i];

    // We hit it with an inpulse and printf the results.
    bb_cplx_type conv_out;
	x_in = bb_cplx_type(+0.0,+0.0);
	conv_out = complex_conv(x_in, coef);
	std::cout << "conv_out = " << conv_out << "\n";

	x_in = bb_cplx_type(+1.0,+0.0);
	conv_out = complex_conv(x_in, coef);
	std::cout << "conv_out = " << conv_out << "\n";

	for(int i=0; i<num_coefs+5; i++) {
		x_in = bb_cplx_type(+0.0,+0.0);
		conv_out = complex_conv(x_in, coef);
		std::cout << "conv_out = " << conv_out << "\n";
	}

    // let't try a linear fm chirp.
    const int Nsim = 4096;
    const double F0 = -M_PI;
    const double CR = 2.0*M_PI/Nsim;
    double fr, ph;
    std::complex<double> s0;
    fr = F0;
    ph = 0.0;
    std::ofstream outfile("conv_out.dat");
	for(int i=0; i<Nsim; i++) {
        s0 = exp(std::complex<double>(0.0,1.0)*ph);
        fr += CR;
        ph += fr;
        x_in = s0;
		conv_out = complex_conv(x_in, coef);
        outfile << real(conv_out) << "  " << imag(conv_out) << "\n";
    }
    outfile.close();





	int errors = 0;
	return(errors);
}

