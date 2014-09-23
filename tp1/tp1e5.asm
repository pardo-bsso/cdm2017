; resultado = x << y
; Tanto x como y no conservan su valor.
; A su vez, el byte bajo del resultado esta contenido
; en la misma posicion que x.

        org $80
resH    db  $00             ;0080
resM    db  $00             ;0081
x       db  $A5             ;0082
y       db  $10             ;0083
resL    equ $82

        org $EE00
start
;       nem                  addr

        clr $80             ;EE00
        clr $81             ;EE02
; !130 == $82
        lsl !130            ;EE04
        rol $81             ;EE06
        rol $80             ;EE08
        dec $83             ;EE0A
        bne *-08            ;EE0C (bne EE04)

end
        jmp end             ;

        org $FFFA

        dw start
        dw start
        dw start

