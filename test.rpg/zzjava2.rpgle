     H AlwNull(*UsrCtl)

     D myfunc          S            128A   inz('jvmString')
     D makestring      PR              O    EXTPROC(*JAVA:
     D                                       'java.lang.String':
     D                                       *CONSTRUCTOR)
     D    bytes                      30A    CONST VARYING

     D string          S               O    CLASS(*JAVA:'java.lang.String')

     D Main            PR                  ExtPgm('ZZJAVA2') 
     D  ms                           40a
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Main            PI 
     D  ms                           40a
      /free
        string = makestring('TEST');
        ms = 'TEST';
        return;
      /end-free

