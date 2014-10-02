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

        ldx #$10            ; 2
        clr R               ; 3
        clr Rh              ; 3
        clr C               ; 3
        clra                ; 1
                            ; 12 total.

loop_bits
        clc                 ; 1
        rol A+1             ; 4
        rol A               ; 4
        rol R               ; 4
        rol Rh              ; 4
        asl C               ; 4
                            ; 21 total.

        lda Rh              ; 3
        bne resta           ; 3
        lda R               ; 3
        cmp B               ; 3
        blo loop_bits_fin   ; 3
                            ; 15 total.

resta
        lda R               ; 3
        sub B               ; 3
        sta R               ; 3
        lda Rh              ; 3
        sbc #$00            ; 2
        sta Rh              ; 3
        bset 0,C            ; 4
                            ; 21 total.


loop_bits_fin

        decx                ; 1
        bne loop_bits       ; 3

                            ; 73 total peor caso por iteracion.
                            ; 1168 (16 iteraciones, una por bit) peor caso.


fin
        jmp fin


; Vector interrupciones.
        org $FFFA

        dw start
        dw start
        dw start
