.model small
.stack
.data
    saltoLinea DB 13, 10, '$'
    
    numeroSecreto DB 65
    n1 DW 0
    
    msj1 DB 'Ingrese un numero del 0 al 99 (presione enter para seguir): $'
    msjMayor DB 'Mayor$'
    msjMenor DB 'Menor$'
    msjDescubierto DB 'Me haz descubierto tio joder. yo crei que nunca me descubirias >:($'

    i DW 1    
    buffer DB 4 DUP(?)
.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax
        
        cicloFor:
            ;pedir primer numero
            MOV dx, OFFSET msj1
            MOV ah, 09h
            INT 21h

            Digito:
                MOV ah, 01h
                INT 21h

                CMP al, 0Dh
                JE mensaje
                
                XOR ah, ah
                
                SUB al, 30h
                MOV bl, al
                
                MOV ax, n1
                MOV ch, 10d
                MUL ch
                ADD ax, bx
                MOV n1, ax

                JMP Digito
    
            mensaje:
                ;salto de linea
                MOV dx, OFFSET saltoLinea
                MOV ah, 09h
                INT 21h
                MOV dx, OFFSET saltoLinea
                MOV ah, 09h
                INT 21h
                
                XOR ax,ax
                XOR bx,bx
                
                MOV ax, n1
                MOV bl, numeroSecreto
                
                CMP ax, bx
                JE descubierto
                JB mayor
                JA menor

                descubierto:
                    MOV dx, OFFSET msjDescubierto
                    MOV ah, 09h
                    INT 21h
                    
                    ;salto de linea
                    MOV dx, OFFSET saltoLinea
                    MOV ah, 09h
                    INT 21h
                    MOV dx, OFFSET saltoLinea
                    MOV ah, 09h
                    INT 21h
                    
                    ;imprimir intentos
                    MOV ax, i
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
                        JE salto

                        JMP imprimirBuffer
    
                    salto:
                        JMP fin

                mayor:
                    MOV dx, OFFSET msjMayor
                    MOV ah, 09h
                    INT 21h
                    JMP finCiclo 

                menor:
                    MOV dx, OFFSET msjMenor
                    MOV ah, 09h
                    INT 21h
                    JMP finCiclo
            
            finCiclo:
                ;salto de linea
                MOV dx, OFFSET saltoLinea
                MOV ah, 09h
                INT 21h
                MOV dx, OFFSET saltoLinea
                MOV ah, 09h
                INT 21h

                MOV n1, 0
                INC i

                JMP cicloFor
        fin:
        ;finalizar programa
        MOV ah, 4Ch
        INT 21h
    main ENDP
    END main