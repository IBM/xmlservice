     H AlwNull(*UsrCtl)


     D sleep           PR                  ExtProc('sleep')
     D  nSecs                        10i 0 Value

     D writeIFS        PR            20I 0 ExtProc('write')     
     D   fd                          10I 0 value                       
     D   buf                           *   value
     D   size                        10I 0 value 

     D ms1             s           4096a   inz(*BLANKS)


     D Main            PR                  ExtPgm('ZZCHINAO')
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Main            PI 
      /free
        // sleep(5000);
        ms1 = x'C4E3'; // h in hello
        // ms1 = 'HI';
        writeIFS(4:%addr(ms1):%len(%trim(ms1)));
        return;
      /end-free

