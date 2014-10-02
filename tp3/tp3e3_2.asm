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



        org $EE00
start
;                            cycles.
        ldhx A              ; 4
        lda A+1             ; 3
        ldx B               ; 3
        div                 ; 7

        sta C               ; 3
        pshh                ; 2
        pula                ; 2
        sta R               ; 3
                            ; 27 total.


fin
        jmp fin


; Vector interrupciones.
        org $FFFA

        dw start
        dw start
        dw start
