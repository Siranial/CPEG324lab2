library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( I : in STD_LOGIC_VECTOR (3 downto 0);
           S : in STD_LOGIC_VECTOR (1 downto 0);
           Y : out STD_LOGIC);
end mux;

architecture Behavioral of mux is

begin
    with S select
    Y<= I(0) when "00",
        I(1) when "01",
        I(2) when "10",
        I(3) when others;

end Behavioral;