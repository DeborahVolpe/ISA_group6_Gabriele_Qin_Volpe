library ieee;
use ieee.std_logic_1164.all;

entity Branch is
	port(
		opcode6		: in std_logic;
		opcode5		: in std_logic;
		opcode3		: in std_logic;
		cond		: out std_logic;
		uncond		: out std_logic
		);
end entity Branch;

architecture structure of Branch is

	signal branch_op 			: std_logic;
	
	begin
	
		branch_op 	<= opcode6 and opcode5;
		cond 		<= branch_op and not(opcode3);
		uncond		<= branch_op and opcode3;
		
end architecture structure;