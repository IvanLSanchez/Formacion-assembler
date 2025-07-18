.model small
.stack
.data
.code
    main PROC
        ;asigno 15 a AX
        MOV ax, 15
        
        ;asigno 10 a BX
        MOV bx, 10
        
        ;sobrescribo AX con AX + BX
        ADD ax, bx
        
        ;imprimo en pantalla
        ADD al, 30h ;convierte en ascii el numero
        MOV dl, al ;DL guarda la salida de pantalla pero el dato esta en AL
        MOV ah, 2h
        int 21h

        ;finalizar programa
        MOV ah, 4Ch
        int 21h
    main ENDP
    END main