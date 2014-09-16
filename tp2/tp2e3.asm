        org $90

        db 'uNa cADeNa XXaa'
        db $0D

        org $EE00
start
        clrh
        ldhx #$0090

loop
        lda #$0D
        cmp ,X
        beq fin

        lda #!97
        cmp ,X
        bgt loop_tail
        lda #!122
        cmp ,X
        blt loop_tail

        lda ,X
        sub #!32
        sta ,X

loop_tail
        incx
        jmp loop

fin
        jmp fin

        org $FFFA

        dw start
        dw start
        dw start
