.model small
.stack
.data
    entrada DB ?
    saltoLinea DB 13, 10, '$'
    msj1 DB 'ingrese un numero:  $'
.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax

        ;Pedir a un usuario un caracter
        MOV dx, OFFSET msj1
        MOV ah, 9
        INT 21h
        
        MOV ah, 1h
        INT 21h

        ;Guardar el caracter en una variable
        MOV entrada, al

        ;salto de linea
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h

        ;imprimir nuevamente el caracter
        MOV dl, entrada
        MOV ah, 2h
        INT 21h

        ;finalizar programa
        MOV ah, 4Ch
        INT 21h
    main ENDP
    END main