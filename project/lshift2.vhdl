library ieee;
use ieee.std_logic_1164.all;

entity lshift2 is
generic n : integer;
    port (d_in : std_logic_vector(n downto 0);
        d_out : std_logic_vector(n+2 downto 0));
end entity shift;

architecture behav of lshift2 is
begin
    d_out <= d_in & "00";
end architecture behav;
