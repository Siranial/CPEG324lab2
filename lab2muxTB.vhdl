library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench is
end testbench;

architecture Behavioral of testbench is
   
    COMPONENT mux 
    PORT(
        A: IN std_logic;
        B: IN std_logic;
        C: IN std_logic;
        D: IN std_logic;
        S: IN std_logic_vector (1 downto 0));
        Y: OUT std_logic; 
    );
    END COMPONENT;
    
    signal A : std_logic := '0';
    signal B : std_logic := '0';
    signal C : std_logic := '0';
    signal D : std_logic := '0';
    signal S : std_logic_vector (1 downto 0) := (others=>'0');
    
    signal Y : std_logic;

begin
    uut: mux PORT MAP (
          A => A,
          B => B,
          C => C,
          D => D,
          S => S,
          Y => Y
        );
    stim_proc: process
    begin
        wait for 100ns;
        
        A<='1';
        B<='0';
        C<='0';
        D<='1';
        
        S<="00";
        wait for 100 ns;
        S<="01";
        wait for 100 ns;
        S<="10";
        wait for 100 ns;
        S<="11";
        wait for 100 ns;
        end process;

end Behavioral;
