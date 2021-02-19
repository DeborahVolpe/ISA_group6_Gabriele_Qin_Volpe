library ieee;
use ieee.std_logic_1164.all;

entity PCsrc is
	port(
		zero		: in std_logic;
		cond		: in std_logic;
		uncond		: in std_logic;
		PCsrc_out	: out std_logic
		);
end entity PCsrc;

architecture structure of PCsrc is

	signal branch_yes			: std_logic;
	
	begin
	
		branch_yes	<= zero and cond;
		PCsrc_out	<= branch_yes or uncond;
		
end architecture structure;
		
		
		