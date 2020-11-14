library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_n is
	generic ( N : positive:=4);
	port 	( 
			A		: in signed (N-1 downto 0 ); --input
			B 		: in signed (N-1 downto 0 ); --input
			P    	: out signed (2*N-1 downto 0) --output A*B
			);
end entity multiplier_n;

architecture behaviour of multiplier_n is
	
	begin
	
		P		<= A*B;
		
end architecture behaviour;
				 
				 
				 