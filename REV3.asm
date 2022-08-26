
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

data segment
    ; add your data here!   
     
    
    answer db ?,?,?,? 
    
    YourAnswer db ?,?,?,?
     
    bool db 0 
      
    pgiha db 0 
    
    isagain dw 10,13,10,13,9,"       Do you want to play again(y-yes,another char-no)?$"
    
    pkey db "To finish press any key...$"   
    
    Title1 dw 10,13,9,"      M   M  AA   SS TTTTT EEE RRR  M   M III N   N DD "
    Title2 dw 10,13,9,"      MM MM A  A S     T   E   R  R MM MM  I  NN  N D D"
    Title4 dw 10,13,9,"      M M M A  A  S    T   EEE RRR  M M M  I  N N N D D"
    Title5 dw 10,13,9,"      M   M AAAA   S   T   E   R R  M   M  I  N  NN D D"
    Title6 dw 10,13,9,"      M   M A  A SS    T   EEE R  R M   M III N   N DD$"
    
    guidance1 dw 10,13,10,13,,9,"            Hello, welcome to my mastermind game!"  
    guidance2 dw 10,13,9,"      In this game you will have to guess the secret code." 
    guidance3 dw 10,13,10,13,"1. The code consists of 4 deffrent colors."
     
    guidance4 dw 10,13,"2. You can input colors by digits (between 0 to 5)."
    guidance5 dw 10,13,"3. You have 9 turns."                                                           
    guidance6 dw 10,13,"4. ",1,"-one of your colors exist in the original code but the location is worng.   "
    guidance7 dw "  ",2,"-one of your colors exist in the original code with right location."
    guidance8 dw 10,13,"5. The secret code can be chosen by computer or by player2 (It's your choice)." 
    guidance9 dw "  6. If player1 fail so player2 win.$" 
    
    start1 dw 10,13,10,13,"Do you want the code will be chosen by player2 (y\n) ? $"
    start2 dw 10,13,10,13,"Player2 ,please input the secret code: $"  
    start3 dw 10,13,10,13,"When you're ready to start press any key.$"
    
    mone dw 10,13,10,13,'0',". Input your guess: $"
    
    writeanswer dw 9,"Your score is: $" 
    
    string dw 10,13,"                          Color list: $" 
    
    isMulty db 0  
    
    linedown dw 10,13,10,13,10,13,10,13,"$"
      
    won1 dw 10,13,10,13,10,13,9,9,9," W   W III N   N N   N EEE RRR    "
    won2 dw 10,13,9,9,9,            " W   W  I  NN  N NN  N E   R  R   "
    won3 dw 10,13,9,9,9,            " W   W  I  N N N N N N EEE RRR    "
    won4 dw 10,13,9,9,9,            " W W W  I  N  NN N  NN E   R R    "
    won5 dw 10,13,9,9,9,            "  W W  III N   N N   N EEE R  R   $"
    won6 dw 10,13,9," PPP  L    AA  Y   Y EEE RRR  11    III  SS   TTTTT H  H EEE"
    won7 dw 10,13,9," P  P L   A  A  Y Y  E   R  R  1     I  S       T   H  H E  "
    won8 dw 10,13,9," PPP  L   AAAA   Y   EEE RRR   1     I   S      T   HHHH EEE"
    won9 dw 10,13,9," P    L   A  A   Y   E   R R   1     I    S     T   H  H E  "
    won0 dw 10,13,9," P    LLL A  A   Y   EEE R  R 111   III SS      T   H  H EEE$"
    
    Lose1 dw 10,13,9,9,9,"   L   OO   SS EEE RRR   "
    Lose2 dw 10,13,9,9,9,"   L  O  O S   E   R  R  "
    Lose3 dw 10,13,9,9,9,"   L  O  O  S  EEE RRR   "
    Lose4 dw 10,13,9,9,9,"   L  O  O   S E   R R   "
    Lose5 dw 10,13,9,9,9,"   LLL OO  SS  EEE R  R  $"
    Lose6 dw 10,13,9," PPP  L    AA  Y   Y EEE RRR  22    III  SS   TTTTT H  H EEE"
    Lose7 dw 10,13,9," P  P L   A  A  Y Y  E   R  R   2    I  S       T   H  H E  "
    Lose8 dw 10,13,9," PPP  L   AAAA   Y   EEE RRR   2     I   S      T   HHHH EEE"
    Lose9 dw 10,13,9," P    L   A  A   Y   E   R R  2      I    S     T   H  H E  "
    Lose0 dw 10,13,9," P    LLL A  A   Y   EEE R  R 222   III SS      T   H  H EEE$"
     
   
ends

stack segment        
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    startofgame:   
    mov mone+8,'0'
    mov ismulty,0
    call clearscreen
    mov bl,10                                             
    call changecolor        
    mov ah,9                 
    lea dx,Title1           
    int 21h                 
                             
    mov bl,11                                          
    call changecolor         
    lea dx,guidance1         
    int 21h                  
                            
                            
    mov bl,14                                            
    call changecolor         
    lea dx,start1           
    int 21h                  
                            
                            
    isMulti: mov ah,7       
    int 21h                   
                            
    cmp al,'y'                
    je multi                 
    cmp al,'n'                   
    jne isMulti                         
    mov ah,2                    
    mov dl,'n'               
    int 21h                  
                            
    call createrandom        
    jmp startPlay            
                            
    multi: mov isMulty,1     
    mov ah,2                 
    mov dl,'y'               
    int 21h                   
                            
    lea dx,start2            
    mov ah,9                 
    int 21h                  
    call multiversion        
    
    ; ===================================== ;
    ; the start of the game (guesses input) ;
    ; ===================================== ;
    
    startPlay: mov ah,9        
    lea dx,start3            
    int 21h                    
                            
    mov ah,7                
    int 21h                 
                            
    call clearscreen         
                            
    mov bl,15                
    call changecolor           
    lea dx,string
    call printcolorlist      
                            
    mov cx,9                 
    turn: inc mone+8         
                            
    mov bl,15                                           
    call changecolor         
                            
    mov ah,9                 
    lea dx,mone              
    int 21h                  
    call Inputguess         
                            
    mov bl,15                                            
    call changecolor         
                            
    lea dx,writeanswer       
    int 21h                 
                            
    call check              
    mov bl,14                
    call changecolor          
    call printcheck          
    cmp bool,4                
    je winner                
    loop turn
    
    jmp Lose              
    
    ; ==================== ;
    ; situation of victory ;
    ; ==================== ;
    
    winner: call clearScreen 
    mov ah,9               
    lea dx,linedown          
    int 21h                  
    mov bl,10                                            
    call changecolor         
    mov ah,9                  
    cmp isMulty,0            
    je printit1              
    lea dx,won6             
    int 21h                  
    
    printit1:
    lea dx,won1              
    int 21h                  
    jmp End                  
    
    ; ================= ;
    ; situation of loss ;
    ; ================= ;                 
                        
    lose:call clearScreen    
    mov ah,9                 
    lea dx,linedown          
    int 21h                  
    mov bl,10                                             
    call changecolor         
    mov ah,9                    
    cmp isMulty,0               
    je printit2              
    lea dx,lose6               
    int 21h                  
    lea dx,won1              
    int 21h                  
    
    
    jmp end                  
    
    printit2: mov bl,12                                     
    call changecolor         
    mov ah,9                 
    lea dx,lose1             
    int 21h                  
                             
    
    
      
    End:
    mov bl,15       
    call changecolor
    mov ah,9
    lea dx,isagain
    int 21h
    mov ah,1
    int 21h   
    cmp al,'y'
    je startofgame
    mov bl,15         
    call changecolor    
    mov dh, 23           
	mov dl, 1             
	mov bh, 0         
	mov ah, 2             
	int 10h              
    lea dx, pkey        
    mov ah, 9          
    int 21h        
     
        
    mov ah, 7
    int 21h
    
    mov ax, 4c00h 
    int 21h         
    
    Inputguess PROC NEAR 
        
    ;=================================================================;
    ;   The procedure call to procedure that let you input your answer;
    ;   and check it if its diffrent from the other numbers           ;
    ;=================================================================;
   
    mov     bp, sp                  
                                     
                                     
    
                                     
    push ax                                     
    push bx                          
    push cx                          
    push dx                          
                                     
    xor si,si                       
                                     
    Input1: call print1             
    call print2        
                                             
    Input2: mov si,1     
    call print1        
    mov al,[5]  
    cmp al,[4]                              
    je Input2                              
    call print2          
                                             
    Input3:mov si,2                         
    call print1                              
    mov al,[6]                              
    cmp al,[5]                             
    je Input3                            
    cmp al,[4]                           
    je Input3                               
    call print2                               
                                             
    Input4:mov si,3                         
    call print1                             
    mov al,[7]            
    cmp al,[6]            
    je Input4              
    cmp al,[5]           
    je Input4            
    cmp al,[4]        
    je Input4            
    call print2          
                                             
                                             
                                             
    pop  dx                      
    pop  cx                                  
    pop  bx                                  
    pop  ax                                  
                                             
                                             
    ret                 
                                             
    Inputguess ENDP                          
                                             
    Createrandom PROC NEAR  
        
    ;=================================================;                                 
    ; The procedure make four random diffrent numbers ;
    ; and put them in the memory site call answer     ;                                                                   
    ;=================================================;                 
    
    mov     bp, sp     
                                                       
                                               
    push ax            
    push bx                                  
    push cx                                  
    push dx                                  
                                             
                       
    xor si,si              
                                             
    one: call createrand  
                                             
                                             
    two: mov si,1      
    call createrand    
    mov al,[1]                              
    cmp al,[0]         
    je two             
                                            
                                             
    three:mov si,2    
    call createrand    
    mov al,[2]           
    cmp al,[1]            
    je three              
    cmp al,[0]         
    je three           
                                             
                                             
    four:mov si,3                            
    call createrand    
    mov al,[3]         
    cmp al,[2]           
    je four            
    cmp al,[1]              
    je four               
    cmp al,[0]         
    je four            
                                             
                                             
    pop  dx                 
    pop  cx                                  
    pop  bx                                  
    pop  ax                                  
                                             
                                             
    ret                 
    
    Createrandom ENDP
    
    createrand PROC Near 
        
    ;================================================                  
    ; The procedure get the current index
    ; and craete random number in the current location
    ;================================================
    
    mov     bp, sp  
                    
                    
   
    
    
    push ax          
    push bx
    push cx
    push dx
    
    
    mov ah,2ch         
    int 21h             
    mov bl,6             
    mov al,dl           
    xor ah,ah              
    div bl              
    mov [si],ah       
     
        
    pop  dx           
    pop  cx
    pop  bx
    pop  ax                 
    
    ret               
    
    createrand ENDP
    
    print1 PROC NEAR  
        
    ;==================================================================
    ; The procedure get the current location 
    ; and read you answer and put it in the memory site call youranswer
    ;==================================================================    
    
    mov     bp, sp           
                              
                    
                     
        
    push ax                  
    push bx 
    push cx
    push dx 
    
    again:                      
    mov ah,7                    
    int 21h                      
    cmp al,'5'                    
    jg again                       
    cmp al,'0'               
    jl again                 
    mov [4+si],al             
    sub [4+si],'0'            
    
    pop dx                    
    pop cx
    pop bx
    pop ax 
    
    ret                     
        
    print1 ENDP
    
    
    print2 PROC NEAR 
        
    ;=====================================================================================
    ; The procedure get the current location and get the value of youranswer[currentindex]
    ; and print char in the color by the value of bl
    ;=====================================================================================
    
    mov     bp, sp  
                    
                    
                        
        
    push ax              
    push bx 
    push cx
    push dx
    
     
    mov bl,[4+si]
    add bl,2              
    call changecolor       
    mov dl,04             
    mov ah,2                
    int 21h               
    
    pop dx                
    pop cx
    pop bx
    pop ax 
                          
    ret   
        
    print2 ENDP    
    
    check PROC NEAR
         
    ; ===================================================================================================== ;   
    ; The procedure get the memory site call youranswer                                                     ;
    ; and another memory site call answer.                                                                  ;
    ; The procedure compares the memory sites and add 1 to Pgiha                                            ;
    ; if one of your colors exist in the original code (your answer) but the location is worng.             ;
    ; and add 1 to Bool if one of your colors exist in the original code (your answer) with right location. ;
    ; (At the beginning of the procedure bool and pgiha reset                                               ;
    ; ===================================================================================================== ; 
      
    mov     bp, sp                    
                                       
                                      
                                          
                                      
    push ax                           
    push bx 
    push cx
    push dx 
                                      
    xor si,si                        
    mov cx,4
    mov [9],0
    mov [8],0
    
    
    checking: mov al,[4+si]            
                                      
    cmp al,[si]                        
    je addBool                        
    jmp next                          
    addBool: inc [8]                  
    next: inc si                      
                                      
    loop checking                     
    
    mov cx,4                          
    xor si,si                         
    
    checking1: mov al,[4+si]          
                                      
    inc si                            
    push cx                           
    push si                           
    mov cx,4                          
    xor si,si                        
    checking2:mov bl,[4+si]           
                                      
    cmp al,[si]                       
    jne next1                         
    inc [9]                           
    next1:inc si                      
    loop checking2                   
    pop si                            
    pop cx                            
                                      
    loop checking1                    
    
    mov al,[8]                        
    sub [9],al                       
    
    pop dx                
    pop cx
    pop bx
    pop ax 
                         
    ret
       
    check ENDP
    
    clearScreen PROC NEAR 
    ; ============================================================== ;
    ; The procedure clears the screen by the action for this purpose ; 
    ; ============================================================== ;    
        
    mov     bp, sp  
                  
                    
                        
        
    push ax                
    push bx 
    push cx
    push dx 
        
    mov ax,03h            
    int 10h               
     
    pop dx              
    pop cx
    pop bx
    pop ax 
                          
    ret
    
    clearScreen ENDP
    
     
    
    changecolor Proc NEAR 
    ; ============================================================= ;   
    ; The procedure change the color of the text by the value of bl ;
    ; ============================================================= ;
        
    mov     bp, sp 
                   
                                               
    push ax        
    push bx 
    push cx
    push dx
    
    mov cx,0755h   
    mov ah, 9                         
    mov al,0           
    int 10h                               
    
    pop dx         
    pop cx
    pop bx
    pop ax 
                          
    ret            
    
    changecolor Endp
    
    multiversion Proc NEAR 
    ; ========================================================================================================= ;
    ; The procedure let to player2 to input his secret code (if pleyer1 choose to play in multi player version) ;    
    ; ========================================================================================================= ;
       
    mov     bp, sp 
                   
                                               
    push ax      
    push bx 
    push cx
    push dx    
    
    mov ah,2
    mov dl,'X'
    
    InputAns1: call print1 
    int 21h           
                                             
    InputAns2: mov si,1      
    call print1           
    mov al,[4+si]     
    cmp al,[4]                                  
    je InputAns2           
    int 21h                       
                                                
    InputAns3:mov si,2                         
    call print1                                 
    mov al,[4+si]           
    cmp al,[5]                                
    je InputAns3                          
    cmp al,[4]              
    je InputAns3          
    int 21h                              
                                                
    InputAns4:mov si,3                            
    call print1                               
    mov al,[4+si]           
    cmp al,[6]              
    je InputAns4            
    cmp al,[5]              
    je InputAns4            
    cmp al,[4]              
    je InputAns4            
    int 21h
    
    mov cx,4                           
    xor si,si                          
    transition: mov al,[4+si]               
    mov [4+si],0                       
    mov [si],al                        
    inc si                                
    loop transition                    
            
    pop dx          
    pop cx
    pop bx
    pop ax 
                          
    ret            
    
    multiversion Endp
    
    printCheck Proc NEAR
          
    ; ============================================================= ;  
    ; The procedure gets the value of bool and value of pgiha and   ;
    ; print  BOOL times and  PGIHA times in yellow                ;
    ; ============================================================= ;   
        
    mov     bp, sp          
                           
                                                        
    push ax                 
    push bx 
    push cx
    push dx
     
    
    mov cl,[8]               
    mov ah,2                 
    cmp [8],0                
    je nextstep              
    mov bl,14                                             
    call changecolor         
                             
    printscore1: mov dl,2    
    int 21h                 
    loop printscore1         
    
    nextstep:mov cl,[9]      
    
    cmp [9],0                
    je return                  
    
    printscore2: mov dl,1     
    int 21h                     
    loop printscore2                 
    
    return:
    pop dx                   
    pop cx                  
    pop bx                  
    pop ax                  
                                   
    ret                      
    
    printcheck Endp
    
    printcolorlist PROC NEAR 
        
    ; ============================================================= ;
    ; The procedure print "ColorList: 0 1 2 3 4 5"                  ;
    ;                                 ^ ^ ^ ^ ^ ^                   ;
    ;                       color by the value of each number       ;
    ; ============================================================= ;     
        
    mov     bp, sp 
                   
                                               
    push ax         
    push bx 
    push cx
    push dx    
        
    mov ah,9        
                    
    int 21h         
    
    
    mov cx,6              
    mov bl,1                
    mov dl,'0'            
    printcolor: mov ah,2  
    inc bl                
    call changecolor      
    int 21h               
    inc dl                
    push dx               
    mov dl,' '            
    int 21h              
    pop dx                                    
    loop printcolor       
    
    pop dx          
    pop cx
    pop bx
    pop ax 
                          
    ret             
        
    printcolorlist Endp     
    
      
ends
    
    
end start 



