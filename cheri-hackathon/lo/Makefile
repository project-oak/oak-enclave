SDK_DIR=../sdk
#CC=$(SDK_DIR)/bin/cheribsd256purecap-clang
CC=$(SDK_DIR)/bin/clang
LD=$(SDK_DIR)/bin/ld.lld
OBJDUMP=$(SDK_DIR)/bin/llvm-objdump
CHERI=256
#ABI=purecap
#TARGET=mips64c256-unknown-freebsd13-purecap
ABI=n64
TARGET=mips64-unknown-freebsd
CFLAGS=--target=$(TARGET) -mabi=$(ABI) -cheri=$(CHERI)
IMAGE_BASE=0xffffffff80100000
GOT_ADDRESS=0xffffffff80700000

all:	lo.elf

clean:
	rm -f *.o *.elf

lo.S.o: lo.S Makefile
	$(CC) $(CFLAGS) -c $< -o $@

foo.c.o:  foo.c Makefile
	$(CC) $(CFLAGS) -c $< -o $@

lo.elf: lo.S.o foo.c.o Makefile
	$(LD) -o $@ foo.c.o $< --image-base=$(IMAGE_BASE) --section-start .got=$(GOT_ADDRESS)
	$(OBJDUMP) --disassemble $@ > $@.disasm
