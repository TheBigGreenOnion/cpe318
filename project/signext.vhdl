library ieee;
use ieee.std_logic_1164.all;

entity signext is
    port (d_in : in std_logic_vector(15 downto 0);
          d_out : out std_logic_vector(33 downto 0));
end entity signext;

architecture behav of signext is
begin
    -- Sign extend and lshift by 2. Won't lose any valuable bits from shifting
    -- sign extended 16 bit number.
    d_out <= (x"FFFF" & d_in & "00") when d_in(15) = '1' else
             (x"0000" & d_in & "00");
end architecture behav;
