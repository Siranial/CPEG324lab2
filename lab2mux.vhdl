library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           D : in STD_LOGIC;
           S : in STD_LOGIC_VECTOR (1 downto 0);
           Y : out STD_LOGIC);
end mux;

architecture Behavioral of mux is

begin
with S select

Y<= A when "00",
    B when "01",
    C when "10",
    D when others;

end Behavioral;