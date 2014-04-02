library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips is
    port (clk, someothershit : std_logic);
end entity mips;


architecture behav of mips is
    component derp 
        port map (derp);
    end component


    signal derp : std_logic;

begin
    pc : program_counter
    port map (
        pc_jmp => s_pc_jmp,
        pc_en => s_jmp_en,
        pc_addr => s_pc_addr,
        clk => pc_clk
    );

    
