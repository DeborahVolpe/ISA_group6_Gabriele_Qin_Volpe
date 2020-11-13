library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- register to store std_logic_vector

entity reg is
	generic (N : positive := 5); 
	port(
		D       : in signed (N-1 downto 0);
		RST_n	: in std_logic;
		en		: in std_logic;
		clk     : in std_logic;
		Q       : out signed (N-1 downto 0)
		);
end entity reg;

architecture behaviour of reg is
	begin

		reg_process:    process(clk)
						begin
							if RST_n = '0' then
								Q <= (others => '0');
							elsif rising_edge(clk) then
									if en = '1' then
										Q <= D;
									end if;
							end if;
						end process;
					
end architecture behaviour;