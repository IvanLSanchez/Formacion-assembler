.model small
.stack
.data
    saltoLinea DB 13, 10, '$'
    msj1 DB 'insgrse un numero: $'
    msj2 DB 'El resultado de la suma es: $'
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

        ;mostrar mensaje resultado
        MOV ah, 9h
        LEA dx, msj2
        INT 21h

        ;suma
        MOV al, n1
        MOV bl, n2
        ADD al, bl
        
        CMP al, 10d
        JAE dosDigitos
 
        unDigito:
            ;Imprimir
            ADD al, 30h
            
            MOV dl, al
            MOV ah, 2h 
            INT 21h
            
            JMP fin
 
        dosDigitos:
            XOR bx, bx
            
            ;Separar en 2 digitos
            AAM
            
            MOV bl, al
            MOV bh, ah 
            
            ;ASCII
            ADD bl, 30h
            ADD bh, 30h
            
            XOR ax, ax
            ;Imprimir
            MOV dl, bh
            MOV ah, 2h 
            INT 21h

            MOV dl, bl
            MOV ah, 2h
            INT 21h
        fin:    
            ;finalizar programa
            MOV ah, 4Ch
            INT 21h
    main ENDP
    END main