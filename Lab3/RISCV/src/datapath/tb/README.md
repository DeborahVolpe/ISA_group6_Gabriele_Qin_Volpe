This folder contain VHDL and Verilog files necessary for the testbench:

- tb_datapath.v is a Verilog file and represents the top entity of the testbench. This Instantiates
  the datapath, the clock_gen, the data_marker and the data_sink components;
  
- clk_gen.vhd that generates the clock signal according to the imposed period;
  
- data_marker.vhd reads data from input file;

- data_sink.txt writes the outputs data in results.txt file.