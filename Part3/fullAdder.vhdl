library ieee;
use ieee.std_logic_1164.all;

entity fullAdder is
    Port (  A,B,Cin: in std_logic;
            O, Cout: out std_logic
            );
end fullAdder;

architecture behavioral of fullAdder is

begin

    O <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and A) or (Cin and B);

end behavioral;