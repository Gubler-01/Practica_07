.ORG 0x00                   ; Dirección de inicio del programa

RJMP INICIO                 ; Salta a la etiqueta INICIO
INICIO:                     ; Etiqueta de inicio
    LDI R16, LOW(RAMEND)    ; Carga el valor bajo de RAMEND en el registro R16
    OUT SPL, R16            ; Escribe el valor de R16 en el registro SPL
    LDI R16, HIGH(RAMEND)   ; Carga el valor alto de RAMEND en el registro R16
    OUT SPH, R16            ; Escribe el valor de R16 en el registro SPH
    ldi r16, 0xFF           ; Carga el valor 0xFF en el registro R16
    out DDRB, r16           ; Escribe el valor de R16 en el registro DDRB
    cbi DDRB, 0            ;
    cbi DDRB, 1            
    cbi DDRB, 2             
    cbi DDRB, 3             
    cbi DDRB, 4            
    cbi DDRB, 5             
    ldi r16, 0xFF           ; Carga el valor 0xFF en el registro R16
    out DDRD, r16           ; Escribe el valor de R16 en el registro DDRD
    ldi r21, 1              ; Carga el valor 1 en el registro R21
    ldi r22, 0              ; Carga el valor 0 en el registro R22
Return:                   
    ldi r19, 1              ; Carga el valor 1 en el registro R19
    ldi r20, 0              ; Carga el valor 0 en el registro R20
    in r16, PINB            ; Lee el valor del registro PINB y lo guarda en R16
    mov r17, r16            ; Copia el valor de R16 en R17
    cpse r22, r17           ; Compara si R22 es igual a R17 y salta si son iguales
    rjmp Chekprimo          ; Salta a la etiqueta Chekprimo
    rjmp Noconfirma         ; Salta a la etiqueta Noconfirma

Divprimo:                  
    cp r18, r19             ; Compara R18 con R19
    brcs Stopdiv            ; Salta a la etiqueta Stopdiv si el resultado de la comparación es menor o igual
    sub r18, r19            ; Resta R19 de R18
    brne Divprimo           ; Salta a la etiqueta Divprimo si el resultado de la resta no es cero
    inc r19                 ; Incrementa R19
    inc r20                 ; Incrementa R20
    rjmp Chekprimo          ; Salta a la etiqueta Chekprimo
	Chekprimo:                 
    mov r18, r17            ; Copia el valor de R17 en R18
    cpse r19, r17           ; Compara si R19 es igual a R17 y salta si son iguales
    rjmp Divprimo           ; Salta a la etiqueta Divprimo
    cpse r20, r21           ; Compara si R20 es igual a R21 y salta si son iguales
    rjmp Noconfirma         ; Salta a la etiqueta Noconfirma
    rjmp Confirma           ; Salta a la etiqueta Confirma
	Noconfirma:                 
    cbi PortD, 7            ; Limpia el bit 7 del registro PortD
    rjmp Return             ; Salta a la etiqueta Return
	Confirma:                   
    sbi PortD, 7            ; Establece en alto el bit 7 del registro PortD
    rjmp Return             ; Salta a la etiqueta Return
	Stopdiv:                   
    inc r19                 ; Incrementa R19
    rjmp Chekprimo          ; Salta a la etiqueta Chekprimo