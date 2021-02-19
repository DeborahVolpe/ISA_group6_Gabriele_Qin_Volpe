library ieee;
use ieee.std_logic_1164.all;

-- Generic right barrel shifter

entity barrel_shifter is
    generic ( 
			N : positive := 8; -- bit of the input
			M : positive := 3  -- bit of the shift --> max value is log2(N) that is, it can shift by up to N positions
			);
    port  (
			R 	: in std_logic_vector (N-1 downto 0);
			S	: in std_logic_vector (M-1 downto 0);
			Q	: out std_logic_vector(N-1 downto 0)
		  );
end entity barrel_shifter;

architecture Structure of barrel_shifter is

	component bN_2to1mux 
		generic (N : positive := 8);
		port ( x, y 	: in std_logic_vector(N-1 downto 0);
			   s   		: in std_logic;
			   output	: out std_logic_vector(N-1 downto 0)
			  );
	end component;
	
	type matrix is array (M-1 downto 0) of std_logic_vector (N-1 downto 0);
	type matrix_out is array (M downto 0) of std_logic_vector (N-1 downto 0);
	signal x : matrix; 
	signal output : matrix_out;

begin
	
	output(0) <=  R;
	
	--generation of multiplexer matrix
	G: for i in 0 to M-1 generate
		gx : for j in 2**i to N-1 generate
			x(i)(j-2**i) <= output(i)(j);
		end generate;
		gx2 : for k in N-2**i to N-1 generate
			x(i)(k) <= R(N-1);
		end generate;
		
		mux : bN_2to1mux 
			generic map (N => N )
			port map 	(
						x 		=> output(i),
						y 		=> x(i),
						s 		=> S(i), 
						output	=> output(i+1)	
						);
	end generate;
	
	
	Q <= output(M);
	
end architecture;
