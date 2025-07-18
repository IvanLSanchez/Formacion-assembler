.model small
.stack
.data
    arr DB 15, 20, 37, 40
    saltoLinea DB 13, 10, '$'
    msj DB 'La suma es: $'
.code
    main PROC
        ; importar data
        MOV ax, @data
        MOV ds, ax

        ; resetear registros
        XOR ax, ax
        XOR si, si
        MOV cx, 4
        
        ; sumar arreglo
        sumaLoop:
            mov bl, arr[si]
            add al, bl
            inc si
            loop sumaLoop
                    
                    
        ; mostrar en pantalla      
        
        ;# guardar resultado en bl
        XOR bl,bl
        MOV bl, al
        
        ;# imprimir mensaje
        MOV dx, msj offset
        MOV ah, 9
        int 21h
        
        ;# volver resultado a al
        XOR ax, ax
        MOV al, bl
        XOR bl, bl
        
        aam ;AH=11  AL=2 
        
        mov bl, al ;AH=11  AL=2   BL=2
        XOR al, al ;AH=11  AL=0   BL=2
        MOV al, ah ;AH=11  AL=11  BL=2
        XOR ah, ah ;AH=0   AL=11  BL=2

        aam ;AH=1  AL=1  ;BL=2
        
        ;# ASCII
        mov ch, ah
        add ch, 30h

        MOV cl, al
        add cl, 30h

        add bl, 30h
        
        ;# imprimir numero
        MOV dl, ch
        MOV ah, 2h
        int 21h

        MOV dl, cl
        MOV ah, 2h
        int 21h

        MOV dl, bl
        MOV ah, 2h
        int 21h


        ;finalizar
        MOV ah, 4Ch
        int 21h
    main ENDP
    END main