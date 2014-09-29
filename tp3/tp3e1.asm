        org $80


        org $EE00
start
        clrx

        lda #%1110101
        jsr hdec74
        lda #%1010101
        jsr hdec74
        lda #%1010100
        jsr hdec74


fin
        jmp fin

; Hamming Weight.
; bithacks, version de Kernighan.
; unsigned int v;
; unsigned int c;
; for (c = 0; v; c++) {
;   v &= v - 1;
; }

; v en A.
; devuelve cuenta en A.
hweight
        psha
        clr 1,SP        ; c en SP+1
        psha            ; v en A y SP

; for (c = 0; v; c++) {
hweight_l1
        cmp #$0
        beq hweight_fin

;   v &= v - 1;
; lhs en A , rhs en SP
        dec 1,SP
        and 1,SP
        sta 1,SP
        inc 2,SP
        jmp hweight_l1

hweight_fin
        lda 2,SP
        ais #+2
        rts


; Decodifica Hamming(7,4) pasado en A
; XXX: pasar flags de error y si corregido en MSB
hdec74
        pshh
        pshx

; Matriz para el calculo de paridad
        ldhx #h74_parity

; dato original en SP
; sindrome en SP+1
; Multiplico H por el dato recibido.
; En este caso solo importa si la cantidad de unos es par o impar,
; por lo que solo considero el bit 0 del resultado.
; El bucle esta desenrrollado.

        psha
        psha
        clr 2,SP

        and 0,X
        jsr hweight
        and #$01
        sta 2,SP
        asl 2,SP

        lda 1,SP
        and 1,X
        jsr hweight
        and #$01
        ora 2,SP
        sta 2,SP
        asl 2,SP

        lda 1,SP
        and 2,X
        jsr hweight
        and #$01
        ora 2,SP
        sta 2,SP

        lda 2,SP
        and #$07

; Si el resultado es nulo se que el dato recibido no contiene errores.
        beq hdec74_noerr

; Caso contrario uno o mas bits estan invertidos.
; Errores en un bit pueden ser corregidos.
; Si solo hay un bit erroneo, el sindrome es a su vez la posicion del mismo.
; Invirtiendolo se obtiene el dato original.
; r = r ^ (1 << s)

; con esta tabla s=7 es en realidad el bit 0
        coma
        and #$07
        tax
        lda #$01

; A = (1 << s)
hdec74_L0
        cpx #$00
        beq hdec74_L0e
        decx
        asla
        jmp hdec74_L0

hdec74_L0e
; A = r ^ A
        eor 1,SP
        sta 1,SP


; No hubo error o fue corregido.
; Reemplazo bit 3 que es paridad por el correspondiente dato.
hdec74_noerr
        lda 1,SP
        bit #%10000
        beq hdec74_b30
        ora #%1000
hdec74_b30
        and #%1111


hdec74_fin
        ais #+2 ;XXX FIXME: ver que apunte bien al final.
        pulx
        pulh

        rts

; Ziemer , Principles of Communications cap 11
h74_parity
        db %0001111
        db %0110011
        db %1010101





; Vector interrupciones.
        org $FFFA

        dw start
        dw start
        dw start
