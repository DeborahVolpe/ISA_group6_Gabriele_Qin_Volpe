library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is  
  port (
    CLK     : in  std_logic; --clock signal
    RST_n   : in  std_logic; --reset low active
    VOUT    : out std_logic; -- valid input for IIR
    DOUT    : out signed (10 downto 0); -- input of the IIR
    c2      : out signed (10 downto 0); -- coefficient
    c1      : out signed (10 downto 0); -- coefficient
	c0      : out signed (10 downto 0); -- coefficient
    b0      : out signed (10 downto 0); -- coefficient
    END_SIM : out std_logic);
end data_maker;

architecture beh of data_maker is

  constant tco : time := 1 ns; --delay 

  signal sEndSim : std_logic;
  signal END_SIM_i : std_logic_vector(0 to 4);  

begin  -- beh

  -- set coefficients value
  c2 <= to_signed(25,11);
  c1 <= to_signed(-69,11);
  c0 <= to_signed(499,11);
  b0 <= to_signed(430,11);

  process (CLK, RST_n)
    file fp_in : text open READ_MODE is "../../../Design/samples.txt";
    variable line_in : line;
    variable x : integer;
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      DOUT <= (others => '0') after tco;      
      VOUT <= '0' after tco;
      sEndSim <= '0' after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if not endfile(fp_in) then
        readline(fp_in, line_in);
        read(line_in, x);
        DOUT <= to_signed(x, 11) after tco;
        VOUT <= '1' after tco;
        sEndSim <= '0' after tco;
      else
        VOUT <= '0' after tco;        
        sEndSim <= '1' after tco;
      end if;
    end if;
  end process;

  process (CLK, RST_n)
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      END_SIM_i <= (others => '0') after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      END_SIM_i(0) <= sEndSim after tco;
      END_SIM_i(1 to 4) <= END_SIM_i(0 to 3) after tco;
    end if;
  end process;

  END_SIM <= END_SIM_i(4);  

end beh;
