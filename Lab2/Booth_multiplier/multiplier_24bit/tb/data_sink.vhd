library STD;
use STD.textio.all;                     -- basic I/O
library IEEE;
use IEEE.std_logic_1164.all;            -- basic logic types
use IEEE.std_logic_textio.all;
USE ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity data_sink is
  port (
    CLK   	: in std_logic;
    RST_n 	: in std_logic;
    P  		: in std_logic_vector (47 downto 0);
	P_test	: in std_logic_vector (47 downto 0);
	Errore	: out std_logic
	);
end data_sink;

architecture beh of data_sink is

	constant tco 		 : time := 1 ns; --delay 
	signal valid_output	 : std_logic_vector(0 to 5);
	signal P_temp		 : std_logic_vector (47 downto 0);

begin  -- beh

  P_temp <= P after tco;

  process (P_temp)
    file res_fp : text open WRITE_MODE is "./log.txt";
    variable line_out : line;    
  begin  -- process
	  if P = P_test then
		Errore <= '0';
	   else
		 Errore <= '1';
		 write(line_out,P);
		 write(line_out,' ');
		 write(line_out,P_test);
         writeline(res_fp, line_out);
      end if;
  end process;
    

end beh;
