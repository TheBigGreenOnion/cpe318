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
        pc_dest => s_pc_jmp,
        pc_en => s_jmp_en,
        pc_addr => s_pc_addr,
        clk => pc_clk
    );

    code : code_mem
    port map (
        read_addr => s_read_addr,
        data_out => s_instruction
    );

    data : data_mem
    port map (
        read_addr => s_read_addr,
        write_addr => s_write_addr,
        read_en => s_read_en,
        write_en => s_write_en,
        clk => clk,
        d_in => ram_write_data
    );
    
    regfile1 : regfile
    port map (
        read_addr => s_reg_read_addr,
        write_addr => s_reg_write_addr,
    );

    
