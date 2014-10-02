        org $80

        org $EE00
start
;       nem                  addr   opc(hex)    dir         ccr (solo primer iteracion)
        ldhx #$0080         ;EE00   450080      inmediato   01101000
        lda #$90            ;EE03   A690        inmediato   01101100
        psha                ;EE05   87          inherente   01101100
        lda ,X              ;EE06   F6          indexado    01101100
        bit #$01            ;EE07   A501        inmediato   01101000
        beq *+0C            ;EE09   270A        relativo
        pshx                ;EE0B   89          inherente   01101000
        ldx $2,sp           ;EE0C   9EEE02      indexado SP 01101100
        sta ,X              ;EE0F   F7          inherente   01101100
        incx                ;EE10   5C          inherente   01101100
        stx $2,sp           ;EE11   9EEF02      indexado SP 01101100
        pulx                ;EE14   88          inherente   01101100
        incx                ;EE15   5C          inherente   01101100
        cphx #$0090         ;EE16   650090      inmediato   01101101
        bne *-13            ;EE19   26EB        relativo

end
        jmp end             ;

        org $FFFA

        dw start
        dw start
        dw start

