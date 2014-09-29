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
;                            cycles.
hweight
        psha                ; 2
        clr 1,SP            ; 4 c en SP+1
        psha                ; 2 v en A y SP
                            ; 8 total.
; for (c = 0; v; c++) {
hweight_l1
        cmp #$0             ; 2
        beq hweight_fin     ; 3

;   v &= v - 1;
; lhs en A , rhs en SP
        dec 1,SP            ; 5
        and 1,SP            ; 4
        sta 1,SP            ; 4
        inc 2,SP            ; 5
        jmp hweight_l1      ; 3
                            ; 26 total.

hweight_fin
        lda 2,SP            ; 2
        ais #+2             ; 2
        rts                 ; 4
                            ; 8 total.

; hweight total de ciclos
; constantes: 8 + 8
; bucle interno: 26
; peor caso: 8 + 8 + (8 * 26) = 224


; Decodifica Hamming(7,4) pasado en A
; XXX: pasar flags de error y si corregido en MSB
;                           cycles.
hdec74
        pshh                ; 2
        pshx                ; 2

; Matriz para el calculo de paridad
        ldhx #h74_parity    ; 3
                            ; 7 total.

; dato original en SP
; sindrome en SP+1
; Multiplico H por el dato recibido.
; En este caso solo importa si la cantidad de unos es par o impar,
; por lo que solo considero el bit 0 del resultado.
; El bucle esta desenrrollado.

        psha                ; 2
        psha                ; 2
        clr 2,SP            ; 4
                            ; 8 total.

        and 0,X             ; 3
        jsr hweight         ; 5 + hweight
        and #$01            ; 2
        sta 2,SP            ; 4
        asl 2,SP            ; 5
                            ; 15 + hweight total.

        lda 1,SP            ; 2
        and 1,X             ; 3
        jsr hweight         ; 5 + hweight
        and #$01            ; 2
        ora 2,SP            ; 4
        sta 2,SP            ; 4
        asl 2,SP            ; 5
                            ; 25 + hweight total.

        lda 1,SP            ; 2
        and 2,X             ; 3
        jsr hweight         ; 5 + hweight
        and #$01            ; 2
        ora 2,SP            ; 4
        sta 2,SP            ; 4
                            ; 20 + hweight total.

        lda 2,SP            ; 2
        and #$07            ; 2
                            ; 4 total.

                            ; 8 + 15 + 25 + 20 + 4 + 3*hweight
                            ; 744 total peor caso.

; Si el resultado es nulo se que el dato recibido no contiene errores.
        beq hdec74_noerr    ; 3

; Caso contrario uno o mas bits estan invertidos.
; Errores en un bit pueden ser corregidos.
; Si solo hay un bit erroneo, el sindrome es a su vez la posicion del mismo.
; Invirtiendolo se obtiene el dato original.
; r = r ^ (1 << s)

; con esta tabla s=7 es en realidad el bit 0
        coma                ; 1
        and #$07            ; 2
        tax                 ; 1
        lda #$01            ; 2
                            ; 6 total.

; A = (1 << s)
hdec74_L0
        cpx #$00            ; 2
        beq hdec74_L0e      ; 3
        decx                ; 1
        asla                ; 1
        jmp hdec74_L0       ; 3
                            ; 10 total.
                            ; 70 peor caso.

hdec74_L0e
; A = r ^ A
        eor 1,SP            ; 4
        sta 1,SP            ; 4
                            ; 8 total.

; No hubo error o fue corregido.
; Reemplazo bit 3 que es paridad por el correspondiente dato.
hdec74_noerr
        lda 1,SP            ; 4
        bit #%10000         ; 2
        beq hdec74_b30      ; 3
        ora #%1000          ; 2
hdec74_b30
        and #%1111          ; 2
                            ; 13 total peor caso.


hdec74_fin
        ais #+2             ; 2
        pulx                ; 2
        pulh                ; 2

        rts                 ; 4
                            ; 10 total.

; hdec74 total de ciclos peor caso
; 7 + 744 + 3 + 6 + 70 + 8 + 13 + 10 = 861

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
