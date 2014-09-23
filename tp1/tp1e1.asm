        org $80

        org $EE00
start
;       nem                  addr   opc(hex)    dir         ccr
        clr $80             ;EE00   3F80        directo     011--01-
        lda #$08            ;EE02   A608        inmediato   011--  -
        sta $81             ;EE04   B781        directo     011--  -
        lda #%10010110      ;EE06   A696        inmediato   011--10-
        rola                ;EE08   49          inherente   111----1
        ror $80             ;EE09   3680        directo     111--1--
        dec $81             ;EE0B   3A81        directo     
; PC = PC + 0x0002 + rel
; rel = EE08 - (EE0D + 0x0002) = -7
; rel = F9
        bne *-05            ;EE0D   26F9        relativo    
        swi                 ;EE0F   83          inherente   

end
        jmp end             ;EE10   CCEE10

        org $FFFA

        dw start
        dw start
        dw start

