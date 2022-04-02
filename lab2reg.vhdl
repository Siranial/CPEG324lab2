library ieee;
use ieee.std_logic_1164.all;

entity reg is
port(
  I: in std_logic_vector (3 downto 0); -- for loading
  clock: in std_logic; -- rising-edge triggering 
  enable: in std_logic; -- 0: don't do anything; 1: reg is enabled
  O: out std_logic_vector (3 downto 0) := (others => '0') -- output the current register
);
end reg;

architecture behav of reg is

--Value stored in register, initialized to "0000"
signal V : std_logic_vector (3 downto 0) := (others=>'0');

begin
    process(clock)
    begin
      if rising_edge(clock) then
        -- Write to register when enable = '0'
        if (enable = '0') then
          V <= I;
        -- Read from register when enable = '1'
        else
          O <= V;
        end if;
      end if;
    end process;
end behav;
