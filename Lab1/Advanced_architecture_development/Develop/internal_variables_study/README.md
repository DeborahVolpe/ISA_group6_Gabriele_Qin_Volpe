This folder contain:

- main.c;

- myfunction.c and myfunction.h containing filter function. This is a modified version that write
  internal variables values in different files;

- Makefile, necessary to compile the program;

- samples.txt, that is the input file;

- Variables_studies.m is a MATLAB script that read internal variables value and plot them in order
  to evaluate number of required bit for the internal representation.


To compile this c program:
> make Clean #to cancel eventual previous version
> make # to compile using makefile

To execute
>./MyFilter samples.txt output.txt