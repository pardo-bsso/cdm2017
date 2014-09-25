        org $80


        org $EE00
start


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

hweight_l1
        cmp #$0
        beq hweight_fin

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




; Vector interrupciones.
        org $FFFA

        dw start
        dw start
        dw start
