library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- register to store std_logic_vector

entity reg is
	generic (N : positive := 5); 
	port(
		D       : in signed (N-1 downto 0); --input
		RST_n	: in std_logic; --reset low active
		en		: in std_logic; --enable
		clk     : in std_logic; --clock signal
		Q       : out signed (N-1 downto 0) --output
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
