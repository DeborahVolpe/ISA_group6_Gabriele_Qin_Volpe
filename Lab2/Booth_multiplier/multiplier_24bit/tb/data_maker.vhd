library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is
  port (
    CLK  	: in std_logic;
	RST_n 	: in std_logic;
    A		: out std_logic_vector(23 downto 0);
	B		: out std_logic_vector(23 downto 0)
	);
end data_maker;

architecture beh of data_maker is

begin  -- beh

  process (CLK)
    file fp : text open read_mode is "./input.txt";
    variable ptr : line;
	variable space : character;
    variable A_f, B_f : std_logic_vector(23 downto 0);
  begin  -- process
  if RST_n = '1' then
    if CLK'event and CLK = '1' then  -- rising clock edge
      if (not(endfile(fp))) then
        readline(fp, ptr);
        read(ptr, A_f);
		read(ptr, space);
		read(ptr, B_f);  
      end if;
    end if;
  end if;
  A <= A_f;
  B <= B_f;
  end process;

end beh;
