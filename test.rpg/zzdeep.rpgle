     H AlwNull(*UsrCtl)

     D INDS6           DS                  qualified based(Template)
     D  I1                           10i 0
     D  C2                           10a           
     D  P1                           12p 2      
     D  Z2                           12s 2            
     D  R2                            8F            
     D  R3                            4F            

     D INDS5           DS                  qualified based(Template)
     D  I1                           10i 0
     D  C2                           10a           
     D  P1                           12p 2      
     D  Z2                           12s 2            
     D  R2                            8F            
     D  R3                            4F            

     D INDS4           DS                  qualified based(Template)
     D  I1                           10i 0
     D  C2                           10a           
     D  P1                           12p 2      
     D  Z2                           12s 2            
     D   D5                                likeds(INDS5) dim(5)

     D INDS3           DS                  qualified based(Template)
     D  I1                           10i 0
     D  C2                           10a           
     D  P1                           12p 2      
     D  Z2                           12s 2            
     D   D4                                likeds(INDS4) dim(4)

     D INDS2           DS                  qualified based(Template)
     D  I1                           10i 0
     D  C2                           10a           
     D  P1                           12p 2      
     D  Z2                           12s 2            
     D   D3                                likeds(INDS3) dim(3)

     D INDS1           DS                  qualified
     D  I1                           10i 0
     D  C2                           10a           
     D  P1                           12p 2      
     D  Z2                           12s 2            
     D   D2                                likeds(INDS2) dim(2)
     D   D4                                likeds(INDS4) dim(4)
     D   D5                                likeds(INDS5)
     D   D6                                likeds(INDS6)
     D  R2                            8F            
     D  R3                            4F            
     D  C3                           60a           
     D  Z3                           12s 3            
     D  Z4                           12s 4            

     D i               s             10i 0 inz(0)
     D j               s             10i 0 inz(0)
     D k               s             10i 0 inz(0)
     D l               s             10i 0 inz(0)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     C     *Entry        PLIST                   
     C                   PARM                    INDS1
      /free
        INDS1.I1 = -1;
        INDS1.C2 = %char(-1);
        INDS1.P1 = 1*(-1.1);
        INDS1.Z2 = 1*(-1.11);
        INDS1.R2 = 1*(-1.1155);
        INDS1.R3 = 1*(-1.1155);
        INDS1.C3 = 'Oh my, this is complex';
        INDS1.Z3 = 1*(-1.1156);
        INDS1.Z4 = 1*(-1.1156);
        for k = 1 to 4;
          INDS1.D4(k).I1 = -1*1000+2*100+k;
          INDS1.D4(k).C2 = %char(-1*1000+2*100+k);
          INDS1.D4(k).P1 = (-1*1000+2*100+k)*4.4;
          INDS1.D4(k).Z2 = (-1*1000+2*100+k)*4.44;
        for l = 1 to 5;
          INDS1.D4(k).D5(l).I1 = -1*10000+2*1000+k*100+l;
          INDS1.D4(k).D5(l).C2 = %char(-1*10000+2*1000+k*100+l);
          INDS1.D4(k).D5(l).P1 = (-1*10000+2*1000+k*100+l)*5.5;
          INDS1.D4(k).D5(l).Z2 = (-1*10000+2*1000+k*100+l)*5.55;
          INDS1.D4(k).D5(l).R2 = (-1*10000+2*1000+k*100+l)*5.55;
          INDS1.D4(k).D5(l).R3 = (-1*10000+2*1000+k*100+l)*5.55;
        endfor;
        endfor;
        INDS1.D5.I1 = 1*10000+2*1000+3*100+4;
        INDS1.D5.C2 = %char(1*10000+2*1000+3*100+4);
        INDS1.D5.P1 = (1*10000+2*1000+3*100+4)*5.5;
        INDS1.D5.Z2 = (1*10000+2*1000+3*100+4)*5.55;
        INDS1.D5.R2 = (1*10000+2*1000+3*100+4)*5.55;
        INDS1.D5.R3 = (1*10000+2*1000+3*100+4)*5.55;
        INDS1.D6.I1 = 1*10000+2*1000+3*100+4;
        INDS1.D6.C2 = %char(1*10000+2*1000+3*100+4);
        INDS1.D6.P1 = (1*10000+2*1000+3*100+4)*5.5;
        INDS1.D6.Z2 = (1*10000+2*1000+3*100+4)*5.55;
        INDS1.D6.R2 = (1*10000+2*1000+3*100+4)*5.55;
        INDS1.D6.R3 = (1*10000+2*1000+3*100+4)*5.55;
        for i = 1 to 2;
          INDS1.D2(i).I1 = i;
          INDS1.D2(i).C2 = %char(i);
          INDS1.D2(i).P1 = i*2.2;
          INDS1.D2(i).Z2 = i*2.22;
        for j = 1 to 3;
          INDS1.D2(i).D3(j).I1 = i*100+j;
          INDS1.D2(i).D3(j).C2 = %char(i*100+j);
          INDS1.D2(i).D3(j).P1 = (i*100+j)*3.3;
          INDS1.D2(i).D3(j).Z2 = (i*100+j)*3.33;
        for k = 1 to 4;
          INDS1.D2(i).D3(j).D4(k).I1 = i*1000+j*100+k;
          INDS1.D2(i).D3(j).D4(k).C2 = %char(i*1000+j*100+k);
          INDS1.D2(i).D3(j).D4(k).P1 = (i*1000+j*100+k)*4.4;
          INDS1.D2(i).D3(j).D4(k).Z2 = (i*1000+j*100+k)*4.44;
        for l = 1 to 5;
          INDS1.D2(i).D3(j).D4(k).D5(l).I1 = i*10000+j*1000+k*100+l;
          INDS1.D2(i).D3(j).D4(k).D5(l).C2 = %char(i*10000+j*1000+k*100+l);
          INDS1.D2(i).D3(j).D4(k).D5(l).P1 = (i*10000+j*1000+k*100+l)*5.5;
          INDS1.D2(i).D3(j).D4(k).D5(l).Z2 = (i*10000+j*1000+k*100+l)*5.55;
          INDS1.D2(i).D3(j).D4(k).D5(l).R2 = (i*10000+j*1000+k*100+l)*5.55;
          INDS1.D2(i).D3(j).D4(k).D5(l).R3 = (i*10000+j*1000+k*100+l)*5.55;
        endfor;
        endfor;
        endfor;
        endfor;
        return;
        // *inlr = *on;
      /end-free

