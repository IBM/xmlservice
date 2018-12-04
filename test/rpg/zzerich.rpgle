     H AlwNull(*UsrCtl)
     D $vevsfi         s              1
     D $vevsrj         s              2
     D $vevsob         s              7s 0
     D $vevsve         s              5s 0
     D*Ergebnisdaten:
     D $vevsods        ds                  occurs(200)
     D $vsukz                  1      1
     D $vpos                   2      9
     D $vtxt                  10     39
     D $vkalw                 40    174  2 dim(15)
     D $vvsw                 175    309  2 dim(15)
     D $vvsk                 310    324  0 dim(15)
     d*
     D i               S             10i 0 inz(0)
     D j               S             10i 0 inz(0)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     C     *Entry        PLIST
     c                   parm                    $vevsfi
     c                   parm                    $vevsrj
     c                   parm                    $vevsob
     c                   parm                    $vevsve
     c                   parm                    $vevsods
      /free
        $vevsfi = 'A';
        $vevsrj = 'BB';
        $vevsob = 22.0;
        $vevsve = 33.0;
        for i = 1 to 200;
          %OCCUR($vevsods) = i;
          $vsukz = '1';
          $vpos  = '23456789';
          $vtxt  = 'lots o stuff';
          for j = 1 to 15;
            $vkalw(j) = 42.42;
            $vvsw(j) = 43.43;
            $vvsk(j) = 2.0;
          endfor;
        endfor;
        return;
      /end-free
