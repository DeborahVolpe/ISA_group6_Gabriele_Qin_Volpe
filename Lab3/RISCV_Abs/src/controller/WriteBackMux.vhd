library ieee;
use ieee.std_logic_1164.all;

entity WriteBackMux is
	port(
		opcode4		: in std_logic;
		uncond		: in std_logic;
		selMux		: out std_logic_vector(1 downto 0)
		);
end entity WriteBackMux;

architecture Structure of WriteBackMux is

	begin
		
		selMux(0)		<= opcode4;
		selMux(1)		<= uncond;

end architecture Structure;