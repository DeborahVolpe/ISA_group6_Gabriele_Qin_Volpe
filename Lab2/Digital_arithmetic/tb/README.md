This folder contains VHDL and Verilog files necessary for the testbench:

- tb_floating_multiplier.v is a Verilog file and represents the top entity of the testbench. This Instantiates
  the floating point multiplier, the clock_gen, the data_marker and the data_sink components;
  
- clk_gen.vhd that generates the clock signal according to the imposed period;
  
- data_marker.vhd reads data from fp_samples.txt file;

- data_sink.txt writes the outputs data in results.txt file;

- difference.sh, bash script, that verify the correctness of the output of simulation comparing fp_prod.hex and results.hex;

- fp_samples.hex input file of the testbench;

- fp_prod.hex provided file of the expected outputs;

- results.hex ouput file of the testbench.


to verify that the two files are equal use on the shell:
./difference.sh fp_prod.hex results.hex

if is necessary, before give the permission using:
chmod u+x difference.sh
