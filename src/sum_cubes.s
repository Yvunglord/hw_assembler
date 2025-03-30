.text
.global _start
_start:
    li a0, 5       # n = 5 (1³ + 2³ + 3³ + 4³ + 5³ = 225)
    call sum_cubes
    call print_int
    li a0, 0
    li a7, 93      # exit(0)
    ecall

sum_cubes:
    beqz a0, .base_case
    addi sp, sp, -16
    sd ra, 8(sp)
    sd a0, 0(sp)
    addi a0, a0, -1
    call sum_cubes
    ld t0, 0(sp)   # n
    mul t1, t0, t0 # n²
    mul t1, t1, t0 # n³
    add a0, a0, t1
    ld ra, 8(sp)
    addi sp, sp, 16
    ret
.base_case:
    li a0, 0
    ret