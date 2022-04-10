library ieee;
use ieee.std_logic_1164.all;

entity alu is
    Port (  A: in std_logic_vector (3 downto 0);
            B: in std_logic_vector (3 downto 0);
            S: in std_logic; -- Selects adding / subtracting
            CUF, COF: out std_logic; -- Carry under and overflow bits
            O: out std_logic_vector (3 downto 0));
end alu;



architecture behavioral of alu is

    component mux2to1 is
        Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
               S : in STD_LOGIC;
               Y : out STD_LOGIC_vector (3 downto 0));
    end component;

    component fullAdder is
        Port (  A,B,Cin: in std_logic;
                O, Cout: out std_logic
                );
    end component;
    
    signal twosComp : std_logic_vector (3 downto 0);
    signal aluB : std_logic_vector (3 downto 0);
    signal FAcout : std_logic_vector (3 downto 0);
    signal TCc : std_logic_vector (2 downto 0);

    begin

        mux : mux2to1 port map(A => B, B => twosComp, S => S, Y => aluB);

        FA0 : fullAdder port map(A => A(0), B => aluB(0), Cin => '0', 
                                O => O(0), Cout => FAcout(0));

        FA1 : fullAdder port map(A => A(1), B => aluB(1), Cin => FAcout(0),
                                O => O(1), Cout => FAcout(1));

        FA2 : fullAdder port map(A => A(2), B => aluB(2), Cin => FAcout(1), 
                                O => O(2), Cout => FAcout(2));

        FA3 : fullAdder port map(A => A(3), B => aluB(3), Cin => FAcout(2), 
                                O => O(3), Cout => FAcout(3));

        --Twos complement for B
        twosComp(0) <= B(0) xor '1';
        TCc(0) <= B(0) and '1';
        twosComp(1) <= B(1) xor TCc(0);
        TCc(1) <= B(1) and TCc(0);
        twosComp(2) <= B(2) xor TCc(1);
        TCc(2) <= B(2) and TCc(1);
        twosComp(3) <= B(3) xor TCc(2);

        --Demux 2 to 1 for adding / subtracting
        with S select
        aluB<=  B when '0',
                twosComp when others;

        --Select underflow or overflow
        COF <= FAcout(3) and (not S);
        CUF <= FAcout(3) and S;

end behavioral;