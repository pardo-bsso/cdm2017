; R = X * Y
; R y X son enteros de 16 bits
; Y es un entero de 8 bits.
; Se modifica el registro X.
; No se maneja si hay overflow.
; La operación se divide en dos partes, multiplicando por separado
; los bytes de X y combinando en el resultado final.
; R = Y*Xl + ((Y*Xh) << 8)
        org $80

Xh      db  $DE
Xl      db  $EA
Y       db  $A5
Rh      db  $BA
Rl      db  $DC

        org $EE00
start
;                            cycles.

        lda Y               ; 3
        ldx Xl              ; 3
        mul                 ; 5
        sta Rl              ; 3
        stx Rh              ; 3
                            ; 17 total.

        lda Y               ; 3
        ldx Xh              ; 3
        mul                 ; 5
        add Rh              ; 3
        sta Rh              ; 3
                            ; 17 total.
; total de ciclos: 34

fin
        jmp fin


; Vector interrupciones.
        org $FFFA

        dw start
        dw start
        dw start
