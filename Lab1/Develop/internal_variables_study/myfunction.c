#include "myfunction.h"
#include <stdio.h>
#include <stdlib.h>

#define N 1 /// order of the filter 
#define NB 11  /// number of bits

int myfilter(int x){
	
	const int b0 = 430; /// coefficient b0
	const int b1 = 430; /// coefficient b1
	const int a1 = -163; /// coefficient a1
	static int sw; /// w shift register
	static int first_run = 0; /// for cleaning the shift register
	int w; /// intermediate value (w)
	int y; /// output sample
	int fb, ff; /// feed-back and feed-forward results
	static FILE* fp_w = NULL;
	static FILE* fp_fb = NULL;
	static FILE* fp_ff	= NULL;
	static FILE* fp_y = NULL;

	/// open files and clean sw
	if (first_run == 0)
	{
		first_run = 1;
		sw = 0;
		
		fp_w = fopen ("w_values.txt", "w");
		fp_fb = fopen ("fb_values.txt", "w");
		fp_ff = fopen ("ff_values.txt", "w");
		fp_y  = fopen ("y_values.txt", "w");
		
	}

	/// compute feed-back and feed-forward
	fb = 0;
	ff = 0;
	fb -= (sw*a1) >> (NB-1);
	
	/// write in the file
	fprintf( fp_fb , "%d\n",  fb); 
	
	ff += (sw*b1) >> (NB-1);
	
	/// write in the file
	fprintf( fp_ff , "%d\n",  ff); 

	/// compute intermediate value (w) and output sample
	w = x + fb;
	
	/// write in the file
	fprintf( fp_w , "%d\n",  w);
	
	y = (w*b0) >> (NB-1);
	
	/// write in the file
	fprintf( fp_y , "%d\n",  y);
	
	y += ff;

	/// update the shift register
	sw = w;
	 
	return y;
}
