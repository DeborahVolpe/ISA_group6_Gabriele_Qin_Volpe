library ieee;
use ieee.std_logic_1164.all;

entity RF_gen is
	port(	
		opcode2		: in std_logic;
		opcode3		: in std_logic;
		opcode4		: in std_logic;
		opcode5		: in std_logic;
		opcode6		: in std_logic;
		write_RF	: out std_logic
		);
end entity RF_gen;

architecture structure of RF_gen is

	signal store	: std_logic;
	
	begin
	
		write_RF	<= (not( opcode6 or (opcode5 and not(opcode4) and not(opcode3) and not(opcode2))) or (opcode6 and opcode5 and opcode3));
		
end architecture structure;
		
