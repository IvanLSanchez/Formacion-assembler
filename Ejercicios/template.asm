.model small
.stack
.data
    saltoLinea DB 13, 10, '$'

    msjCarga DB 'Ingrese un numero (presione enter para seguir): $'
    buffer DB 6 dup(?)
    aux DW 0

.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax
        
        ;salto de linea
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h

        ;finalizar programa
        MOV ah, 4Ch
        INT 21h
    main ENDP

    cargaNumero PROC
        ;mensaje
        MOV dx, OFFSET msjCarga
        MOV ah, 09h
        INT 21h

        ;carga de numero
        Digito:
            MOV ah, 01h
            INT 21h

            CMP al, 0Dh
            JE finCarga
            
            XOR ah, ah
            
            SUB al, 30h
            MOV bl, al
            
            MOV ax, aux
            MOV cx, 10d
            MUL cx
            ADD ax, bx
            MOV aux, ax

            JMP Digito
        finCarga:
            RET
    cargaNumero ENDP
    
    saltoDeLinea PROC
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h

        RET
    saltoDeLinea ENDP

    imprimirNumero PROC
        ;Imprime numero decimal
        MOV ax, aux
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
            JE finImpresion

            JMP imprimirBuffer
        finImpresion:
            RET
    imprimirNumero ENDP
    
    END main