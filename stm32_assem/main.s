.syntax unified
.thumb
.global main
.text

main:
    movs r0, #5
    movs r1, #10
    adds r2, r0, r1   @ works now
loop:
    b loop
