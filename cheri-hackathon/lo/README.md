# lo 
## Introduction
This is a tiny example of a minimal bootable and executible CHERI code on Qemu/malta virtual machine.

It builds a tiny ELF kernel which when booted by Qemu executes following operations:
* Enables CHERI coprocessor
* Gets the universal capability and restricts its down to adressing memory-mapped I/O range for UART
* Uses the UART capability to transmit character 'l'
* Uses the UART capability to transmit character 'o'
* Performs a demonstational crash by using the capability in improper way

When running under Qemu - you'll be able to see something like 'lololololo....' printed on the console as a result of automatic restart after the crash.

If you wonder what does 'lo' mean and where it comes from --> https://thisdayintechhistory.com/10/29/first-message-on-the-internet/

## Building
```
cd lo
make
```

## Running in Qemu
```bash
../sdk/bin/qemu-system-cheri256 -M malta -nographic -m 2048 -kernel lo.elf -D /tmp/trace.log -d instr
```
NOTE: Exit from Qemu is Ctrl+A,X

