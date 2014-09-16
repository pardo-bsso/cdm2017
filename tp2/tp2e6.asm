        org $80

len     db !10
arr     db '01234567'
        db $a3
        db $FF

cnt     db $0

        org $EE00
start
        clrh
        ldx #arr

loop
        lda ,X
        bpl loop_tail
        inc cnt

loop_tail
        incx
        txa
        clc
        sub #arr
        sub len
        beq fin
        jmp loop

fin
        jmp fin

        org $FFFA

        dw start
        dw start
        dw start
