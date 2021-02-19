In this folder are present all the VHDL files necessary for the RISCV implementation:

- RISCV.vhd that is the top entity. It has as input RST_n (Reset low active), CLK (clock signal), Data_out(data that comes from 
  memory), instruction (fetched from instruction memory) and StartAddress (start address for PC). It has as output AddressData 
 (address for instruction memory), write_data (control signal for memory), read_data (control signal for memory), Data_in(input data
  for instruction memory) and PC_out(that is the program counter, address for instruction memory);
  
- common_component folder that contains VHDL files of compoment useful in more unit;

- controller folder that constains VHDL files necessary to implement controller, hazard and forward unit;

- datapath that constains VHDL files necessary to implement datapath;

- register_file constains VHDL files necessary to implement the register file.