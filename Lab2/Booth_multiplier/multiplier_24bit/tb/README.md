This folder contains VHDL and Verilog files necessary for the testbench:

- tb_floating_multiplier.v is a Verilog file and represents the top entity of the testbench. This Instantiates
  the floating point multiplier, the clock_gen, the data_marker and the data_sink components;
  
- clk_gen.vhd that generates the clock signal according to the imposed period;
  
- data_marker.vhd reads data from input.txt file;

- genera_file_input.py generates input.txt file using random number;

- multiplier_test.vhd that is a behvioural multiplier that is used to verify output correctness;

- data_sink.txt compares results obtained with MBE multiplier and the behavioura one, generating an error signal;

- fp_samples.hex input file of the testbench;

- fp_prod.hex provided file of the expected outputs;

- results.hex ouput file of the testbench.

