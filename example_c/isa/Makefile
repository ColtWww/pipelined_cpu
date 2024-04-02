#=======================================================================
# Makefile for riscv-tests/isa
#-----------------------------------------------------------------------

XLEN := 32

src_dir := .

#include $(src_dir)/rv32ui/Makefrag
#include $(src_dir)/rv32um/Makefrag
#include $(src_dir)/rv32Zicsr/Makefrag
#include $(src_dir)/rv32Zifencei/Makefrag
include $(src_dir)/rv32si/Makefrag
include $(src_dir)/rv32ua/Makefrag


default: all

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

RISCV_PREFIX ?= D:\\cpu_design\\6.Self_CPU\\riscv_soc\\tools\\gnu-mcu-eclipse-riscv-none-gcc-8.2.0-2.2-20190521-0004-win64\\bin\\riscv-none-embed-
#RISCV_PREFIX ?= D:\\riscv_gnu_toolchain_windows\\SysGCC\\bin\\riscv64-unknown-elf-
RISCV_GCC ?= $(RISCV_PREFIX)gcc
RISCV_GCC_OPTS ?= -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles
RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump --disassemble-all
RISCV_OBJCOPY ?= $(RISCV_PREFIX)objcopy


vpath %.S $(src_dir)

#------------------------------------------------------------
# Build assembly tests

%.dump: % 
	$(RISCV_OBJDUMP) generated/$< > generated/$@
	$(RISCV_OBJCOPY) -O verilog generated/$<   generated/$<.verilog
	$(RISCV_OBJCOPY) -O binary generated/$<   generated/$<.bin


define compile_template

$$($(1)_p_tests): $(1)-p-%: $(1)/%.S
	$$(RISCV_GCC) $(2) $$(RISCV_GCC_OPTS) -I$(src_dir) -T$(src_dir)/link.ld $$< -o generated/$$@
$(1)_tests += $$($(1)_p_tests)

$(1)_tests_dump = $$(addsuffix .dump, $$($(1)_tests))

$(1): $$($(1)_tests_dump)

.PHONY: $(1)

tests += $$($(1)_tests)

endef

$(eval $(call compile_template,rv32ui,-march=rv32g -mabi=ilp32))
$(eval $(call compile_template,rv32um,-march=rv32g -mabi=ilp32))
$(eval $(call compile_template,rv32Zicsr,-march=rv32g -mabi=ilp32))
$(eval $(call compile_template,rv32Zifencei,-march=rv32g -mabi=ilp32))
$(eval $(call compile_template,rv32si,-march=rv32g -mabi=ilp32))
$(eval $(call compile_template,rv32ua,-march=rv32g -mabi=ilp32))

tests_verilog = $(addsuffix .verilog, $(tests))
tests_dump = $(addsuffix .dump, $(tests))


#------------------------------------------------------------
# Default

all: $(tests_dump)

clean:
	rm -rf generated/*

