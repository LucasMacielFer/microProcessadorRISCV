# Makefile for VHDL simulation with GHDL and GTKWave
# Recursively compiles all .vhd files in the project (excluding test benches) and simulates the specified top-level testbench

# === User editable section ===
# Top-level testbench entity name (should match the filename .vhd)
TOP = Top_Level_tb
# GHDL work library name
WORK = work

# Find all VHDL design sources (exclude files ending with _tb.vhd)
DESIGN_SOURCES := $(shell find . -type f -name "*.vhd" ! -name "*_tb.vhd")
# Explicit testbench source
TB_SOURCE := $(TOP).vhd

# Default: compile, elaborate, simulate and view
.PHONY: all
all: analyze elaborate simulate view

# Analyze (compile) design sources and testbench
.PHONY: analyze
analyze:
	@echo "=== Analyzing design sources ==="
	@for src in $(DESIGN_SOURCES); do \
		echo "Compiling $$src"; \
		ghdl -a --work=$(WORK) $$src; \
	done
	@echo "=== Analyzing testbench ==="
	@ghdl -a --work=$(WORK) $(TB_SOURCE)

# Elaborate the top-level testbench
.PHONY: elaborate
elaborate: analyze
	@echo "=== Elaborating $(TOP) ==="
	@ghdl -e --work=$(WORK) $(TOP)

# Run simulation and generate VCD
.PHONY: simulate
simulate: elaborate
	@echo "=== Running simulation ==="
	@ghdl -r --work=$(WORK) $(TOP) --vcd=$(TOP).vcd

# Open GTKWave on the generated VCD
.PHONY: view
view: simulate
	@echo "=== Launching GTKWave ==="
	@gtkwave $(TOP).vcd

# Clean generated files
.PHONY: clean
clean:
	@echo "=== Cleaning project ==="
	@rm -f *.o *.cf *.vcd
	@find . -type f -name "*.o" -delete
	@find . -type f -name "*.cf" -delete

# Display help
.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all       - analyze, elaborate, simulate, and view waveform"
	@echo "  analyze   - compile design sources and testbench"
	@echo "  elaborate - elaborate the testbench ($(TOP))"
	@echo "  simulate  - run simulation, generate $(TOP).vcd"
	@echo "  view      - open GTKWave on $(TOP).vcd"
	@echo "  clean     - remove generated files"
	@echo "  help      - show this message"