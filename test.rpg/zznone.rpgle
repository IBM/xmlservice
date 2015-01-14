     H AlwNull(*UsrCtl)

     D Main            PR                  ExtPgm('ZZNONE') 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Main            PI 
      /free
        return;
        // *inlr = *on;
      /end-free

