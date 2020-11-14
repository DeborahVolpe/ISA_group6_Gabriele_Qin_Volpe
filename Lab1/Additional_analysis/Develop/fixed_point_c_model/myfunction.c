#include "myfunction.h"
#include <stdio.h>

#define N 1 /// order of the filter 
#define NB 11  /// number of bits

int myfilter(int x){
	
	const long b0 = 430; /// coefficient b0
	const long b1 = 430; /// coefficient b1
	const long a1 = -163; /// coefficient a1
	const long c0 = b1 - ((a1*b0) >> (NB -1)); /// new coefficient c0
	const long c1 = (a1*b1) >> (NB -1); /// new coefficient c1
	const long c2 = (a1*a1) >> (NB -1); /// new coefficient c2
	static long sx[2] = {0, 0};
	static long sx_b0[3] = {0, 0, 0};
	static long sx_c0[2] = {0, 0};
	static long sx_c1[2] = {0, 0};
	static long sx_c0_c1[2] = {0, 0};
	static long w[2] = {0, 0};
	static long sy = 0;
	static long sy_c2[2] = {0, 0};
	long y; /// output sample

	sx_b0[0] = (b0*x) >> (NB-1);
	sx_c0[0] = (c0*sx[0]) >> (NB-1);
	sx_c1[0] = (c1*sx[1]) >> (NB-1);
	
	sx_c0_c1[0] = sx_c0[1] - sx_c1[1];
	w[0] = sx_b0[2] + sx_c0_c1[1];
	
	sy_c2[0] = (sy*c2) >> (NB-1);
	
	y = sy_c2[1] + w[1];
	
	//shift_operation
	sy = y;
	sx[1] = sx[0];
	sx[0] = x;
	sx_b0[2] = sx_b0[1];
	sx_b0[1] = sx_b0[0];
	sx_c0[1] = sx_c0[0];
	sx_c1[1] = sx_c1[0];
	sx_c0_c1[1] = sx_c0_c1[0];
	w[1] = w[0];
	sy_c2[1] = sy_c2[0];
	
	return y;
}
