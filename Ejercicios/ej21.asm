.model small
.stack
.data
    arr DB 1,2,3,4
    saltoLinea DB 13, 10, '$'
.code
    main PROC
        ; importar data
        MOV ax, @data
        MOV ds, ax

        ; resetear registros
        XOR ax, ax
        XOR si, si
        MOV cx, 4
        
        ; sumar arreglo
        sumaLoop:
            mov bl, arr[si]
            add al, bl
            inc si
            loop sumaLoop

        ; mostrar en pantalla
        aam
        
        mov cl, al
        add cl, 30h

        mov ch, ah
        add ch, 30h
        
        MOV dl, ch
        MOV ah, 2h
        int 21h

        MOV dl, cl
        MOV ah, 2h
        int 21h

        ;finalizar
        MOV ah, 4Ch
        int 21h
    main ENDP
    END main