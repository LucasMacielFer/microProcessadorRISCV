# Limpeza de compilações anteriores (opcional, mas recomendado para evitar resíduos)
ghdl --clean

# --- Compilação de todos os arquivos VHDL ---
# A ordem de compilação (-a) geralmente não é tão crítica,
# mas é bom compilar as dependências de baixo nível primeiro.
# Por exemplo, reg16bit antes de banco_regs se banco_regs usar reg16bit.

# -- Banco Regs --
ghdl -a BancoRegs/reg14bit.vhd
ghdl -a BancoRegs/reg16bit.vhd
ghdl -a BancoRegs/banco_regs.vhd # Compile banco_regs depois dos regs se ele os instanciar

# -- Memo --
ghdl -a Memo/ROM.vhd

# -- PC --
ghdl -a PC/reg7bit.vhd
ghdl -a PC/soma1.vhd
ghdl -a PC/somador7bit.vhd

# -- State_Machine --
ghdl -a State_Machine/one_shot_FF.vhd
ghdl -a State_Machine/Maq_estados.vhd # Compile Maq_estados depois de one_shot_FF se usar

# -- UC --
ghdl -a UC/Control_Unit.vhd

# -- ULA --
ghdl -a ULA/reg1bit.vhd
ghdl -a ULA/ULA.vhd # Compile ULA depois de reg1bit se usar

# --- Arquivos principais do processador e testbench ---
ghdl -a processador.vhd
ghdl -a processador_tb.vhd # Compile o testbench por último (ou após tudo que ele instancia)

echo "Compiling and elaborating Top_Level_tb..."

# --- Elaboração apenas do Testbench ---
# O GHDL vai resolver toda a hierarquia a partir do testbench.
ghdl -e processador_tb || { echo "Error: ghdl -e processador_tb failed"; exit 1; }

echo "Running processador_tb simulation and generating waveform..."
ghdl -r processador_tb --wave=processador_tb.ghw || { echo "Error: ghdl -r processador_tb failed"; exit 1; }

echo "processador_tb simulation complete."

echo ""
echo "All GHDL operations completed successfully!"