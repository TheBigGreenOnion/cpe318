-- Main MIPS datapath
-- NEEDS MOAR ABSTRACTION but whatevs for now

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.lib_mips32.all;

entity mips is
    port (clk, rst : in std_logic;
         seg_0, seg_1, seg_2, seg_3, seg_4, seg_5, seg_6, seg_7 : out std_logic_vector(6 downto 0));
end entity mips;

architecture structural of mips is
     -- System-wide signals
    alias g_clk : std_logic is clk;
    alias g_rst : std_logic is rst;
    signal g_instruction : std_logic_vector(31 downto 0);

    -- Global instruction defines
    alias g_opcode : std_logic_vector(5 downto 0)  is g_instruction(31 downto 26);
    alias g_rs     : std_logic_vector(4 downto 0)  is g_instruction(25 downto 21);
    alias g_rt     : std_logic_vector(4 downto 0)  is g_instruction(20 downto 16);
    alias g_rd     : std_logic_vector(4 downto 0)  is g_instruction(15 downto 11);
    alias g_shamt  : std_logic_vector(4 downto 0)  is g_instruction(10 downto 6);
    alias g_fn     : std_logic_vector(5 downto 0)  is g_instruction(5 downto 0);
    alias g_imm    : std_logic_vector(15 downto 0) is g_instruction(15 downto 0);
    alias g_jump   : std_logic_vector(25 downto 0) is g_instruction(25 downto 0); 
    
    -- ALU Bundles 
    signal b_alu_a  : std_logic_vector(31 downto 0);
    signal b_alu_b  : std_logic_vector(31 downto 0);
    signal b_alu_out: std_logic_vector(31 downto 0);
    signal b_alu_unbuff : std_logic_vector(31 downto 0);
   
    --ALU Signals 
    signal c_alu_op : std_logic_vector(2 downto 0);
    signal c_alu_src_a : std_logic;
    signal c_alu_src_b : std_logic_vector(1 downto 0);
    signal c_alu_zero : std_logic;
    signal c_alu_ctrl : std_logic_vector(4 downto 0);

    signal b_alu_b1 : std_logic_vector(31 downto 0) ;
    signal b_alu_b2 : std_logic_vector(31 downto 0);
    signal b_alu_b3 : std_logic_vector(31 downto 0);

    signal b_pc_jmp : std_logic_vector(31 downto 0);

    -- General control signals  
    signal c_pc_write_cond : std_logic;
    signal c_pc_write : std_logic;
    signal c_pc_src : std_logic_vector(1 downto 0);
    signal c_mem_to_reg : std_logic;
    signal c_mem_write : std_logic;
    signal c_mem_read : std_logic;
    signal c_ir_write : std_logic;
    signal c_reg_dest : std_logic;
    signal c_reg_write : std_logic;
    signal c_mem_en : std_logic;

    -- Various intermediary bundles
    signal b_pc_dest : std_logic_vector(31 downto 0);
    signal b_pc_addr : std_logic_vector(31 downto 0);
    signal b_rom_inst : std_logic_vector(31 downto 0);
    signal b_rw_data : std_logic_vector(31 downto 0); -- writeback data
    signal b_rw : std_logic_vector(4 downto 0);
    signal b_regdat1 : std_logic_vector(31 downto 0);
    signal b_regdat2 : std_logic_vector(31 downto 0);
    signal b_ram_data : std_logic_vector(31 downto 0);
    signal b_seg_in : std_logic_vector(31 downto 0);

begin
    -- Component instances
    alu1 : entity work.alu
        port map (
            a => b_alu_a,
            b => b_alu_b,
            clk => g_clk,
            ctrl => c_alu_ctrl,
            shamt => g_shamt,
            result => b_alu_out,
            res_unbuff => b_alu_unbuff,
            branch_condition => c_alu_zero
        );

    alu_control1 : entity work.alu_control
        port map (
           alu_op => c_alu_op,
           fn => g_fn,
           alu_ctrl => c_alu_ctrl
        );

    control1 : entity work.control
        port map (
            clk => g_clk,
            rst => g_rst,
            opcode => g_opcode,
            pc_write_cond => c_pc_write_cond,
            pc_write => c_pc_write,
            pc_src => c_pc_src,
            mem_to_reg => c_mem_to_reg,
            mem_write => c_mem_write,
            mem_read => c_mem_read,
            alu_op => c_alu_op,
            alu_src_a => c_alu_src_a,
            alu_src_b => c_alu_src_b,
            ir_write => c_ir_write,
            reg_dest => c_reg_dest,
            reg_write => c_reg_write
        );

    program_counter1 : entity work.program_counter
        port map (
            clk => g_clk,
            rst => g_rst,
            pc_en => c_pc_write,
            pc_dest => b_pc_dest,
            pc_addr => b_pc_addr 
        );

    rom1 : entity work.code_mem
        port map (
           clk => g_clk,
           en => c_mem_en,
           read_addr => b_pc_addr,
           d_out => b_rom_inst
        );

    inst_reg1 : entity work.inst_reg
        port map (
            clk => g_clk,
            inst_in => b_rom_inst,
            inst_out => g_instruction,
            ir_write => c_ir_write
        );

    mux2_regwrite : entity work.mux2
        generic map (n => 5)
        port map (
            a => g_rt,
            b => g_rd,
            sel => c_reg_dest,
            output => b_rw
        );

    mux2_regdata : entity work.mux2
    generic map (n => 32)
        port map (
            a => b_alu_out,
            b => b_ram_data,
            sel => c_mem_to_reg,
            output => b_rw_data
        );

    regfile1 : entity work.regfile
        port map (
            clk => g_clk,
            rst => g_rst,
            reg_write => c_reg_write,
            write_data => b_rw_data,
            addr1 => g_rs,
            addr2 => g_rt,
            addr3 => b_rw,
            out1 => b_regdat1,
            out2 => b_regdat2
        );

    signext1 : entity work.signext
        port map (
            d_in => g_imm,
            d_out => b_alu_b2, 
            d_out_sl2 => b_alu_b3
        );

    mux2_alu_a : entity work.mux2
        generic map (n => 32)
        port map (
            a => b_pc_addr,
            b => b_regdat1, -- reg a
            sel => c_alu_src_a,
            output => b_alu_a
        );

    mux4_alu_b : entity work.mux4
        generic map (n => 32)
        port map (
            a => b_regdat2, -- reg b
            b => x"00000004",
            c => b_alu_b2,
            d => b_alu_b3,
            sel => c_alu_src_b,
            output => b_alu_b
        );

    -- PC JMP calculation
    b_pc_jmp <= b_pc_addr(31 downto 28) & g_jump & "00";

    mux4_pc_src : entity work.mux4
        generic map (n => 32)
        port map (
            a => b_alu_unbuff,
            b => b_alu_out,        -- buffered alu out
            c => b_pc_jmp,      -- branch logic
            d => Zero32,
            sel => c_pc_src,    -- default 0
            output => b_pc_dest
        );

    ram1 : entity work.data_mem
        port map( 
           ram_addr => b_alu_out,
           d_in => b_regdat2,
           d_out => b_ram_data,
           write_en => c_mem_write,
           read_en => c_mem_read,
           clk => g_clk,
           rst => g_rst
       );


    seg7word1 : entity work.seg7word
        port map (
            d_in => b_seg_in,
            seg_0 => seg_0,
            seg_1 => seg_1,
            seg_2 => seg_2,
            seg_3 => seg_3,
            seg_4 => seg_4,
            seg_5 => seg_5,
            seg_6 => seg_6,
            seg_7 => seg_7
        );

end architecture;
