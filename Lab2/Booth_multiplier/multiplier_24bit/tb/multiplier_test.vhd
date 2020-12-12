library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_test is
	port 	( 
			A		: in std_logic_vector (23 downto 0 );
			B 		: in std_logic_vector (23 downto 0 );
			P    	: out std_logic_vector (47 downto 0)
			);
end entity multiplier_test;

architecture behaviour of multiplier_test is
	
	begin
	
		P		<= std_logic_vector(unsigned(A)*unsigned(B));
		
end architecture behaviour;
				 
				 
				 
