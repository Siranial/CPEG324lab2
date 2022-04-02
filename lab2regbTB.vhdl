library ieee;
use ieee.std_logic_1164.all;


entity regb_tb is
end regb_tb;

architecture behav of regb_tb is
--  Declaration of the component that will be instantiated.
component reg0
    port(	
        I:	in std_logic_vector (3 downto 0); -- for loading
        clock:		in std_logic; -- rising-edge triggering 
        enable:		in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	out std_logic_vector(3 downto 0) -- output the current register content. 
    );
end component;

component reg1
    port(	
        I:	in std_logic_vector (3 downto 0); -- for loading
        clock:		in std_logic; -- rising-edge triggering 
        enable:		in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	out std_logic_vector(3 downto 0) -- output the current register content. 
    );
end component;

component reg2
    port(	
        I:	in std_logic_vector (3 downto 0); -- for loading
        clock:		in std_logic; -- rising-edge triggering 
        enable:		in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	out std_logic_vector(3 downto 0) -- output the current register content. 
    );
end component;

component reg3
    port(	
        I:	in std_logic_vector (3 downto 0); -- for loading
        clock:		in std_logic; -- rising-edge triggering 
        enable:		in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	out std_logic_vector(3 downto 0) -- output the current register content. 
    );
end component;

component reg4
    port(	
        I:	in std_logic_vector (3 downto 0); -- for loading
        clock:		in std_logic; -- rising-edge triggering 
        enable:		in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	out std_logic_vector(3 downto 0) -- output the current register content. 
    );
end component;

component reg5
    port(	
        I:	in std_logic_vector (3 downto 0); -- for loading
        clock:		in std_logic; -- rising-edge triggering 
        enable:		in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	out std_logic_vector(3 downto 0) -- output the current register content. 
    );
end component;

component reg6
    port(	
        I:	in std_logic_vector (3 downto 0); -- for loading
        clock:		in std_logic; -- rising-edge triggering 
        enable:		in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	out std_logic_vector(3 downto 0) -- output the current register content. 
    );
end component;

component reg7
    port(	
        I:	in std_logic_vector (3 downto 0); -- for loading
        clock:		in std_logic; -- rising-edge triggering 
        enable:		in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	out std_logic_vector(3 downto 0) -- output the current register content. 
    );
end component;

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
    
    -- Selector bits
    signal S : std_logic_vector (2 downto 0) := (others=>'0');
    -- Flip flop enabler
    signal E : std_logic := '0';
    -- Wires that connect demux to registers
    signal Y0 : std_logic_vector (3 downto 0) := (others=>'0');
    signal Y1 : std_logic_vector (3 downto 0) := (others=>'0');
    signal Y2 : std_logic_vector (3 downto 0) := (others=>'0');
    signal Y3 : std_logic_vector (3 downto 0) := (others=>'0');
    signal Y4 : std_logic_vector (3 downto 0) := (others=>'0');
    signal Y5 : std_logic_vector (3 downto 0) := (others=>'0');
    signal Y6 : std_logic_vector (3 downto 0) := (others=>'0');
    signal Y7 : std_logic_vector (3 downto 0) := (others=>'0');
    -- Output signals from registers
    signal O0 : std_logic_vector (3 downto 0) := (others=>'0');
    signal O1 : std_logic_vector (3 downto 0) := (others=>'0');
    signal O2 : std_logic_vector (3 downto 0) := (others=>'0');
    signal O3 : std_logic_vector (3 downto 0) := (others=>'0');
    signal O4 : std_logic_vector (3 downto 0) := (others=>'0');
    signal O5 : std_logic_vector (3 downto 0) := (others=>'0');
    signal O6 : std_logic_vector (3 downto 0) := (others=>'0');
    signal O7 : std_logic_vector (3 downto 0) := (others=>'0');

--  Specifies which entity is bound with the component.
-- Input signal;
signal i, o : std_logic_vector(3 downto 0) := (others=>'0');
signal clk, enable : std_logic;
begin
--  Component instantiation.
demux8: demux8 port map (I => i, S => S, Y0 => Y0, Y1 => Y1, Y2 => Y2, 
                        Y3 => Y3, Y4 => Y4, Y5 => Y5, Y6 => Y6, Y7 => Y7);
reg0: reg port map (I => Y0, clock => clk, enable => enable, O => O0);
reg1: reg port map (I => Y1, clock => clk, enable => enable, O => O1);
reg2: reg port map (I => Y2, clock => clk, enable => enable, O => O2);
reg3: reg port map (I => Y3, clock => clk, enable => enable, O => O3);
reg4: reg port map (I => Y4, clock => clk, enable => enable, O => O4);
reg5: reg port map (I => Y5, clock => clk, enable => enable, O => O5);
reg6: reg port map (I => Y6, clock => clk, enable => enable, O => O6);
reg7: reg port map (I => Y7, clock => clk, enable => enable, O => O7);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the reg.
	i: std_logic_vector (3 downto 0);
    s: std_logic_vector (2 downto 0);
	clock, enable: std_logic;
--  The expected outputs of the reg.
	o: std_logic_vector (3 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("0001", "000", '0', '1', "0000"),
("0001", "000", '1', '1', "0001")); -- Need two vectors to simulate an edge.
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
