; Tengo dos tablas contiguas en memoria (me aprovecho de este layout)
; Con X recorro la primera, la segunda con SP. La condicion de fin es cuando
; X apunta al primer elemento de la segunda.

        org $80

; import random
; [random.randrange(0, 127) for x in range(8)]
tbla    db !85,!117,!19,!94,!21,!55,!32,!27
tblb    db !3,!68,!34,!62,!85,!60,!124,!18

        org $EE00
start
        cli
        clrh

; apunto SP a la segunda tabla.
        ldhx #tblb
        txs

; X a la primera.
        ldhx #tbla

loop
; Tengo en A el elemento actual de la segunda tabla, lo comparo con el
; apuntado por X. Si es mayor no hago nada, ya estan en el orden esperado.
; Sino, reemplazo el elemento de la primer tabla con el de la segunda.
; SP ya apunta al siguiente.

        pula

        cmp ,X
        bgt amin
        sta ,X

amin
; Muevo X al proximo elemento. Si la direccion es la de la segunda tabla
; ya termine de procesar.
        incx
        cpx #tblb
        blt loop

end
        jmp end

        org $FFFA

        dw start
        dw start
        dw start
