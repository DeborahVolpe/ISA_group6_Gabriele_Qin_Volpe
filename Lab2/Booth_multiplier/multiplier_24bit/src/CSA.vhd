library ieee; 
use ieee.std_logic_1164.all;

entity CSA is
	generic ( N		: positive := 8 );
	port(
			a		: in std_logic_vector ( N-1 downto 0 );
			b		: in std_logic_vector ( N-1 downto 0 );
			c		: in std_logic_vector ( N-1 downto 0 );
			sum		: out std_logic_vector ( N-1 downto 0 );
			carry	: out std_logic_vector ( N-1 downto 0 )
		);
end entity CSA;

architecture structure of CSA is 

	component full_adder 
		port(
				a		: in std_logic;
				b		: in std_logic;
				c_in	: in std_logic;
				s		: out std_logic;
				c_out	: out std_logic
			);
	end component full_adder;
	
	
	begin
	
		g1 : for i in 0 to N-1 generate
			
			FA : full_adder 
					port map(
							a		=> a(i),	
							b		=> b(i),
							c_in	=> c(i),
							s		=> sum(i),
							c_out	=> carry(i)
							);
							
		end generate;
		
end architecture structure; 
