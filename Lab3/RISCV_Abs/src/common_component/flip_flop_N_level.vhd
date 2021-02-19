library ieee;
use ieee.std_logic_1164.all;

-- N level of flip flop to store std_logic

entity flip_flop_N_level is
	generic	(
			N 		: positive := 32
			);
	port	(
			D   	: in std_logic;
			clk 	: in std_logic;
			en		: in std_logic;
			RST_n	: in std_logic;
			Q  		: out std_logic_vector(N-1 downto 0)
			);
end entity flip_flop_N_level;

architecture structure of flip_flop_N_level  is

	component flipflop 
		port	(
				D   	: in std_logic;
				RST_n	: in std_logic;
				en		: in std_logic;
				clk 	: in std_logic;
				Q   	: out std_logic
				);
	end component flipflop;
	
	signal Q_in		: std_logic_vector(N-1 downto 0);

	begin
	
		FD_0 :	flipflop port map	(
									D   	=> D, 
									clk 	=> clk,
									RST_n => RST_n,
									en		=> en,
									Q   	=> Q_in(0)
									);
									
		G : for i in 1 to N-1 generate
			FD : 	flipflop port map	(
										D   	=> Q_in(i-1), 
										clk 	=> clk,
										RST_n => RST_n,
										en		=> en,
										Q   	=> Q_in(i)
										);
		end generate;
		
		Q	<= Q_in;
	
end architecture structure;
	
		
