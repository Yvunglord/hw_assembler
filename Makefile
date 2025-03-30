CC      = riscv64-unknown-elf-gcc
LD      = riscv64-unknown-elf-ld
OBJCOPY = riscv64-unknown-elf-objcopy
CFLAGS  = -nostdlib -static -march=rv64gc -mabi=lp64d
QEMU    = qemu-riscv64

SRC_DIR = src
LIB_DIR = lib
BIN_DIR = bin

TARGETS = sum_cubes sum_squares fib_exp fib_linear

.PHONY: all clean test

all: $(addprefix $(BIN_DIR)/,$(TARGETS))

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(BIN_DIR)/%: $(SRC_DIR)/%.s $(LIB_DIR)/rv_runtime.s | $(BIN_DIR)
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -rf $(BIN_DIR)

test: all
	@echo "Running tests..."
	@for prog in $(TARGETS); do \
		expected=$$(case $$prog in \
			"sum_cubes") echo 225;; \
			"sum_squares") echo 55;; \
			"fib_exp"|"fib_linear") echo 55;; \
		esac); \
		result=$$($(QEMU) $(BIN_DIR)/$$prog | tr -d '[:space:]'); \
		if [ "$$result" -eq "$$expected" ]; then \
			echo -e "\033[32m[OK]\033[0m $$prog: $$result"; \
		else \
			echo -e "\033[31m[FAIL]\033[0m $$prog: expected $$expected, got $$result"; \
		fi; \
	done