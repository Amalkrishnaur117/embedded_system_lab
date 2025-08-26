TARGET = main
BUILD  = build

CC = arm-none-eabi-gcc
CFLAGS = -mcpu=cortex-m0 -mthumb -O0 -g -Wall -ffreestanding -fno-builtin
LDFLAGS = -T linker.ld -nostartfiles -nostdlib

# C + assembly sources
SRCS = main.c startup_stm32f072.s
OBJS = $(SRCS:%.c=$(BUILD)/%.o)
OBJS := $(OBJS:%.s=$(BUILD)/%.o)

all: $(BUILD)/$(TARGET).elf $(BUILD)/$(TARGET).bin

$(BUILD):
	mkdir -p $(BUILD)

# Compile C
$(BUILD)/%.o: %.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# Compile ASM
$(BUILD)/%.o: %.s | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# Link
$(BUILD)/$(TARGET).elf: $(OBJS) linker.ld | $(BUILD)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJS)

# BIN
$(BUILD)/$(TARGET).bin: $(BUILD)/$(TARGET).elf
	arm-none-eabi-objcopy -O binary $< $@

flash: $(BUILD)/$(TARGET).bin
	st-flash write $< 0x08000000

clean:
	rm -rf $(BUILD)
