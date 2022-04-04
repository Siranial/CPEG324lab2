library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux8 is
    Port ( I : in std_logic;
           S : in std_logic_vector (2 downto 0);
           Y0 : out std_logic;
           Y1 : out std_logic;
           Y2 : out std_logic;
           Y3 : out std_logic;
           Y4 : out std_logic;
           Y5 : out std_logic;
           Y6 : out std_logic;
           Y7 : out std_logic);
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

--    Y0 <= (not S(2) and not S(1) and not S(0)) and I;
--    Y0 <= (not S(2) and not S(1) and S(0)) and I;
--    Y0 <= (not S(2) and S(1) and not S(0)) and I;
--    Y0 <= (not S(2) and S(1) and S(0)) and I;
--    Y0 <= (S(2) and not S(1) and not S(0)) and I;
--    Y0 <= (S(2) and not S(1) and S(0)) and I;
--    Y0 <= (S(2) and S(1) and not S(0)) and I;
--    Y0 <= (S(2) and S(1) and S(0)) and I;
end Behavioral;