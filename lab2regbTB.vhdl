library ieee;
use ieee.std_logic_1164.all;

entity regb_tb is
end regb_tb;

architecture behav of regb_tb is
--  Declaration of the component that will be instantiated.
component demux8 is
    port (  I : in std_logic;
            S : in std_logic_vector (2 downto 0);
            Y : out std_logic_vector (7 downto 0) := (others=>'0')
            );
end component;

component reg is
    port(	
        I:	    in std_logic_vector (3 downto 0); -- for loading
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
signal clk, enable : std_logic := (others=>'0');

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
(("0001", "000", '0', '0', "0000"),
("0001", "000", '1', '1', "0001"),
("1001", "000", '0', '0', "0001"),
("1001", "000", '1', '1', "1001"),
("1101", "001", '0', '0', "0000"), -- enable is delayed by 1 vector.
("1001", "001", '1', '0', "0000"), -- when enable is 1 for previous vector,
("1111", "001", '0', '0', "0000"), -- enable is seen as 1 for current vector.
("0101", "001", '1', '1', "0101")
--("0101", "010", '0', '1', "0101"),
--("0101", "010", '1', '0', "0000"),
--("0101", "010", '0', '0', "0000"),
--("1110", "011", '1', '1', "0000"),
--("1110", "011", '0', '1', "1110"),
--("1010", "011", '1', '0', "1110"),
--("0001", "100", '0', '1', "0000"),
--("0101", "100", '1', '1', "0001"),
--("0101", "100", '0', '0', "0000"),
--("0111", "101", '1', '1', "0000"),
--("0001", "101", '0', '1', "0111"),
--("0001", "101", '1', '0', "0111"),
--("0001", "110", '0', '1', "0000"),
--("0001", "110", '1', '1', "0001"),
--("0001", "111", '0', '1', "0000"),
--("0011", "111", '1', '1', "0001"),
--("0011", "111", '0', '0', "0001")
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
