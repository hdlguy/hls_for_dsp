#include <iostream>
#include "phase_mod.hpp"

int main()
{
	bb_cplx_type bb_in, ph_in, mod_out;

	bb_in = bb_cplx_type(+0.707,+0.707);
	ph_in = bb_cplx_type(-0.707,+0.707);

	mod_out = phase_mod(bb_in, ph_in);

	std::cout << "\nbb_in = " << bb_in << ", ph_in = " << ph_in << ", mod_out = " << mod_out << "\n\n";

	if (mod_out == bb_cplx_type(-1.0, 0.0))
		return(0);
	else
		return(1);
}
