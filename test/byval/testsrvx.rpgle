     H AlwNull(*UsrCtl)

      /copy test_h         

       // ****************************************************          
       // xmlservice/xmlstoredp SRVPGM
       // ****************************************************          
       dcl-pr runClient ind;
         pIPCSP char(1024);
         pCtl char(1024);
         pIClob pointer;
         szIClob int(10);
         pOClob pointer;
         szOClob int(10);
       end-pr;


       // ****************************************************          
       // TESTPGM 
       // ****************************************************          
       dcl-pr Main extpgm;
       end-pr;

       // ****************************************************          
       // main(): Control flow
       // ****************************************************          
       dcl-pi Main;
       end-pi;

       // ****************************************************          
       // tests
       // ****************************************************          
       dcl-s i int(10) inz(0);

       // testboom();
       testval1();
       testval2();
       testval4();
       testval5();
       testval6();
       getsmart();
       getmixed();
       getremixed();
       getpacked();
       // getzoned();
       getchared();

       return;

       // ****************************************************          
       // interface to old xmlservice
       // ****************************************************          
       dcl-proc xjRun;
       dcl-pi *N;
         xjIn pointer value;
         xjOut pointer value;
         xjInSz int(10) value;
         xjOutSz int(10) value;
       end-pi;

       dcl-s ipc char(1024) inz(*BLANKS);
       dcl-s ctl char(1024) inz(*BLANKS);

       ipc = '*na';
       ctl = '*here';

       runClient(ipc:ctl:xjIn:xjInSz:xjOut:xjOutSz);

       end-proc;

       // ****************************************************          
       // test: TESTZSRV.TESTBOOM
       // ****************************************************          
       dcl-proc testboom;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<myscript>'
       + '<pgm name="TESTZSRV" lib="'+TEST_LIB+'" func="TESTBOOM">'
       + ' <return>'
       + '   <data type="10i0">3</data>'
       + ' </return>'
       + '</pgm>'
       + '</myscript>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;

       // ****************************************************          
       // test: TESTZSRV.TESTVAL1
       // ****************************************************          
       dcl-proc testval1;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<myscript>'
       + '<pgm name="TESTZSRV" lib="'+TEST_LIB+'" func="TESTVAL1">'
       + ' <parm  io="both" by="val">'
       + '   <data type="10i0">3</data>'
       + ' </parm>'
       + ' <return>'
       + '   <data type="10i0">3</data>'
       + ' </return>'
       + '</pgm>'
       + '</myscript>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;

       // ****************************************************          
       // test: TESTZSRV.TESTVAL2
       // ****************************************************          
       dcl-proc testval2;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<myscript>'
       + '<pgm name="TESTZSRV" lib="'+TEST_LIB+'" func="TESTVAL2">'
       + ' <parm  io="both" by="val">'
       + '   <data type="10i0">3</data>'
       + ' </parm>'
       + ' <parm  io="both" by="val">'
       + '   <data type="20i0">4</data>'
       + ' </parm>'
       + ' <return>'
       + '   <data type="20i0">3</data>'
       + ' </return>'
       + '</pgm>'
       + '</myscript>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;


       // ****************************************************          
       // test: TESTZSRV.TESTVAL4
       // ****************************************************          
       dcl-proc testval4;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<myscript>'
       + '<pgm name="TESTZSRV" lib="'+TEST_LIB+'" func="TESTVAL4">'
       + ' <parm  io="both" by="val">'
       + '   <data type="3i0">4</data>'
       + ' </parm>'
       + ' <parm  io="both" by="val">'
       + '   <data type="5i0">5</data>'
       + ' </parm>'
       + ' <parm  io="both" by="val">'
       + '   <data type="10i0">6</data>'
       + ' </parm>'
       + ' <parm  io="both" by="val">'
       + '   <data type="20i0">7</data>'
       + ' </parm>'
       + ' <return>'
       + '   <data type="16a">olive</data>'
       + ' </return>'
       + '</pgm>'
       + '</myscript>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;


       // ****************************************************          
       // test: TESTZSRV.TESTVAL5
       // ****************************************************          
       dcl-proc testval5;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<myscript>'
       + '<pgm name="TESTZSRV" lib="'+TEST_LIB+'" func="TESTVAL5">'
       + ' <parm  io="both">'
       + '   <data type="3i0">4</data>'
       + ' </parm>'
       + ' <parm  io="both">'
       + '   <data type="5i0">5</data>'
       + ' </parm>'
       + ' <parm  io="both">'
       + '   <data type="10i0">6</data>'
       + ' </parm>'
       + ' <parm  io="both">'
       + '   <data type="20i0">7</data>'
       + ' </parm>'
       + ' <return>'
       + '   <data type="20i0">3</data>'
       + ' </return>'
       + '</pgm>'
       + '</myscript>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;


       // ****************************************************          
       // test: TESTZSRV.TESTVAL6
       // ****************************************************          
       dcl-proc testval6;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<myscript>'
       + '<pgm name="TESTZSRV" lib="'+TEST_LIB+'" func="TESTVAL6">'
       + ' <return>'
       + '   <data type="16a">frog</data>'
       + ' </return>'
       + '</pgm>'
       + '</myscript>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;


       // ****************************************************          
       // test: TESTZSRV.GETSMART
       // dcl-proc GetSmart export;
       // dcl-pi  *N;
       //   p0Format char(10) Value;
       //   p0Type char(1) Value;
       //   p0Value char(15) Value;
       //   p0Channel char(5);
       //   p0ChannelDesc char(50);
       //   p0MPG char(5);
       //   p0MPGDesc char(50);
       //   p0Class char(5);
       //   p0ClassDesc char(50);
       //   p0Line char(5);
       //   p0LineDesc char(50);
       //   p0Part char(15);
       //   p0PartDesc char(30);
       // end-pi;
       // ****************************************************          
       dcl-proc getsmart;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<xmlservice>'
       + '<cmd error="fast" exec="cmd" var="chglibl">'
       + 'CHGLIBL LIBL('+TEST_LIB+')'
       + '</cmd>'
       + '<pgm error="fast" func="GETSMART" name="TESTZSRV" var="getsmart">'
       + '<parm io="both" by="val" var="p1">'
       + '<data type="10a" var="p0Format"/></parm>'
       + '<parm io="both" by="val" var="p2">'
       + '<data type="1a" var="p0Type"/></parm>'
       + '<parm io="both" by="val" var="p3">'
       + '<data type="15a" var="p0Value"/></parm>'
       + '<parm io="both" var="p4">'
       + '<data type="5a" var="p0Channel"/></parm>'
       + '<parm io="both" var="p5">'
       + '<data type="50a" var="p0ChannelDesc"/></parm>'
       + '<parm io="both" var="p6">'
       + '<data type="5a" var="p0MPG"/></parm>'
       + '<parm io="both" var="p7">'
       + '<data type="50a" var="p0MPGDesc"/></parm>'
       + '<parm io="both" var="p8">'
       + '<data type="5a" var="p0Class"/></parm>'
       + '<parm io="both" var="p9">'
       + '<data type="50a" var="p0ClassDesc"/></parm>'
       + '<parm io="both" var="p10">'
       + '<data type="5a" var="p0Line"/></parm>'
       + '<parm io="both" var="p11">'
       + '<data type="50a" var="p0LineDesc"/></parm>'
       + '<parm io="both" var="p12">'
       + '<data type="15a" var="p0Part"/></parm>'
       + '<parm io="both" var="p13">'
       + '<data type="30a" var="p0PartDesc"/></parm>'
       + '</pgm>'
       + '</xmlservice>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;


       // ****************************************************          
       // test: TESTZSRV.GETMIXED
       // dcl-proc GetMixed export;
       // dcl-pi  *N;
       //   pp packed(12:2) Value;
       //   ppd char(30);
       //   zz zoned(12:2) Value;
       //   zzd char(30);
       //   i1 int(3) value;
       //   i1d char(30);
       //   i2 int(5) value;
       //   i2d char(30);
       //   i4 int(10) value;
       //   i4d char(30);
       //   i8 int(20) value;
       //   i8d char(30);
       //   f4 float(4) value;
       //   f4d char(30);
       //   f8 float(8) value;
       //   f8d char(30);
       // end-pi;
       // ****************************************************          
       dcl-proc getmixed;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<xmlservice>'
       + '<cmd error="fast" exec="cmd" var="chglibl">'
       + 'CHGLIBL LIBL('+TEST_LIB+')'
       + '</cmd>'
       + '<pgm error="fast" func="GETMIXED" name="TESTZSRV" var="mixed0">'

       + '<parm io="both" by="val" var="p1">'
       + '<data type="12p2" var="pp">1</data></parm>'
       + '<parm io="both" var="p2">'
       + '<data type="30a" var="ppd">1</data></parm>'

       + '<parm io="both" by="val" var="p3">'
       + '<data type="12s2" var="zz">1</data></parm>'
       + '<parm io="both" var="p4">'
       + '<data type="30a" var="zzd">1</data></parm>'

       + '<parm io="both" by="val" var="p5">'
       + '<data type="3i0" var="i1">1</data></parm>'
       + '<parm io="both" var="p6">'
       + '<data type="30a" var="i1d">1</data></parm>'

       + '<parm io="both" by="val" var="p7">'
       + '<data type="5i0" var="i2">1</data></parm>'
       + '<parm io="both" var="p8">'
       + '<data type="30a" var="i2d">1</data></parm>'

       + '<parm io="both" by="val" var="p9">'
       + '<data type="10i0" var="i4">1</data></parm>'
       + '<parm io="both" var="p10">'
       + '<data type="30a" var="i4d">1</data></parm>'

       + '<parm io="both" by="val" var="p11">'
       + '<data type="20i0" var="i8">1</data></parm>'
       + '<parm io="both" var="p12">'
       + '<data type="30a" var="i8d">1</data></parm>'

       + '<parm io="both" by="val" var="p13">'
       + '<data type="4f" var="f4">1</data></parm>'
       + '<parm io="both" var="p14">'
       + '<data type="30a" var="f4d">1</data></parm>'

       + '<parm io="both" by="val" var="p15">'
       + '<data type="8f" var="f8">1</data></parm>'
       + '<parm io="both" var="p16">'
       + '<data type="30a" var="f8d">1</data></parm>'

       + '</pgm>'
       + '</xmlservice>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;


       // ****************************************************          
       // test: TESTZSRV.GETREMIXED
       // dcl-pi  *N;
       //   i2d char(30);
       //   pp packed(12:2) Value;
       //   zz zoned(12:2) Value;
       //   ppd char(30);
       //   zzd char(30);
       //   i1 int(3) value;
       //   i1d char(30);
       //   i4 int(10) value;
       //   i8 int(20) value;
       //   f4 float(4) value;
       //   f4d char(30);
       //   f8 float(8) value;
       //   i4d char(30);
       //   i8d char(30);
       //   f8d char(30);
       //   i2 int(5) value;
       // end-pi;
       // ****************************************************          
       dcl-proc getremixed;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<xmlservice>'
       + '<cmd error="fast" exec="cmd" var="chglibl">'
       + 'CHGLIBL LIBL('+TEST_LIB+')'
       + '</cmd>'
       + '<pgm error="fast" func="GETREMIXED" name="TESTZSRV" var="mixed1">'

       + '<parm io="both" var="p8">'
       + '<data type="30a" var="i2d">1</data></parm>'

       + '<parm io="both" by="val" var="p1">'
       + '<data type="12p2" var="pp">1</data></parm>'

       + '<parm io="both" by="val" var="p3">'
       + '<data type="12s2" var="zz">1</data></parm>'

       + '<parm io="both" var="p2">'
       + '<data type="30a" var="ppd">1</data></parm>'

       + '<parm io="both" var="p4">'
       + '<data type="30a" var="zzd">1</data></parm>'

       + '<parm io="both" by="val" var="p5">'
       + '<data type="3i0" var="i1">1</data></parm>'

       + '<parm io="both" var="p6">'
       + '<data type="30a" var="i1d">1</data></parm>'

       + '<parm io="both" by="val" var="p9">'
       + '<data type="10i0" var="i4">1</data></parm>'

       + '<parm io="both" by="val" var="p11">'
       + '<data type="20i0" var="i8">1</data></parm>'

       + '<parm io="both" by="val" var="p13">'
       + '<data type="4f" var="f4">1</data></parm>'

       + '<parm io="both" var="p14">'
       + '<data type="30a" var="f4d">1</data></parm>'

       + '<parm io="both" by="val" var="p15">'
       + '<data type="8f" var="f8">1</data></parm>'

       + '<parm io="both" var="p10">'
       + '<data type="30a" var="i4d">1</data></parm>'

       + '<parm io="both" var="p12">'
       + '<data type="30a" var="i8d">1</data></parm>'

       + '<parm io="both" var="p16">'
       + '<data type="30a" var="f8d">1</data></parm>'

       + '<parm io="both" by="val" var="p7">'
       + '<data type="5i0" var="i2">1</data></parm>'

       + '</pgm>'
       + '</xmlservice>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;


       // ****************************************************          
       // test: TESTZSRV.GETPACKED
       // dcl-pi  *N;
       // i2d char(30);
       // p1 packed(4:2) Value;
       // p2 packed(3:2) Value;
       // p3 packed(12:2) Value;
       // p4 packed(6:2) Value;
       // p5 packed(8:2) Value;
       // p6 packed(24:4) Value;
       // p7 packed(48:8) Value;
       // ppd char(30);
       // zzd char(30);
       // i2 int(5) value;
       // i1d char(30);
       // i4 int(10) value;
       // i8 int(20) value;
       // f4 float(4) value;
       // f4d char(30);
       // f8 float(8) value;
       // i4d char(30);
       // i8d char(30);
       // f8d char(30);
       // i1 int(3) value;
       // end-pi;
       // ****************************************************          
       dcl-proc getpacked;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<xmlservice>'
       + '<cmd error="fast" exec="cmd" var="chglibl">'
       + 'CHGLIBL LIBL('+TEST_LIB+')'
       + '</cmd>'
       + '<pgm error="fast" func="GETPACKED" name="TESTZSRV" var="packme">'

       + '<parm io="both" by="val" var="p8">'
       + '<data type="8a" var="i2d">1</data></parm>'

       + '<parm io="both" by="val" var="pp1">'
       + '<data type="4p2" var="pp">1</data></parm>'

       + '<parm io="both" by="val" var="pp2">'
       + '<data type="3p2" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="pp3">'
       + '<data type="12p2" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="pp4">'
       + '<data type="6p2" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="pp5">'
       + '<data type="8p2" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="pp6">'
       + '<data type="24p4" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="pp7">'
       + '<data type="48p8" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="p2">'
       + '<data type="15a" var="ppd">1</data></parm>'

       + '<parm io="both" var="p4">'
       + '<data type="30a" var="zzd">1</data></parm>'

       + '<parm io="both" by="val" var="p7">'
       + '<data type="5i0" var="i2">1</data></parm>'

       + '<parm io="both" var="p6">'
       + '<data type="30a" var="i1d">1</data></parm>'

       + '<parm io="both" by="val" var="p9">'
       + '<data type="10i0" var="i4">1</data></parm>'

       + '<parm io="both" by="val" var="p11">'
       + '<data type="20i0" var="i8">1</data></parm>'

       + '<parm io="both" by="val" var="p13">'
       + '<data type="4f" var="f4">1</data></parm>'

       + '<parm io="both" var="p14">'
       + '<data type="30a" var="f4d">1</data></parm>'

       + '<parm io="both" by="val" var="p15">'
       + '<data type="8f" var="f8">1</data></parm>'

       + '<parm io="both" var="p10">'
       + '<data type="30a" var="i4d">1</data></parm>'

       + '<parm io="both" var="p12">'
       + '<data type="30a" var="i8d">1</data></parm>'

       + '<parm io="both" var="p16">'
       + '<data type="30a" var="f8d">1</data></parm>'

       + '<parm io="both" by="val" var="p5">'
       + '<data type="3i0" var="i1">1</data></parm>'

       + '</pgm>'
       + '</xmlservice>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;


       // ****************************************************          
       // test: TESTZSRV.ZONED
       // dcl-pi  *N;
       // i2d char(30);
       // z1 zoned(4:2) Value;
       // z2 zoned(3:2) Value;
       // z3 zoned(12:2) Value;
       // z4 zoned(6:2) Value;
       // z5 zoned(8:2) Value;
       // z6 zoned(24:4) Value;
       // z7 zoned(48:8) Value;
       // ppd char(30);
       // zzd char(30);
       // i2 int(5) value;
       // i1d char(30);
       // i4 int(10) value;
       // i8 int(20) value;
       // f4 float(4) value;
       // f4d char(30);
       // f8 float(8) value;
       // i4d char(30);
       // i8d char(30);
       // f8d char(30);
       // i1 int(3) value;
       // end-pi;
       // ****************************************************          
       dcl-proc getzoned_Not_Work_MMM;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<xmlservice>'
       + '<cmd error="fast" exec="cmd" var="chglibl">'
       + 'CHGLIBL LIBL('+TEST_LIB+')'
       + '</cmd>'
       + '<pgm error="fast" func="GETZONED" name="TESTZSRV" var="zoneme">'

       + '<parm io="both" var="p8">'
       + '<data type="30a" var="i2d">1</data></parm>'

       + '<parm io="both" by="val" var="zz1">'
       + '<data type="4s2" var="pp">11.11</data></parm>'

       + '<parm io="both" by="val" var="zz2">'
       + '<data type="3s2" var="zz">2.22</data></parm>'

       + '<parm io="both" by="val" var="zz3">'
       + '<data type="12s2" var="zz">3333333333.33</data></parm>'

       + '<parm io="both" by="val" var="zz4">'
       + '<data type="6s2" var="zz">4444.44</data></parm>'

       + '<parm io="both" by="val" var="zz5">'
       + '<data type="8s2" var="zz">555555.55</data></parm>'

       + '<parm io="both" by="val" var="zz6">'
       + '<data type="24s4" var="zz">6666666666.66</data></parm>'

       + '<parm io="both" by="val" var="zz7">'
       + '<data type="48s8" var="zz">7777777777.77777777</data></parm>'

       + '<parm io="both" var="p2">'
       + '<data type="30a" var="ppd">1</data></parm>'

       + '<parm io="both" var="p4">'
       + '<data type="30a" var="zzd">1</data></parm>'

       + '<parm io="both" by="val" var="p7">'
       + '<data type="5i0" var="i2">1</data></parm>'

       + '<parm io="both" var="p6">'
       + '<data type="30a" var="i1d">1</data></parm>'

       + '<parm io="both" by="val" var="p9">'
       + '<data type="10i0" var="i4">1</data></parm>'

       + '<parm io="both" by="val" var="p11">'
       + '<data type="20i0" var="i8">1</data></parm>'

       + '<parm io="both" by="val" var="p13">'
       + '<data type="4f" var="f4">1</data></parm>'

       + '<parm io="both" var="p14">'
       + '<data type="30a" var="f4d">1</data></parm>'

       + '<parm io="both" by="val" var="p15">'
       + '<data type="8f" var="f8">1</data></parm>'

       + '<parm io="both" var="p10">'
       + '<data type="30a" var="i4d">1</data></parm>'

       + '<parm io="both" var="p12">'
       + '<data type="30a" var="i8d">1</data></parm>'

       + '<parm io="both" var="p16">'
       + '<data type="30a" var="f8d">1</data></parm>'

       + '<parm io="both" by="val" var="p5">'
       + '<data type="3i0" var="i1">1</data></parm>'

       + '</pgm>'
       + '</xmlservice>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;


       // ****************************************************          
       // test: TESTZSRV.GETCHARED
       // dcl-pi  *N;
       //   c1 char(8) value;
       //   c2 char(3) value;
       //   c3 char(3) value;
       //   c4 char(30) value;
       //   c5 char(30);
       //   c6 char(1) value;
       //   c7 char(3) value;
       //   c8 char(8) value;
       //   c9 char(80);
       // end-pi;
       // ****************************************************          
       dcl-proc getchared;
       dcl-pi *N;
       end-pi;
       dcl-s xjInData char(4096) inz(*BLANKS);
       dcl-s xjOutData char(4096) inz(*BLANKS);
       dcl-s xjIn pointer inz(%addr(xjInData));
       dcl-s xjOut pointer inz(%addr(xjOutData));

       xjInData = 
         '<?xml version="1.0"?>'
       + '<xmlservice>'
       + '<cmd error="fast" exec="cmd" var="chglibl">'
       + 'CHGLIBL LIBL('+TEST_LIB+')'
       + '</cmd>'
       + '<pgm error="fast" func="GETCHARED" name="TESTZSRV" var="charme">'

       + '<parm io="both" by="val" var="c1">'
       + '<data type="8a" var="c1">1</data></parm>'

       + '<parm io="both" by="val" var="c2">'
       + '<data type="3a" var="c2">1</data></parm>'

       + '<parm io="both" by="val" var="c3">'
       + '<data type="3a" var="c3">1</data></parm>'

       + '<parm io="both" by="val" var="c4">'
       + '<data type="30a" var="c4">1</data></parm>'

       + '<parm io="both" var="c5">'
       + '<data type="30a" var="c5">1</data></parm>'

       + '<parm io="both" by="val" var="c6">'
       + '<data type="1a" var="c6">1</data></parm>'

       + '<parm io="both" by="val" var="c7">'
       + '<data type="3a" var="c7">1</data></parm>'

       + '<parm io="both" by="val" var="c8">'
       + '<data type="8a" var="c8">1</data></parm>'

       + '<parm io="both" var="c9">'
       + '<data type="80a" var="c9">1</data></parm>'

       + '</pgm>'
       + '</xmlservice>'
       + x'00';

       xjRun(xjIn:xjOut:4096:4096);

       end-proc;

