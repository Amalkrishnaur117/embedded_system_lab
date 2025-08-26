/*
#include <stdint.h>
void _init(void) {}
void _fini(void) {}
volatile uint32_t result;

int main(void) {
    uint32_t a = 21;
    uint32_t b = 21;
    result = a + b;  // result = 42
    while (1) {
        // infinite loop so debugger can attach
    }
}
*/
