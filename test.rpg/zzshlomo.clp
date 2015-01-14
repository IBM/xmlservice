PGM PARM(&CHAR1 &NUM2 &RTNVAL)                                 
      DCL VAR(&CHAR1) TYPE(*CHAR) LEN(15)                            
      DCL VAR(&NUM1) TYPE(*DEC) LEN(10)                              
      DCL VAR(&NUM2) TYPE(*CHAR) LEN(10)                             
      DCL VAR(&RTNVAL) TYPE(*CHAR) LEN(100)                          
      CHGVAR VAR(&CHAR1) VALUE('I am 15')             
      CHGVAR VAR(&NUM2) VALUE(12.2)             
      CHGVAR VAR(&RTNVAL) VALUE('ALAN HOW ARE YOU TEST one of one')  
 ENDPGM: +                                                           
     ENDPGM                                                         

