#include <iostream>
#include "phase_mod.hpp"

int main()
{
	bb_cplx_type bb_in, ph_in, mod_out;
	std::complex<float> expected;

	bb_in = bb_cplx_type(+0.707,+0.707);
	ph_in = bb_cplx_type(-0.707,+0.707);

	const float A = 2047.0/2048.0;
	float bb_angle, ph_angle;
	bb_angle = 0.0;
	ph_angle = 0.0;

	const int iters = 100000;
	const float tolerance = 7e-4;
	int errors = 0;
	for(int i=0; i<iters; i++) {
		bb_in = bb_cplx_type(A*cos(bb_angle), A*sin(bb_angle));
		ph_in = bb_cplx_type(A*cos(ph_angle), A*sin(ph_angle));
		mod_out = phase_mod(bb_in, ph_in);

		expected = std::complex<float>(A*cos(ph_angle), A*sin(ph_angle)) * std::complex<float>(A*cos(bb_angle), A*sin(bb_angle));
		if (
				(std::abs( (float)(std::real(mod_out)) - std::real(expected) ) > tolerance) &&
				(std::abs( (float)(std::imag(mod_out)) - std::imag(expected) ) > tolerance)
			)
		{
			errors++;
			std::cout << "\nbb_in = " << bb_in << ", ph_in = " << ph_in << ", mod_out = " << mod_out << ", expected = " << expected << "\n\n";
		}
		//std::cout << "real(mod_out) = " << (float)(std::real(mod_out)) << ", real(expected) = " << std::real(expected) << "\n";
		//std::cout << "\nbb_in = " << bb_in << ", ph_in = " << ph_in << ", mod_out = " << mod_out << ", expected = " << expected << "\n\n";
		ph_angle += +0.01;
		bb_angle += -0.03;
	}

	std::cout << "\niterations = " << iters << ", number of errors found = " << errors << "\n\n";

	return(errors);
}
