library ieee;
use ieee.std_logic_1164.all;

entity XorN_bit is
    generic ( 
			N : positive := 32 -- bit of the input
			);
    port  (
			A 			: in std_logic_vector(N-1 downto 0);
			B			: in std_logic_vector(N-1 downto 0);
			Output		: out std_logic_vector(N-1 downto 0)
		  );
end entity XorN_bit;

architecture structure of XorN_bit is

	begin
		
		G : for i in 0 to N-1 generate
			Output(i) <= A(i) xor B(i);
		end generate;
		
end architecture structure;