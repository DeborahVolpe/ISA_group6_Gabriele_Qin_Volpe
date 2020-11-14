This folder contain VHDL and Verilog files necessary for the testbench:

- tb_filer.v is a Verilog file and represent the top entity of the testbench. This Instantiate
  the Filter, the clock_gen, the data_marker and the data_sink components;
  
- clk_gen.vhd that generate the clock signal according to the imposed period. This clock signal 
  is filterd by the END_SIM, in this way the clock signal is obtained only if the signal END_SIM
  is equal to zero and so there are data to process available yet;
  
- data_marker_new.vhd sets coefficients value and reads data from samples.txt file;

- data_sink.txt writes the outputs data in results.txt file.