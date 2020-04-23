#include <iostream>
#include "ap_int.h"
#include "ap_fixed.h"
int main () {
	std::cout << "hello!\n";

    ap_fixed<16, 8, AP_RND, AP_WRAP, 0> a, b, c;

    a = 12.33333;
    b = -57.75;

    c = a + b;

    std::cout << "a=" << a << ", b=" << b << ", c=" << c << "\n";

}


