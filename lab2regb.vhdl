library ieee;
use ieee.std_logic_1164.all;

entity regb is
    Port (  I: in std_logic_vector (3 downto 0);
            S: in std_logic_vector (2 downto 0);
            clk, enable: in std_logic;
            O: out std_logic_vector (3 downto 0)
            );
end regb;

architecture behav of regb is
--  Declaration of the component that will be instantiated.
component demux8 is
    port (  I : in std_logic;
            S : in std_logic_vector (2 downto 0);
            Y : out std_logic_vector (7 downto 0) := (others=>'0')
            );
end component;

component reg is
    port(	I:	    in std_logic_vector (3 downto 0); -- for loading
            clock:	in std_logic; -- rising-edge triggering 
            enable:	in std_logic; -- 0: don't do anything; 1: reg is enabled
            O:	    out std_logic_vector(3 downto 0) := (others=>'0') -- output the current register content. 
            );
end component;

component mux8 is
    Port (  I0 : in std_logic_vector (3 downto 0);
            I1 : in std_logic_vector (3 downto 0);
            I2 : in std_logic_vector (3 downto 0);
            I3 : in std_logic_vector (3 downto 0);
            I4 : in std_logic_vector (3 downto 0);
            I5 : in std_logic_vector (3 downto 0);
            I6 : in std_logic_vector (3 downto 0);
            I7 : in std_logic_vector (3 downto 0);
            S : in std_logic_vector (2 downto 0);
            Y : out std_logic_vector (3 downto 0) := (others=>'0')
            );
end component;
    
-- Write enable wires that connect demux to registers
signal W : std_logic_vector (7 downto 0) := (others=>'0');
-- Read wires that connect registers to mux
signal R0 : std_logic_vector (3 downto 0) := (others=>'0');
signal R1 : std_logic_vector (3 downto 0) := (others=>'0');
signal R2 : std_logic_vector (3 downto 0) := (others=>'0');
signal R3 : std_logic_vector (3 downto 0) := (others=>'0');
signal R4 : std_logic_vector (3 downto 0) := (others=>'0');
signal R5 : std_logic_vector (3 downto 0) := (others=>'0');
signal R6 : std_logic_vector (3 downto 0) := (others=>'0');
signal R7 : std_logic_vector (3 downto 0) := (others=>'0');

-- Input signals
signal i, o : std_logic_vector (3 downto 0) := (others=>'0');
signal s : std_logic_vector (2 downto 0) := (others=>'0');
signal clk, enable : std_logic;

begin
--  Component instantiation.
writedemux8: demux8 port map (  I => enable, S => s, Y(0) => W(0), Y(1) => W(1), Y(2) => W(2), 
                                Y(3) => W(3), Y(4) => W(4), Y(5) => W(5), Y(6) => W(6), Y(7) => W(7));
reg0: reg port map (i => i, clock => clk, enable => W(0), O => R0);
reg1: reg port map (i => i, clock => clk, enable => W(1), O => R1);
reg2: reg port map (i => i, clock => clk, enable => W(2), O => R2);
reg3: reg port map (i => i, clock => clk, enable => W(3), O => R3);
reg4: reg port map (i => i, clock => clk, enable => W(4), O => R4);
reg5: reg port map (i => i, clock => clk, enable => W(5), O => R5);
reg6: reg port map (i => i, clock => clk, enable => W(6), O => R6);
reg7: reg port map (i => i, clock => clk, enable => W(7), O => R7);
readmux8: mux8 port map (   I0 => R0, I1 => R1, I2 => R2, I3 => R3, I4 => R4, 
                            I5 => R5, I6 => R6, I7 => R7, S => s, Y => o);
end behav;