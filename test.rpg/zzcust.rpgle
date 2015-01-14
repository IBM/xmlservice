     H AlwNull(*UsrCtl)

     D i               s             10i 0 inz(0)
     
     D pcustomer_id    s              8p 0
     D plines          s              4p 0
     D pline_ds        DS                  Dim(10) qualified
     D item                          35a
     D qty                           11p 3
     D price                         14p 4

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     C     *Entry        PLIST                   
     C                   PARM                    pcustomer_id
     C                   PARM                    plines
     C                   PARM                    pline_ds
      /free
        pcustomer_id = 12345678;
        plines = 8;
        for i = 1 to plines;
          pline_ds(i).item = 'good item ' + %char(i);
          pline_ds(i).qty = i;
          pline_ds(i).price = i*100;
        endfor;
        return; // *inlr = *on;
      /end-free

