In this folder are present all the VHDL files necessary for the filter implementation:

- significant_multiplier.vhd that is the top entity. It has as input A and B(Data input). It gives
  in output P, product (A*B). This component generates partial products instantiating the correct number of partial 
  product generation, then instantiate full adder and half adder to obtain dadda tree and sum obtained output using 
  a behavioural adder;
  
- full_adder.vhd that sum the three bit a, b and c_in. It returns bit s and c_out;

- half_adder.vhd that sum the two bit a and b. It returns bit s and c_out ;

- CSA.vhd implements a carry save adder, instantiating N full adder. This component is generic;
  
- adder.vhd that implement a two input adder implemented in behavioural way. This is a generic component;
  
- partial_product_generator.vhd that implement booth encoding;

- bN_2to1mux.vhd that implements a 2to1 multiplexer, generic for number of bit;

- bN_3to1mux.vhd that implements a 3to1 multiplexer, generic for number of bit. This is used in partial product generator
  to correctly select partial products.