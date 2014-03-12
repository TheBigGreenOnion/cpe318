library ieee;
use ieee.std_logic_1164.all;
use ieee.std_numeric.all;

entity mult16 is
begin
    port (x,y : in std_logic_vector(15 downto 0);
        y_load_in, y_ce, x_ce, p_reset, p_ce, clk : in std_logic;
        p : out std_logic_vector(31 downto 0));
end entity mult16;

architecture behavioral of mult16 is
signal p_low : std_logic_vector(14 downto 0) := (others => '0');
signal Qy_temp, Qx_temp, a, b : std_logic_vector(15 downto 0) := (others => '0');
signal sum, p_high, p_temp : std_logic_vector(16 downto 0) := (others => '0');
signal p_temp : std_logic_vector(31 downto 0) := (others => '0');

begin

    -- Combinational
    a <= (others => Qy_temp(0)) and Qx_temp;
    b <= p_temp(31 downto 16);

    sum <= to_unsigned(a) + to_unsigned(b);
    p_temp <= p_high & p_low;
    p <= p_temp;
    -- End Combinational


    xregister : process (clk)
    begin
        if (rising_edge(clk)) then
            if (x_ce = '1') then
                Qx_temp <= x;
            end if;
        end if;
    end process xregister;

    yshift : process (clk)
    begin
        if (rising_edge(clk)) then
            if (y_ce = '1') then
                if (y_load_in = '1') then
                    Qy_temp <= y;
                else
                    Qy_temp <= '0' & Qy_temp(14 downto 0);
                end if;
            end if;
        end if;
    end process yshift;

    pregister : process (clk)
    begin
        if rising_edge(clk) then
            if (p_ce = '1') then
                if (p_reset = '1') then
                    p_high <= (others => '0');
                else
                    p_high <= sum;
            end if;
        end if;
    end process sregister; 

    pshift : process (clk)
    begin
        if (rising_edge(clk)) then
            if (p_ce = '1') then
                if (p_reset = '1') then
                    p_low <= (others => '0');
                else
                    p_temp <= p_low & p_high(0);
                    p_low <= p_temp(14 downto 0);
                end if;
            end if;
        end if;
    end process pshift;

end architecture behavioral;

