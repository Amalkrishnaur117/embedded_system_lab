.syntax unified
.cpu cortex-m0
.thumb

.global g_pfnVectors
.global Reset_Handler
.global Default_Handler

/* Reset Handler */
.section .text.Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    ldr   r0, =_estack
    mov   sp, r0          /* set stack pointer */

    bl    main            /* jump to user main (assembly) */

1:  b 1b                  /* loop forever if main returns */

.size Reset_Handler, .-Reset_Handler

/* Default handler */
.section .text.Default_Handler,"ax",%progbits
Default_Handler:
    b .
.size Default_Handler, .-Default_Handler

/* Vector table */
.section .isr_vector,"a",%progbits
.type g_pfnVectors, %object
g_pfnVectors:
    .word _estack
    .word Reset_Handler
    .word Default_Handler  /* NMI */
    .word Default_Handler  /* HardFault */
    .word 0                /* Reserved */
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word Default_Handler  /* SVC */
    .word 0
    .word 0
    .word Default_Handler  /* PendSV */
    .word Default_Handler  /* SysTick */
    /* Fill out rest with Default_Handler (or 0) */
    .rept (48)             /* enough entries for F0 IRQs */
    .word Default_Handler
    .endr
.size g_pfnVectors, .-g_pfnVectors

/* Weak aliases */
.weak NMI_Handler
.thumb_set NMI_Handler, Default_Handler
.weak HardFault_Handler
.thumb_set HardFault_Handler, Default_Handler
.weak SVC_Handler
.thumb_set SVC_Handler, Default_Handler
.weak PendSV_Handler
.thumb_set PendSV_Handler, Default_Handler
.weak SysTick_Handler
.thumb_set SysTick_Handler, Default_Handler
