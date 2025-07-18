.model small
.stack
.data
    saltoLinea DB 13, 10, '$'

.code
    main PROC
        ; carga en memoria las variables del segmento de datos
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax

        ; AL = 2    BL = 9
        MOV al, 2
        MOV bl, 9

        ; intercambiar BL y AL
        XCHG al, bl

        ; Mostrar AL
        ADD al, 30h
        MOV dl, al
        MOV ah, 2h
        int 21h

        ; Salto de línea
        mov dx, OFFSET saltoLinea
        mov ah, 09h
        int 21h
        
        ; Mostrar BL
        ADD bl, 30h
        MOV dl, bl
        MOV ah, 2h
        int 21h

        ;finalizar programa
        MOV ah, 4Ch
        int 21h
    main ENDP
    END main