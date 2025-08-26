TARGET = main
BUILD  = build

CC = arm-none-eabi-gcc
CFLAGS = -mcpu=cortex-m0 -mthumb -O0 -g -Wall
LDFLAGS = -T linker.ld -nostartfiles -nostdlib

# Only assembly sources
SRCS = main.s startup_stm32f072.s
OBJS = $(SRCS:%.s=$(BUILD)/%.o)

all: $(BUILD)/$(TARGET).elf $(BUILD)/$(TARGET).bin

# Create build dir if it doesn’t exist
$(BUILD):
	mkdir -p $(BUILD)

# Compile ASM
$(BUILD)/%.o: %.s | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# Link ELF
$(BUILD)/$(TARGET).elf: $(OBJS) linker.ld | $(BUILD)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJS)

# Make BIN from ELF
$(BUILD)/$(TARGET).bin: $(BUILD)/$(TARGET).elf
	arm-none-eabi-objcopy -O binary $< $@

# Flash to board
flash: $(BUILD)/$(TARGET).bin
	st-flash write $< 0x08000000

# Optional: Disassemble ELF (for debugging)
disasm: $(BUILD)/$(TARGET).elf
	arm-none-eabi-objdump -d $< > $(BUILD)/$(TARGET).lst

clean:
	rm -rf $(BUILD)
