library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
    port (a, b : in std_logic_vector(31 downto 0);
        sel : in std_logic;
        output : out std_logic_vector(31 downto 0));
end entity mux2;

architecture behav of mux2 is
begin
    output <= a when sel = '0' else
              b when sel = '1' else
              x"00000000";
end architecture behav;
