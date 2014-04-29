library ieee;
use ieee.std_logic_1164.all;

entity detector is
    port ( stream, clk : in std_logic;
            detect : out std_logic);

end entity;

architecture detect101 of detector is
    signal mem : std_logic_vector(2 downto 0);
begin
    
    detect <= '1' when (mem = "101") else
              '0' when others;

    shift : process (clk)
    begin
        if rising_edge(clk) then
            if (mem = "000" or mem = "010") then
                mem <= mem(1 downto 0) & stream when (stream = '1') else
                       "000" when others;
            elsif (mem = "001") then
                mem <= mem(1 downto 0) & stream when (stream = '0') else
                       "000" when others;
            end if;
        end if;
    end process shift;
end architecture detect101;


architecture detect111 of detector is
    signal mem : std_logic_vector(2 downto 0);
begin
    detect <= '1' when (mem = "111") else
              '0' when others;

    shift : process (clk)
    begin
        if rising_edge(clk) then
            if (mem = "000" or mem="001" or mem="011") then
                mem <= mem(1 downto 0) & stream when (stream = '1') else
                       "000" when others;
            end if;
        end if;
    end process shift;
end architecture detect111;

