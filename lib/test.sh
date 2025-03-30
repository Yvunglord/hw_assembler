#!/bin/bash

command -v qemu-riscv64 >/dev/null || { echo "Error: qemu-riscv64 not found"; exit 1; }
command -v riscv64-unknown-elf-gcc >/dev/null || { echo "Error: RISC-V toolchain not found"; exit 1; }

make || exit 1

test_program() {
    local program=$1
    local expected=$2
    local result=$(qemu-riscv64 ./$program | tr -d '[:space:]')
    if [ "$result" -eq "$expected" ]; then
        echo -e "\033[32m[OK]\033[0m $program: $result"
    else
        echo -e "\033[31m[FAIL]\033[0m $program: expected $expected, got $result"
    fi
}

echo "Running tests..."
test_program sum_cubes 225
test_program sum_squares 55
test_program fib_exp 55
test_program fib_linear 55