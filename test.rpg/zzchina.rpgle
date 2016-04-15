     H AlwNull(*UsrCtl)

     D ms1             s           4096a   inz(*BLANKS)

     D Main            PR                  ExtPgm('ZZCHINA') 
     D  ms                         4096a
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Main            PI 
     D  ms                         4096a
      /free
        ms1 = x'C4E3'; // h in hello 
        ms = ms1;
        return;
      /end-free

