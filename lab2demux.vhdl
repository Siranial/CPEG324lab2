library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux8 is
    Port ( I : in STD_LOGIC_VECTOR (3 downto 0);
           S : in STD_LOGIC_VECTOR (2 downto 0);
           Y0 : out STD_LOGIC_VECTOR (3 downto 0);
           Y1 : out STD_LOGIC_VECTOR (3 downto 0);
           Y2 : out STD_LOGIC_VECTOR (3 downto 0);
           Y3 : out STD_LOGIC_VECTOR (3 downto 0);
           Y4 : out STD_LOGIC_VECTOR (3 downto 0);
           Y5 : out STD_LOGIC_VECTOR (3 downto 0);
           Y6 : out STD_LOGIC_VECTOR (3 downto 0);
           Y7 : out STD_LOGIC_VECTOR (3 downto 0));
end demux8;

architecture Behavioral of demux8 is

begin
    process(I,S) is
    begin
        case S is
            when "000" => Y0 <= I;
            when "001" => Y1 <= I;
            when "010" => Y2 <= I;
            when "011" => Y3 <= I;
            when "100" => Y4 <= I;
            when "101" => Y5 <= I;
            when "110" => Y6 <= I;
            when others => Y7 <= I;
        end case;
    end process;
end Behavioral;