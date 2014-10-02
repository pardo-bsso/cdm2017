; Calcular
;   C = A / B
; A e B son variables de un byte.
; A variable de dos bytes.
; R contiene el resto de la division.

        org $80
A       dw $BADC
B       db $DE
C       db $00
R       db $00
Rh      db $00



        org $EE00
start
;                            cycles.

        ldx #$10
        clr R
        clr Rh
        clr C
        clra

loop_bits
        clc
        rol A+1
        rol A
        rol R
        rol Rh
        asl C

        lda Rh
        bne resta
        lda R
        cmp B
        blo loop_bits_fin

resta
        lda R
        sub B
        sta R
        lda Rh
        sbc #$00
        sta Rh
        bset 0,C


loop_bits_fin


        decx
        bne loop_bits


fin
        jmp fin


; Vector interrupciones.
        org $FFFA

        dw start
        dw start
        dw start
