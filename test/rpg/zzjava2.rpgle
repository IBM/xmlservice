     H AlwNull(*UsrCtl)

     D rpgVary         S           4096A   INZ(*BLANKS) VARYING

     D pathstr         S               O   CLASS(*JAVA:'java.lang.String')
     D propstr         S               O   CLASS(*JAVA:'java.lang.String')

     D makeString      PR              O   EXTPROC(*JAVA:'java.lang.String':
     D                                      *CONSTRUCTOR)
     D    bytes                    4096A   CONST VARYING

     D trimString      PR              O   CLASS(*JAVA:'java.lang.String')
     D                                     EXTPROC(*JAVA:'java.lang.String':
     D                                      'trim')

     D getProperty     PR              O   CLASS(*JAVA:'java.lang.String')
     D                                     ExtProc(*JAVA:'java.lang.System':
     D                                      'getProperty')
     D                                     static
     D inString                        O   CLASS(*JAVA:'java.lang.String')

     D getBytes        PR          4096A   EXTPROC(*JAVA:'java.lang.String':
     D                                      'getBytes') VARYING


     D Main            PR                  ExtPgm('ZZJAVA2') 
     D  ms                         4096a
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Main            PI 
     D  ms                         4096a
      /free
        propstr = makeString('java.class.path');
        pathstr = makeString(' ');
        pathstr = getProperty(propstr);
        // pathstr = trimString(pathstr);
        rpgVary = getBytes(pathstr);
        ms      = rpgVary;
        return;
      /end-free

