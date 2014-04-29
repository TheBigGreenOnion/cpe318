library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips is
    port (clk, someothershit : std_logic);
end entity mips;

architecture structural of mips is
    component derp 
        port (derp);
    end component

    component alu 
        port (a,b : in std_logic_vector(31 downto 0);
            op : in std_logic_vector(XXX downto 0);
            result : out std_logic_vector(31 downto 0);
            zf : out std_logic);
    end component alu
    
    component alu_control 
        port (alu_op : in std_logic_vector(1 downto 0);
            fn : in std_logic_vector(5 downto 0);
            alu_ctrl : out std_logic_vector(3 downto 0));
    end component alu_control;
    
    component control 
        port ( pc_write_cond, pc_write, pc_source : out std_logic;
            mem_to_reg, mem_write, mem_read : out std_logic;
            ir_write, reg_dest, reg_write : out std_logic;
            alu_src_a : out std_logic;
            alu_op, alu_src_b : out std_logic_vector(1 downto 0);
            opcode : in std_logic_vector(5 downto 0);
            clk : in std_logic);
    end component control;
    
    component inst_reg 
        port (inst_in : in std_logic_vector(31 downto 0);
            ir_write, clk : in std_logic;
            inst_out : out std_logic_vector(31 downto 0));
    end component inst_reg;
    
    component lshift2 
        port (d_in : in std_logic_vector(26 downto 0);
            d_out : out std_logic_vector(28 downto 0));
    end component lshift2;
    
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

    component data_mem 
        port (read_addr, write_addr, d_in : in std_logic_vector(31 downto 0);
            d_out : out std_logic_vector(31 downto 0);
            write_en, read_en, clk : in std_logic);
    end component data_mem;

    component regfile 
        port (addr1, addr2, addr3 : in std_logic_vector (5 downto 0);
            write_data : in std_logic_vector(31 downto 0);
            out1, out2 : out std_logic_vector (31 downto 0);
            reg_write, clk : in std_logic);
    end component regfile;

    component code_mem 
        port (read_addr : in unsigned ();
            en, clk : in std_logic;
            d_out : out std_logic_vector(31 downto 0));
    end component code_mem;

    component signext 
        port (d_in : in std_logic_vector(15 downto 0);
          d_out : out std_logic_vector(31 downto 0));
    end component signext;


begin
    regfile1 : regfile
    port map (
    );

    program_counter1 : program_counter
    port map (s_pc_dest, clk, c_pc_en, rst, s_pc_addr
