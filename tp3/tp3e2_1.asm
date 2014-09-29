; R = X * Y
; R y X son enteros de 16 bits
; Y es un entero de 8 bits.
; No se maneja si hay overflow.
; variables X e Y son modificados por la rutina.
; El registro X tambien.

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

; Por cada bit de Y, si es uno
;   sumo X al resultado
; X = X << 1
; Y = Y >> 1
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
