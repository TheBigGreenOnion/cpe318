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
    regfile1 : regfile
    port map (
    );

    
alu1 : alu
alu_control1 : alu_control
control_unit1 : control_unit
datapath1 : datapath
inst_reg1 : inst_reg
lshift2 : lshift2
mux2
mux4
program_counter1 : program_counter
ram1 : ram
regfile1 : regfile
rom1 : rom
signext : signext
