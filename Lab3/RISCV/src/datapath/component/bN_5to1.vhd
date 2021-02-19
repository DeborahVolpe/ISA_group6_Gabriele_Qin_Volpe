library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- multiplex 2 to 1 for std_logic_vector
-- generic for the number of bit 

entity bN_5to1mux is
	generic (N : positive := 8);
	port	( 
			X000	: in std_logic_vector(N-1 downto 0);
			X001	: in std_logic_vector(N-1 downto 0);
			X010	: in std_logic_vector(N-1 downto 0);
			X011	: in std_logic_vector(N-1 downto 0);
			X100	: in std_logic_vector(N-1 downto 0);
			Sel		: in std_logic_vector(2 downto 0);
			output	: out std_logic_vector(N-1 downto 0)
			);
end entity bN_5to1mux;

architecture structure of bN_5to1mux is

	component bN_2to1mux 
		generic (N : positive := 8);
		port	( 
				x		: in std_logic_vector (N-1 downto 0); --0
				y		: in std_logic_vector (N-1 downto 0); --1
				s		: in std_logic;
				output	: out std_logic_vector(N-1 downto 0)
			  );
	end component bN_2to1mux;
	
	signal U0			: std_logic_vector(N-1 downto 0);
	signal U1			: std_logic_vector(N-1 downto 0);
	signal U2			: std_logic_vector(N-1 downto 0);

	begin
	
		mux0 : bN_2to1mux 
					generic map	(
								N		=> N
								)
					port map	( 
								x		=> X000,
								y		=> X001,
								s		=> Sel(0),
								output	=> U0
								);
								
		mux1 : bN_2to1mux 
					generic map	(
								N		=> N
								)
					port map	( 
								x		=> X010,
								y		=> X011,
								s		=> Sel(0),
								output	=> U1
								);
								
		mux2 : bN_2to1mux 
					generic map	(
								N		=> N
								)
					port map	( 
								x		=> U0,
								y		=> U1,
								s		=> Sel(1),
								output	=> U2
								);
								
		mux3 : bN_2to1mux 
					generic map	(
								N		=> N
								)
					port map	( 
								x		=> U2,
								y		=> X100,
								s		=> Sel(2),
								output	=> output
								);
	
end architecture structure;