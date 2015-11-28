#!Makefile

# patsubst 处理所有在 C_SOURCES 字列中的字（一列文件名），如果它的 结尾是 '.c'，就用 '.o' 把 '.c' 取代
C_SOURCES = $(shell find . -name "*.c")
C_OBJECTS = $(patsubst %.c, %.o, $(C_SOURCES))
S_SOURCES = $(shell find . -name "*.s")
S_OBJECTS = $(patsubst %.s, %.o, $(S_SOURCES))

CC = gcc
LD = ld
ASM = nasm

C_FLAGS = -c -Wall -m32 -ggdb -gstabs+ -nostdinc -fno-builtin -fno-stack-protector -I include -Wunused-value
LD_FLAGS = -T scripts/kernel.ld -m elf_i386 -nostdlib
ASM_FLAGS = -f elf -g -F stabs

all: $(S_OBJECTS) $(C_OBJECTS) link

# The automatic variable `$<' is just the first prerequisite
.c.o:
	@echo Compile C Source files $< ...
	$(CC) $(C_FLAGS) $< -o $@

.s.o:
	@echo Compile NASM Source files $< ...
	$(ASM) $(ASM_FLAGS) $<

link:
	@echo Linking kernel image...
	$(LD) $(LD_FLAGS) $(S_OBJECTS) $(C_OBJECTS) -o crystal

.PHONY:clean
clean:
	$(RM) $(S_OBJECTS) $(C_OBJECTS) crystal

.PHONY:qemu
qemu:
	qemu -kernel crystal &

.PHONY:debug
debug:
	qemu -S -s -kernel crystal &
	sleep 0.5
	cgdb -x scripts/gdbinit

