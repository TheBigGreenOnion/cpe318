library ieee;
use ieee.std_logic_1164.all;
use ieee.std_numeric.all;

entity clk_dpath is
    port (a, b, c, d, e : in unsigned (15 downto 0);
        z : out unsigned (31 downto 0));
end entity clk_dpath;

architecture behavioral of clk_dpath is
signal clk, clk1, clk2, clk3 : std_logic;
signal in1, in2 : std_logic_vector (15 downto 0) := (others => '0');
signal sum_out, sum_temp : unsigned (31 downto 0) := (others => '0');

begin

    sum_temp <= in1 * in2;
    

    stage1mult : process(clk)
    begin
        if (rising_edge(clk)) then
            if (sel(0) = '1') then
                in1 <= a;
                in2 <= b;
            elsif (sel(1) = '1') then
                in1 <= c;
                in2 <= d;
            elsif (sel(2) = '1') then
                in1 <= e;
                in2 <= f;
            end if;
        end if;
    end process stage1mult


    stage2add : process(clk)
    begin
        if (rising_edge(clk)) then
            

        end if;
    end process stage2add


    stag3mult : process(clk)
    begin
        if (rising_edge(clk)) then
            

        end if;
    end process stage1mult
