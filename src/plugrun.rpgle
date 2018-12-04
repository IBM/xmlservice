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
      /copy pluglic_h
      /copy plugipc_h
      /copy plugpase_h
      /copy plugperf_h
      /copy plugbug_h
      /copy plugmri_h
      /copy plugxml_h
      /copy plugerr_h
      /copy plugsig_h
      /copy plugrun_h
      /copy plugcach_h
      /copy plugconv_h

      *****************************************************
      * run control
      *****************************************************
     D RUN_CLIENT_NADA...
     D                 C                   const(-1)
     D RUN_CLIENT_ATTACH...
     D                 C                   const(0)
     D RUN_CLIENT_RETRY...
     D                 C                   const(1)
     D RUN_CLIENT_START...
     D                 C                   const(2)
     D RUN_CLIENT_MEM...
     D                 C                   const(3)
     D RUN_CLIENT_SEM...
     D                 C                   const(4)
     D RUN_CLIENT_PID_GOOD...
     D                 C                   const(5)
     D RUN_CLIENT_WAIT_USE...
     D                 C                   const(6)
     D RUN_CLIENT_WAIT_COPYIN...
     D                 C                   const(7)
     D RUN_CLIENT_COPYIN...
     D                 C                   const(8)
     D RUN_CLIENT_WAKE_CALL...
     D                 C                   const(9)
     D RUN_CLIENT_WAIT_COPYOUT...
     D                 C                   const(10)
     D RUN_CLIENT_COPYOUT...
     D                 C                   const(11)
     D RUN_CLIENT_REPORT_WRITE...
     D                 C                   const(12)
     D RUN_CLIENT_WAKE_DONE...
     D                 C                   const(13)
     D RUN_CLIENT_FINISH...
     D                 C                   const(14)
     D RUN_CLIENT_REPORT_OUTPUT...
     D                 C                   const(15)
     D RUN_CLIENT_LICENSE...
     D                 C                   const(17)
     D RUN_CLIENT_SESSION...
     D                 C                   const(18)
     D RUN_CLIENT_ERROR...
     D                 C                   const(38)
     D RUN_CLIENT_DESTROY...
     D                 C                   const(39)
     D RUN_CLIENT_DETACH...
     D                 C                   const(40)
      * conversion (*hex *before *after)
     D RUN_CLIENT_CONVERT_BEFORE...
     D                 C                   const(50)
     D RUN_CLIENT_CONVERT_AFTER...
     D                 C                   const(51)

     D RUN_CLIENT_OWN...
     D                 C                   const(55)

     D RUN_SERVER_NADA...
     D                 C                   const(101)
     D RUN_SERVER_SEM_CREATE...
     D                 C                   const(102)
     D RUN_SERVER_MEM_CREATE...
     D                 C                   const(103)
     D RUN_SERVER_WAIT_USE...
     D                 C                   const(104)
     D RUN_SERVER_WAKE_NEW...
     D                 C                   const(105)
     D RUN_SERVER_WAKE_COPYIN...
     D                 C                   const(106)
     D RUN_SERVER_WAIT_CALL...
     D                 C                   const(107)
     D RUN_SERVER_CHECK_DEBUG...
     D                 C                   const(109)
     D RUN_SERVER_INIT...
     D                 C                   const(110)

     D RUN_SERVER_XML_PARSE...
     D                 C                   const(111)
     D RUN_SERVER_XML_HACK...
     D                 C                   const(112)
     D RUN_SERVER_XML_DEAD...
     D                 C                   const(113)
     D RUN_SERVER_XML_TERM...
     D                 C                   const(114)

     D RUN_SERVER_WAKE_COPYOUT...
     D                 C                   const(118)
     D RUN_SERVER_REPORT_WRITE...
     D                 C                   const(119)
     D RUN_SERVER_WAIT_DONE...
     D                 C                   const(120)
     D RUN_SERVER_FINISH...
     D                 C                   const(121)
     D RUN_SERVER_ERROR...
     D                 C                   const(122)
     D RUN_SERVER_DESTROY...
     D                 C                   const(123)

     D RUN_SERVER_XML_SET_BATCH...
     D                 C                   const(124)
     D RUN_SERVER_XML_RUN_BATCH...
     D                 C                   const(125)
     D RUN_SERVER_XML_GET_BATCH...
     D                 C                   const(126)

      * pecl in/out parm
     d aIn             ds                  occurs(5001)
     d   ai151                     3000A
     D pIn             S               *   inz(%addr(aIn))
     
     d aOut            ds                  occurs(5001)
     d   ao151                     3000A
     D pOut            S               *   inz(%addr(aOut))

     D runClient2      PR             1N
     D   pIPCSP                    1024A
     D   pCtlSP                    1024A
     D   pIClob                        *
     D   szIClob                     10i 0
     D   pOClob                        *
     D   szOClob                     10i 0
     D   pIPCSP2                       *   options(*nopass)
     D   szIPCSP2                    10i 0 options(*nopass)
     D   pCtlSP2                       *   options(*nopass)
     D   szCtlSP2                    10i 0 options(*nopass)
     D   pIClob2                       *   options(*nopass)
     D   szIClob2                    10i 0 options(*nopass)
     D   pOClob2                       *   options(*nopass)
     D   szOClob2                    10i 0 options(*nopass)
     D   ccsidPASE2                  10i 0 options(*nopass)
     D   ccsidILE2                   10i 0 options(*nopass)

      *****************************************************
      * rc = runASCII()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P runASCII        B                   export
     D runASCII        PI             1N
     D   pIPCSP2                       *
     D   szIPCSP2                    10i 0
     D   pCtlSP2                       *
     D   szCtlSP2                    10i 0
     D   pIClob2                       *
     D   szIClob2                    10i 0
     D   pOClob2                       *
     D   szOClob2                    10i 0
     D   ccsidPASE2                  10i 0
     D   ccsidILE2                   10i 0
      * vars
     D szIn            s             10i 0 inz(0)
     D szOut           s             10i 0 inz(0)
     D runGood         s              1N   inz(*OFF)
     D pIPC            s           1024A   inz(*BLANKS)
     D pCtl            s           1024A   inz(*BLANKS)
      /free
       szIn = %size(aIn:*ALL);
       szOut = %size(aOut:*ALL);
       return runClient2(pIPC:pCtl:pIn:szIn:pOut:szOut
                        :pIPCSP2:szIPCSP2:pCtlSP2:szCtlSP2
                        :pIClob2:szIClob2:pOClob2:szOClob2
                        :ccsidPASE2:ccsidILE2);
      /end-free
     P                 E

      *****************************************************
      * rc = runClient()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P runClient       B                   export
     D runClient       PI             1N
     D   pIPCSP                    1024A
     D   pCtlSP                    1024A
     D   pIClob                        *
     D   szIClob                     10i 0
     D   pOClob                        *
     D   szOClob                     10i 0
      /free
       return runClient2(pIPCSP:pCtlSP:pIClob:szIClob:pOClob:szOClob);
      /end-free
     P                 E     

      *****************************************************
      * rc = runClient2()
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P runClient2      B
     D runClient2      PI             1N
     D   pIPCSP                    1024A
     D   pCtlSP                    1024A
     D   pIClob                        *
     D   szIClob                     10i 0
     D   pOClob                        *
     D   szOClob                     10i 0
     D   pIPCSP2                       *   options(*nopass)
     D   szIPCSP2                    10i 0 options(*nopass)
     D   pCtlSP2                       *   options(*nopass)
     D   szCtlSP2                    10i 0 options(*nopass)
     D   pIClob2                       *   options(*nopass)
     D   szIClob2                    10i 0 options(*nopass)
     D   pOClob2                       *   options(*nopass)
     D   szOClob2                    10i 0 options(*nopass)
     D   ccsidPASE2                  10i 0 options(*nopass)
     D   ccsidILE2                   10i 0 options(*nopass)

      * vars
     D runGood         s              1N   inz(*ON)
     D runLoop         s              1N   inz(*ON)
     D runExcp         s              1N   inz(*OFF)
     D runConv         s              1N   inz(*OFF)
     D logOk           s              1N   inz(*OFF)

     D status          S             10i 0 inz(RUN_CLIENT_NADA)
 
     D rcb             S              1N   inz(*OFF)
     D rcb2            S              1N   inz(*OFF)
     D rc              S             10i 0 inz(0)
     D myErrno         S             10i 0 inz(0)

     D runMemP         S               *   inz(*NULL)
     D ipcCtl          DS                  likeds(ipcRec_t) based(runMemP)

     D doTimerOn       s              1N   inz(*OFF)
     D timerOn         s              1N   inz(*OFF)
     D timerType       s              1A   inz(*BLANKS)
     D timeAction      s              1A   inz(*BLANKS)
     D timeSeconds     s             10i 0 inz(-1)

     D lo              C                   x'00'
     D up              C                   x'40'
      /free

       // DebugMe('frog went courtin');

       // -------------
       // ascii interface
       if %parms >= 16;
         cacStatic(CAC_LEVEL_ALL);
         // convert ascii to ebcdic control words
         if szCtlSP2 > 0;
           rc = convCCSID2(ccsidPASE2:ccsidILE2
                :pCtlSP2:szCtlSP2
                :%addr(pCtlSP):%size(pCtlSP));
           pCtlSP = %XLATE(lo:up:pCtlSP);
         endif;
       endif;

       // ADC special perf on early (1.6.8)
       perfScan(pCtlSP);

       sigTimerOff();

       // -------------
       // ascii interface
       if %parms >= 16;
         // convert ascii to ebcdic ipc route (internalKey)
         if szIPCSP2 > 0;
           rc = convCCSID2(ccsidPASE2:ccsidILE2
                :pIPCSP2:szIPCSP2
                :%addr(pIPCSP):%size(pIPCSP));
           pIPCSP = %XLATE(lo:up:pIPCSP);
         endif;
         // convert ascii to ebcdic xml input
         if szIClob2 > 0;
           rc = convCCSID2(ccsidPASE2:ccsidILE2
                :pIClob2:szIClob2
                :pIClob:szIClob);
         endif;
       endif;

       // -------------
       // HEY - custom hook (plugconfx)
       runGood = confClient(pIPCSP:pCtlSP:pIClob:szIClob:pOClob:szOClob);
       if runGood = *OFF;
         return *OFF;
       endif;

       // --------------
       // init
       // *ON - reset all memory/flags
       if %parms < 7;
         cacStatic(CAC_LEVEL_ALL);
       endif;
       runMemP = ipcStatic(*ON:pIPCSP:pCtlSP
                :pIClob:szIClob:pOClob:szOClob);
       xmlStatic(runMemP);

       // --------------
       // debug qsysopr message - ZZZZZZ
       if ipcCtl.ipcFlags.doDebugProc = *ON;
         DebugMe(DEBUG_ME_PROC);
       endif;

       // --------------
       // *justproc
       // used to test max speed allowed
       if ipcCtl.ipcFlags.doJustProc = *ON;
         return *ON;
       endif;

       // ADC 1.7.1 logging
       logOk = ipcCtl.ipcFlags.doLog;
       if logOk = *ON;
         perfLogAdd(PERF_LOG_CLIENT_START);
         perfLogId(); 
         perfLogAdd('L_CTL ' + pCtlSP);
         perfAdd(PERF_RUN_CLIENT_LOG_JOBINFO);
       endif;

       // --------------
       // loop forever
       dow runLoop = *ON;

         Monitor;

         // --------------
         // client set timer seconds (Luca IDLE_TIMEOUT)
         doTimerOn = *ON;
         if ipcCtl.ipcFlags.doDebugProc = *ON
         or status = RUN_CLIENT_ERROR 
         or status = RUN_CLIENT_FINISH
         or status = RUN_CLIENT_DETACH
         or status = RUN_CLIENT_DESTROY
         or status = RUN_CLIENT_CONVERT_AFTER; // add (1.8.0)
           doTimerOn = *OFF;
         endif;
         if doTimerOn = *OFF;
           sigTimerOff();
         else;
           sigSetTimeOut(SIG_TIMEOUT_CLIENT:ipcCtl.ipcFlags.doWaitPerm
             :ipcCtl.ipcFlags.doWaitAct:ipcCtl.ipcFlags.doWaitSec);
         endif;
         // what is timer status?
         timerOn = sigLastTimer(timerType:timeAction:timeSeconds);

         select;

         // --------------
         // start
         when status = RUN_CLIENT_NADA;
           status = RUN_CLIENT_ERROR;
           // see plugconf_h
           if PLUGCLIENTALLOW = *OFF;
             iter;
           endif;
           status = RUN_CLIENT_CONVERT_BEFORE;
           perfAdd(PERF_RUN_CLIENT_NADA);

         // -------------
         // do conversion
         // before locking ipc
         // split up CPU performance
         // with other potential clients
         when status = RUN_CLIENT_CONVERT_BEFORE;
           status = RUN_CLIENT_ERROR;
           // --------------
           // hex requested
           if ipcCtl.ipcFlags.doHex = *ON 
           and (ipcCtl.ipcFlags.doHexAct = CONV_HEX_ACTION_INPUT
                or ipcCtl.ipcFlags.doHexAct = CONV_HEX_ACTION_BOTH);
             rcb = convX2B(pIClob:szIClob);
           endif;
           status = RUN_CLIENT_ATTACH;
           // --------------
           // CCSID conversion before requested
           if ipcCtl.ipcFlags.doBef = *ON;
             if ipcCtl.ipcFlags.doNoCall = *ON;
               rc = convCCSID2(ipcCtl.ipcFlags.doBefFrom:ipcCtl.ipcFlags.doBefTo
                    :pIClob:szIClob
                    :pOClob:szOClob);
               status = RUN_CLIENT_CONVERT_AFTER;
             else;
               xmlSidCDATA(ipcCtl.ipcFlags.doBefTo);
               rc = convCCSID2(ipcCtl.ipcFlags.doBefFrom:ipcCtl.ipcFlags.doBefTo
                    :pIClob:szIClob);
             endif;
             if rc < 0;
               status = RUN_CLIENT_ERROR;
             endif;
           endif;
           perfAdd(PERF_RUN_CLIENT_CONVERT_BEFORE);

         // --------------
         // attempt attach
         when status = RUN_CLIENT_ATTACH;
           status = RUN_CLIENT_ERROR;
           if ipcCtl.ipcFlags.doHere = *ON;
             rcb = ipcAttach(*ON);
           else;
             rcb = ipcAttach(*OFF);
           endif;
           if ipcCtl.ipcFlags.doImmed = *ON;
             status = RUN_CLIENT_DESTROY;
           elseif ipcCtl.ipcFlags.doLic = *ON;
             status = RUN_CLIENT_LICENSE;
           elseif ipcCtl.ipcFlags.doSes = *ON;
             status = RUN_CLIENT_SESSION;
           else;
             if ipcCtl.ipcFlags.doSbmJob = *ON;
               rcb2 = xmlPreSbm();
             endif;
             if rcb = *OFF;
               status = RUN_CLIENT_START;
             else;
               status = RUN_CLIENT_PID_GOOD;
             endif;
           endif;
           perfAdd(PERF_RUN_CLIENT_ATTACH);

         // --------------
         // start a new service
         when status = RUN_CLIENT_START;
           status = RUN_CLIENT_ERROR;
           if ipcCtl.ipcFlags.doNoStart = *OFF;
             if ipcCtl.ipcFlags.doSbmJob = *ON;
               rcb = sbmJob();
             else;
               rcb = spawnJob();
             endif;
             if rcb = *ON;
               status = RUN_CLIENT_RETRY;
             endif;
           endif;
           perfAdd(PERF_RUN_CLIENT_START);

         // --------------
         // attempt attach again
         when status = RUN_CLIENT_RETRY;
           status = RUN_CLIENT_ERROR;
           rcb = ipcAttach2();
           if rcb = *ON;
             status = RUN_CLIENT_PID_GOOD;
           endif;
           perfAdd(PERF_RUN_CLIENT_RETRY);

         // -------------
         // xmlserver good
         // expect pid good
         when status = RUN_CLIENT_PID_GOOD;
           status = RUN_CLIENT_ERROR;
           rcb = ipcAlive(myErrno);
           if rcb = *ON;
             status = RUN_CLIENT_OWN;
           else;
             // check not authorized, forget any additional action
             // EPERM 3027 The operation is not permitted.
             if myErrno <> 3027;
               status = RUN_CLIENT_ATTACH;
             endif;
           endif;
           perfAdd(PERF_RUN_CLIENT_PID_GOOD);

         // -------------
         // job owner (reservation)
         // expected to be there
         when status = RUN_CLIENT_OWN;
           status = RUN_CLIENT_ERROR;
           rcb = xmlPreRun();
           rcb = ipcOwnUse(ipcCtl.ipcOwnKey:*OFF);
           if rcb = *ON;
             status = RUN_CLIENT_SEM;
           endif;
           perfAdd(PERF_RUN_CLIENT_OWN);

         // -------------
         // semaphore
         // expected to be there
         when status = RUN_CLIENT_SEM;
           status = RUN_CLIENT_ERROR;
           rcb = ipcLock(*OFF);
           if rcb = *ON;
             status = RUN_CLIENT_WAIT_USE;
           endif;
           perfAdd(PERF_RUN_CLIENT_SEM);

         // -------------
         // wait to use
         // racing other clients, 
         // is it my turn yet?
         when status = RUN_CLIENT_WAIT_USE;
           status = RUN_CLIENT_ERROR;
           rcb = ipcClientWaitUse();
           if rcb = *ON;
             status = RUN_CLIENT_WAIT_COPYIN;
           endif;
           perfAdd(PERF_RUN_CLIENT_WAIT_USE);

         // -------------
         // wait to talk
         // server ok for copy in?
         when status = RUN_CLIENT_WAIT_COPYIN;
           status = RUN_CLIENT_ERROR;
           rcb = ipcClientWaitCopyIn();
           if rcb = *ON;
             status = RUN_CLIENT_COPYIN;
           endif;
           perfAdd(PERF_RUN_CLIENT_WAIT_COPYIN);

         //-------------
         // copy in
         when status = RUN_CLIENT_COPYIN;
           status = RUN_CLIENT_ERROR;
           rcb = ipcOwnUse(ipcCtl.ipcOwnKey:*ON);
           if rcb = *ON;
             runMemP = ipcCopyIn(*OFF:runMemP);
             status = RUN_CLIENT_WAKE_CALL;
           else;
             rcb = xmlError(*ON:*ON);
             status = RUN_CLIENT_WAKE_DONE;
           endif;
           perfAdd(PERF_RUN_CLIENT_COPYIN);

         // --------------
         // allow other side ipc
         // copy in complete,
         // ask server make the call
         when status = RUN_CLIENT_WAKE_CALL;
           status = RUN_CLIENT_ERROR;
           rcb = ipcClientRequestRunXML();
           // call server in-line
           if ipcCtl.ipcFlags.doHere = *ON;
             rcb = runServer(pIPCSP);
           endif;
           if rcb = *ON;
             status = RUN_CLIENT_WAIT_COPYOUT;
           endif;
           perfAdd(PERF_RUN_CLIENT_WAKE_CALL);

         // -------------
         // wait to talk
         // server call complete for copyout?
         when status = RUN_CLIENT_WAIT_COPYOUT;
           status = RUN_CLIENT_ERROR;
           // call set timer seconds (Luca IDLE_TIMEOUT)
           sigSetTimeOut(SIG_TIMEOUT_CALL_CLIENT:ipcCtl.ipcFlags.doCallPerm1
               :ipcCtl.ipcFlags.doCallAct1:ipcCtl.ipcFlags.doCallSec1);
           // what is timer status?
           timerOn = sigLastTimer(timerType:timeAction:timeSeconds);
           // zzzz - waiting for program calls
           rcb = ipcClientWaitCopyOut();
           // check client side left
           // the party early due to
           // timeout pop
           if ipcCtl.ipcBusyIAm = *ON;
             status = RUN_CLIENT_ERROR;
           elseif rcb = *ON;
             status = RUN_CLIENT_COPYOUT;
           endif;
           perfAdd(PERF_RUN_CLIENT_WAIT_COPYOUT);

         // -------------
         // copy out
         // server call complete?
         when status = RUN_CLIENT_COPYOUT;
           status = RUN_CLIENT_ERROR;
           // nothing ???
           if ipcCtl.ipcFlags.doRpt = *ON;
             status = RUN_CLIENT_REPORT_OUTPUT;
           elseif ipcCtl.ipcFlags.doHere = *ON
           and ipcCtl.ipcFlags.doFly = *ON;
             ipcCtl.ipcFlags.doRpt = *ON;
             ipcCtl.ipcFlags.doFly = *OFF;
             status = RUN_CLIENT_REPORT_OUTPUT;
           else;
             status = RUN_CLIENT_REPORT_WRITE;
           endif;
           perfAdd(PERF_RUN_CLIENT_COPYOUT);
           // ADC 1.7.1 logging
           if logOk = *ON;
             perfLogAdd(PERF_LOG_CLIENT_END);
           endif;

         // --------------
         // full performance report 
         when status = RUN_CLIENT_REPORT_OUTPUT;
           status = RUN_CLIENT_ERROR;
           xmlOutReset();
           rcb = xmlPerf(ipcCtl);
           status = RUN_CLIENT_REPORT_WRITE;

         // --------------
         // write performance report
         when status = RUN_CLIENT_REPORT_WRITE;
           status = RUN_CLIENT_ERROR;
           // perf report data
           rcb = ipcIsOk();
           if rcb = *ON;
             if ipcCtl.ipcFlags.doFly = *ON
             and ipcCtl.ipcFlags.doRpt = *OFF;
               rcb = perfSave(%addr(ipcCtl.ipcTmClt)
                           :%size(ipcCtl.ipcTmClt));
             endif;
           endif;
           status = RUN_CLIENT_WAKE_DONE;

         // --------------
         // allow other side ipc
         // server released
         when status = RUN_CLIENT_WAKE_DONE;
           status = RUN_CLIENT_ERROR;
           rcb = ipcClientDoneRelease();
           if rcb = *ON;
             status = RUN_CLIENT_FINISH;
           endif;

         // --------------
         // license report 
         when status = RUN_CLIENT_LICENSE;
           status = RUN_CLIENT_ERROR;
           rcb = xmlLic();
           status = RUN_CLIENT_FINISH;

         // --------------
         // session report 
         when status = RUN_CLIENT_SESSION;
           status = RUN_CLIENT_ERROR;
           rcb = xmlSess();
           status = RUN_CLIENT_FINISH;

         // --------------
         // bad news
         when status = RUN_CLIENT_ERROR;
           runGood = *OFF;
           // least one error
           errsWarning(CALL_ERROR_RUN_FAIL);
           rcb = xmlError(*ON:*ON);
           cacStatic(CAC_LEVEL_HEAP);
           status = RUN_CLIENT_CONVERT_AFTER;

         // --------------
         // finshed
         when status = RUN_CLIENT_FINISH;
           status = RUN_CLIENT_CONVERT_AFTER;

         // -------------
         // do conversion
         // after locking ipc
         // split up CPU performance
         // with other potential clients
         when status = RUN_CLIENT_CONVERT_AFTER;
           status = RUN_CLIENT_ERROR;
           // --------------
           // CCSID conversion after requested
           rc = 0;
           if ipcCtl.ipcFlags.doAft = *ON and runConv = *OFF;
             rc = convCCSID2(ipcCtl.ipcFlags.doAftFrom:ipcCtl.ipcFlags.doAftTo
                  :pOClob:szOClob);
             xmlResetCDATA();
           endif;
           // --------------
           // hex requested
           rcb = *ON;
           if (rc > -1 or runConv = *ON)
           and ipcCtl.ipcFlags.doHex = *ON 
           and (ipcCtl.ipcFlags.doHexAct = CONV_HEX_ACTION_OUTPUT
                or ipcCtl.ipcFlags.doHexAct = CONV_HEX_ACTION_BOTH);
             rcb = convB2X(pOClob:szOClob);
           endif;
           if  runConv = *ON 
           or  (rc > -1 and rcb = *ON);
             status = RUN_CLIENT_DETACH;
           endif;
           // --------------
           // ascii interface
           if %parms >= 16;
             if szOClob2 > 0;
               // convert ebcdic to ascii xml output
               szOClob = strlen(pOClob);
               rc = convCCSID2(ccsidILE2:ccsidPASE2
                    :pOClob:szOClob
                    :pOClob2:szOClob2);
             endif;
             // clear used portions 
             // convert temp buffers 
             // for clean use next call
             szOClob = strlen(pOClob);
             memset(pOClob:0:szOClob);
             szIClob = strlen(pIClob);
             memset(pIClob:0:szIClob);
           endif;
           runConv = *ON; // no recursion

         // -------------
         // detach IPC
         when status = RUN_CLIENT_DETACH;
           status = RUN_CLIENT_ERROR;
           rcb = ipcDetach();
           leave;

         // -------------
         // destroy IPC
         when status = RUN_CLIENT_DESTROY;
           status = RUN_CLIENT_ERROR;
           ipcEndJobImmed();
           leave;

         // --------------
         // ???
         other;
           DebugMe(DEBUG_ME_PROC);
         endsl;

         // -------------
         // exception
         On-error;
           status = RUN_CLIENT_ERROR;
           if runExcp = *ON;
             leave;
           endif;
           runGood = *OFF;
           runExcp = *ON; // no recursion
         Endmon;


       // -------------
       // end loop
       enddo;

       // -------------
       // HEY - custom hook (plugconfx)
       runGood = confCltOut(runGood:pOClob:szOClob);

       // -------------
       // make sure timer off (1.8.0)
       sigTimerOff();

       return runGood;
      /end-free
     P                 E

      *****************************************************
      * rc = runServer(path)
      * return (*ON=good; *OFF=bad)
      *****************************************************
     P runServer       B                   export
     D runServer       PI             1N
     D   pIPCSP                    1024A

      * vars
     D runGood         s              1N   inz(*ON)
     D runLoop         s              1N   inz(*ON)
     D runDead         s              1N   inz(*OFF)
     D runExcp         s              1N   inz(*OFF)

     D status          s             10i 0 inz(RUN_SERVER_NADA)

     D rcb             S              1N   inz(*OFF)
     D rc              S             10i 0 inz(0)

     D runMemP         S               *   inz(*NULL)
     D ipcCtl          DS                  likeds(ipcRec_t) based(runMemP)

     D doTimerOn       s              1N   inz(*OFF)
     D timerOn         s              1N   inz(*OFF)
     D timerType       s              1A   inz(*BLANKS)
     D timeAction      s              1A   inz(*BLANKS)
     D timeSeconds     s             10i 0 inz(-1)
      /free
       sigTimerOff();

       // -------------
       // HEY - custom hook (plugconfx)
       rcb = confStart(pIPCSP);
       if rcb = *OFF;
         return *OFF;
       endif;

          // DebugMe('frog went courtin');


       // --------------
       // init
       // *OFF 
       // - if *here then good memory/flags (from client)
       // - if *sbmjob then fake memory/flags (from start)
       runMemP = ipcStatic(*OFF:pIPCSP:*BLANKS
                          :*NULL:0:*NULL:0);
       xmlStatic(runMemP);

       // --------------
       // loop forever
       dow runLoop = *ON;

         Monitor;

         // --------------
         // server set timer seconds (Luca IDLE_TIMEOUT)
         doTimerOn = *ON;
         if ipcCtl.ipcFlags.doDebug = *ON
         or status = RUN_SERVER_ERROR;
           doTimerOn = *OFF;
         endif;
         if doTimerOn = *OFF;
           sigTimerOff();
         else;
           sigSetTimeOut(SIG_TIMEOUT_SERVER:ipcCtl.ipcFlags.doIdlePerm
               :ipcCtl.ipcFlags.doIdleAct:ipcCtl.ipcFlags.doIdleSec);
         endif;
         // what is timer status?
         timerOn = sigLastTimer(timerType:timeAction:timeSeconds);

         select;
         // --------------
         // start
         when status = RUN_SERVER_NADA;
           status = RUN_SERVER_ERROR;
           if ipcCtl.ipcFlags.doHere = *OFF;
             cacStatic(CAC_LEVEL_ALL);
           endif;
           status = RUN_SERVER_SEM_CREATE;
           perfAdd(PERF_RUN_SERVER_NADA);

         // --------------
         // create ipc semaphores
         when status = RUN_SERVER_SEM_CREATE;
           status = RUN_SERVER_ERROR;
           rcb = ipcLock(*ON);
           if rcb = *ON;
             status = RUN_SERVER_MEM_CREATE;
           endif;
           perfAdd(PERF_RUN_SERVER_SEM_CREATE);

         // --------------
         // create ipc shared memory
         when status = RUN_SERVER_MEM_CREATE;
           status = RUN_SERVER_ERROR;
           if ipcCtl.ipcFlags.doHere = *ON;
             rcb = *ON; // already attached
           else;
             rcb = ipcAttach(*ON);
           endif;
           if rcb = *ON;
            status = RUN_SERVER_WAIT_USE;
           endif;
           perfAdd(PERF_RUN_SERVER_MEM_CREATE);

         // -------------
         // wait to use (never wait)
         when status = RUN_SERVER_WAIT_USE;
           status = RUN_SERVER_ERROR;
           runGood = *ON;
           rcb = ipcServerWaitUse();
           if rcb = *ON;
             if ipcCtl.ipcFlags.doHere = *ON;
               status = RUN_SERVER_WAKE_NEW;
             else;
               // client released reservation
               // at end of this script.
               // we have IPC eclusive,
               // so just clear it right now
               if ipcCtl.ipcFlags.doOwnEnd = *ON;
                 ipcCtl.ipcOwnKey = *BLANKS;
                 ipcCtl.ipcFlags.doOwnEnd = *OFF;
               endif;
               // ipc reset (no stale batch state)
               runMemP = ipcStatic(*OFF:pIPCSP:*BLANKS
                          :*NULL:0:*NULL:0);
               ipcCtl.ipcIClobP    = *NULL;
               ipcCtl.ipcOClobP    = *NULL;
               ipcCtl.ipcIClobSz   = 0;
               ipcCtl.ipcOClobSz   = 0;
               runMemP = ipcCopyIn(*ON:runMemP);
               xmlStatic(runMemP);
               perfInit(*OFF:*OFF);
               // before we handle a new client,
               // any batch processing to do?
               ipcCtl.ipcFlags.doBatNbr = xmlBatAny();
               if ipcCtl.ipcFlags.doBatNbr > 0;
                 status = RUN_SERVER_XML_RUN_BATCH;
               else;
                 status = RUN_SERVER_WAKE_NEW;
               endif;
             endif;
           endif;
           perfAdd(PERF_RUN_SERVER_WAIT_USE);

         // -------------
         // accept a client
         when status = RUN_SERVER_WAKE_NEW;
           status = RUN_SERVER_ERROR;
           rcb = ipcServerAcceptClient();
           if rcb = *ON;
             status = RUN_SERVER_WAKE_COPYIN;
           endif;
           perfAdd(PERF_RUN_SERVER_WAKE_NEW);

         // --------------
         // allow other side ipc
         // ask client to copy in
         when status = RUN_SERVER_WAKE_COPYIN;
           status = RUN_SERVER_ERROR;
           rcb = ipcServerAcceptCopyIn();
           if rcb = *ON;
             status = RUN_SERVER_WAIT_CALL;
           endif;

         // -------------
         // wait to talk
         // client copy in complete?
         when status = RUN_SERVER_WAIT_CALL;
           status = RUN_SERVER_ERROR;
           rcb = ipcServerWaitCopyIn();
           // client left early due to wrong
           // key reservation exclusive use
           // take a new client
           if ipcCtl.ipcOwnBad = *ON;
             ipcCtl.ipcOwnBad = *OFF;
             status = RUN_SERVER_WAIT_USE;
           elseif rcb = *ON;
             // reset buffers to client location
             runMemP = ipcRunMem();
             xmlStatic(runMemP);
             perfInit(ipcCtl.ipcFlags.doFly:ipcCtl.ipcFlags.doLog);
             perfLogId(); 
             // PASE CCSID conversion @ADC (1.7.6)
             if ipcCtl.ipcFlags.doPase = *ON;
               ccsidPASE(ipcCtl.ipcFlags.doPasePASE);
               ccsidILE(ipcCtl.ipcFlags.doPaseILE);
             endif;
             status = RUN_SERVER_INIT;
           endif;
           perfAdd(PERF_RUN_SERVER_WAKE_COPYIN);


         // --------------
         // xml init
         // xml must be null term
         when status = RUN_SERVER_INIT;
           status = RUN_SERVER_ERROR;
           // -------------
           // HEY - custom hook (plugconfx)
           rcb = confAccept(runMemP);
           if rcb = *OFF;
             status = RUN_SERVER_WAKE_COPYOUT;
           else;
             // set control flags from client
             if ipcCtl.ipcFlags.doHere = *ON;
               rcb = *ON; // already running
             else;
               // *** clear PGM cache/PASE ***
               if ipcCtl.ipcFlags.doClear = *ON;
                 cacStatic(CAC_LEVEL_SQL);
               endif;
             endif;
             status = RUN_SERVER_CHECK_DEBUG;
           endif;
           perfAdd(PERF_RUN_SERVER_INIT);

         // --------------
         // *debug
         // wait for debug zzzz...
         when status = RUN_SERVER_CHECK_DEBUG;
           status = RUN_SERVER_ERROR;
           if ipcCtl.ipcFlags.doDebug = *ON;
             DebugMe(DEBUG_ME_SERV);
           endif;
           // set up batch XML input (process later)
           if ipcCtl.ipcFlags.doBatch = *ON;
             ipcCtl.ipcFlags.doBatch = *OFF;
             status = RUN_SERVER_XML_SET_BATCH;
           // get batch input (if available)
           elseif ipcCtl.ipcFlags.doGet = *ON;
             ipcCtl.ipcFlags.doGet = *OFF;
             status = RUN_SERVER_XML_GET_BATCH;
           // normal client attach
           else;
             status = RUN_SERVER_XML_PARSE;
           endif;

         // --------------
         // xml set batch 
         when status = RUN_SERVER_XML_SET_BATCH;
           status = RUN_SERVER_ERROR;
           // find a batch XML input slot
           // and release client (async),
           // XML report batch slot nbr
           // returned or full report (retry)
           rcb = xmlBatCopy(runMemP);
           status = RUN_SERVER_REPORT_WRITE;
           perfAdd(PERF_RUN_SERVER_SET_BATCH);

         // --------------
         // xml run batch 
         when status = RUN_SERVER_XML_RUN_BATCH;
           status = RUN_SERVER_ERROR;
           // set the io buffers to batch area (not IPC)
           // run batch XML with stored doflags
           rcb = xmlBatXML(runMemP);
           if rcb = *ON;
             // reset buffers to client location (or batch)
             runMemP = ipcCopyIn(*ON:runMemP);
             xmlStatic(runMemP);
             perfInit(ipcCtl.ipcFlags.doFly:ipcCtl.ipcFlags.doLog);
             status = RUN_SERVER_XML_PARSE;
           else;
             status = RUN_SERVER_XML_DEAD;
           endif;
           perfAdd(PERF_RUN_SERVER_RUN_BATCH);

         // --------------
         // xml parse me in 
         when status = RUN_SERVER_XML_PARSE;
           status = RUN_SERVER_ERROR;
           // server set timer seconds (Luca IDLE_TIMEOUT)
           sigSetTimeOut(SIG_TIMEOUT_CALL_SERVER:ipcCtl.ipcFlags.doCallPerm2
               :ipcCtl.ipcFlags.doCallAct2:ipcCtl.ipcFlags.doCallSec2);
           // what is timer status?
           timerOn = sigLastTimer(timerType:timeAction:timeSeconds);
           // run the xml document (execute)
           rcb = xmlRun();
           // post execute behavior
           if rcb = *ON;
             status = RUN_SERVER_XML_HACK;
           else;
             status = RUN_SERVER_XML_DEAD;
           endif;
           perfAdd(PERF_RUN_SERVER_XML_PARSE);

         // --------------
         // xml parse do hack
         when status = RUN_SERVER_XML_HACK;
           status = RUN_SERVER_ERROR;
           if ipcCtl.ipcFlags.doHack = *ON;
             rcb = xmlHack();
           endif;
           status = RUN_SERVER_XML_TERM;
           perfAdd(PERF_RUN_SERVER_XML_HACK);

         // --------------
         // xml parse do hack
         when status = RUN_SERVER_XML_DEAD;
           status = RUN_SERVER_ERROR;
           runDead = *ON;
           // report all errors
           // collected to client
           rcb = xmlError(*ON:*ON);
           cacStatic(CAC_LEVEL_HEAP);
           status = RUN_SERVER_XML_TERM;
           perfAdd(PERF_RUN_SERVER_XML_DEAD);

         // --------------
         // xml parse completed
         when status = RUN_SERVER_XML_TERM;
           status = RUN_SERVER_ERROR;
           // mark end of report
           // possible bad drivers
           rcb = xmlTerm();
           // XML batch run ...
           // record size XML output for get
           // go directly to cleanup (no client)
           if ipcCtl.ipcFlags.doBatNbr > 0;
             xmlBatDone(runMemP);
             status = RUN_SERVER_FINISH;
           else;
             status = RUN_SERVER_REPORT_WRITE;
           endif;
           perfAdd(PERF_RUN_SERVER_XML_TERM);

         // --------------
         // xml get batch results
         when status = RUN_SERVER_XML_GET_BATCH;
           status = RUN_SERVER_ERROR;
           rcb = xmlBatGet(runMemP);
           status = RUN_SERVER_REPORT_WRITE;
           perfAdd(PERF_RUN_SERVER_GET_BATCH);

         // -------------
         // performance report
         when status = RUN_SERVER_REPORT_WRITE;
           status = RUN_SERVER_ERROR;
           // perf report data
           rcb = ipcIsOk();
           if rcb = *ON;
             if ipcCtl.ipcFlags.doFly = *ON
             and ipcCtl.ipcFlags.doRpt = *OFF;
               rcb = perfSave(%addr(ipcCtl.ipcTmSrv)
                           :%size(ipcCtl.ipcTmSrv));
             endif;
           endif;
           status = RUN_SERVER_WAKE_COPYOUT;

         // --------------
         // allow other side ipc
         // made the call,
         // ask client to copy out
         when status = RUN_SERVER_WAKE_COPYOUT;
           status = RUN_SERVER_ERROR;
           // check client side left
           // the party early due to
           // timeout and go handle
           // next client (or batch)
           if ipcCtl.ipcBusyIAm = *ON;
              status = RUN_SERVER_FINISH;
           else;
             rcb = ipcServerDoneCopyOut();
             if rcb = *ON;
               status = RUN_SERVER_WAIT_DONE;
             endif;
           endif;

         // -------------
         // wait to talk
         // client copy out complete?
         when status = RUN_SERVER_WAIT_DONE;
           status = RUN_SERVER_ERROR;
           // -------------
           // HEY - custom hook (plugconfx)
           runDead = confSrvOut(runDead:runMemP);
           rcb = ipcServerWaitCopyOut();
           if rcb = *ON;
             status = RUN_SERVER_FINISH;
           endif;

         // -------------
         // complete
         // recoverable, 
         // but PASE maybe dies
         when status = RUN_SERVER_FINISH;
           if ipcCtl.ipcFlags.doHere = *ON;
             leave;
           endif;
           if runDead = *ON;
             runDead = *OFF;
             cacStatic(CAC_LEVEL_SQL);
           else;
             cacStatic(CAC_LEVEL_ERROR);
           endif;
           status = RUN_SERVER_WAIT_USE;

         // -------------
         // error
         when status = RUN_SERVER_ERROR;
           runGood = *OFF;
           if ipcCtl.ipcFlags.doHere = *ON;
             leave;
           endif;
           status = RUN_SERVER_DESTROY;

         // -------------
         // error
         when status = RUN_SERVER_DESTROY;
           ipcEndJobImmed();
           leave;

         // --------------
         // ???
         other;
           DebugMe(DEBUG_ME_SERV);
         endsl;

         // ------------
         // exception
         On-error;
           status = RUN_SERVER_ERROR;
           if runExcp = *ON;
             leave;
           endif;
           runExcp = *ON;
           runGood = *OFF;
         Endmon;

       // -------------
       // end loop
       enddo;

       // ok
       return runGood;

      /end-free
     P                 E

