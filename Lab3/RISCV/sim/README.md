This folder contains:

- results folder that contains outputs file obtained simulation VHDL files, Verilog Netlist provided by Synopsys Design Vision and Verilog Netlist provided by Cadence Innovus;

- compile.do, script necessary to simulate VHDL implementation;

- compile_common_component.do that compile component in common_componet folder. This script is called by compile.do;

- compile_controller.do that compile component in controller folder. This script is called by compile.do;

- compile_datapath.do that compile component in datapath folder. This script is called by compile.do;

- compile_netlist.do script necessary to simulate Verilog Netlist provided by Synopsys Design Vision and create vcd file for power consumption evaluation;

- compile_netlistFile.do script necessary to simulate Verilog Netlist provided by Synopsys Design Vision using tb_RISC_file.v that is able to write outputs in a file;

- compile_registerFile.do that compile component in register_file folder. This script is called by compile.do;

- compile.do, script necessary to simulate VHDL implementation using tb_RISC_file.v that is able to write outputs in a file;

- script_sim_netlist_innovus.do, script necessary to simulate Verilog Netlist pr by Cadence Innovus.