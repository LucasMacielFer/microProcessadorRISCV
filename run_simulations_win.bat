Claro, aqui está o script convertido para o formato de arquivo em lote do Windows (.bat).

Este script realiza as mesmas operações de limpeza, compilação, elaboração e simulação que o seu script shell, mas com a sintaxe correta para o Prompt de Comando do Windows.

DOS

@echo off
:: Limpeza de compilações anteriores (opcional, mas recomendado para evitar resíduos)
echo Limpando compilacoes anteriores...
ghdl --clean

:: --- Compilação de todos os arquivos VHDL ---
:: A ordem de compilação (-a) geralmente não é tão crítica,
:: mas é bom compilar as dependências de baixo nível primeiro.
:: Por exemplo, reg16bit antes de banco_regs se banco_regs usar reg16bit.

echo Compilando arquivos VHDL...

:: -- Banco Regs --
ghdl -a BancoRegs/reg14bit.vhd
ghdl -a BancoRegs/reg16bit.vhd
ghdl -a BancoRegs/banco_regs.vhd

:: -- Memo --
ghdl -a Memo/ROM.vhd

:: -- PC --
ghdl -a PC/reg7bit.vhd
ghdl -a PC/soma1.vhd
ghdl -a PC/somador7bit.vhd

:: -- State_Machine --
ghdl -a State_Machine/one_shot_FF.vhd
ghdl -a State_Machine/Maq_estados.vhd

:: -- UC --
ghdl -a UC/Control_Unit.vhd

:: -- ULA --
ghdl -a ULA/reg1bit.vhd
ghdl -a ULA/ULA.vhd

:: --- Arquivos principais do processador e testbench ---
ghdl -a processador.vhd
ghdl -a processador_tb.vhd

echo.
echo Compilando e elaborando o Testbench...

:: --- Elaboração apenas do Testbench ---
:: O GHDL vai resolver toda a hierarquia a partir do testbench.
ghdl -e processador_tb
ghdl -r processador_tb --wave=processador_tb.ghw


echo Simulacao de processador_tb completa.

echo.
echo Todas as operacoes do GHDL foram concluidas com sucesso!
echo.

pause