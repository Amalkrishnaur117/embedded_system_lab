# Embedded system Lab
# Embedded System Lab – STM32F072 (Cortex-M0)

This project demonstrates a simple STM32 bare-metal firmware build using `arm-none-eabi-gcc`, a custom `Makefile`, and ST-LINK tools.  
The guide includes step-by-step instructions for **Ubuntu users**, so even beginners can get started quickly.

---

## 🔧 Requirements

### 🐧 On Ubuntu/Debian
First, update your package lists:
```bash
sudo apt update
```

Then install the required tools:
```bash
sudo apt install build-essential gcc-arm-none-eabi binutils-arm-none-eabi stlink-tools make
```

- **build-essential** → compilers and tools  
- **gcc-arm-none-eabi** → ARM cross-compiler + debugger (includes `arm-none-eabi-gdb`)  
- **binutils-arm-none-eabi** → assembler & linker for ARM  
- **stlink-tools** → flashing/debugging STM32 via ST-LINK  
- **make** → build automation tool  

### 🐧 On Arch Linux
```bash
sudo pacman -S base-devel arm-none-eabi-gcc arm-none-eabi-binutils arm-none-eabi-gdb stlink make
```

---

## 📂 Project Structure

```
.
├── main.c                 # Application code
├── startup_stm32f072.s    # Startup assembly
├── linker.ld              # Linker script
├── Makefile               # Build system
└── build/                 # Generated build output
```

---

## ⚡ Usage

### 1. Build the project
Run:
```bash
make
```
This generates:
- `build/main.elf` → Executable firmware  
- `build/main.bin` → Binary for flashing  

---

### 2. Flash firmware to STM32
Connect your STM32 board via **ST-LINK** and run:
```bash
make flash
```
This writes the program to flash at address `0x08000000`.

---

### 3. Clean build files
Remove all generated files:
```bash
make clean
```

---

## 🐞 Debugging with GDB

You can debug the firmware with **arm-none-eabi-gdb** and **st-util**.

### Step 1: Start the ST-LINK GDB server
```bash
st-util
```
This opens a GDB server on port `:4242`.

### Step 2: Open GDB in another terminal
```bash
arm-none-eabi-gdb build/main.elf
```

### Step 3: Connect to target
Inside GDB:
```
target extended-remote :4242
```

### Step 4: Load & run program
```
load
continue
```

Now you can set breakpoints, inspect variables, and step through code.

---

## 🛠 Notes
- The `Makefile` is configured for **STM32F072 (ARM Cortex-M0)**.  
- If you change the MCU, update `linker.ld` accordingly.  
- Requires an **ST-LINK v2** or compatible programmer.  

---

## ✅ Tested On
- Ubuntu 22.04 LTS with `gcc-arm-none-eabi 10.3.1`  
- Arch Linux (rolling) with latest `arm-none-eabi-gcc`  
- STM32F072 Nucleo Board + ST-LINK v2
