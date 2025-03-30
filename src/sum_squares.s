.text
.global _start
_start:
    li a0, 5       # n = 5 (1² + 2² + 3² + 4² + 5² = 55)
    call sum_squares
    call print_int
    li a0, 0
    li a7, 93
    ecall

sum_squares:
    beqz a0, .base_case
    addi sp, sp, -16
    sd ra, 8(sp)
    sd a0, 0(sp)
    addi a0, a0, -1
    call sum_squares
    ld t0, 0(sp)
    mul t1, t0, t0 # n²
    add a0, a0, t1
    ld ra, 8(sp)
    addi sp, sp, 16
    ret
.base_case:
    li a0, 0
    ret