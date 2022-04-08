library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture behav of alu_tb is



--  Test cases for ALU
process
type pattern_type is record
--  The inputs of the ALU.

--  The expected outputs of the ALU.

end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(
);
begin
--  Check each pattern.
	for n in patterns'range loop
--  Set the inputs.

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