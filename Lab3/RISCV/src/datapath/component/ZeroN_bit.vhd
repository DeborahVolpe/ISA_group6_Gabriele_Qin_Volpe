library ieee;
use ieee.std_logic_1164.all;

entity ZeroN_bit is
    generic ( 
			N : positive := 32 -- bit of the input
			);
    port  (
			diff		: in std_logic_vector(N-1 downto 0);
			Zero		: out std_logic
		  );
end entity ZeroN_bit;

architecture structure of ZeroN_bit is

	signal equal 		: std_logic_vector(N-1 downto 0);
	signal ands			: std_logic_vector(N-1 downto 0);

	begin
		
		G : for i in 0 to N-1 generate
			equal(i) <= not(diff(i));
		end generate;
		
		ands(0)		<= equal(0);
		
		G2 : for i in 1 to N-1 generate
			ands(i)	<= ands(i-1) and equal(i);
		end generate;
		
		Zero		<= ands(N-1);
			
		
end architecture structure;
