.model small
.stack
.data
    num1 DB 5
    num2 DB 3
    suma DB ? ;variable sin valor de inicio

.code
    main PROC
        ; carga en memoria las variables del segmento de datos
        MOV ax, @data
        MOV ds, ax
        XOR ax,ax
          
        ;num1 + num2
        MOV al, num1
        ADD al, num2
        
        ;lo convierte en ASCII
        ADD al, 30h
        
        ;suma = num1 + num2 (en ascii)
        MOV suma, al

        ;imprimir numero
        MOV al, suma
        MOV dl, al
        MOV ah, 2h
        int 21h

        ;finalizar programa
        MOV ah, 4Ch
        int 21h
    main ENDP
    END main