#include "myfunction.h"
#include <stdio.h>
#include <stdlib.h>

#define N 1 /// order of the filter 
#define NB 11  /// number of bits

int myfilter(int x){
	
	const int b0 = 430; /// coefficient b0
	const int b1 = 430; /// coefficient b1
	const int a1 = -163; /// coefficient a1
	const int c0 = b1 - ((a1*b0) >> (NB -1)); /// new coefficient c0
	const int c1 = (a1*b1) >> (NB -1); /// new coefficient c1
	const int c2 = (a1*a1) >> (NB -1); /// new coefficient c2
	static int sx[2] = {0, 0};
	static int sx_b0[3] = {0, 0, 0};
	static int sx_c0[2] = {0, 0};
	static int sx_c1[2] = {0, 0};
	static int sx_c0_c1[2] = {0, 0};
	static int w[2] = {0, 0};
	static int sy = 0;
	static int sy_c2[2] = {0, 0};
	int y; /// output sample
	static int first_run = 0; 
	static FILE* fp_sx_b0 = NULL;
	static FILE* fp_sx_c0 = NULL;
	static FILE* fp_sx_c1 = NULL;
	static FILE* fp_sx_c0_c1 = NULL;
	static FILE* fp_w = NULL;
	static FILE* fp_sy_c2 = NULL;
	

	if (first_run == 0){
	  fprintf(stdout, "c0: %d\n", c0);
	  fprintf(stdout, "c1: %d\n", c1);
	  fprintf(stdout, "c2: %d\n", c2);
	  fp_sx_b0 = fopen("sx_b0_values.txt", "w");
	  fp_sx_c0 = fopen("sx_c0_values.txt", "w");
	  fp_sx_c1 = fopen("sx_c1_values.txt", "w");
	  fp_sx_c0_c1 = fopen("sx_c0_c1_values.txt", "w");
	  fp_w = fopen("w_values.txt", "w");
	  fp_sy_c2 = fopen("sy_c2_values.txt", "w");
	  first_run = 1;
	}

	sx_b0[0] = b0*x >> (NB-1);
	fprintf(fp_sx_b0, "%d\n", sx_b0[0]);
	sx_c0[0] = c0*sx[0] >> (NB-1);
	fprintf(fp_sx_c0, "%d\n", sx_c0[0]);
	sx_c1[0] = c1*sx[1] >> (NB-1);
	fprintf(fp_sx_c1, "%d\n", sx_c1[0]);
	sx_c0_c1[0] = sx_c0[1] - sx_c1[1];
	fprintf(fp_sx_c0_c1, "%d\n", sx_c0_c1[0]);
	w[0] = sx_b0[2] + sx_c0_c1[1];
	fprintf(fp_w, "%d\n", w[0]);
	
	sy_c2[0] = sy*c2 >> (NB-1);
	fprintf(fp_sy_c2, "%d\n", sy_c2[0]);
	
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
