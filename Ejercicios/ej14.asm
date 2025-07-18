.model small
.stack
.data
    saltoLinea DB 13, 10, '$'
    msj1 DB 'Ingrese un numero del 1 al 9 (para finalizar presione 0): $'
    msj2 DB 'La suma total da: $'
    suma DB 0
.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax
        
        cicloWhile:
            ;pido un numero
            MOV dx, OFFSET msj1 
            MOV ah, 9h
            INT 21h
            MOV ah, 1h
            INT 21h
            SUB al, 30h
            MOV bl, al
            
            ;salto de linea
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            
            ;fijo que no sea condicion de fin
            CMP bl, 0d
            JE imprimirSuma

            ;sumo
            ADD suma, bl

            ;repetir
            JMP cicloWhile     
            
        imprimirSuma:
            ;mostrar mensaje
            MOV dx, OFFSET msj2
            MOV ah, 9h
            INT 21h

            ;limpia registros
            XOR ax, ax
            XOR bx, bx
            XOR cx, cx

            ;imprimir numero
            CMP suma, 100d
            JAE tresDigitos
            
            CMP suma, 10d
            JAE dosDigitos
            
            unDigito:
                ADD suma, 30h

                MOV dl, suma
                MOV ah, 2h
                INT 21h
    
                JMP fin
            
            dosDigitos:
                MOV al, suma
                AAM
                MOV cl, ah
                MOV bl, al
                
                ADD cl, 30h
                ADD bl, 30h

                MOV dl, cl
                MOV ah, 2h
                INT 21h

                MOV dl, bl
                MOV ah, 2h
                INT 21h

                JMP fin            
            
            tresDigitos:
                MOV al, suma
                AAM ;AH=cd AL=u
                MOV bl, al;AH=cd AL=u bl=u
                XOR al, al;AH=cd AL=0 bl=u
                MOV al, ah;AH=0 AL=cd bl=u
                XOR ah, ah
                AAM;AH=c AL=d bl=u
                MOV cl, ah 
                MOV bh, al

                ADD cl, 30h
                ADD bh, 30h
                ADD bl, 30h

                MOV dl, cl
                MOV ah, 2h 
                INT 21h

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