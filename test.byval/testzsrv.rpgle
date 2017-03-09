     H NOMAIN          
     H AlwNull(*UsrCtl)          

      /copy test_h         

       // ****************************************************          
       // prototype          
       // ****************************************************          

       dcl-pr testVal1 int(10);
         argc int(10) value;
       end-pr;

       dcl-pr testVal2 int(20);
         arg1 int(10) value;
         arg2 int(20) value;
       end-pr;

       dcl-pr testVal4 char(16);
         arg1 int(3) value;
         arg2 int(5) value;
         arg3 int(10) value;
         arg4 int(20) value;
       end-pr;

       dcl-pr testVal5 int(20);
         arg1 int(3);
         arg2 int(5);
         arg3 int(10);
         arg4 int(20);
       end-pr;

       dcl-pr testVal6 char(16);
       end-pr;

       // ****************************************************          
       // implementation          
       // ****************************************************          

       dcl-proc testVal1 export;
       dcl-pi  *N int(10);
         argc int(10) value;
       end-pi;
         argc = 1;
         return argc;
       end-proc;

       dcl-proc testVal2 export;
       dcl-pi  *N int(20);
         arg1 int(10) value;
         arg2 int(20) value;
       end-pi;
         arg1 = 1;
         arg2 = 2;
         return arg1 + arg2;
       end-proc;

       dcl-proc testVal4 export;
       dcl-pi  *N char(16);
         arg1 int(3) value;
         arg2 int(5) value;
         arg3 int(10) value;
         arg4 int(20) value;
       end-pi;
         dcl-s prcPtr pointer(*proc);
         dcl-ds anyInty_t qualified based(Template);
           anypart char(16);
         end-ds;
         dcl-pr iIleSrv16 likeds(anyInty_t) extproc(prcPtr);
         end-pr;
         dcl-ds retv likeds(anyInty_t);
         arg1 = 1;
         arg2 = 2;
         arg3 = 3;
         arg4 = 4;
         prcPtr = %paddr(testVal6);
         retv = iIleSrv16();
         return retv.anypart;
       end-proc;

       dcl-proc testVal5 export;
       dcl-pi  *N int(20);
         arg1 int(3);
         arg2 int(5);
         arg3 int(10);
         arg4 int(20);
       end-pi;
         arg1 = 1;
         arg2 = 2;
         arg3 = 3;
         arg4 = 4;
         return arg1 + arg2 + arg3 + arg4;
       end-proc;


       dcl-proc testVal6 export;
       dcl-pi  *N char(16);
       end-pi;
         return 'I am sailor';
       end-proc;


       dcl-proc testBoom export;
       dcl-pi  *N int(20);
       end-pi;
         dcl-s bigptr pointer inz(*NULL);
         dcl-s bigint int(20) based(bigptr);
         bigint = 9; // boom
         return bigint;
       end-proc;

       dcl-proc GetSmart export;
       dcl-pi  *N;
         p0Format char(10) Value;
         p0Type char(1) Value;
         p0Value char(15) Value;
         p0Channel char(5);
         p0ChannelDesc char(50);
         p0MPG char(5);
         p0MPGDesc char(50);
         p0Class char(5);
         p0ClassDesc char(50);
         p0Line char(5);
         p0LineDesc char(50);
         p0Part char(15);
         p0PartDesc char(30);
       end-pi;
         p0Format = 'i be fmt';
         p0Type = '9';
         p0Value = 'i be value';
         p0Channel = 'ch1';
         p0ChannelDesc = 'Great SyFy';
         p0MPG = '4mpg';
         p0MPGDesc = 'i dunno mpg';
         p0Class = 'low';
         p0ClassDesc = 'ye haw';
         p0Line = 'lin5';
         p0LineDesc = 'line man county';
         p0Part = 'part1';
         p0PartDesc = 'hairy frog';
       end-proc;

