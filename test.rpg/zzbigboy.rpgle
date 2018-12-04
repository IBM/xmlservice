     H AlwNull(*UsrCtl)

     D STEP1           s              7s 0

     D BIGBOY1         ds                  occurs(1000000)
     D NAME1                   1      7
     D YEARWIN1                8     14  1
     d*
     D i               S             10i 0 inz(0)
     D j               S             10i 0 inz(0)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     C     *Entry        PLIST
     c                   parm                    STEP1
     c                   parm                    BIGBOY1
      /free
        for i = 1 to STEP1;
          %OCCUR(BIGBOY1) = i;
          NAME1 = 'B' + %char(i);
          YEARWIN1 = i + .1;
        endfor;
        return;
      /end-free
