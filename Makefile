CROSS_COMPILE=aarch64-linux-gnu-
CXX=$(CROSS_COMPILE)g++
LD=$(CROSS_COMPILE)ld
OBJCOPY=$(CROSS_COMPILE)objcopy
AS=$(CROSS_COMPILE)as

fsl.img: fsl.bin
	../u-boot/tools/mkimage -T sunxi_egon -n "sun50i-h616-orangepi-zero2" -d fsl.bin fsl.img

clean:
	$(RM) *.o *.elf *.img *.bin

fsl.bin: fsl.elf
	$(OBJCOPY) -O binary fsl.elf fsl.bin

fsl.elf: leds.o boot0.o fsl.lds
	$(LD) -g -T fsl.lds leds.o boot0.o -o fsl.elf

boot0.o: boot0.s
	$(AS) -g -c boot0.s -o boot0.o

leds.o: leds.cpp
	$(CXX) -O2 -g -c leds.cpp -o leds.o

flash: fsl.img
	sudo dd if=fsl.img of=/dev/mmcblk0 bs=1k seek=8
