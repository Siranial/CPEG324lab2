library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux8 is
    Port ( I : in std_logic;
           S : in std_logic_vector (2 downto 0);
           Y : out std_logic_vector (7 downto 0) := (others=>'0')
           );
end demux8;

architecture Behavioral of demux8 is

begin
    process(I,S) is
    begin
        -- Ensures that only one register is writing
        Y <= "00000000";
        case S is
            when "000" => Y(0) <= I;
            when "001" => Y(1) <= I;
            when "010" => Y(2) <= I;
            when "011" => Y(3) <= I;
            when "100" => Y(4) <= I;
            when "101" => Y(5) <= I;
            when "110" => Y(6) <= I;
            when others => Y(7) <= I;
        end case;
    end process;
end Behavioral;