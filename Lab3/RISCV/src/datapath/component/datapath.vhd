library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
	port(
		in1					: in std_logic_vector(31 downto 0);
		in2					: in std_logic_vector(31 downto 0);
		PC					: in std_logic_vector(31 downto 0);
		immediate			: in std_logic_vector(19 downto 0);
		sel					: in std_logic_vector(2 downto 0);
		shamt				: in std_logic_vector(4 downto 0);
		sel_LUI_AUIPC		: in std_logic;
		sel_OP_LUI_AUIPC	: in std_logic;
		sub_add_n			: in std_logic;
		zero				: out std_logic;
		outputs				: out std_logic_vector(31 downto 0)	
		);
end entity datapath;

architecture structure of datapath is

	component bN_5to1mux 
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
	end component bN_5to1mux;
	
	component bN_2to1mux 
		generic (N : positive := 8);
		port	( 
				x		: in std_logic_vector (N-1 downto 0); --0
				y		: in std_logic_vector (N-1 downto 0); --1
				s		: in std_logic;
				output	: out std_logic_vector(N-1 downto 0)
			  );
	end component bN_2to1mux;
	
	component LUI_AUIPC 
		port(
			immediate		: in std_logic_vector(19 downto 0);
			PC			: in std_logic_vector( 31 downto 0);
			LUI_AUIPC_n		: in std_logic;
			LUI_AUIPC_out	: out std_logic_vector (31 downto 0)
			);
	end component LUI_AUIPC;
	
	component adder_subtractor
		generic ( N : positive := 8);
		port(
			a			: in std_logic_vector (N-1 downto 0);
			b 			: in std_logic_vector (N-1 downto 0);
			sub_add_n	: in std_logic;
			sum_diff 	: out std_logic_vector (N-1 downto 0)
			);
	end component adder_subtractor;
	
	component ZeroN_bit 
		generic ( 
				N : positive := 32 -- bit of the input
				);
		port  (
				diff		: in std_logic_vector(N-1 downto 0);
				Zero		: out std_logic
			  );
	end component ZeroN_bit;
	
	component XorN_bit 
		generic ( 
				N : positive := 32 -- bit of the input
				);
		port  (
				A 			: in std_logic_vector(N-1 downto 0);
				B			: in std_logic_vector(N-1 downto 0);
				Output		: out std_logic_vector(N-1 downto 0)
			  );
	end component XorN_bit;
	
	component barrel_shifter 
		generic ( 
				N : positive := 8; -- bit of the input
				M : positive := 3  -- bit of the shift --> max value is log2(N) that is, it can shift by up to N positions
				);
		port  (
				R 	: in std_logic_vector (N-1 downto 0);
				S	: in std_logic_vector (M-1 downto 0);
				Q	: out std_logic_vector(N-1 downto 0)
			  );
	end component barrel_shifter;
	
	component AndN_bit
		generic ( 
				N : positive := 32 -- bit of the input
				);
		port  (
				A 			: in std_logic_vector(N-1 downto 0);
				B			: in std_logic_vector(N-1 downto 0);
				Output		: out std_logic_vector(N-1 downto 0)
			  );
	end component AndN_bit;
	
	signal sum_diff			: std_logic_vector(31 downto 0);
	signal slt				: std_logic_vector(31 downto 0);
	signal BS_out			: std_logic_vector(31 downto 0);
	signal AND_out			: std_logic_vector(31 downto 0);
	signal Xor_out			: std_logic_vector(31 downto 0);
	signal operation		: std_logic_vector(31 downto 0);
	signal LUI_AUIPC_out	: std_logic_vector(31 downto 0);
	
	begin
	
		ADDSUB : adder_subtractor
						generic map	(
									N 		=> 32
									)
						port map	(
									a			=> in1,
									b 			=> in2,
									sub_add_n	=> sub_add_n,
									sum_diff 	=> sum_diff
									);
									
		slt(0)				<= sum_diff(31);
		slt(31 downto 1)	<= (others => '0');
		
		BS : barrel_shifter 
						generic map	( 
									N			=> 32,
									M  			=> 5
									)
						port map 	(
									R			=> in1,
									S			=> shamt,
									Q			=> BS_out
									);
									
		AND32 : AndN_bit
						generic map	( 
									N			=> 32
									)
						port  map	(
									A 			=> in1,
									B			=> in2,
									Output		=> AND_out
									);
									
		XOR32 : XorN_bit 
						generic map	( 
									N 			=> 32		
									)
						port map	(
									A 			=> in1,
									B			=> in2,
									Output		=> Xor_out
									);
									
		Zero_gen : ZeroN_bit 
						generic map ( 
									N			=> 32
									)
						port map	(
									diff		=> Xor_out,
									Zero		=> Zero
									);
									
		mux5 : bN_5to1mux 
						generic map (
									N			=> 32
									)
						port map	( 
									X000		=> sum_diff,
									X001		=> slt,
									X010		=> BS_out,
									X011		=> AND_out,
									X100		=> Xor_out,
									Sel			=> sel,
									output		=> operation
									);
									
		LA : LUI_AUIPC 
						port map(
								immediate		=> immediate,
								PC				=> PC,
								LUI_AUIPC_n		=> sel_LUI_AUIPC,
								LUI_AUIPC_out	=> LUI_AUIPC_out
								);
								
		mux2 : bN_2to1mux 
						generic map	(
									N			=> 32
									)
						port map	( 
									x			=> operation,
									y			=> LUI_AUIPC_out,
									s			=> sel_OP_LUI_AUIPC,
									output		=> outputs
									);
						
		
									
end architecture structure;
	
	
