library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
    port ( pc_write_cond, pc_write, pc_source : out std_logic;
        mem_addr, mem_toreg : out std_logic;
        reg_writeinst, reg_dest, reg_write : out std_logic;
        alu_src_a : out std_logic;
        alu_op, alu_src_b : out std_logic_vector(1 downto 0);
        inst : in std_logic_vector(5 downto 0));
end entity control;


architecture behav of control is 
    signal s_pc_write_cond, s_pc_write, s_pc_source : std_logic;
    signal s_mem_addr, s_mem_toreg : std_logic;
    signal s_reg_writeinst, s_reg_dest, s_reg_write : std_logic;
    signal s_alu_src_a : std_logic;
    signal s_alu_op, s_alu_src_b : std_logic_vector(1 downto 0);

begin
    
    -- Combinational logic for control signals.
    signal_control : process
    begin
       s_reg_dest <= '0' when 

end architecture behav;


--PCWriteCond
--PCWrite
--PCSource
--MemAddr
--MemRead
--MemWrite
--MemToReg
--IRWrite
--RegDest
--RegWrite
--ALUOp
--ALUSrcA
--ALUSrcB



