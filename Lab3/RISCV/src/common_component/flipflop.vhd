library ieee;
use ieee.std_logic_1164.all;

-- flip flop to store std_logic

entity flipflop is
	port(
		D   	: in std_logic;
		RST_n	: in std_logic;
		en  	: in std_logic;
		clk 	: in std_logic;
		Q   	: out std_logic
		);
end entity flipflop;

architecture behaviour of flipflop is

	begin

		reg_process:    process(clk)
						begin
							if RST_n = '0' then
								  Q <= '0';
							elsif rising_edge(clk) then
								   if en = '1' then
										Q <= D;
									end if;
							end if;
						end process;
						
end architecture behaviour;