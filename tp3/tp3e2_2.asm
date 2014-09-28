        org $80

Xh      db  $DE
Xl      db  $EA
Y       db  $A5
Rh      db  $BA
Rl      db  $DC

        org $EE00
start

        lda Y
        ldx Xl
        mul
        sta Rl
        stx Rh

        lda Y
        ldx Xh
        mul
        add Rh
        sta Rh

fin
        jmp fin


; Vector interrupciones.
        org $FFFA

        dw start
        dw start
        dw start
