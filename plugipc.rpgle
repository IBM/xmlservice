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
      /copy plugipc_h
      /copy plugile_h
      /copy plugerr_h
      /copy plugsig_h
      /copy plugpase_h
      /copy plugxml_h
      /copy plugcach_h
      /copy plugconv_h
      /copy plugperf_h
      /copy plugbug_h
      /copy plugsql_h
      /copy plugperf_h

      *****************************************************
      * ipc globals
      *****************************************************
      * semaphores
     D ipcSemKey       S             10i 0 inz(-1)
     D ipcSemRet       s             10i 0 inz(-1)
     D ipcSemSet       ds                  likeds(sembuf_t) dim(NUMSEMS)
      * shared memory
     D ipcShmKey       S             10i 0 inz(-1)
     D ipcShmId        S             10i 0 inz(-1)
     D ipcShmAddr      S               *   inz(*NULL)

     D ipcIsHere       S              1N   inz(*OFF)
     D sUsrSbmJob      s           4096A   inz(*BLANKS)

     D ipcHereCtl      DS                  likeds(ipcRec_t)
     D ipcHereFlg      s           1024A   inz(*BLANKS)
     D ipcHereIn       s           4096A   inz(*BLANKS)
     D ipcHereOut      s           4096A   inz(*BLANKS)
     D ipcPathBlk      S           1024A   inz(*BLANKS)
     D ipcPathNull     S           1024A   inz(*BLANKS)
     D ipcFileTmp      S           1024A   inz(*BLANKS)

     D ipcCtlP         S               *   inz(*NULL)
     D ipcCtl          DS                  likeds(ipcRec_t) based(ipcCtlP)
     D ipcDoFlagP      s               *   inz(*NULL)
     D ipcDoFlags      ds                  likeds(doRec_t) based(ipcDoFlagP)

      *****************************************************
      * IPC misc
      *****************************************************
     D ipcCtlScan      PR             1N
     D   pSearch                   1024A   value
     D   doCtl                     1024A

     D ipcRmvNow       PR             1N

     D ipcMemClr       PR

     D ipcBoilWater...
     D                 PR

     D ipcOwnFix       PR
     D   jobCtlP                       *   value

     D ipcSafe         PR

      *****************************************************
      * IPC locking
      *****************************************************
     D IPC_WAIT_OK...
     D                 C                   const(0)
     D IPC_WAIT_USE...
     D                 C                   const(-1)
     D IPC_WAIT_WAKE...
     D                 C                   const(1)

     D ipcUse          PR             1N
     D   talkIPC                     10i 0 value
     D   talkClient                  10i 0 value
     D   talkServer                  10i 0 value
     
     
      *****************************************************
      * set ipc safe (1.7.4)
      * return (NA)
      *****************************************************
     P ipcSafe         B
     D ipcSafe         PI
      * vars
     d rc              s              1N   inz(*OFF)
      /free
       Monitor;
         // check IPC ok
         rc = ipcCtl.ipcReadyGo;
       On-error;
         // local IPC until attached (here) 
         ipcCtlP    = %ADDR(ipcHereCtl);
         ipcDoFlagP = %ADDR(ipcCtl.ipcFlags);
       Endmon;
      /end-free
     P                 E
     

      *****************************************************
      * set global
      * return (NA)
      *****************************************************
     P ipcStatic       B                   export
     D ipcStatic       PI              *
     D   reDo                         1N   value
     D   pIPCSP                    1024A   value
     D   pCtlSP                    1024A   value
     D   pIClob                        *   value
     D   szIClob                     10i 0 value
     D   pOClob                        *   value
     D   szOClob                     10i 0 value
      * vars
     D i               s             10i 0 inz(0)
     D j               s             10i 0 inz(0)
     D search          s              1A   inz('/')
     D pos             S             10i 0 inz(0)
     D szIPC           s             10i 0 inz(0)
      * vars
     D doCtl2          s           1024A   inz(*BLANKS)
     D pTop            s               *   inz(*NULL)
     D pBeg            s               *   inz(*NULL)
     D pLst            s               *   inz(*NULL)
     D len             s             10i 0 inz(0)
     D count           s             10i 0 inz(0)
     D doNbr           s             10i 0 dim(XMLMAXATTR) inz(-1)
     D doChar          s             64A   dim(XMLMAXATTR) inz(*BLANKS)
     D doCallx         s              1N   inz(*OFF)
     D doCallx1        s              1N   inz(*OFF)
     D doCallx2        s              1N   inz(*OFF)
     D doTestx         s              1N   inz(*OFF)
      /free
       // kill any previous test run
       ileDoTest(*ON);

       // force initialization
       if reDo = *ON;
         ipcCtlP = *NULL;
       endif;
       // where is ipcCtl?
       if ipcCtlP <> *NULL;
         return ipcCtlP;
       endif;

       perfAdd(PERF_ANY_WATCH_IPCSTATIC:*ON);
       
       // user provided sbmjob
       sUsrSbmJob = *BLANKS;

       // local IPC until attached (here) 
       ipcCtlP    = %ADDR(ipcHereCtl);
       ipcDoFlagP = %ADDR(ipcCtl.ipcFlags);
       // ipcCtl.ipcTmClt = *BLANKS;
       // ipcCtl.ipcTmSrv = *BLANKS;

       // no user buffers, 
       // internal buffer power scotty
       if pIClob = *NULL;
         pIClob = %addr(ipcHereIn);
         szIClob = %size(ipcHereIn);
       endif;
       if pOClob = *NULL;
         pOClob = %addr(ipcHereOut);
         szOClob = %size(ipcHereOut);
       endif;

       // ipc
       ipcPathNull         = %trim(pIPCSP) + x'00';
       szIPC               = strlen(%addr(ipcPathNull));
       if szIPC < 1;
         ipcPathBlk        = *BLANKS;
       else;
         ipcPathBlk        = pIPCSP;
         ipcPathNull       = %trim(pIPCSP) + x'00';
       endif;
       ipcCtl.ipcPathBlk   = ipcPathBlk;
       ipcCtl.ipcPathNull  = ipcPathNull;
       ipcCtl.ipcIClobP    = pIClob;
       ipcCtl.ipcOClobP    = pOClob;
       ipcCtl.ipcIClobSz   = szIClob;
       ipcCtl.ipcOClobSz   = szOClob;
       ipcCtl.ipcPidSrv    = 0;
       ipcCtl.ipcBusyIAm   = *OFF;
       ipcCtl.ipcWaiting   = *OFF;
       ipcCtl.ipcReadyGo   = *OFF;
       ipcCtl.ipcOwnBad    = *OFF;
       ipcCtl.ipcOwnKey    = *BLANKS;

       // user flags
       ipcCtl.ipcFlg       = pCtlSP;

       // set default flags
       ipcDoFlags.doJustProc = *OFF;
       ipcDoFlags.doDebug    = *OFF;
       ipcDoFlags.doDebugProc= *OFF;
       ipcDoFlags.doDebugCGI = *OFF;
       // see plugconf_h settings
       if PLUGSPAWNALLOW = *OFF;
         ipcDoFlags.doNoStart = *ON;
       else;
         ipcDoFlags.doNoStart  = *OFF;
       endif;
       ipcDoFlags.doImmed    = *OFF;
       if szIPC < 1;
         ipcDoFlags.doHere     = *ON;
       else;
         ipcDoFlags.doHere     = *OFF;
       endif;
       ipcDoFlags.doHack     = *OFF;
       ipcDoFlags.doBatch    = *OFF;
       ipcDoFlags.doGet      = *OFF;
       ipcDoFlags.doBatNbr   = 0;
       ipcDoFlags.doRpt      = *OFF;
       ipcDoFlags.doLic      = *OFF;
       ipcDoFlags.doSes      = *OFF;
       ipcDoFlags.doFly      = *OFF;
       ipcDoFlags.doLog      = *OFF;
       ipcDoFlags.doLogKey   = *BLANKS;
       ipcDoFlags.doSbmJob   = *OFF;
       ipcDoFlags.doSbmLib   = *BLANKS;
       ipcDoFlags.doSbmJobd  = *BLANKS;
       ipcDoFlags.doSbmNam   = *BLANKS;
       ipcDoFlags.doSbmAsp   = *BLANKS;
       ipcDoFlags.doOwnEnd   = *OFF;
       ipcDoFlags.doClear    = *OFF;
       ipcDoFlags.doIdle     = *OFF;
       ipcDoFlags.doCall1    = *OFF;
       ipcDoFlags.doCall2    = *OFF;
       ipcDoFlags.doHex      = *OFF;
       ipcDoFlags.doHexAct   = *BLANKS;
       ipcDoFlags.doNoCall   = *OFF;
       ipcDoFlags.doBef      = *OFF;
       ipcDoFlags.doAft      = *OFF;
       ipcDoFlags.doPase     = *OFF;
       ipcDoFlags.doCDATA    = *OFF;
       ipcDoFlags.doJVM      = *OFF;
       ipcDoFlags.doSQLJVM   = *OFF;
       ipcDoFlags.doDbgJVM   = *OFF;
       ipcDoFlags.doIdleAct  = *BLANKS;
       ipcDoFlags.doWaitAct  = *BLANKS;
       ipcDoFlags.doCallAct1 = *BLANKS;
       ipcDoFlags.doCallAct2 = *BLANKS;
       ipcDoFlags.doIdlePerm = *BLANKS;
       ipcDoFlags.doWaitPerm = *BLANKS;
       ipcDoFlags.doCallPerm1= *BLANKS;
       ipcDoFlags.doCallPerm2= *BLANKS;
       ipcDoFlags.doIdleSec  = -42;
       ipcDoFlags.doWaitSec  = -42;
       ipcDoFlags.doCallSec1 = -42;
       ipcDoFlags.doCallSec2 = -42;
       ipcDoFlags.doBefFrom  = -42;
       ipcDoFlags.doBefTo    = -42;
       ipcDoFlags.doAftFrom  = -42;
       ipcDoFlags.doAftTo    = -42;
       ipcDoFlags.doPaseILE  = -42;
       ipcDoFlags.doPasePASE = -42;
       ipcDoFlags.doTest = -42;
       ipcDoFlags.doESCP = *OFF; 

       // parse elements (input)
       len  = %len(%trim(pCtlSP));
       pTop = %addr(pCtlSP);
       pLst = pTop + len;

       // count the '*'s
       pBeg = pTop;
       for i = 1 to XFLAGMAX;
         pBeg = bigScan(pBeg:'*':pLst:*ON);
         if pBeg <> *NULL;
           count += 1;
           pBeg += 1;
         else;
           leave;
         endif;
       endfor;

       // kill immed (return)
       if count > 0;
        pBeg = bigScan(pTop:xIMMED:pLst);
        if pBeg <> *NULL;
          ipcDoFlags.doImmed = *ON;
          count = 0;
        endif;
       endif;

       // ignore all other flags (return)
       if count > 0;
        pBeg = bigScan(pTop:xIGNORE:pLst);
        if pBeg <> *NULL;
          count = 0;
        endif;
       endif;

       // run stateless
       if count > 0;
        pBeg = bigScan(pTop:xHERE:pLst);
        if pBeg <> *NULL;
          ipcDoFlags.doHere = *ON;
          count -= 1;
        endif;
       endif;

       // run cdata
       if count > 0;
        pBeg = bigScan(pTop:xCDATA:pLst);
        if pBeg <> *NULL;
          ipcDoFlags.doCDATA = *ON; // see it means on
          for j = 1 to 1;
            if doChar(j) = 'on';
              ipcDoFlags.doCDATA = *ON;
            elseif doChar(j) = 'off';
              ipcDoFlags.doCDATA = *OFF;
            endif;
          endfor;
          count -= 1;
        endif;
       endif;

       // run jvm normal
       if count > 0;
        pBeg = bigScan(pTop:xJVM:pLst);
        if pBeg <> *NULL;
          ipcDoFlags.doJVM = *ON; // see it means on
          count -= 1;
        endif;
       endif;

       // run jvm SQL (stored procedures)
       if count > 0;
        pBeg = bigScan(pTop:xSQLJVM:pLst);
        if pBeg <> *NULL;
          ipcDoFlags.doJVM = *ON; // see it means on
          ipcDoFlags.doSQLJVM = *ON; // see it means on
          count -= 1;
        endif;
       endif;

       // run jvm (debug)
       if count > 0;
        pBeg = bigScan(pTop:xDBGJVM:pLst);
        if pBeg <> *NULL;
          ipcDoFlags.doJVM = *ON; // see it means on
          ipcDoFlags.doDbgJVM = *ON; // see it means on
          count -= 1;
        endif;
       endif;

       // run hack
       if count > 0;
         pBeg = bigScan(pTop:xHACK:pLst);
         if pBeg <> *NULL;
           ipcDoFlags.doHack = *ON;
           count -= 1;
         endif;
       endif;

       // sbmjob
       if count > 0;
        pBeg = bigScan(pTop:xSBM:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doSbmJob  = bigDimOpt(xSBM:pCtlSP:doChar:doNbr);
         ipcDoFlags.doSbmLib  = doChar(1);
         ipcDoFlags.doSbmJobd = doChar(2);
         ipcDoFlags.doSbmNam  = doChar(3);
         ipcDoFlags.doSbmAsp  = doChar(4);
         // -------------
         // HEY - custom hook (plugconfx)
         if ipcDoFlags.doSbmLib = *BLANKS;
           ipcDoFlags.doSbmLib = confJOBLIB();
         endif;
         if ipcDoFlags.doSbmJobd = *BLANKS;
           ipcDoFlags.doSbmJobd = confJOBD();
         endif;
         if ipcDoFlags.doSbmNam = *BLANKS;
           ipcDoFlags.doSbmNam = confJOBNAM();
         endif;
         if ipcDoFlags.doSbmAsp = *BLANKS;
           ipcDoFlags.doSbmAsp = confJOBASP();
         endif;
         if szIPC < 1;
           ipcDoFlags.doSbmJob  = *OFF;
         endif;
         count -= 1;
        endif;
       endif;

       // idle(seconds/action/duration) (Luca IDLE_TIMEOUT)
       if count > 0;
        pBeg = bigScan(pTop:xIDLE:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doIdle   = bigDimOpt(xIDLE:pCtlSP:doChar:doNbr);
         for j = 1 to 3;
           if doChar(j) = 'busy';
             ipcDoFlags.doIdleAct = SIG_ACTION_BUSY;
           elseif doChar(j) = 'kill';
             ipcDoFlags.doIdleAct = SIG_ACTION_KILL;
           elseif doChar(j) = 'user';
             ipcDoFlags.doIdleAct = SIG_ACTION_USER;
           elseif doChar(j) = 'perm';
             ipcDoFlags.doIdlePerm = SIG_SET_PERM;
           elseif doChar(j) = 'orig';
             ipcDoFlags.doIdlePerm = SIG_SET_ORIG;
           elseif doNbr(j) > -42;
             ipcDoFlags.doIdleSec = doNbr(j);
           endif;
         endfor;
         count -= 1;
        endif;
       endif;

       // before(CCSIDFrom/CCSIDTo[/action])
       if count > 0;
        pBeg = bigScan(pTop:xBEFORE:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doBef   = bigDimOpt(xBEFORE:pCtlSP:doChar:doNbr);
         for j = 1 to 3;
           if doChar(j) = 'call';
             ipcDoFlags.doNoCall = *OFF;
           elseif doChar(j) = 'nocall';
             ipcDoFlags.doNoCall = *ON;
           elseif doNbr(j) > -42;
             if ipcDoFlags.doBefFrom  = -42;
               ipcDoFlags.doBefFrom = doNbr(j);
               ipcDoFlags.doBefTo = 0;
             else;
               ipcDoFlags.doBefTo = doNbr(j);
             endif;
           endif;
         endfor;
         if ipcDoFlags.doBef = *ON and ipcDoFlags.doBefFrom = -42;
           ipcDoFlags.doBefFrom = 0;
           ipcDoFlags.doBefTo = 0;
         endif;
         if ipcDoFlags.doBef = *ON and ipcDoFlags.doBefTo = -42;
           ipcDoFlags.doBefTo = 0;
         endif;
         count -= 1;
        endif;
       endif;

       // after(CCSIDFrom/CCSIDTo)
       if count > 0;
        pBeg = bigScan(pTop:xAFTER:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doAft   = bigDimOpt(xAFTER:pCtlSP:doChar:doNbr);
         for j = 1 to 2;
           if doNbr(j) > -42;
             if ipcDoFlags.doAftFrom  = -42;
               ipcDoFlags.doAftFrom = doNbr(j);
               ipcDoFlags.doAftTo = 0;
             else;
               ipcDoFlags.doAftTo = doNbr(j);
             endif;
           endif;
         endfor;
         if ipcDoFlags.doAft = *ON and ipcDoFlags.doAftFrom = -42;
           ipcDoFlags.doAftFrom = 0;
           ipcDoFlags.doAftTo = 0;
         endif;
         if ipcDoFlags.doAft = *ON and ipcDoFlags.doAftTo = -42;
           ipcDoFlags.doAftTo = 0;
         endif;
         count -= 1;
        endif;
       endif;

       // pase(CCSIDFrom/CCSIDTo)
       if count > 0;
        pBeg = bigScan(pTop:xPASE:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doPase   = bigDimOpt(xPASE:pCtlSP:doChar:doNbr);
         for j = 1 to 2;
           if doNbr(j) > -42;
             if ipcDoFlags.doPasePASE  = -42;
               ipcDoFlags.doPasePASE = doNbr(j);
               ipcDoFlags.doPaseILE = 0;
             else;
               ipcDoFlags.doPaseILE = doNbr(j);
             endif;
           endif;
         endfor;
         if ipcDoFlags.doPase = *ON and ipcDoFlags.doPasePASE = -42;
           ipcDoFlags.doPasePASE = 0;
           ipcDoFlags.doPaseILE = 0;
         endif;
         if ipcDoFlags.doPase = *ON and ipcDoFlags.doPaseILE = -42;
           ipcDoFlags.doPaseILE = 0;
         endif;
         count -= 1;
        endif;
       endif;

       // test(n)
       if count > 0;
        pBeg = bigScan(pTop:xTEST:pLst);
        if pBeg <> *NULL;
         doTestx = bigDimOpt(xTEST:pCtlSP:doChar:doNbr);
         if doTestx = *ON;
           if doNbr(1) > -42;
             ipcDoFlags.doTest = doNbr(1);
           else;
             ipcDoFlags.doTest = 1;
           endif;
         endif;
         count -= 1;
        endif;
       endif;

       // wait(seconds/action/duration) (Luca IDLE_TIMEOUT)
       if count > 0;
        pBeg = bigScan(pTop:xWAIT:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doWait   = bigDimOpt(xWAIT:pCtlSP:doChar:doNbr);
         for j = 1 to 3;
           if doChar(j) = 'busy';
             ipcDoFlags.doWaitAct = SIG_ACTION_BUSY;
           elseif doChar(j) = 'kill';
             ipcDoFlags.doWaitAct = SIG_ACTION_KILL;
           elseif doChar(j) = 'user';
             ipcDoFlags.doWaitAct = SIG_ACTION_USER;
           elseif doChar(j) = 'perm';
             ipcDoFlags.doWaitPerm = SIG_SET_PERM;
           elseif doChar(j) = 'orig';
             ipcDoFlags.doWaitPerm = SIG_SET_ORIG;
           elseif doNbr(j) > -42;
             ipcDoFlags.doWaitSec = doNbr(j);
           endif;
         endfor;
         count -= 1;
        endif;
       endif;

       // call(seconds/action/duration/job) (Luca IDLE_TIMEOUT)
       // ... loop may be 2 *call entries here ...
       if count > 0;
        pBeg = pTop;
        for i = 1 to 2;
         pBeg = bigScan(pBeg:xCALL:pLst);
         if pBeg <> *NULL;
          doCtl2    = %str(pBeg:pLst-pBeg);
          doCallx   = bigDimOpt(xCALL:doCtl2:doChar:doNbr);
          doCallx1  = *OFF;
          doCallx2  = *OFF;
          for j = 1 to 4;
            if doChar(j)     = 'client';
              doCallx1  = *ON;
              ipcDoFlags.doCall1 = doCallx1;
            elseif doChar(j) = 'server';
              doCallx2  = *ON;
              ipcDoFlags.doCall2 = doCallx2;
            endif;
          endfor;
          // both off means both on
          if doCallx1  = *OFF and doCallx2  = *OFF;
            doCallx1  = *ON;
            doCallx2  = *ON;
            ipcDoFlags.doCall1 = doCallx1;
            ipcDoFlags.doCall2 = doCallx2;
          endif;
          for j = 1 to 4;
            if doChar(j)     = 'busy';
              if doCallx1 = *ON;
                ipcDoFlags.doCallAct1 = SIG_ACTION_BUSY;
              endif;
              if doCallx2 = *ON;
                ipcDoFlags.doCallAct2 = SIG_ACTION_BUSY;
              endif;
            elseif doChar(j) = 'kill';
              if doCallx1 = *ON;
                ipcDoFlags.doCallAct1 = SIG_ACTION_KILL;
              endif;
              if doCallx2 = *ON;
                ipcDoFlags.doCallAct2 = SIG_ACTION_KILL;
              endif;
            elseif doChar(j) = 'user';
              if doCallx1 = *ON;
                ipcDoFlags.doCallAct1 = SIG_ACTION_USER;
              endif;
              if doCallx2 = *ON;
                ipcDoFlags.doCallAct2 = SIG_ACTION_USER;
              endif;
            elseif doChar(j) = 'perm';
              if doCallx1 = *ON;
                ipcDoFlags.doCallPerm1 = SIG_SET_PERM;
              endif;
              if doCallx2 = *ON;
                ipcDoFlags.doCallPerm2 = SIG_SET_PERM;
              endif;
            elseif doChar(j) = 'orig';
              if doCallx1 = *ON;
                ipcDoFlags.doCallPerm1 = SIG_SET_ORIG;
              endif;
              if doCallx2 = *ON;
                ipcDoFlags.doCallPerm2 = SIG_SET_ORIG;
              endif;
            elseif doNbr(j)  > -42;
              if doCallx1 = *ON;
                ipcDoFlags.doCallSec1 = doNbr(j);
              endif;
              if doCallx2 = *ON;
                ipcDoFlags.doCallSec2 = doNbr(j);
              endif;
            endif;
          endfor;
          count -= 1;
          if count <= 0;
            leave;
          endif;
          pBeg += 1;
         endif;
        endfor;
       endif;

       // debug stored procedure
       if count > 0;
        pBeg = bigScan(pTop:xDEBUGPROC:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doDebugProc = *ON;
         count -= 1;
        endif;
       endif;

       // debug cgi
       if count > 0;
        pBeg = bigScan(pTop:xDEBUGCGI:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doDebugCGI = *ON;
         count -= 1;
        endif;
       endif;

       // doDebugProc and doDebugCGI handle first
       if count > 0;
        if ipcDoFlags.doDebugProc = *OFF 
        and ipcDoFlags.doDebugCGI = *OFF;
         // debug XMLSERVICE
         pBeg = bigScan(pTop:xDEBUG:pLst);
         if pBeg <> *NULL;
           ipcDoFlags.doDebug = *ON;
           count -= 1;
         endif;
        endif;
       endif;

       // no spawn allowed
       if count > 0;
        pBeg = bigScan(pTop:xNOSTART:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doNoStart = *ON;
         count -= 1;
        endif;
       endif;

       // run hex
       if count > 0;
        pBeg = bigScan(pTop:xHEX:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doHex = *ON;
         for j = 1 to 1;
           if doChar(j) = 'in';
             ipcDoFlags.doHexAct = CONV_HEX_ACTION_INPUT;
           elseif doChar(j) = 'out';
             ipcDoFlags.doHexAct = CONV_HEX_ACTION_OUTPUT;
           elseif doChar(j) = 'both';
             ipcDoFlags.doHexAct = CONV_HEX_ACTION_BOTH;
           endif;
         endfor;
         if ipcDoFlags.doHexAct = *BLANKS;
           ipcDoFlags.doHexAct = CONV_HEX_ACTION_BOTH;
         endif;
         count -= 1;
        endif;
       endif;

       // run batch
       if count > 0;
        pBeg = bigScan(pTop:xBATCH:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doBatch = *ON;
         count -= 1;
        endif;
       endif;

       // run get batch
       if count > 0;
        pBeg = bigScan(pTop:xGET:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doGet    = bigDimOpt(xGET:pCtlSP:doChar:doNbr);
         ipcDoFlags.doBatNbr = doNbr(1);
         if ipcDoFlags.doBatNbr < 0;
           ipcDoFlags.doBatNbr = 0;
         endif;
         count -= 1;
        endif;
       endif;

       // retrieve performance report
       if count > 0;
        pBeg = bigScan(pTop:xRPT:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doRpt = *ON;
         count -= 1;
        endif;
       endif;

       // retrieve IBM license
       if count > 0;
        pBeg = bigScan(pTop:xLIC:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doLic = *ON;
         count -= 1;
        endif;
       endif;

       // retrieve session IPC (/tmp/ranger)
       if count > 0;
        pBeg = bigScan(pTop:xSES:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doSes = *ON;
         count -= 1;
        endif;
       endif;

       // record performance data *ON
       if count > 0;
        pBeg = bigScan(pTop:xDOFLY:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doFly = *ON;
         count -= 1;
        endif;
       endif;
       // record performance data *OFF (default)
       if count > 0;
        pBeg = bigScan(pTop:xNOFLY:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doFly = *OFF;
         count -= 1;
        endif;
       endif;
       
       // log performance data *ON
       if count > 0;
        pBeg = bigScan(pTop:xDOLOG:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doLog = bigDimOpt(xDOLOG:pCtlSP:doChar:doNbr);
         ipcDoFlags.doLogKey = doChar(1);
         count -= 1;
        endif;
       endif;
       // log performance data *OFF (default)
       if count > 0;
        pBeg = bigScan(pTop:xNOLOG:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doLog = *OFF;
         count -= 1;
        endif;
       endif;

       // stored proc test
       if count > 0;
        pBeg = bigScan(pTop:xJUSTPROC:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doJustProc = *ON;
         count -= 1;
        endif;
       endif;

       // clear PGM cache
       if count > 0;
        pBeg = bigScan(pTop:xCLEAR:pLst);
        if pBeg <> *NULL;
         ipcDoFlags.doClear = *ON;
         count -= 1;
        endif;
       endif;

       // Alan request (1.6.8)
       if ipcDoFlags.doHere = *OFF;
         // no IPC (blanks)
         if ipcPathBlk = *BLANKS;
           pos = 0;
         // '/path/ipcname'
         //  x - bad ipc is missing
         else;
           pos = %scan(search:ipcPathBlk);
         endif;
         if pos < 1;
           ipcDoFlags.doHere = *ON;
         endif;
       endif;

       // stateless with no IPC, no lock needed
       if ipcDoFlags.doHere = *ON;
         // debug either way
         if ipcDoFlags.doDebug = *ON;
            ipcDoFlags.doDebugProc = *ON;
            ipcDoFlags.doDebug = *OFF;
         endif;
         // kill either way @ADC -- 2.0.0
         if ipcDoFlags.doCallAct1 = SIG_ACTION_KILL;
           ipcDoFlags.doCallPerm2 = ipcDoFlags.doCallPerm1;
           ipcDoFlags.doCallSec2 = ipcDoFlags.doCallSec1;
           ipcDoFlags.doCallAct2 = ipcDoFlags.doCallAct1;
         endif;
         ipcIsHere = *ON;
       else;
         ipcIsHere = *OFF;
       endif;

       // PASE CCSID conversion
       if ipcDoFlags.doPase = *ON;
         ccsidPASE(ipcDoFlags.doPasePASE);
         ccsidILE(ipcDoFlags.doPaseILE);
       endif;

       // run escape   
       if count > 0;
        pBeg = bigScan(pTop:xESCP:pLst);
        if pBeg <> *NULL;
          ipcDoFlags.doESCP = *ON; // see it means on
          for j = 1 to 1;
            if doChar(j) = 'on';
              ipcDoFlags.doESCP = *ON;
            elseif doChar(j) = 'off';
              ipcDoFlags.doESCP = *OFF;
            endif;
          endfor;
          count -= 1;
        endif;
       endif;

       perfAdd(PERF_ANY_WATCH_IPCSTATIC:*OFF);

       return ipcCtlP;
      /end-free
     P                 E

      *****************************************************
      * set global
      * return (NA)
      *****************************************************
     P ipcCopyIn       B                   export
     D ipcCopyIn       PI              *
     D   reDo                         1N   value
     D   srcMemP                       *   value
      * vars
     D i               s             10i 0 inz(0)
     D memP            S               *   inz(*NULL)
     D memchar         s              1A   based(memP)
     D aCtlP           S               *   inz(*NULL)
     D aCtl            DS                  likeds(ipcRec_t) based(aCtlP)
     D aDoFlagP        s               *   inz(*NULL)
     D aDoFlags        ds                  likeds(doRec_t) based(aDoFlagP)
     D tgtMemP         S               *   inz(*NULL)
      /free
       if ipcShmAddr = *NULL;
         tgtMemP = srcMemP;
       else;
         tgtMemP = ipcShmAddr;
       endif;

       // original data (source)
       aCtlP    = srcMemP;
       aDoFlagP = %ADDR(aCtl.ipcFlags);

       // copy of data (target)
       ipcCtlP    = tgtMemP;
       ipcDoFlagP = %ADDR(ipcCtl.ipcFlags);

       // initialize
       // ipcCtl.ipcTmClt  = aCtl.ipcTmClt;
       // ipcCtl.ipcTmSrv  = aCtl.ipcTmSrv;
       ipcCtl.ipcFlg       = aCtl.ipcFlg;
       ipcCtl.ipcPathBlk   = aCtl.ipcPathBlk;
       ipcCtl.ipcPathNull  = aCtl.ipcPathNull;
       ipcCtl.ipcIClobP    = aCtl.ipcIClobP;
       ipcCtl.ipcOClobP    = aCtl.ipcOClobP;
       ipcCtl.ipcIClobSz   = aCtl.ipcIClobSz;
       ipcCtl.ipcOClobSz   = aCtl.ipcOClobSz;
       // on internal buffer power scotty 
       if ipcCtl.ipcIClobP = *NULL;
         ipcCtl.ipcIClobP = %addr(ipcHereIn);
         ipcCtl.ipcIClobSz = %size(ipcHereIn);
       endif;
       if ipcCtl.ipcOClobP = *NULL;
         ipcCtl.ipcOClobP = %addr(ipcHereOut);
         ipcCtl.ipcOClobSz = %size(ipcHereOut);
       endif;
       // only redo if asked
       if reDo = *ON;
         // mark server pid alive
         ipcCtl.ipcPidSrv = getpid();
       // job own key managed client side
       else;
         ipcCtl.ipcOwnKey   = aCtl.ipcOwnKey;
       endif;
       ipcCtl.ipcBusyIAm   = aCtl.ipcBusyIAm;
       ipcCtl.ipcWaiting   = aCtl.ipcWaiting;
       ipcCtl.ipcOwnBad    = aCtl.ipcOwnBad;
       // set flags
       cpybytes(ipcDoFlagP:aDoFlagP:%size(aDoFlags));
       // only redo if asked
       if reDo = *ON;
         ipcCtl.ipcReadyGo = *ON;
       endif;

       // PASE CCSID conversion
       if ipcDoFlags.doPase = *ON;
         ccsidPASE(ipcDoFlags.doPasePASE);
         ccsidILE(ipcDoFlags.doPaseILE);
       endif;

       return ipcCtlP;
      /end-free
     P                 E

      *****************************************************
      * Flags
      * return (NA)
      *****************************************************
     P ipcDoTest       B                   export
     D ipcDoTest       PI            10i 0
      /free
       if ipcDoFlagP = *NULL; // @ADC 1.7.3
         return -42;
       endif;
       return ipcDoFlags.doTest;
      /end-free
     P                 E

     P ipcDoCDATA      B                   export
     D ipcDoCDATA      PI             1N
      /free
       if ipcDoFlagP = *NULL; // @ADC 1.7.3
         return *ON;
       endif;
       return ipcDoFlags.doCDATA;
      /end-free
     P                 E

     P ipcDoJVM        B                   export
     D ipcDoJVM        PI             1N
      /free
       if ipcDoFlagP = *NULL;
         return *OFF;
       endif;
       return ipcDoFlags.doJVM;
      /end-free
     P                 E

     P ipcDoSQLJVM     B                   export
     D ipcDoSQLJVM     PI             1N
      /free
       if ipcDoFlagP = *NULL;
         return *OFF;
       endif;
       return ipcDoFlags.doSQLJVM;
      /end-free
     P                 E

     P ipcDoDbgJVM     B                   export
     D ipcDoDbgJVM     PI             1N
      /free
       if ipcDoFlagP = *NULL;
         return *OFF;
       endif;
       return ipcDoFlags.doDbgJVM;
      /end-free
     P                 E
     
     P ipcDoLogKey     B                   export
     D ipcDoLogKey     PI            64A
      /free
       if ipcDoFlagP = *NULL; // @ADC 1.7.3
         return log_id();
       endif;
       if ipcDoFlags.doLogKey = *BLANKS;
         ipcDoFlags.doLogKey = log_id();
       endif;
       return ipcDoFlags.doLogKey;
      /end-free
     P                 E

      *****************************************************
      * set global
      * return (NA)
      *****************************************************
     P ipcRunMem       B                   export
     D ipcRunMem       PI              *
      /free
       return ipcCtlP;
      /end-free
     P                 E

      *****************************************************
      * rc = ipcMemClr()
      * return (*ON=good; *OFF=bad)
      * Note:
      * called both client/server, so be careful
      * and delete only memory owned side running.
      *****************************************************
     P ipcMemClr       B
     D ipcMemClr       PI
      * vars
     D runMemP         S               *   inz(*NULL)
      /free
       // reset back to internal IPC
       runMemP = ipcStatic(*OFF:ipcPathBlk:*BLANKS
                          :*NULL:0:*NULL:0);
       // xml caches cleared
       cacStatic(CAC_LEVEL_SQL);  // ADC (1.6.8)
      /end-free
     P                 E


      *****************************************************
      * set global
      * return (NA)
      *****************************************************
     P ipcRunHere      B                   export
     D ipcRunHere      PI             1N
      /free
       return ipcIsHere;
      /end-free
     P                 E

      *****************************************************
      * rc = ipcAlive()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcAlive        B                   export
     D ipcAlive        PI             1N
     D   myErrno                     10i 0
      * vars
     D rcb             s              1N   inz(*ON)
     D rc              S             10i 0 inz(0)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
     d serverPid       s             10i 0 inz(0)
      /free
       myErrno = 0;
       
       // no sbmjob stateless
       if ipcIsHere = *ON;
         if ipcShmAddr = *NULL;
           return *OFF;
         endif;
         return *ON;
       endif;
       if ipcShmAddr = *NULL;
         return *OFF;
       endif;
       bCtlP = ipcShmAddr;

       Monitor;
         serverPid = bCtl.ipcPidSrv;
       On-error;
       Endmon;

       // server pid was 0???
       // something went wrong
       if serverPid = 0;
         errsWarning(IPC_ERROR_ALIVE_PID_FAIL:%char(serverPid));
         return *OFF;
       endif;

       // If sig is 0, then no signal is sent
       // but error checking is still performed.
       // On error, -1 is returned, and errno is set appropriately.
       rc = kill(serverPid:0);
       if rc = -1;
         // check not authorized, forget any additional action
         // EPERM 3027 The operation is not permitted.
         myErrno = ileErrno();
         if myErrno <> 3027;
           rcb = ipcPanic();
         endif;
         errsWarning(IPC_ERROR_ALIVE_FAIL:%char(serverPid));
         return *OFF;
       endif;

       return *ON;
      /end-free
     P                 E
      *****************************************************
      * rc = ipcOwnFix()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcOwnFix       B
     D ipcOwnFix       PI
     D   jobCtlP                       *   value
      * vars
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
      /free
       // no job own stateless
       if ipcIsHere = *ON;
         return;
       endif;
       // fix up key
       bCtlP = jobCtlP;
       pCopy = %addr(bCtl.ipcOwnKey);
       if myCopy.bytex = x'00';
         bCtl.ipcOwnKey = *BLANKS;
       endif;
      /end-free
     P                 E


      *****************************************************
      * rc = ipcOwnUse()
      * return (*ON=good; *OFF=bad)
      * Note:
      * Called IPC belongs to client ...
      *   ipcOwnJob()       
      *   RUN_CLIENT_OWN    -- after shared memory,
      *                        before lock semaphore (ipcLocked = *OFF)
      *                        before ipcCopyIn (ipcCtl local) 
      *                        (quick check no match)
      *
      *   RUN_CLIENT_COPYIN -- after shared memory,
      *                        after lock semaphore (ipcLocked = *ON)
      *                        server copyin allowed
      *                        before ipcCopyIn (ipcCtl local) 
      *                        (slower check exclusive IPC)
      *****************************************************
     P ipcOwnUse       B                   export
     D ipcOwnUse       PI             1N
     D   jobKey                     128A   value
     D   ipcLocked                    1N   value
      * vars
     D rcb             s              1N   inz(*ON)
     D rc              S             10i 0 inz(0)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       // no job own stateless
       if ipcIsHere = *ON;
         return *ON;
       endif;
       // shared memory attached (internal error)
       if ipcShmAddr = *NULL;
         return *OFF;
       endif;
       // check matching key
       // or blanks (anyone allowed)
       // bCtl.ipcOwnKey -- IPC shared memory
       // jobKey         -- passed by user
       bCtlP = ipcShmAddr;
       ipcOwnFix(bCtlP);
       if bCtl.ipcOwnKey = *BLANKS
       or bCtl.ipcOwnKey = jobKey;
         return *ON;
       endif;
       // error message owner busy
       ipcOwnJobBusy();
       if ipcLocked = *ON;
         bCtl.ipcOwnBad = *ON;      // shared memory flag set
       endif;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * rc = ipcOwnJob()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcOwnJob       B                   export
     D ipcOwnJob       PI             1N
     D   jobKey                     128A   value
      * vars
     D rcb             s              1N   inz(*ON)
     D rc              S             10i 0 inz(0)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       // no job own stateless
       if ipcIsHere = *ON;
         return *ON;
       endif;
       ipcSafe(); // @ADC safe IPC (1.7.4)
       // blank set it
       ipcOwnFix(ipcCtlP);
       if ipcCtl.ipcOwnKey = *BLANKS 
       or ipcCtl.ipcOwnKey = jobKey;
         ipcCtl.ipcOwnKey = jobKey;   // local flag set (prior ipcCopyIn)
       endif;
       // maybe i already own IPC
       // or blanks (anyone can own)
       return ipcOwnUse(jobKey:*OFF);
      /end-free
     P                 E

      *****************************************************
      * rc = ipcOwnEnd()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcOwnEnd       B                   export
     D ipcOwnEnd       PI             1N
     D   jobKey                     128A   value
      * vars
     D rcb             s              1N   inz(*ON)
     D rc              S             10i 0 inz(0)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       // no job own stateless
       if ipcIsHere = *ON;
         return *ON;
       endif;
       // set end reservation end script
       rcb = ipcOwnJob(jobKey);
       if rcb = *ON;
         ipcDoFlags.doOwnEnd = *ON;   // local flag set (prior ipcCopyIn)
       endif;
       return rcb;
      /end-free
     P                 E

      *****************************************************
      * IDLE_TIMEOUT
      *****************************************************
     P ipcOwnJobBusy...
     P                 B                   export
     D ipcOwnJobBusy...
     D                 PI
      * vars
     d rc              s              1N   inz(*OFF)
     d rcsig           s             10i 0 inz(0)
     D cmd             s            200a   inz(*BLANKS)
     d string          s               *   inz(%addr(CMD))
     d stringLen       s             10i 0 inz(0)
     d serverPid       s             10i 0 inz(0)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       // end job owner busy
       cacStatic(CAC_LEVEL_ERROR);
       errsCritical(IPC_ERROR_TIMEOUT_OWN_BUSY);
      /end-free
     P                 E


      *****************************************************
      * Luca IDLE_TIMEOUT
      *****************************************************
     P ipcEndJobBusy...
     P                 B                   export
     D ipcEndJobBusy...
     D                 PI
      * vars
     d rc              s              1N   inz(*OFF)
     d rcsig           s             10i 0 inz(0)
     D cmd             s            200a   inz(*BLANKS)
     d string          s               *   inz(%addr(CMD))
     d stringLen       s             10i 0 inz(0)
     d serverPid       s             10i 0 inz(0)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       ipcSafe(); // @ADC safe IPC (1.7.4)
       // local run memory based
       // mark busy leave for server
       if ipcCtl.ipcWaiting = *ON;
         ipcCtl.ipcBusyIAm = *ON;
         ipcCtl.ipcWaiting = *OFF;
       endif;

       // end job busy
       cacStatic(CAC_LEVEL_ERROR);
       errsCritical(IPC_ERROR_TIMEOUT_END_BUSY);

      /end-free
     P                 E

      *****************************************************
      * Luca IDLE_TIMEOUT
      *****************************************************
     P ipcEndJobImmed...
     P                 B                   export
     D ipcEndJobImmed...
     D                 PI
      * vars
     d rc              s              1N   inz(*OFF)
     d rcsig           s             10i 0 inz(0)
     D cmd             s            200a   inz(*BLANKS)
     d string          s               *   inz(%addr(CMD))
     d stringLen       s             10i 0 inz(0)
     d serverPid       s             10i 0 inz(0)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       // end job kill
       errsCritical(IPC_ERROR_TIMEOUT_END_KILL);

       // attached??
       if ipcShmAddr = *NULL;
         serverPid = 0;
       else;
         bCtlP = ipcShmAddr;
         serverPid = bCtl.ipcPidSrv;
       endif;

       // immed end from client side 
       // also sends server sigkill
       if serverPid > 0 and serverPid <> getpid();
         rcsig = kill(serverPid:SIGKILL);
       endif;

       // remote run ipc based
       // destroy semaphore
       // will release all waiters
       rc = ipcDestroy();

       // end my job immediate
       // i am the server
       if (serverPid > 0 and serverPid = getpid())
       or ipcIsHere = *ON; // @ADC -- 2.0.0
         CMD = 'ENDJOB JOB(*) OPTION(*IMMED)';
         stringLen = %LEN(CMD);
         rc = ileCmdExc(string:stringLen);
       endif;

      /end-free
     P                 E

      *****************************************************
      * rc = ipcOwnSbm(sbmjob)
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcOwnSbm       B                   export
     D ipcOwnSbm       PI             1N
     D   mySbm                     4096A   value
      * vars
     D rcb             s              1N   inz(*ON)
      /free
       sUsrSbmJob = mySbm;
       return rcb;
      /end-free
     P                 E

      *****************************************************
      * rc = sbmJob()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P sbmJob          B                   export
     D sbmJob          PI             1N
      * vars
     D cmdstr          s           4096A   inz(*BLANKS)
     D rcb             s              1N   inz(*ON)
     D len             s             10i 0 inz(0)
     D i               s             10i 0 inz(0)
     D mylib           s             10A   inz(*BLANKS)
     D mypgm           s             10A   inz(*BLANKS)
      /free
       Monitor;

       // no sbmjob stateless
       if ipcIsHere = *ON;
         return *ON;
       endif;

       if sUsrSbmJob <> *BLANKS;
         // user set SBMJOB
         cmdstr = sUsrSbmJob;
       else;
         // -------------
         // execute command
         // SBMJOB CMD(CALL PGM(PLUGSBMLIB/PLUGSBMPGM)
         //   PARM('/tmp/ranger')) JOBD(ZENDSVR/ZSVR_JOBD)
         //   PRTDEV(*JOBD) OUTQ(*JOBD) INLLIBL(*JOBD) 
         //   INLASPGRP(*JOBD) SPLFACN(*JOBD)
         mylib = confSBMLIB();
         mypgm = confSBMPGM();
         cmdstr = 'SBMJOB CMD(CALL PGM(' 
              + %trim(mylib) 
              + '/' 
              + %trim(mypgm) 
              + ')'
              + ' PARM('
              + '''' 
              + %trim(ipcPathBlk) 
              + '''' 
              + '))'
              + ' JOB('
              + %trim(ipcDoFlags.doSbmNam) 
              + ')'
              + ' JOBD('
              + %trim(ipcDoFlags.doSbmLib) 
              + '/' 
              + %trim(ipcDoFlags.doSbmJobd)         
              + ')';          
         // INLASPGRP(ASP1) (1.6.5)
         if ipcDoFlags.doSbmAsp <> *BLANKS;
           cmdstr = %trim(cmdstr)
              + ' INLASPGRP('
              + %trim(ipcDoFlags.doSbmAsp) 
              + ')';
         endif;
         // add options for SBMJOB
         for i = 1 to SBMNBR;
           cmdstr = %trim(cmdstr) + ' ' + %trim(SBMARRAY(i));
         endfor;
       endif;
       len = %len(%trim(cmdstr));
       cmdexec(cmdstr:len);

       // -------------
       // error
       On-error;
         rcb = *OFF;
       Endmon;

       return rcb;
      /end-free
     P                 E

      *****************************************************
      * rc = spawnJob()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P spawnJob        B                   export
     D spawnJob        PI             1N

      * vars spawn
     D inherit         ds                  likeds(inheritance_t)
     D inhp            s               *
     D openmax         s             10i 0
     D pid             s             10i 0
     D argv            s               *   dim(3)
     D argp            s               *
     D arg1            s            128A   inz(*BLANKS)
     D envv            s               *   dim(1)
     D envp            s               *
     D mydir           s            128A   inz(*BLANKS)
     D mypgm           s            128A   inz(*BLANKS)
      /free
       // no spawn stateless
       if ipcIsHere = *ON;
         return *ON;
       endif;

       inhp = %addr(inherit);
       inherit.flags = SPAWN_SETTHREAD_NP
               + SPAWN_SETJOBNAMEPARENT_NP;
       inherit.flags = SPAWN_SETJOBNAMEARGV_NP;
       inherit.pgroup = 0;
       inherit.sigmask = 0;
       inherit.sigdefault = 0;
       openmax = sysconf(SC_OPEN_MAX);

       mydir = confSPNDIR();
       mypgm = confSPNPGM();
       arg1 = %trim(mydir) + %trim(mypgm) + x'00';
       argp = %addr(argv(1));
       argv(1) = %addr(arg1);
       argv(2) = %addr(ipcPathNull);
       argv(3) = *NULL;

       envp = %addr(envv(1));
       envv(1) = *NULL;

       pid = spawn(%addr(arg1):openmax:*NULL:inhp:argp:envp);
       if pid > -1;
         return *ON;
       else;
         errsCritical(IPC_ERROR_SPAWN_FAIL:arg1);
       endif;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * rc = ipcMake()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcMake         B                   export
     D ipcMake         PI             1N
      * vars
     D rc              S             10i 0 inz(0)
      /free
       // no ipc make stateless
       if ipcIsHere = *ON;
         return *ON;
       endif;
       // make directory
       rc = mkdir(ipcPathNull:xIPC_RW);
       // take out (occurs too often)
       // if rc < 0;
       //  errsWarning(IPC_ERROR_MKDIR_FAIL:ipcPathBlk);
       // endif;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * xml temp file
      * return (NA)
      *****************************************************
     P ipcRmvNow       B
     D ipcRmvNow       PI             1N
      * vars
     d rc              s             10i 0 inz(0)
      /free
       if ipcPathBlk <> *BLANKS;
         rc = rmdir(ipcPathNull); // @ADC (1.7.4)
       endif;
       // ipcPathBlk = *BLANKS;
       if rc > -1;
         return *ON;
       endif;
       errsWarning(IPC_ERROR_DLT_TMP_FAIL:ipcPathBlk);
       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * rc = ipcPanic()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcPanic        B                   export
     D ipcPanic        PI             1N
      * vars
     D ipcAllKey       S             10i 0 inz(-1)
     D rcb             s              1N   inz(*OFF)
     D thekey          s             32A   inz(*BLANKS)
     D cmdstr          s           6000A   inz(*BLANKS)
     D cmdp            s               *   inz(%addr(cmdstr))
     D cmdlen          s             10i 0 inz(0)
      /free
       ipcAllKey = ftok(ipcPathNull:IPC_ID);
       if ipcAllKey > -1;
         thekey = ipcFtok();

         // destroy semaphore 
         cmdstr = *BLANKS;
         cmdstr = %trim(cmdstr) + 'call PGM(QSYS/QP0ZIPCR) PARM(';
         cmdstr = %trim(cmdstr) + '''-S0X';
         cmdstr = %trim(cmdstr) + %trim(thekey);
         cmdstr = %trim(cmdstr) + '''';
         cmdstr = %trim(cmdstr) + ')';
         cmdlen = %len(%trim(cmdstr));
         rcb = ileCmdExc(cmdp:cmdlen);

         // destroy shared memory
         cmdstr = *BLANKS;
         cmdstr = %trim(cmdstr) + 'call PGM(QSYS/QP0ZIPCR) PARM(';
         cmdstr = %trim(cmdstr) + '''-M0X';
         cmdstr = %trim(cmdstr) + %trim(thekey);
         cmdstr = %trim(cmdstr) + '''';
         cmdstr = %trim(cmdstr) + ')';
         cmdlen = %len(%trim(cmdstr));
         rcb = ileCmdExc(cmdp:cmdlen);

       endif;
       return rcb;
      /end-free
     P                 E


      *****************************************************
      * rc = ipcBoilWater()
      * return (NA)
      *****************************************************
     P ipcBoilWater...
     P                 B
     D ipcBoilWater...
     D                 PI
      * vars
      * boil water
     D boilwater       S              1N   inz(*OFF)
     D jobName         s             10A   inz(*BLANKS)
     D jobUserID       s             10A   inz(*BLANKS)
     D jobNbr          s              6A   inz(*BLANKS)
     D jobInfo         ds                  likeds(myJob_t)
      /free
       // Ask job to boil water,
       // maybe IBM i ending/starting process
       boilwater = ileJob(jobName:jobUserID:jobNbr:jobInfo);
      /end-free
     P                 E

      *****************************************************
      * rc = ipcLock()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcLock         B                   export
     D ipcLock         PI             1N
     D   doCreate                     1N   value
      * vars
     D rc              S             10i 0 inz(0)
     D rcb             S              1N   inz(*OFF)
     D myErrLast       DS                  likeds(erRec_t)
      /free
       // no lock stateless
       if ipcIsHere = *ON;
         return *ON;
       endif;

       ipcSemKey = -1;
       ipcSemRet = -1;
       if doCreate = *ON;
         // -----------------
         // i am server side (XMLSERVICE)
         // attempt semaphore create (semget xIPC_RWCRT)
         // (see ipcUse lock/wake shared client/server)
         // -----------------
         // make the path (our key)
         rcb = ipcMake();
         // create semaphores
         ipcSemKey = ftok(ipcPathNull:IPC_ID);
         if ipcSemKey > -1;
           // try create
           ipcSemRet = semget(ipcSemKey:NUMSEMS:xIPC_RWCRT); // +XIPC_OTHR
           if ipcSemRet < 0;
             errsWarning(IPC_ERROR_CRTSEM1_FAIL:ipcPathBlk);
             // EINVAL 3021 The value specified 
             // for the argument is not correct.
             errsLast(myErrLast);
             if myErrLast.erErrNo = 3021;
               rcb = ipcPanic();
             else;
               // Ask server to boil water,
               // maybe IBM i ending/starting process
               ipcBoilWater();
             endif;
             // try create again now
             ipcSemRet = semget(ipcSemKey:NUMSEMS:xIPC_RWCRT); // +XIPC_OTHR
             if ipcSemRet < 0;
               errsCritical(IPC_ERROR_CRTSEM2_FAIL:ipcPathBlk);
             endif;
           endif;
         else;
           errsWarning(IPC_ERROR_FTOK_BEG_FAIL:ipcPathBlk);
         endif;
       // -----------------
       // i am client side (QSQSRVR)
       // attempt semaphore attach (semget xIPC_RW)
       // (see ipcUse lock/wake shared client/server)
       // -----------------
       else;
         ipcSemKey = ftok(ipcPathNull:IPC_ID);
         if ipcSemKey > -1;
           ipcSemRet = semget(ipcSemKey:NUMSEMS:xIPC_RW);
           if ipcSemRet < 0;
             errsCritical(IPC_ERROR_GETSEM_FAIL:ipcPathBlk);
             // EINVAL 3021 The value specified 
             // for the argument is not correct.
             errsLast(myErrLast);
             if myErrLast.erErrNo = 3021;
               rcb = ipcPanic();
             else;
               // Ask client to boil water,
               // maybe IBM i ending/starting process
               ipcBoilWater();
             endif;
             // try attach again now
             ipcSemRet = semget(ipcSemKey:NUMSEMS:xIPC_RW);
             if ipcSemRet < 0;
               errsCritical(IPC_ERROR_GETSEM_FAIL:ipcPathBlk);
             endif;
           endif;
         else;
           errsWarning(IPC_ERROR_FTOK_BEG_FAIL:ipcPathBlk);
         endif;
       endif;
       if ipcSemRet <> -1;
         return *ON;
       endif;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * rc = ipcAttach()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcAttach       B                   export
     D ipcAttach       PI             1N
     D   doCreate                     1N   value
      * vars
     D rc              S             10i 0 inz(0)
     D rcb             S              1N   inz(*OFF)
     D myErrLast       DS                  likeds(erRec_t)
     D looper          S             10i 0 inz(0)
      /free
       // no shared memory stateless
       if ipcIsHere = *ON;
         return ipcAttach3(doCreate);
       endif;

       ipcShmAddr = *NULL;
       ipcShmId = -1;
       ipcShmKey = ftok(ipcPathNull:IPC_ID);
       if ipcShmKey > -1;
         // -----------------
         // i am server side (XMLSERVICE)
         // attempt shared memory create (shmget xIPC_RWCRT)
         // and then attach shared memory (shmat)
         // -----------------
         if doCreate = *ON;
           // attempt create
           ipcShmId = shmget(ipcShmKey:IPCSZ:xIPC_RWCRT+XSHM_TS); // +XIPC_OTHR
           if ipcShmId < 0;
             errsCritical(IPC_ERROR_CRTSHM_FAIL:ipcPathBlk);
             // EINVAL 3021 The value specified 
             // for the argument is not correct.
             // EIDRM  3509 The semaphore, shared memory, 
             // or message queue identifier is removed from the system.
             // ENOENT 3025 No such path or directory.
             // EINTR 3407 Interrupted function call.
             errsLast(myErrLast);
             if myErrLast.erErrNo <> 0;
               if myErrLast.erErrNo = 3021;
                 // Ask server panic, start over
                 rcb = ipcPanic();
               else;
                 // Ask server to boil water,
                 // maybe IBM i ending/starting process
                 ipcBoilWater();
               endif;
               // try create again now
               ipcShmId = shmget(ipcShmKey:IPCSZ:xIPC_RWCRT+XSHM_TS); // +XIPC_OTHR
               if ipcShmId < 0;
                 errsCritical(IPC_ERROR_CRTSHM_FAIL:ipcPathBlk);
               endif;
             endif;
           endif;
           if ipcShmId > 0;
             // try attach shared memory
             ipcShmAddr = shmat(ipcShmId:*NULL:0);
             if ipcShmAddr = *NULL;
               errsCritical(IPC_ERROR_SHMAT1_FAIL:ipcPathBlk);
             endif;
           endif;
         // -----------------
         // i am client side (QSQSRVR)
         // attempt shared memory key get (shmget xIPC_RW)
         // and then attach shared memory (shmat)
         // if not work start XMLSERVICE job retry ipcAttach2
         // -----------------
         else;
           // try attach
           ipcShmId = shmget(ipcShmKey:IPCSZ:xIPC_RW+XSHM_TS);
           if ipcShmId < 0;
             errsWarning(IPC_ERROR_GETSHM_FAIL:ipcPathBlk);
             // EINVAL 3021 The value specified 
             // for the argument is not correct.
             // EIDRM  3509 The semaphore, shared memory, 
             // or message queue identifier is removed from the system.
             // ENOENT 3025 No such path or directory.
             // EINTR 3407 Interrupted function call.
             errsLast(myErrLast);
             if myErrLast.erErrNo <> 0;
               if myErrLast.erErrNo = 3021;
                 // Ask client panic, start over
                 rcb = ipcPanic();
               else;
                 // Ask client to boil water,
                 // maybe IBM i ending/starting process
                 ipcBoilWater();
               endif;
               // try attach again
               ipcShmId = shmget(ipcShmKey:IPCSZ:xIPC_RW+XSHM_TS);
               if ipcShmId < 0;
                 errsLast(myErrLast);
               endif;
               if ipcShmId < 0;
                 errsWarning(IPC_ERROR_GETSHM_FAIL:ipcPathBlk);
               endif;
             endif;
           endif;
           if ipcShmId > 0;
             // try attach shared memory
             ipcShmAddr = shmat(ipcShmId:*NULL:0);
             if ipcShmAddr = *NULL;
               errsWarning(IPC_ERROR_SHMAT2_FAIL:ipcPathBlk);
             endif;
           endif;
         endif;
       else;
         errsWarning(IPC_ERROR_FTOK_BEG_FAIL:ipcPathBlk);
       endif;
       // -------------
       // ok???
       if ipcShmAddr = *NULL;
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E

      *****************************************************
      * rc = ipcAttach2()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcAttach2      B                   export
     D ipcAttach2      PI             1N
      * vars
     D iAmReady        S              1N   inz(*OFF)
     D looper          S             10i 0 inz(0)
     D bCtlP           S               *   inz(*NULL)
     D bCtl            DS                  likeds(ipcRec_t) based(bCtlP)
      /free
       // no shared memory stateless
       if ipcIsHere = *ON;
         return *ON;
       endif;
       // -----------------
       // i am client side (QSQSRVR)
       // ipc=/tmp/packers exist??
       // created by XMLSERVICE job
       // loop until seen
       // -----------------
       ipcShmAddr = *NULL;
       ipcShmKey = -1;
       ipcShmId = -1;
       looper = 0;
       if ipcShmKey = -1;
        dow ipcShmKey = -1;
         ipcShmKey = ftok(ipcPathNull:IPC_ID);
         if ipcShmKey > 0;
           leave;
         elseif looper = 0 and ipcShmKey < 0;
            errsWarning(IPC_ERROR_FTOK_BEG_FAIL:ipcPathBlk);
         endif;
         looper += 1;
         if looper < IPCLOOPATTACHNOSLEEP;
           // Ask client to boil water,
           // IBM i hatching new baby process
           ipcBoilWater();
         elseif looper < IPCLOOPATTACHSLEEPONESECOND;
           // Ask client to take a nap (zzzzzzz),
           // IBM i hatching new baby process
           sleep(1);
         else;
           leave;
         endif;
        enddo;
        // It all went wrong, tell client bad news
        if ipcShmKey < 0;
          errsWarning(IPC_ERROR_FTOK_END_FAIL
          :%trim(ipcPathBlk)+' : ' + %char(looper));
        endif;
       endif;
       // -----------------
       // i am client side (QSQSRVR)
       // ipc=/tmp/packers shared memory key exist??
       // created by XMLSERVICE job
       // loop until seen
       // -----------------
       looper = 0;
       if ipcShmKey > 0;
        dow ipcShmId = -1;
         ipcShmId = shmget(ipcShmKey:IPCSZ:xIPC_RW+XSHM_TS);
         if ipcShmId > 0;
           leave;
         elseif looper = 0 and ipcShmId < 0;
            errsWarning(IPC_ERROR_SHM_BEG_FAIL:ipcPathBlk);
         endif;
         looper += 1;
         if looper < IPCLOOPATTACHNOSLEEP;
           // Ask client to boil water,
           // IBM i hatching new baby process
           ipcBoilWater();
         elseif looper < IPCLOOPATTACHSLEEPONESECOND;
           // Ask client to take a nap (zzzzzzz),
           // IBM i hatching new baby process
           sleep(1);
         else;
           leave;
         endif;
        enddo;
        // It all went wrong, tell client bad news
        if ipcShmId < 0;
          errsCritical(IPC_ERROR_SHM_END_FAIL
          :%trim(ipcPathBlk)+' : ' + %char(looper));
        endif;
       endif;
       // -----------------
       // i am client side (QSQSRVR)
       // ipc=/tmp/packers shared memory attach ok??
       // created by XMLSERVICE job
       // loop until attached
       // -----------------
       looper = 0;
       if ipcShmId > 0;
        dow ipcShmAddr = *NULL;
         ipcShmAddr = shmat(ipcShmId:*NULL:0);
         if ipcShmAddr = *NULL;
           if looper = 0;
             errsWarning(IPC_ERROR_SHMAT_BEG_FAIL:ipcPathBlk);
           endif;
         else;
           leave;
         endif;
         looper += 1;
         if looper < IPCLOOPATTACHNOSLEEP;
           // Ask client to boil water,
           // IBM i hatching new baby process
           ipcBoilWater();
         elseif looper < IPCLOOPATTACHSLEEPONESECOND;
           // Ask client to take a nap (zzzzzzz),
           // IBM i hatching new baby process
           sleep(1);
         else;
           leave;
         endif;
        enddo;
        // It all went wrong, tell client bad news
        if ipcShmAddr = *NULL;
          errsCritical(IPC_ERROR_SHMAT_END_FAIL
          :%trim(ipcPathBlk)+' : ' + %char(looper));
        endif;
       endif;
       // -----------------
       // i am client side (QSQSRVR)
       // ipc=/tmp/packers shared memory attach ok above,
       // is XMLSERVICE bCtl.ipcReadyGo = *ON???
       // loop until XMLSERVICE finishes makeup and comb (over)
       // -----------------
       looper = 0;
       if ipcShmKey > 0 and ipcShmId > 0
       and ipcShmAddr <> *NULL;  // @ADC 1.6.10 
        dow iAmReady = *OFF;
         bCtlP = ipcShmAddr;
         if bCtl.ipcReadyGo = *ON;
           iAmReady = *ON;
           leave;
         endif;
         looper += 1;
         if looper < IPCLOOPATTACHNOSLEEP;
           // Ask client to boil water,
           // IBM i hatching new baby process
           ipcBoilWater();
         elseif looper < IPCLOOPATTACHSLEEPONESECOND;
           // Ask client to take a nap (zzzzzzz),
           // IBM i hatching new baby process
           sleep(1);
         else;
           leave;
         endif;
        enddo;
        // It all went wrong, tell client bad news
        if iAmReady = *OFF;
          errsCritical(IPC_ERROR_SHMAT_READY_FAIL
          :%trim(ipcPathBlk)+' : ' + %char(looper));
        endif;
       endif;
       // -----------------
       // good or error
       if iAmReady = *ON;
         return *ON;
       endif;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * rc = ipcAttach3()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcAttach3      B                   export
     D ipcAttach3      PI             1N
     D   doCreate                     1N   value
      * vars
     D rcb             S              1N   inz(*OFF)
     D memI            S             10i 0 inz(0)
      /free
       if doCreate = *ON;
         memI = cacAddBig(IPCSZ:CAC_HEAP_ILE_IPC);
         ipcShmAddr = cacScanBig(memI);
       endif;
       if ipcShmAddr = *NULL;
         errsCritical(IPC_ERROR_ALLOC_FAIL:%char(IPCSZ));
       else;
         return *ON;
       endif;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * rc = ipcDetach()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcDetach       B                   export
     D ipcDetach       PI             1N
      * vars
     D rcb             S              1N   inz(*OFF)
     D rc              S             10i 0 inz(0)
     D errNbr          S             10i 0 inz(0)
      /free
       // no shared memory stateless
       if ipcIsHere = *ON;
         return ipcDetach3();
       endif;
       ipcMemClr();   // ADC (1.6.8)
       // have shared memory
       if ipcShmAddr = *NULL;
         return *ON;
       endif;
       rc = shmdt(ipcShmAddr);
       ipcShmAddr = *NULL;
       if rc > -1;
         return *ON;
       endif;
       errsWarning(IPC_ERROR_RM_SHMDT_FAIL:ipcPathBlk);
       return *OFF;
      /end-free
     P                 E


      *****************************************************
      * rc = ipcDetach3()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcDetach3      B                   export
     D ipcDetach3      PI             1N
      * vars
     D rcb             S              1N   inz(*OFF)
      /free
       ipcMemClr();   // ADC (1.6.8)
       ipcShmAddr = *NULL;
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * rcb = ipcDestroy()
      * return (good=*ON; bad=*OFF)
      * Talk:
      *  -1 = wait to use
      *   0 = ok to use?
      *   1 = wake up
      *****************************************************
     P ipcDestroy      B                   export
     D ipcDestroy      PI             1N
      * vars
     D rc              S             10i 0 inz(-1)
     D rc1             S             10i 0 inz(-1)
     D rc2             S             10i 0 inz(-1)
     D rcb             S              1N   inz(*OFF)
     D ipcShmBuf       S           1024A   inz(*BLANKS)
      /free
       // no shared memory stateless
       if ipcIsHere = *ON;
         return ipcDetach3();
       endif;

       if ipcShmAddr = *NULL;
         rc = 0;
       else;
         // destroy shared memory
         rc = shmdt(ipcShmAddr);
         if rc < 0;
           errsWarning(IPC_ERROR_RM_SHMDT_FAIL:ipcPathBlk);
         endif;
         ipcShmAddr = *NULL;
       endif;
       // delete shared memory
       ipcShmKey = ftok(ipcPathNull:IPC_ID);
       if ipcShmKey > -1;
         ipcShmId = shmget(ipcShmKey:IPCSZ:xIPC_RW+XSHM_TS);
         if ipcShmId > -1;
           rc1 = shmctl(ipcShmId:IPC_RMID:%addr(ipcShmBuf));
           if rc1 < 0;
             errsWarning(IPC_ERROR_RM_SHMCTL_FAIL:ipcPathBlk);
           endif;
         else;
           errsWarning(IPC_ERROR_RM_SHMID_FAIL:ipcPathBlk);
         endif;
       else;
         errsWarning(IPC_ERROR_RM_SHMKEY_FAIL:ipcPathBlk);
       endif;
       // destroy semaphores
       ipcSemKey = ftok(ipcPathNull:IPC_ID);
       if ipcSemKey > -1;
         ipcSemRet = semget(ipcSemKey:NUMSEMS:xIPC_RW);
         if ipcSemRet > -1;
           rc2 = semctl(ipcSemRet:0:IPC_RMID);
           if rc2 < 0;
             errsWarning(IPC_ERROR_RM_SEMCTL_FAIL:ipcPathBlk);
           endif;
         else;
           errsWarning(IPC_ERROR_RM_SEMGET_FAIL:ipcPathBlk);
         endif;
       else;
         errsWarning(IPC_ERROR_RM_SEMKEY_FAIL:ipcPathBlk);
       endif;

       // done
       ipcShmAddr = *NULL;
       ipcSemKey = -1;
       ipcSemRet = -1;

       // new destroy IPC safeguard 
       // rcb = ipcPanic(); // ADC (1.6.8)

       // destroy memory
       ipcMemClr();   // ADC (1.6.8)

       // destroy IPC IFS path
       rcb = ipcRmvNow();   // ADC (1.6.8)

       if rc = -1 or rc1 = -1 or rc2 = -1;
         return *OFF;
       endif;

       return *ON;
      /end-free
     P                 E


      *****************************************************
      * rc = ipcFtok()
      * return (*ON=ok; *OFF=bad)
      * Note: qsh -> ipcs
      *****************************************************
     P ipcFtok         B                   export
     D ipcFtok         PI            32A
      * vars
     D rc              s             10i 0 inz(0)
     D myKey           s             10i 0 inz(0)
     D pTarget         s               *   inz(*NULL) 
     D nLength         s             10i 0 inz(0)
     D myHex           s             32A   inz(*BLANKS) 
     D pSource         s               *   inz(*NULL) 
      /free
       myKey = ftok(ipcPathNull:IPC_ID);
       pTarget = %addr(myHex);
       pSource = %addr(myKey);
       nLength = %size(myKey);
       rc = cpyB2Hex(pTarget:pSource:nLength);
       return myHex;
      /end-free
     P                 E

      *****************************************************
      * rc = ipcIPC()
      * return (*ON=ok; *OFF=bad)
      * Note: qsh -> ipcs
      *****************************************************
     P ipcIPC          B                   export
     D ipcIPC          PI          1024A
      /free
       return ipcPathBlk;
      /end-free
     P                 E


      *****************************************************
      * rc = ipcIsOk()
      * return (*ON=ok; *OFF=bad)
      *****************************************************
     P ipcIsOk         B                   export
     D ipcIsOk         PI             1N
      /free
       if ipcShmAddr = *NULL;
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * rcb = ipcUse()
      * return (good=*ON; bad=*OFF)
      * Talk:
      *  -1 = wait to use
      *   0 = ok to use?
      *   1 = wake up
      *****************************************************
     P ipcUse          B
     D ipcUse          PI             1N
     D   talkIPC                     10i 0 value
     D   talkClient                  10i 0 value
     D   talkServer                  10i 0 value
      * vars
     D rc              S             10i 0 inz(0)
     D myErrno         S             10i 0 inz(0)
      /free
       // no lock stateless
       if ipcIsHere = *ON;
         return *ON;
       endif;

       // sem_op = 0, waits for result = 0      *** ZZZZZZZZ
       // sem_op > 0, result++                  *** WAKE ALL
       // sem_op < 0, attempts result-- ...
       // ... result = 0, result--              *** WAKE ALL
       // ... result < 0, waits for result > 0  *** ZZZZZZZZ
       // ... result > 0, result--              *** nada
       // Note: 
       //   sem_flg IPC_NOWAIT - not wait
       //   sem_flg 0          - wait forever
       ipcSemSet(1).sem_num = 0;  // USE IPC world
       ipcSemSet(1).sem_op  = talkIPC;
       ipcSemSet(1).sem_flg = 0;  
       ipcSemSet(2).sem_num = 1;  // TALK CLIENT
       ipcSemSet(2).sem_op  = talkClient;
       ipcSemSet(2).sem_flg = 0;
       ipcSemSet(3).sem_num = 2;  // TALK SERVER
       ipcSemSet(3).sem_op  = talkServer;
       ipcSemSet(3).sem_flg = 0;
       rc = semop(ipcSemRet:ipcSemSet:%elem(ipcSemSet));

       // response semop (good)
       if rc > -1;
         return *ON;
       endif;

       // response semop (error)
       myErrno = ileErrno();
       errsWarning(IPC_ERROR_RM_SEMOP_FAIL:ipcPathBlk);
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * ipcClientWaitUse - ipc wait racing other clients
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcClientWaitUse...
     P                 B                   export
     D ipcClientWaitUse...
     D                 PI             1N
      * vars
      /free
       return ipcUse(IPC_WAIT_USE:IPC_WAIT_OK:IPC_WAIT_OK);
      /end-free
     P                 E

      *****************************************************
      * ipcClientWaitCopyIn - ipc wait for server allow copyin
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcClientWaitCopyIn...
     P                 B                   export
     D ipcClientWaitCopyIn...
     D                 PI             1N
      * vars
      /free
       return ipcUse(IPC_WAIT_OK:IPC_WAIT_USE:IPC_WAIT_OK);
      /end-free
     P                 E

      *****************************************************
      * ipcClientRequestRunXML - ipc wake ask server make call
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcClientRequestRunXML...
     P                 B                   export
     D ipcClientRequestRunXML...
     D                 PI             1N
      * vars
      /free
       return ipcUse(IPC_WAIT_OK:IPC_WAIT_OK:IPC_WAIT_WAKE);
      /end-free
     P                 E

      *****************************************************
      * ipcClientWaitCopyOut - ipc wait server call finish 
      *                        for copyout
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcClientWaitCopyOut...
     P                 B                   export
     D ipcClientWaitCopyOut...
     D                 PI             1N
      * vars
      /free
       ipcSafe(); // @ADC safe IPC (1.7.4)
       ipcCtl.ipcWaiting = *ON;
       ipcCtl.ipcBusyIAm = *OFF;
       return ipcUse(IPC_WAIT_OK:IPC_WAIT_USE:IPC_WAIT_OK);
      /end-free
     P                 E

      *****************************************************
      * ipcClientDoneRelease - ipc wake server released next client
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcClientDoneRelease...
     P                 B                   export
     D ipcClientDoneRelease...
     D                 PI             1N
      * vars
      /free
       return ipcUse(IPC_WAIT_OK:IPC_WAIT_OK:IPC_WAIT_WAKE);
      /end-free
     P                 E

      *****************************************************
      * ipcServerWaitUse - ipc wait to use (never wait)
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcServerWaitUse...
     P                 B                   export
     D ipcServerWaitUse...
     D                 PI             1N
      * vars
      /free
       return ipcUse(IPC_WAIT_OK:IPC_WAIT_OK:IPC_WAIT_OK);
      /end-free
     P                 E

      *****************************************************
      * ipcServerAcceptClient - ipc wake accept a client
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcServerAcceptClient...
     P                 B                   export
     D ipcServerAcceptClient...
     D                 PI             1N
      * vars
      /free
       return ipcUse(IPC_WAIT_WAKE:IPC_WAIT_OK:IPC_WAIT_OK);
      /end-free
     P                 E

      *****************************************************
      * ipcServerAcceptCopyIn - ipc wake ask client to copy in
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcServerAcceptCopyIn...
     P                 B                   export
     D ipcServerAcceptCopyIn...
     D                 PI             1N
      * vars
      /free
       return ipcUse(IPC_WAIT_OK:IPC_WAIT_WAKE:IPC_WAIT_OK);
      /end-free
     P                 E

      *****************************************************
      * ipcServerWaitCopyIn - ipc wait client copy in complete
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcServerWaitCopyIn...
     P                 B                   export
     D ipcServerWaitCopyIn...
     D                 PI             1N
      * vars
      /free
       return ipcUse(IPC_WAIT_OK:IPC_WAIT_OK:IPC_WAIT_USE);
      /end-free
     P                 E

      *****************************************************
      * ipcServerDoneCopyOut - ipc wake ask client to copy out
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcServerDoneCopyOut...
     P                 B                   export
     D ipcServerDoneCopyOut...
     D                 PI             1N
      * vars
      /free
       return ipcUse(IPC_WAIT_OK:IPC_WAIT_WAKE:IPC_WAIT_OK);
      /end-free
     P                 E

      *****************************************************
      * ipcServerWaitCopyOut - ipc wait client copy out complete
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P ipcServerWaitCopyOut...
     P                 B                   export
     D ipcServerWaitCopyOut...
     D                 PI             1N
      * vars
      /free
       return ipcUse(IPC_WAIT_OK:IPC_WAIT_OK:IPC_WAIT_USE);
      /end-free
     P                 E

      *****************************************************
      * xml temp file
      * return (NA)
      *****************************************************
     P ipcPthXMLf      B                   export
     D ipcPthXMLf      PI          1024A
     D   jobName                     10A   value
     D   jobUserID                   10A   value
     D   jobNbr                       6A   value
      /free
       return '/tmp/xmlservice-joblog-'
              + %trim(jobName) + '-'
              + %trim(jobUserID) + '-'
              + %trim(jobNbr)
              +'.log';
      /end-free
     P                 E

      *****************************************************
      * xml temp file
      * return (NA)
      *****************************************************
     P ipcWrtXMLf      B                   export
     D ipcWrtXMLf      PI             1N
     D   pData                         *   value
     D   pSize                       10i 0 value
     D   pTmpFile                  1024A   value
      * vars
     d fd              s             10i 0 inz(0)
     d rc              s             10i 0 inz(0)
     d rc1             s             10i 0 inz(0)
      /free
       ipcFileTmp = %trim(pTmpFile) + x'00';
       fd = openIFS(ipcFileTmp
              :O_WRONLY + O_CREAT + O_TRUNC
              :S_IRUSR + S_IWUSR);
       if fd > -1;
         rc = writeIFS(fd:pData:pSize);
         rc1 = closeIFS(fd);
       else;
         errsWarning(IPC_ERROR_CRT_TMP_FAIL:ipcFileTmp);
         ipcFileTmp = *BLANKS;
         rc = -1;
       endif;
       if rc > -1;
         return *ON;
       endif;
       return *OFF;
      /end-free
     P                 E

      *****************************************************
      * xml temp file
      * return (NA)
      *****************************************************
     P ipcBotXMLf      B                   export
     D ipcBotXMLf      PI            10i 0
     D   pData                         *   value
     D   pSize                       10i 0 value
     D   pTmpFile                  1024A   value
      * vars
     d fd              s             10i 0 inz(0)
     d rc              s             10i 0 inz(0)
     d rc1             s             10i 0 inz(0)
     d len             s             20i 0 inz(1)
     d remain          s             20i 0 inz(0)
     d need            s             20i 0 inz(0)
     D myTmp           s           4096A   inz(*BLANKS) 
     D pTmp            s               *   inz(*NULL)
     d myLen           s             10i 0 inz(1)
     D pTop            s               *   inz(*NULL)
     D pBot            s               *   inz(*NULL)
     d totlen          s             10i 0 inz(0)
      /free
       ipcFileTmp = %trim(pTmpFile) + x'00';
       fd = openIFS(ipcFileTmp:O_RDONLY);
       if fd > -1;
         pTop = pData;
         pBot = pData + pSize;
         pTmp = %addr(myTmp);
         myLen = %size(myTmp);
         dow len > 0;
           // read up to myLen bytes tmp buffer (yyyyyy...)
           // len < 1 mean EOF
           len = readIFS(fd:pTmp:myLen);
           //            pData        myTmp
           //            xxxxxxxxxx <---------------- shift up (off top)
           //            xxxxxxxxxx
           //            xxxxxxxxxx <---------------- copy needs this spot
           // remain --> 0000000000 < yyyyyyyyyy <--- len (read)
           //            0000000000 < yyyyyyyyyy 
           //                       < yyyyyyyyyy <--- need space
           if len > 0;
             remain = pBot - pTop;
             if remain < len;
               // shift up (off top)
               need   = len - remain;
               cpybytes(pData:pData+need:pSize-need);
               pTop = pBot - len;
             endif;
             cpybytes(pTop:pTmp:len);
             pTop += len;
             totlen = pTop - pData;
           endif;
         enddo;
         // read complete
         rc1 = closeIFS(fd);
       else;
         errsWarning(IPC_ERROR_CRT_TMP_FAIL:ipcFileTmp);
         ipcFileTmp = *BLANKS;
         rc = -1;
       endif;
       if rc > -1;
         return totlen;
       endif;
       return 0;
      /end-free
     P                 E

      *****************************************************
      * xml temp file
      * return (NA)
      *****************************************************
     P ipcRmvXMLf      B                   export
     D ipcRmvXMLf      PI             1N
      * vars
     d rc              s             10i 0 inz(0)
      /free
       if ipcFileTmp <> *BLANKS;
         rc = unlink(ipcFileTmp);
       endif;
       ipcFileTmp = *BLANKS;
       if rc > -1;
         return *ON;
       endif;
       errsWarning(IPC_ERROR_DLT_TMP_FAIL:ipcFileTmp);
       return *OFF;
      /end-free
     P                 E

