
; Apunto SP al principio de la tabla y H:X al final.
; Intercambio los elementos, incremento SP, decremento X.
; Dependiendo si la longitud de la tabla es par o impar en un punto SP y X
; o se cruzan o toman el mismo valor. Ahi termine de invertir la tabla.
;         -------------------
; SP |    |      $0081      |
;    V    -------------------
;                  |
;                  |
;     ^   -------------------
; H:X |   | $0081 + len - 1 |
;         -------------------


        org $80
len     db !5
tbl     db !1,!2,!3,!4,!5
tmp     rmb 1

        org $EE00
start
; si voy a usar SP como puntero tengo que deshabilitar interrupciones.
; (y dejarlo donde estaba despues ... )
        cli
        clrh

; SP apunta a principio de la tabla.
        lda #tbl
        tax
        txs

; X al final. ( X = $80 + len - 1 )
        add len
        tax
        decx


loop

; Comparo X y SP. Si SP apunta a una direccion >= que X termine.
; guardo X en tmp, paso SP a A via X. Comparo A (== SP) con tmp (== X).
        stx tmp
        tsx
        txa
        cmp tmp
        bge fin
; restauro X a la posicion original.
        ldx tmp

; guardo en tmp el elemento superior actual.
; Ahora SP apunta al siguiente.
        pula
        sta tmp

; guardo en la posicion superior el valor apuntado por X
; ahora SP apunta al superior actual.
        lda ,X
        psha

; hace que SP apunte al siguiente elemento para la proxima iteracion.
        pula

; guardo en la posicion inferior el valor que tenia antes el elemento superior.
        lda tmp
        sta ,X

; muevo X al proximo elemento.
        decx

        jmp loop

fin
        jmp fin

        org $FFFA

        dw start
        dw start
        dw start
