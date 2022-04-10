library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    generic(dataWidth : integer);
    Port (  I0 : in STD_LOGIC_VECTOR (dataWidth-1 downto 0);
            I1 : in STD_LOGIC_VECTOR (dataWidth-1 downto 0);
            I2 : in STD_LOGIC_VECTOR (dataWidth-1 downto 0);
            I3 : in STD_LOGIC_VECTOR (dataWidth-1 downto 0);
            S : in STD_LOGIC_VECTOR (1 downto 0);
            Y : out STD_LOGIC_vector (dataWidth-1 downto 0));
end mux;

architecture Behavioral of mux is

begin
    with S select
    Y<= I0 when "00",
        I1 when "01",
        I2 when "10",
        I3 when others;

end Behavioral;