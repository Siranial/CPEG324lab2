library ieee;
use ieee.std_logic_1164.all;

entity regb is
    Port (  I: in std_logic_vector (3 downto 0);
            S: in std_logic_vector (2 downto 0);
            clk, enable: in std_logic;
            O: out std_logic_vector (3 downto 0));
end regb;

architecture behavioral of regb is

component demux8
    port(
        I : in STD_LOGIC_VECTOR (3 downto 0);
        S : in STD_LOGIC_VECTOR (2 downto 0);
        Y0 : out STD_LOGIC_VECTOR (3 downto 0);
        Y1 : out STD_LOGIC_VECTOR (3 downto 0);
        Y2 : out STD_LOGIC_VECTOR (3 downto 0);
        Y3 : out STD_LOGIC_VECTOR (3 downto 0);
        Y4 : out STD_LOGIC_VECTOR (3 downto 0);
        Y5 : out STD_LOGIC_VECTOR (3 downto 0);
        Y6 : out STD_LOGIC_VECTOR (3 downto 0);
        Y7 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component reg
    port(	
        I:	    in std_logic_vector (3 downto 0); -- for loading
        clock:	in std_logic; -- rising-edge triggering 
        enable:	in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	    out std_logic_vector(3 downto 0) -- output the current register content. 
    );
end component;

component mux8
    Port (  I0 : in STD_LOGIC_VECTOR (3 downto 0);
            I1 : in STD_LOGIC_VECTOR (3 downto 0);
            I2 : in STD_LOGIC_VECTOR (3 downto 0);
            I3 : in STD_LOGIC_VECTOR (3 downto 0);
            I4 : in STD_LOGIC_VECTOR (3 downto 0);
            I5 : in STD_LOGIC_VECTOR (3 downto 0);
            I6 : in STD_LOGIC_VECTOR (3 downto 0);
            I7 : in STD_LOGIC_VECTOR (3 downto 0);
            S : in STD_LOGIC_VECTOR (2 downto 0);
            Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

-- Write wires that connect demux to registers
signal W0 : std_logic_vector (3 downto 0) := (others=>'0');
signal W1 : std_logic_vector (3 downto 0) := (others=>'0');
signal W2 : std_logic_vector (3 downto 0) := (others=>'0');
signal W3 : std_logic_vector (3 downto 0) := (others=>'0');
signal W4 : std_logic_vector (3 downto 0) := (others=>'0');
signal W5 : std_logic_vector (3 downto 0) := (others=>'0');
signal W6 : std_logic_vector (3 downto 0) := (others=>'0');
signal W7 : std_logic_vector (3 downto 0) := (others=>'0');
-- Read wires that connect registers to mux
signal R0 : std_logic_vector (3 downto 0) := (others=>'0');
signal R1 : std_logic_vector (3 downto 0) := (others=>'0');
signal R2 : std_logic_vector (3 downto 0) := (others=>'0');
signal R3 : std_logic_vector (3 downto 0) := (others=>'0');
signal R4 : std_logic_vector (3 downto 0) := (others=>'0');
signal R5 : std_logic_vector (3 downto 0) := (others=>'0');
signal R6 : std_logic_vector (3 downto 0) := (others=>'0');
signal R7 : std_logic_vector (3 downto 0) := (others=>'0');

begin
--  Component instantiation.
writedemux8: demux8 port map (  I => I, S => S, Y0 => W0, Y1 => W1, Y2 => W2, 
                                Y3 => W3, Y4 => W4, Y5 => W5, Y6 => W6, Y7 => W7);
reg0: reg port map (I => W0, clock => clk, enable => enable, O => R0);
reg1: reg port map (I => W1, clock => clk, enable => enable, O => R1);
reg2: reg port map (I => W2, clock => clk, enable => enable, O => R2);
reg3: reg port map (I => W3, clock => clk, enable => enable, O => R3);
reg4: reg port map (I => W4, clock => clk, enable => enable, O => R4);
reg5: reg port map (I => W5, clock => clk, enable => enable, O => R5);
reg6: reg port map (I => W6, clock => clk, enable => enable, O => R6);
reg7: reg port map (I => W7, clock => clk, enable => enable, O => R7);
readmux8: mux8 port map (   I0 => R0, I1 => R1, I2 => R2, I3 => R3, I4 => R4, 
                            I5 =>R5, I6 => R6, I7 => R7, S => S, Y => O);

end behavioral;