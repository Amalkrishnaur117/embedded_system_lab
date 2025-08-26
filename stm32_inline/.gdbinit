# Load ELF file (symbols only)
file main.elf

# Define a custom command to connect + flash
define connect_target
    target extended-remote :4242
    monitor reset halt
    load
    #monitor reset init
end

document connect_target
Connect to st-util (port 4242), halt, load firmware, and reset init.
Usage: connect_target
end
