.model small
.stack
.data
    saltoLinea DB 13, 10, '$'

    frase DB 'tu alma brilla con fuerza cuando el mundo calla, y tus pasos siguen sin temor. $'
    
    vocales DB 5 dup(0)
    
    msj1 DB 'CANTIDAD DE LETRAS A: $'
    msj2 DB 'CANTIDAD DE LETRAS E: $'
    msj3 DB 'CANTIDAD DE LETRAS I: $'
    msj4 DB 'CANTIDAD DE LETRAS O: $'
    msj5 DB 'CANTIDAD DE LETRAS U: $'
.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax

        ;preparar contador
        XOR si, si

        bucleFor:
            ;Condicion de fin
            CMP frase[si],'$' 
            JE imprimir
            
            ;agarro caracter de la frase
            MOV al, frase[si]
            
            ;Compara
            CMP ax, 61h
            JE A
            CMP ax, 65h
            JE E
            CMP ax, 69h
            JE I
            CMP ax, 6Fh
            JE O
            CMP ax, 75h
            JE U
            JMP incrementar
            
            A:
                INC vocales[0]
                JMP incrementar
            E:
                INC vocales[1]
                JMP incrementar
            I:
                INC vocales[2]
                JMP incrementar
            O:
                INC vocales[3]
                JMP incrementar
            U:
                INC vocales[4]
                JMP incrementar

            incrementar:
                ;incrementar
                INC si
                JMP bucleFor
            
        imprimir:
            MOV dx, OFFSET msj1
            MOV ah, 09h
            INT 21h
            MOV dl, vocales[0]
            ADD dl, 30h
            MOV ah, 02h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

            MOV dx, OFFSET msj2
            MOV ah, 09h
            INT 21h
            MOV dl, vocales[1]
            ADD dl, 30h
            MOV ah, 02h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

            MOV dx, OFFSET msj3
            MOV ah, 09h
            INT 21h
            MOV dl, vocales[2]
            ADD dl, 30h
            MOV ah, 02h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

            MOV dx, OFFSET msj4
            MOV ah, 09h
            INT 21h
            MOV dl, vocales[3]
            ADD dl, 30h
            MOV ah, 02h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

            MOV dx, OFFSET msj5
            MOV ah, 09h
            INT 21h
            MOV dl, vocales[4]
            ADD dl, 30h
            MOV ah, 02h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

        ;finalizar programa
        MOV ah, 4Ch
        INT 21h
    main ENDP
    END main