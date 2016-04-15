     H AlwNull(*UsrCtl)

       // *************************************************
       // main program
       // *************************************************
       dcl-c QPRINT_LEN 132;
       dcl-f qprint printer(QPRINT_LEN);
       dcl-ds qprint_ds len(QPRINT_LEN) end-ds;

       *inlr = '1'; 
       qprint_ds = x'C4E3';
       write qprint qprint_ds;


