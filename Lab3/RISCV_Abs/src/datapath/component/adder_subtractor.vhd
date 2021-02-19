library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_subtractor is
	generic ( N : positive := 8);
	port(
		a			: in std_logic_vector (N-1 downto 0);
		b 			: in std_logic_vector (N-1 downto 0);
		sub_add_n	: in std_logic;
		sum_diff 	: out std_logic_vector (N-1 downto 0)
		);
end entity adder_subtractor;

architecture behaviour of adder_subtractor is

	begin
	
		p: process(a,b, sub_add_n)
			begin
				if sub_add_n = '1' then
					sum_diff <= std_logic_vector(signed(a) - signed(b));
				else
					sum_diff <= std_logic_vector(signed(a) + signed(b));
				end if;
		end process;
		
end architecture behaviour;
