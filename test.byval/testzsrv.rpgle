     H NOMAIN          
     H AlwNull(*UsrCtl)          

      /copy test_h         

       // **************************************************** 
       // try one by value return int32
       // ****************************************************
       dcl-proc testVal1 export;
       dcl-pi  *N int(10);
         argc int(10) value;
       end-pi;
         argc = 1;
         return argc;
       end-proc;

       // **************************************************** 
       // try two by value return int64
       // ****************************************************
       dcl-proc testVal2 export;
       dcl-pi  *N int(20);
         arg1 int(10) value;
         arg2 int(20) value;
       end-pi;
         arg1 = 1;
         arg2 = 2;
         return arg1 + arg2;
       end-proc;

       // **************************************************** 
       // try 4 by value return char(16) fit in two regs
       // ****************************************************
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

       // **************************************************** 
       // try 4 pass by ref return int64
       // ****************************************************
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


       // **************************************************** 
       // try 4 return char(16) fit in two regs
       // ****************************************************
       dcl-proc testVal6 export;
       dcl-pi  *N char(16);
       end-pi;
         return 'I am sailor';
       end-proc;

       // **************************************************** 
       // try exception
       // ****************************************************
       dcl-proc testBoom export;
       dcl-pi  *N int(20);
       end-pi;
         dcl-s bigptr pointer inz(*NULL);
         dcl-s bigint int(20) based(bigptr);
         bigint = 9; // boom
         return bigint;
       end-proc;

       // **************************************************** 
       // try mix by value and by ref
       // ****************************************************
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

       // **************************************************** 
       // try mix by value and by ref exotic types
       // ****************************************************
       dcl-proc GetMixed export;
       dcl-pi  *N;
         pp packed(12:2) Value;
         ppd char(30);
         zz zoned(12:2) Value;
         zzd char(30);
         i1 int(3) value;
         i1d char(30);
         i2 int(5) value;
         i2d char(30);
         i4 int(10) value;
         i4d char(30);
         i8 int(20) value;
         i8d char(30);
         f4 float(4) value;
         f4d char(30);
         f8 float(8) value;
         f8d char(30);
       end-pi;
         pp += 2.22;
         ppd = 'pack man';
         zz += 2.22;
         zzd = 'zone man';
         i1 += 2;
         i1d = 'byte man';
         i2 += 2;
         i2d = 'short man';
         i4 += 2;
         i4d = 'integer man';
         i8 += 2;
         i8d = 'longlong man';
         f4 += 2.22;
         f4d = 'float man';
         f8 += 2.22;
         f8d = 'double man';
       end-proc;


       // **************************************************** 
       // try mix by value and by ref exotic types
       // ****************************************************
       dcl-proc GetReMixed export;
       dcl-pi  *N;
         i2d char(30);
         pp packed(12:2) Value;
         zz zoned(12:2) Value;
         ppd char(30);
         zzd char(30);
         i1 int(3) value;
         i1d char(30);
         i4 int(10) value;
         i8 int(20) value;
         f4 float(4) value;
         f4d char(30);
         f8 float(8) value;
         i4d char(30);
         i8d char(30);
         f8d char(30);
         i2 int(5) value;
       end-pi;
         pp += 2.22;
         ppd = 'pack man';
         zz += 2.22;
         zzd = 'zone man';
         i1 += 2;
         i1d = 'byte man';
         i2 += 2;
         i2d = 'short man';
         i4 += 2;
         i4d = 'integer man';
         i8 += 2;
         i8d = 'longlong man';
         f4 += 2.22;
         f4d = 'float man';
         f8 += 2.22;
         f8d = 'double man';
       end-proc;


       // **************************************************** 
       // try mix by value and by ref exotic types
       // ****************************************************
       dcl-proc GetPacked export;
       dcl-pi  *N;
         i2d char(8) Value;
         p1 packed(4:2) Value;
         p2 packed(3:2) Value;
         p3 packed(12:2) Value;
         p4 packed(6:2) Value;
         p5 packed(8:2) Value;
         p6 packed(24:4) Value;
         p7 packed(48:8) Value;
         ppd char(15) Value;
         zzd char(30);
         i2 int(5) value;
         i1d char(30);
         i4 int(10) value;
         i8 int(20) value;
         f4 float(4) value;
         f4d char(30);
         f8 float(8) value;
         i4d char(30);
         i8d char(30);
         f8d char(30);
         i1 int(3) value;
       end-pi;
         p1 += 2.22;
         p2 += 2.22;
         p3 += 2.22;
         p4 += 2.22;
         p5 += 2.22;
         p6 += 2.22;
         p7 += 2.22;
         ppd = 'pack man';
         zzd = 'zone man';
         i1 += 2;
         i1d = 'byte man';
         i2 += 2;
         i2d = 'short man';
         i4 += 2;
         i4d = 'integer man';
         i8 += 2;
         i8d = 'longlong man';
         f4 += 2.22;
         f4d = 'float man';
         f8 += 2.22;
         f8d = 'double man';
       end-proc;


       // **************************************************** 
       // try mix by value and by ref exotic types
       // ****************************************************
       dcl-proc GetZoned_Not_Work_MMM export;
       dcl-pi  *N;
         i2d char(30);
         z1 zoned(4:2) Value;
         z2 zoned(3:2) Value;
         z3 zoned(12:2) Value;
         z4 zoned(6:2) Value;
         z5 zoned(8:2) Value;
         z6 zoned(24:4) Value;
         z7 zoned(48:8) Value;
         ppd char(30);
         zzd char(30);
         i2 int(5) value;
         i1d char(30);
         i4 int(10) value;
         i8 int(20) value;
         f4 float(4) value;
         f4d char(30);
         f8 float(8) value;
         i4d char(30);
         i8d char(30);
         f8d char(30);
         i1 int(3) value;
       end-pi;
         z1 += 2.22;
         z2 += 2.22;
         z3 += 2.22;
         z4 += 2.22;
         z5 += 2.22;
         z6 += 2.22;
         z7 += 2.22;
         ppd = 'pack man';
         zzd = 'zone man';
         i1 += 2;
         i1d = 'byte man';
         i2 += 2;
         i2d = 'short man';
         i4 += 2;
         i4d = 'integer man';
         i8 += 2;
         i8d = 'longlong man';
         f4 += 2.22;
         f4d = 'float man';
         f8 += 2.22;
         f8d = 'double man';
       end-proc;


       // **************************************************** 
       // try mix by value and by ref exotic types
       // ****************************************************
       dcl-proc GetChared export;
       dcl-pi  *N;
         c1 char(8) value;
         c2 char(3) value;
         c3 char(3) value;
         c4 char(30) value;
         c5 char(30);
         c6 char(1) value;
         c7 char(3) value;
         c8 char(8) value;
         c9 char(80);
       end-pi;
         c1 = 'i am 8';
         c2 = 'mex';
         c3 = 'mey';
         c4 = 'i am 30 val';
         c5 = 'i am 30 ref';
         c6 = '1';
         c7 = 'mez';
         c8 = 'i 8 too';
         c9 = 'i am 80';
       end-proc;

