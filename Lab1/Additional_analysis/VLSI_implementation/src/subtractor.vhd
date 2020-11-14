library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtractor is
	generic ( N : positive := 8);
	port(
		a			: in signed (N-1 downto 0); --input
		b 			: in signed (N-1 downto 0); --input
		subtraction	: out signed(N-1 downto 0)--output a-b
		);
end entity subtractor;

architecture behaviour of subtractor is
	
	begin
	
	subtraction		<= a - b;
		
end architecture behaviour;