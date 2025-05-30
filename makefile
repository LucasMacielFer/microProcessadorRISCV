ghdl -a BancoRegs/reg18bit.vhd
ghdl -e reg18bit
ghdl -a BancoRegs/banco_regs.vhd
ghdl -e banco_regs
ghdl -a BancoRegs/reg18bit_tb.vhd
ghdl -e reg18bit_tb
ghdl -a BancoRegs/banco_regs_tb.vhd
ghdl -e banco_regs_tb
ghdl -r banco_regs_tb --wave=banco_regs_tb.ghw

ghdl -a ULA/ULA.vhd
ghdl -e ULA
ghdl -a BancoRegs/reg16bit.vhd
ghdl -e reg16bit
ghdl -a BancoRegs/banco_regs.vhd 
ghdl -e banco_regs
ghdl -a BancoRegs/reg14bit.vhd 
ghdl -e reg14bit
ghdl -a UC/Control_Unit.vhd 
ghdl -e Control_Unit
ghdl -a Memo/ROM.vhd 
ghdl -e ROM
ghdl -a PC/reg1bit.vhd 
ghdl -e reg1bit
ghdl -a PC/soma1.vhd
ghdl -e soma1
ghdl -a State_Machine/Maq_estados.vhd 
ghdl -e Maq_estados
ghdl -a Top_Level.vhd 
ghdl -e Top_Level
ghdl -a Top_Level_tb.vhd 
ghdl -e Top_Level_tb
ghdl -r Top_Level_tb --wave=Top_Level_tb.ghw