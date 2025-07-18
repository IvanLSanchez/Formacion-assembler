.model small
.stack
.data
    saltoLinea DB 13, 10, '$'

    msj1 DB 'Ingrese un numero: $'
    msj2 DB 'Ingrese la operacion a realizar (+ o -): $'
    msj3 DB 'Error de calculo: la calculadora no puede devolver numeros negativos$'
    
    igual DB ' = $'
    espacio DB ' $'

.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax
        
        ;ingreso primer digito
        MOV dx, OFFSET msj1
        MOV ah, 9h
        INT 21h

        MOV ah, 1h
        INT 21h

        SUB al, 30h
        MOV ch, al

        ;salto de linea (X2)
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        XOR ax, ax

        ;ingreso segundo numero
        MOV dx, OFFSET msj1
        MOV ah, 9h
        INT 21h

        MOV ah, 1h
        INT 21h

        SUB al, 30h
        MOV cl, al

        XOR ax,ax
        
        ;salto de linea (X2)
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        XOR ax, ax

        ;consulta operando
        MOV dx, OFFSET msj2
        MOV ah, 9h
        INT 21h
        XOR ax, ax

        MOV ah, 1h 
        INT 21h
        MOV bl, al

        ;salto de linea (X2)
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        MOV dx, OFFSET saltoLinea
        MOV ah, 09h
        INT 21h
        XOR ax, ax
        
        ;mensaje "CH [operador (BL)] CL = "
        ADD ch, 30h
        ADD cl, 30h

        MOV dl, ch
        MOV ah, 2h
        INT 21h

        MOV dx, OFFSET espacio
        MOV ah, 9h
        INT 21h

        MOV dl, bl
        MOV ah, 2h
        INT 21h

        MOV dx, OFFSET espacio
        MOV ah, 9h
        INT 21h

        MOV dl, cl
        MOV ah, 2h
        INT 21h

        MOV dx, OFFSET igual
        MOV ah, 9h
        INT 21h

        SUB ch, 30h
        SUB cl, 30h

        ;operacion
        ;# me fijo si quiere sumar
        CMP bl, 2Bh
        JNE resta
        suma:
            ADD ch,cl

            CMP ch, 10d
            JAE dosDigitos
            
            JMP unDigito

        resta:
            SUB ch, cl
            
            ;compara que no sea negativo
            CMP ch, 0d

            ;JL error
            JL imprimirNegativo
            
            JMP unDigito
        
        ;error:
            ;salto de linea
            ;MOV dx, OFFSET saltoLinea
            ;MOV ah, 09h
            ;INT 21h

            ;imprimir mensaje
            ;MOV dx, OFFSET msj3
            ;MOV ah, 9h
            ;INT 21h

            ;JMP fin

        imprimirNegativo:
            ;signo -
            MOV dl, 2Dh
            MOV ah, 2h
            INT 21h
            
            ;valor absoluto
            NEG ch

            JMP unDigito

        ;imprimirNegativoV2:
            ;ADD ch, cl
            ;SUB cl, ch
            
            ;signo -
            ;MOV dl, 2Dh
            ;MOV ah, 2h
            ;INT 21h

            ;JMP unDigito
        
        multiplicar:
        
        dividir:

        unDigito:
            ADD ch, 30h

            MOV dl, ch
            MOV ah, 2h 
            INT 21h
            JMP fin
        
        dosDigitos:
            XOR ax,ax
            XOR bx, bx

            MOV al, ch
            
            AAM
            
            ADD ah, 30h
            ADD al, 30h
            
            MOV bh, ah
            MOV bl, al            
            
            MOV dl, bh
            MOV ah, 2h 
            INT 21h

            MOV dl, bl
            MOV ah, 2h 
            INT 21h

            JMP fin
        fin:
            ;finalizar programa
            MOV ah, 4Ch
            INT 21h
    main ENDP
    END main