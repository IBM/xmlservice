     H AlwNull(*UsrCtl) bnddir('QC2LE')   

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
      /copy plugmri_h
      /copy plugbug_h
      /copy plugcli_h
      /copy plugerr_h
      /copy plugile_h
      /copy plugpase_h
      /copy plugcach_h
      /copy plugipc_h
      /copy plugxml_h
      /copy plugperf_h

      *****************************************************
      * Persistent connections (1.8.0)
      *****************************************************
     D PERMAX          c                   const(1024)
     D persis          S             10i 0 inz(0)
     D perdb2          S             10i 0 inz(0)
     d perkey          s             10A   dim(PERMAX)
     d peruid          s             10A   dim(PERMAX)
     d perpwd          s             10A   dim(PERMAX)
     d percon          s             10i 0 dim(PERMAX)
     d perstm          s             10i 0 dim(PERMAX)

      *****************************************************
      * Perform check
      * Not automated yet ... set perfon and a perf rpt
      * will return insetad of your regular data.
      *****************************************************
     D perfon          S              1N   inz(*OFF)
     D perfgo          S              1N   inz(*OFF)
     D perffly         S           1024A   inz(' *fly *here')
     D reportb         S           2048A   inz(*BLANKS)
     D report          S          32000A   inz(*BLANKS)

      *****************************************************
      * dynamic call
      *****************************************************
     D okCGISym        S              1N   inz(*OFF)
     D pCGISym         S               *   inz(*NULL)
     D AnyDS           ds                  qualified based(Template)
     D   AnyProc                       *   Procptr
     D anyProc         s               *   inz(*NULL)
     D myDS            ds                  likeds(AnyDS) based(anyProc)
     D procPtr         S               *   ProcPtr
     D pMyProc1        Pr            10i 0 ExtProc(procPtr)
     D  pargv1                         *   value

      *****************************************************
      * Apache hacking
      *****************************************************
     D apaHack         PR            10I 0
     D   buf                           *   value

      *****************************************************
      * Decode entries:
      * 'db2='    - CLI database (*LOCAL) 
      * 'uid='    - CLI connect user profile
      * 'pwd='    - CLI connect user password
      * 'ipc='    - XML Toolkit SERVICE IPC (/tmp/ranger)
      * 'ctl='    - control (*debugcgi, see plugipc_h)
      * 'xmlin='  - urlencode("<xml>...requests...")
      * 'xmlout=' - size of output xml buffer
      * 'persis=' - persistent connection  (1.8.0)
      *****************************************************
     D uDB2            c                   const('db2=')
     D uUID            c                   const('uid=')
     D uPWD            c                   const('pwd=')
     D uIPC            c                   const('ipc=')
     D uCTL            c                   const('ctl=')
     D uXMLIN          c                   const('xmlin=')
     D uXMLOUT         c                   const('xmlout=')
     D uPERSIS         c                   const('persis=')

     D uDEBUGCGI       c                   const('*debugcgi')

     D uBLOCKSZ        c                   const(32766)
     DuRec_t           ds                  qualified based(Template)
     D  cIOver                    32766a
     D  cIChar                        1a   overlay(cIOver)
     D  c2Char                        2a   overlay(cIOver)
     D  c3Char                        3a   overlay(cIOver)

      *****************************************************
      * REST web
      *****************************************************
     D RUN_CGI_NADA...
     D                 C                   const(-1)
     D RUN_CGI_COPYIN...
     D                 C                   const(0)
     D RUN_CGI_CHECK_DEBUG...
     D                 C                   const(1)
     D RUN_CGI_PARMS_PARSE...
     D                 C                   const(2)
     D RUN_CGI_SECURITY...
     D                 C                   const(3)
     D RUN_CGI_RUN...
     D                 C                   const(4)
     D RUN_CGI_OUTPUT...
     D                 C                   const(5)

     D RUN_CGI_ERROR...
     D                 C                   const(98)
     D RUN_CGI_FINISH...
     D                 C                   const(99)

     D CRLFold         c                   x'0d25'
     D CRLF            c                   x'15'
     D NULLTERM        c                   x'00'

     D rc              S              1N   inz(*OFF)
     D rn              S             10i 0 inz(0)

     D xDB2            s             10A   inz(*BLANKS)
     D xUID            s             10A   inz(*BLANKS)
     D xPWD            s             10A   inz(*BLANKS)
     D xIPC            s           1024A   inz(*BLANKS)
     D xCtl            s           1024A   inz(*BLANKS)
     D xSize           s           1024A   inz(*BLANKS)
     D xPersis         s             10A   inz(*BLANKS)

     D pTmp            S               *   inz(*NULL)
     D pTmpSz          S             10i 0 inz(0)

     D runMemP         S               *   inz(*NULL)
     D ipcCtl          DS                  likeds(ipcRec_t) based(runMemP)

     D pIClobIdx       S             10i 0 inz(0)
     D pIClobOrg       S               *   inz(*NULL)
     D pIClob          S               *   inz(*NULL)
     D szIClob         S             10i 0 inz(0)
     D szIBlock        S             10i 0 inz(0)

     D pOClobIdx       S             10i 0 inz(0)
     D pOClobOrg       S               *   inz(*NULL)
     D pOClob          S               *   inz(*NULL)
     D szOClob         S             10i 0 inz(0)
     D szOBlock        S             10i 0 inz(0)

     D rMethod         s             32A   inz(*BLANKS)

     D respHead        s             80A   inz(*BLANKS)
     D respChar        s           1024A   inz(*BLANKS)

     D status          s             10i 0 inz(RUN_CGI_NADA)
     D runExcp         s              1N   inz(*OFF)

     D cgiStatic       PR

     D restData        PR             1N 

     D toHex           PR             1A 
     D  nbr                          10i 0   value

     D xltEBC1         PR            10i 0
     D  where                          *   value
     D  size                         10i 0 value

     D rmvPlus         PR            10i 0
     D  where                          *   value
     D  size                         10i 0 value

     D setIPC          PR

     D newBlockIn      PR              *
     D  size                         10i 0 value

     D newBlockOut     PR              *
     D  size                         10i 0 value

     D scanBlock       PR            10i 0
     D  search                       20A   value
     D  start                        10i 0 value
     D  where                          *

     D findBlock       PR             1N
     D  search                       20A   value

     D chopBlock       PR           128A
     D  search                       20A   value

     D markBlock       PR              *
     D  search                       20A   value

     D runXMLServ      PR             1N
     D  mDB2                         10A   value
     D  mUID                         10A   value
     D  mPWD                         10A   value
     D  mIPC                       1024A   value
     D  mCtl                       1024A   value
     D  mIClob                         *   value
     D  mzIClob                      10i 0 value
     D  mOClob                         *   value
     D  mzOClob                      10i 0 value

      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *++++++++++++++++++++++++++++++++++++++++++++++++++++
      /free
       // --------------
       // main loop
       Monitor;

       select;

       // --------------
       // start
       when status = RUN_CGI_NADA;
         status = RUN_CGI_ERROR;
         if perfon = *ON and perfgo = *OFF;
           perfScan(perffly);
           perfgo = *ON;
         endif;
         cgiStatic();
         setIPC();
         status = RUN_CGI_COPYIN;
         perfAdd(PERF_RUN_CGI_NADA);

       // --------------
       // REST data
       when status = RUN_CGI_COPYIN;
         status = RUN_CGI_ERROR;
         rc = restData();
         if rc = *ON;
           status = RUN_CGI_CHECK_DEBUG;
         endif;
         perfAdd(PERF_RUN_CGI_COPYIN);

       // --------------
       // *debugcgi
       // wait for debug zzzz...
       when status = RUN_CGI_CHECK_DEBUG;
         status = RUN_CGI_ERROR;
         if findBlock(uDEBUGCGI) = *ON;
           DebugMe(DEBUG_ME_CGI);
         endif;
         status = RUN_CGI_PARMS_PARSE;
         perfAdd(PERF_RUN_CGI_CHECK_DEBUG);

       // --------------
       // parms
       // db2=xxxx&
       // uid=xxxx&
       // pwd=xxxx&
       // ipc=xxxx&
       // ctl=xxxx&
       // xmlin=xxxx&
       // xmlout=nnnn&
       // persis=nnnn&
       when status = RUN_CGI_PARMS_PARSE;
         status = RUN_CGI_ERROR;
         xDB2 = chopBlock(uDB2);
         xUID = chopBlock(uUID);
         if xUID = *BLANKS;
           xUID = '*NONE';
         endif;
         xPWD = chopBlock(uPWD);
         if xUID = *BLANKS;
           xUID = '*NONE';
         endif;
         xIPC = chopBlock(uIPC);
         xCtl = chopBlock(uCTL);

         // persis
         xPersis = chopBlock(uPERSIS);
         if xPersis = *BLANKS;
           xPersis = '*NONE';
         else;
           persis = 1;
         endif;

         // true output size
         xSize = chopBlock(uXMLOUT);
         if xSize = *BLANKS;
           xSize = '512000';
         endif;
         pTmpSz = %int(xSize);
         pTmp = newBlockOut(pTmpSz);

         // actual XML input location and size
         // (xmlin= must be last chunk chopped)
         pIClob = markBlock(uXMLIN);
         if pIClob <> *NULL;
           szIClob = strlen(pIClob);
         endif;

         if pIClob = *NULL or pOClob = *NULL;
           errsSevere(XMLCGI_ERROR_NONE_INVALID:XMLCGI_MSG_NO_XML);
         else;
           status = RUN_CGI_SECURITY;
         endif;
         perfAdd(PERF_RUN_CGI_PARMS_PARSE);

       // --------------
       // HEY - custom hook (plugconfx)
       when status = RUN_CGI_SECURITY;
         status = RUN_CGI_ERROR;
         rc = confCGI(
                xDB2:xUID:xPWD:
                xIPC:xCtl:
                pIClob:szIClob:
                pOClob:szOClob);
         // all ok?
         if rc =*ON;
           status = RUN_CGI_RUN;
         endif;
         perfAdd(PERF_RUN_CGI_SECURITY);

       // --------------
       // run
       when status = RUN_CGI_RUN;
         status = RUN_CGI_ERROR;
         rc = runXMLServ(
                xDB2:xUID:xPWD:
                xIPC:xCtl:
                pIClob:szIClob:
                pOClob:szOClob);
         // all ok?
         if rc =*ON;
           status = RUN_CGI_OUTPUT;
         endif;
         perfAdd(PERF_RUN_CGI_RUN);

       // --------------
       // error
       when status = RUN_CGI_ERROR;
         // mmm - always copy ????
         rc = xmlError(*ON:*ON);
         status = RUN_CGI_OUTPUT;
         perfAdd(PERF_RUN_CGI_ERROR);

       // --------------
       // output
       when status = RUN_CGI_OUTPUT;
         // -----
         // send header + end (LFLF)
         // Content-type: text/xml ... windows ok (today)???
         // Content-type: text/plain ... windows maybe???
         // CRLF x'15' ... windows ok (today)???
         // CRLFold x'0d25' ... windows maybe???
         respHead = 'Content-type: text/xml' 
                  + CRLF + CRLF + NULLTERM;
         rn = writeIFS(1:%addr(respHead):strlen(%addr(respHead)));
         // rn = ileErrno();
         // length of return data
         szOClob = strlen(pOClob);
         if perfgo = *ON;
           rc = perfSave(%addr(reportb):%size(reportb));
           report = *BLANKS;
           report = %trim(report) + %trim(xmlGetHead())+x'25';
           report = %trim(report) + '<report>'+x'25';
           xmlPerfRpt(%addr(reportb):report);
           report = %trim(report) + '</report>';
           memset(pOClob:0:szOClob);
           cpybytes(pOClob:%addr(report):%len(%trim(report)));
           szOClob = strlen(pOClob);
           perfgo = *OFF;
           cacClrPrf();
         endif;
         // send return data
         rn = writeIFS(1:pOClob:szOClob);
         // rn = ileErrno();
         // fsync returns -1 errno 3012 (not added)
         // rn = fsyncIFS(1);
         // rn = ileErrno();
         status = RUN_CGI_FINISH;
         // perfAdd(PERF_RUN_CGI_OUTPUT);

       // --------------
       // finish
       when status = RUN_CGI_FINISH;
         // all values default
         // cgiStatic(); (1.8.0)
         // leave the program
         status = RUN_CGI_NADA;
         // perfAdd(PERF_RUN_CGI_FINISH);
         return;

       // --------------
       // ???
       other;
         DebugMe(DEBUG_ME_CGI);
         status = RUN_CGI_ERROR;
       endsl;

       // ------------
       // exception
       On-error;
         status = RUN_CGI_ERROR;
         if runExcp = *ON;
           status = RUN_CGI_NADA;
           return;
         endif;
         runExcp = *ON;
       Endmon;


      /end-free

      *****************************************************
      * rc = cgiStatic()
      * return (NA)
      *****************************************************
     P cgiStatic       B
     D cgiStatic       PI
      /free
       xDB2 = *BLANKS;
       xUID = *BLANKS;
       xPWD = *BLANKS;
       xIPC = *BLANKS;
       xCtl = *BLANKS;
       xSize = *BLANKS;
       xPersis = *BLANKS;

       pIClobIdx = 0;
       pIClobOrg = *NULL;
       pIClob = *NULL;
       szIClob = 0;
       szIBlock = 0;

       pOClobIdx = 0;
       pOClobOrg = *NULL;
       pOClob = *NULL;
       szOClob = 0;
       szOBlock = 0;

       rMethod = *BLANKS;

       respHead = *BLANKS;
       respChar = *BLANKS;

       status = RUN_CGI_NADA;
       runExcp = *OFF;

       cacStatic(CAC_LEVEL_ALL);

      /end-free
     P                 E


      *****************************************************
      * dynamic call fix SAV/RST issue QHTTPSVR/QZSRCORE
      *****************************************************
     P apaHack         B
     D apaHack         PI            10I 0
     D   buf                           *   value
      * vars
     d rc              s             10i 0 inz(-1)
     d rcb             s              1N   inz(*OFF)
     D mypgm           S             10A   inz(*BLANKS)
     D mylib           S             10A   inz(*BLANKS)
     D myfunc          S            128A   inz(*BLANKS)

     D pTop1           S               *   inz(*NULL)
      /free
       Monitor;

       // anything at all?? (1.8.0)
       pTop1 = strchr(buf:x'6C');
       if pTop1 = *NULL;
         perfAdd(PERF_RUN_CGI_COPYIN_HACK);
         return 1;
       endif;

       if okCGISym = *OFF;
         mypgm = 'QZSRCORE';
         mylib = 'QHTTPSVR';
         myfunc = 'ebcdic_unescape_url';

         rcb = ileRslv(mypgm:mylib:pCGISym:myfunc);
         if rcb = *OFF;
           return rc;
         endif;

         anyProc = %addr(pCGISym);
         procPtr = myDS.AnyProc;

         okCGISym = *ON;
       endif;

       rc = pMyProc1(buf);

       On-error;
         errsSevere(QP2_ERROR_ILECALL_FAIL:myfunc);
       Endmon;

       perfAdd(PERF_RUN_CGI_COPYIN_HACK);
       return rc;
      /end-free
     P                 E



      *****************************************************
      * rc = restData()
      * return (*ON=good, *OFF=bad)
      *****************************************************
     P restData        B
     D restData        PI             1N 
      * vars
     D rCopy           s               *   inz(*NULL)
     D rContent        s             32A   inz(*BLANKS)
     D isMIXED         s             20A   inz('MIXED')
     D pos             S             10i 0 inz(999)
     D rMode           s               *   inz(*NULL)
     D rModeType       s             64A   inz(*BLANKS)
     D zero            S              1N   inz(*OFF)
     D rSz             S             10i 0 inz(0)
     D pContent        S               *   inz(*NULL)
     D szContent       S             10i 0 inz(0)
     D rTot            S             10i 0 inz(0)
     D pOver           S               *   inz(*NULL)
     D uOver           ds                  likeds(uRec_t) based(pOver)
     D i               S             10i 0 inz(0)
      /free
       rCopy = getenv('REQUEST_METHOD');
       rMethod = %str(rCopy:strlen(rCopy));
       if rMethod='POST';
         rCopy = getenv('CONTENT_LENGTH');
         rContent = %str(rCopy:strlen(rCopy));
         szContent= %int(rContent);
         pContent = newBlockIn(szContent);
         // -----
         // read from stdin (Apache)
         rTot = 0;
         rSz = 1;
         dou rTot >= szContent or rSz <= 0;
           rSz = readIFS(0:pContent+rTot:szContent-rTot);
           rTot += rSz;
         enddo;
       elseif rMethod='GET';
         rCopy = getenv('QUERY_STRING');
         szContent= strlen(rCopy);
         pContent = newBlockIn(szContent);
         cpybytes(pContent:rCopy:szContent);
       endif;
       perfAdd(PERF_RUN_CGI_COPYIN_MEMORY);
       // conversion
       if pContent <> *NULL;
         // add & to end for easy parsing
         pOver = pContent;
         rn = strlen(pOver);
         pOver = pIClobOrg + rn;
         uOver.cIChar = '&';
         szContent = strlen(pContent);
         // moved remove marker '+' 1st safely (1.8.0)
         // content included '+' will be encoded 
         // <query>SELECT 1 + 1 ... </query>
         rn = rmvPlus(pContent:szContent);
         if rn < 0;
           errsSevere(XMLCGI_ERROR_INTERNAL:
             '0) rmvPlus '+%char(rn));
           return *OFF;
         endif;
         // what sort of unescape junk happened?
         // %%MIXED%%, %%EBCDIC%%, 
         // %%BINARY%%, %%EBCDIC_JCD%%, - not supported
         rMode = getenv('CGI_MODE');
         if rMode <> *NULL;
           rModeType = %str(rMode:strlen(rMode));
           pos = %scan(%trim(isMIXED):rModeType);
         endif;
         // %%MIXED%% ASCII unescape (%0A means %25) 
         // actually EBCDIC representing ASCII hex (wow)
         if pos > 0;
           rn = xltEBC1(pContent:szContent);
           if rn < 0;
             errsSevere(XMLCGI_ERROR_INTERNAL:
               '1) xltEBC1 '+%char(rn));
             return *OFF;
           endif;
           rn = apaHack(pContent);
           if rn < 0;
             errsSevere(XMLCGI_ERROR_INTERNAL:
               '2) apaHack '+%char(rn));
             return *OFF;
           endif;
           rn = xltEBC1(pContent:szContent);
           if rn < 0;
             errsSevere(XMLCGI_ERROR_INTERNAL:
               '3) xltEBC1 '+%char(rn));
             return *OFF;
           endif;
           rn = apaHack(pContent);
           if rn < 0;
             errsSevere(XMLCGI_ERROR_INTERNAL:
               '4) apaHack'+%char(rn));
             return *OFF;
           endif;
         // unescape EBCDIC
         else;
           rn = apaHack(pContent);
           if rn < 0;
             errsSevere(XMLCGI_ERROR_INTERNAL:
               '5) apaHack '+%char(rn));
             return *OFF;
           endif;
           rn = xltEBC1(pContent:szContent);
           if rn < 0;
             errsSevere(XMLCGI_ERROR_INTERNAL:
               '6) xltEBC1 '+%char(rn));
             return *OFF;
           endif;
           rn = apaHack(pContent);
           if rn < 0;
             errsSevere(XMLCGI_ERROR_INTERNAL:
               '7) apaHack '+%char(rn));
             return *OFF;
           endif;
         endif;
         return *ON;
       endif;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * rc = rmvPlus(where:size)
      * return (1=good, -1=bad)
      *****************************************************
     P rmvPlus         B
     D rmvPlus         PI            10i 0 
     D  where                          *   value
     D  size                         10i 0 value
      * vars
     D zero            S              1N   inz(*OFF)
     D i               S             10i 0 inz(0)
     D pIOver          S               *   inz(*NULL)
     D uROver          ds                  likeds(uRec_t) based(pIOver)
      /free
       pIOver = where;
       for i = 1 to size;
         if uROver.cIChar = x'00' or zero = *ON;
           zero = *ON;
           uROver.cIChar = x'00';
         elseif uROver.cIChar = x'0D'; // junk
           uROver.cIChar = ' ';
         // @ADC - may lead to errors (fix me)
         elseif uROver.cIChar = '+';   // junk
             uROver.cIChar = ' ';
         endif;
         pIOver += 1;
       endfor;
       perfAdd(PERF_RUN_CGI_COPYIN_PLUS);
       return 1;
      /end-free
     P                 E


      *****************************************************
      * setipc
      * return (void)
      *****************************************************
     P setIPC          B
     D setIPC          PI
      * vars
      /free
         runMemP = ipcStatic(*ON:*BLANKS:*BLANKS
            :pIClob:szIClob:pOClob:szOClob);
         pIClob = ipcCtl.ipcIClobP;
         pIClobOrg = pIClob;
         pOClob = ipcCtl.ipcOClobP;
         pOClobOrg = pOClob;
         szIClob = ipcCtl.ipcIClobSz;
         szOClob = ipcCtl.ipcOClobSz;
         xmlStatic(runMemP);
      /end-free
     P                 E

      *****************************************************
      * rc = newBlockIn(size)
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P newBlockIn      B
     D newBlockIn      PI              *
     D  size                         10i 0 value
      * vars
      /free
       szIBlock = (size / uBLOCKSZ) + 1;
       szIClob = (uBLOCKSZ * (szIBlock + 1));
       cacClrBig(pIClobIdx);
       pIClobIdx = cacAddBig(szIClob:CAC_HEAP_ILE_REUSE);
       pIClobOrg = cacScanBig(pIClobIdx);
       pIClob = pIClobOrg;
       setIPC();
       return pIClobOrg;
      /end-free
     P                 E

      *****************************************************
      * rc = newBlockOut(size)
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P newBlockOut     B
     D newBlockOut     PI              *
     D  size                         10i 0 value
      * vars
      /free
       szOBlock = (size / uBLOCKSZ) + 1;
       szOClob = (uBLOCKSZ * (szOBlock + 1));
       cacClrBig(pOClobIdx);
       pOClobIdx = cacAddBig(szOClob:CAC_HEAP_ILE_REUSE);
       pOClobOrg = cacScanBig(pOClobIdx);
       pOClob = pOClobOrg;
       setIPC();
       return pOClobOrg;
      /end-free
     P                 E

      *****************************************************
      * rc = scanBlock(char:start:where)
      * return (!0=good; 0=bad)
      *****************************************************
     P scanBlock       B
     D scanBlock       PI            10i 0
     D  search                       20A   value
     D  start                        10i 0 value
     D  where                          *
      * vars
     D i               S             10i 0 inz(0)
     D pos             S             10i 0 inz(0)
     D here            S             10i 0 inz(0)
     D len             S             10i 0 inz(0)
     D offset          S             10i 0 inz(0)
     D pIOver          S               *   inz(*NULL)
     D uROver          ds                  likeds(uRec_t) based(piOver)
      /free
       len = %len(%trim(search))-1;
       for i = 1 to szIBlock;
         if here + uBLOCKSZ > start;
           if start > here;
             offset = start - here;
           else;
             offset = 0;
           endif;
           pIOver = pIClobOrg + (i-1) * uBLOCKSZ + offset;
           pos = %scan(%trim(search):uROver.cIOver);
           if pos > 0;
             where = pIClobOrg + here + pos + len + offset;
             return here + pos + len + offset;
           endif;
         endif;
         here += uBLOCKSZ;
       endfor;
       where = *NULL;
       return 0;
      /end-free
     P                 E

      *****************************************************
      * rc = findBlock(search)
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P findBlock       B
     D findBlock       PI             1N
     D  search                       20A   value
      * vars
     D pos             S             10i 0 inz(0)
     D pIOver          S               *   inz(*NULL)
     D uROver          ds                  likeds(uRec_t) based(piOver)
      /free
       pos = scanBlock(search:0:pIOver);
       if pos > 0;
         return *ON;
       endif;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * rc = chopBlock(search)
      * return (!*BLANKS=good; *BLANKS=bad)
      *****************************************************
     P chopBlock       B
     D chopBlock       PI           128A
     D  search                       20A   value
      * vars
     D pos1            S             10i 0 inz(0)
     D pos2            S             10i 0 inz(0)
     D pIOver1         S               *   inz(*NULL)
     D uROver1         ds                  likeds(uRec_t) based(piOver1)
     D pIOver2         S               *   inz(*NULL)
     D uROver2         ds                  likeds(uRec_t) based(piOver2)
      /free
       pos1 = scanBlock(search:0:pIOver1);
       if pos1 > 0;
          pos2 = scanBlock('&':pos1:pIOver2);
          if pos2 > pos1 + 1;
            return %str(pIOver1:pos2-pos1-1);
          endif;
       endif;
       return *BLANKS;
      /end-free
     P                 E

      *****************************************************
      * rc = markBlock(search)
      * return (!*NULL=good; *NULL=bad)
      *****************************************************
     P markBlock       B
     D markBlock       PI              *
     D  search                       20A   value
      * vars
     D rn              S             10i 0 inz(0)
     D size            S             10i 0 inz(0)
     D pos1            S             10i 0 inz(0)
     D pos2            S             10i 0 inz(0)
     D pos3            S             10i 0 inz(0)
     D pIOver1         S               *   inz(*NULL)
     D uROver1         ds                  likeds(uRec_t) based(piOver1)
     D pIOver2         S               *   inz(*NULL)
     D uROver2         ds                  likeds(uRec_t) based(piOver2)
     D pIOver3         S               *   inz(*NULL)
      /free
       pos1 = scanBlock(search:0:pIOver1);
       if pos1 > 0;
          // @ADC 1.9.4 - echo '&fred&'
          size = strlen(pIOver1);
          pos3 = pos1;
          dou pos3 < pos1 or pos3 > pos1 + size;
            pos2 = pos3;
            pIOver2 = pIOver3;
            pos3 = scanBlock('&':pos2 + 1:pIOver3);
          enddo;
          // @ADC 1.9.4 - echo '&fred&'
          if pos2 > pos1 + 1;
            pIOver2 -= 1;
            uROver2.cIChar = NULLTERM;
            size = strlen(pIOver1);
            return pIOver1;
          endif;
       endif;
       return *NULL;
      /end-free
     P                 E


      *****************************************************
      * rc = toHex(0-15)
      * return ('0'-'F'-good, ' '-bad)
      *****************************************************
     P toHex           B
     D toHex           PI             1A 
     D  nbr                          10i 0   value
      /free
       select;
       when nbr = 0;
         return '0';
       when nbr = 1;
         return '1';
       when nbr = 2;
         return '2';
       when nbr = 3;
         return '3';
       when nbr = 4;
         return '4';
       when nbr = 5;
         return '5';
       when nbr = 6;
         return '6';
       when nbr = 7;
         return '7';
       when nbr = 8;
         return '8';
       when nbr = 9;
         return '9';
       when nbr = 10;
         return 'A';
       when nbr = 11;
         return 'B';
       when nbr = 12;
         return 'C';
       when nbr = 13;
         return 'D';
       when nbr = 14;
         return 'E';
       when nbr = 15;
         return 'F';
       other;
       endsl;
       return ' ';
      /end-free
     P                 E

     *****************************************************
      * rc = xltEBC1(where)
      * return (1=good, -1=bad)
      *****************************************************
     P xltEBC1         B
     D xltEBC1         PI            10i 0 
     D  where                          *   value
     D  size                         10i 0 value
      * vars
     D zero            S              1N   inz(*OFF)
     D i               S             10i 0 inz(0)
     D j               S             10i 0 inz(0)
     D k               S             10i 0 inz(0)
     D pIOver          S               *   inz(*NULL)
     D uROver          ds                  likeds(uRec_t) based(pIOver)

     D len             S             10i 0 inz(256)
     DuByte_t          ds                  qualified based(Template)
     D  uNbr                          3u 0 dim(256)

     D ASCESC          s           1024A   inz(*BLANKS)
     D pasc            S               *   inz(%addr(ASCESC))
     D asc             ds                  likeds(uByte_t) based(pasc)
     D asca            s              3A   dim(256)

     D EBCESC          s           1024A   inz(*BLANKS)
     D pebc            S               *   inz(%addr(EBCESC))
     D ebc             ds                  likeds(uByte_t) based(pebc)
     D ebca            s              3A   dim(256)

     D hi              S             10i 0 inz(0)
     D lo              S             10i 0 inz(0)

     D pTop1           S               *   inz(*NULL)
      /free

       // anything at all?? (1.8.0)
       pTop1 = strchr(where:x'6C');
       if ptop1 = *NULL;
         perfAdd(PERF_RUN_CGI_COPYIN_XLATE);
         return 1;
       endif;

       // ascii
       for i = 1 to 16;
         for j = 1 to 16;
           k += 1;
           asc.uNbr(k) = (i-1)*16 + (j-1);
           asca(k) = '%' + toHex(i-1) + toHex(j-1);
         endfor;
       endfor;

       // ebcdic translation of ascii
       // in correct CCSID (i think)
       EBCESC = ASCESC;
       Translate(len:EBCESC:QP2_2_EBCDIC);
       for i = 1 to 256;
         hi = %bitand(ebc.uNbr(i):x'F0');
         hi = hi / 16;
         lo = %bitand(ebc.uNbr(i):x'0F');
         ebca(i) = '%' + toHex(hi) + toHex(lo);
       endfor;

       // replace ascii escape 
       // with ebcdic equivalent
       pIOver = where;
       for i = 1 to size;
         if uROver.cIChar = '%';
           for j = 1 to 256;
             if uROver.c3Char = asca(j);
               uROver.c3Char = ebca(j);
               leave; // leave j loop
             endif;
           endfor;
         endif;
         pIOver += 1;
       endfor;

       perfAdd(PERF_RUN_CGI_COPYIN_XLATE);
       return 1;
      /end-free
     P                 E


      *****************************************************
      * rc = runXMLServ(...)
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P runXMLServ      B
     D runXMLServ      PI             1N
     D  mDB2                         10A   value
     D  mUID                         10A   value
     D  mPWD                         10A   value
     D  mIPC                       1024A   value
     D  mCtl                       1024A   value
     D  mIClob                         *   value
     D  mzIClob                      10i 0 value
     D  mOClob                         *   value
     D  mzOClob                      10i 0 value
      * vars
     D hackSz          S             10I 0 inz(0)
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0) 

     DiTry             S             10I 0 inz(0)
     DiPersis          S             10I 0 inz(0)
     DyPersis          s             10A   inz('*NONE')

     Dhenv             S             10I 0 inz(0)
     Dhdbc             S             10I 0 inz(0)

     DDBName           S             18A   inz(*BLANKS)
     DDBNameP          S               *   INZ(%ADDR(DBName))
     DDBUser           S             10A   inz(*BLANKS)
     DDBUserP          S               *   INZ(%ADDR(DBUser))
     DDBPwd            S             10A   inz(*BLANKS)
     DDBPwdP           S               *   INZ(%ADDR(DBPwd))

     DConnOpt          S              5I 0 inz(0)
     DIslLvl           S             10I 0 inz(0)
     DIslLvlP          S               *   INZ(%ADDR(IslLvl))

     Dhstmt            S             10I 0 inz(0)
     DSQLStm           S            128A   inz(*BLANKS)
     DSQLStmP          S               *   INZ(%ADDR(SQLStm))

     DSQLState         S              6A   inz(*BLANKS)
     DSQLStateP        S               *   INZ(%ADDR(SQLState))
     DSQLCode          S             10I 0 inz(0)
     DSQLMsg           S             71A   inz(*BLANKS)
     DSQLMsgP          S               *   INZ(%ADDR(SQLMsg))
     DMsgLenMax        S              5I 0 inz(0)
     DMsgLen           S              5I 0 inz(0)
     DZeroBin          S            128A   INZ(*ALLX'00')

     DParm1P           S               *   inz(*NULL)
     DParm1Ind         S             10I 0 inz(0) 
     DParm1IndP        S               *   inz(%addr(Parm1Ind))
     DParm1Mark        S             10I 0 inz(0)
     DParm1IO          S              5I 0 inz(0)
     DParm1CType       S              5I 0 inz(0)
     DParm1DType       S              5I 0 inz(0)
     DParm1ColSz       S             10I 0 inz(0)
     DParm1DecSz       S              5I 0 inz(0)
     DParm1UnUse       S             10I 0 inz(0)

     DParm2P           S               *   inz(*NULL)
     DParm2Ind         S             10I 0 inz(0) 
     DParm2IndP        S               *   inz(%addr(Parm2Ind))
     DParm2Mark        S             10I 0 inz(0)
     DParm2IO          S              5I 0 inz(0)
     DParm2CType       S              5I 0 inz(0)
     DParm2DType       S              5I 0 inz(0)
     DParm2ColSz       S             10I 0 inz(0)
     DParm2DecSz       S              5I 0 inz(0)
     DParm2UnUse       S             10I 0 inz(0)

     DParm3P           S               *   inz(*NULL)
     DParm3Ind         S             10I 0 inz(0) 
     DParm3IndP        S               *   inz(%addr(Parm3Ind))
     DParm3Mark        S             10I 0 inz(0)
     DParm3IO          S              5I 0 inz(0)
     DParm3CType       S              5I 0 inz(0)
     DParm3DType       S              5I 0 inz(0)
     DParm3ColSz       S             10I 0 inz(0)
     DParm3DecSz       S              5I 0 inz(0)
     DParm3UnUse       S             10I 0 inz(0)

     DParm4P           S               *   inz(*NULL)
     DParm4Ind         S             10I 0 inz(0) 
     DParm4IndP        S               *   inz(%addr(Parm4Ind))
     DParm4Mark        S             10I 0 inz(0)
     DParm4IO          S              5I 0 inz(0)
     DParm4CType       S              5I 0 inz(0)
     DParm4DType       S              5I 0 inz(0)
     DParm4ColSz       S             10I 0 inz(0)
     DParm4DecSz       S              5I 0 inz(0)
     DParm4UnUse       S             10I 0 inz(0)

      * env attr server mode
     DSQLAttr          S             10I 0 INZ(DB2_TRUE)
     DSQLAttrP         S               *   INZ(%ADDR(SQLAttr))
      /free
       // *NONE not allowed
       if confNoneOk() = *OFF and mUID = '*NONE';
         errsSevere(XMLCGI_ERROR_NONE_INVALID:mUID);
         return *OFF;
       endif;

       // persistent connection (retry)
       for iTry = 1 to 2; 

       // CLI SQL
       DB2_RC=db2AllocEnv(henv);

       if perdb2 = 0;
         // server mode (QSQ jobs)
         DB2_RC=db2SetEnvAttr(henv:DB2_ATTR_SERVER_MODE:SQLAttrP:0);
         // persistent connection
         if persis = 1;
           perdb2 = 1;
         endif;
       endif;

       // persistent connection
       if DB2_RC = 0 and xPersis <> '*NONE' and perdb2 = 1;
         for iPersis = 1 to PERMAX;
           if xPersis = perkey(iPersis);
             if peruid(iPersis) = xUID and perpwd(iPersis) = xPWD;
               hdbc = percon(iPersis);
               hstmt = perstm(iPersis);
               yPersis = '*FOUND';
             endif;
             leave;
           endif;
         endfor;
       endif;

       // allocate connect
       if DB2_RC = 0 and hdbc = 0;
         DB2_RC=db2AllocConnect(henv:hdbc);
       endif;

       // make connection
       if mUID <> '*NONE';
         if DB2_RC = 0 and yPersis <> '*FOUND';
           DBName = mDB2;
           DBName = (%TRIM(DBName)) + Zerobin;
           DBUser = mUID;
           DBUser = (%TRIM(DBUser)) + Zerobin;
           DBPwd = mPWD;
           DBPwd = (%TRIM(DBPwd)) + Zerobin;
           DB2_RC=db2Connect(hdbc:DBNameP:DB2_NTS:
              DBUserP:DB2_NTS:DBPwdP:DB2_NTS);
         endif;
       else;
         if DB2_RC = 0 and yPersis <> '*FOUND';
           DB2_RC=db2Connect(hdbc:
                           *NULL:0:
                           *NULL:0:
                           *NULL:0);
         endif;
       endif;
       // allocate statement
       if DB2_RC = 0 and yPersis <> '*FOUND';
         DB2_RC=db2AllocStmt(hdbc: hstmt);
       endif;
       // prepare statement
       if DB2_RC = 0 and yPersis <> '*FOUND';
         SQLStm = confCALLSP();
         select;
         when mzOClob<=4096;
           SQLStm = %trim(SQLStm) + PLUG4K;
         when mzOClob>4096 and mzOClob<=32768;
           SQLStm = %trim(SQLStm) + PLUG32K;
         when mzOClob>32768 and mzOClob<=65536;
           SQLStm = %trim(SQLStm) + PLUG65K;
         when mzOClob>65536 and mzOClob<=524288;
           SQLStm = %trim(SQLStm) + PLUG512K;
         when mzOClob>524288 and mzOClob<=1048576;
           SQLStm = %trim(SQLStm) + PLUG1M;
         when mzOClob>1048576 and mzOClob<=5242880;
           SQLStm = %trim(SQLStm) + PLUG5M;
         when mzOClob>5242880 and mzOClob<=10485760;
           SQLStm = %trim(SQLStm) + PLUG10M;
         when mzOClob>10485760;
           SQLStm = %trim(SQLStm) + PLUG15M;
         other;
           SQLStm = %trim(SQLStm) + PLUG32K;
         endsl;
         SQLStm = (%TRIM(SQLStm)) + Zerobin;
         DB2_RC = db2Prepare(hstmt:SQLStmP:DB2_NTS);
       endif;
       // bind parm1: ipc
       if DB2_RC = 0;
         Parm1Mark  = 1;
         Parm1IO    = DB2_PARAM_INPUT;
         Parm1CType = DB2_CHAR;
         Parm1DType = DB2_CHAR;
         Parm1ColSz = %size(mIPC);
         Parm1DecSz = 0;
         Parm1P     = %ADDR(mIPC);
         Parm1UnUse = 0;
         Parm1Ind   = %size(mIPC);
         DB2_RC = db2BindParameter(hstmt:Parm1Mark:Parm1IO
                   :Parm1CType:Parm1DType:Parm1ColSz
                   :Parm1DecSz:Parm1P:Parm1UnUse:Parm1IndP);
       endif;
       // bind parm2: ctl
       if DB2_RC    = 0;
         Parm2Mark  = 2;
         Parm2IO    = DB2_PARAM_INPUT;
         Parm2CType = DB2_CHAR;
         Parm2DType = DB2_CHAR;
         Parm2ColSz = %size(mCtl);
         Parm2DecSz = 0;
         Parm2P     = %ADDR(mCtl);
         Parm2UnUse = 0;
         Parm2Ind   = %size(mCtl);
         DB2_RC = db2BindParameter(hstmt:Parm2Mark:Parm2IO
                   :Parm2CType:Parm2DType:Parm2ColSz
                   :Parm2DecSz:Parm2P:Parm2UnUse:Parm2IndP);
       endif;
       // bind parm3: xmlin
       if DB2_RC    = 0;
         Parm3Mark  = 3;
         Parm3IO    = DB2_PARAM_INPUT;
         Parm3CType = DB2_CHAR;
         Parm3DType = DB2_CHAR;
         Parm3ColSz = mzIClob;
         Parm3DecSz = 0;
         Parm3P     = mIClob;
         Parm3UnUse = 0;
         Parm3Ind   = mzIClob;
         DB2_RC = db2BindParameter(hstmt:Parm3Mark:Parm3IO
                   :Parm3CType:Parm3DType:Parm3ColSz
                   :Parm3DecSz:Parm3P:Parm3UnUse:Parm3IndP);
       endif;
       // bind parm4: xmlout
       if DB2_RC = 0;
         Parm4Mark  = 4;
         Parm4IO    = DB2_PARAM_OUTPUT;
         Parm4CType = DB2_CHAR;
         Parm4DType = DB2_CHAR;
         Parm4ColSz = mzOClob;
         Parm4DecSz = 0;
         Parm4P     = mOClob;
         Parm4UnUse = 0;
         Parm4Ind   = mzOClob;
         DB2_RC = db2BindParameter(hstmt:Parm4Mark:Parm4IO
                   :Parm4CType:Parm4DType:Parm4ColSz
                   :Parm4DecSz:Parm4P:Parm4UnUse:Parm4IndP);
       endif;

       // persistent connection
       if DB2_RC = 0 and yPersis <> '*FOUND' 
       and xPersis <> '*NONE' and perdb2 = 1;
         for iPersis = 1 to PERMAX;
           if perkey(iPersis) = *BLANKS;
             perkey(iPersis) = xPersis;
             peruid(iPersis) = xUID;
             perpwd(iPersis) = xPWD;
             percon(iPersis) = hdbc;
             perstm(iPersis) = hstmt;
             yPersis = '*NEW';
             leave;
           endif;
         endfor;
       endif;

       perfAdd(PERF_RUN_CGI_DB2_PREPARE);

       // execute statement
       if DB2_RC = 0;
         DB2_RC=db2Execute(hstmt);
       endif;

       perfAdd(PERF_RUN_CGI_DB2_EXECUTE);

       // mmm ... odd sometimes output here
       hackSz = strlen(mOClob);
       if hackSz > 0;
         DB2_RC = 0;
       endif;
       
       // errors
       if DB2_RC <> 0;
         MsgLenMax=71;
         DB2_RC1=db2Error(henv:hdbc:hstmt:SQLStateP:
                       SQLCode:SQLMsgP:MsgLenMax:MsgLen);
         errsSevere(XMLCGI_ERROR_INTERNAL: 'rc '+%char(DB2_RC)
                                          +'isz '+%char(mzIClob)
                                          +'osz '+%char(mzOClob)
                                          +'hsz '+%char(hackSz));
         errsSevere(XMLCGI_ERROR_INTERNAL: '1) id '+%char(Parm1Ind)
                                          +'mk '+%char(Parm1Mark)
                                          +'i0 '+%char(Parm1IO)
                                          +'ct '+%char(Parm1CType)
                                          +'dt '+%char(Parm1DType)
                                          +'cs '+%char(Parm1ColSz)
                                          +'ds '+%char(Parm1DecSz)
                                          +'un '+%char(Parm1UnUse));
         errsSevere(XMLCGI_ERROR_INTERNAL: '2) id '+%char(Parm2Ind)
                                          +'mk '+%char(Parm2Mark)
                                          +'i0 '+%char(Parm2IO)
                                          +'ct '+%char(Parm2CType)
                                          +'dt '+%char(Parm2DType)
                                          +'cs '+%char(Parm2ColSz)
                                          +'ds '+%char(Parm2DecSz)
                                          +'un '+%char(Parm2UnUse));
         errsSevere(XMLCGI_ERROR_INTERNAL: '3) id '+%char(Parm3Ind)
                                          +'mk '+%char(Parm3Mark)
                                          +'i0 '+%char(Parm3IO)
                                          +'ct '+%char(Parm3CType)
                                          +'dt '+%char(Parm3DType)
                                          +'cs '+%char(Parm3ColSz)
                                          +'ds '+%char(Parm3DecSz)
                                          +'un '+%char(Parm3UnUse));
         errsSevere(XMLCGI_ERROR_INTERNAL: '4) id '+%char(Parm4Ind)
                                          +'mk '+%char(Parm4Mark)
                                          +'i0 '+%char(Parm4IO)
                                          +'ct '+%char(Parm4CType)
                                          +'dt '+%char(Parm4DType)
                                          +'cs '+%char(Parm4ColSz)
                                          +'ds '+%char(Parm4DecSz)
                                          +'un '+%char(Parm4UnUse));
         errsSevere(XMLCGI_ERROR_INTERNAL: 'db '+%trim(mDB2)
                                          +'uid '+%trim(mUID)
                                          +'ipc '+%trim(mIPC));
         errsSevere(XMLCGI_ERROR_INTERNAL:%trim(SQLState)
                                          +':'+%char(SQLCode)
                                          +':'+SQLMsg);
       endif;

       // remove all resources

       // persistent connection found or created
       if yPersis = '*FOUND' or yPersis = '*NEW';
         // internal error persistent connection (retry)
         if DB2_RC <> 0;
           perkey(iPersis) = *BLANKS;
           peruid(iPersis) = *BLANKS;
           perpwd(iPersis) = *BLANKS;
           percon(iPersis) = 0;
           perstm(iPersis) = 0;
           yPersis = '*NONE';
         // do nothing connection persistent
         else;
           hdbc = 0;
           hstmt = 0;
           iTry = 99;
         endif;
       else;
         iTry = 99;
       endif;

       // free DB2 statement
       if hstmt <> 0;
         DB2_RC1=db2FreeStm(hstmt: DB2_DROP);
       endif;

       // free DB2 connection
       if hdbc <> 0;
         DB2_RC1=db2Disconnect(hdbc);
         DB2_RC1=db2FreeConnect(hdbc);
       endif;

       // do nothing using connection persistent
       if perdb2 = 1;
         henv = 0;
       endif;

       // free DB2 env
       if henv <> 0;
         DB2_RC1=db2FreeEnv(henv);
       endif;

       perfAdd(PERF_RUN_CGI_DB2_FREE);

       // persistent connection (retry)
       endfor;

       // result
       if DB2_RC <> 0;
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E


