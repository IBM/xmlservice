     H AlwNull(*UsrCtl)
     D i               s             10i 0 inz(0)
     d MyErrorDs       ds                  qualified based(Template)
     d  ErrorId                       8a
     d  Severity                      3u 0
     d  Description                  80a
     d ErrorParm       ds                  likeds(MyErrorDs) dim(20)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     C     *Entry        PLIST                   
     C                   PARM                    ErrorParm
      /free
        for i = 1 to 20;
          // data values
          if ErrorParm(i).ErrorId = *BLANKS;
            return;
          endif;
          select;
          when i = 1;
            ErrorParm(i).ErrorId = '11111111';
            ErrorParm(i).Severity = 1.0;
            ErrorParm(i).Description = 'Universe blew up';
          when i = 2;
            ErrorParm(i).ErrorId = '22222222';
            ErrorParm(i).Severity = 2.0;
            ErrorParm(i).Description = 'World blew up';
          when i = 3;
            ErrorParm(i).ErrorId = '33333333';
            ErrorParm(i).Severity = 3.0;
            ErrorParm(i).Description = 'Machine blew up';
          // other?
          other;
            ErrorParm(i).ErrorId = %char(i);
            ErrorParm(i).Severity = i;
            ErrorParm(i).Description = 'Program blew up';
          endsl;
        endfor;
        return;
        // *inlr = *on;
      /end-free

