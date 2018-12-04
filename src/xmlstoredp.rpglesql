     H NOMAIN
     H AlwNull(*UsrCtl)
     H BNDDIR('QC2LE')
   
      *****************************************************
      * Copyright (c) 2010, IBM Corporation
      * All rights reserved.
      *
      * Redistribution and use in source and binary forms, 
      * with or without modification, are permitted provided 
      * that the following conditions are met:
      * - Redistributions of source code must retain 
      *   the above copyright notice, this list of conditions 
      *   and the following disclaimer. 
      * - Redistributions in binary form must reproduce the 
      *   above copyright notice, this list of conditions 
      *   and the following disclaimer in the documentation 
      *   and/or other materials provided with the distribution.
      * - Neither the name of the IBM Corporation nor the names 
      *   of its contributors may be used to endorse or promote 
      *   products derived from this software without specific 
      *   prior written permission. 
      *
      * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND 
      * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
      * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
      * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
      * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR 
      * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
      * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
      * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
      * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
      * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
      * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
      * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE 
      * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
      * POSSIBILITY OF SUCH DAMAGE.
      *****************************************************

      *****************************************************
      * includes
      *****************************************************
      /copy plugconf_h
      /copy plugbug_h
      /copy plugrun_h
      /copy plugperf_h
      /copy plugconv_h


      *****************************************************
      * stored procedure interface(s)
      * see: strsql.cmd
      * Notes:
      * SP's based on the idea why transmit more data than
      * needed for I/O and bog down the "wire" talk 
      *****************************************************
     d sLast151        s             10i 0 inz(0)
     d Occurs151       s              5P 0 inz(5001)
     d Output151       ds                  occurs(5001)
     d   Out151                    3000A

     D iRunMe          PR             1N
     D pIPC                        1024A   value
     D pCtl                        1024A   value
     D pXmlIn                          *   value
     D szXmlIn                       10i 0 value
     D pXmlOut                         *   value
     D szXmlOut                      10i 0 value

      *****************************************************
      * stored procedure interface(s)
      * see: strsql.cmd
      * Notes:
      * New accumulate interface (JTOpenLite)
      *****************************************************
     d Accm151         s             10i 0 inz(0)
     d Accumu151       ds                  occurs(5001)
     d   Acc151                    3000A

     D iAccMe          PR             1N
     D pIPC                        1024A   value
     D pCtl                        1024A   value
     D pXmlIn                          *   value
     D szXmlIn                       10i 0 value
     D pCnt                          10i 0 value
     D pOff                          10i 0 value

      * in/out parm

     D iPLUG4K         PR             1N   extproc(*CL:'iPLUG4K')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *

     D iPLUG32K        PR             1N   extproc(*CL:'iPLUG32K')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *

     D iPLUG65K        PR             1N   extproc(*CL:'iPLUG65K')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *

     D iPLUG512K       PR             1N   extproc(*CL:'iPLUG512K')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *

     D iPLUG1M         PR             1N   extproc(*CL:'iPLUG1M')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *

     D iPLUG5M         PR             1N   extproc(*CL:'iPLUG5M')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *

     D iPLUG10M        PR             1N   extproc(*CL:'iPLUG10M')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *

     D iPLUG15M        PR             1N   extproc(*CL:'iPLUG15M')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *

      * result set

     D iPLUGR4K        PR             1N   extproc(*CL:'iPLUGR4K')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *

     D iPLUGR32K       PR             1N   extproc(*CL:'iPLUGR32K')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *

     D iPLUGR65K       PR             1N   extproc(*CL:'iPLUGR65K')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *

     D iPLUGR512K      PR             1N   extproc(*CL:'iPLUGR512K')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *

     D iPLUGR1M        PR             1N   extproc(*CL:'iPLUGR1M')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *

     D iPLUGR5M        PR             1N   extproc(*CL:'iPLUGR5M')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *

     D iPLUGR10M       PR             1N   extproc(*CL:'iPLUGR10M')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *

     D iPLUGR15M       PR             1N   extproc(*CL:'iPLUGR15M')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *

     D iPLUGRC32K      PR             1N   extproc(*CL:'iPLUGRC32K')
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pCnt                          10i 0

      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      * utilities
      *++++++++++++++++++++++++++++++++++++++++++++++++++++

      *****************************************************
      * Note:
      * There is compile tricks played here. 
      * We are just skipping past CLOB varying length
      * %ADDR(pXml)+4 to avoid RPG compiler interference
      * with this larger CLOB buffer.
      *****************************************************
     P iRunMe          B
     D iRunMe          PI             1N
     D pIPC                        1024A   value
     D pCtl                        1024A   value
     D pXmlIn                          *   value
     D szXmlIn                       10i 0 value
     D pXmlOut                         *   value
     D szXmlOut                      10i 0 value
      * vars
     D rc              S              1N   inz(*OFF)
     D pIClob          S               *   inz(*NULL)
     D szIClob         S             10i 0 inz(0)
     D mxIClob         S             10i 0 inz(0)
     D pOClob          S               *   inz(*NULL)
     D szOClob         S             10i 0 inz(0)
     D mxOClob         S             10i 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D totSz           S             10i 0 inz(0)
     D rows            S             10i 0 inz(0)
     D rowSz           S             10i 0 inz(3000)
     D pos             S             10i 0 inz(0)
      /free
       // -----------
       // input
       pIClob       = pXmlIn+4;            // clob length (4 bytes)
       mxIClob      = szXmlIn;             // max size clob used
       pCopy        = pIClob + mxIClob;    // end of buffer
       myCopy.bytex = x'00';               // null terminate string
       szIClob      = strlen(pIClob);      // string length clob

       // -----------
       // output
       if pXmlOut <> *NULL;
         pOClob       = pXmlOut+4;         // clob length (4 bytes)
         mxOClob      = szXmlOut;          // max size clob used
         pCopy        = pOClob + mxOClob;  // end of buffer
         myCopy.bytex = x'00';             // null terminate string
         szOClob      = strlen(pOClob);    // string length clob
       else;
         pOClob       = %ADDR(Output151);  // internal (result set)
         mxOClob      = mxIClob;           // max size clob used
         pCopy        = pOClob + mxOClob;  // end of buffer
         myCopy.bytex = x'00';             // null terminate string
         szOClob      = strlen(pOClob);    // string length clob
         if szOClob < sLast151;
           szOClob    = sLast151;          // last time larger
         endif;
         sLast151     = mxOClob;           // save this time
       endif;
       if szOClob > 0;
         memset(pOClob:0:szOClob);         // clear output area
       endif;
       szOClob        = 0;                 // no size (yet)

       // -----------
       // make call to XML Toolkit Service
       rc = runClient(pIPC:pCtl:pIClob:mxIClob:pOClob:mxOClob);

       // -----------
       // input buffer clear for reuse
       szIClob      = strlen(pIClob);      // string length clob
       memset(pIClob:0:szIClob);           // clear input area

       // -----------
       // output buffer actual string length
       pCopy        = pOClob + mxOClob;    // end of buffer
       myCopy.bytex = x'00';               // null terminate string
       szOClob      = strlen(pOClob);      // string length clob
       if pXmlOut <> *NULL;                // in/out parameter
         pCopy      = pXmlOut;             // DB2 actual lob length
         myCopy.intx= szOClob;
       else;                               // result set
         totSz      = szOClob + rowSz;     // round up row count
         rows       = %div(totSz:rowSz);   // how many rows
         // sql result set for rows
         Occurs151  = rows;
         exec sql
         Set Result Sets Array :Output151 For :Occurs151 Rows;
       endif;

       return rc;
      /end-free
     P                 E


      *****************************************************
      * Note:
      * There is compile tricks played here. 
      * We are just skipping past CLOB varying length
      * %ADDR(pXml)+4 to avoid RPG compiler interference
      * with this larger CLOB buffer.
      *****************************************************
     P iAccMe          B
     D iAccMe          PI             1N
     D pIPC                        1024A   value
     D pCtl                        1024A   value
     D pXmlIn                          *   value
     D szXmlIn                       10i 0 value
     D pCnt                          10i 0 value
     D pOff                          10i 0 value
      * vars
     D rc              S              1N   inz(*ON)
     D pIClob          S               *   inz(*NULL)
     D szIClob         S             10i 0 inz(0)
     D mxIClob         S             10i 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D pAccm           s               *   inz(*NULL)
      /free
       // -----------
       // input
       pIClob       = pXmlIn + pOff;       // varchar + 2 (len)
                                           // clob + 4 (len)
       mxIClob      = szXmlIn;             // max size clob used
       pCopy        = pIClob + szXmlIn;    // end of buffer
       myCopy.bytex = x'00';               // null terminate string
       szIClob      = strlen(pIClob);      // string length clob

       // -----------
       // accumulate
       if szIClob > 0;
         pAccm        = %addr(Accumu151) + Accm151 + 4;
         Accm151     += szIClob;
         pCopy        = %addr(Accumu151);  // clob size
         myCopy.uintx = Accm151;           // clob + 4 (len)
         cpybytes(pAccm:pIClob:szIClob);   // copy data
         pCopy        = %addr(Accumu151) + Accm151 + 4; // end buffer
         myCopy.bytex = x'00';             // null terminate string
       endif;

       // -----------
       // run
       if pCnt = 0;
         pAccm = %addr(Accumu151);
         rc = iRunMe(pIPC:pCtl:pAccm:15000000:*NULL:0);
         if Accm151 > 0;
           memset(pAccm:0:Accm151 + 4);    // clear input area
         endif;
         Accm151 = 0;
       endif;

       memset(pIClob:0:szIClob);           // clear input area (re-used)

       return rc;
      /end-free
     P                 E


      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      * in/out parms
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++


     P iPLUG4K         B                   export
     D iPLUG4K         PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
     D pOClob          S               *
     D szOClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 4000;
       pOClob = %ADDR(pXmlOut);
       szOClob = 4000;
       return iRunMe(pIPC:pCtl:pIClob:szIClob:pOClob:szOClob);
      /end-free
     P                 E

     P iPLUG32K        B                   export
     D iPLUG32K        PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *
      * vars
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
     D pOClob          S               *
     D szOClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 32000;
       pOClob = %ADDR(pXmlOut);
       szOClob = 32000;
       return iRunMe(pIPC:pCtl:pIClob:szIClob:pOClob:szOClob);
      /end-free
     P                 E

     P iPLUG65K        B                   export
     D iPLUG65K        PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
     D pOClob          S               *
     D szOClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 65000;
       pOClob = %ADDR(pXmlOut);
       szOClob = 65000;
       return iRunMe(pIPC:pCtl:pIClob:szIClob:pOClob:szOClob);
      /end-free
     P                 E

     P iPLUG512K       B                   export
     D iPLUG512K       PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
     D pOClob          S               *
     D szOClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 512000;
       pOClob = %ADDR(pXmlOut);
       szOClob = 512000;
       return iRunMe(pIPC:pCtl:pIClob:szIClob:pOClob:szOClob);
      /end-free
     P                 E

     P iPLUG1M         B                   export
     D iPLUG1M         PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
     D pOClob          S               *
     D szOClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 1000000;
       pOClob = %ADDR(pXmlOut);
       szOClob = 1000000;
       return iRunMe(pIPC:pCtl:pIClob:szIClob:pOClob:szOClob);
      /end-free
     P                 E

     P iPLUG5M         B                   export
     D iPLUG5M         PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
     D pOClob          S               *
     D szOClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 5000000;
       pOClob = %ADDR(pXmlOut);
       szOClob = 5000000;
       return iRunMe(pIPC:pCtl:pIClob:szIClob:pOClob:szOClob);
      /end-free
     P                 E

     P iPLUG10M        B                   export
     D iPLUG10M        PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
     D pOClob          S               *
     D szOClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 10000000;
       pOClob = %ADDR(pXmlOut);
       szOClob = 10000000;
       return iRunMe(pIPC:pCtl:pIClob:szIClob:pOClob:szOClob);
      /end-free
     P                 E

     P iPLUG15M        B                   export
     D iPLUG15M        PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pXmlOut                         *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
     D pOClob          S               *
     D szOClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 15000000;
       pOClob = %ADDR(pXmlOut);
       szOClob = 15000000;
       return iRunMe(pIPC:pCtl:pIClob:szIClob:pOClob:szOClob);
      /end-free
     P                 E


      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      * result set (3000 best max odbc drivers)
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++


     P iPLUGR4K        B                   export
     D iPLUGR4K        PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 4000;
       return iAccMe(pIPC:pCtl:pIClob:szIClob:0:4);
      /end-free
     P                 E

     P iPLUGR32K       B                   export
     D iPLUGR32K       PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 32000;
       return iAccMe(pIPC:pCtl:pIClob:szIClob:0:4);
      /end-free
     P                 E

     P iPLUGR65K       B                   export
     D iPLUGR65K       PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 65000;
       return iAccMe(pIPC:pCtl:pIClob:szIClob:0:4);
      /end-free
     P                 E

     P iPLUGR512K      B                   export
     D iPLUGR512K      PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 500000;
       return iAccMe(pIPC:pCtl:pIClob:szIClob:0:4);
      /end-free
     P                 E

     P iPLUGR1M        B                   export
     D iPLUGR1M        PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 1000000;
       return iAccMe(pIPC:pCtl:pIClob:szIClob:0:4);
      /end-free
     P                 E

     P iPLUGR5M        B                   export
     D iPLUGR5M        PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 5000000;
       return iAccMe(pIPC:pCtl:pIClob:szIClob:0:4);
      /end-free
     P                 E

     P iPLUGR10M       B                   export
     D iPLUGR10M       PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 10000000;
       return iAccMe(pIPC:pCtl:pIClob:szIClob:0:4);
      /end-free
     P                 E

     P iPLUGR15M       B                   export
     D iPLUGR15M       PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 15000000;
       return iAccMe(pIPC:pCtl:pIClob:szIClob:0:4);
      /end-free
     P                 E


      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      * accumulate 32K at time
      * result set (3000 best max odbc drivers)
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      *++++++++++++++++++++++++++++++++++++++++++++++++++++

     P iPLUGRC32K      B                   export
     D iPLUGRC32K      PI             1N
     D pIPC                        1024A
     D pCtl                        1024A
     D pXmlIn                          *
     D pCnt                          10i 0
      * vars
     D pIClob          S               *
     D szIClob         S             10i 0
      /free
       pIClob = %ADDR(pXmlIn);
       szIClob = 32000;
       // DebugMe('frog went courtin');
       return iAccMe(pIPC:pCtl:pIClob:szIClob:pCnt:2);
      /end-free
     P                 E

