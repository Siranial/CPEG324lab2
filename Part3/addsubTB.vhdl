library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture behav of alu_tb is

	component alu is
		Port (  A: in std_logic_vector (3 downto 0);
				B: in std_logic_vector (3 downto 0);
				S: in std_logic; -- Selects adding / subtracting
				CUF, COF: out std_logic; -- Carry under and overflow bits
				O: out std_logic_vector (3 downto 0));
	end component;

-- Input signals
signal a,b: std_logic_vector (3 downto 0);
signal s: std_logic;
-- Output signals
signal cuf,cof: std_logic;
signal o: std_logic_vector (3 downto 0);

begin
-- Component Instantiation
addsub : alu port map(A => a, B => b, S => s, CUF => cuf, COF => cof, O => o);

--  Test cases for ALU
process
type pattern_type is record
--  The inputs of the ALU.
		a,b: std_logic_vector (3 downto 0);
		s: std_logic;
--  The expected outputs of the ALU.
		cuf,cof: std_logic;
		o: std_logic_vector (3 downto 0);

end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("0100", "0010", '0', '0', '0', "0110"), -- 4 + 2 = 6
("0100", "0001", '1', '0', '0', "0011") -- 4 - 1 = 3
);
begin
--  Check each pattern.
	for n in patterns'range loop
--  Set the inputs.
		a <= patterns(n).a;
		b <= patterns(n).b;
		s <= patterns(n).s;
--  Wait for the results.
		wait for 1 ns;
--  Check the outputs.
		assert cuf = patterns(n).cuf
		report "bad output value" severity error;
		assert cof = patterns(n).cof
		report "bad output value" severity error;
		assert o = patterns(n).o
		report "bad output value" severity error;
	end loop;
	assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
	wait;
end process;
end behav;