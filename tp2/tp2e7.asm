; Apunto X al final de la cadena
; X = 0x0081 + len - 1
; Recorro para atras, me aprovecho que al cargar A con 0
; beq branchea.
; Cuando X apunta a 0x0080 ya termine.

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

; X apunta al final de la cadena. Ver arriba.
        lda $80
        add #$81
        deca
        tax

loop
; Cargo en A elemento actual, si es 0 lo reemplazo por 0x20.
        lda ,X
        beq repl
        jmp loop_tail

repl
        lda $20
        sta ,X

loop_tail
; Apunto X al elemento anterior. Si es 0x0080 ya termine.
        decx
        cpx #$80
        bgt loop

fin
        jmp fin

        org $FFFA

        dw start
        dw start
        dw start
