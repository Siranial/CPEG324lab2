library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench is
end testbench;

architecture Behavioral of testbench is
   
    component mux is
        generic(dataWidth : integer);
        Port (  I0 : in STD_LOGIC_VECTOR (dataWidth-1 downto 0);
                I1 : in STD_LOGIC_VECTOR (dataWidth-1 downto 0);
                I2 : in STD_LOGIC_VECTOR (dataWidth-1 downto 0);
                I3 : in STD_LOGIC_VECTOR (dataWidth-1 downto 0);
                S : in STD_LOGIC_VECTOR (1 downto 0);
                Y : out STD_LOGIC_vector (dataWidth-1 downto 0));
    end component;
    
    signal I : std_logic_vector (7 downto 0) := (others=>'0');
    signal S : std_logic_vector (1 downto 0) := (others=>'0');
    signal Y : std_logic_vector (1 downto 0) := (others=>'0');

begin
    uut: mux
    generic map(dataWidth => 2)
    port map (
        I0 => I(1 downto 0),
        I1 => I(3 downto 2),
        I2 => I(5 downto 4),
        I3 => I(7 downto 6),
        S => S,
        Y => Y
        );

    --  Test predicted outputs
process
type pattern_type is record
--  The inputs of the reg.
    i: std_logic_vector (7 downto 0);
	s: std_logic_vector (1 downto 0);
--  The expected outputs of the reg.
	y: std_logic_vector (1 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("11000110", "00", "10"),
("11000110", "11", "11"),
("11000110", "10", "00"),
("11000110", "01", "01"));
begin
--  Check each pattern.
	for n in patterns'range loop
--  Set the inputs.
		i <= patterns(n).i;
		s <= patterns(n).s;
--  Wait for the results.
		wait for 1 ns;
--  Check the outputs.
		assert y = patterns(n).y
		report "bad output value" severity error;
	end loop;
	assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
	wait;
end process;
end Behavioral;
