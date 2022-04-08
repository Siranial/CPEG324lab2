library ieee;
use ieee.std_logic_1164.all;

entity alu is
    Port (  I0: in std_logic_vector (3 downto 0);
            I1: in std_logic_vector (3 downto 0);
            S: in std_logic; -- Selects adding / subtracting
            O: out std_logic_vector (3 downto 0));
end alu;

architecture behavioral of alu is



end behavioral;