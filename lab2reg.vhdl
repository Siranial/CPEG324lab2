library ieee;
use ieee.std_logic_1164.all;

entity reg is
port(
  I: in std_logic_vector (3 downto 0); -- for loading
  clock: in std_logic; -- rising-edge triggering 
  enable: in std_logic; -- 0: don't do anything; 1: reg is enabled
  O: out std_logic_vector(3 downto 0) -- output the current register
);
end reg;

architecture behav of reg is

begin
    process(clock)
    begin
      if rising_edge(clock) then
        if (enable = '1') then
          O<=I;
        end if;
      end if;
    end process;
end behav;
