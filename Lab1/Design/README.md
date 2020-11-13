In this folder are present:

- my_iir_design.m is a MATLAB script containing a function able to design an IIR filter
  and so to give coefficients of our filter. In this script it is necessary properly set 
  wanted cut-off frequency and sample frequency. Filter order and number of bit are input
  arguments of the function;
  
- my_iir_filter.m is a MATLAB script that, properly set filter order and number of bit
  call the function my_iir_design, present in the other script. Then verify filter 
  behaviour with a test signal;
  
- resultsm.txt contains filter output with samples.txt as input. Both are produced by 
  my_iir_filter.m;
  
- samples.txt;