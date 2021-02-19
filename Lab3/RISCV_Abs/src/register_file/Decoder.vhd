library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder is
	port( 
		write_enable 		: in std_logic;
		write_reg			: in std_logic_vector( 4 downto 0);
		load_r				: out std_logic_vector(31 downto 0)
		);
end Decoder;

architecture Structure of Decoder is 

	begin

		process (write_enable, write_reg )
			begin
				if write_enable ='1' then
					load_r	<= std_logic_vector(to_unsigned(2**(to_integer(unsigned(write_reg))), 32));
				else
					load_r <= (others => '0');
				end if;
		end process;

end architecture structure;
