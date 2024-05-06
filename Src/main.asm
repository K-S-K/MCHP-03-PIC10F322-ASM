    LIST    P=10F322          ; Directive to define the device
    #include <xc.inc>         ; Include the header file for the PIC10F322
    
    config  FOSC = INTOSC     ; Internal oscillator
    config  BOREN = ON        ; Brown-out Reset Enable->Brown-out Reset enabled
    config  WDTE = OFF        ; Watchdog Timer disabled
    config  PWRTE = OFF       ; Power-up Timer disabled
    config  MCLRE = ON        ; MCLR/VPP pin function enabled
    config  CP = OFF          ; Code protection disabled
    config  LVP = OFF         ; Low-voltage programming disabled
    config  LPBOR = ON        ; Brown-out Reset Selection bits->BOR enabled
    config  BORV = LO         ; Brown-out Reset Voltage Selection->Brown-out Reset Voltage (Vbor), low trip point selected.
    config  WRT = OFF         ; Flash Memory Self-Write Protection->Write protection off
    
    ; Define constants
    LED_PIN1    EQU     1       ; RA1 is connected to the LED
    LED_PIN2    EQU     2       ; RA2 is connected to the LED
    DELAY_VAL   EQU     0x7FFF  ; Delay value for approximately 500ms (depends on oscillator frequency)

    ; Initialization routine
    ORG     0x0000              ; Reset vector
    GOTO    Main                ; Jump to the main code

    ; Main code
    ORG     0x0010              ; Start of main code

Main:
    MOVLW   0b00000111          ; Select 4MHz internal oscillator
    MOVWF   OSCCON              ; Write OSCCON register
    

    BCF     TRISA, LED_PIN1      ; Set RA1 as output
    BCF     TRISA, LED_PIN2      ; Set RA2 as output
    
//*    
Loop:
    BSF     PORTA, LED_PIN1     ; Turn on LED (RA1)
    CALL    Delay               ; Call delay subroutine
    BCF     PORTA, LED_PIN1     ; Turn off LED (RA1)
    BSF     PORTA, LED_PIN2     ; Turn on LED (RA2)
    CALL    Delay               ; Call delay subroutine
    BCF     PORTA, LED_PIN2     ; Turn off LED (RA2)
    CALL    Delay               ; Call delay subroutine
    GOTO    Loop                ; Repeat indefinitely

Delay:
    MOVLW   DELAY_VAL           ; Load delay value high byte
    MOVWF   0x20                ; Store delay value in WREG
Delay_Loop:
    DECFSZ  0x20, F             ; Decrement delay value
    GOTO    Delay_Loop          ; Loop until delay value reaches zero
    RETURN                      ; Return from subroutine
//*/
    END                         ; End of program
