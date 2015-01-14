     H AlwNull(*UsrCtl)

     D i               s             10i 0 inz(0)

     D job_t           ds                  qualified based(Template)
     D  dsMyHire                       D   datfmt(*iso)
     D  dsMyLeav                       D   datfmt(*iso)
     D  dsMyJob                      64A   varying
     D  dsMyPay                      12p 2

     D MyDsArray       ds                  likeds(job_t) dim(3)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     C     *Entry        PLIST                   
     C                   PARM                    MyDsArray
      /free
        for i = 1 to 3;
          // data values
          select;
          when i = 1;
            MyDsArray(i).dsMyHire = d'2011-05-11';
            MyDsArray(i).dsMyLeav = d'2011-07-12';
            MyDsArray(i).dsMyJob  = 'Frog wrangler';
            MyDsArray(i).dsMyPay  = 7.25;
          when i = 2;
            MyDsArray(i).dsMyHire = d'2010-01-11';
            MyDsArray(i).dsMyLeav = d'2010-07-12';
            MyDsArray(i).dsMyJob  = 'Toad wrangler';
            MyDsArray(i).dsMyPay  = 4.29;
          when i = 3;
            MyDsArray(i).dsMyHire = d'2009-05-11';
            MyDsArray(i).dsMyLeav = d'2009-07-12';
            MyDsArray(i).dsMyJob  = 'Lizard wrangler';
            MyDsArray(i).dsMyPay  = 1.22;
          // other?
          other;
          endsl;
        endfor;
        return;
        // *inlr = *on;
      /end-free

