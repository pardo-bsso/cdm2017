; Tengo dos variables signadas de 16 bits en $80 y $81 (x, y) en big endian.
; x = x - y
; En principio cualquiera de las dos puede estar en el rango [-32768, 32767]
; Sin embargo, el resultado también está circunscripto a ese rango, por lo que
; sera correcto siempre que (x-y) se encuentre contenido en el mismo.


        org $80
x       dw  $DEAD

        org $82
y       dw  $BEEF

        org $EE00
start
;       nem                  addr

; tomo complemento a 2 de la variable signada
; en $82:$83
; byte alto en $82, bajo en $83
        ldhx #$0082         ;EE00
; invierto los dos bytes.
        com  ,X             ;EE03
        com  01,X           ;EE04
; incremento en 1 el bajo
        add  #01            ;EE06
        sta  01,X           ;EE08

; llevo el carry al alto, si hubiera.
        lda  ,X             ;EE0A
        adc  #00            ;EE0B
        sta  ,X             ;EE0D

; tengo otro signado en $80:$81
        ldhx #$0080         ;EE0E
; sumo los bytes bajos de las dos variables.
; resultado en la primera.
        lda  01,X           ;EEF1
        add  03,X           ;EEF3
        sta  01,X           ;EEF5

; sumo los bytes altos junto con el carry anterior.
; resultado en primer variable.
        lda  ,X             ;EEF7
        adc  02,X           ;EEF8
        sta  ,X             ;EEFA

end
        jmp end             ;

        org $FFFA

        dw start
        dw start
        dw start

