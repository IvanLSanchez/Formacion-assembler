.model small
.stack
.data
.code
    main PROC
        ;asigno 5 a AX
        MOV ax, 5
        
        ;sobrescribo AX con AX + 2
        ADD ax, 2
        
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