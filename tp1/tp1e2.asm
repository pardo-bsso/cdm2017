        org $80
        db $B7,$01,$F6,$17,$F6,$10,$00,$3F,$FF,$CC,$CB,$BB,$BE,$00,$00,$FF

        org $EE00
start
;       nem                  addr   opc(hex)    dir         ccr (solo primer iteracion)
        ldhx #$008F         ;EE00   45008F      inmediato   01101000
        lda ,X              ;EE03   F6          indexado    01101100
        psha                ;EE04   87          inherente   01101100
        decx                ;EE05   5A          inherente   01101100
        cphx #$007F         ;EE06   65007F      inmediato   01101000 N=1 si H==0x007F
        bne *-6             ;EE09   26F8        relativo    

                            ;                               una iteracion. Ya pase por el bucle anterior
        ldx #$008F          ;EE0B   45008F      inmediato   01101100
        pula                ;EE0D   86          inherente   01101100
        sta ,X              ;EE0E   F7          indexado    01101100
        decx                ;EE0F   5A          inherente   01101100
        cphx #$007F         ;EE10   65007F      inmediato   01101000 N=1 si H==0x007F
        bne *-6             ;EE13   26F8        relativo    

end
        jmp end             ;

        org $FFFA

        dw start
        dw start
        dw start

