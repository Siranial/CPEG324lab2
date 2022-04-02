library ieee;
use ieee.std_logic_1164.all;


entity reg_tb is
end reg_tb;

architecture behav of reg_tb is
--  Declaration of the component that will be instantiated.
component reg
port(	
	I:	in std_logic_vector (3 downto 0); -- for loading
    clock:		in std_logic; -- rising-edge triggering 
	enable:		in std_logic; -- 0: don't do anything; 1: reg is enabled
	O:	out std_logic_vector(3 downto 0) -- output the current register content. 
);
end component;

--  Specifies which entity is bound with the component.
-- for reg_0: reg use entity work.reg(rtl);
signal i, o : std_logic_vector(3 downto 0);
signal clk, enable : std_logic;
begin
--  Component instantiation.
reg_0: reg port map (I => i, clock => clk, enable => enable, O => o);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the reg.
	i: std_logic_vector (3 downto 0);
	clock, enable: std_logic;
--  The expected outputs of the reg.
	o: std_logic_vector (3 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("0001", '0', '0', "0000"),
("0001", '1', '0', "0000"),
("0011", '0', '1', "0000"),
("0001", '1', '1', "0001")); -- Need two vectors to simulate an edge.
begin
--  Check each pattern.
	for n in patterns'range loop
--  Set the inputs.
		i <= patterns(n).i;
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
