        org $80

Xh      db  $DE
Xl      db  $EA
Y       db  $A5
Rh      db  $BA
Rl      db  $DC

        org $EE00
start

        ldx #$08
        clr Rh
        clr Rl

loop_mult
        brclr 0,Y,rota

        clc

        lda Rl
        add Xl
        sta Rl

        lda Rh
        adc Xh
        sta Rh

rota
        clc
        asr Y
        asl Xl
        rol Xh

        decx
        bne loop_mult

fin
        jmp fin


; Vector interrupciones.
        org $FFFA

        dw start
        dw start
        dw start
