library ieee; 
use ieee.std_logic_1164.all;

entity partial_product_generator is

	generic ( N : positive := 24 );
	port(
			b2j_plus_1		: in std_logic;
			b2j				: in std_logic;
			b2j_minus_1		: in std_logic;
			A				: in std_logic_vector ( N-1 downto 0 );
			p				: out std_logic_vector ( N downto 0 );
			s				: out std_logic
		);
		
end entity partial_product_generator;

architecture structure of partial_product_generator is
	
	component bN_3to1mux 
		generic	(N : integer := 8);
		port 	(  
				x		: in std_logic_vector (N-1 downto 0); --00
				y		: in std_logic_vector (N-1 downto 0); --01
				z		: in std_logic_vector (N-1 downto 0); --10
				s		: in std_logic_vector (1 downto 0);
				output	: out std_logic_vector (N-1 downto 0)
				);
	end component bN_3to1mux;
	
	signal A2		: std_logic_vector ( N downto 0 );
	signal A_ext	: std_logic_vector ( N downto 0 );
	signal Sel		: std_logic_vector ( 1 downto 0 );
	signal p_temp	: std_logic_vector ( N downto 0 );
	signal s_temp   : std_logic;
	
	begin
	
		A2		<= A & "0";
		A_ext 	<= "0" & A;
		
		Sel(0)	<= b2j xor b2j_minus_1;
		Sel(1) 	<= (b2j xnor b2j_minus_1) and ( b2j_plus_1 xor b2j );
		
		s_temp <= b2j_plus_1 and (b2j nand b2j_minus_1);
		
		mux : bN_3to1mux 
				generic map (  N => N+1 )
				port map	(  
							x		=> (others => '0'),
							y		=> A_ext,
							z		=> A2,
							s		=> Sel,
							output	=> p_temp
							);
							
		g1 : for i in 0 to N generate
		
			p(i) <= p_temp(i) xor s_temp;
			
		end generate;
		
		s		<= s_temp;
		
end architecture structure;
			
		
		
