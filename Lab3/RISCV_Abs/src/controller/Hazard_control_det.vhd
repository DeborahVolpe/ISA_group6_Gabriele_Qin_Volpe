library ieee;
use ieee.std_logic_1164.all;

entity Hazard_control_det is
	port(
		opcode6			: in std_logic; --for jump
		opcode5			: in std_logic; --for jump
		opcode3			: in std_logic; --for jump
		uncond_1D		: in std_logic;
		uncond_2D		: in std_logic;
		cond_2D			: in std_logic;
		zero			: in std_logic;
		sel_WB_M		: out std_logic;
		enable_PC_NOP	: out std_logic
		);
end entity Hazard_control_det;

architecture structure of Hazard_control_det is

	signal NOP, NOP_1D, NOP_2D	: std_logic;

	begin 
	
		sel_WB_M		<= cond_2D and zero;
		NOP 			<= opcode6 and opcode5 and opcode3;
		NOP_1D 			<= uncond_1D;
		NOP_2D 			<= uncond_2D;
		enable_PC_NOP	<= not(NOP or NOP_1D or NOP_2D);
		
end architecture structure;