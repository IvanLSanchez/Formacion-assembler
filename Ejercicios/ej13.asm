.model small
.stack
.data
    saltoLinea DB 13, 10, '$'
.code
    main PROC
        ;importar variables
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax
        
        XOR si,si
        
        forUnoADiez:
            inc si
            CMP si, 10d
            JAE dosDigitos

            MOV dx, si
            ADD dx, 30h
            MOV ah, 02h
            INT 21h
            
            XOR dx,dx

            MOV dx, OFFSET saltoLinea
            MOV ah, 09h
            INT 21h
            
            JMP forUnoADiez

        dosDigitos:
            MOV ax, si
            
            AAM
            
            MOV bh, ah
            MOV bl, al

            ADD bh, 30h
            ADD bl, 30h

            MOV dl, bh
            MOV ah, 02h
            INT 21h

            MOV dl, bl
            MOV ah, 02h
            INT 21h
        
        fin:
            ;finalizar programa
            MOV ah, 4Ch
            INT 21h
    main ENDP
    END main