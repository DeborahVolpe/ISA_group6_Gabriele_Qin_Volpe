library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- register to store std_logic_vector

entity reg_start_value is
	generic (N : positive := 5); 
	port(
		D       	: in std_logic_vector (N-1 downto 0);
		start_value	: in std_logic_vector (N-1 downto 0);
		RST_n		: in std_logic;
		en			: in std_logic;
		clk     	: in std_logic;
		Q       	: out std_logic_vector (N-1 downto 0)
		);
end entity reg_start_value;

architecture behaviour of reg_start_value is
	begin

		reg_process:    process(clk)
						begin
							if RST_n = '0' then
								Q <= start_value;
							elsif rising_edge(clk) then
									if en = '1' then
										Q <= D;
									end if;
							end if;
						end process;
					
end architecture behaviour;
