ghdl -a BancoRegs/reg18bit.vhd
ghdl -e reg18bit
ghdl -a BancoRegs/banco_regs.vhd
ghdl -e banco_regs
ghdl -a BancoRegs/reg18bit_tb.vhd
ghdl -e reg18bit_tb
ghdl -a BancoRegs/banco_regs_tb.vhd
ghdl -e banco_regs_tb
ghdl -r banco_regs_tb --wave=banco_regs_tb.ghw