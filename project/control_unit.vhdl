library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips32.all;

entity control is
    port ( pc_write_cond, pc_write, pc_source : out std_logic;
        mem_to_reg, mem_write, mem_read : out std_logic;
        ir_write, reg_dest, reg_write : out std_logic;
        alu_src_a : out std_logic;
        alu_op, alu_src_b : out std_logic_vector(1 downto 0);
        opcode : in std_logic_vector(5 downto 0);
        clk : in std_logic);
end entity control;


architecture behav of control is 
    signal s_pc_write_cond, s_pc_write, s_pc_src : std_logic;
    signal s_mem_addr, s_mem_toreg, s_mem_write : std_logic;
    signal s_reg_writeinst, s_reg_dest, s_reg_write : std_logic;
    signal s_alu_src_a, s_ir_write : std_logic;
    signal s_alu_op, s_alu_src_b : std_logic_vector(1 downto 0);
    
    type state is (state0, state1, state2, state3, state4);
    type inst is (R, I, J, B);
    type memaccess is (load, store, none);

    signal clkstate : state;
    signal itype : inst;
    signal memwb : memaccess;
begin

    state_tbl : process (clk) 
    begin
        if (rising_edge(clk)) then
            if (clkstate = state0) then
                clkstate <= state1;
            elsif (clkstate = state1) then
                clkstate <= state2;
            elsif (clkstate = state2) then
                clkstate <= state3;
            elsif (clkstate = state3) then
                clkstate <= state4;
            elsif (clkstate = state4) then
                clkstate <= state0;
            else
                clkstate <= state0;
            end if;
        end if;
    end process state_tbl;


    -- Combinational logic for control signals.
    control : process(clk, clkstate, itype, memwb) 
    begin
        if (rising_edge(clk)) then
            -- Instruction Read
            if (clkstate = state0) then
                s_alu_src_a <= '0';
                s_alu_src_b <= "01";
                s_alu_op <= "000";
                
                s_pc_write <= '1';
                s_pc_src <= '0';
                
                s_ir_write <= '1';

            -- Decode
            elsif (clkstate = state1) then
                s_ir_write <= '0';
                s_reg_write <= '0';

                -- set reg_dest based on instruction type
                s_reg_dest <= '1' when itype = B or itype = R else '0';

            -- Execute
            elsif (clkstate = state2) then
                s_alu_src_a <= '1' when itype = I or itype = R else '0';
                
                s_alu_src_b <= "00" when itype = R else
                               --01
                               "10" when itype = I else
                               "11";

                s_alu_op <= "000" when add else
                            "001" when sub else     --slt
                            "010" when opcode = "001100" else   -- andi
                            "011" when opcode = "001101" else   -- ori
                            "100" when opcode = "001110" else   -- xori
                            "111" when itype = R or itype = B;

            -- Writeback
            elsif (clkstate = state3) then
                s_pc_src <= "10" when itype = J else
                            "01" when others;
                -- 00 reserved for automatic PC increment

                s_pc_write_cond <= '1' when itype = B else '0';
                
                s_pc_write <= '1' when (itype = B or itype = J) else '0';

                s_mem_read <= '1' when memwb = load else '0';
                s_mem_write <= '1' when memwb = store else '0';

            -- RegWrite
            elsif (clkstate = state4) then
                s_mem_to_reg <= '1' when memwb = load else '0';
            end if;
        end if;
    end process;

end architecture behav;

