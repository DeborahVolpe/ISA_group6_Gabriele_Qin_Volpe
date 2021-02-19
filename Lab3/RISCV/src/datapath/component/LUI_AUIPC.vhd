library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LUI_AUIPC is
	port(
		immediate		: in std_logic_vector(19 downto 0);
		LUI_AUIPC_n		: in std_logic;
		PC				: in std_logic_vector(31 downto 0);
		LUI_AUIPC_out	: out std_logic_vector (31 downto 0)
		);
end entity LUI_AUIPC;

architecture behaviour of LUI_AUIPC is

	component bN_2to1mux 
		generic (N : positive := 8);
		port	( 
				x		: in std_logic_vector (N-1 downto 0); --0
				y		: in std_logic_vector (N-1 downto 0); --1
				s		: in std_logic;
				output	: out std_logic_vector(N-1 downto 0)
			  );
	end component bN_2to1mux;
	
	signal LUI		: std_logic_vector(31 downto 0);
	signal AUIPC	: std_logic_vector(31 downto 0);
	
	begin
	
	AUIPC	<= std_logic_vector(unsigned(LUI) + unsigned(PC)); 
	LUI	<= immediate & "000000000000";
	
	mux : bN_2to1mux
				generic map	(
							N		=> 32
							)
				port map	( 
							x		=> AUIPC,
							y		=> LUI,
							s		=> LUI_AUIPC_n,
							output	=> LUI_AUIPC_out
							);
	
end architecture behaviour;
