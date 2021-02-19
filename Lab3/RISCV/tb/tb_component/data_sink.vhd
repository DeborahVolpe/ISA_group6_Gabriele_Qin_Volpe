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
    CLK  			: in std_logic;
    RST_n 			: in std_logic;
    AddressData		: in std_logic_vector(31 downto 0);
	write_data		: in std_logic;
	read_data		: in std_logic;
	Data_in			: in std_logic_vector(31 downto 0);
	PC_out			: in std_logic_vector(31 downto 0)
	);
end data_sink;

architecture beh of data_sink is

	constant tco 		 : time := 1 ns; --delay 
	signal valid_output	 : std_logic_vector(0 to 5);
	signal start		 : std_logic;

begin  -- beh

  process (CLK, RST_n)
    file outputFile : text open WRITE_MODE is "./results.txt";
    variable line_out : line;    
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      null;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
	  if start = '1' then
		write(line_out,AddressData);
		write(line_out,' ');
		write(line_out,write_data);
		write(line_out,' ');
		write(line_out,read_data);
		write(line_out,' ');
		write(line_out,Data_in);
		write(line_out,' ');
		write(line_out,PC_out);
		writeline(OutputFile, line_out);
	  end if;
    end if;
  end process;
  
   process (CLK, RST_n)
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      valid_output <= (others => '0') after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      valid_output(0) <= '1' after tco;
      valid_output(1 to 5) <= valid_output(0 to 4) after tco;
    end if;
  end process;

  start <= valid_output(5);  

end beh;
