.model small
.stack
.data
.code
    main PROC
        ;AX=5    BX=2    CX=3
        XOR ax,ax
        XOR bx,bx
        XOR cx, cx

        MOV ax, 5
        MOV bx, 2
        MOV cx, 3

        ;(AX+BX)*CX
        ADD ax, bx ;(7)
        XOR dx, dx ;limpio DX
        MUL cx ;(21)
        
        ;preparar impresion
        aam ;AH=DECENAS(2), AL=UNIDADES(1)

        ;transformar en ascii
        ;como necesitamos la variable AH para la interrupcion
        ;movemos AL y AH a CL y CH
        MOV cl, al
        ADD cl, 30h

        MOV ch, ah
        ADD ch, 30h

        ;imprimir decenas (CH) 
        MOV dl, ch
        MOV ah, 2h
        int 21h

        ;imprimir unidades (CL)
        MOV dl, cl
        MOV ah, 2h
        int 21h

        ;finalizar
        MOV ah, 4Ch
        int 21h

    main ENDP
    END main