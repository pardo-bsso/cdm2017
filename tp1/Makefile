ASM=/media/datos/programas/pemicro/ics08qtqyz/CASM08Z.EXE

%.png : %.dot
		dot -Tpng $< -o $@

%.s19 : %.asm
		$(ASM) $< S D

all: $(patsubst %.dot, %.png, $(wildcard *.dot)) $(patsubst %.asm, %.s19, $(wildcard *.asm))

clean:
		rm *.s19 *.ERR *.map
