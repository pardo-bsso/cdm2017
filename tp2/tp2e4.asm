; Sumar tres numeros de 16 bits (na, nb, nc)
; En este caso el acarreo en byte alto es ignorado, dando resultados erroneos
; si en algun paso la suma excede 0xFFFF.
;
; El proceso se hace por partes, sumando primero dos bytes bajos y luego dos
; altos mas el carry de la primer operacion, quedando el resultado en la
; variable de salida.
; Esto se repite entre el resultado intermedio y el numero de entrada restante.

        org $80
na      dw $DEAD
nb      dw $BEEF
nc      dw $BADC

        org $90
res     rmb 2

; Atajos para acceder al byte alto/bajo de cada parametro y hacer, un poco,
; mas legible el resto.
naH     equ na
naL     equ na+1
nbH     equ nb
nbL     equ nb+1
ncH     equ nc
ncL     equ nc+1
resH    equ res
resL    equ res+1

        org $EE00
start
; Borro carry, sumo byte bajo de na y nb.
; Resultado en variable de salida.
        clc
        lda naL
        adc nbL
        sta resL

; Sumo bytes altos de na y nb mas el carry de la operacion anterior.
; Resultado en variable de salida.
        lda naH
        adc nbH
        sta resH

; Igual que antes pero entre el resultado y nc.
        clc
        lda ncL
        adc resL
        sta resL
        lda ncH
        adc resH
        sta resH

fin
        jmp fin

        org $FFFA

        dw start
        dw start
        dw start
