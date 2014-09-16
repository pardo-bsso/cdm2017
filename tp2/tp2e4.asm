        org $80
na      dw $DEAD
nb      dw $BEEF
nc      dw $BADC
res     rmb 2

naH     equ na
naL     equ na+1
nbH     equ nb
nbL     equ nb+1
ncH     equ nc
ncL     equ nc+1
resH    equ res
resL    equ res+1

        org $EE00
start
        clc
        lda naL
        adc nbL
        sta resL

        lda naH
        adc nbH
        sta resH

        clc
        lda ncL
        adc resL
        sta resL
        lda ncH
        adc resH
        sta resH

fin
        jmp fin

        org $FFFA

        dw start
        dw start
        dw start
