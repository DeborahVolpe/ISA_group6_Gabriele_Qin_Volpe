#include "myfunction.h"
#include <stdio.h>

#define N 1 /// order of the filter 
#define NB 11  /// number of bits

int myfilter(int x){
	
	const int b0 = 430; /// coefficient b0
	const int b1 = 430; /// coefficient b1
	const int a1 = -163; /// coefficient a1
	const int c0 = b1 - ((a1*b0) >> (NB -1)); /// new coefficient c0
	const int c1 = (a1*b1) >> (NB -1); /// new coefficient c1
	const int c2 = (a1*a1) >> (NB -1); /// new coefficient c2
	static int w[4] = {0, 0, 0, 0};
	static int w_c2[2] = {0,0};
	static int w_b0[3] = {0,0,0};
	static int w_c0[2] = {0,0};
	static int w_c1[2] = {0,0};
	static int w_c1_c0[2] = {0,0};
	int y; /// output sample

	//filter implementation
	w[0] = x + w_c2[1];
	w_c2[0] = (c2*w[1]) >> (NB-1);
	w_b0[0] = (b0*w[1]) >> (NB-1);
	w_c0[0] = (c0*w[2]) >> (NB-1);
	w_c1[0] = (c1*w[3]) >> (NB-1);

	w_c1_c0[0] = w_c0[1] - w_c1[1];
	
	y = w_c1_c0[1] + w_b0[2]; 
	
	
	//shift_operation
	w[3] = w[2];
	w[2] = w[1];
	w[1] = w[0];
	w_c2[1] = w_c2[0];
	w_b0[2] = w_b0[1];
	w_b0[1] = w_b0[0];
	w_c0[1] = w_c0[0];
	w_c1[1] = w_c1[0];
	w_c1_c0[1] = w_c1_c0[0];
	
	return y;
}