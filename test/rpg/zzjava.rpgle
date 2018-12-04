     H AlwNull(*UsrCtl)

     D Main            PR                  ExtPgm('ZZJAVA') 
     D  ms                           10i 0
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Main            PI 
     D  ms                           10i 0
      /free
        Exec Sql call xmlservice/sleeper(:ms);
        return;
      /end-free

