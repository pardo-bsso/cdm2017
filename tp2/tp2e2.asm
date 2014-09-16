        org $80
len     db !5
tbl     db !1,!2,!3,!4,!5
tmp     rmb 1

        org $EE00
start
        cli
        clrh

        lda #tbl
        tax
        txs
        add len
        tax
        decx

loop
        stx tmp
        tsx
        txa
        cmp tmp
        bge fin
        ldx tmp

        pula
        sta tmp
        lda ,X
        psha
        pula
        lda tmp
        sta ,X
        decx
        jmp loop

fin
        jmp fin

        org $FFFA

        dw start
        dw start
        dw start
