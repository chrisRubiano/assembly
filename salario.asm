; salario.asm Calcula el impuesto al sueldo
; Cristian Samaniego
; 17/11/2015
;-------------------------------------------
; sueldo > 50000 impuesto = 35%
; sueldo > 25000 y < 50000 impuesto = 30%
; sueldo > 10000 y < 24999 impuesto = 20%
; sueldo < 10000  impuesto = 0%
; debe imprimir:
; salario: 55000
; impuesto: 19250
; sueldo neto: 35750
;-------------------------------------------

%include 'funciones.asm' 

section .data
	msgsalario db "Salario: ", 0x0
	msgimpuesto db "Impuesto: ", 0x0
    msg db "mayor a 50",0x0
    msg2 db "mayor a 25", 0x0
    msg3 db "mayor a 10", 0x0
    msg4 db "menor a 10", 0x0

section .text
    global _start
    
_start:
    pop ECX                             ;obtenemos el numero de argumentos del stack
    pop EAX                             ;sacamos el nombre del programa del stack (el argumento 0)
    dec ECX                             ;le restamos 1 a ECX
    ;mov EDX, 0                          


sigArg:
    cmp ECX, 0                          ;checamos si todavia hay argumentos
    jz noMasArgs                        ;si cero, ya no hay mas argumentos
    pop EAX                             ;sacamos del stack el siguiente argumento
    call atoi                           ;convertimos el argumento a entero   
    mov EDX, 50000						;movemos 50000 para comparar con el salario
    cmp EDX,EAX                         ;comparamos lo que esta en EAX con nuestro numero mayor
    jle mayora50	                    ;si es mayor, sobreescribimos el registro
    mov EDX, 25000
    cmp EDX, EAX
    jle mayora25
    mov EDX, 10000
    cmp EDX, EAX
    jle mayora10
    jg menora10    
    dec ECX                             ;le restamos 1 a ECX
    jmp sigArg                          ;saltamos a sigArg para obtener otro argumento
    
noMasArgs:
    ;mov EAX, msg                        ;preparamos para imprimir mensaje
    ;call sprint                         ;imprimimos
    ;mov EAX,EDX                         ;movemos nuestro numero mayor para imprimirlo
    ;call iprintLF                       ;imprimimos el resultado con linefeed
    call quit                           ;salida

mayora50:
	push eax
	mov eax,msgsalario
	call sprint
	pop eax
	call iprintLF
	push eax
	mov eax, msgimpuesto
	call sprint
	pop eax
	mov edx, 30
	mul edx
	mov ebx, 100
	div ebx

	call iprintLF
	dec ecx
	jmp sigArg

mayora25:
	mov eax, msg2
	call sprintLF
	dec ecx
	jmp sigArg

mayora10:
	mov eax, msg3
	call sprintLF
	dec ecx
	jmp sigArg

menora10:
	mov eax, msg4
	call sprintLF
	dec ecx
	jmp sigArg