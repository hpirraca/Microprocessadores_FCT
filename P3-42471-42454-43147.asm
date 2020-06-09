; multi-segment executable file template.

data segment
    
    ;Ficheiros
    filePath    db   "C:\mydir", 0
    fileName    db   "C:\contents.txt", 0 
    informacao db 128 dup(0) ;128 posicoes inicializadas a 0
    handle dw ?    
    
    ;Quadrados
    cores db 0100b, 0011b, 1110b, 0010b, 1111b, 1101b, 1001b ;tabela de cores - vermelho, azul, amarelo, verde, branco
    Quad db 0, 0, 0, 0, 0
    ok db 0, 0, 0, 0, 0
    
    ;Triangulos
    tri db 0, 0, 0, 0
    linha db 0
    larg db 20 
    
    ;Menu
    str1 db "MENU"
    str2 db "- Carregar Stock de Moedas"
    str3 db "- Iniciar operacao"
    str4 db "- Mostrar Stock de moedas"
    str5 db "- Sobre"
    strsair db "- Sair"
    
    ;About
    nome1 db "Ana Rita Rogado - 42454"
    nome2 db "Hugo Pirraca    - 42471"
    nome3 db "Pedro Rolla     - 43147"
    
    ;Iniciar OP
    strop1 db "Hora atual: "
    strop2 db "Introduza a hora no cartao: "
    strop3 db "Valor a pagar: "
    strop4 db "Pagamento Acumulado: "
    strop5 db "Moedas: "
    strop6 db "Num Moedas: "
    strop7 db "OK"
    strhoras db 8 dup(?)
    array_horas db 0,0,3ah,0,0,2eh
    strmoedqntdint db 200, 0, 100, 0, 50, 0, 20, 0, 10, 0, 5, 0, 2, 0, 1, 0
    total db 0
    total_preco dw 0
    total_array dw 0,0,2eh,0,0
    quant_tot db 0, 0, 0, 0
    hora_entrada db 0, 0
    preco dw 0
    preco_fim dw 0
    
    ;Mostrar Stock
    strstock1    db "O valor acumulado e: "
    strstock2    db "Stock de Moedas: "
    strstockm2e  db "2 Euros: "
    strstockm1e  db "1  Euro: "
    strstockm50  db "50 Cent: "
    strstockm20  db "20 Cent: "
    strstockm10  db "10 Cent: "
    strstockm5   db "05 Cent: "
    strstockm2   db "02 Cent: "
    strstockm1   db "01 Cent: "
    strvalor db 0        
    
    ;Moedas
    strmoed_qntd db 200, 0, 100, 0, 50, 0, 20, 0, 10, 0, 5, 0, 2, 0, 1, 0
    contador  db 0 
    
    ;Sair
    endLine db 0Dh,0Ah
    cent200 db "200:"
    cent100 db "100:"
    cent50  db "50:"
    cent20  db "20:"
    cent10  db "10:"
    cent5   db "5:"
    cent2   db "2:"
    cent1   db "1:"
    
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

    
    call setVideoMode
    
    
    inicio proc
    
        mov bx, 0                             ;Menu
        mov dl, 18                            ;Menu
        mov dh, 1
        mov cx, 4
        mov bp, offset str1
        mov bl,cores[4]
        call writestr
    
    endp    
    
    
;*************************************************************************************************************
;
;Configuracao dos Botoes do Menu -- Configuracao dos botoes
;
;*************************************************************************************************************
        
    
    ;Botao1
    
    mov Quad[0], 20  ;eixo do x
    mov Quad[1], 20  ;eixo do y
    mov Quad[2], 20  ;dim
    
    call contaQuad
    
    mov dh, 0
    mov ch, 0
    mov cl,Quad[0]
    mov dl,Quad[1]
    mov al,cores[0]
    call putQuad
    
    
    ;Botao2
    
    mov Quad[0], 20  ;eixo do x
    mov Quad[1], 50  ;eixo do y
    mov Quad[2], 20  ;dim
    
    call contaQuad
    
    mov dh, 0
    mov ch, 0
    mov cl,Quad[0]
    mov dl,Quad[1]
    mov al,cores[1]
    call putQuad
    
    
    ;Botao3
    
    mov Quad[0], 20  ;80
    mov Quad[1], 80
    mov Quad[2], 20  ;100
    
    call contaQuad
    
    mov dh, 0
    mov ch, 0
    mov cl,Quad[0]
    mov dl,Quad[1]
    mov al,cores[2]
    call putQuad
    
    
    ;Botao4
    
    mov Quad[0], 20  ;110
    mov Quad[1], 110
    mov Quad[2], 20  ;130
    
    call contaQuad
    
    mov dh, 0
    mov ch, 0
    mov cl,Quad[0]
    mov dl,Quad[1]
    mov al,cores[3]
    call putQuad
    
    
    ;Botao5
    
    mov Quad[0], 20  ;140
    mov Quad[1], 140
    mov Quad[2], 20  ;160
    
    call contaQuad
    
    mov dh, 0
    mov ch, 0
    mov cl,Quad[0]
    mov dl,Quad[1]
    mov al,cores[4]
    call putQuad
    
    
    ;Botao1_text
    
    mov bx, 0
    mov dl, 6
    mov dh, 3
    mov cx, 26
    mov bp, offset str2
    mov bl, cores[4]    
    call writestr
    
    ;Botao2_text
    
    mov bx, 0
    mov dl, 6
    mov dh, 7
    mov cx, 18
    mov bp, offset str3
    mov bl, cores[4]   
    call writestr
    
    ;Botao3_text
    
    mov bx, 0
    mov dl, 6
    mov dh, 11
    mov cx, 25
    mov bp, offset str4
    mov bl, cores[4]    
    call writestr    
    
    ;Botao4_text
    
    mov bx, 0
    mov dl, 6
    mov dh, 15
    mov cx, 7
    mov bp, offset str5
    mov bl, cores[4]
    call writestr
    
    ;Botao5_text
    
    mov bx, 0
    mov dl, 6
    mov dh, 19
    mov cx, 6
    mov bp, offset strsair
    mov bl, cores[4]
    call writestr
    
 
;*************************************************************************************************************
;
;Posicoes do Menu principal 
;
;*************************************************************************************************************

    selecao_menu proc
        
        call ini_rato
        
        call posicao
            
        ;Posicao de click de cada botao
        
        posicao proc
            
            Band_x:                    ;verifica se o click do rato esta dentro da banda_x
            cmp cx, 40
            jng salta_rato
            cmp cx, 80
            jnl salta_rato
            
            jmp Band_y1        
            
            
            Band_y1:
                cmp dx,20
                jng salta_rato
                cmp dx,40
                jg Band_y2
                
                jmp dentro1
                
            Band_y2:
                cmp dx,50
                jng salta_rato
                cmp dx,70
                jg Band_y3
                
                jmp dentro2    
            
            Band_y3:
                cmp dx,80
                jng salta_rato
                cmp dx,100
                jg Band_y4
            
                jmp dentro3
        
            Band_y4:
                cmp dx,110
                jng salta_rato
                cmp dx,130
                jg Band_y5
            
                jmp dentro4
                
            Band_y5:
                cmp dx,140
                jng salta_rato
                cmp dx,160
                jg salta_rato
            
                jmp dentro5
                
            salta_rato:
                call ini_rato
                call posicao
            
            
            dentro1:               ;se o click estiver dentro da banda
                call carrega_stock
                
            dentro2:
                jmp  iniciar_op
                
            dentro3:
                call mostra_stock
            
            dentro4:
                call about
            
            dentro5:
                call sair
        endp 
    endp
    
;*************************************************************************************************************
;
;Inicializacao do rato 
;
;*************************************************************************************************************

    
    ini_rato proc
        mov cx, 0
        mov dx, 0 
    rato:            
        mov ax, 3
        int 33h
        cmp bx,0
        je rato
        ret
    endp


;*************************************************************************************************************
;
;PUTQUAD -- Desenha os varios quadrados dos menus
;
;*************************************************************************************************************


    putQuad proc
        push ax
        push bx
        
        linha_h1:                           ;linha horizontal superior
        mov ah,0ch
        mov bh,00 ; active display page
        int 10h
        inc cx
        cmp cl, Quad[3]
        jl linha_h1
        
        linha_v1:                           ;linha vertical direita
        mov ah,0ch
        mov bh,00
        int 10h
        inc dx
        cmp dl, Quad[4]
        jne linha_v1
                                           
        linha_h2:
        mov ah,0ch                         ;linha horizontal inferior
        mov bh,00
        int 10h
        dec cx
        cmp cl, Quad[0]
        jg linha_h2
        
        linha_v2:                          ;linha vertical esquerda
        mov ah,0ch
        mov bh,00
        int 10h
        dec dx
        cmp dl, Quad[1]
        jne linha_v2
        
        pop bx
        pop ax
        
        ret
    endp
    
    contaQuad proc                        ;define a dimensao real do quad
        push ax
        push bx
        
        mov cl,Quad[0]
        mov dl,Quad[1]
        
        mov bl,Quad[2]
        add bl, cl
        mov Quad[3], bl
        
        mov bl,Quad[2]
        add bl, dl
        mov Quad[4], bl
        
        pop ax
        pop bx
        ret
    endp
         

;*************************************************************************************************************
;
;CARREGA STOCK DE MOEDAS -- Abertura do ficheiro que contem o stock
;
;*************************************************************************************************************

    carrega_stock proc            
    push ax
    push bx
    
    
       mov dx, offset filename    ;vai buscar o endereco do ficheiro
       mov al, 0
       call fopen
        
       mov bx, handle
       mov dx, offset informacao
       call fread
       
       mov bx, handle
       call fclose
       
       call organizar
       
       jmp rato
    endp
   

    fread proc
    
        mov cx, 255
        mov ah, 3fh
        int 21h   
        
        ret
    endp

    
    fclose proc
        
        mov ah, 3eh
        int 21h
        
        ret
    endp 


    fopen proc
        
        mov ah, 3dh
        int 21h
        mov handle, ax
        
        ret
    endp
        
    organizar proc                    ;organiza as moedas por quantidade
        
        mov si, offset informacao
        mov ax, 0
        push ax
        
        ciclomoeda:
            
            mov al, byte ptr[si]
            inc si
            
            
            cmp al, 0     ; NULL
            je finalizar  
            
            cmp al, 3Ah   ; compara com ":"
            je moeda
            
            cmp al, 0Ah   ; compara com enter
            je ciclomoeda
            
            cmp al, 30h   ; compara com 0
            jnge not_coin
            
            cmp al, 39h   ; compara com 9
            jg  not_coin
            
            sub al, 30h   ; Decimal

            jmp multmoed
    
            jmp ciclomoeda
            
        multmoed:                    
            pop cx
            add ax, cx
            mov bl, 10
            mul bl
            
            push ax
            jmp ciclomoeda
            
        moeda:
            pop ax
            mov bl, 10
            div bl
            mov di, offset strmoed_qntd
                
                search_moeda:
                
                cmp byte ptr[di], al
                je ciclo_quant
                
                inc di
                inc di
                
                jmp search_moeda
                
                jmp not_coin
                
        ciclo_quant:                        
                
            mov ax, 0
            push ax
             
        cicloquant:
                   
            mov al, byte ptr[si]
            inc si
             
            cmp al, 0Dh
            je quantidade
            
            cmp al, 0
            je quantidade 
            
            cmp al, 30h
            jnge not_quant
            
            cmp al, 39h
            jg  not_quant 
            
            
            sub al, 30h
            jmp multquant
            
            jmp cicloquant
            
        multquant:
            pop cx
            add ax, cx            
            mov bl, 10
            mul bl

            
            push ax
            jmp cicloquant
            
        quantidade:
            pop ax
            mov bl, 10
            div bl
            inc di
            mov byte ptr[di], al
            mov ax, 0
            push ax
            jmp ciclomoeda            
            
        not_coin: 
            mov al, byte ptr[si]
            inc si
            
            cmp al, 0Ah
            je ciclomoeda            
            
            jmp not_coin
        
        not_quant:
            mov al, byte ptr[si]
            inc si
            
            cmp al, 0Ah
            je retificar
            
            jmp not_quant
            
        retificar:
            dec di
            mov byte ptr[di], 0
            
            jmp ciclomoeda         
                    
        finalizar:    
        call selecao_menu    
    endp 


;*************************************************************************************************************
;
;MOSTRA STOCK DE MOEDAS -- Mostra o stock no ecra
;
;*************************************************************************************************************
     
     mostra_stock proc
           
        call setVideoMode

        mov bx, 0
        mov dl, 3
        mov dh, 6
        mov cx, 17
        mov bp, offset strstock2
        mov bl, cores[4]
        call writestr
        
        mov bx, 0
        mov dl, 3
        mov dh, 10
        mov cx, 8
        mov bp, offset strstockm2e
        mov bl, cores[4]
        call writestr
        
        mov bl, 200
        call check_coin
        
        mov bx, 0
        mov dl, 22
        mov dh, 10
        mov cx, 8
        mov bp, offset strstockm1e
        mov bl, cores[4]
        call writestr

        mov bl, 100
        call check_coin
        
        mov bx, 0
        mov dl, 3
        mov dh, 13
        mov cx, 8
        mov bp, offset strstockm50
        mov bl, cores[4]
        call writestr

        mov bl, 50
        call check_coin
        
        mov bx, 0
        mov dl, 22
        mov dh, 13
        mov cx, 8
        mov bp, offset strstockm20
        mov bl, cores[4]
        call writestr
        
        mov bl, 20
        call check_coin
        
        mov bx, 0
        mov dl, 3
        mov dh, 16
        mov cx, 8
        mov bp, offset strstockm10
        mov bl, cores[4]
        call writestr

        mov bl, 10
        call check_coin
       
        mov bx, 0
        mov dl, 22
        mov dh, 16
        mov cx, 8
        mov bp, offset strstockm5
        mov bl, cores[4]
        call writestr

        mov bl, 5
        call check_coin
        
        mov bx, 0
        mov dl, 3
        mov dh, 19
        mov cx, 8
        mov bp, offset strstockm2
        mov bl, cores[4]
        call writestr

        mov bl, 2
        call check_coin
        
        mov bx, 0
        mov dl, 22
        mov dh, 19
        mov cx, 8
        mov bp, offset strstockm1
        mov bl, cores[4]
        call writestr          

        mov bl, 1
        call check_coin
        
        
        mov si, offset strmoed_qntd

        call ini_rato
        call setVideoMode
        call inicio 
     endp
     
;*************************************************************************************************************
;
;CHECK COIN-verifica a moeda e escreve a quantidade a frente 
;
;*************************************************************************************************************

    check_coin proc 
        mov si, offset strmoed_qntd
                 
        check:
            mov al, byte ptr[si]
            inc si
            
            
            cmp al, bl
            je conta
            
            inc si
            
            cmp al, 0
            je zero

            jmp check
        
        conta:
            mov al, byte ptr[si]
        conta_aux:    
            mov ah, 0
            mov cl, 10
            mov bx, 0
            mov dx, 0
            
            cmp ax, 9
            jbe corret
            jmp loop1
        
        print:
            add al, 30h
            mov ah, 0Eh
            int 10h
            cmp dh, 10
            jne mudar_var
            cmp bl, 10
            jne mudar_var2
            jmp fim
        
        loop1:
            div cl
            cmp al, 9
            ja loop2
            push ax
            mov dh, ah
            mov bl,10
            jmp print
        
            
        loop2:
            push ax
            mov ah, 0
            div cl
            push ax
            jmp print    
          
          
        mudar_var:
            pop ax
            mov al, ah
            mov ah, 0
            cmp al, 0
            mov dh, 10
            jmp print
          
          
        mudar_var2:
            pop ax
            mov al, ah
            mov ah, 0
            mov bl, 10
            jmp print
          
                                
        corret:
            mov bl, 10
            mov dh, 10
            jmp print
            
        zero:
            mov al, 0
            mov ah, 0
            jmp corret
  
        fim:
            ret
        
    endp     
     
;*************************************************************************************************************
;
;WRITESTR -- Escreve String no Ecra
;
;*************************************************************************************************************

    writestr proc
        mov al, 1
        mov bh, 0
        mov ah, 13h
        int 10h
        ret   
    endp
    
;*************************************************************************************************************
;
;ABOUT -- Apresenta os nomes dos programadores
;
;*************************************************************************************************************

    about proc
        call setVideoMode
        
        mov bx, 0
        mov dl, 9
        mov dh, 7
        mov cx, 23
        mov bp, offset nome1
        mov bl, cores[5]
        call writestr
        
        mov bx, 0
        mov dl, 9
        mov dh, 9
        mov cx, 23
        mov bp, offset nome2
        mov bl, cores[6]
        call writestr
        
        mov bx, 0
        mov dl, 9
        mov dh, 11
        mov cx, 23
        mov bp, offset nome3
        mov bl, cores[6]
        call writestr
        
        call ini_rato
        
        call setVideoMode
        call inicio
            
    endp

;*************************************************************************************************************
;
;INICIAR OPERACAO
;
;*************************************************************************************************************

    
    iniciar_op proc
        
        call setVideoMode 
        mov bx, 0
        mov dl, 1
        mov dh, 1
        mov cx, 11
        mov bp, offset strop1 
        mov bl, cores[4]
        call writestr
        
        call time

        mov bx, 0
        mov dl, 1
        mov dh, 4
        mov cx, 28
        mov bp, offset strop2 
        mov bl, cores[4]
        call writestr
        
        call escreve_hora
        


        dinheiros:
        mov bx, 0
        mov dl, 1
        mov dh, 7
        mov cx, 14
        mov bp, offset strop3 
        mov bl, cores[4]
        call writestr               
        call calcular_preco     
                     
        mov bx, 0
        mov dl, 1
        mov dh, 10
        mov cx, 6
        mov bp, offset strop5 
        mov bl, cores[4]
        call writestr             
        
        call limpar_moeda
        
        mov tri[0], 180  ;coluna_inicial
        mov tri[1], 200  ;coluna_final
        mov tri[2], 150  ;altura
        call putTriangBaixo
        
        mov tri[0], 180  ;coluna_inicial
        mov tri[1], 200 ;coluna_final
        mov tri[2], 140  ;altura
        call putTriangCima
        
        ;Botao_OK
    
        mov Quad[0], 210 
        mov Quad[1], 135
        mov Quad[2], 25  
        
        call contaQuad
        
        mov dh, 0
        mov ch, 0
        mov cl,Quad[0]
        mov dl,Quad[1]
        mov al,cores[0]
        call putQuad
        
        mov bx, 0
        mov dl, 27
        mov dh, 18
        mov cx, 2
        mov bp, offset strop7 
        mov bl, cores[4]
        call writestr
        
        
        mov bx, 0
        mov dl, 1
        mov dh, 17
        mov cx, 12
        mov bp, offset strop6 
        mov bl, cores[4]
        call writestr
        
        mov bx, 0
        mov dl, 1
        mov dh, 22
        mov cx, 21
        mov bp, offset strop4 
        mov bl, cores[4]
        call writestr
        
        espera:
        call posicao_moedas
        call time
        jmp espera
   endp
   
   limpar_moeda proc
   
        mov bx, 0
        mov dl, 1
        mov dh, 12
        mov cx, 7
        mov bp, offset strstockm2e
        mov bl, 1111_0000b
        call writestr
        
        mov bx, 0
        mov dl, 10
        mov dh, 12
        mov cx, 7
        mov bp, offset strstockm1e
        mov bl, 1111_0000b
        call writestr
        
        mov bx, 0
        mov dl, 20
        mov dh, 12
        mov cx, 7
        mov bp, offset strstockm50
        mov bl, 1111_0000b
        call writestr
        
        mov bx, 0
        mov dl, 30
        mov dh, 12
        mov cx, 7
        mov bp, offset strstockm20
        mov bl, 1111_0000b
        call writestr
        
        mov bx, 0
        mov dl, 1
        mov dh, 14
        mov cx, 7
        mov bp, offset strstockm10
        mov bl, 1111_0000b
        call writestr
       
        mov bx, 0
        mov dl, 10
        mov dh, 14
        mov cx, 7
        mov bp, offset strstockm5
        mov bl, 1111_0000b
        call writestr
        
        mov bx, 0
        mov dl, 20
        mov dh, 14
        mov cx, 7
        mov bp, offset strstockm2
        mov bl, 1111_0000b
        call writestr
        
        mov bx, 0
        mov dl, 30
        mov dh, 14
        mov cx, 7
        mov bp, offset strstockm1
        mov bl, 1111_0000b
        call writestr
        
        ret
   endp   
   
   posicao_moedas proc
       
       call ini_rato
       
       Band_moeda_y1:
        cmp dx,93
        jng salta_rato_moeda
        cmp dx,107
        jg Band_moeda_y2 ;nao esta dentro da banda y1
        
       Band_200:
        cmp cx,0Ch
        jng salta_rato_moeda
        cmp cx,70h
        jg Band_100 ;nao esta dentro da banda x1
        
        jmp dentro_moeda_200 ;esta dentro da banda x1
        
       Band_100:
        cmp cx,9Eh
        jng salta_rato_moeda
        cmp cx,110h
        jg Band_50
        
        jmp dentro_moeda_100    
        
       Band_50:
        cmp cx,13Eh
        jng salta_rato_moeda
        cmp cx,1B0h
        jg Band_20
        
        jmp dentro_moeda_50
        
       Band_20:
        cmp cx,1DEh
        jng salta_rato_moeda
        cmp cx,24Eh
        jg  salta_rato_moeda
        
        jmp dentro_moeda_20    
                    
       Band_moeda_y2: 
        cmp dx,108
        jng salta_rato_moeda
        cmp dx,122
        jg salta_rato_moeda ;nao esta dentro da banda y2
        
       Band_10:
        cmp cx,0Ch
        jng salta_rato_moeda
        cmp cx,70h
        jg Band_5 ;nao esta dentro da banda x1
        
        jmp dentro_moeda_10 ;esta dentro da banda x1
        
       Band_5:
        cmp cx,9Eh
        jng salta_rato_moeda
        cmp cx,110h
        jg Band_2
        
        jmp dentro_moeda_5    
        
       Band_2:
        cmp cx,13Eh
        jng salta_rato_moeda
        cmp cx,1B0h
        jg Band_1
        
        jmp dentro_moeda_2
        
       Band_1:
        cmp cx,1DEh
        jng salta_rato
        cmp cx,24Eh
        jg  salta_rato_moeda
        
        jmp dentro_moeda_1 
         
        salta_rato_moeda:      
        
        call ini_rato
      
        dentro_moeda_200:
            ;hlt
            mov bx, 0
            mov dl, 1
            mov dh, 12
            mov cx, 7
            mov bp, offset strstockm2e
            mov bl, 0011_0000b
            call writestr
            mov ax, 0
            mov al, 200
            
            call modquantint
            call limpar_moeda
            ret
            
        ret

        dentro_moeda_100:
            ;hlt
            mov bx, 0
            mov dl, 10
            mov dh, 12
            mov cx, 7
            mov bp, offset strstockm1e
            mov bl, 0011_0000b
            call writestr
            mov ax, 0
            mov al, 100
            call modquantint
            call limpar_moeda
        ret

        dentro_moeda_50:
            ;hlt
            mov bx, 0
            mov dl, 20
            mov dh, 12
            mov cx, 7
            mov bp, offset strstockm50
            mov bl, 0011_0000b
            call writestr
            mov ax, 0
            mov al, 50
            call modquantint
            call limpar_moeda
        ret        

        dentro_moeda_20:
            ;hlt
            mov bx, 0
            mov dl, 30
            mov dh, 12
            mov cx, 7
            mov bp, offset strstockm20
            mov bl, 0011_0000b
            call writestr
            mov ax, 0
            mov al, 20
            call modquantint
            call limpar_moeda        
        ret

        dentro_moeda_10:
            ;hlt
            mov bx, 0
            mov dl, 1
            mov dh, 14
            mov cx, 7
            mov bp, offset strstockm10
            mov bl, 0011_0000b
            call writestr
            mov ax, 0
            mov al, 10
            call modquantint
            call limpar_moeda
        ret

        dentro_moeda_5:
            ;hlt
            mov bx, 0
            mov dl, 10
            mov dh, 14
            mov cx, 7
            mov bp, offset strstockm5
            mov bl, 0011_0000b
            call writestr
            mov ax, 0
            mov al, 5
            call modquantint
            call limpar_moeda
        ret

        dentro_moeda_2:
            ;hlt
            mov bx, 0
            mov dl, 20
            mov dh, 14
            mov cx, 7
            mov bp, offset strstockm2
            mov bl, 0011_0000b
            call writestr
            mov ax, 0
            mov al, 2
            call modquantint
            call limpar_moeda
        ret

        dentro_moeda_1:
            ;hlt
            mov bx, 0
            mov dl, 30
            mov dh, 14
            mov cx, 7
            mov bp, offset strstockm1
            mov bl, 0011_0000b
            call writestr
            mov ax, 0
            mov al, 1
            call modquantint
            call limpar_moeda
        ret
        
   endp
   
   modquantint proc
       mov di, offset strmoedqntdint
       mov si, offset strmoedqntdint
       mov cx, 0
       push cx
                
       searchmoeda:
                
       cmp byte ptr[di], al
       je quant
        
       inc si
       inc si
       inc di
       inc di
       jmp searchmoeda
       
       quant:
      
            call ini_rato
            
            Band_ok:
                cmp cx, 1A4h
                jng Band_seta
                cmp cx, 1D7h
                jg quant
                
            Band_ok1:
                cmp dx, 86h
                jng quant 
                cmp dx, 161
                jg quant
            
            jmp bok
            
            Band_seta:
                cmp cx,168h
                jng quant
                cmp cx,190h
                jg quant 
            
            
            Band_s1:
                cmp dx,80h
                jng quant 
                cmp dx,8Dh
                jg Band_s2
            
            jmp sup    
            
            Band_s2:
                cmp dx,96h
                jng quant
                cmp dx,161
                jg quant
            
            jmp sdown
            
            sup:
                
                pop cx
                inc cx
                push cx
                mov dl, 14
                mov dh, 17
                call setCursorPos
                push ax
                mov ax, cx
                call writeSimpleUns
                pop ax  
                jmp quant
            
            sdown:
                
                pop cx
                cmp cx, 0
                je quant
                dec cx
                push cx
                mov dl, 14
                mov dh, 17
                call setCursorPos                
                push ax
                mov ax, cx
                call writeSimpleUns
                pop ax
                jmp quant
                
            bok:
                pop cx
                inc si
                mov byte ptr[si], cl
                mov dl, 14
                mov dh, 17
                call setCursorPos
                mov ax, 0
                call writeSimpleUns
   
   ret
   endp
   
   
    writeSimpleUns proc
        mov bx, 2710h
        mov cx, 5
        xor dx, dx
        
        newDigit:
        
        div bx             
        
        add al,30h         
        
        call printChar     
        
        mov ax, dx
        
        push ax
        
        mov dx,0000h   
        ;
        mov ax,bx      
        mov bx,000Ah   
        div bx         
        ;
        mov bx,ax      
        
        pop ax                
        
        loop newDigit        
        
        exit_writeSimpleUns:
        ret
        endp 
        
        printChar proc
        
        push ax
        push dx
        
        mov ah,02h
        mov dl,al
        int 21h
        
        exit_printChar: 
        pop dx
        pop ax
        ret
    endp
   
      
;*************************************************************************************************************
;
;TRIANGULOS -- Triangulos
;
;*************************************************************************************************************

    putTriangBaixo proc
        mov dh, 0
        mov ch, 0
        mov cl, tri[0];coluna do 1o pixel
        push cx
        add cl,larg  ;coluna do ultimo pixel
        mov larg,cl
        pop cx
        mov dl,tri[2]
        mov al,cores[0]
        
        linha_tri_baixo: 
            mov ah,0ch; int pinta pixel
            mov bh,00 ; active display page
            int 10h
            inc cx
            cmp cl, larg
            jle linha_tri_baixo
        
        next_colun:
            inc dx
            mov cl,linha
            inc cl
            mov linha,cl
            mov cl,larg
            dec cl
            mov larg,cl
            mov cl,tri[0]
            add cl,linha
            cmp linha,11
            jz f
            jmp linha_tri_baixo

         f:
            ret
    endp
    
    putTriangCima proc
        mov ch, 0
        mov cl,tri[0]
        push cx
        add cl,20
        mov larg,cl
        pop cx
        mov dl,tri[2]
        mov al,cores[1]
        push cx
        mov cl,0
        mov linha,cl
        pop cx
        
        linha_tri_cima: 
            mov ah,0ch; int pinta pixel
            mov bh,00 ; active display page
            int 10h
            inc cx
            cmp cl, larg
            jle linha_tri_cima
        
        prev_colun:
            dec dx
            mov cl,linha
            inc cl
            mov linha,cl
            mov cl,larg
            dec cl
            mov larg,cl
            mov cl,tri[0]
            add cl,linha
            cmp linha,11
            jz f2
            jmp linha_tri_cima

        f2:
            ret
    endp
   
;*************************************************************************************************************
;
;   calculo preco,troco,tempo
;
;*************************************************************************************************************
            

    

    calcular_preco proc
        
        call hora_var
        
        call hora_atual
        
        mov ah,ch                    ;guardar temporariamente valor de ch
        mov al,cl
        
        cmp ah, hora_entrada[0]
        jb horas_negativas           ;se a hora atual (ah) for inferior a hora de entrada
        
        
        tempo_a_pagar:
        
        sub ah,hora_entrada[0]       ;ah fica com a diferenca de horas
        
        sub al,hora_entrada[1]
        js minutos_negativos         ;se o minuto de entrada for superior ao minuto atual
        
        jmp c_preco                  ;calcula o preco total a pagar   
                                     ;jmp hora_atual  ;para atualizar a hora constantemente   
                     
        ret
        
        minutos_negativos:  
        
        sub ah,1h                    ;ja convertido para hexadecimal (1 em decimal)
        add al,3ch                   ;ja convertido para hexadecimal (60 em decimal)
        jmp c_preco
        
        horas_negativas:  
        
        mov hora_entrada[0],0        ;como se a hora de entrada fosse as 00:00
        mov hora_entrada[1],0
        jmp tempo_a_pagar
        
        
        c_preco:                     ;horasx240+(minutos/15+1)x60 
        
        mov bl,0                     ;pois vamos somar o 240, ah vezes
        mov bh,0                                                             
                                          
        preco_horas:                 ;multiplica as horas (ah) por 240(bh)  
        
        ;****************************horasx240*****************************************************       
        ; input: ah-> hora(vai decrementando), bl-> numero a somar 
        ; output: -> resultado da multipliocacao
        ;******************************************************************************************
        
        l0:
        
        cmp ah,0                     ;se forem iguais faz preco_minutos, se forem diferentes continua 
        
        je preco_minutos
        
        dec ah
        
        push bx
        add bl,240
        pop cx
        cmp cl,bl
        
        jb l0
        add bh,1
                                     ;O ciclo e executado AH-1 vezes, ja que e sempre feito pelo menos 1 ADD bl,bl
        
        jmp l0     
        ret
        
        preco_minutos:               ;divide os minutos por 15, soma-lhe 1 e multiplica tudo por 60 
        
        push bx                      ;bl tem o preco das horas
        mov bl,15d 
        div bl                       ;o resultado da divisao fica em al
        add al,1
        
        mov bl,60 
        mul bl         ;multiplicar al por 60 
                       ;o preco dos minutos fica em ax  
        pop bx
        mov ah, 0
        add ax,bx
        
        mov preco[0], ax
        
        
        mov ax, 0
        mov bx, 0
        mov cx, 0
        mov dx, 0
        
        mov ax, preco[0]
        mov di, offset quant_tot
        
        euro:                               
        
        cmp ax, 100
        jng centimos 
        
        mov bl, 10
        div bx
        mov dh, 0
        
        mov byte ptr[di], dl
        inc di
        inc cl
        
        jmp euro
        
        
        
        centimos: 
        
        mov bl, 10
        div bx                   
        mov byte ptr[di], dl
        inc di
        inc cl
        
        
        imp:
        
        add al, 30h
        mov ah, 0Eh
        int 10h
        cmp cl, 0
        je ex
        dec cl
        dec di
        mov al, byte ptr[di]
        jmp imp
        inc cl
        
        ex:
        ret
    
    endp
                

    hora_atual proc 
        mov ah, 2ch   ;guardar a
        int 21h       ;hora atual
        ret
    endp    


    hora_var proc
        mov di,offset array_horas
        mov si,offset hora_entrada
        mov ah, 0
        mov cx, 0
        push cx
        
        escreve_h:
            mov al, byte ptr[di]
            
            cmp al, ":"
            je dois_p
            
            cmp al, 2eh
            je sai_hvar
            
            pop cx
            add ax, cx            
            mov bl, 10
            mul bl

            push ax
            inc di
            jmp escreve_h
            
            dois_p:
                pop ax
                div bl
                mov byte ptr[si], al
                inc si
                inc di
                mov cx, 0
                push cx
                jmp escreve_h
            
            sai_hvar:
                pop ax
                div bl
                mov byte ptr[si], al
                ret
        
    endp
        

;*************************************************************************************************************
;
;SET VIDEO MODE
;
;*************************************************************************************************************

    setVideoMode proc
        push ax
        mov al, 13h
        mov ah,0
        int 10h
        pop ax
        ret
    endp


;*************************************************************************************************************
;
;TIME
;
;*************************************************************************************************************

    time proc
        push ax
        push cx
        push dx
        push si
        
        mov ah, 2Ch
        int 21h
        xor ax,ax
        xor bx,bx
        mov al,ch        ;horas
        mov si,offset strhoras
        mov dl,10
    minutos: 
        div dl    
        inc bx
        add al, 48              
        add ah, 48
        mov [si], al            
        inc si
        mov [si], ah
        inc si  
        cmp bx,3
        je imprime_horas
        mov [si],':'
        inc si   
        cmp bx,2
        je segundos
        xor ax,ax         ;minutos
        mov al,cl
        jmp minutos
    segundos: 
        xor ax,ax         
        mov al,dh         ;segundos
        jmp minutos   
           
        
    imprime_horas:
        mov al, 0
        mov bl, cores[4]
        mov bh, 0
        mov cx, 8                   ;numero de caracteres
        mov dl, 14
        mov dh, 1                   ;coluna 1
        mov bp, offset strhoras
        call writestr
                      
        pop si
        pop dx
        pop cx
        pop ax
        ret
        
    endp
    
    escreve_hora proc
        
        ;aponta para o array das horas    
        ;push ax
        mov si,offset array_horas

        mov ax,0
            
        ;guarda valor no AL
        
        l1:
         
        mov ah, 1
        int 21h
        sub al,30h
        
        ;passa o que estava no AL pra posicao
        ;apontada pelo SI
        
        mov byte ptr[si],al
        
        ;ve se chegou ao fim
        
        inc si
        cmp [si],2eh
        je l2
        
        ;ve se chegou ao ":"
        
        cmp [si],':'
        jne l1
        
        mov al,total
        mov al,0
        push ax
        mov ah,2h
        mov dl,':'
        int 21h
        
        inc si
     
        ;faz RESET ao total
        
        jmp l1
        l2:
        mov al,total
        jmp dinheiros

    endp     
    
;*************************************************************************************************************
;
;SAIR -- Devolve o controlo ao sistema operativo
;
;*************************************************************************************************************
        
        setCursorPos proc
        
            push cx
            push ax
            
            mov ah, 02h
            int 10h
        
        exit_setCursorPos: 
            pop cx       
            mov ah, ch   
            pop cx       
            ret
        setCursorPos endp        
        
        setDirect proc 
        
            mov ah, 3bh
            int 21h
        
            exit_setDirect: 
                ret    
        setDirect endp
        
        fCreate proc 
                                                                                                                                      
            mov ah, 3Ch 
            int 21h
        
            exit_fCreate: 
                ret    
        endp 

        fWrite proc 
            
            mov bx, handle
            mov ah, 40h
            int 21h    
      
            exit_fWrite: 
                ret     
        endp
        
        fWriteNewLine proc
        
            lea dx, endLine 
            mov cx, 2
            call fWrite
            
            exit_fWriteNewLine:  
                ret
        endp
        
        fWriteCquantity proc              
        
            mov dh, 64h
            mov cl, 3
            xor ch, ch
            
            newDigit3:
            
            mov dl, al                   
                       
            div dh                       
            
            or ch, al                   
            jz dontPrint2               
                                
            inc ch                  
            
            add al,30h               
            
            mov informacao, al        
            
            push ax                
            push cx                 
            push dx                 
                                
            mov cx, 1               
            lea dx, informacao         
            call fWrite             
            jc exit_fWriteCquantity 
                                
            pop dx                  
            pop cx                  
            pop ax                  
            
            mov dl, ah              
            
            dontPrint2:
            
            xor ah, ah                  
            mov al, dh                  
            mov dh, 0Ah                 
            div dh                      
            mov dh, al                  
            
            mov al, dl                  
            
            dec cl                          
            jnz newDigit3                   
            
            test ch,ch                      
            jnz numNotZero2                
                                
            mov al,30h                  
            mov informacao, al             
                                
            mov cx, 1                   
            lea dx, informacao             
            call fWrite                 
            jc exit_fWriteCquantity     
                                
            numNotZero2:                    
            
            clc                 
            
            exit_fWriteCquantity: 
            ret
        
        endp
        
        f_Close proc
        
            mov ah,3eh
            int 21h    
            ret    
        endp
    
    
    sair proc    

        lea dx, filePath             
        call setDirect                
        
        lea dx, fileName              
        xor cx, cx                    
        call fCreate                  

        mov cx, 4                     
        lea dx, cent200               
        call fWrite                                                                
        mov al, strmoed_qntd[1]          
        call fWriteCquantity                                                       
        call fWriteNewLine
        
        mov cx, 4                     
        lea dx, cent100               
        call fWrite                                                                
        mov al, strmoed_qntd[3]          
        call fWriteCquantity                                                       
        call fWriteNewLine
        
        mov cx, 3                     
        lea dx, cent50               
        call fWrite                                                                
        mov al, strmoed_qntd[5]          
        call fWriteCquantity                                                       
        call fWriteNewLine
        
        mov cx, 3                     
        lea dx, cent20               
        call fWrite                                                                
        mov al, strmoed_qntd[7]          
        call fWriteCquantity                                                       
        call fWriteNewLine
        
        mov cx, 3                     
        lea dx, cent10               
        call fWrite                                                                
        mov al, strmoed_qntd[9]          
        call fWriteCquantity                                                       
        call fWriteNewLine                        
        
        mov cx, 2                     
        lea dx, cent5                 
        call fWrite                                                                   
        mov al, strmoed_qntd[11]          
        call fWriteCquantity                                                        
        call fWriteNewLine                      
            
        mov cx, 2                     
        lea dx, cent2                 
        call fWrite                                                                   
        mov al, strmoed_qntd[13]          
        call fWriteCquantity                                                        
        call fWriteNewLine 
        
        mov cx, 2                     
        lea dx, cent1                 
        call fWrite                                                                   
        mov al, strmoed_qntd[9] ;strmoed_qntd[15]         
        call fWriteCquantity                                                        
        call fWriteNewLine 
        
        call f_Close
        
        mov ax, 4c00h ; exit to operating system.
        int 21h
        
    endp 
    
ends

end start ; set entry point and stop the assembler.
