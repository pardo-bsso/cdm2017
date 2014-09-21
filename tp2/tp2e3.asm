; Pasar de minuscula a mayuscula.
; Letras minusculas son ascii de 97 a 122 inclusive.
; Mayusculas de 65 a 90.
; Solo en ese rango restando 32 se hace la conversion.

        org $90

        db 'uNa cADeNa XXaa'
        db $0D

        org $EE00
start
; Apunto X al inicio de la cadena.
        clrh
        ldhx #$0090

loop
; Si llego a un \r termine de procesar.
        lda #$0D
        cmp ,X
        beq fin

; Si el caracter no esta en [97, 122] no proceso.
; Comparo A con el caracter actual.
; Si 97 es >= que el caracter no proceso.
        lda #!97
        cmp ,X
        bgt loop_tail

; Lo mismo si 122 es <= que el caracter.
        lda #!122
        cmp ,X
        blt loop_tail

; Paso a minuscula. Resto 32 de A y reemplazo
; el caracter actual con el resultado.
        lda ,X
        sub #!32
        sta ,X

loop_tail
; Avanzo X al siguiente elemento.
        incx
        jmp loop

fin
        jmp fin

        org $FFFA

        dw start
        dw start
        dw start
