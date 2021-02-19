This folder contain VHDL and Verilog files necessary for the testbench:

- tb_RISC.v is a Verilog file and represents the top entity of the testbench. This Instantiates
  the RISCV, the clock_gen and the data_marker;
  
- tb_RISC_file.v is a Verilog file and represents the top entity of the testbench. This Instantiates
  the RISCV, the clock_gen, the data_marker and data_sink. This testbench is able to write outputs on a file;
  
- clk_gen.vhd that generates the clock signal according to the imposed period;
  
- Instruction_memory.vhd that implements instruction memory;

- Data_memory.vhd that implements data memory;

- data_sink.vhd writes the outputs data in results.txt file.