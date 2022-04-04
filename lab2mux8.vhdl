library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8 is
    Port (  I0 : in std_logic_vector (3 downto 0);
            I1 : in std_logic_vector (3 downto 0);
            I2 : in std_logic_vector (3 downto 0);
            I3 : in std_logic_vector (3 downto 0);
            I4 : in std_logic_vector (3 downto 0);
            I5 : in std_logic_vector (3 downto 0);
            I6 : in std_logic_vector (3 downto 0);
            I7 : in std_logic_vector (3 downto 0);
            S : in std_logic_vector (2 downto 0);
            Y : out std_logic_vector (3 downto 0));
end mux8;

architecture Behavioral of mux8 is

begin
    with S select
    Y<= I0 when "000",
        I1 when "001",
        I2 when "010",
        I3 when "011",
        I4 when "100",
        I5 when "101",
        I6 when "110",
        I7 when others;

end Behavioral;