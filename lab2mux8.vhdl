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
    process(I0,I1,I2,I3,I4,I5,I6,I7,S) begin
        case S is
            when "000" => Y <= I0;
            when "001" => Y <= I1;
            when "010" => Y <= I2;
            when "011" => Y <= I3;
            when "100" => Y <= I4;
            when "101" => Y <= I5;
            when "110" => Y <= I6;
            when others => Y <= I7;
        end case;
    end process;

end Behavioral;