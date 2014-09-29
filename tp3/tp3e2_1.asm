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
;                            cycles.
loop_mult
        brclr 0,Y,rota      ; 5

        clc                 ; 1

        lda Rl              ; 3
        add Xl              ; 3
        sta Rl              ; 3

        lda Rh              ; 3
        adc Xh              ; 3
        sta Rh              ; 3
                            ; 24 total.

rota
        clc                 ; 1
        asr Y               ; 4
        asl Xl              ; 4
        rol Xh              ; 4

        decx                ; 1
        bne loop_mult       ; 3
                            ; 17 total.

; total de ciclos peor caso: 8 * (17 + 24) = 328

fin
        jmp fin


; Vector interrupciones.
        org $FFFA

        dw start
        dw start
        dw start
