
TOOLCHAIN_PREFIX = riscv32-unknown-elf-

all: firmware.S firmware.c firmware.lds
	$(TOOLCHAIN_PREFIX)gcc -Os -ffreestanding -nostdlib -o firmware.elf firmware.S firmware.c \
		 --std=gnu99 -Wl,-Bstatic,-T,firmware.lds,-Map,firmware.map,--strip-debug -lgcc
	$(TOOLCHAIN_PREFIX)objcopy -O binary firmware.elf firmware.bin
	python3 ./makehex.py firmware.bin 4096 > firmware.hex

clean:
	rm *.bin *.elf *.hex *.map