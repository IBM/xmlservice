      /if defined(PLUGCONF_H)
      /eof
      /endif
      /define PLUGCONF_H

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
      * ---change if new version---
      *****************************************************
     D PLUGVER         c                   const('XML Toolkit 2.0.1')

      *****************************************************
      * ---change plugconf1/2 alternate library---
      *   plugconf1.rpgle - assumes XMLSERVICE library
      *   plugconf2.rpgle - assumes ZENDSVR    library
      *   plugconf3.rpgle - assumes XMLSERVICE library (yips)
      *   plugconf6.rpgle - assumes ZENDSVR6   library
      *   plugconf7.rpgle - assumes ZENDPHP7   library
      *   plugconfq.rpgle - assumes QXMLSERV   library (IBM)
      * Pick the correct one to compile ...
      *   crtxml  - XMLSERVICE testing library (plugconf1.rpgle)
      *   crtxml2 - ZENDSVR production library (plugconf2.rpgle)
      *   crtxml3 - XMLSERVICE Yips demo library (plugconf3.rpgle)
      *   crtxml6 - ZENDSVR6 production library (plugconf6.rpgle)
      *   crtxmlq - QXMLSERV IBM PTF library (plugconfq.rpgle)
      *****************************************************
      * custom setup
     D confHeader      PR          2048A
     D confDemoOk      PR             1N
     D confNoneOk      PR             1N
     D confCALLSP      PR           128A
     D confSPNDIR      PR           128A
     D confSPNPGM      PR           128A
     D confSBMLIB      PR            10A
     D confSBMPGM      PR            10A
     D confJOBLIB      PR            10A
     D confJOBD        PR            10A
     D confJOBNAM      PR            10A
     D confJOBASP      PR            10A
      * custom client side security
     D confCGI         PR             1N
     D  mDB2                         10A   value
     D  mUID                         10A   value
     D  mPWD                         10A   value
     D  mIPC                       1024A   value
     D  mCtl                       1024A   value
     D  mIClob                         *   value
     D  mzIClob                      10i 0 value
     D  mOClob                         *   value
     D  mzOClob                      10i 0 value
     D confClient      PR             1N
     D   pIPCSP                    1024A   value
     D   pCtlSP                    1024A   value
     D   pIClob                        *   value
     D   szIClob                     10i 0 value
     D   pOClob                        *   value
     D   szOClob                     10i 0 value
      * custom server side security
     D confStart       PR             1N
     D   pIPCSP                    1024A   value
     D confAccept      PR             1N
     D   runMemP                       *   value
      * custom server side output (server XML)
     D confSrvOut      PR             1N
     D   runGood                      1N   value
     D   runMemP                       *   value
      * custom client side output (client XML)
     D confCltOut      PR             1N
     D   runGood                      1N   value
     D   pOClob                        *   value
     D   szOClob                     10i 0 value
      * custom diag info <diag info='conf'>
     D confDiag        PR             1N
     D   jobName                     10A   value
     D   jobUserID                   10A   value
     D   jobNbr                       6A   value
     D   anyData                  60000A
      * custom timeout defaults (*idle/*wait/*call can override)
      * time out types of alarms/action (see plugsig_h)
     D confAction      PR             1A
     D   timerType                    1A   value
     D confSeconds     PR            10i 0
     D   timerType                    1A   value
      * action taken when time out pops (occurred)
     D confTimePop     PR
     D   signo                       10I 0 value
     D   timerType                    1A   value
     D   timeAction                   1A   value
     D   timeSeconds                 10i 0 value
      * custom logging
      * action taken when log record pops (occurred)
     D confLogLib      PR            10A
     D confLogTab      PR            10A
     D confLogMore     PR            10A
     D confLogPop      PR
     D   text                        64A   value
     D confDumpPop     PR
     D   text                     65000A   value



      *****************************************************
      * server program library configuration
      * INLLIBL *JOBD changed to *CURRENT via Alan (1.7.3)
      *****************************************************
     DSBMOPTS          ds
     D sbm1                          50    inz('CURLIB(*CURRENT)')
     D                               50    inz('INLLIBL(*CURRENT)')
     D                               50    inz('SRTSEQ(*CURRENT)')
     D                               50    inz('LANGID(*CURRENT)')
     D                               50    inz('CNTRYID(*CURRENT)')
     D                               50    inz('CCSID(*CURRENT)')
     D SBMNBR          c                   %div(%size(SBMOPTS):%size(sbm1)) 
     D pSBMOPTS        s               *   inz(%addr(SBMOPTS))
     D SBMARRAY        s             50    dim(SBMNBR) based(pSBMOPTS)
      * stored procs call PLUGCALL.PLUG4K (xmlcgi)
     D PLUG4K          c                   const('iPLUG4K(?,?,?,?)')
     D PLUG32K         c                   const('iPLUG32K(?,?,?,?)')
     D PLUG65K         c                   const('iPLUG65K(?,?,?,?)')
     D PLUG512K        c                   const('iPLUG512K(?,?,?,?)')
     D PLUG1M          c                   const('iPLUG1M(?,?,?,?)')
     D PLUG5M          c                   const('iPLUG5M(?,?,?,?)')
     D PLUG10M         c                   const('iPLUG10M(?,?,?,?)')
     D PLUG15M         c                   const('iPLUG15M(?,?,?,?)')
     D PLUGR4K         c                   const('iPLUGR4K(?,?,?,?)')
     D PLUGR32K        c                   const('iPLUGR32K(?,?,?,?)')
     D PLUGR65K        c                   const('iPLUGR65K(?,?,?,?)')
     D PLUGR512K       c                   const('iPLUGR512K(?,?,?,?)')
     D PLUGR1M         c                   const('iPLUGR1M(?,?,?,?)')
     D PLUGR5M         c                   const('iPLUGR5M(?,?,?,?)')
     D PLUGR10M        c                   const('iPLUGR10M(?,?,?,?)')
     D PLUGR15M        c                   const('iPLUGR15M(?,?,?,?)')
      * IPC server side missing parm (error)
     D PLUGMISS        c                   const('/tmp/xmlmiss')

      *****************************************************
      * compile time default control application
      *****************************************************
      * allow clients at all (silly???)
     D PLUGCLIENTALLOW...
     D                 S              1N   inz(*ON)
      * allow clients to initiate new server jobs (web spawns)
     D PLUGSPAWNALLOW...
     D                 S              1N   inz(*ON)
      * record perf (off for production)
     D PLUGPERFALLOW...
     D                 S              1N   inz(*ON)
      * stop on error debug message qsysopr (off for production)
     D PLUGSTOPONERROR...
     D                 S              1N   inz(*OFF)

      *****************************************************
      * IPC loop attach
      *****************************************************
     D IPCLOOPATTACHNOSLEEP...
     D                 c                   const(1000)
     D IPCLOOPATTACHSLEEPONESECOND...
     D                 c                   const(1010)

      *****************************************************
      * max chars joblog diag
      *****************************************************
     D XMLMAXJOBLOG...
     D                 c                   const(128000)

      *****************************************************
      * max count DB2 options templates
      * max count DB2 connections
      * max count DB2 statements
      *****************************************************
     D SQLMAXOPTS      c                   const(128)
     D SQLMAXCONN      c                   const(128)
     D SQLMAXSTMT      c                   const(512)
     D SQLMAXPARM      c                   const(512)
     D SQLMAXFETCH     c                   const(9999)

      *****************************************************
      * max count error records
      *****************************************************
     D ERRSPRV         c                   const(1)
     D ERRSMAX         c                   const(32)

      *****************************************************
      * max CPF summary records extracted joblog
      * (do not set big)
      *****************************************************
     D CPFSMAX         c                   const(12)

     DerRec_t          ds                  qualified based(Template)
     D erErrXml                      10i 0
     D erErrNo                       10i 0
     D erErrNoPs                     10i 0
     D erErrSYS                      10i 0
     D erErrCODE                     10i 0
     D erErrCPF                       7A
     D erErrSTAT                      6A
     D erHelp                        60A

      *****************************************************
      * max count performance records
      *****************************************************
     D PERFMAX         c                   const(340)

     DpfRec_t          ds                  qualified based(Template)
     D pfCode                         5i 0
     D pfTicks                       10u 0

      *****************************************************
      * max count PGM PASE lookup ILE symbols
      *****************************************************
     D CACHEMAX        c                   const(128)

      *****************************************************
      * max count types cache
      *****************************************************
     D XMLMAXTYPE      c                   const(256)
     D XMLMAXATTE      c                   const(1024)

      *****************************************************
      * max XML scan avoid positions
      *****************************************************
     D XMLMAXXML       c                   const(20000)

      *****************************************************
      * max count used to count max for caches
      *****************************************************
     D XMLMAXCNT       c                   const(256)

      *****************************************************
      * max dou/endo pairs in a single XML document
      * <ds [dim='n' dou='z']>
      *                   x
      * <data type='data types' [varying='on|off' enddo='z']>
      *                                                  x
      *****************************************************
     D XMLMAXDOU       c                   const(256)

      *****************************************************
      * max attributes pairs in a single element
      * <ds [dim='n' dou='z']>
      *      1       2
      * <data type='data types' [varying='on|off' enddo='z']>
      *       1                  2                3
      *****************************************************
     D XMLMAXATTR      c                   const(30)

      *****************************************************
      * max cache f64 to/from string (plugile)
      * where float, double, packed, zoned are relatively
      * slow to convert to from the XML document, so
      * cache the convert for reuse on probability
      * some program i/o values will be the same (common).
      *****************************************************
     D ILEMAXF64       c                   const(160)

      *****************************************************
      * max ILE parms - max number of parms used for
      * top='n' overlays
      *****************************************************
     D ILEMAXOVR       c                   const(256)

      *****************************************************
      * pase lib cache max                          (1.8.5)
      *****************************************************
     D PASELIBMAX      c                   const(512)

      *****************************************************
      * pase lib sym cache max                      (1.8.5)
      *****************************************************
     D PASESYMMAX      c                   const(512)

      *****************************************************
      * PASE call area (PASE memory):
      *
      * 0x00000010 alloc  - quadalign   10 (    16)
      *                   - pase call 2000 (  8192)     2 pages
      * 0x00002000 sigs   - signature 8000 ( 32736) 16368 sigs
      * 0x0000AFE0 ILEBASE- base        20 (    32)
      * 0x0000B000 argv   - _PGMCALL    (134172672) 32757 pages
      *    0x10000        - max argv[]     ( 65536)    16 pages
      *            data   - _ILECALL (actually starts at ILEBASE)
      *            parms  - data                       
      *            return - data
      * 0x00FFFE00 end                  (016773120) 04095 pages
      * 0x08000000 end                  (134217728) 32768 pages
      * 
      * PASE can only see PASE memory
      * Qp2malloc returns PASE useable memory
      *****************************************************
     D SZCALLPASE      c                   const(8192)
     D SZSIG           c                   const(32736)
     D SZARGC          c                   const(65536)
     D SZBASE          c                   const(32)
     D SZALL           c                   const(134217728)
      * max ILE - when running in OPM mode V5R4 (1.6.8)
      * 0x00000000 alloc  - quadalign
      * 0x00002000 sigs   - signature 8000 ( 32736) 16368 sigs
      * 0x0000B000 argv   - _PGMCALL    (134172672) 32757 pages
      *    0x10000        - max argv[]     ( 65536)    16 pages
      *            data   - _ILECALL (actually starts at ILEBASE)
      *            parms  - data                       
      *            return - data
      * 0x00A00000 end                  (010375168) 02533 pages
      * 0x00FFFE00 end                  (016773120) 04095 pages -- max
      * 0x08000000 end                  (134217728) 32768 pages -- nope
     D SZOPM           c                   const(16773120)

     DpaseRec_t        ds                  qualified based(Template)
     D paseOrig                      10u 0
     D paseResv                      12A
     D paseOrigP                       *
     D paseCallP                       *
     D paseSigP                        *
     D paseArgvP                       *

      * ILE cache of SZALL for fast recalls
     D SZILEPAD        c                   const(128)
     D SZILESIG        c                   const(4096)
     D SZILEARGC       c                   const(65536)
     D SZILEPARM       c                   const(65536)
     D SZILEALL        c                   const(135296)

      *****************************************************
      * shared memory IPC w/fast XML cache processing ...
      * IPCSZ     - max size of shared memory IPC
      *             ipcRec_t IPC anchor between processes                  
      *             IPCSZ    (see ipcRec_t)
      *****************************************************
     D IPC_ID          c                   const(1)
     D IPCSZ           c                   const(12608)

      *****************************************************
      * ipc flag control area
      *****************************************************
     DdoRec_t          ds                  qualified based(Template)
     D doJustProc                     1N
     D doDebug                        1N
     D doDebugProc                    1N
     D doDebugCGI                     1N
     D doNoStart                      1N
     D doImmed                        1N
     D doHere                         1N
     D doHack                         1N
     D doBatch                        1N
     D doGet                          1N
     D doRpt                          1N
     D doLic                          1N
     D doSes                          1N
     D doFly                          1N
     D doLog                          1N
     D doClear                        1N
     D doSbmJob                       1N
     D doIdle                         1N
     D doWait                         1N
     D doCall1                        1N
     D doCall2                        1N
     D doHex                          1N
     D doNoCall                       1N
     D doBef                          1N
     D doAft                          1N
     D doPase                         1N
     D doCDATA                        1N
     D doOwnEnd                       1N
     D doJVM                          1N
     D doSQLJVM                       1N
     D doDbgJVM                       1N
     D doIdleAct                      1A
     D doWaitAct                      1A
     D doCallAct1                     1A
     D doCallAct2                     1A
     D doIdlePerm                     1A
     D doWaitPerm                     1A
     D doCallPerm1                    1A
     D doCallPerm2                    1A
     D doHexAct                       1A
     D doBatNbr                      10i 0
     D doIdleSec                     10i 0
     D doWaitSec                     10i 0
     D doCallSec1                    10i 0
     D doCallSec2                    10i 0
     D doBefFrom                     10i 0
     D doBefTo                       10i 0
     D doAftFrom                     10i 0
     D doAftTo                       10i 0
     D doPaseILE                     10i 0
     D doPasePASE                    10i 0
     D doTest                        10i 0
     D doSbmLib                      10A
     D doSbmJobd                     10A
     D doSbmNam                      10A
     D doSbmAsp                      10A
     D doLogKey                      64A
     D doESCP                         1N                                        

      *****************************************************
      * ipc control area
      *****************************************************
     D IPCBATMAX       c                   const(16)
     DipcRec_t         ds                  qualified based(Template)
     D ipcIClobP                       *
     D ipcOClobP                       *
     D ipcIClobSz                    10i 0
     D ipcOClobSz                    10i 0
     D ipcPidSrv                     10i 0
     D ipcBusyIAm                     1N
     D ipcWaiting                     1N
     D ipcReadyGo                     1N
     D ipcOwnBad                      1N
     D ipcOwnKey                    128A
     D ipcTmClt                    2048A
     D ipcTmSrv                    2048A
     D ipcFlg                      1024A
     D ipcPathBlk                  1024A
     D ipcPathNull                 1024A
     D ipcFlags                            likeds(doRec_t)

      *****************************************************
      * node record
      *****************************************************
     DxmlNode_t        ds                  qualified based(Template)
     D xmlStrP                         *

     D pgmIndex                      10i 0
     D pgmSigPo                      10i 0
     D pgmArgPo                      10i 0
     D pgmValPo                      10i 0
     
     D pgmRetPo                      10i 0
     D pgmSigSz                      10i 0
     D pgmArgSz                      10i 0
     D pgmValSz                      10i 0
     
     D pgmRetSz                      10i 0
     D pgmTruOff                     10i 0
     D xmlStrSz                      10i 0
     D xmlOccurs                     10i 0
     
     D xmlDigits                     10i 0
     D xmlFrac                       10i 0
     D xmlbCCSID1                    10i 0
     D xmlbCCSID2                    10i 0
     
     D xmlbCCSID3                    10i 0
     D xmlbCCSID4                    10i 0
     D xmlaCCSID1                    10i 0
     D xmlaCCSID2                    10i 0
     
     D xmlaCCSID3                    10i 0
     D xmlaCCSID4                    10i 0
     D xmlTopNbr                     10i 0
     D xmlOffNbr                     10i 0
     
     D cacElemCnt                    10i 0
     D cacElemTop1                   10i 0
     D cacDouDim                     10i 0
     D cacDouEnd                     10i 0
     
     D cacOffOvr                     10i 0
     D cacOffEnd                     10i 0
     D cacLenOne                     10i 0
     D cacLenSet                     10i 0
     
     D cacLenBeg                     10i 0
     D cacLenOff1                    10i 0
     D cacLenOff2                    10i 0
     D cacTruLen                     10i 0

     D cacNxtOvr                     10i 0
     D cacNxtOff                     10i 0

     D cacIsRec                       1A
     D cacIsRecT                      1A
     D cacIsRecD                      1A
     D xmlpad03                       1A

     D xmlpad04                       1A     
     D pgmPtrTyp                      1A
     D pgmArgTop                      1A
     D pgmOPMMem                      1A

     D pgmValErr                      1A
     D xmlAttr                        1A
     D xmlIO                          1A
     D xmlBy                          1A

     D xmlVary                        1A
     D xmlCallAs                      1A
     D xmlPrmRet                      1A
     D xmlIsCDATA                     1A

     D xmlIsHex                       1A
     D xmlIsOmit                      1A
     D xmlIsTop                       1A
     D xmlTrim                        1A
     
     D pgmValHex                     16A

      *****************************************************
      * Copy any to any
      *****************************************************
     D over_t          DS                  qualified based(Template)
     D  ubufx                        32a
     D  bytex                         1a   overlay(ubufx)
     D  boolx                         1n   overlay(ubufx)
     D  twox                          2a   overlay(ubufx)
     D  chrx                          3i 0 overlay(ubufx)
     D  uchrx                         3u 0 overlay(ubufx)
     D  shortx                        5i 0 overlay(ubufx)
     D  ushortx                       5u 0 overlay(ubufx)
     D  intx                         10i 0 overlay(ubufx)
     D  uintx                        10u 0 overlay(ubufx)
     D  longlongx                    20i 0 overlay(ubufx)
     D  ulonglongx                   20u 0 overlay(ubufx)
     D  floatx                        4f   overlay(ubufx)
     D  doublex                       8f   overlay(ubufx)
     D  ptrx                           *   overlay(ubufx)
     D  char1                         1a   overlay(ubufx)
     D  char2                         2a   overlay(ubufx)
     D  char3                         3a   overlay(ubufx)
     D  char4                         4a   overlay(ubufx)
     D  char5                         5a   overlay(ubufx)
     D  char6                         6a   overlay(ubufx)
     D  char7                         7a   overlay(ubufx)
     D  char8                         8a   overlay(ubufx)
     D  char9                         9a   overlay(ubufx)
     D  char10                       10a   overlay(ubufx)
     D  char11                       11a   overlay(ubufx)
     D  chardim                       1a   dim(32) overlay(ubufx)

      *****************************************************
      * job information debug
      *****************************************************
     DmyJob_t          ds                  qualified based(Template)
     D   Job0_JobName                10A
     D   Job0_UserID                 10A
     D   Job0_JobNbr                  6A
     D   Job0_LangId                  3A
     D   Job0_CntryId                 2A
     D   Job0_CCSID                  10i 0
     D   Job0_DfCCSID                10i 0
     D   Job0_CurUser                10A
     D   Job0_SbsName                10A
     D   Job0_SbsLib                 10A
     D   Job0_Status                 10A
     D   Job0_CurL                   10A
     D   Job0_SysL                 1000A
     D   Job0_PrdL                 1000A
     D   Job0_UsrL                 1000A

     D ileJob          PR             1N
     D   jobName                     10A
     D   jobUserID                   10A
     D   jobNbr                       6A
     D   jobInfo                           likeds(myJob_t)

      *****************************************************
      * file
      *****************************************************
     D O_RDONLY        C                   1
     D O_WRONLY        C                   2
     D O_RDWR          C                   4
     D O_CREAT         C                   8
     D O_EXCL          C                   16
     D O_TRUNC         C                   64
     D O_APPEND        C                   256
     D O_CODEPAGE      C                   8388608
     D O_TEXTDATA      C                   16777216

     D S_IRUSR         C                   256
     D S_IWUSR         C                   128
     D S_IXUSR         C                   64
     D S_IRWXU         C                   448
     D S_IRGRP         C                   32
     D S_IWGRP         C                   16
     D S_IXGRP         C                   8
     D S_IRWXG         C                   56
     D S_IROTH         C                   4
     D S_IWOTH         C                   2
     D S_IXOTH         C                   1
     D S_IRWXO         C                   7

     D ftok            PR            10i 0 extproc('ftok')
     D   path                          *   value options(*string)
     D   ID                          10i 0 value

     D mkdir           PR            10i 0 extproc('mkdir')
     D   path                          *   value options(*string)
     D   mode                        10i 0 value

     D openIFS         PR            10I 0 extproc('open')
     D   path                          *   value options(*string)
     D   oflag                       10I 0 value
     D   mode                        10U 0 value options(*nopass)
     D   codepage                    10U 0 value options(*nopass)

     D closeIFS        PR            10I 0 extproc('close')
     D   fildes                      10I 0 value


     D readIFS         PR            20I 0 ExtProc('read')     
     D   fd                          10I 0 value                       
     D   buf                           *   value
     D   size                        10I 0 value                       

     D writeIFS        PR            20I 0 ExtProc('write')     
     D   fd                          10I 0 value                       
     D   buf                           *   value
     D   size                        10I 0 value 

     D fsyncIFS        PR            20I 0 ExtProc('fsync')     
     D   fd                          10I 0 value                       

     D unlink          PR            10I 0 ExtProc('unlink')                 
     D   path                          *   value options(*string)            

     D rmdir           PR            10I 0 ExtProc('rmdir')                 
     D   path                          *   value options(*string)            
   
      *****************************************************
      * file _C_IFS_fopen, _C_NEU_DM_fopen, fopen
      *****************************************************
     DopenSRC          Pr              *   ExtProc( 'fopen' )
     D                                 *   Value  Options( *String )
     D                                 *   Value  Options( *String )

     DfgetSRC          Pr              *   ExtProc( 'fgets' )
     D                                 *   Value
     D                               10i 0 Value
     D                                 *   Value

     DfputSRC          Pr            10i 0 ExtProc( 'fputs' )
     D                                 *   Value  Options( *String )
     D                                 *   Value

     DcloseSRC         Pr            10i 0 ExtProc( 'fclose' )
     D                                 *   Value

      *****************************************************
      * file and semaphore
      *****************************************************
     D NUMSEMS         c                   const(3)

      * rw by others
     D XIPC_OTHR       C                   const(6)

      * semaphore and shm create
     D IPC_CREAT       c                   const(512)
     D IPC_EXCL        c                   const(1024)
      * create and return error if exist
     D xIPC_CRT        c                   const(1536)

      * rw by owner
     D xIPC_RW         C                   const(384)
      * rw owner, create and return error if exist
     D xIPC_RWCRT      C                   const(1920)

     D IPC_RMID        c                   const(0)
     D IPC_SET         c                   const(1)
     D IPC_STAT        c                   const(2)

     D IPC_NOWAIT      c                   const(2048)

      * shm teraspace
     D SHM_TS_NP...
     D                 C                   const(65536)
     D SHM_RESIZE_NP...
     D                 C                   const(262144)
      * fixed address everywhere
     D SHM_MAP_FIXED_NP...
     D                 C                   const(1048576)
      * teraspace w/resize
     D XSHM_TS         C                   const(327680)
      * ... and same addr (not used)
     D XSHM_TS1        C                   const(1376256)

     D shmat           PR              *   extproc('shmat')
     D   shmid                       10i 0 value
     D   addr                          *   value
     D   shmflg                      10i 0 value

     D shmctl          PR            10i 0 extproc('shmctl')
     D   shmid                       10i 0 value
     D   cmd                         10i 0 value
     D   buf                           *   value

     D shmdt           PR            10i 0 extproc('shmdt')
     D   addr                          *   value

     D shmget          PR            10i 0 extproc('shmget')
     D   key                         10i 0 value
     D   size                        10u 0 value
     D   shmflg                      10i 0 value

      *****************************************************
      * semaphores
      *****************************************************
     D semget          PR            10i 0 extproc('semget')
     D   key                         10i 0 value
     D   nsems                       10i 0 value
     D   semflg                      10i 0 value

     D semctl          PR            10i 0 extproc('semctl')
     D   semid                       10i 0 value
     D   semnum                      10i 0 value
     D   cmd                         10i 0 value
     D   buf                           *   value options(*nopass)

     D sembuf_t        ds                  qualified inz
     D   sem_num                      5u 0
     D   sem_op                       5i 0
     D   sem_flg                      5i 0

     D SEM_UNDO        C                   x'1000'

     D semop           PR            10i 0 extproc('semop')
     D   semid                       10i 0 value
     D   sops                              likeds(sembuf_t) dim(32767)
     D                                     options(*varsize)
     D   nsops                       10u 0 value


      *****************************************************
      * spawn
      *****************************************************
     D SC_OPEN_MAX...
     D                 c                   const(4)
     D sysconf         PR            10i 0 ExtProc('sysconf')
     D  name                         10i 0 Value

     D SPAWN_SETTHREAD_NP...
     D                 c                   const(16)
     D SPAWN_SETJOBNAMEPARENT_NP...
     D                 c                   const(128)
     D SPAWN_SETJOBNAMEARGV_NP...
     D                 c                   const(256)

     D QIBM_USE_DESCRIPTOR_STDIO...
     D                 c                   const('QIBM_USE_DESCRIPTOR_STDIO=Y')


     D inheritance_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   flags                       10U 0
     D   pgroup                      10i 0 
     D   sigmask                     20U 0
     D   sigdefault                  20U 0

     D spawn           PR            10i 0 ExtProc('spawn')
     D  path                           *   Value 
     D  fdcount                      10i 0 
     D  fdmap                          *   Value 
     D  inherit                        *   Value 
     D  argv                           *   Value 
     D  envp                           *   Value 

      * pid_t waitpid(pid_t pid, int *stat_loc, int options);
     D waitpid         PR            10i 0 ExtProc('waitpid')
     D  pid                          10i 0 value
     D  stat_loc                     10i 0
     D  options                      10i 0 value

      *****************************************************
      * convert string to numeric
      *****************************************************
     D QXXDTOP         PR                  ExtProc('QXXDTOP') 
     D  pTarget                        *   Value 
     D  digit                        10i 0 Value 
     D  frac                         10i 0 Value 
     D  value                         8f   Value 

     D QXXDTOZ         PR                  ExtProc('QXXDTOZ') 
     D  pTarget                        *   Value 
     D  digit                        10i 0 Value 
     D  frac                         10i 0 Value 
     D  value                         8f   Value 

     D QXXPTOD         PR             8f   ExtProc('QXXPTOD') 
     D  pTarget                        *   Value 
     D  digit                        10i 0 Value 
     D  frac                         10i 0 Value 

     D QXXZTOD         PR             8f   ExtProc('QXXZTOD') 
     D  pTarget                        *   Value 
     D  digit                        10i 0 Value 
     D  frac                         10i 0 Value 

      *****************************************************
      * run command (error in job log)
      *****************************************************
     D cmdexec         PR                  ExtPgm('QCMDEXC') 
     D cmdstr                      3000A   Const Options(*VarSize)
     D cmdlen                        15P 5 Const
     D cmdDbcs                        3A   Const Options(*NOPASS)

     D cmdcap          Pr                  extpgm('QCAPCMD')
     D                             1024a   options(*varsize) const
     D                                9b 0 const
     D                               20a   options(*varsize) const
     D                                9b 0 const
     D                                8a   const
     D                             1024a   options(*varsize) const
     D                                9b 0 const
     D                                9b 0 const
     D                              512a   options(*varsize) const     

      *****************************************************
      * run command (error _EXCP_MSGID 'CPF3142')
      * rc (0-good, -1-error)
      *****************************************************
     D system          PR            10I 0 ExtProc( 'system' )
     D  szCmd                          *   Value options(*string)
     D SYSEXPID        S              7a   Import('_EXCP_MSGID')

      *****************************************************
      * run rexx
      *   funt   - 'P' - pull, 'A' - add/push (1A)
      *   buf    - buffer     (xA)
      *   buflen - buffer len (10u 0) 
      *   flag   - operation flag (1A?)
      *   rcode  - return code (1A)
      *****************************************************
     D cmdrexx         PR                  ExtPgm('QREXQ') 
     D funt                           1A
     D buf                             *
     D buflen                        10U 0
     D flag                           1A   
     D rcode                          1A

      *****************************************************
      * Misc
      *****************************************************
     D RSLOBJ_TS_PGM   c                   const(X'0201')
     D RSLOBJ_TS_SRVPGM...
     D                 c                   const(X'0203')

     /* Prototype of CALLPGMV */
     d callpgmv        pr                  extproc('_CALLPGMV')
     d     pgm_ptr                     *
     d     argv                        *   dim(1) options(*varsize)
     d     argc                      10u 0 value

      ** resolve system pointer
      *  PGM      x'201'
      *  SRVPGM   x'203'
      *  LIB      x'401'
     D rslvsp          PR              *   procptr ExtProc('rslvsp') 
     D  ObjType                       2A   Value                     
     D  ObjName                        *   Value OPTIONS(*STRING)    
     D  ObjLibr                        *   Value OPTIONS(*STRING)    
     D  ObjAuth                       2A   Value  
                   
     D actbndpgm       PR            20i 0 ExtProc('QleActBndPgmLong') 
     D  objPtr                         *   Value 

     D actsympgm       PR              *   ExtProc('QleGetExpLong') 
     D  objAct                       20i 0  
     D  zeroA1                       10i 0 Value
     D  symLen                       10i 0
     D  symName                        *   Value OPTIONS(*STRING)    
     D  expPtr                         *   Value 
     D  expTyp                       10i 0
                                                                
      **  Set space ptr from system pointer                                 
     D setcPTR         PR              *   ExtProc('_SETSPPFP')      
     D  AnyPtr                         *   Value Procptr

     D cpybytes        PR                  ExtProc('_CPYBYTES') 
     D  pTarget                        *   Value 
     D  pSource                        *   Value 
     D  nLength                      10U 0 Value 

     d cpybwp          PR                  extproc('_CPYBWP')
     d  pTarget                        *   value
     d  pSource                        *   value
     d  nLength                      10u 0 value

     D memset          PR              *   ExtProc('__memset')
     D  pTarget                        *   Value
     D  nChar                        10I 0 Value
     D  nBufLen                      10U 0 Value

     D memcmp          PR            10I 0 ExtProc('__memcmp')
     D  pS1                            *   Value
     D  pS2                            *   Value
     D  nBufLen                      10U 0 Value

     D toupper         PR            10i 0 ExtProc('toupper')
     D  nBufLen                      10i 0 Value

     D islower         PR            10i 0 ExtProc('islower')
     D  nBufLen                      10i 0 Value

     D strlen          PR            10I 0 ExtProc('strlen')
     D  pVal                           *   Value options(*string)

     D getenv          PR              *   ExtProc('getenv')
     D  pVal                           *   Value options(*string)

     D putenv          PR            10i 0 ExtProc('putenv')
     D  pVal                           *   Value options(*string)

     D getpid          PR            20I 0 ExtProc('getpid')     

     D kill            PR            10I 0 ExtProc('kill')     
     D  pid                          10I 0 Value
     D  sig                          10I 0 Value

     D strchr          PR              *   ExtProc('strchr')
     D  pVal                           *   Value options(*string)
     D  nChar                        10I 0 Value

     D strrchr         PR              *   ExtProc('strrchr')
     D  pVal                           *   Value options(*string)
     D  nChar                        10I 0 Value

     D strstr          PR              *   ExtProc('strstr')
     D  pVal1                          *   Value options(*string)
     D  pVal2                          *   Value options(*string)

     D GetErrNo        Pr              *   Extproc('__errno')

     D StrError        Pr              *   ExtProc('strerror')
     D   ErrNo                       10I 0 Value

     D sprintf         PR            10I 0 ExtProc('vsprintf')
     D  pTarget                        *   Value
     D  pFormat                        *   Value
     D  pVS                            *   Value

     D sleep           PR                  ExtProc('sleep')
     D  nSecs                        10i 0 Value

     D CMPSWP4         PR            10i 0  extproc('_CMPSWP4')
     D   op1                           *   value
     D   op2                           *   value
     D   val                         10i 0 value

     D bigTrim         PR            20U 0
     D   start                         *   value
     D   len                         20U 0 value

     D bigJunkOut      PR
     D  pTop                           *   value
     D  pBottom                        *   value
     D  rmCDATA                       1N   value
     D  rmLF                          1N   value options(*nopass)
     D  rmQuote                       1N   value options(*nopass)

     D lilAssist       PR             1A
     D  pCopy                          *
     D  find                          1N
     D  j                            10i 0
     D  len                          10i 0 value
     D  search                       18A   value

     D bigAssist       PR            10i 0
     D  pTop                           *   value
     D  pBottom                        *   value
     D  search                       18A   dim(XMLMAXATTR)
     D  doFind                       10i 0 dim(XMLMAXATTR)

     D bigScan         PR              *
     D  pTop                           *   value
     D  search                       20A   value
     D  pBottom                        *   value
     D  oneChar                       1N   value options(*nopass)

     D bigOptAll       PR            10i 0
     D  pTop                           *   value
     D  pBottom                        *   value
     D  search                       20A   value
     D  pValue                         *   dim(XMLMAXATTR)

     D bigDimAttr      PR             1N
     D  pTop                           *   value
     D  pBottom                        *   value
     D  search                       20A   dim(XMLMAXATTR)
     D  pName                          *   dim(XMLMAXATTR)
     D  pValue                         *   dim(XMLMAXATTR)
     D  valueLen                     10i 0 dim(XMLMAXATTR)

     D bigElem         PR            10i 0
     D  pTop                           *   value
     D  pLst                           *   value
     D  search                       18A   dim(XMLMAXATTR)
     D  doNest                        1N   dim(XMLMAXATTR)
     D  isNada                        1N
     D  isCDATA                       1N
     D  aElemTop1                      *
     D  aElemTop2                      *
     D  aDataVal1                      *
     D  aDataVal2                      *
     D  aElemEnd1                      *
     D  aElemEnd2                      *
     D  aElemNext                      *

     D bigCDATA        PR             1N
     D   pTop                          *   value
     D   pLst                          *   value
     D   pC1                           *
     D   pC2                           *

     D bigValType      PR             1N
     D   string                        *   value
     D   stringLen                   10i 0 value
     D   myAttr                       1A
     D   myDigits                    10i 0
     D   myFrac                      10i 0

     D bigDimOpt       PR             1N
     D   pSearch                   1024A   value
     D   doCtl                     1024A
     D   doChar                      64A   dim(XMLMAXATTR)
     D   doNbr                       10i 0 dim(XMLMAXATTR)


     D isDigit         PR             1N
     D  pSource                        *   Value 
     D  nLength                      10i 0 Value 

     D toUpperSafe...
     D                 PR             1N
     D  pSource                        *   Value 
     D  nLength                      10i 0 Value 

     Dtimeval_t        ds                  qualified based(Template)
     D tv_sec                        10i 0
     D tv_usec                       10i 0

     D gettimeofday...
     D                 PR            10i 0 ExtProc('gettimeofday')
     D  ltime                          *   Value
     D  lzone                          *   Value


      *****************************************************
      * translate
      *****************************************************

     D QP2_2_ASCII...
     D                 c                   const('QTCPASC')
     D QP2_2_EBCDIC...
     D                 c                   const('QTCPEBC')

     D Translate       PR                  ExtPgm('QDCXLATE')
     D   Length                       5P 0 const
     D   Data                     32766A   options(*varsize)
     D   Table                       10A   const

     D iconv_t         DS                  qualified based(Template)
     D  rtn                          10I 0
     D  cd                           10I 0 Dim(12)

     DqtqCode_t        ds                  qualified based(Template)
     D qtqCCSID                      10i 0
     D qtqAltCnv                     10i 0
     D qtqAltSub                     10i 0
     D qtqAltSft                     10i 0
     D qtqOptLen                     10i 0
     D qtqMixErr                     10i 0
     D qtqRsv                        20i 0

     D CNVOPNMAX       c                   const(128)
     
     Dciconv_t         ds                  qualified based(Template)
     D conviok                       10i 0
     D conv                                likeds(iconv_t)
     D tocode                              likeds(qtqCode_t)
     D fromcode                            likeds(qtqCode_t)

     D iconvOpen       PR                  extproc('QtqIconvOpen') 
     D                                     likeds(iconv_t)
     D   tocode                            likeds(qtqCode_t)
     D   fromcode                          likeds(qtqCode_t)

     D iconv           PR            10i 0 ExtProc('iconv')
     D   hConv                             likeds(iconv_t) value
     D   pInBuff                       *   value
     D   nInLen                        *   value
     D   pOutBuff                      *   value
     D   nOutLen                       *   value

     D iconvClose      PR                  extproc('iconv_close') 
     D   cd                                likeds(iconv_t)

