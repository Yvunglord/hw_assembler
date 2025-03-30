.text
.global _start
_start:
    li a0, 10      # fib(10) = 55
    call fib_exp
    call print_int
    li a0, 0
    li a7, 93
    ecall

fib_exp:
    li t0, 1
    beqz a0, .base_0
    beq a0, t0, .base_1
    addi sp, sp, -16
    sd ra, 8(sp)
    sd a0, 0(sp)
    addi a0, a0, -1
    call fib_exp
    sd a0, 0(sp)
    ld a0, 8(sp)
    addi a0, a0, -2
    call fib_exp
    ld t0, 0(sp)
    add a0, a0, t0
    ld ra, 8(sp)
    addi sp, sp, 16
    ret
.base_0:
    li a0, 0
    ret
.base_1:
    li a0, 1
    ret