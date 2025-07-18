.model small
.stack
.data
    saltoLinea DB 13, 10, '$'

    n1 DW 0
    n2 DW 0
    n3 DW 0

    msj1 DB 'Ingrese un numero (presione enter para seguir): $'
    msj2 DB 'ORDENANDO. . .$'
    msj3 DB '  $'

    buffer DB 6 dup(?)

.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax
        
        mensajePrimerDigito:
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

        mensajeSegundoDigito:
            ;salto de linea *2
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

            ;pedir segundo numero
            MOV dx, OFFSET msj1
            MOV ah, 09h
            INT 21h

        segundoDigito:
            MOV ah, 01h
            INT 21h

            CMP al, 0Dh
            JE mensajeTercerDigito
            
            XOR ah, ah
            
            SUB al, 30h
            MOV bl, al
            
            MOV ax, n2
            MOV ch, 10d
            MUL ch
            ADD ax, bx
            MOV n2, ax

            JMP segundoDigito

        mensajeTercerDigito:
            ;salto de linea *2
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

            ;pedir tercer numero
            MOV dx, OFFSET msj1
            MOV ah, 09h
            INT 21h
        
        tercerDigito:
            MOV ah, 01h
            INT 21h

            CMP al, 0Dh
            JE ordenamiento
            
            XOR ah, ah
            
            SUB al, 30h
            MOV bl, al
            
            MOV ax, n3
            MOV ch, 10d
            MUL ch
            ADD ax, bx
            MOV n3, ax

            JMP tercerDigito

        ordenamiento:
            ;salto de linea *2
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

            ;mensaje
            MOV dx, OFFSET msj2
            MOV ah, 09h
            INT 21h

            XOR ax, ax
            XOR bx, bx
            XOR cx, cx

            MOV ax, n1
            MOV bx, n2
            MOV cx, n3

            primerComparacion:
                ;ordenar por metodo de burbujeo
                CMP ax, bx
                JB segundaComparacion
                
                XCHG ax,bx

            segundaComparacion:
                CMP bx, cx
                JB tercerComparacion

                XCHG bx, cx

            tercerComparacion:
                CMP ax, bx
                JB imprimir

                XCHG ax, bx

        imprimir:
            MOV n1, ax
            MOV n2, bx
            MOV n3, cx

            ;salto de linea *2
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h

            ;imprimir numeros ordenados
            MOV ax, n1
            XOR si, si
            XOR bx, bx

            cargarBufferUno:
                XOR dx, dx
                MOV bx, 10d
                div bx
                
                ADD dx, 30h
                MOV buffer[si], dl

                INC si

                CMP ax, 0d 
                JE imprimirBufferUno
                
                JMP cargarBufferUno

            imprimirBufferUno:
                DEC si
                MOV dl, buffer[si]
                MOV ah, 02h
                INT 21h
                
                CMP si, 0d 
                JE numeroDos

                JMP imprimirBufferUno

            numeroDos:
                ;imprimir espacio
                XOR dx, dx
                MOV dl, OFFSET msj3
                MOV ah, 09h
                INT 21h
                
                MOV ax, n2
                XOR si, si
                XOR bx, bx

                cargarBufferDos:
                    XOR dx, dx
                    MOV bx, 10d
                    div bx
                    
                    ADD dx, 30h
                    MOV buffer[si], dl

                    INC si

                    CMP ax, 0d 
                    JE imprimirBufferDos
                    
                    JMP cargarBufferDos

                imprimirBufferDos:
                    DEC si
                    MOV dl, buffer[si]
                    MOV ah, 02h
                    INT 21h
                    
                    CMP si, 0d 
                    JE numeroTres

                    JMP imprimirBufferDos
            numeroTres:
                ;imprimir espacio
                XOR dx, dx
                MOV dl, OFFSET msj3
                MOV ah, 09h
                INT 21h

                MOV ax, n3
                XOR si, si
                XOR bx, bx

                cargarBufferTres:
                    XOR dx, dx
                    MOV bx, 10d
                    div bx
                    
                    ADD dx, 30h
                    MOV buffer[si], dl

                    INC si

                    CMP ax, 0d 
                    JE imprimirBufferTres
                    
                    JMP cargarBufferTres

                imprimirBufferTres:
                    DEC si
                    MOV dl, buffer[si]
                    MOV ah, 02h
                    INT 21h
                    
                    CMP si, 0d 
                    JE fin

                    JMP imprimirBufferTres
        fin:
            ;finalizar programa
            MOV ah, 4Ch
            INT 21h
    main ENDP
    END main