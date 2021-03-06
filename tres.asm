;tres.asm Devuelve el numero mayor
;Cristian Samaniego
;
%include 'funciones.asm' 

section .data
    msg db "Numero mayor: ",0x0

section .text
    global _start
    
_start:
    pop ECX                             ;obtenemos el numero de argumentos del stack
    pop EAX                             ;sacamos el nombre del programa del stack (el argumento 0)
    dec ECX                             ;le restamos 1 a ECX
    mov EDX, 0                          ;guardamos 0 en EDX para compararlo con el primer argumento


sigArg:
    cmp ECX, 0                          ;checamos si todavia hay argumentos
    jz noMasArgs                        ;si cero, ya no hay mas argumentos
    pop EAX                             ;sacamos del stack el siguiente argumento
    call atoi                           ;convertimos el argumento a entero   
    cmp EDX,EAX                         ;comparamos lo que esta en EAX con nuestro numero mayor
    jle sobreEscribir                   ;si es mayor, sobreescribimos el registro    
    dec ECX                             ;le restamos 1 a ECX
    jmp sigArg                          ;saltamos a sigArg para obtener otro argumento
    
noMasArgs:
    mov EAX, msg                        ;preparamos para imprimir mensaje
    call sprint                         ;imprimimos
    mov EAX,EDX                         ;movemos nuestro numero mayor para imprimirlo
    call iprintLF                       ;imprimimos el resultado con linefeed
    call quit                           ;salida

sobreEscribir:
    mov EDX, EAX                        ;cuando es mayor mandamos el argumento ya convertido a nuestro registro
    dec ECX                             ;restamos 1 a ecx para pasar al siguiente argumento
    jmp sigArg                          ;saltamos a sigArg para obtener otro argumento