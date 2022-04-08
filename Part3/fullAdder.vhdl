library ieee;
use ieee.std_logic_1164.all;

entity alu is
    Port (  A: in std_logic_vector (3 downto 0);
            B: in std_logic_vector (3 downto 0);
            Cin: in std_logic; -- Inbound carry bit
            Cout: out std_logic; -- Outbound carry bit
            O: out std_logic_vector (3 downto 0));
end alu;

architecture behavioral of alu is




end behavioral;