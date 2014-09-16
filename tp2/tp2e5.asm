        org $80
bcdin   dw  $1234
umil    rmb 1
ucen    rmb 1
udec    rmb 1
uuni    rmb 1


        org $EE00
start
        lda bcdin
        and #$0F
        sta ucen
        lda bcdin
        nsa
        and #$0F
        sta umil

        lda bcdin+1
        and #$0F
        sta uuni
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
