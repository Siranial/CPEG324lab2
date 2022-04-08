library ieee;
use ieee.std_logic_1164.all;

entity regb_tb is
end regb_tb;

architecture behav of regb_tb is
--  Declaration of the component that will be instantiated.

component regb is
    port (  I: in std_logic_vector (3 downto 0) := (others=>'0');
            S: in std_logic_vector (2 downto 0) := (others=>'0');
            clk, enable: in std_logic;
            O: out std_logic_vector (3 downto 0) := (others=>'0')
            );
end component;

-- Input and output signal declaration
signal i : std_logic_vector (3 downto 0) := (others=>'0');
signal s : std_logic_vector (2 downto 0) := (others=>'0');
signal clk, enable : std_logic;
signal o : std_logic_vector (3 downto 0) := (others=>'0');

begin
-- Component Instantiation
regbank : regb port map( I => i, S => s, clk => clk, enable => enable, O => o);

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
("0001", "000", '1', '0', "0001"),
("1001", "000", '0', '1', "0001"),
("1001", "000", '1', '0', "1001"),
("1101", "001", '0', '1', "0000"), -- enable is delayed by 1 vector.
("1001", "001", '1', '0', "1001"), -- when enable is 1 for previous vector,
("1111", "001", '0', '1', "1001"), -- enable is seen as 1 for current vector.
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
