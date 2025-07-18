.model small
.stack
.data
    num DB 4
    resultado DB ?
    saltoLinea DB 13, 10, '$'
.code 
    main PROC
        ;importar variables
        mov ax, @data
        mov ds, ax
        xor ax, ax

        ;cargar num usando direccionamiento indirecto con SI
        lea si, num
        mov ax, [si]

        ;duplicar num
        ADD ax, ax

        ;guardar en resultado
        mov resultado, al

        ;imprimir resultados
        XOR ax, ax

        mov dl, num
        ADD dl, 30h
        mov ah, 2h 
        int 21h

        ; Salto de línea
        mov dx, OFFSET saltoLinea
        mov ah, 09h
        int 21h

        mov dl, resultado
        add dl, 30h
        mov ah, 2h
        int 21h
    main ENDP
    END main