library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench is
end testbench;

architecture Behavioral of testbench is
   
    COMPONENT mux 
    PORT(
        I: IN std_logic_vector (3 downto 0);
        S: IN std_logic_vector (1 downto 0);
        Y: OUT std_logic
    );
    END COMPONENT;
    
    signal I : std_logic_vector (3 downto 0) := (others=>'0');
    signal S : std_logic_vector (1 downto 0) := (others=>'0');
    signal Y : std_logic;

begin
    uut: mux PORT MAP (
          I => I,
          S => S,
          Y => Y
        );
    stim_proc: process
    begin
        wait for 100 ns;
        
        I<="1001";
        
        S<="00";
        wait for 100 ns;
        S<="01";
        wait for 100 ns;
        S<="10";
        wait for 100 ns;
        S<="11";
        wait for 100 ns; 
        wait;-- Wait forever to finish simulation
    end process;
end Behavioral;
