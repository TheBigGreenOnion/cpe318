library ieee;
use ieee.std_logic_1164.all;
use ieee.std_numeric.all;

entity clk_dpath is
    port (a, b, c, d, e : in unsigned (15 downto 0);
        z : out unsigned (31 downto 0);
end entity clk_dpath;

architecture behavioral of clk_dpath is
signal clk, clk1, clk2, clk3 : std_logic;
signal in1, in2 : std_logic_vector (15 downto 0) := (others => '0');
signal sum_out, sum_temp, prod_temp : unsigned (31 downto 0) := (others => '0');
signal sel : std_logic_vector (1 downto 0) := (others <= '0');
signal count : unsigned (4 downto 0) := (others => '0');

begin

    prod_temp <= in1 * in2;
    z <= sum_out;

    -- Mux for multiplicative elements
    stage1mult : process(clk)
    begin
        add_en <= '1';
        if (rising_edge(clk)) then
            if (sel = "00") then
                in1 <= a;
                in2 <= b;
            elsif (sel = "01") then
                in1 <= c;
                in2 <= d;
            elsif (sel = "10") then
                in1 <= e;
                in2 <= f;
            else
                in1 <= (others <= '0');
                in2 <= (others <= '0');
        end if;
    end process stage1mult


    stage2add : process(clk)
    begin
        if (rising_edge(clk)) then
            sum_temp <= prod_temp + sum_temp;
        end if;
        sum_out <= sum_temp;
    end process stage2add


    manage_clk : process(clk, a, b, c, d, e, f)
    begin
        if (rising_edge(clk)) then
            if (count = "0000") then
                sel <= "00";
            elsif (count = "0001") then
                sel <= "01";
            elsif (count = "0010") then
                sel <= "10"; 
            elsif (count = "0011") then 
                sel <= "11";
            end if;

            -- Detect change in one of the inputs
            if (a'event or b'event or c'event or d'event or e'event or f'event) then
                count <= "0000";
                sum_out <= (others => '0');
            end if;

            if (not (count(3) and count(2) and count(1) and count(0))) then
                count <= count + 1;
            end if;
        end if;
    end process manage_clk
