.model small
.stack
.data
    saltoLinea DB 13, 10, '$'

    msjCarga DB 'Ingrese un numero decimal (presione enter para seguir): $'
    msjH DB 'El digito ingresado en Hexadecimal es: $'
    msjD DB 'El digito ingresado en Decimal es: $'
    msjB DB 'El digito ingresado en Binario es: $'
    msjO DB 'El digito ingresado en octal es: $'
    
    buffer DB 16 dup(?)
    aux DW 0

.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax
        
        ;ingreso de numero
        CALL cargaNumero

        ;salto linea *2
        CALL saltoDeLinea

        ;impresion decimal
        CALL imprimirNumeroD

        ;salto linea *2
        CALL saltoDeLinea

        ;impresion binaria
        CALL imprimirNumeroB

        ;salto linea *2
        CALL saltoDeLinea

        ;impresion octal
        CALL imprimirNumeroO

        ;salto linea *2
        CALL saltoDeLinea

        ;impresion hexadecimal
        CALL imprimirNumeroH
        
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
    
    imprimirNumeroD PROC
        MOV dx, OFFSET msjD
        MOV ah, 09h
        INT 21h
        
        MOV ax, aux
        XOR si, si
        XOR bx, bx

        cargarBufferD:
            XOR dx, dx
            MOV bx, 10d
            div bx
            
            ADD dx, 30h
            MOV buffer[si], dl

            INC si

            CMP ax, 0d 
            JE imprimirBufferD
            
            JMP cargarBufferD

        imprimirBufferD:
            DEC si
            MOV dl, buffer[si]
            MOV ah, 02h
            INT 21h
            
            CMP si, 0d 
            JE finImpresionD

            JMP imprimirBufferD
        finImpresionD:
            RET
    imprimirNumeroD ENDP

    imprimirNumeroB PROC
        MOV dx, OFFSET msjB
        MOV ah, 09h
        INT 21h

        MOV ax, aux
        XOR si, si
        XOR bx, bx

        cargarBufferB:
            XOR dx, dx
            MOV bx, 2d
            div bx
            
            ADD dx, 30h
            MOV buffer[si], dl

            INC si

            CMP ax, 0d 
            JE imprimirBufferB
            
            JMP cargarBufferB

        imprimirBufferB:
            DEC si
            MOV dl, buffer[si]
            MOV ah, 02h
            INT 21h
            
            CMP si, 0d 
            JE finImpresionB

            JMP imprimirBufferB
        finImpresionB:
            RET
    imprimirNumeroB ENDP

    imprimirNumeroO PROC
        MOV dx, OFFSET msjO
        MOV ah, 09h
        INT 21h

        MOV ax, aux
        XOR si, si
        XOR bx, bx

        cargarBufferO:
            XOR dx, dx
            MOV bx, 8d
            div bx
            
            ADD dx, 30h
            MOV buffer[si], dl

            INC si

            CMP ax, 0d 
            JE imprimirBufferO
            
            JMP cargarBufferO

        imprimirBufferO:
            DEC si
            MOV dl, buffer[si]
            MOV ah, 02h
            INT 21h
            
            CMP si, 0d 
            JE finImpresionO

            JMP imprimirBufferO
        finImpresionO:
            RET
    imprimirNumeroO ENDP

    imprimirNumeroH PROC
        MOV dx, OFFSET msjH
        MOV ah, 09h
        INT 21h

        MOV ax, aux
        XOR si, si
        XOR bx, bx

        cargarBufferH:
            XOR dx, dx
            MOV bx, 16d
            div bx
            
            CMP dx, 10d
            JE A

            CMP dx, 11d
            JE B

            CMP dx, 12d
            JE C
            
            CMP dx, 13d
            JE D
            
            CMP dx, 14d
            JE E
            
            CMP dx, 15d
            JE F 

            ADD dx, 30h
            MOV buffer[si], dl
            JMP cargaCompleta

            A:
                MOV buffer[si], 41h
                JMP cargaCompleta
            B:
                MOV buffer[si], 42h
                JMP cargaCompleta
            C:
                MOV buffer[si], 43h
                JMP cargaCompleta
            D:
                MOV buffer[si], 44h
                JMP cargaCompleta
            E:
                MOV buffer[si], 45h
                JMP cargaCompleta
            F:
                MOV buffer[si], 46h
                JMP cargaCompleta
            

            cargaCompleta:
                INC si

                CMP ax, 0d 
                JE imprimirBufferH
            
                JMP cargarBufferH

        imprimirBufferH:
            DEC si
            MOV dl, buffer[si]
            MOV ah, 02h
            INT 21h
            
            CMP si, 0d 
            JE finImpresionH

            JMP imprimirBufferH
        finImpresionH:
            RET
    imprimirNumeroH ENDP    

    END main