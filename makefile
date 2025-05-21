# Makefile for VHDL compilation and elaboration with GHDL
# Recursively analyzes all .vhd files and elaborates the specified top-level testbench

# === User editable section ===
# Top-level testbench entity name (should match the filename .vhd)
TOP = Top_Level_tb
# GHDL work library name
WORK = work

# Find all VHDL files in project
VHDL_SOURCES := $(shell find . -type f -name "*.vhd")

# Default target: analyze all sources and elaborate the top-level
.PHONY: all
all: analyze elaborate

# Analyze (compile) all VHDL sources
.PHONY: analyze
analyze:
	@echo "=== Analyzing VHDL sources ==="
	@for src in $(VHDL_SOURCES); do \
		echo "ghdl -a --work=$(WORK) $$src"; \
		ghdl -a --work=$(WORK) $$src; \
	done

# Elaborate the top-level testbench
.PHONY: elaborate
elaborate: analyze
	@echo "=== Elaborating $(TOP) ==="
	@ghdl -e --work=$(WORK) $(TOP)

# Clean generated files
.PHONY: clean
clean:
	@echo "=== Cleaning project ==="
	@rm -f *.o *.cf *.vcd
	@find . -type f -name "*.o" -delete
	@find . -type f -name "*.cf" -delete

# Help message
.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all       - analyze all VHDL sources and elaborate $(TOP)"
	@echo "  analyze   - compile all .vhd files"
	@echo "  elaborate - elaborate the testbench ($(TOP))"
	@echo "  clean     - remove generated files"
	@echo "  help      - show this message"
