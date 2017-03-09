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
       + 'CHGLIBL LIBL(XMLSERVICE)'
       + '</cmd>'
       + '<pgm error="fast" func="GETSMART" name="TESTZSRV" var="getsmart">'
       + '<parm io="both" var="p1">'
       + '<data by="val" type="10a" var="p0Format"/></parm>'
       + '<parm io="both" var="p2">'
       + '<data by="val" type="1a" var="p0Type"/></parm>'
       + '<parm io="both" var="p3">'
       + '<data by="val" type="15a" var="p0Value"/></parm>'
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

