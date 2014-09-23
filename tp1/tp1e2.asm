        org $80
        db $B7,$01,$F6,$17,$F6,$10,$00,$3F,$FF,$CC,$CB,$BB,$BE,$00,$00,$FF

        org $EE00
start
;       nem                  addr   opc(hex)    dir         ccr
        ldhx #$008F         ;EE00   45008F      inmediato   -11-I---
        lda ,X              ;EE03   F6          indexado    (depende de donde apunte X)
        psha                ;EE04   87          inherente   =
        decx                ;EE05   5A          inherente   -11-I---
        cphx #$007F         ;EE06   65007F      inmediato   -11-I--- N=1 si H==0x007F
        bne *-6             ;EE09   26F8        relativo    
        ldx #$008F          ;EE0B   45008F      inmediato   
        pula                ;EE0D   86          inherente   (depende del valor en la pila)
        sta ,X              ;EE0E   F7          indexado    
        decx                ;EE0F   5A          inherente   
        cphx #$007F         ;EE10   65007F      inmediato   -11-I--- N=1 si H==0x007F
        bne *-6             ;EE13   26F8        relativo    

end
        jmp end             ;

        org $FFFA

        dw start
        dw start
        dw start

