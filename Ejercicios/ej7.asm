.model small
.stack
.data
    num1 DB 2
    num2 DB 9
    saltoLinea DB 13, 10, '$'
.code
    main PROC
        ;carga variables
        mov ax, @data
        mov ds, ax

        ;carga registros de manera indirecta
        lea si, num1
        mov al, [si]

        lea di, num2
        mov bl, [di]

        ;intercambia AL y BL
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