library ieee;
use ieee.std_logic_1164.all;

entity Forward_unit is
	port(
		c1			: in std_logic;
		c2			: in std_logic;
		c3			: in std_logic;
		c4			: in std_logic;
		imm			: in std_logic;
		ForwA		: out std_logic_vector(1 downto 0);
		ForwB		: out std_logic_vector(1 downto 0)
		);
end entity Forward_unit;

architecture structure of Forward_unit is

	begin
		
		ForwB(1)	<= not(imm) and (c3 or c4);
		ForwB(0)	<= imm or (not(c3) and c4);
		
		ForwA(0)	<= c2;
		ForwA(1)	<= c1;
		
end architecture structure;
