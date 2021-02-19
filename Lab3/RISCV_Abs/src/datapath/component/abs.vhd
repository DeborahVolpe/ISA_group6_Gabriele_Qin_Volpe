library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity abs_val is
	port(
		in_abs					: in std_logic_vector(31 downto 0);
		out_abs				 	: out std_logic_vector(31 downto 0)	
		);
end entity abs_val;


architecture Struct of abs_val is

	component bN_2to1mux 
		generic (N : positive := 8);
		port	( 
				x		: in std_logic_vector (N-1 downto 0); --0
				y		: in std_logic_vector (N-1 downto 0); --1
				s		: in std_logic;
				output	: out std_logic_vector(N-1 downto 0)
			  );
	end component bN_2to1mux;

	component adder 
		generic ( N : positive := 8);
		port	(
				a			: in std_logic_vector (N-1 downto 0);
				b 			: in std_logic_vector (N-1 downto 0);
				sum 		: out std_logic_vector (N-1 downto 0)
			);
	end component adder;


signal in_abs_inv,  in_abs_ca2: std_logic_vector(31 downto 0);
signal one: std_logic_vector(31 downto 0);

begin

g1: for i in 0 to 31 generate
	in_abs_inv(i) <= not(in_abs(i));
end generate;

one <= std_logic_vector(to_signed(1,32));

add_ca2: adder 
		generic map(N => 32)
		port map(
				a		=> in_abs_inv,	
				b 		=> one,
				sum 	=> in_abs_ca2
			);

mux_abs: bN_2to1mux 
		generic map (N => 32)
		port map ( 
				x		=> in_abs, --0
				y		=> in_abs_ca2, --1
				s		=> in_abs(31),
				output	=> out_abs
			  );

end architecture Struct;


