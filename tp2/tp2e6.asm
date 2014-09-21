; Cuento cantidad de elementos de un byte negativos en un array.

        org $80

len     db !10
cnt     db $0
arr     db '01234567'
        db $a3
        db $FF


        org $EE00
start
; X apunta a principo del array.
        clrh
        ldx #arr

loop
; Si es negavito incremento cuenta.
        lda ,X
        bpl loop_tail
        inc cnt

loop_tail
; Si X apunta a inicio + longitud termine de procesar.
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
