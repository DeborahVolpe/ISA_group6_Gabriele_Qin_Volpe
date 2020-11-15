In this folder are present all the VHDL files necessary for the filter implementation:

- Filter.vhd that is the top entity. It has as input DIN (Data input), VIN (Valid input), 
  RST_n (Reset low active), CLK (clock signal) and the coefficient a0, a1 and b0. It gives
  in output DOUT (Data output) and VOUT (Valid output);
  
- adder.vhd that sum the two input a and b, using + operator. This is a generic component for
  the number of input-output bits;
  
- subtractor.vhd that subtract the two input a and b, using - operator. This is a generic component for
  the number of input-output bits;

- multiplier.vhd that multiply the two input A and B, using * operator. This is a generic component for
  the number of input bits.The output is express in 2N bits, where N is the number of the input bits;
  
- reg.vhd that implements a register with enable and reset signal. This is a generic component for
  the number of input-output bits;
  
- flipflop.vhd that implements a single flip flop with enable and reset signal;

- flip_flop_N_level.vhd that implements a cascade of N flip flop. This component is useful to delay 
  the VIN signal in order to obtain the VOUT.