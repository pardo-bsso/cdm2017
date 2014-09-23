        org $80

        org $EE00
start
;       nem                  addr   opc(hex)    dir         ccr
        ldhx #$0080         ;EE00   450080      inmediato   -11-I---
        lda #$90            ;EE03   A690        inmediato   -11-IN--
        psha                ;EE05   87          inherente   =
        lda ,X              ;EE06   F6          indexado    -11-I---
        bit #$01            ;EE07   A501        inmediato   011--??-
        beq *+0C            ;EE09   270A        relativo    -11-----
        pshx                ;EE0B   89          inherente   -11-----
        ldx $2,sp           ;EE0C   9EEE02      indexado SP 011--??-
        sta ,X              ;EE0F   F7          inherente   011--??-
        incx                ;EE10   5C          inherente   011--?--
        stx $2,sp           ;EE11   9EEF02      indexado SP 011--??-
        pulx                ;EE14   88          inherente   011-----
        incx                ;EE15   5C          inherente   011--?--
        cphx #$0090         ;EE16   650090      inmediato   011--???
        bne *-13            ;EE19   26EB        relativo    -11-----

end
        jmp end             ;

        org $FFFA

        dw start
        dw start
        dw start

