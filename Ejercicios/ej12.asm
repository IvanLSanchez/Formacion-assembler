.model small
.stack
.data
    saltoLinea DB 13, 10, '$'
    msj1 DB 'insgrse un numero: $'
    msj2 DB ' mayor que $'
    msj3 DB 'Son iguales$'
    n1 DB ?
    n2 DB ?
.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax
        
        ;ingreso numero 1
        MOV ah, 9h
        LEA dx, msj1
        INT 21h
        
        XOR ax, ax

        MOV ah, 1h
        INT 21h

        MOV n1, al
        SUB n1, 30h 
        
        XOR ax, ax

        ;salto de linea
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h

        ;ingreso numero 2
        MOV ah, 9h
        LEA dx, msj1
        INT 21h
        
        XOR ax, ax

        MOV ah, 1h
        INT 21h

        MOV n2, al
        SUB n2, 30h 
        
        XOR ax, ax

        ;salto de linea
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h

        ;Comparacion
        MOV al, n1
        MOV bl, n2

        ADD n1, 30h
        ADD n2, 30h

        CMP al, bl
        JB nDosMayor
        JA nUnoMayor

        iguales:
            MOV ah, 09h
            LEA dx, msj3
            INT 21h

            JMP fin

        nUnoMayor:
            MOV dl, n1
            MOV ah, 02h
            INT 21h

            MOV ah, 09h
            LEA dx, msj2
            INT 21h

            MOV dl, n2
            MOV ah, 02h
            INT 21h

            JMP fin
        nDosMayor:
            MOV dl, n2
            MOV ah, 02h
            INT 21h

            MOV ah, 09h
            LEA dx, msj2
            INT 21h

            MOV dl, n1
            MOV ah, 02h
            INT 21h

        fin:
            ;finalizar programa
            MOV ah, 4Ch
            INT 21h
    main ENDP
    END main