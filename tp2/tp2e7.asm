        org $80

len     db !10
str     db 'abc'
        db $0
        db 'cd'
        db $0
        db 'ef'
        db $0

        org $EE00
start

        lda $80
        add #$81
        deca
        tax

loop
        lda ,X
        beq repl
        jmp loop_tail

repl
        lda $20
        sta ,X

loop_tail
        decx
        cpx #$80
        bgt loop

fin
        jmp fin

        org $FFFA

        dw start
        dw start
        dw start
