library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
    port ( pc_write_cond, pc_write, pc_source : out std_logic;
        mem_addr, mem_read, mem_write, mem_toreg : out std_logic;
        reg_writeinst, reg_dest, reg_write : out std_logic;
        alu_src_a, alu_src_b : out std_logic;
        alu_op : out std_logic_vector(1 downto 0);
        inst : in std_logic_vector(5 downto 0));
end entity control;

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



