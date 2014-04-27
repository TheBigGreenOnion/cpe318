library ieee;
use ieee.std_logic_1164.all;

entity signext is
    port (d_in : in std_logic_vector(15 downto 0);
          d_out : out std_logic_vector(31 downto 0));
end entity signext

architecture behav of signext is
begin
    d_out <= (others => d_in(15)) & d_in;
end architecture behav;
