     H NOMAIN
     H AlwNull(*UsrCtl)

      *****************************************************
      * includes
      *****************************************************
     D Step            s             10i 0 inz(0)
     D zzstep          PR            10i 0

     D ARRAYMAX        c                   const(999)

     D dcRec_t         ds                  qualified based(Template)
     D  dcMyName                     10A
     D  dcMyJob                    4096A
     D  dcMyRank                     10i 0
     D  dcMyPay                      12p 2

     D zzarray         PR                  likeds(dcRec_t) dim(ARRAYMAX)
     D  myName                       10A
     D  myMax                        10i 0
     D  myCount                      10i 0

     D zzarray2        PR
     D  myName                       10A
     D  myMax                        10i 0
     D  myCount                      10i 0
     D  findMe                             likeds(dcRec_t) dim(ARRAYMAX)

     D zzarrbad        PR
     D  myName                       10A
     D  myMax                        10i 0
     D  myCount                      10i 0
     D  findMe                             likeds(dcRec_t) dim(ARRAYMAX)

     D zzbig           PR            10I 0
     D  myNam1                    32000A
     D  myNam2                    32000A
     D  myNam3                    32000A
     D  myNam4                    32000A
     D  myNam5                    32000A
     D  myNam6                    32000A
     D  myNam7                    32000A
     D  myNam8                    32000A
     D  myNam9                    32000A

     D zzvary          PR            20A   varying
     D  myName                       10A   varying

     D zzbinary        PR            20A
     D  myBinary                     20A

     D zz200           PR
     D  my200                       200A

     D zzpdf           PR            10i 0
     D  myPDF                     65000A

     D zznada          PR

     D zzdate          PR              D
     D  myDate                         D   datfmt(*iso)

     D zzdateUSA       PR              D   datfmt(*USA)
     D  myDate                         D   datfmt(*USA)

     D zztime          PR              T
     D  myTime                         T   timfmt(*iso)

     D zztimeUSA       PR              T   timfmt(*USA)
     D  myTime                         T   timfmt(*USA)

     D zzstamp         PR              Z
     D  mystamp                        Z

     D zzomit          PR            50A   varying
     D  myName                       10A   options(*OMIT)
     D  yourName                     10A

     D zznopass        PR            50A   varying
     D  myName                       10A
     D  yourName                     10A   options(*NOPASS)

     D memset          PR                  ExtProc('__memset')
     D  pTarget                        *   Value
     D  nChar                        10I 0 Value
     D  nBufLen                      10U 0 Value

     D zzboom          PR

     D zzhang          PR

     D zzbigi          PR            20u 0
     D  mmint8                        3i 0
     D  mmint16                       5i 0
     D  mmint32                      10i 0
     D  mmint64                      20i 0
     D  myint8                        3i 0
     D  myint16                       5i 0
     D  myint32                      10i 0
     D  myint64                      20i 0
     D  myuint8                       3u 0
     D  myuint16                      5u 0
     D  myuint32                     10u 0
     D  myuint64                     20u 0


     D DebugMe         PR
     D Message                      100A   value varying

     D QMHSNDM         PR                  ExtPgm('QMHSNDM')
     D   MsgID                        7A   const
     D   QualMsgF                    20A   const
     D   MsgTxt                   32767A   const options(*varsize)
     D   MsgTxtLen                   10I 0 const
     D   MsgType                     10A   const
     D   MsgQueues                   20A   const dim(50) options(*varsize)
     D   NumQueues                   10I 0 const
     D   RpyQueue                    20A   const
     D   MsgKey                       4A
     D   ErrorCode                 8000A   options(*varsize)
     D   CCSID                       10I 0 const options(*nopass)

     D QMHRCVPM        PR                  ExtPgm('QMHRCVPM')
     D   MsgInfo                  32767A   options(*varsize)
     D   MsgInfoLen                  10I 0 const
     D   Format                       8A   const
     D   StackEntry                  10A   const
     D   StackCount                  10I 0 const
     D   MsgType                     10A   const
     D   MsgKey                       4A   const
     D   WaitTime                    10I 0 const
     D   MsgAction                   10A   const
     D   ErrorCode                 8000A   options(*varsize)

     D TONMAX          c                   const(2)

     D dcTon_t         ds                  qualified based(Template)
     D  so7a                          7a
     D  so4p0                         4p 0
     D  so8a                          8a
     D  so5p0                         5p 0
     D  so3a                          3a
     D  so6a                          6a
     D  so3p0                         3p 0
     D  so22a                        22a
     D  so2p0                         2p 0
     D  so2a                          2a
     D  so4p2                         4p 2
     D  so1a                          1a
     D  so3s0                         3s 0
     D  so4s0                         4s 0
     D  so9p0                         9p 0
     D  so12a                        12a
     D  so12p3                       12p 3
     D  so15a                        15a
     D  so17p7                       17p 7
     D  to7a                          7a
     D  to4p0                         4p 0
     D  to8a                          8a
     D  to5p0                         5p 0
     D  to3a                          3a
     D  to6a                          6a
     D  to3p0                         3p 0
     D  to22a                        22a
     D  to2p0                         2p 0
     D  to2a                          2a
     D  to4p2                         4p 2
     D  to1a                          1a
     D  to3s0                         3s 0
     D  to4s0                         4s 0
     D  to9p0                         9p 0
     D  to12a                        12a
     D  to12p3                       12p 3
     D  to15a                        15a
     D  to17p7                       17p 7
     D  uo7a                          7a
     D  uo4p0                         4p 0
     D  uo8a                          8a
     D  uo5p0                         5p 0
     D  uo3a                          3a
     D  uo6a                          6a
     D  uo3p0                         3p 0
     D  uo22a                        22a
     D  uo2p0                         2p 0
     D  uo2a                          2a
     D  uo4p2                         4p 2
     D  uo1a                          1a
     D  uo3s0                         3s 0
     D  uo4s0                         4s 0
     D  uo9p0                         9p 0
     D  uo12a                        12a
     D  uo12p3                       12p 3
     D  uo15a                        15a
     D  uo17p7                       17p 7
     D  vo7a                          7a
     D  vo4p0                         4p 0
     D  vo8a                          8a
     D  vo5p0                         5p 0
     D  vo3a                          3a
     D  vo6a                          6a
     D  vo3p0                         3p 0
     D  vo22a                        22a
     D  vo2p0                         2p 0
     D  vo2a                          2a
     D  vo4p2                         4p 2
     D  vo1a                          1a
     D  vo3s0                         3s 0
     D  vo4s0                         4s 0
     D  vo9p0                         9p 0
     D  vo12a                        12a
     D  vo12p3                       12p 3
     D  vo15a                        15a
     D  vo17p7                       17p 7
     D  wo7a                          7a
     D  wo4p0                         4p 0
     D  wo8a                          8a
     D  wo5p0                         5p 0
     D  wo3a                          3a
     D  wo6a                          6a
     D  wo3p0                         3p 0
     D  wo22a                        22a
     D  wo2p0                         2p 0
     D  wo2a                          2a
     D  wo4p2                         4p 2
     D  wo1a                          1a
     D  wo3s0                         3s 0
     D  wo4s0                         4s 0
     D  wo9p0                         9p 0
     D  wo12a                        12a
     D  wo12p3                       12p 3
     D  wo15a                        15a
     D  wo17p7                       17p 7
     D  xo7a                          7a
     D  xo4p0                         4p 0
     D  xo8a                          8a
     D  xo5p0                         5p 0
     D  xo3a                          3a
     D  xo6a                          6a
     D  xo3p0                         3p 0
     D  xo22a                        22a
     D  xo2p0                         2p 0
     D  xo2a                          2a
     D  xo4p2                         4p 2
     D  xo1a                          1a
     D  xo3s0                         3s 0
     D  xo4s0                         4s 0
     D  xo9p0                         9p 0
     D  xo12a                        12a
     D  xo12p3                       12p 3
     D  xo15a                        15a
     D  xo17p7                       17p 7
     D  yo7a                          7a
     D  yo4p0                         4p 0
     D  yo8a                          8a
     D  yo5p0                         5p 0
     D  yo3a                          3a
     D  yo6a                          6a
     D  yo3p0                         3p 0
     D  yo22a                        22a
     D  yo2p0                         2p 0
     D  yo2a                          2a
     D  yo4p2                         4p 2
     D  yo1a                          1a
     D  yo3s0                         3s 0
     D  yo4s0                         4s 0
     D  yo9p0                         9p 0
     D  yo12a                        12a
     D  yo12p3                       12p 3
     D  yo15a                        15a
     D  yo17p7                       17p 7
     D  zo7a                          7a
     D  zo4p0                         4p 0
     D  zo8a                          8a
     D  zo5p0                         5p 0
     D  zo3a                          3a
     D  zo6a                          6a
     D  zo3p0                         3p 0
     D  zo22a                        22a
     D  zo2p0                         2p 0
     D  zo2a                          2a
     D  zo4p2                         4p 2
     D  zo1a                          1a
     D  zo3s0                         3s 0
     D  zo4s0                         4s 0
     D  zo9p0                         9p 0
     D  zo12a                        12a
     D  zo12p3                       12p 3
     D  zo15a                        15a
     D  zo17p7                       17p 7

     D zzton           PR
     D  nn1p0                         1p 0
     D  nn7a                          7a
     D  nn8p0                         8p 0
     D  nnDS                               likeds(dcTon_t) dim(TONMAX)
     D  nn9p0                         9p 0
     D  nn1a                          1a
     D  nn60a                        60a
     D  nn35a                        35a

     D zztonbad        PR
     D  nn1p0                         1p 0
     D  nn7a                          7a
     D  nn8p0                         8p 0
     D  nnDS                               likeds(dcTon_t) dim(TONMAX)
     D  nn9p0                         9p 0
     D  nn1a                          1a
     D  nn60a                        60a
     D  nn35a                        35a

     D zzconst         PR           100A
     D  byRefSpill                   17A   const
     D  byRef                        10A

      *****************************************************
      * DebugMe
      * Send message to qsysopr and wait for response
      * to allow for debug. 
      * return NA
      *****************************************************
     P DebugMe         B                   export
     D DebugMe         PI
     D Message                      100A   value varying

     D RCVM0100        DS                  qualified
     D   BytesRtn                    10I 0
     D   BytesAvail                  10I 0
     D   MsgSev                      10I 0
     D   MsgID                        7A
     D   MsgType                      2A
     D   MsgKey                       4A
     D                                7A
     D   CCSID_status                10I 0
     D   CCSID                       10I 0
     D   MsgDtaLen                   10I 0
     D   MsgDtaAvail                 10I 0
     D   MsgDta                    8000A

     D ErrorCode       ds                  qualified
     D   BytesProv                   10I 0 inz(0)
     D   BytesAvail                  10I 0 inz(0)

     D MsgKey          s              4A
     D MsgQ            s             20A   dim(1) inz('*SYSOPR')
     D Reply           s            100A
      /free
          QMHSNDM( *blanks
                   : *blanks
                   : Message
                   : %len(Message)
                   : '*INQ'
                   : MsgQ
                   : %elem(MsgQ)
                   : '*PGMQ'
                   : MsgKey
                   : ErrorCode );

          // Wait up to 1 hour (3600 seconds) for a reply to the
          // above message. If you change the value of 3600 below to
          // a value of -1, it will wait indefinitely.
          QMHRCVPM( RCVM0100
                    : %size(RCVM0100)
                    : 'RCVM0100'
                    : '*'
                    : 0
                    : '*RPY'
                    : MsgKey
                    : 3600
                    : '*REMOVE'
                    : ErrorCode );
          Reply = %subst(RCVM0100.MsgDta: 1: RCVM0100.MsgDtaLen);
      /end-free
     P                 E


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzstep: check private (stateful)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzstep          B                   export
     D zzstep          PI            10i 0
      /free
        Step +=1;
        return Step;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzarray: check return array aggregate 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzarray         B                   export
     D zzarray         PI                  likeds(dcRec_t) dim(ARRAYMAX)
     D  myName                       10A
     D  myMax                        10i 0
     D  myCount                      10i 0
      * vars
     D i               S             10i 0 inz(0)
     D max             S             10i 0 inz(ARRAYMAX)
     D findMe          DS                  likeds(dcRec_t) dim(ARRAYMAX)
      /free
       if myMax <= max;
         max = myMax;
       endif;
       for i = 1 to max;
         findMe(i).dcMyName = %trim(myName) + %char(i);
         if myMax > 10;
           memset(%ADDR(findMe(i).dcMyJob):193:4095); // 'A'
         else;
           findMe(i).dcMyJob  = 'Test 10' + %char(i);
         endif;
         findMe(i).dcMyRank = 10 + i;
         findMe(i).dcMyPay  = 13.42 * i;
         myCount = i;
       endfor;
       return findMe;
      /end-free
     P                 E


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzarray2: check parameter array aggregate 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzarray2        B                   export
     D zzarray2        PI
     D  myName                       10A
     D  myMax                        10i 0
     D  myCount                      10i 0
     D  findMe                             likeds(dcRec_t) dim(ARRAYMAX)
      * vars
     D i               S             10i 0 inz(0)
     D max             S             10i 0 inz(ARRAYMAX)
      /free
       if myMax <= max;
         max = myMax;
       endif;
       for i = 1 to max;
         findMe(i).dcMyName = %trim(myName) + %char(i);
         if myMax > 10;
           memset(%ADDR(findMe(i).dcMyJob):193:4095); // 'A'
         else;
           findMe(i).dcMyJob  = 'Test 10' + %char(i);
         endif;
         findMe(i).dcMyRank = 10 + i;
         findMe(i).dcMyPay  = 13.42 * i;
         myCount = i;
       endfor;
       return;
      /end-free
     P                 E



      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzarrbad: check parameter array aggregate 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzarrbad        B                   export
     D zzarrbad        PI
     D  myName                       10A
     D  myMax                        10i 0
     D  myCount                      10i 0
     D  findMe                             likeds(dcRec_t) dim(ARRAYMAX)
      * vars
     D i               S             10i 0 inz(0)
     D max             S             10i 0 inz(ARRAYMAX)
      /free
       if myMax <= max;
         max = myMax;
       endif;
       for i = 1 to max;
         findMe(i).dcMyName = %trim(myName) + %char(i);
         if myMax > 10;
           memset(%ADDR(findMe(i).dcMyJob):193:4095); // 'A'
         else;
           findMe(i).dcMyJob  = 'Test 10' + %char(i);
         endif;
         findMe(i).dcMyRank = 10 + i;
         findMe(i).dcMyPay  = 13.42 * i;
         myCount = i;
       endfor;
       // error injected (deep)
       memset(%ADDR(findMe(max).dcMyName):194:%size(dcRec_t)); // 'B'
       return;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzbig: check big 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzbig           B                   export
     D zzbig           PI            10I 0
     D  myNam1                    32000A
     D  myNam2                    32000A
     D  myNam3                    32000A
     D  myNam4                    32000A
     D  myNam5                    32000A
     D  myNam6                    32000A
     D  myNam7                    32000A
     D  myNam8                    32000A
     D  myNam9                    32000A
      * vars
     D i               S             10i 0 inz(0)
      /free
       memset(%addr(myNam1):x'F1':32000);
       memset(%addr(myNam2):x'F2':32000);
       memset(%addr(myNam3):x'F3':32000);
       memset(%addr(myNam4):x'F4':32000);
       memset(%addr(myNam5):x'F5':32000);
       memset(%addr(myNam6):x'F6':32000);
       memset(%addr(myNam7):x'F7':32000);
       memset(%addr(myNam8):x'F8':32000);
       memset(%addr(myNam9):x'F9':32000);
       return 32000*9;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzvary: check return varying 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzvary          B                   export
     D zzvary          PI            20A   varying
     D  myName                       10A   varying
      * vars
     D tmp             S             20A   varying
      /free
       tmp = 'my name is ';
       tmp = tmp + myName;
       return tmp;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzomit: check omit 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzomit          B                   export
     D zzomit          PI            50A   varying
     D  myName                       10A   options(*OMIT)
     D  yourName                     10A
      * vars
     D tmp             S             50A   varying
      /free
       tmp = 'my name is ';
       if %addr(myName) <> *NULL;
         tmp = tmp + %trim(myName) + ' ' + %trim(yourName);
       else;
         tmp = tmp + 'OMIT ' + %trim(yourName);
       endif;
       return tmp;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zznopass: check nopass (does not work XML cnt = -1)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zznopass        B                   export
     D zznopass        PI            50A   varying
     D  myName                       10A
     D  yourName                     10A   options(*NOPASS)
      * vars
     D tmp             S             50A   varying
     D cnt             S             10i 0 inz(0)
      /free
       cnt = %parms;
       tmp = 'my name is ' + %char(cnt) + ' ';
       if %parms > 1;
         tmp = tmp + %trim(myName) + ' ' + %trim(yourName);
       else;
         tmp = tmp + %trim(myName) + ' NOPASS';
       endif;
       return tmp;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzbinary: check return binary 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzbinary        B                   export
     D zzbinary        PI            20A
     D  myBinary                     20A
      * vars
     D tmp             S             20A
      /free
       tmp = myBinary;
       return tmp;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzpdf: check binary 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzpdf           B                   export
     D zzpdf           PI            10i 0
     D  myPDF                     65000A
      * vars
     D i               S             10i 0 inz(0)
     D pPDF            S               *   inz(*NULL)
     D tmp             S           4096A   based(pPDF)
      /free
       pPDF = %addr(myPDF);
       for i = 1 to 15;
         if myPDF = *BLANKS;
           return 0;
         endif;
         pPDF += 4096;
       endfor;
       return 1;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zznada: check no parms 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zznada          B                   export
     D zznada          PI
      /free
       return;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzdate: check date parm
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzdate          B                   export
     D zzdate          PI              D
     D  myDate                         D   datfmt(*iso)
      * vars
     D  retDate        s               D   datfmt(*iso)
      /free
       retDate=myDate;
       myDate=d'2007-09-30';
       return retDate;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzdateUSA: check date parm
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzdateUSA       B                   export
     D zzdateUSA       PI              D   datfmt(*USA)
     D  myDate                         D   datfmt(*USA)
      * vars
     D  retDate        s               D   datfmt(*USA)
      /free
       retDate=myDate;
       myDate=d'2007-09-30';
       return retDate;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zztime: check time parm
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zztime          B                   export
     D zztime          PI              T
     D  myTime                         T   timfmt(*iso)
      * vars
     D  retTime        s               T   timfmt(*iso)
      /free
       retTime=myTime;
       myTime=t'12.34.56';
       return retTime;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zztimeUSA: check time parm
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zztimeUSA       B                   export
     D zztimeUSA       PI              T   timfmt(*USA)
     D  myTime                         T   timfmt(*USA)
      * vars
     D  retTime        s               T   timfmt(*USA)
      /free
       retTime=myTime;
       myTime=t'12.34.00';
       return retTime;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzstamp: check timestamp parm
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzstamp         B                   export
     D zzstamp         PI              Z
     D  myStamp                        Z
      * vars
     D  retStamp       s               Z
      /free
       retStamp=myStamp;
       myStamp=z'1960-12-31-12.32.23.000000';
       return retStamp;
      /end-free
     P                 E


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzboom: bad function blow up
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzboom          B                   export
     D zzboom          PI
      * vars
     D uanyv           DS                  qualified based(Template)
     D  ubufx                        32a
     D  bytex                         1a   overlay(ubufx)
     D pCopy1          s               *   inz(*NULL)
     D myCopy1         ds                  likeds(uanyv) based(pCopy1)
      /free
       myCopy1.bytex='1'; // exception
      /end-free
     P                 E


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzhang: bad function hang up
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzhang          B                   export
     D zzhang          PI
      /free
       DebugMe('zzhang test case waiting forever');
      /end-free
     P                 E


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zz200: check NLS 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zz200           B                   export
     D zz200           PI
     D  my200                       200A
      * vars
     D tmp             S            200A
      /free
       tmp = my200;
      /end-free
     P                 E


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzbigi: check ints 
      * int8  -128                  +127
      * int16 -32768                +32767
      * int32 -2147483648           +2147483647
      * int64 -9223372036854775808  +9223372036854775807
      * uint8                       +255
      * uint16                      +65535
      * uint32                      +4294967295
      * uint64                      +18446744073709551615
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzbigi          B                   export
     D zzbigi          PI            20u 0
     D  mmint8                        3i 0
     D  mmint16                       5i 0
     D  mmint32                      10i 0
     D  mmint64                      20i 0
     D  myint8                        3i 0
     D  myint16                       5i 0
     D  myint32                      10i 0
     D  myint64                      20i 0
     D  myuint8                       3u 0
     D  myuint16                      5u 0
     D  myuint32                     10u 0
     D  myuint64                     20u 0
      * vars
     D tmp             S             20u 0
      /free
       // negative integer
       mmint8   += 1;
       mmint16  += 1;
       mmint32  += 1;
       mmint64  += 1;
       mmint8   -= 1;
       mmint16  -= 1;
       mmint32  -= 1;
       mmint64  -= 1;
       // positive integer
       myint8   -= 1;
       myint16  -= 1;
       myint32  -= 1;
       myint64  -= 1;
       myint8   += 1;
       myint16  += 1;
       myint32  += 1;
       myint64  += 1;
       // unsigned integer
       myuint8  -= 1;
       myuint16 -= 1;
       myuint32 -= 1;
       myuint64 -= 1;
       myuint8  += 1;
       myuint16 += 1;
       myuint32 += 1;
       myuint64 += 1;
       tmp = myuint64;
       return tmp;
      /end-free
     P                 E



      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzton: check parm array aggregate 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzton           B                   export
     D zzton           PI
     D  nn1p0                         1p 0
     D  nn7a                          7a
     D  nn8p0                         8p 0
     D  nnDS                               likeds(dcTon_t) dim(TONMAX)
     D  nn9p0                         9p 0
     D  nn1a                          1a
     D  nn60a                        60a
     D  nn35a                        35a
      * vars
     D i               S             10i 0 inz(0)
      /free
       nn1p0   = 1.0;
       nn7a    = '1234567';
       nn8p0   = 12345678.0;
       nn9p0   = 12345679.0;
       nn1a    = '1';
       nn60a   = '1 to 60';
       nn35a   = '1 to 35';
       for i = 1 to TONMAX;
         nnDS(i).so7a   = '1234567';
         nnDS(i).so4p0  = 1234.0;
         nnDS(i).so8a   = '12345678';
         nnDS(i).so5p0  = 12345.0;
         nnDS(i).so3a   = '123';
         nnDS(i).so6a   = '123456';
         nnDS(i).so3p0  = 123.0;
         nnDS(i).so22a  = '1 to 22';
         nnDS(i).so2p0  = 12.0;
         nnDS(i).so2a   = '12';
         nnDS(i).so4p2  = 14.12;
         nnDS(i).so1a   = '1';
         nnDS(i).so3s0  = 123.0;
         nnDS(i).so4s0  = 1234.0;
         nnDS(i).so9p0  = 12345679.0;
         nnDS(i).so12a  = '1 to 12';
         nnDS(i).so12p3 = 112.123;
         nnDS(i).so15a  = '1 to 15';
         nnDS(i).so17p7 = 117.1234567;

         nnDS(i).to7a   = '1234567';
         nnDS(i).to4p0  = 1234.0;
         nnDS(i).to8a   = '12345678';
         nnDS(i).to5p0  = 12345.0;
         nnDS(i).to3a   = '123';
         nnDS(i).to6a   = '123456';
         nnDS(i).to3p0  = 123.0;
         nnDS(i).to22a  = '1 to 22';
         nnDS(i).to2p0  = 12.0;
         nnDS(i).to2a   = '12';
         nnDS(i).to4p2  = 14.12;
         nnDS(i).to1a   = '1';
         nnDS(i).to3s0  = 123.0;
         nnDS(i).to4s0  = 1234.0;
         nnDS(i).to9p0  = 12345679.0;
         nnDS(i).to12a  = '1 to 12';
         nnDS(i).to12p3 = 112.123;
         nnDS(i).to15a  = '1 to 15';
         nnDS(i).to17p7 = 117.1234567;

         nnDS(i).uo7a   = '1234567';
         nnDS(i).uo4p0  = 1234.0;
         nnDS(i).uo8a   = '12345678';
         nnDS(i).uo5p0  = 12345.0;
         nnDS(i).uo3a   = '123';
         nnDS(i).uo6a   = '123456';
         nnDS(i).uo3p0  = 123.0;
         nnDS(i).uo22a  = '1 to 22';
         nnDS(i).uo2p0  = 12.0;
         nnDS(i).uo2a   = '12';
         nnDS(i).uo4p2  = 14.12;
         nnDS(i).uo1a   = '1';
         nnDS(i).uo3s0  = 123.0;
         nnDS(i).uo4s0  = 1234.0;
         nnDS(i).uo9p0  = 12345679.0;
         nnDS(i).uo12a  = '1 to 12';
         nnDS(i).uo12p3 = 112.123;
         nnDS(i).uo15a  = '1 to 15';
         nnDS(i).uo17p7 = 117.1234567;

         nnDS(i).vo7a   = '1234567';
         nnDS(i).vo4p0  = 1234.0;
         nnDS(i).vo8a   = '12345678';
         nnDS(i).vo5p0  = 12345.0;
         nnDS(i).vo3a   = '123';
         nnDS(i).vo6a   = '123456';
         nnDS(i).vo3p0  = 123.0;
         nnDS(i).vo22a  = '1 to 22';
         nnDS(i).vo2p0  = 12.0;
         nnDS(i).vo2a   = '12';
         nnDS(i).vo4p2  = 14.12;
         nnDS(i).vo1a   = '1';
         nnDS(i).vo3s0  = 123.0;
         nnDS(i).vo4s0  = 1234.0;
         nnDS(i).vo9p0  = 12345679.0;
         nnDS(i).vo12a  = '1 to 12';
         nnDS(i).vo12p3 = 112.123;
         nnDS(i).vo15a  = '1 to 15';
         nnDS(i).vo17p7 = 117.1234567;

         nnDS(i).wo7a   = '1234567';
         nnDS(i).wo4p0  = 1234.0;
         nnDS(i).wo8a   = '12345678';
         nnDS(i).wo5p0  = 12345.0;
         nnDS(i).wo3a   = '123';
         nnDS(i).wo6a   = '123456';
         nnDS(i).wo3p0  = 123.0;
         nnDS(i).wo22a  = '1 to 22';
         nnDS(i).wo2p0  = 12.0;
         nnDS(i).wo2a   = '12';
         nnDS(i).wo4p2  = 14.12;
         nnDS(i).wo1a   = '1';
         nnDS(i).wo3s0  = 123.0;
         nnDS(i).wo4s0  = 1234.0;
         nnDS(i).wo9p0  = 12345679.0;
         nnDS(i).wo12a  = '1 to 12';
         nnDS(i).wo12p3 = 112.123;
         nnDS(i).wo15a  = '1 to 15';
         nnDS(i).wo17p7 = 117.1234567;

         nnDS(i).xo7a   = '1234567';
         nnDS(i).xo4p0  = 1234.0;
         nnDS(i).xo8a   = '12345678';
         nnDS(i).xo5p0  = 12345.0;
         nnDS(i).xo3a   = '123';
         nnDS(i).xo6a   = '123456';
         nnDS(i).xo3p0  = 123.0;
         nnDS(i).xo22a  = '1 to 22';
         nnDS(i).xo2p0  = 12.0;
         nnDS(i).xo2a   = '12';
         nnDS(i).xo4p2  = 14.12;
         nnDS(i).xo1a   = '1';
         nnDS(i).xo3s0  = 123.0;
         nnDS(i).xo4s0  = 1234.0;
         nnDS(i).xo9p0  = 12345679.0;
         nnDS(i).xo12a  = '1 to 12';
         nnDS(i).xo12p3 = 112.123;
         nnDS(i).xo15a  = '1 to 15';
         nnDS(i).xo17p7 = 117.1234567;

         nnDS(i).yo7a   = '1234567';
         nnDS(i).yo4p0  = 1234.0;
         nnDS(i).yo8a   = '12345678';
         nnDS(i).yo5p0  = 12345.0;
         nnDS(i).yo3a   = '123';
         nnDS(i).yo6a   = '123456';
         nnDS(i).yo3p0  = 123.0;
         nnDS(i).yo22a  = '1 to 22';
         nnDS(i).yo2p0  = 12.0;
         nnDS(i).yo2a   = '12';
         nnDS(i).yo4p2  = 14.12;
         nnDS(i).yo1a   = '1';
         nnDS(i).yo3s0  = 123.0;
         nnDS(i).yo4s0  = 1234.0;
         nnDS(i).yo9p0  = 12345679.0;
         nnDS(i).yo12a  = '1 to 12';
         nnDS(i).yo12p3 = 112.123;
         nnDS(i).yo15a  = '1 to 15';
         nnDS(i).yo17p7 = 117.1234567;

         nnDS(i).zo7a   = '1234567';
         nnDS(i).zo4p0  = 1234.0;
         nnDS(i).zo8a   = '12345678';
         nnDS(i).zo5p0  = 12345.0;
         nnDS(i).zo3a   = '123';
         nnDS(i).zo6a   = '123456';
         nnDS(i).zo3p0  = 123.0;
         nnDS(i).zo22a  = '1 to 22';
         nnDS(i).zo2p0  = 12.0;
         nnDS(i).zo2a   = '12';
         nnDS(i).zo4p2  = 14.12;
         nnDS(i).zo1a   = '1';
         nnDS(i).zo3s0  = 123.0;
         nnDS(i).zo4s0  = 1234.0;
         nnDS(i).zo9p0  = 12345679.0;
         nnDS(i).zo12a  = '1 to 12';
         nnDS(i).zo12p3 = 112.123;
         nnDS(i).zo15a  = '1 to 15';
         nnDS(i).zo17p7 = 117.1234567;
       endfor;
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zztonbad: check parm array aggregate bad
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zztonbad        B                   export
     D zztonbad        PI
     D  nn1p0                         1p 0
     D  nn7a                          7a
     D  nn8p0                         8p 0
     D  nnDS                               likeds(dcTon_t) dim(TONMAX)
     D  nn9p0                         9p 0
     D  nn1a                          1a
     D  nn60a                        60a
     D  nn35a                        35a
      * vars
     D i               S             10i 0 inz(0)
      /free
       nn1p0   = 1.0;
       nn7a    = '1234567';
       nn8p0   = 12345678.0;
       nn9p0   = 12345679.0;
       nn1a    = '1';
       nn60a   = '1 to 60';
       nn35a   = '1 to 35';
       for i = 1 to TONMAX;
         nnDS(i).so7a   = '1234567';
         nnDS(i).so4p0  = 1234.0;
         nnDS(i).so8a   = '12345678';
         nnDS(i).so5p0  = 12345.0;
         nnDS(i).so3a   = '123';
         nnDS(i).so6a   = '123456';
         nnDS(i).so3p0  = 123.0;
         nnDS(i).so22a  = '1 to 22';
         nnDS(i).so2p0  = 12.0;
         nnDS(i).so2a   = '12';
         nnDS(i).so4p2  = 14.12;
         nnDS(i).so1a   = '1';
         nnDS(i).so3s0  = 123.0;
         nnDS(i).so4s0  = 1234.0;
         nnDS(i).so9p0  = 12345679.0;
         nnDS(i).so12a  = '1 to 12';
         nnDS(i).so12p3 = 112.123;
         nnDS(i).so15a  = '1 to 15';
         nnDS(i).so17p7 = 117.1234567;

         nnDS(i).to7a   = '1234567';
         nnDS(i).to4p0  = 1234.0;
         nnDS(i).to8a   = '12345678';
         nnDS(i).to5p0  = 12345.0;
         nnDS(i).to3a   = '123';
         nnDS(i).to6a   = '123456';
         nnDS(i).to3p0  = 123.0;
         nnDS(i).to22a  = '1 to 22';
         nnDS(i).to2p0  = 12.0;
         nnDS(i).to2a   = '12';
         nnDS(i).to4p2  = 14.12;
         nnDS(i).to1a   = '1';
         nnDS(i).to3s0  = 123.0;
         nnDS(i).to4s0  = 1234.0;
         nnDS(i).to9p0  = 12345679.0;
         nnDS(i).to12a  = '1 to 12';
         nnDS(i).to12p3 = 112.123;
         nnDS(i).to15a  = '1 to 15';
         nnDS(i).to17p7 = 117.1234567;

         nnDS(i).uo7a   = '1234567';
         nnDS(i).uo4p0  = 1234.0;
         nnDS(i).uo8a   = '12345678';
         nnDS(i).uo5p0  = 12345.0;
         nnDS(i).uo3a   = '123';
         nnDS(i).uo6a   = '123456';
         nnDS(i).uo3p0  = 123.0;
         nnDS(i).uo22a  = '1 to 22';
         nnDS(i).uo2p0  = 12.0;
         nnDS(i).uo2a   = '12';
         nnDS(i).uo4p2  = 14.12;
         nnDS(i).uo1a   = '1';
         nnDS(i).uo3s0  = 123.0;
         nnDS(i).uo4s0  = 1234.0;
         nnDS(i).uo9p0  = 12345679.0;
         nnDS(i).uo12a  = '1 to 12';
         nnDS(i).uo12p3 = 112.123;
         nnDS(i).uo15a  = '1 to 15';
         nnDS(i).uo17p7 = 117.1234567;

         nnDS(i).vo7a   = '1234567';
         nnDS(i).vo4p0  = 1234.0;
         nnDS(i).vo8a   = '12345678';
         nnDS(i).vo5p0  = 12345.0;
         nnDS(i).vo3a   = '123';
         nnDS(i).vo6a   = '123456';
         nnDS(i).vo3p0  = 123.0;
         nnDS(i).vo22a  = '1 to 22';
         nnDS(i).vo2p0  = 12.0;
         nnDS(i).vo2a   = '12';
         nnDS(i).vo4p2  = 14.12;
         nnDS(i).vo1a   = '1';
         nnDS(i).vo3s0  = 123.0;
         nnDS(i).vo4s0  = 1234.0;
         nnDS(i).vo9p0  = 12345679.0;
         nnDS(i).vo12a  = '1 to 12';
         nnDS(i).vo12p3 = 112.123;
         nnDS(i).vo15a  = '1 to 15';
         nnDS(i).vo17p7 = 117.1234567;

         nnDS(i).wo7a   = '1234567';
         nnDS(i).wo4p0  = 1234.0;
         nnDS(i).wo8a   = '12345678';
         nnDS(i).wo5p0  = 12345.0;
         nnDS(i).wo3a   = '123';
         nnDS(i).wo6a   = '123456';
         nnDS(i).wo3p0  = 123.0;
         nnDS(i).wo22a  = '1 to 22';
         nnDS(i).wo2p0  = 12.0;
         nnDS(i).wo2a   = '12';
         nnDS(i).wo4p2  = 14.12;
         nnDS(i).wo1a   = '1';
         nnDS(i).wo3s0  = 123.0;
         nnDS(i).wo4s0  = 1234.0;
         nnDS(i).wo9p0  = 12345679.0;
         nnDS(i).wo12a  = '1 to 12';
         nnDS(i).wo12p3 = 112.123;
         nnDS(i).wo15a  = '1 to 15';
         nnDS(i).wo17p7 = 117.1234567;

         nnDS(i).xo7a   = '1234567';
         nnDS(i).xo4p0  = 1234.0;
         nnDS(i).xo8a   = '12345678';
         nnDS(i).xo5p0  = 12345.0;
         nnDS(i).xo3a   = '123';
         nnDS(i).xo6a   = '123456';
         nnDS(i).xo3p0  = 123.0;
         nnDS(i).xo22a  = '1 to 22';
         nnDS(i).xo2p0  = 12.0;
         nnDS(i).xo2a   = '12';
         nnDS(i).xo4p2  = 14.12;
         nnDS(i).xo1a   = '1';
         nnDS(i).xo3s0  = 123.0;
         nnDS(i).xo4s0  = 1234.0;
         nnDS(i).xo9p0  = 12345679.0;
         nnDS(i).xo12a  = '1 to 12';
         nnDS(i).xo12p3 = 112.123;
         nnDS(i).xo15a  = '1 to 15';
         nnDS(i).xo17p7 = 117.1234567;

         nnDS(i).yo7a   = '1234567';
         nnDS(i).yo4p0  = 1234.0;
         nnDS(i).yo8a   = '12345678';
         nnDS(i).yo5p0  = 12345.0;
         nnDS(i).yo3a   = '123';
         nnDS(i).yo6a   = '123456';
         nnDS(i).yo3p0  = 123.0;
         nnDS(i).yo22a  = '1 to 22';
         nnDS(i).yo2p0  = 12.0;
         nnDS(i).yo2a   = '12';
         nnDS(i).yo4p2  = 14.12;
         nnDS(i).yo1a   = '1';
         nnDS(i).yo3s0  = 123.0;
         nnDS(i).yo4s0  = 1234.0;
         nnDS(i).yo9p0  = 12345679.0;
         nnDS(i).yo12a  = '1 to 12';
         nnDS(i).yo12p3 = 112.123;
         nnDS(i).yo15a  = '1 to 15';
         nnDS(i).yo17p7 = 117.1234567;

         nnDS(i).zo7a   = '1234567';
         nnDS(i).zo4p0  = 1234.0;
         nnDS(i).zo8a   = '12345678';
         nnDS(i).zo5p0  = 12345.0;
         nnDS(i).zo3a   = '123';
         nnDS(i).zo6a   = '123456';
         nnDS(i).zo3p0  = 123.0;
         nnDS(i).zo22a  = '1 to 22';
         nnDS(i).zo2p0  = 12.0;
         nnDS(i).zo2a   = '12';
         nnDS(i).zo4p2  = 14.12;
         nnDS(i).zo1a   = '1';
         nnDS(i).zo3s0  = 123.0;
         nnDS(i).zo4s0  = 1234.0;
         nnDS(i).zo9p0  = 12345679.0;
         nnDS(i).zo12a  = '1 to 12';
         nnDS(i).zo12p3 = 112.123;
         nnDS(i).zo15a  = '1 to 15';
         nnDS(i).zo17p7 = 117.1234567;
       endfor;
       // error injected (deep)
       memset(%ADDR(nnDS(TONMAX).so7a):194:%size(dcTon_t)); // 'B'
      /end-free
     P                 E

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzzconst: try explain 'const'/'value' (uf da)
      * data <= 16 -- fits in 1/2 regs, so 'true' value pass
      * data > 16 -- spills copy memory, so effectively by ref
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzconst         B                   export
     D zzconst         PI           100A
     D  byRefSpill                   17A   const
     D  byRef                        10A
      * vars
      /free

       // not 'by val', actually compiler temp copy 'by ref'
       // <parm by='ref'><data type='17A'>suprise<data></parm>
       // byRefSpill = 'suprise';

       // <parm by='ref'><data type='10A'>expect<data></parm>
       // byRef = 'expect';

       // <return><data type='17A'>expect suprise<data></return>
       return byRef + ' ' + byRefSpill;
      /end-free
     P                 E

