library ieee;
use ieee.std_logic_1164.all;

entity regb_tb is
end regb_tb;

architecture behav of regb_tb is
--  Declaration of the component that will be instantiated.
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
        I:	in std_logic_vector (3 downto 0); -- for loading
        clock:		in std_logic; -- rising-edge triggering 
        enable:		in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	out std_logic_vector(3 downto 0) -- output the current register content. 
    );
end component;

component mux8 is
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

-- Input signals
signal i, o : std_logic_vector (3 downto 0) := (others=>'0');
signal s : std_logic_vector (2 downto 0) := (others=>'0');
signal clk, enable : std_logic := '0';

begin
--  Component instantiation.
writedemux8: demux8 port map (  I => i, S => S, Y0 => W0, Y1 => W1, Y2 => W2, 
                                Y3 => W3, Y4 => W4, Y5 => W5, Y6 => W6, Y7 => W7);
reg0: reg port map (i => W0, clock => clk, enable => enable, O => R0);
reg1: reg port map (i => W1, clock => clk, enable => enable, O => R1);
reg2: reg port map (i => W2, clock => clk, enable => enable, O => R2);
reg3: reg port map (i => W3, clock => clk, enable => enable, O => R3);
reg4: reg port map (i => W4, clock => clk, enable => enable, O => R4);
reg5: reg port map (i => W5, clock => clk, enable => enable, O => R5);
reg6: reg port map (i => W6, clock => clk, enable => enable, O => R6);
reg7: reg port map (i => W7, clock => clk, enable => enable, O => R7);
readmux8: mux8 port map (   I0 => R0, I1 => R1, I2 => R2, I3 => R3, I4 => R4, 
                            I5 =>R5, I6 => R6, I7 => R7, S => s, Y => o);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the reg.
	i : std_logic_vector (3 downto 0);
    s : std_logic_vector (2 downto 0);
	clock, enable : std_logic;
--  The expected outputs of the reg.
	o: std_logic_vector (3 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("0001", "000", '0', '1', "0000"),
("0001", "000", '1', '1', "0001"),
("1001", "000", '0', '1', "0000"),
("1001", "000", '1', '1', "1001"),
("1101", "001", '0', '1', "0000"),
("0001", "001", '1', '1', "1101"),
("1111", "001", '0', '0', "1101"),
("0101", "010", '1', '1', "0000"),
("0101", "010", '0', '1', "0101"),
("0101", "010", '1', '0', "0000"),
("0101", "010", '0', '0', "0000"),
("1110", "011", '1', '1', "0000"),
("1110", "011", '0', '1', "1110"),
("1010", "011", '1', '0', "1110"),
("0001", "100", '0', '1', "0000"),
("0101", "100", '1', '1', "0001"),
("0101", "100", '0', '0', "0000"),
("0111", "101", '1', '1', "0000"),
("0001", "101", '0', '1', "0111"),
("0001", "101", '1', '0', "0111"),
("0001", "110", '0', '1', "0000"),
("0001", "110", '1', '1', "0001"),
("0001", "111", '0', '1', "0000"),
("0011", "111", '1', '1', "0001"),
("0011", "111", '0', '0', "0001")
);
begin
--  Check each pattern.
	for n in patterns'range loop
--  Set the inputs.
		i <= patterns(n).i;
        s <= patterns(n).s;
		clk <= patterns(n).clock;
		enable <= patterns(n).enable;
--  Wait for the results.
		wait for 1 ns;
--  Check the outputs.
		assert o = patterns(n).o
		report "bad output value" severity error;
	end loop;
	assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
	wait;
end process;
end behav;
