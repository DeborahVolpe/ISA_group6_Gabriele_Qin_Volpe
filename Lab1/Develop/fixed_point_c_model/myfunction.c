#include "myfunction.h"
#include <stdio.h>

#define N 1 /// order of the filter 
#define NB 11  /// number of bits

int myfilter(int x){
	
	const int b0 = 430; /// coefficient b0
	const int b1 = 430; /// coefficient b1
	const int a1 = -163; /// coefficient a1
	static int sw; /// w shift register
	static int first_run = 0; /// for cleaning the shift register
	int i; /// index
	int w; /// intermediate value (w)
	int y; /// output sample
	int fb, ff; /// feed-back and feed-forward results

	/// clean the buffer
	if (first_run == 0)
	{
		first_run = 1;
		sw = 0;
	}

	/// compute feed-back and feed-forward
	fb = 0;
	ff = 0;
	fb -= (sw*a1) >> (NB-1);
	ff += (sw*b1) >> (NB-1);

	/// compute intermediate value (w) and output sample
	w = x + fb;
	y = (w*b0) >> (NB-1);
	y += ff;

	/// update the shift register
	sw = w;
	 
	return y;
}
