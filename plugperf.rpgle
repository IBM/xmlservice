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
      /copy plugperf_h
      /copy plugmri_h
      /copy plugcach_h
      /copy plugxml_h
      /copy plugipc_h
      /copy plugile_h
      /copy plugpase_h
      /copy plugconv_h
      /copy plugcli_h
      /copy plugbug_h

      *****************************************************
      * global variables
      *****************************************************
     D sFlyMe          S              1N   inz(*OFF)
     D sLogMe          S              1N   inz(*OFF)
     
     D log_query...        
     D                 PR             1N
     D  stmt_str                       *   value
     D  stmt_len                     10I 0 value
     D  fetch_str                      *   value options(*nopass)
     D  fetch_len                    10I 0 value options(*nopass)


      *****************************************************
      * flight record on/off
      *****************************************************
     P perfLogOn       B                   export
     D perfLogOn       PI             1N
      * vars
      /free
       return sLogMe;
      /end-free
     P                 E

      *****************************************************
      * perfInit
      * return (NA)
      *****************************************************
     P perfScan        B                   export
     D perfScan        PI
     D   pCtlSP                    1024A
      * vars
     D fly             S              1N   inz(*OFF)
     D log             S              1N   inz(*OFF)
     D pos             S             10i 0 inz(0)
      /free
       // ADC special perf on early (1.7.1)
       pos = %scan(%trim(xNOLOG):pCtlSP);
       if pos > 0;
         log = *OFF;
       endif;
       // ADC special perf on early (1.7.1)
       pos = %scan(%trim(xDOLOG):pCtlSP);
       if pos > 0;
         log = *ON;
       endif;
       // ADC special perf on early (1.6.8)
       pos = %scan(%trim(xDOFLY):pCtlSP);
       if pos > 0;
         fly = *ON;
       endif;
       // *here - start over stateless
       if fly = *ON;
         pos = %scan(%trim(xHERE):pCtlSP);
         if pos > 0;
           sFlyMe = *OFF;
         endif;
       endif;
       perfInit(fly:log);
      /end-free
     P                 E

     P perfInit        B                   export
     D perfInit        PI
     D   fly                          1N   value
     D   log                          1N   value
      * vars
      /free
       // log on??
       sLogMe = log;
       // already on
       if sFlyMe = *ON and fly = *ON;
         return;
       endif;
       sFlyMe = fly;
       // see plugconf_h
       if PLUGPERFALLOW = *OFF;
         sFlyMe = *OFF;
       endif;
       if sFlyMe = *ON;
         cacClrPrf();
         perfAdd(PERF_RUN_START);
       endif;
      /end-free
     P                 E

      *****************************************************
      * perfAdd
      * return (NA)
      *****************************************************
     P perfAdd         B                   export
     D perfAdd         PI
     D   myCode                       5i 0 value
     D   myOnOff                      1N   value options(*nopass)
      * vars
     D rc              S             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D sec             S             10i 0 inz(0)
     D usec            S             10i 0 inz(1)
      * vars
     D msgOut          S             32A   inz(*BLANKS)
      /free
       // see plugconf_h
       if sLogMe = *ON;
         if myCode <> PERF_RUN_START; // @ADC 1.7.3
           msgOut = perfMsgTxt(myCode);
           confLogPop(msgOut);
         endif;
       endif;
       // see plugconf_h
       if PLUGPERFALLOW = *OFF or sFlyMe = *OFF;
         return;
       endif;
       if %parms >= 2;
         cacAddPrf(myCode:myOnOff);
       else;
         cacAddPrf(myCode);
       endif;
      /end-free
     P                 E

      *****************************************************
      * perfSave - data
      * return (NA)
      *****************************************************
     P perfSave        B                   export
     D perfSave        PI             1N
     D   rptBuff                       *   value
     D   rptLen                      10i 0 value
      * vars
     D len             S             10i 0 inz(0)
     D i               S             10i 0 inz(0)
     D j               S             10i 0 inz(0)
      /free
       // see plugconf_h
       if PLUGPERFALLOW = *OFF or sFlyMe = *OFF;
         return *OFF;
       endif;
       return cacScanPrf(rptBuff:rptLen);
      /end-free
     P                 E


      *****************************************************
      * perfMsgTxt
      * return (message)
      *****************************************************
     P perfMsgTxt      B                   export
     D perfMsgTxt      PI            32A
     D   errXml                       5i 0 value
      * vars
     D msgOut          S             32A   inz(*BLANKS)
      /free
       select;

       when errXml = PERF_RUN_CLIENT_NADA;
         msgOut    = PERF_MSG_CLIENT_NADA;
       when errXml = PERF_RUN_CLIENT_CONVERT_BEFORE;
         msgOut    = PERF_MSG_CLIENT_CONVERT_BEFORE;
       when errXml = PERF_RUN_CLIENT_ATTACH;
         msgOut    = PERF_MSG_CLIENT_ATTACH;
       when errXml = PERF_RUN_CLIENT_START;
         msgOut    = PERF_MSG_CLIENT_START;
       when errXml = PERF_RUN_CLIENT_RETRY;
         msgOut    = PERF_MSG_CLIENT_RETRY;
       when errXml = PERF_RUN_CLIENT_PID_GOOD;
         msgOut    = PERF_MSG_CLIENT_PID_GOOD;
       when errXml = PERF_RUN_CLIENT_OWN;
         msgOut    = PERF_MSG_CLIENT_OWN;
       when errXml = PERF_RUN_CLIENT_SEM;
         msgOut    = PERF_MSG_CLIENT_SEM;
       when errXml = PERF_RUN_CLIENT_WAIT_USE;
         msgOut    = PERF_MSG_CLIENT_WAIT_USE;
       when errXml = PERF_RUN_CLIENT_WAIT_COPYIN;
         msgOut    = PERF_MSG_CLIENT_WAIT_COPYIN;
       when errXml = PERF_RUN_CLIENT_COPYIN;
         msgOut    = PERF_MSG_CLIENT_COPYIN;
       when errXml = PERF_RUN_CLIENT_WAKE_CALL;
         msgOut    = PERF_MSG_CLIENT_WAKE_CALL;
       when errXml = PERF_RUN_CLIENT_WAIT_COPYOUT;
         msgOut    = PERF_MSG_CLIENT_WAIT_COPYOUT;
       when errXml = PERF_RUN_CLIENT_COPYOUT;
         msgOut    = PERF_MSG_CLIENT_COPYOUT;
       when errXml = PERF_RUN_CLIENT_LOG_JOBINFO;
         msgOut    = PERF_MSG_CLIENT_LOG_JOBINFO;

       when errXml = PERF_RUN_SERVER_NADA;
         msgOut    = PERF_MSG_SERVER_NADA;
       when errXml = PERF_RUN_SERVER_SEM_CREATE;
         msgOut    = PERF_MSG_SERVER_SEM_CREATE;
       when errXml = PERF_RUN_SERVER_MEM_CREATE;
         msgOut    = PERF_MSG_SERVER_MEM_CREATE;
       when errXml = PERF_RUN_SERVER_WAIT_USE;
         msgOut    = PERF_MSG_SERVER_WAIT_USE;
       when errXml = PERF_RUN_SERVER_WAKE_NEW;
         msgOut    = PERF_MSG_SERVER_WAKE_NEW;
       when errXml = PERF_RUN_SERVER_WAKE_COPYIN;
         msgOut    = PERF_MSG_SERVER_WAKE_COPYIN;
       when errXml = PERF_RUN_SERVER_WAIT_CALL;
         msgOut    = PERF_MSG_SERVER_WAIT_CALL;
       when errXml = PERF_RUN_SERVER_INIT;
         msgOut    = PERF_MSG_SERVER_INIT;
       when errXml = PERF_RUN_SERVER_SET_BATCH;
         msgOut    = PERF_MSG_SERVER_SET_BATCH;
       when errXml = PERF_RUN_SERVER_RUN_BATCH;
         msgOut    = PERF_MSG_SERVER_RUN_BATCH;
       when errXml = PERF_RUN_SERVER_GET_BATCH;
         msgOut    = PERF_MSG_SERVER_GET_BATCH;
       when errXml = PERF_RUN_SERVER_XML_PARSE;
         msgOut    = PERF_MSG_SERVER_XML_PARSE;
       when errXml = PERF_RUN_SERVER_XML_HACK;
         msgOut    = PERF_MSG_SERVER_XML_HACK;
       when errXml = PERF_RUN_SERVER_XML_DEAD;
         msgOut    = PERF_MSG_SERVER_XML_DEAD;
       when errXml = PERF_RUN_SERVER_XML_TERM;
         msgOut    = PERF_MSG_SERVER_XML_TERM;

       when errXml = PERF_XML_SERVER_PGM_RUN1;
         msgOut    = PERF_MSG_SERVER_PGM_RUN1;
       when errXml = PERF_XML_SERVER_PGM_RUN2;
         msgOut    = PERF_MSG_SERVER_PGM_RUN2;
       when errXml = PERF_XML_SERVER_PGM_COPYIN1;
         msgOut    = PERF_MSG_SERVER_PGM_COPYIN1;
       when errXml = PERF_XML_SERVER_PGM_COPYIN2;
         msgOut    = PERF_MSG_SERVER_PGM_COPYIN2;
       when errXml = PERF_XML_SERVER_PGM_CALL1;
         msgOut    = PERF_MSG_SERVER_PGM_CALL1;
       when errXml = PERF_XML_SERVER_PGM_CALL2;
         msgOut    = PERF_MSG_SERVER_PGM_CALL2;
       when errXml = PERF_XML_SERVER_PGM_COPYOUT1;
         msgOut    = PERF_MSG_SERVER_PGM_COPYOUT1;
       when errXml = PERF_XML_SERVER_PGM_COPYOUT2;
         msgOut    = PERF_MSG_SERVER_PGM_COPYOUT2;
       when errXml = PERF_XML_SERVER_PGM_ATTR1;
         msgOut    = PERF_MSG_SERVER_PGM_ATTR1;
       when errXml = PERF_XML_SERVER_PGM_ATTR2;
         msgOut    = PERF_MSG_SERVER_PGM_ATTR2;
       when errXml = PERF_XML_SERVER_PGM_INIT1;
         msgOut    = PERF_MSG_SERVER_PGM_INIT1;
       when errXml = PERF_XML_SERVER_PGM_INIT2;
         msgOut    = PERF_MSG_SERVER_PGM_INIT2;
       when errXml = PERF_XML_SERVER_PGM_ASSIST1;
         msgOut    = PERF_MSG_SERVER_PGM_ASSIST1;
       when errXml = PERF_XML_SERVER_PGM_ASSIST2;
         msgOut    = PERF_MSG_SERVER_PGM_ASSIST2;

       when errXml = PERF_XML_SERVER_CMD_RUN1;
         msgOut    = PERF_MSG_SERVER_CMD_RUN1;
       when errXml = PERF_XML_SERVER_CMD_RUN2;
         msgOut    = PERF_MSG_SERVER_CMD_RUN2;

       when errXml = PERF_XML_SERVER_SH_RUN1;
         msgOut    = PERF_MSG_SERVER_SH_RUN1;
       when errXml = PERF_XML_SERVER_SH_RUN2;
         msgOut    = PERF_MSG_SERVER_SH_RUN2;

       when errXml = PERF_XML_SERVER_SQL_RUN1;
         msgOut    = PERF_MSG_SERVER_SQL_RUN1;
       when errXml = PERF_XML_SERVER_SQL_RUN2;
         msgOut    = PERF_MSG_SERVER_SQL_RUN2;

       when errXml = PERF_XML_SERVER_DIAG_RUN1;
         msgOut    = PERF_MSG_SERVER_DIAG_RUN1;
       when errXml = PERF_XML_SERVER_DIAG_RUN2;
         msgOut    = PERF_MSG_SERVER_DIAG_RUN2;

       when errXml = PERF_XML_SERVER_ERROR_JOBLOG;
         msgOut    = PERF_MSG_SERVER_ERROR_JOBLOG;
         
       when errXml = PERF_XML_SERVER_RUN_SUCCESS;
         msgOut    = PERF_MSG_SERVER_RUN_SUCCESS;
       when errXml = PERF_XML_SERVER_RUN_ERROR;
         msgOut    = PERF_MSG_SERVER_RUN_ERROR;

       when errXml = PERF_ANY_WATCH_BIGJUNK;
         msgOut    = PERF_MSG_WATCH_BIGJUNK;
       when errXml = PERF_ANY_WATCH_BIGSCAN;
         msgOut    = PERF_MSG_WATCH_BIGSCAN;
       when errXml = PERF_ANY_WATCH_BIGDIM;
         msgOut    = PERF_MSG_WATCH_BIGDIM;
       when errXml = PERF_ANY_WATCH_BIGELEM;
         msgOut    = PERF_MSG_WATCH_BIGELEM;
       when errXml = PERF_ANY_WATCH_BIGDIMOPT;
         msgOut    = PERF_MSG_WATCH_BIGDIMOPT;
       when errXml = PERF_ANY_WATCH_TIMER;
         msgOut    = PERF_MSG_WATCH_TIMER;

       when errXml = PERF_ANY_WATCH_CACHE;
         msgOut    = PERF_MSG_WATCH_CACHE;
       when errXml = PERF_ANY_WATCH_XMLSTATIC;
         msgOut    = PERF_MSG_WATCH_XMLSTATIC;
       when errXml = PERF_ANY_WATCH_IPCSTATIC;
         msgOut    = PERF_MSG_WATCH_IPCSTATIC;

       when errXml = PERF_ANY_WATCH_PASESTART;
         msgOut    = PERF_MSG_WATCH_PASESTART;

       when errXml = PERF_ANY_WATCH_PUSH;
         msgOut    = PERF_MSG_WATCH_PUSH;
       when errXml = PERF_ANY_WATCH_POP;
         msgOut    = PERF_MSG_WATCH_POP;
       when errXml = PERF_ANY_WATCH_CACXML;
         msgOut    = PERF_MSG_WATCH_CACXML;
       when errXml = PERF_ANY_WATCH_TMP4;
         msgOut    = PERF_MSG_WATCH_TMP4;
       when errXml = PERF_ANY_WATCH_TMP5;
         msgOut    = PERF_MSG_WATCH_TMP5;
       when errXml = PERF_ANY_WATCH_TMP6;
         msgOut    = PERF_MSG_WATCH_TMP6;
       when errXml = PERF_ANY_WATCH_TMP7;
         msgOut    = PERF_MSG_WATCH_TMP7;
       when errXml = PERF_ANY_WATCH_TMP8;
         msgOut    = PERF_MSG_WATCH_TMP8;
       when errXml = PERF_ANY_WATCH_TMP9;
         msgOut    = PERF_MSG_WATCH_TMP9;

       when errXml = PERF_RUN_CGI_NADA;
         msgOut    = PERF_MSG_CGI_NADA;
       when errXml = PERF_RUN_CGI_COPYIN;
         msgOut    = PERF_MSG_CGI_COPYIN;
       when errXml = PERF_RUN_CGI_CHECK_DEBUG;
         msgOut    = PERF_MSG_CGI_CHECK_DEBUG;
       when errXml = PERF_RUN_CGI_PARMS_PARSE;
         msgOut    = PERF_MSG_CGI_PARMS_PARSE;
       when errXml = PERF_RUN_CGI_SECURITY;
         msgOut    = PERF_MSG_CGI_SECURITY;
       when errXml = PERF_RUN_CGI_RUN;
         msgOut    = PERF_MSG_CGI_RUN;
       when errXml = PERF_RUN_CGI_ERROR;
         msgOut    = PERF_MSG_CGI_ERROR;
       when errXml = PERF_RUN_CGI_OUTPUT;
         msgOut    = PERF_MSG_CGI_OUTPUT;
       when errXml = PERF_RUN_CGI_FINISH;
         msgOut    = PERF_MSG_CGI_FINISH;
       when errXml = PERF_RUN_CGI_DB2_PREPARE;
         msgOut    = PERF_MSG_CGI_DB2_PREPARE;
       when errXml = PERF_RUN_CGI_DB2_EXECUTE;
         msgOut    = PERF_MSG_CGI_DB2_EXECUTE;
       when errXml = PERF_RUN_CGI_DB2_FREE;
         msgOut    = PERF_MSG_CGI_DB2_FREE;

       when errXml = PERF_RUN_CGI_COPYIN_MEMORY;
         msgOut    = PERF_MSG_CGI_COPYIN_MEMORY;
       when errXml = PERF_RUN_CGI_COPYIN_PLUS;
         msgOut    = PERF_MSG_CGI_COPYIN_PLUS;
       when errXml = PERF_RUN_CGI_COPYIN_XLATE;
         msgOut    = PERF_MSG_CGI_COPYIN_XLATE;
       when errXml = PERF_RUN_CGI_COPYIN_HACK;
         msgOut    = PERF_MSG_CGI_COPYIN_HACK;

       // ???
       other;
         msgOut =  PERF_MSG_ERROR_UNKNOWN;
       endsl;
       return msgOut;
      /end-free
     P                 E
     


      *****************************************************
      * perfLogAdd
      * return (NA)
      *****************************************************
     P perfLogHex      B                   export
     D perfLogHex      PI
     D   text                         3A   value
     D   piParm                        *   value
     D   piSize                      10i 0 value
      * vars
     D i               s             10i 0 inz(0)
     D xxHint          S             60A   inz(*BLANKS)
     D xxChar          S             60A   inz(*BLANKS)
     D pxCopy          s               *   inz(*NULL)
      /free
       // see plugconf_h
       if sLogMe = *ON;
         pxCopy = piParm;
         for i = 1 to 10;
           hexDump(pxCopy:%size(xxHint)
                :%addr(xxHint):%size(xxHint)
                :%addr(xxChar):%size(xxChar));
           perfLogAdd(text + ' ' + xxHint);
           perfLogAdd(text + ' ' + xxChar);
           pxCopy += 30; // half size output buffer 60 chars
           if pxCopy > piParm + piSize
           or xxHint = *BLANKS;
             leave;
           endif;
         endfor;
       endif;
      /end-free
     P                 E

     P perfLogAdd      B                   export
     D perfLogAdd      PI
     D   text                        64A   value
      /free
       // see plugconf_h
       if sLogMe = *ON;
         confLogPop(text);
       endif;
      /end-free
     P                 E
     
     P perfDumpAdd     B                   export
     D perfDumpAdd     PI
     D   text                     65000A   value
      /free
       // see plugconf_h
       if sLogMe = *ON;
         confDumpPop(text);
       endif;
      /end-free
     P                 E
     
     P perfLogId       B                   export
     D perfLogId       PI
      * vars
     D rc              s              1N   inz(*OFF)
     d string          s               *   inz(*NULL)
     d stringLen       s             10i 0 inz(0)
     D jobName         s             10A   inz(*BLANKS)
     D jobUserID       s             10A   inz(*BLANKS)
     D jobNbr          s              6A   inz(*BLANKS)
     D jobInfo         ds                  likeds(myJob_t)
     D text            s             64A   inz(*BLANKS)
     D paseCCSID       S             10i 0 inz(0)
      /free
       // see plugconf_h
       if sLogMe = *ON;
         rc = ileJob(jobName:jobUserID:jobNbr:jobInfo);
         text = 'L_JOB'
              + ' ' + %trim(jobInfo.Job0_CurUser)
              + ' ' + %trim(jobName) 
              + ' ' + %trim(jobUserID) 
              + ' ' + %trim(jobNbr);
         confLogPop(text);
         text = 'L_IPC'
              + ' ' + %trim(ipcIPC()) 
              + ' ' + %trim(ipcFtok());
         confLogPop(text);
         paseCCSID = PaseLstCCSID();
         text = 'L_CCSID' 
              + ' ' + %char(jobInfo.Job0_CCSID) 
              + ' ' + %char(jobInfo.Job0_DfCCSID) 
              + ' ' + %char(paseCCSID);
         confLogPop(text);
         text = 'L_LIBL' 
              + ' ' + %trim(jobInfo.Job0_UsrL);
         confLogPop(text);
       endif;
      /end-free
     P                 E     


      *****************************************************
      * xmlservice logging
      *****************************************************
     P log_query...
     P                 B
     D log_query...        
     D                 PI             1N
     D  stmt_str                       *   value
     D  stmt_len                     10I 0 value
     D  fetch_str                      *   value options(*nopass)
     D  fetch_len                    10I 0 value options(*nopass)
      * vars
     DDB2_RC           S             10I 0 inz(0)
     DDB2_RC1          S             10I 0 inz(0)
     Dhenv             S             10I 0 inz(0)
     Dhdbc             S             10I 0 inz(0)
     Dhstmt            S             10I 0 inz(0)
     Dpout             s               *   inz(*NULL)
     D opt             s             10i 0 inz(0)
     D pOpt            s               *   inz(%addr(opt))
      /free
       Monitor;
             
       // CLI SQL
       DB2_RC=db2AllocEnv(henv);
       
       // allocate connect
       if DB2_RC = 0;
         DB2_RC=db2AllocConnect(henv:hdbc);
       endif;
       
       // make connection
       if DB2_RC = 0;
         DB2_RC=db2Connect(hdbc:
                         *NULL:0:
                         *NULL:0:
                         *NULL:0);
       endif;

       // always system naming  
       if DB2_RC = 0;
         opt = DB2_TRUE;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_DBC_SYS_NAMING:pOpt:DB2_NTS);
       endif;
       
       // always auto commit on
       if DB2_RC = 0;
         opt = DB2_TRUE;
         DB2_RC=db2SetConnectAttr(hdbc:DB2_ATTR_AUTOCOMMIT:pOpt:DB2_NTS);
       endif;
       
       // make statement
       if DB2_RC = 0;
         DB2_RC=db2AllocStmt(hdbc:hstmt);
       endif;
       
       // make call
       if DB2_RC = 0;
         DB2_RC=db2ExecDirect(hstmt:stmt_str:stmt_len);      
       endif;
              
       // fetch one string
       if %parms >= 4;
         if DB2_RC = 0;     
           DB2_RC=db2BindCol(hstmt:1:DB2_CHAR:fetch_str:fetch_len:pout);
         endif;
         if DB2_RC = 0;     
           DB2_RC=db2Fetch(hstmt);
         endif;
       endif;

       // -------------
       // error
       On-error;
         DB2_RC = DB2_ERROR;
       Endmon;


       // --------------
       // remove all resources
       // moved beyond top monitor @ADC (1.7.4)

       if hstmt <> 0;
         Monitor;
         DB2_RC1=db2FreeStm(hstmt: DB2_DROP);
         On-error;
         Endmon;
       endif;
       
       if hdbc <> 0;
         Monitor;
         DB2_RC1=db2Disconnect(hdbc);
         On-error;
         Endmon;
       endif;
       
       if hdbc <> 0;
         Monitor;
         DB2_RC1=db2FreeConnect(hdbc);
         On-error;
         Endmon;
       endif;

       if henv <> 0;
         Monitor;
         DB2_RC1=db2FreeEnv(henv);
         On-error;
         Endmon;
       endif;


       // result
       if DB2_RC <> 0;
         return *OFF;
       endif;
       return *ON;
      /end-free
     P                 E
      
      *****************************************************
      * xmlservice logging
      *****************************************************
     P log_crt...
     P                 B                   export
     D log_crt...
     D                 PI
      * vars
     D i               s             10i 0 inz(0)
     D pos             s             10i 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D myLib           s             10A   inz(*BLANKS)
     D myFile          s             10A   inz(*BLANKS)
     D myFile2         s             10A   inz(*BLANKS)
     D myTable         s             21A   inz(*BLANKS)
     D myTable2        s             21A   inz(*BLANKS)
     D myText          s             64A   inz(*BLANKS)
      * sql statement
     D  stmt           s            256A   inz(*BLANKS)
     D  stmt_str       s               *   inz(*NULL)
     D  stmt_len       s             10I 0 inz(0)
      * sql attributes
     D myConn          s             10A   inz(*BLANKS)
     D myStmt          s             10A   inz(PERF_LOG_STMT_NAME)
     D myOpt           s             10A   inz(*BLANKS)
     D myKey           s             64A   inz(*BLANKS)
     D sqlCode         s             10I 0 inz(0)
      /free
       // mmm ... need to find system/sql naming ??
       myLib = confLogLib();
       myFile = confLogTab();
       myFile2 = confLogMore();
       myTable = %trim(myLib) + '/' + %trim(myFile);
       myTable2 = %trim(myLib) + '/' + %trim(myFile2);
       // -----------
       // SQL call
       stmt = 'create schema ' 
            + %trim(myLib);
       stmt_str = %addr(stmt);
       stmt_len = %len(%trim(stmt));
       rc = log_query(stmt_str:stmt_len);
       // -----------
       // authorization
       stmt = 'GRTOBJAUT OBJ(' 
            + %trim(myLib) 
            + ') OBJTYPE(*LIB) USER(*PUBLIC) AUT(*ALL)'; 
       stmt_str = %addr(stmt);
       stmt_len = %len(%trim(stmt));
       rc = ileCmdExc(stmt_str:stmt_len);
       // -----------
       // SQL call - log table
       stmt = 'create table ' 
            + %trim(myTable)
            + ' ('
            + ' key varchar(64) NOT NULL WITH DEFAULT,' 
            + ' log TIMESTAMP NOT NULL WITH DEFAULT,'
            + ' text varchar(64) NOT NULL WITH DEFAULT )';
       stmt_str = %addr(stmt);
       stmt_len = %len(%trim(stmt));
       rc = log_query(stmt_str:stmt_len);
       // -----------
       // SQL call - dump table
       stmt = 'create table ' 
            + %trim(myTable2)
            + ' ('
            + ' key varchar(64) NOT NULL WITH DEFAULT,' 
            + ' log TIMESTAMP NOT NULL WITH DEFAULT,'
            + ' text clob(15M) NOT NULL WITH DEFAULT )';
       stmt_str = %addr(stmt);
       stmt_len = %len(%trim(stmt));
       rc = log_query(stmt_str:stmt_len);
      /end-free
     P                 E
      
      
     P log_add...
     P                 B                   export
     D log_add...
     D                 PI
     D   text                        64A   value
      * vars
     D i               s             10i 0 inz(0)
     D pos             s             10i 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D myLib           s             10A   inz(*BLANKS)
     D myFile          s             10A   inz(*BLANKS)
     D myTable         s             21A   inz(*BLANKS)
     D myText          s             64A   inz(*BLANKS)
      * sql statement
     D  stmt           s            256A   inz(*BLANKS)
     D  stmt_str       s               *   inz(*NULL)
     D  stmt_len       s             10I 0 inz(0)
      * sql attributes
     D myConn          s             10A   inz(*BLANKS)
     D myStmt          s             10A   inz(PERF_LOG_STMT_NAME)
     D myOpt           s             10A   inz(*BLANKS)
     D myKey           s             64A   inz(*BLANKS)
     D sqlCode         s             10I 0 inz(0)
      /free
       // mmm ... need to find system/sql naming ??
       myLib = confLogLib();
       myFile = confLogTab();
       myTable = %trim(myLib) + '/' + %trim(myFile);
       for i = 1 to 2;
         // create
         if i = 2;
           log_crt();
         endif;
         // -----------
         // SQL call
         myKey = ipcDoLogKey();
         myText = text;
         bigJunkOut(%addr(myText):%addr(myText)+%size(myText):*ON:*ON:*ON);
         stmt = 'insert into ' 
              + %trim(myTable) 
              + ' (key, text) values ('
              + ''''
              + %trim(myKey)
              + ''''
              + ','
              + ''''
              + %trim(myText)
              + ''''
              + ')';
         stmt_str = %addr(stmt);
         stmt_len = %len(%trim(stmt));
         rc = log_query(stmt_str:stmt_len);
         if rc = *ON;
           leave;
         endif;
       endfor;
      /end-free
     P                 E

     P log_dump...
     P                 B                   export
     D log_dump...
     D                 PI
     D   text                     65000A   value
      * vars
     D i               s             10i 0 inz(0)
     D pos             s             10i 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D myLib           s             10A   inz(*BLANKS)
     D myFile          s             10A   inz(*BLANKS)
     D myTable         s             21A   inz(*BLANKS)
     D myText          s          64000A   inz(*BLANKS)
      * sql statement
     D  stmt           s          65000A   inz(*BLANKS)
     D  stmt_str       s               *   inz(*NULL)
     D  stmt_len       s             10I 0 inz(0)
      * sql attributes
     D myConn          s             10A   inz(*BLANKS)
     D myStmt          s             10A   inz(PERF_LOG_STMT_NAME)
     D myOpt           s             10A   inz(*BLANKS)
     D myKey           s             64A   inz(*BLANKS)
     D sqlCode         s             10I 0 inz(0)
      /free
       // mmm ... need to find system/sql naming ??
       myLib = confLogLib();
       myFile = confLogMore();
       myTable = %trim(myLib) + '/' + %trim(myFile);
       for i = 1 to 2;
         // create
         if i = 2;
           log_crt();
         endif;
         // -----------
         // SQL call
         myKey = ipcDoLogKey();
         myText = text;
         bigJunkOut(%addr(myText):%addr(myText)+%size(myText):*OFF:*OFF:*ON);
         stmt = 'insert into ' 
              + %trim(myTable) 
              + ' (key, text) values ('
              + ''''
              + %trim(myKey)
              + ''''
              + ','
              + ''''
              + %trim(myText)
              + ''''
              + ')';
         stmt_str = %addr(stmt);
         stmt_len = %len(%trim(stmt));
         rc = log_query(stmt_str:stmt_len);
         if rc = *ON;
           leave;
         endif;
       endfor;
      /end-free
     P                 E

     P log_id...
     P                 B                   export
     D log_id...
     D                 PI            64A  
      * vars
     D i               s             10i 0 inz(0)
     D pos1            s             10i 0 inz(0)
     D pos2            s             10i 0 inz(0)
     D rc              s              1N   inz(*OFF)
     D myLib           s             10A   inz(*BLANKS)
     D myFile          s             10A   inz(*BLANKS)
     D myTable         s             21A   inz(*BLANKS)
     D myKey           s             64A   inz(*BLANKS)
     D cCDATA1         S              9A   inz(*BLANKS) 
     D cCDATA2         S              3A   inz(*BLANKS) 
      * sql statement
     D  stmt           s            256A   inz(*BLANKS)
     D  stmt_str       s               *   inz(*NULL)
     D  stmt_len       s             10I 0 inz(0)
      * sql attributes
     D myConn          s             10A   inz(*BLANKS)
     D myStmt          s             10A   inz(PERF_LOG_STMT_NAME)
     D myOpt           s             10A   inz(*BLANKS)
     D myBlock         s             10i 0 inz(SQLMAXFETCH)
     D myRec           s             10i 0 inz(0)
     D myDesc          s              1N   inz(*OFF)
     D myOut           s            256A   inz(*BLANKS)
     D myOutPtr        s               *   inz(%addr(myOut))
     D sqlCode         s             10I 0 inz(0)
      * xlate
     D lo              C                   '0123456789ABCDEF'
     D up              C                   'GHIJKLMNOPQRSTUV'
      * job
     D jobName         s             10A   inz(*BLANKS)
     D jobUserID       s             10A   inz(*BLANKS)
     D jobNbr          s              6A   inz(*BLANKS)
     D jobInfo         ds                  likeds(myJob_t)      
      /free
       cCDATA1 = xmlcCDATA1(); // USC2 convert job ccsid (1.6.7)
       cCDATA2 = xmlcCDATA2(); // USC2 convert job ccsid (1.6.7)

       // mmm ... need to find system/sql naming ??
       myLib = 'SYSIBM';
       myFile = 'SYSDUMMY1';
       myTable = %trim(myLib) + '/' + %trim(myFile);
       // -----------
       // SQL call
       stmt = 'select HEX(GENERATE_UNIQUE()) from ' 
            + %trim(myTable);
       stmt_str = %addr(stmt);
       stmt_len = %len(%trim(stmt));
       myOutPtr = %addr(myOut);
       rc = log_query(stmt_str:stmt_len:myOutPtr:%size(myOut));
       // -----------
       // 010415020296ac5e77666ba001
       bigJunkOut(%addr(myOut):%addr(myOut)+%size(myOut):*OFF:*OFF:*OFF);
       if myKey = *BLANKS;
         myKey = myOut;
         myKey = %XLATE(lo:up:myKey);
       endif;
       if myKey = *BLANKS;
         myKey = PERF_LOG_NO_KEY;
       endif;
       rc = ileJob(jobName:jobUserID:jobNbr:jobInfo);
       myKey = %trim(myKey)
             + %trim(jobInfo.Job0_CurUser)
             + %trim(jobName) 
             + %trim(jobUserID) 
             + %trim(jobNbr);
       return myKey;
      /end-free
     P                 E

     

