TARGET = main
BUILD  = build

CC = arm-none-eabi-gcc
CFLAGS = -mcpu=cortex-m0 -mthumb -O0 -g -Wall
LDFLAGS = -T linker.ld -nostartfiles

SRCS = main.c startup_stm32f072.s
OBJS = $(addprefix $(BUILD)/,$(SRCS:.c=.o))
OBJS := $(OBJS:.s=.o)

all: $(BUILD)/$(TARGET).elf $(BUILD)/$(TARGET).bin

# Create build dir if it doesn’t exist
$(BUILD):
	mkdir -p $(BUILD)

# Compile C
$(BUILD)/%.o: %.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# Compile ASM
$(BUILD)/%.o: %.s | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# Link ELF
$(BUILD)/$(TARGET).elf: $(OBJS) linker.ld | $(BUILD)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(LDFLAGS)

# Make BIN from ELF
$(BUILD)/$(TARGET).bin: $(BUILD)/$(TARGET).elf
	arm-none-eabi-objcopy -O binary $< $@

flash: $(BUILD)/$(TARGET).bin
	st-flash write $< 0x08000000

clean:
	rm -rf $(BUILD)
