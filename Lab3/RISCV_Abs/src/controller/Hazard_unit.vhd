library ieee;
use ieee.std_logic_1164.all;

entity Hazard_unit is
	port(
		Rs1				: in std_logic_vector(4 downto 0);
		Rs2				: in std_logic_vector(4 downto 0);
		Rd1				: in std_logic_vector(4 downto 0);
		Rd2				: in std_logic_vector(4 downto 0);
		wb1				: in std_logic;
		wb2				: in std_logic;
		opcode6			: in std_logic; --for jump
		opcode5			: in std_logic; --for jump
		opcode3			: in std_logic; --for jump
		uncond_1D		: in std_logic;
		uncond_2D		: in std_logic;
		cond_2D			: in std_logic;
		zero			: in std_logic;
		load_op			: in std_logic;
		sel_WB_M		: out std_logic;
		enable_PC_NOP	: out std_logic;
		disableLoadOp	: out std_logic;
		c1				: out std_logic;
		c2				: out std_logic;
		c3				: out std_logic;
		c4				: out std_logic
		);
end entity Hazard_unit;

architecture Structure of Hazard_unit is

	component Hazard_control_det
		port(
			opcode6			: in std_logic; --for jump
			opcode5			: in std_logic; --for jump
			opcode3			: in std_logic; --for jump
			uncond_1D		: in std_logic;
			uncond_2D		: in std_logic;
			cond_2D			: in std_logic;
			zero			: in std_logic;
			sel_WB_M		: out std_logic;
			enable_PC_NOP	: out std_logic
			);
	end component Hazard_control_det;
	
	component Hazard_data_det
		port(
			Rs1			: in std_logic_vector(4 downto 0);
			Rs2			: in std_logic_vector(4 downto 0);
			Rd1			: in std_logic_vector(4 downto 0);
			Rd2			: in std_logic_vector(4 downto 0);
			wb1			: in std_logic;
			wb2			: in std_logic;
			c1			: out std_logic;
			c2			: out std_logic;
			c3			: out std_logic;
			c4			: out std_logic
			);
	end component Hazard_data_det;

	signal enable_PC_temp			: std_logic;
	signal c1_in, c3_in				: std_logic;
	
	begin
	
		 HC: Hazard_control_det
						port map(
								opcode6			=> opcode6,
								opcode5			=> opcode5,
								opcode3			=> opcode3,
								uncond_1D		=> uncond_1D,
								uncond_2D		=> uncond_2D,
								cond_2D			=> cond_2D,
								zero			=> zero,
								sel_WB_M		=> sel_WB_M,
								enable_PC_NOP	=> enable_PC_NOP
								);
								
		 disableLoadOp		<=(c1_in and load_op) or (c3_in and load_op);	
	
		 HD : Hazard_data_det
						port map(
								Rs1				=> Rs1,
								Rs2				=> Rs2,
								Rd1				=> Rd1,
								Rd2				=> Rd2,
								wb1				=> wb1,
								wb2				=> wb2,
								c1				=> c1_in,
								c2				=> c2,
								c3				=> c3_in,
								c4				=> c4
								);

		c1		<= c1_in;
		c3		<= c3_in;
								
end architecture Structure;
		
