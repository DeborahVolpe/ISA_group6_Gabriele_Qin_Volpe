library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clk_gen is
  port (
    END_SIM : in  std_logic;  -- End simulation
    CLK     : out std_logic;  -- clock signal
    RST_n   : out std_logic); -- reset low active
end clk_gen;

architecture beh of clk_gen is

  constant Ts : time := 4.8 ns; -- clock period
  
  signal CLK_i : std_logic;
  
begin  -- beh

  process
  begin  -- process
    if (CLK_i = 'U') then
      CLK_i <= '0';
    else
      CLK_i <= not(CLK_i); -- toggle each half period
    end if;
    wait for Ts/2;
  end process;

  CLK <= CLK_i and not(END_SIM); -- End simulation filter the clock signal

  process
  begin  -- process
    RST_n <= '0'; -- reset active
    wait for 3*Ts/2;
    RST_n <= '1'; -- reset disable
    wait;
  end process;

end beh;
