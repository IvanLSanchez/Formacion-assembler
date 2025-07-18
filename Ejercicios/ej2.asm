.model small
.stack
.data
.code  
    main PROC
        MOV cx, 7
        SUB cx, 3

        ADD cx, 30h
        MOV dl, cl
        MOV ah, 2h
        int 21h

        MOV ah, 4Ch
        int 21h
    main ENDP
    END main