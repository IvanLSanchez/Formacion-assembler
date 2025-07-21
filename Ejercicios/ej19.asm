.model small
.stack
.data
    saltoLinea DB 13, 10, '$'

    msjCarga DB 'Ingrese un numero (presione enter para seguir): $'
    buffer DB 16 dup(?)
    aux DW 0

    msj2 DB 'Ingrese la operacion a realizar (+, -, * o /): $'
    
    msjError DB 'ERROR: no se puede dividir entre 0$'
    msjH DB 'Hexadecimal es: $'
    msjD DB 'Decimal es: $'
    msjB DB 'Binario es: $'
    msjO DB 'Octal es: $'
    
    operador DB ?
    igual DB ' = $'
    espacio DB ' $'

    n1 DW 0
    n2 DW 0

    cociente DW 0
    resto DW 0
    esNegativo DB 0
.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax

        ;pedir n1
        CALL cargaNumero
        XOR ax,ax
        MOV ax,aux 
        MOV aux, 0
        MOV n1, ax

        ;salto de linea x2
        CALL saltoDeLinea
        
        ;pedir operando
        CALL cargarOperando

        ;salto de linea x2
        CALL saltoDeLinea

        ;pedir n2
        CALL cargaNumero
        XOR ax,ax
        MOV ax,aux 
        MOV aux, 0
        MOV n2, ax

        ;salto de linea x2
        CALL saltoDeLinea

        ;mensaje de operacion
        CALL imprimirOperacion
        
        ;operacion
        MOV cl, operador

        CMP cl, 2Bh
        JE HACER_SUMA

        CMP cl, 2Dh
        JE HACER_RESTA

        CMP cl, 2Fh
        JE HACER_DIVI

        CMP cl, 2Ah
        JE HACER_MULTI

        HACER_SUMA:
            CALL suma
            JMP imprimir
        
        HACER_RESTA:
            CALL resta
            JMP imprimir            
        
        HACER_MULTI:
            CALL multiplicacion
            JMP imprimir
            
        HACER_DIVI:
            CALL division
            JMP fin
                    
        imprimir:
            CALL saltoDeLinea
            MOV dx, OFFSET msjD
            MOV ah, 09h
            INT 21h
            CALL imprimirSignoMenos
            CALL imprimirNumeroD
            
            CALL saltoDeLinea
            MOV dx, OFFSET msjB
            MOV ah, 09h
            INT 21h
            CALL imprimirSignoMenos
            CALL imprimirNumeroB
            
            CALL saltoDeLinea
            MOV dx, OFFSET msjO
            MOV ah, 09h
            INT 21h
            CALL imprimirSignoMenos
            CALL imprimirNumeroO

            CALL saltoDeLinea
            MOV dx, OFFSET msjH
            MOV ah, 09h
            INT 21h
            CALL imprimirSignoMenos
            CALL imprimirNumeroH
        fin:
            ;finalizar programa
            MOV ah, 4Ch
            INT 21h
    main ENDP

    cargaNumero PROC
        ;mensaJE
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
    
    cargarOperando PROC
        ;consulta operando
        MOV dx, OFFSET msj2
        MOV ah, 9h
        INT 21h
        XOR ax, ax

        MOV ah, 1h 
        INT 21h
        MOV operador, al

        RET
    cargarOperando ENDP
    
    imprimirNumeroD PROC        
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
        MOV ax, aux
        XOR si, si
        XOR bx, bx

        cargarBufferH:
            XOR dx, dx
            MOV bx, 16d
            div bx
            
            CMP dx, 10d
            JE Ahexa

            CMP dx, 11d
            JE Bhexa

            CMP dx, 12d
            JE Chexa
            
            CMP dx, 13d
            JE Dhexa
            
            CMP dx, 14d
            JE Ehexa
            
            CMP dx, 15d
            JE Fhexa 

            ADD dx, 30h
            MOV buffer[si], dl
            JMP cargaCompleta

            Ahexa:
                MOV buffer[si], 41h
                JMP cargaCompleta
            Bhexa:
                MOV buffer[si], 42h
                JMP cargaCompleta
            Chexa:
                MOV buffer[si], 43h
                JMP cargaCompleta
            Dhexa:
                MOV buffer[si], 44h
                JMP cargaCompleta
            Ehexa:
                MOV buffer[si], 45h
                JMP cargaCompleta
            Fhexa:
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
    
    imprimirOperacion PROC
        XOR ax, ax
        MOV ax, n1
        MOV aux, ax
        CALL imprimirNumeroD
        
        MOV dx, OFFSET espacio
        MOV ah, 09h
        INT 21h

        MOV dl, operador
        MOV ah, 02h
        INT 21h

        MOV dx, OFFSET espacio
        MOV ah, 09h
        INT 21h

        MOV aux, 0
        XOR ax, ax
        MOV ax, n2
        MOV aux, ax
        CALL imprimirNumeroD
        MOV aux, 0
        
        MOV dx, OFFSET igual
        MOV ah, 09h
        INT 21h

        RET 
    imprimirOperacion ENDP

    imprimirSignoMenos PROC
        CMP esNegativo, 1d 
        JNE noImprimirMenos
        ;imprime signo menos
        MOV dl, 2Dh
        MOV ah, 2h
        INT 21h
        noImprimirMenos:
            RET  
    imprimirSignoMenos ENDP

    saltoDeLinea PROC
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h

        RET
    saltoDeLinea ENDP

    suma PROC
        XOR ax,ax
        MOV ax, n1    
        add aux, ax

        XOR ax,ax
        MOV ax, n2
        add aux, ax

        RET
    suma ENDP

    resta PROC
        XOR ax, ax
        XOR bx, bx

        MOV ax, n1
        MOV bx, n2

        CMP ax, bx
        JB negativo
        
        positivo:
            SUB ax, bx
            MOV aux, ax
            JMP return

        negativo:
            ;resta para obtener positivo
            SUB bx, ax
            MOV aux, bx

            ;activo bander negativo
            INC esNegativo

            JMP return
        return:
            RET

    resta ENDP

    multiplicacion PROC
        XOR ax, ax
        XOR cx, cx
        XOR dx,dx

        MOV ax, n1
        MOV cx, n2

        MUL cx
        MOV aux, ax

        RET
    multiplicacion ENDP

    division PROC
        ;comprueba que la division sea valida
        MOV ax, n2
        CMP ax, 0d
        JE error
        
        XOR ax, ax
        ;Entero de la division
        MOV aux, 0
        MOV ax, n1
        MOV resto, ax

        entero:
            XOR ax, ax
            XOR bx, bx
            XOR cx, cx
            XOR dx, dx
        
            MOV ax, resto
            MOV bx, n2
  
            DIV bx

            CMP ax, 0Dh
            JE salirEntero
            MOV cociente, ax
            MOV resto, dx

            XOR ax,ax
            MOV ax, aux
            MOV ch, 10d
            MUL ch
            ADD ax, cociente
            MOV aux, ax

            XOR ax, ax
    
        salirEntero:
            XOR ax, ax
            MOV n1, 0
            MOV ax, aux
            MOV n1, ax

        ;calcular decimales
        MOV aux, 0
        XOR si, si
        decimal:
            XOR ax, ax
            XOR bx, bx
            XOR cx, cx
            XOR dx, dx
        
            MOV ax, resto
            MOV bx, n2
            MOV cx, 10d

            MUL cx
            DIV bx

            CMP ax, 0d
            JE imprimirDivision
            CMP si, 4d ;colocar la cantidad de comas que quieres
            JE imprimirDivision

            MOV cociente, ax
            MOV resto, dx
            INC si

            XOR ax,ax
            XOR cx,cx
            
            MOV ax, aux
            MOV cx, 10d
            MUL cx
            ADD ax, cociente
            MOV aux, ax

            JMP decimal    
            
        imprimirDivision:
            MOV n2, 0
            MOV ax, aux
            MOV n2, ax
            XOR ax, ax

            ;imprimir decimal
            CALL saltoDeLinea
            MOV dx, OFFSET msjD
            MOV ah, 09h
            INT 21h

            MOV ax, n1
            MOv aux, ax
            CALL imprimirNumeroD
            
            MOV dl, 2Ch
            MOV ah, 02h
            INT 21h

            MOV ax, n2
            MOv aux, ax
            CALL imprimirNumeroD

            ;imprimir binario
            CALL saltoDeLinea
            MOV dx, OFFSET msjB
            MOV ah, 09h
            INT 21h

            MOV ax, n1
            MOv aux, ax
            CALL imprimirNumeroB
            
            MOV dl, 2Ch
            MOV ah, 02h
            INT 21h

            MOV ax, n2
            MOv aux, ax
            CALL imprimirNumeroB
            
            ;imprimir octal
            CALL saltoDeLinea
            MOV dx, OFFSET msjO
            MOV ah, 09h
            INT 21h

            MOV ax, n1
            MOv aux, ax
            CALL imprimirNumeroO
            
            MOV dl, 2Ch
            MOV ah, 02h
            INT 21h

            MOV ax, n2
            MOv aux, ax
            CALL imprimirNumeroO

            ;imprimir hexadecimal
            CALL saltoDeLinea
            MOV dx, OFFSET msjH
            MOV ah, 09h
            INT 21h

            MOV ax, n1
            MOv aux, ax
            CALL imprimirNumeroH
            
            MOV dl, 2Ch
            MOV ah, 02h
            INT 21h

            MOV ax, n2
            MOv aux, ax
            CALL imprimirNumeroH
            JMP finDivision
        
        error:
            MOV dx, OFFSET msjError
            MOV ah, 09h
            INT 21h
            
        finDivision:
            RET
    division ENDP
    END main