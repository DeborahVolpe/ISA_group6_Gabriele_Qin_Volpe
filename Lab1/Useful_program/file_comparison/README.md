This folder contain:

- main.c;

- Makefile, necessary to compile the program;

- resultsm.txt that is the filter output provided by MATLAB;

- output.txt that is the filter output obtained with fixed point c model;

- results.txt that is the filter output of VHDL implementation;

- results_backann.txt that is the filter output obtained with the Verilog Netlist, doing the 
  backannotation procedure.
  

To compile this c program:
> make Clean #to cancel eventual previous version
> make # to compile using makefile

To execute
>./MyProgram file1.txt file2.txt

This program is able to compare two file with the same lenght and find the maximum difference.

It is also possible compare the two file using the bash command:
	diff file1.txt file2.txt
In this case, the output enumerate the line different in the two file. In case of empty output, the 
two file are perfectly equal