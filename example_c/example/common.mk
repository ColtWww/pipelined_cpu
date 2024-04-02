##change this path to your own riscv-tool-chain path
RISCV_PATH := G:\\FPGA_ZYNQ_IC_Learn\\IC\\riscv\\riscv32_order_pipeline\\riscv-tool-chain
RISCV_GCC     := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-gcc.exe)
RISCV_AS      := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-as.exe)
RISCV_GXX     := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-g++.exe)
RISCV_OBJDUMP := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-objdump.exe)
RISCV_GDB     := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-gdb.exe)
RISCV_AR      := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-ar.exe)
RISCV_OBJCOPY := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-objcopy.exe)
RISCV_READELF := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-readelf.exe)

#RISCV_PATH := D:\\riscv_gnu_toolchain_windows\\SysGCC\\
#RISCV_GCC     := $(abspath $(RISCV_PATH)/bin/riscv64-unknown-elf-gcc)
#RISCV_AS      := $(abspath $(RISCV_PATH)/bin/riscv64-unknown-elf-as)
#RISCV_GXX     := $(abspath $(RISCV_PATH)/bin/riscv64-unknown-elf-g++)
#RISCV_OBJDUMP := $(abspath $(RISCV_PATH)/bin/riscv64-unknown-elf-objdump)
#RISCV_GDB     := $(abspath $(RISCV_PATH)/bin/riscv64-unknown-elf-gdb)
#RISCV_AR      := $(abspath $(RISCV_PATH)/bin/riscv64-unknown-elf-ar)
#RISCV_OBJCOPY := $(abspath $(RISCV_PATH)/bin/riscv64-unknown-elf-objcopy)
#RISCV_READELF := $(abspath $(RISCV_PATH)/bin/riscv64-unknown-elf-readelf)


.PHONY: all
all: $(TARGET)

ASM_SRCS += $(COMMON_DIR)/start.S
ASM_SRCS += $(COMMON_DIR)/trap_entry.S
C_SRCS += $(COMMON_DIR)/init.c
C_SRCS += $(COMMON_DIR)/trap_handler.c
C_SRCS += $(COMMON_DIR)/lib/utils.c
C_SRCS += $(COMMON_DIR)/lib/xprintf.c
C_SRCS += $(COMMON_DIR)/lib/uart.c


LINKER_SCRIPT := $(COMMON_DIR)/link.lds

INCLUDES += -I$(COMMON_DIR)

LDFLAGS += -T $(LINKER_SCRIPT) -nostartfiles -Wl,--gc-sections -Wl,--check-sections

ASM_OBJS := $(ASM_SRCS:.S=.o)
C_OBJS := $(C_SRCS:.c=.o)


LINK_OBJS += $(ASM_OBJS) $(C_OBJS)
LINK_DEPS += $(LINKER_SCRIPT)

CLEAN_OBJS += $(TARGET) $(LINK_OBJS) $(TARGET).dump $(TARGET).bin

CFLAGS += -march=$(RISCV_ARCH)
CFLAGS += -mabi=$(RISCV_ABI)
CFLAGS += -mcmodel=$(RISCV_MCMODEL) -ffunction-sections -fdata-sections -fno-builtin-printf -fno-builtin-malloc

$(TARGET): $(LINK_OBJS) $(LINK_DEPS) Makefile
	$(RISCV_GCC) $(CFLAGS) $(INCLUDES) $(LINK_OBJS) -o $@ $(LDFLAGS) -lm
	$(RISCV_OBJCOPY) -O binary $@ $@.bin
	$(RISCV_OBJDUMP) --disassemble-all $@ > $@.dump

$(ASM_OBJS): %.o: %.S
	$(RISCV_GCC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

$(C_OBJS): %.o: %.c
	$(RISCV_GCC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

.PHONY: clean
clean:
	rm -f $(CLEAN_OBJS)
