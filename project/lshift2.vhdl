library ieee;
use ieee.std_logic_1164.all;

entity lshift2 is
    port (d_in : in std_logic_vector(26 downto 0);
        d_out : out std_logic_vector(28 downto 0));
end entity lshift2;

architecture behav of lshift2 is
begin
    d_out <= d_in & "00";
end architecture behav;
