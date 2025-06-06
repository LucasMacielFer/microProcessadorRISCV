#!/bin/bash

# --- Compilation and Simulation for banco_regs_tb ---
echo "Compiling and elaborating banco_regs_tb..."
# Assuming reg14bit or reg16bit is used in banco_regs_tb if reg18bit doesn't exist
# You need to decide which one is actually used by banco_regs or reg18bit_tb
ghdl -a BancoRegs/reg14bit.vhd || { echo "Error: ghdl -a BancoRegs/reg14bit.vhd failed"; exit 1; }
ghdl -e reg14bit || { echo "Error: ghdl -e reg14bit failed"; exit 1; }
# OR
# ghdl -a BancoRegs/reg16bit.vhd || { echo "Error: ghdl -a BancoRegs/reg16bit.vhd failed"; exit 1; }
# ghdl -e reg16bit || { echo "Error: ghdl -e reg16bit failed"; exit 1; }

ghdl -a BancoRegs/banco_regs.vhd || { echo "Error: ghdl -a BancoRegs/banco_regs.vhd failed"; exit 1; }
ghdl -e banco_regs || { echo "Error: ghdl -e banco_regs failed"; exit 1; }
ghdl -a BancoRegs/reg14bit_tb.vhd || { echo "Error: ghdl -a BancoRegs/reg14bit_tb.vhd failed"; exit 1; } # This testbench likely uses a reg component, verify its size
ghdl -e reg18bit_tb || { echo "Error: ghdl -e reg18bit_tb failed"; exit 1; }
ghdl -a BancoRegs/banco_regs_tb.vhd || { echo "Error: ghdl -a BancoRegs/banco_regs_tb.vhd failed"; exit 1; }
ghdl -e banco_regs_tb || { echo "Error: ghdl -e banco_regs_tb failed"; exit 1; }
echo "Running banco_regs_tb simulation and generating waveform..."
ghdl -r banco_regs_tb --wave=banco_regs_tb.ghw || { echo "Error: ghdl -r banco_regs_tb failed"; exit 1; }
echo "banco_regs_tb simulation complete."

echo ""
echo "----------------------------------------------------"
echo ""

# --- Compilation and Simulation for Top_Level_tb ---
echo "Compiling and elaborating Top_Level_tb..."
ghdl -a ULA/ULA.vhd || { echo "Error: ghdl -a ULA/ULA.vhd failed"; exit 1; }
ghdl -e ULA || { echo "Error: ghdl -e ULA failed"; exit 1; }
ghdl -a BancoRegs/reg16bit.vhd || { echo "Error: ghdl -a BancoRegs/reg16bit.vhd failed"; exit 1; }
ghdl -e reg16bit || { echo "Error: ghdl -e reg16bit failed"; exit 1; }
ghdl -a BancoRegs/banco_regs.vhd || { echo "Error: ghdl -a BancoRegs/banco_regs.vhd failed"; exit 1; }
ghdl -e banco_regs || { echo "Error: ghdl -e banco_regs failed"; exit 1; }
ghdl -a BancoRegs/reg14bit.vhd || { echo "Error: ghdl -a BancoRegs/reg14bit.vhd failed"; exit 1; }
ghdl -e reg14bit || { echo "Error: ghdl -e reg14bit failed"; exit 1; }
ghdl -a UC/Control_Unit.vhd || { echo "Error: ghdl -a UC/Control_Unit.vhd failed"; exit 1; }
ghdl -e Control_Unit || { echo "Error: ghdl -e Control_Unit failed"; exit 1; }
ghdl -a Memo/ROM.vhd || { echo "Error: ghdl -a Memo/ROM.vhd failed"; exit 1; }
ghdl -e ROM || { echo "Error: ghdl -e ROM failed"; exit 1; }
ghdl -a PC/reg14bit.vhd || { echo "Error: ghdl -a PC/reg14bit.vhd failed"; exit 1; } # Changed from reg18bit to reg14bit, verify correct size for PC
ghdl -e reg14bit || { echo "Error: ghdl -e reg14bit failed"; exit 1; }
ghdl -a PC/soma1.vhd || { echo "Error: ghdl -a PC/soma1.vhd failed"; exit 1; }
ghdl -e soma1 || { echo "Error: ghdl -e soma1 failed"; exit 1; }
ghdl -a State_Machine/Maq_estados.vhd || { echo "Error: ghdl -a State_Machine/Maq_estados.vhd failed"; exit 1; }
ghdl -e Maq_estados || { echo "Error: ghdl -e Maq_estados failed"; exit 1; }
ghdl -a Top_Level.vhd || { echo "Error: ghdl -a Top_Level.vhd failed"; exit 1; }
ghdl -e Top_Level || { echo "Error: ghdl -e Top_Level failed"; exit 1; }
ghdl -a Top_Level_tb.vhd || { echo "Error: ghdl -a Top_Level_tb.vhd failed"; exit 1; }
ghdl -e Top_Level_tb || { echo "Error: ghdl -e Top_Level_tb failed"; exit 1; }
echo "Running Top_Level_tb simulation and generating waveform..."
ghdl -r Top_Level_tb --wave=Top_Level_tb.ghw || { echo "Error: ghdl -r Top_Level_tb failed"; exit 1; }
echo "Top_Level_tb simulation complete."

echo ""
echo "All GHDL operations completed successfully!"