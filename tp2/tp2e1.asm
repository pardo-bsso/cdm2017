        org $80

; import random
; [random.randrange(0, 127) for x in range(8)]
tbla    db !85,!117,!19,!94,!21,!55,!32,!27
tblb    db !3,!68,!34,!62,!85,!60,!124,!18

        org $EE00
start
        cli
        clrh

        ldhx #tblb
        txs
        ldhx #tbla

loop
        pula

        cmp ,X
        bgt amin
        sta ,X

amin
        incx
        cpx #tblb
        blt loop

end
        jmp end

        org $FFFA

        dw start
        dw start
        dw start
