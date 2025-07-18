.model small
.stack
.data
    saltoLinea DB 13, 10, '$'
.code
    main PROC
        ;carga variables
        mov ax, @data
        mov ds, ax

        XOR si, si ;declaro contador
        
        cicloFor:
            CMP si, 5d ;condicion de fin
            JE finCicloFor

            MOV dl, 'a'
            MOV ah, 2h
            INT 21h

            ; Salto de línea
            mov dx, OFFSET saltoLinea
            mov ah, 09h
            int 21h

            inc si ;altero condicion de fin
            JMP cicloFor
        finCicloFor:
            ;finalizar programa
            MOV ah, 4Ch
            int 21h
    main ENDP
    END main