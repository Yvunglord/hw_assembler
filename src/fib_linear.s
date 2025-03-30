.text
.global _start
_start:
    li a0, 10      # fib(10) = 55
    call fib_linear
    call print_int
    li a0, 0
    li a7, 93
    ecall

fib_linear:
    li t0, 1
    beqz a0, .base_0
    beq a0, t0, .base_1
    li t1, 0       # a = fib(0)
    li t2, 1       # b = fib(1)
    li t3, 1       # i = 1
.loop:
    add t4, t1, t2 # c = a + b
    mv t1, t2
    mv t2, t4
    addi t3, t3, 1
    blt t3, a0, .loop
    mv a0, t2
    ret
.base_0:
    li a0, 0
    ret
.base_1:
    li a0, 1
    ret