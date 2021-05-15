STACK SEGMENT STACK
   DB 64 DUP(?)
STACK ENDS

DATA SEGMENT
cadena	 	db '                      $'
cadena2 	db '         $'
cadena3 	db '                      $'
login 		db 'Dame tu nombre $'
palabra		db 10,13,'h) Ahora dame una palabra (maximo 9 caracteres) : $'
palabra2	db 10,13,'i)Dame otra palabra: $'
letrasA 	db 'Cambio a las vocales a "a": $'
letrasE 	db 'Cambio a las vocales a "e": $'
contador 	db 0
vocal 		db 'Dame una vocal: $'
noesvocal	db 13,10,'Lo que ingresaste no es una vocal$'
txt1		db '***** ***** *     *        * *****',10,13,'$'
txt2		db '*     *   * *      *      *  *',10,13,'$'
txt3		db '***** ***** *       *    *   *****',10,13,'$'
txt4		db '    * *   * *        *  *    *',10,13,'$'
txt5		db '***** *   * *****     *      *****',10,13,'$'
total		db 'Numero de veces que se repite la vocal: $'
enter 		db 10,13,'$'
;-------------------------para el karaoke -------------------------------------
cargando	db 'Cargando karaoke.',13,10,'$'
cargando2	db 'Cargando karaoke..',13,10,'$'
cargando3	db 'Cargando karaoke...',13,10,'$'
linea1 		db 'Tu sonrisa tan resplandeciente$'
linea2 		db 'A mi corazon deja encantado$'
linea3 		db 'Ven toma mi mano$'
linea4 		db 'para huir de esta terrible obscuridad. $'
columna 	db 15
columna2 	db 15
columna3 	db 15
columna4 	db 15
titulo 		db '....::: MI CORAZON ENCANTADO :::....$'
tecla 		db 13,10,13,10,'[PRESIONE CUALQUIER TECLA PARA MOSTRAR EL KARAOKE] $'
DATA ENDS

CODE SEGMENT
Assume DS:DATA, CS:CODE, SS:STACK
BEGIN:mov ax,DATA
    mov ds,ax
	   
	mov ah,00h  
    mov al,03h ;modo de video 3
     int 10h
cuadros:
;Cuadro en color azul. 
    MOV AH,06H ;LIMPIEZA 3
    MOV AL,00H
    MOV BH,17H ;COLOR AZUL
    MOV CX,0005H ;esquina sup izq
    MOV DX,1250H ;esquina inf der
    INT 10H
;cuadro en color cian
    MOV AH,06H 
    MOV AL,00H
    MOV BH,30H ;(fondo,color de letras)
    MOV CX,0500H ;esquina sup izq
    MOV DX,4545H ;esquina inf der
    INT 10H	

	;movemos el cursor
	mov ah,02h ;Selección de posición del cursor
	mov dh,0Dh ;renglón
	mov dl,15h ;columna
	mov bx,00h ;para gráficos
	int 10h	 
	   
	lea dx,login ;Mensaje que pide el nombre
	mov ah, 09h        
	int 21h
	
	lea dx,enter
	mov ah, 09h        
	int 21h	  
	  
	;movemos el cursor
	mov ah,02h ;Selección de posición del cursor:BH = numero de pagina 
	mov dh,0Eh ;renglón
	mov dl,15h ;columna
	mov bx,00h ;para gráficos
	int 10h	
		
	mov cx,23
	mov si,0
leer: 
    mov ah,07h ; esperar recibir un caracter y lo coloca en al
    int 21h 	
    cmp AL,13
	je saludo
	mov dl,'*'  ;  ;mov dl,al
    mov ah,02h
    int 21h
	   
    mov cadena[si],al
    inc si
    loop leer
	   
saludo:
; borramos pantalla.
    mov  ah,06h
    mov  bh,0Eh; fondo negro y letras blancas
    mov  dh,10
    mov  dl,10
    mov  al,0h
    mov  cx,00h
    mov dx,30a0h
    int  10h
	   
	;movemos el cursor
	mov ah,02h ;Selección de posición del cursor:BH = numero de pagina 
	mov dh,08h ;renglón
	mov dl,15h ;columna
	mov bx,00h ;para gráficos
	int 10h	   
	lea dx,txt1 ;imprimimos mensaje
	mov ah, 09h        
	int 21h
	  ;movemos
	mov ah,02h ;Selección de posición del cursor:BH = numero de pagina 
	mov dh,09h ;renglón
	mov dl,15h ;columna
	mov bx,00h ;para gráficos
	int 10h	
    lea dx,txt2 ;imprimimos
	mov ah, 09h        
	int 21h
	 
	mov ah,02h ;Selección de posición del cursor:BH = numero de pagina 
	mov dh,0Ah ;renglón
	mov dl,15h ;columna
	mov bx,00h ;para gráficos
	int 10h		 
	lea dx,txt3
	mov ah, 09h        
	int 21h
	  
	mov ah,02h ;Selección de posición del cursor:BH = numero de pagina 
	mov dh,0Bh ;renglón
	mov dl,15h ;columna
	mov bx,00h ;para gráficos
	int 10h	
	lea dx,txt4
	mov ah, 09h        
	int 21h

	mov ah,02h ;Selección de posición del cursor:BH = numero de pagina 
	mov dh,0Ch ;renglón
	mov dl,15h ;columna
	mov bx,00h ;para gráficos
	int 10h		  
	lea dx,txt5
	mov ah, 09h        
	int 21h
;INICIO DEL INCISO H) Leer una palabra y una vocal y contar cuantas veces se repite la vocal dentro de la palabra	 
PEDIR:
	lea dx, palabra ;imprimimos 'dame una palabra'
	mov ah, 09h
	int 21h
	mov cx,9
	mov si,0
leemos:
    mov ah,07h ; esperar recibir un caracter y lo coloca en al
    int 21h 	
    cmp AL,13
	je declarar
	mov dl,al  ;  ;mov dl,al
    mov ah,02h
    int 21h
	   
    mov cadena2[si],al
    inc si
    loop leemos	 
declarar:
	mov cx,23
	mov si,0
	lea dx,enter
	mov ah,09h
	int 21h
	;pedimos la vocal
	lea dx,vocal ;imprime 'dame una vocal'
	mov ah,09h
	int 21h
	mov ah,01h ;espera a que ingresemos una vocal para ponerlo en al
	int 21h
;si lo ingresado es una vocal se empezaran a contar, sino muestra un mensaje
	cmp al,65 ;A
    JE Validar 
	cmp al,69 ;E
    JE Validar	
	cmp al,73 ;I
    JE Validar
	cmp al,79 ;O
    JE Validar	
	cmp al,85 ;U
    JE Validar
	cmp al,97
    JE Validar
	cmp al,101
    JE Validar
	cmp al,105
    JE Validar
	cmp al,111
    JE Validar
	cmp al,117
    JE Validar	
;otraletra:
	lea dx,noesvocal
	mov ah, 09h
	int 21h
	jmp PEDIR2
	
Validar:
	;si se ingresó una vocal 
	cmp cadena2[si],al ;A
    JE contar 
	inc si
restar:	loop Validar

	lea dx, enter
	mov ah,09h
	int 21h
	 
	lea dx,total ;total de vocales
	mov ah, 09h        
	int 21h
	 
	mov ah,2
    mov dl,contador 
	add dl, 48
	int 21h
	jmp PEDIR2
    contar: ;ETIQUETA PARA AUMENTAR EL CONTADOR
	inc contador
	inc si	
    JMP restar

;FIN DEL INCISO H	 

;------------------------ INICIO DEL INCISO I --------------------------------
		
	PEDIR2:
	lea dx,enter
	mov ah,09h
	int 21h
		
	lea dx, palabra2 ;imprimimos 'dame una palabra'
	mov ah, 09h
	int 21h
	mov cx,9
	mov si,0
leemos2:
    mov ah,07h ; esperar recibir un caracter y lo coloca en al
    int 21h 	
    cmp AL,13
	je declarar2
	mov dl,al  
    mov ah,02h
    int 21h
	mov cadena3[si],al
Aux:inc si
    loop leemos2	 
	;fin de la lectura
declarar2:
	mov cx,9
	mov si,0
recorrer:
    cmp cadena3[si],101 ;e
	JE esA
	cmp cadena3[si],69 ; E
	JE esA
	cmp cadena3 [si],105;i
	jE esA
	cmp cadena3 [si], 73 ;I
	JE esA
	cmp cadena3[si],111;o
	JE esA
	cmp cadena3 [si], 79 ; la O
	JE esA
	cmp cadena3[si],117;u
	JE esA
	cmp cadena3 [si],85 ; la U
	JE esA
iteracion:
	inc si 
	loop recorrer
    JMP imprimirA	

esA: ;entra aqui solo si encuentra una vocal que no sea a (las que son "A" no necesitan ser cambiadas)
	mov cadena3[si],97 ;cambia la vocal por una a
	jmp iteracion 
	
imprimirA:
	lea dx,enter
	mov ah,09h
	int 21h
	lea dx,letrasA ;mostramos mensaje
	mov ah,09h
	int 21h
	lea dx, cadena3 ;palabra con las vocales cambiadas
	mov ah,09h
	int 21h
	lea dx,enter
	mov ah,09h
	int 21h	
reinicio:
	mov cx,23
	mov si,0
nuevociclo: ;aqui comparamos solo las que tienen A como vocal ya que anteriormente cambiamos todas las vocales
	cmp cadena3[si],97 ;a
	JE esE
	cmp cadena3[si],56 ;A
	JE esE
condicion:
	inc si
	loop nuevociclo
	jmp imprimirE
esE:
	mov cadena3[si],101
	jmp condicion
imprimirE:
	lea dx,letrasE ;mostramos mensaje
	mov ah,09h
	int 21h
	lea dx, cadena3 ;variable con las vocales en E
	mov ah,09h
	int 21h
	lea dx,enter
	mov ah,09h
	int 21h	
	
	lea dx,tecla ;'presiona cualquier tecla'
	mov ah,09h
	int 21h
	
	mov ah,07h
	int 21h

;------------------------ FIN DEL INCISO I ------------------------
;------------------------- iniciamos karaoke --------------------------- 

;limpiamos pantalla
       mov ah,00h  
       mov al,03h  ;modo 80x25 a color
       int 10h  
;----------------	   
;posisionamiento del cursor
    mov ah,02h
    mov bx,0000h
    mov dl,1 ;col
    mov dh,1  ;renglon
    int 10h
	lea dx,cargando
	mov ah,09h
	int 21h

Tiempo:mov cx,9c4h ;
ciclo1:
	sub cx,1
	mov bx,1f4h
ciclo2:	
	sub bx,1
	cmp bx,0
	jne ciclo2	
	cmp cx,0
	jne ciclo1
	
	;posisionamiento del cursor
    mov ah,02h
    mov bx,0000h
    mov dl,1 ;col
    mov dh,1  ;renglon
    int 10h
	lea dx,cargando2
	mov ah,09h
	int 21h

Tiempo2:mov cx,9c4h
b:
	sub cx,1
	mov bx,1f4h
b1:	
	sub bx,1
	cmp bx,0
	jne b1	
	cmp cx,0
	jne b
	;posisionamiento del cursor
    mov ah,02h
    mov bx,0000h
    mov dl,1 ;col
    mov dh,1  ;renglon
    int 10h
	
	lea dx,cargando3
	mov ah,09h
	int 21h

Tiempo3:mov cx,0A8CH
b2:
	sub cx,1
	mov bx,1f4h
b3:	
	sub bx,1
	cmp bx,0
	jne b3	
	cmp cx,0
	jne b2	

;limpiamos la pantalla
    mov ah,00h  
    mov al,03h  ;modo 80x25 a color
    int 10h  
;----------------
;karaoke
    ;Dibuja un cuadro
	mov cx, 0000h        
    mov dx, 0348h 
    xor al, al        
    mov bh, 0Fh ;  Fondo negro, letras blancas
    mov ah, 6
    int 10h 
	;posisionamiento del cursor
    mov ah,02h
    mov bx,0000h
    mov dl,15 ;col
    mov dh,1  ;renglon
    int 10h 
	mov dx,offset titulo
    mov ah,09
    int 21h	


;--------- CANCIÓN------------------------

;--------- LINEA 1------------------------
;Dibujamos un cuadro
dibujar:
    mov cx, 0500h    ;coordenadas esquina superior izquierda  
	mov dh,05 ;renglon
	mov dl,columna ;columna
	xor al, al        
    mov bh, 0Bh ;  Fondo negro, letra azul claro
    mov ah, 6
    int 10h 
	mov ah,02h ;posicion del cursor
    mov bx,0000h
	mov dh,5  ; fila
    mov dl,19 ;columna
    int 10h 
	mov dx,offset linea1 ;PRIMER RENGLON
    mov ah,09
    int 21h	
		
		
;retardo de tiempo
retardo:mov cx,258h 
l1:	sub cx,1
	mov bx,200
a1:	sub bx,1
	cmp bx,0
	jne a1	
	cmp cx,0
	jne l1
	inc columna
	mov al,columna
	cmp columna,50
	je dibujar2
	jmp dibujar
 ;fin del retardo
 
dibujar2:
    mov cx, 0600h    ;coordenadas esquina superior izquierda  
    mov dh,06 ;renglon
	mov dl,columna2 ;columna
	xor al, al        
    mov bh, 0Ah ;  Fondo negro, letra azul
    mov ah, 6
    int 10h 

    mov ah,02h
    mov bx,0000h
	mov dh,6  ; fila
    mov dl,19 ;columna
    int 10h 
		
    mov dx,offset linea2 ;PRIMER RENGLON
    mov ah,09
    int 21h	
		
		
 ;retardo de tiempo

retardo2:mov cx,258h  ;esto es igual a 1000
l12:sub cx,1
	mov bx,200
a12:sub bx,1
	cmp bx,0
	jne a12	
	cmp cx,0
	jne l12
	inc columna2
	mov al,columna2
	cmp columna2,50
	je dibujar3
	jmp dibujar2
 ;fin del retardo
 
dibujar3:
    mov cx, 0700h    ;coordenadas esquina superior izquierda  
    mov dh,07 ;renglon
	mov dl,columna3 ;columna
	xor al, al        
    mov bh, 0Dh ;  Fondo negro, letra azul
    mov ah, 6
    int 10h 

    mov ah,02h
    mov bx,0000h
	mov dh,7  ; fila
    mov dl,19 ;columna
    int 10h 
		
    mov dx,offset linea3 ;PRIMER RENGLON
    mov ah,09
    int 21h	
	
 ;retardo de tiempo
retardo3:mov cx,258h  
l13:sub cx,1
	mov bx,200
a13:sub bx,1
	cmp bx,0
	jne a13	
	cmp cx,0
	jne l13
	inc columna3
	mov al,columna3
	cmp columna3,35
	je dibujar4
	jmp dibujar3
 ;fin del retardo
 
 dibujar4:
    mov cx, 0800h    ;coordenadas esquina superior izquierda  
    mov dh,08 ;renglon
	mov dl,columna4 ;columna
	xor al, al        
    mov bh, 0Eh ;  Fondo negro, letra azul
    mov ah, 6
    int 10h 

    mov ah,02h
    mov bx,0000h
	mov dh,8  ; fila
    mov dl,19 ;columna
    int 10h 
		
    mov dx,offset linea4 ;PRIMER RENGLON
    mov ah,09
    int 21h	
		
 ;retardo de tiempo
retardo4:mov cx,258h 
l14:sub cx,1
	mov bx,200
a14:sub bx,1
	cmp bx,0
	jne a14	
	cmp cx,0
	jne l14
	inc columna4
	mov al,columna4
	cmp columna4,60
	je FIN
	jmp dibujar4
 ;fin del retardo y karaoke
fin:
mov ah, 4ch
int 21h
CODE ENDS
     END BEGIN