
#include <stdint.h>
void _init(void) {}
void _fini(void) {}
// globals to check in debugger
volatile uint32_t sum_res;
volatile uint32_t accum_res;

int main(void) {
    uint32_t a = 5;
    uint32_t b = 7;
    uint32_t acc, i;

    // --- addition: sum_res = a + b ---
    __asm__ volatile (
        "adds %[out], %[a], %[b]\n"
        : [out] "=l"(sum_res)      // force low reg
        : [a] "l"(a), [b] "l"(b)
        : "cc"
    );

    // --- accumulate 0..9 ---
    __asm__ volatile (
        "movs   r0, #0        \n"  // acc = 0
        "movs   r1, #0        \n"  // i = 0
        "1:                   \n"
        "adds   r0, r0, r1    \n"  // acc += i
        "adds   r1, r1, #1    \n"  // i++
        "cmp    r1, #10       \n"
        "bcc    1b            \n"  // loop while i < 10
        "mov    %[acc], r0    \n"
        "mov    %[iout], r1   \n"
        : [acc] "=l"(acc), [iout] "=l"(i)
        :
        : "r0", "r1", "cc"
    );

    accum_res = acc;

    while (1) {
        // idle loop
    }
}
