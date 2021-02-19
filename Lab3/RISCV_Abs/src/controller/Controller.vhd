library ieee;
use ieee.std_logic_1164.all;

entity Controller is
	port(
		opcode			: in std_logic_vector(6 downto 0);
		func3			: in std_logic_vector(2 downto 0);
		zero			: in std_logic;
		cond_2D			: in std_logic;
		uncond_2D		: in std_logic;
		cond			: out std_logic;
		uncond			: out std_logic;
		write_data		: out std_logic;
		read_data		: out std_logic;
		Write_RF		: out std_logic;
		PCsrc_out		: out std_logic;
		Sel_ALU			: out std_logic_vector(2 downto 0);
		selMuxEnd		: out std_logic_vector(1 downto 0);
		sub_add_n		: out std_logic
		);
end entity Controller;

architecture Structure of Controller is 

	component PCsrc 
		port(
			zero		: in std_logic;
			cond		: in std_logic;
			uncond		: in std_logic;
			PCsrc_out	: out std_logic
			);
	end component PCsrc;
	
	component  RF_gen
		port(	
			opcode2		: in std_logic;
			opcode3		: in std_logic;
			opcode4		: in std_logic;
			opcode5		: in std_logic;
			opcode6		: in std_logic;
			write_RF	: out std_logic
			);
	end component RF_gen;
	
	component Data_mem_signal 
		port(
			opcode6		: in std_logic;
			opcode5		: in std_logic;
			opcode4		: in std_logic;
			opcode2		: in std_logic;
			write_data	: out std_logic;
			read_data	: out std_logic
			);
	end component Data_mem_signal;
	
	component Selector_generator 
		port(
			func3		: in std_logic_vector(2 downto 0);
			opcode		: in std_logic_vector(6 downto 0);
			Sel			: out std_logic_vector(2 downto 0);
			sub_add_n	: out std_logic
			);
	end component Selector_generator;
	
	component WriteBackMux -- selMuxEnd
		port(
			opcode4		: in std_logic;
			uncond		: in std_logic;
			selMux		: out std_logic_vector(1 downto 0)
			);
	end component WriteBackMux;
	
	component Branch
		port(
			opcode6		: in std_logic;
			opcode5		: in std_logic;
			opcode3		: in std_logic;
			cond		: out std_logic;
			uncond		: out std_logic
			);
	end component Branch;
	
	signal uncond_in		: std_logic;
	
	begin 
	
		PCsrc_comp : PCsrc 
						port map(
								zero		=>	zero,
								cond		=> 	cond_2D,
								uncond		=> 	uncond_2D,
								PCsrc_out	=> 	PCsrc_out
								);
								
		BR	:  Branch
						port map (
								opcode6		=> opcode(6),
								opcode5		=> opcode(5),
								opcode3		=> opcode(3),
								cond		=> cond,
								uncond		=> uncond_in
								);

		uncond		<= uncond_in;							

		RFComp	: RF_gen
						port map(	
								opcode2		=> opcode(2),
								opcode3		=> opcode(3),
								opcode4		=> opcode(4),
								opcode5		=> opcode(5),
								opcode6		=> opcode(6),
								write_RF	=> write_RF
								);
								
		DMComp	: Data_mem_signal 
						port map(
								opcode6		=> opcode(6),
								opcode5		=> opcode(5),
								opcode4		=> opcode(4),
								opcode2		=> opcode(2),
								write_data	=> write_data,
								read_data	=> read_data
								);
								
		SEL_COMP : Selector_generator 
						port map (
								func3		=> func3,
								opcode		=> opcode,
								Sel			=> Sel_ALU,
								sub_add_n	=> sub_add_n
								);
								
		WBMux : WriteBackMux -- selMuxEnd
						port map(
								opcode4		=> opcode(4),
								uncond		=> uncond_in,
								selMux		=> selMuxEnd
								);
								
end architecture Structure;
		
		
