.model small
.stack
.data
    saltoLinea DB 13, 10, '$'

    msj1 DB 'Ingrese un numero (presione enter para seguir): $'
    msj2 DB 'Ingrese la operacion a realizar (+ o -): $'
    
    operador DB ?
    igual DB ' = $'
    espacio DB ' $'

    n1 DW 0
    n2 DW 0
    buffer DB 6 dup(?)

.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax

        ;pedir primer numero
        MOV dx, OFFSET msj1
        MOV ah, 09h
        INT 21h
        
        primerDigito:
            MOV ah, 01h
            INT 21h

            CMP al, 0Dh
            JE mensajeSegundoDigito
            
            XOR ah, ah
            
            SUB al, 30h
            MOV bl, al
            
            MOV ax, n1
            MOV ch, 10d
            MUL ch
            ADD ax, bx
            MOV n1, ax

            JMP primerDigito

        ;pedir segundo numero
        mensajeSegundoDigito:
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

            MOV dx, OFFSET msj1
            MOV ah, 09h
            INT 21h

        segundoDigito:
            MOV ah, 01h
            INT 21h

            CMP al, 0Dh
            JE mensajeOperacion
            
            XOR ah, ah
            
            SUB al, 30h
            MOV bl, al
            
            MOV ax, n2
            MOV ch, 10d
            MUL ch
            ADD ax, bx
            MOV n2, ax

            JMP segundoDigito

        ;pedir operacion
        mensajeOperacion:
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            ;consulta operando
            MOV dx, OFFSET msj2
            MOV ah, 9h
            INT 21h
            XOR ax, ax

            MOV ah, 1h 
            INT 21h
            MOV operador, al

            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h

        XOR bx, bx
        MOV bx, n1
        XOR cx, cx
        MOV cx, n2

        ;operacion (*= 2a, -=2D)
        CMP operador, 2Bh
        JE suma
        CMP operador, 2Dh
        JE resta
        CMP operador, 2Ah
        JE multiplicar
        JMP dividir
 
        suma:
            ADD bx, cx
            JMP imprimirNumero
        resta:
            SUB bx, cx
    
            CMP bx, 0d
            JL imprimirNegativo
            
            JMP imprimirNumero
        imprimirNegativo:
            ;signo -
            MOV dl, 2Dh
            MOV ah, 2h
            INT 21h
            
            ;valor absoluto
            ADD bx, cx
            SUB cx, bx
            MOV bx, cx
            
            JMP imprimirNumero
        multiplicar:
        dividir:
        
        ;impresion
        imprimirNumero:
            MOV ax, bx
            XOR si, si
            XOR bx, bx

            cargarBuffer:
                XOR dx, dx
                MOV bx, 10d
                div bx
                
                ADD dx, 30h
                MOV buffer[si], dl

                INC si

                CMP ax, 0d 
                JE imprimirBuffer
                
                JMP cargarBuffer

            imprimirBuffer:
                DEC si
                MOV dl, buffer[si]
                MOV ah, 02h
                INT 21h
                
                CMP si, 0d 
                JE fin

                JMP imprimirBuffer
        ;fin del programa
        fin:
            MOV ah, 4Ch
            INT 21h
    main ENDP
    END main