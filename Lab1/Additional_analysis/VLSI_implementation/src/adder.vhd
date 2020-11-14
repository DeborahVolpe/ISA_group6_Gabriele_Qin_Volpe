library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	generic ( N : positive := 8);
	port(
		a			: in signed (N-1 downto 0); --input
		b 			: in signed (N-1 downto 0);--input
		sum 		: out signed (N-1 downto 0) --output a+b
		);
end entity adder;

architecture behaviour of adder is
	
	begin
		
		sum		<= a + b ;
		
end architecture behaviour;
