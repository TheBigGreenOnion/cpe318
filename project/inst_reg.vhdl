library ieee;
use ieee.std_logic_1164.all;

entity inst_reg is
    port (inst_in : in std_logic_vector(31 downto 0);
        ir_write, clk : in std_logic;
        inst_out : out std_logic_vector(31 downto 0));
end entity inst_reg;

architecture behav of inst_reg is
    signal inst : std_logic_vector(31 downto 0) := (others => '0');
begin
    inst_out <= inst;

    latch : process (clk, ir_write) 
    begin
        if (rising_edge(clk)) then
            if (ir_write = '1') then
                inst <= inst_in;
            end if;
        end if;
    end process latch;
end architecture behav;
