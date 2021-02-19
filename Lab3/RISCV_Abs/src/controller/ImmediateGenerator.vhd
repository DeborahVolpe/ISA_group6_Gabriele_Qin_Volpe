library ieee;
use ieee.std_logic_1164.all;

entity ImmediateGenerator is
	port(	
		Instruction					: in std_logic_vector(31 downto 0);
		write_data					: in std_logic;
		cond						: in std_logic;
		Immediate_mux_B				: out std_logic_vector(31 downto 0);
		ImmediateAIUPC_LUI			: out std_logic_vector(19 downto 0);
		Shamt						: out std_logic_vector(4 downto 0);
		Immediate_address_branch	: out std_logic_vector(30 downto 0);
		sel_LUI_AUIPC				: out std_logic;
		sel_OP_LUI_AUIPC			: out std_logic
		);
end entity ImmediateGenerator;

architecture Structure of ImmediateGenerator is 

	component bN_2to1mux
		generic (N : positive := 8);
		port	( 
				x		: in std_logic_vector (N-1 downto 0); --0
				y		: in std_logic_vector (N-1 downto 0); --1
				s		: in std_logic;
				output	: out std_logic_vector(N-1 downto 0)
			  );
	end component bN_2to1mux;
	
	signal immediate_op_lw			: std_logic_vector(31 downto 0); -- immediate operation + load
	signal immediate_st				: std_logic_vector(31 downto 0); -- immediate store
	signal immediate_br_uncond		: std_logic_vector(30 downto 0);
	signal immediate_br_cond		: std_logic_vector(30 downto 0);
	
	begin
	
		immediate_op_lw(11 downto 0)	<= Instruction(31 downto 20);
		immediate_op_lw(31 downto 12)	<= (others => Instruction(31));
		
		immediate_st(11 downto 0)		<= Instruction(31 downto 25) & Instruction(11 downto 7);
		immediate_st(31 downto 12)		<= (others => Instruction(31));
		
		
		mux_st_lw_op :  bN_2to1mux
						generic map (
									N		=> 32
									)
						port map 	( 
									x		=> immediate_op_lw,
									y		=> immediate_st,
									s		=> write_data,
									output	=> Immediate_mux_B
									);
									
		ImmediateAIUPC_LUI				<= Instruction(31 downto 12);
		
		Shamt							<= Instruction(24 downto 20);
		
		immediate_br_uncond(19 downto 0)	<= Instruction(31) & Instruction(19 downto 12) & Instruction(20) & Instruction(30 downto 21);
		immediate_br_uncond(30 downto 20)	<= (others => Instruction(31));

		immediate_br_cond(11 downto 0)		<= Instruction(31) & Instruction(7) & Instruction(30 downto 25) & Instruction(11 downto 8);
		immediate_br_cond(30 downto 11)		<= (others => Instruction(31));
		
		mux_br	 :  bN_2to1mux
						generic map (
									N		=> 31
									)
						port map 	( 
									x		=> immediate_br_uncond,
									y		=> immediate_br_cond,
									s		=> cond,
									output	=> Immediate_address_branch
									);
									
		sel_LUI_AUIPC		<= Instruction(5);
		sel_OP_LUI_AUIPC	<= Instruction(2);
									
end architecture Structure;
		
		
		
	
