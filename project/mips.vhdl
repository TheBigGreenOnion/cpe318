library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.lib_mips32.all;

entity mips is
    port (clk, someothershit : std_logic);
end entity mips;

architecture structural of mips is
     -- System-wide signals
    signal g_clk : std_logic;
    signal g_rst : std_logic;
    
    -- ALU Bundles 
    signal b_alu_a : std_logic_vector(31 downto 0);
    signal b_alu_b : std_logic_vector(31 downto 0);
    signal b_alu_out : std_logic_vector(31 downto 0);
   
    --ALU Signals 
    signal c_alu_op : std_logic_vector(2 downto 0);
    signal c_alu_src_a : std_logic;
    signal c_alu_src_b : std_logic_vector(1 downto 0);
    signal c_alu_zero : std_logic;
  
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

    signal b_opcode : std_logic_vector(5 downto 0);
    signal b_pc_dest : std_logic_vector(31 downto 0);
    signal b_pc_addr : std_logic_vector(31 downto 0);
    signal b_rom_inst : std_logic_vector(31 downto 0);
        

    -- Components
    component alu
        port (a,b : in std_logic_vector(31 downto 0);
    --        op : in std_logic_vector(XXX downto 0);
            result : out std_logic_vector(31 downto 0);
            zf : out std_logic);
    end component alu;
    
   
    component mux2 
        port (a, b : in std_logic_vector(31 downto 0);
            sel : in std_logic;
            output : out std_logic_vector(31 downto 0));
    end component mux2;
    
    component mux4 
        port (a, b, c, d : in std_logic_vector(31 downto 0);
            sel : in std_logic_vector(1 downto 0);
            output : out std_logic_vector(31 downto 0));
    end component mux4;
    
    component program_counter 
        port (pc_dest : in std_logic_vector (31 downto 0);
            clk, pc_en, rst : in std_logic;
            pc_addr : out std_logic_vector(31 downto 0));
    end component program_counter;

    component code_mem 
        port (read_addr : in std_logic_vector (31 downto 0);
            en, clk : in std_logic;
            d_out : out std_logic_vector(31 downto 0));
    end component code_mem;

    component control 
        port ( pc_write_cond, pc_write : out std_logic;
        mem_to_reg, mem_write, mem_read : out std_logic;
        ir_write, reg_dest, reg_write : out std_logic;
        alu_src_a : out std_logic;
        alu_src_b, pc_src : out std_logic_vector(1 downto 0);
        alu_op : out std_logic_vector(2 downto 0);
        opcode : in std_logic_vector(5 downto 0);
        clk : in std_logic);
    end component control;

begin
    -- Component instances
    alu1 : alu
    port map (
        a => b_alu_a,
        b => b_alu_b,
        result => b_alu_out,
        zf => c_alu_zero
    );

    control1 : control
    port map (
        clk => g_clk,
        opcode => b_opcode,
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

    program_counter1 : program_counter
    port map (
        clk => g_clk,
        rst => g_rst,
        pc_en => c_pc_write,
        pc_dest => b_pc_dest,
        pc_addr => b_pc_addr 
    );

    rom1 : code_mem
    port map (
       clk => g_clk,
       en => c_mem_en,
       read_addr => b_pc_addr,
       d_out => b_rom_inst
    );

    mux2_alu_a : mux2
    port map (
        a => b_pc_addr,
        b => Zero32, -- reg a
        sel => c_alu_src_a,
        output => b_alu_a
    );

    mux4_alu_b : mux4
    port map (
        a => Zero32, -- reg b
        b => x"00000004",
        c => Zero32,
        d => Zero32,
        sel => c_alu_src_b,
        output => b_alu_b
    );

    mux4_pc_src : mux4
    port map (
        a => b_alu_out,
        b => Zero32,    -- buffered alu out
        c => Zero32,    -- branch logic
        d => x"00000000",
        sel => c_pc_src,
        output => b_pc_dest
    );

end architecture;
