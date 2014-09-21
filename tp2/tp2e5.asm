; Separa un bcd en [0, 9999] en sus componentes.
; Maskeo cada nibble con 0xF y guardo en otra variable.
        org $80
bcdin   dw  $1234
umil    rmb 1
ucen    rmb 1
udec    rmb 1
uuni    rmb 1


        org $EE00
start
; ucen = (bcdin & 0x0F00) >> 8
        lda bcdin
        and #$0F
        sta ucen

; umil = (bcdin & 0xF000) >> 12
; aca intercambio los nibbles de la parte alta, por eso la misma mascara.
        lda bcdin
        nsa
        and #$0F
        sta umil

; algo parecido con la parte baja de bcdin.
; uuni = (bcdin & 0x000F)
        lda bcdin+1
        and #$0F
        sta uuni

; udec = (bcdin & 0x00F0) >> 4
        lda bcdin+1
        nsa
        and #$0F
        sta udec

fin
        jmp fin

        org $FFFA

        dw start
        dw start
        dw start
