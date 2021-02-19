library ieee;
use ieee.std_logic_1164.all;

entity Data_mem_signal is
	port(
		opcode6		: in std_logic;
		opcode5		: in std_logic;
		opcode4		: in std_logic;
		opcode2		: in std_logic;
		write_data	: out std_logic;
		read_data	: out std_logic
		);
end entity Data_mem_signal;

architecture structure of Data_mem_signal is

	signal mem_op	: std_logic;

	begin
	
		mem_op		<= (opcode2 nor opcode4) and not(opcode6);
		
		write_data 	<= opcode5 and mem_op;
		
		read_data	<= not(opcode5) and mem_op;
	
	
end architecture structure;
