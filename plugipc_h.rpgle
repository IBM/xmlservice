      /if defined(PLUGIPC_H)
      /eof
      /endif
      /define PLUGIPC_H
   
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
      * IPC control options:
      *----------------------------------------------------
      *--- very high peformance ignore all flag parsing (loop calls, etc.)
      * *ignore             
      *    - do not parse flags (high performance)
      *      example: $ctl="*ignore";
      *----------------------------------------------------
      *--- kill XMLSERVICE job
      * *immed
      *    - end server immed destroy IPC 
      *      example: $ctl="*immed";
      *----------------------------------------------------
      *--- misc functions XMLSERVICE
      * *license 
      *    - return license for this code
      * *session 
      *    - retrieve session key (IPC name /tmp/fred042)
      * *clear 
      *    - clear internal XMLSERVICE caches, 
      *                       but will not deactivate loaded PGM/SRVPGM, etc.
      *----------------------------------------------------
      * -- if you need to fix result set return drivers (iPLUGRxxx)
      *    hack for pesky DB2 drivers adding "junk" to back of records.
      * *hack               
      *    - add </hack> each record of a result set
      *      example: $ctl="*hack";
      *      - iPLUGRxxx XMLSERVICE stored procedures
      *        return result sets of 3000 byte records,
      *        you must loop fetch and concat records
      *        to recreate output XML ... except
      *        some DB2 drivers have junk end ...
      *      - enable easy rec truncate ill behaved drivers
      *        remove all past </hack> during concat 
      *        loop fetch records 1-n
      *        rec1: <script>....</hack> (3000 bytes)
      *        rec2: ............</hack> (3000 bytes)
      *        recn: ...</script></hack> (<3000 bytes)
      *----------------------------------------------------
      * -- pause XMLSERVICE job(s) for debugger attach (message to qsysopr)
      * *debug              
      *    - stop call server with message qsysopr (XMLSERVICE)
      *      example: $ctl="*debug";
      * *debugproc          
      *    - stop stored proc with message qsysopr (client QSQSRVR)
      * *debugcgi           
      *    - stop CGI with message qsysopr         (XMLCGI only)
      * *test[(n)]           
      *    - test parse XML in/out and report n level information
      *----------------------------------------------------
      * -- override default XMLSERVICE client/server spawn child behaviour
      * *sbmjob[(lib/jobd/job/asp)] 
      *    - sbmjob job (instead of XMLSERVICE default spawn)
      *      example: $ctl="*sbmjob";
      *      example: $ctl="*sbmjob(QSYS/QSRVJOB/XTOOLKIT)";
      *      example: $ctl="*sbmjob(ZENDSVR/ZSVR_JOBD/XTOOLKIT)";
      *      - default values provided plugconf.rpgle
      *      - optional asp INLASPGRP(ASP1) (added 1.6.5)
      *      -- Notes: 
      *         - See embedded XML overrides for user full control
      *           of XMLSERVICE start behavior SBMJOB settings
      * *here               
      *    - run stateless in stored proc job (client only job)
      *      example: $ctl="*here";
      *      - commonly known as running in PHP job, but in fact
      *        more likely runs in database job you connected
      *        on/off machine DRDA/ODBC/PASE (QSQSRVR, etc.)
      *      - generally runs slower using "one process"
      *        because XMLSERVICE has to restart itself,
      *        wake up PASE, find/load your PGM call, etc.
      * *nostart            
      *    - disallow spawn and sbmjob (web not start anything)
      *      example: $ctl="*nostart";
      *      - probably prestart all your XMLSERVICE jobs
      *        SBMJOB CMD(CALL PGM(XMLSERVICE/XMLSERVICE) 
      *        PARM('/tmp/db2ipc042')) USER(DB2)
      *      - consider using a custom plugconf to disable
      *        issues with timeout defaults (*idle/*wait)
      * *java (1.9.2)               
      *    - start JVM allowing user classpath
      *      <cmd>ADDENVVAR ENVVAR(CLASSPATH) VALUE('$ours') 
      *           REPLACE(*YES)</cmd>
      *      <pgm>... calling my RPG w/JAVA ... </pgm>
      * *sqljava or *dbgjava (port 30000) (1.9.2)            
      *    - start JVM allowing DB2 classpath (no user control)
      *       SQLJ.INSTALL_JAR into schema
      *       /QIBM/UserData/OS400/SQLLib/Function/jar/(schema) 
      *----------------------------------------------------
      * -- CDATA xml output
      * *cdata(on|off)
      *    - xml data fields returned with cdata
      *      <data><![CDATA[...]]></data>
      *      - on - CDATA (default 1.6.2)
      *      - off - CDATA off
      * -- special hex encoded XML document
      * *hex(in/out/both)
      *    - xml document hex encoded avoiding conversions
      *      - in   - HEX convert input side only
      *      - out  - HEX convert all output
      *      - both - HEX convert input and output
      *    example (php sudo):
      *      $doc = "<?xml  version='1.0'> ... </script>";
      *      $hexin  = bin2hex($doc);     // doc-2-hexin
      *      XMLSERVICE($ipc, $ctl="*hex", $hexin, $hexout);
      *      $doc = pack("H*", $hexout);  // hexout-2-doc
      *     -- Notes
      *      - hex string is '0123456789ABCDEF' or '...abcdef'
      *        which are CCSID immutable (or upper most always)
      *        which will arrive at XMLSERVCE in ebcdic via
      *        "natural" clob/rest interface transport conversion
      *        (ie., iBLOBxxx would not work *hex, arrive ascii)
      *        YES (clob): ebcdic (x'F0F1...C6') or (x'...86')
      *        NO  (blob):  ascii  (x'3031...46') or (x'...66')
      *      - hex option is useful with CCSID below
      *        with following order of operations:
      *        - input : *hex followed by *before
      *        - output: *after followed by *hex
      * -- CCSID conversion XMLSERVICE (1.6.2)
      * *before(CCSIDFrom/CCSIDTo[/action])
      *    - conversion before calling XML processing 
      *      - CCSIDFrom - XML document client CCSID
      *      - CCSIDTo   - XML document XMLSERVICE CCSID
      *      - action
      *        call   - call XMLSERVICE (default)
      *        nocall - convert only (no call)
      * *after(CCSIDFrom/CCSIDTo)
      *    - conversion after calling XML processing
      *      - CCSIDFrom - XML document XMLSERVICE CCSID
      *      - CCSIDTo   - XML document client CCSID
      * *pase(CCSIDpase/CCSIDile)
      *    - conversion PGM, LIB, etc, names call processing
      *      - CCSIDpase - name CCSID PASE side (ascii)
      *      - CCSIDile  - name CCSID ILE side (ebcdic)
      *
      *    example: $ctl="*before(819/37) *after(37/819)";
      *      - DB2 interface provides many possibilities
      *        iPLUGxxx - original CLOB automatic DB2 converts
      *        iBLOBxxx - raw binary no DB2 converts (1.6.2)
      *      - action='nocall' is used to convert
      *        anything on IBM i and send it back
      *        without calling XMLSERVICE
      *      - DB2 interface conversion effects are
      *        virtually unlimited performed on IBM i
      *        avoiding additional "code tables" on client
      *      - *pase default (should work)
      *        ILE ccsid 0 means job CCSID (all ebcdic)
      *        PASE csid default Qp2paseCCSID (see API)
      *----------------------------------------------------
      * -- server time out jobs XMLSERVICE (1.6.2)
      * *wait[(seconds[/action])]            
      *    - client side wait for XMLSERVICE call (client side)
      *      example: $ctl="*wait(10)";
      *      - default action *wait(60/busy) (see plugconfx)
      * *call[(seconds[/action[/duration[/job]]])] 
      *    - client/server side XMLSERVICE call wait (PGM, SRVPGM, PASE, etc)
      *      example: $ctl="*wait(10) *call(5/busy/client)";
      *      - default for both client/server is *call(0) 
      *        means wait on call forever (user code flawless),
      *        but can be overriden client/server/both
      * *idle[(seconds[/action[/duration]])] 
      *    - server side XMLSERVICE idle no activity
      *      example: $ctl="*wait(10/kill) *call(30/kill) *idle(30/kill/perm)";
      *      - default action *idle(1800/kill) (see plugconfx)
      *    -- time out parameters
      *      seconds:
      *        -1 - current default timer
      *         0 - no timer, no timeout, wait forever
      *         n - idle timer "pop" seconds
      *      action:
      *        kill - end job immed
      *        user - user override signal behaviour (see plugconfx)
      *        busy - return busy XML (client side)
      *               busy response (1301050):
      *               <error>
      *               <errnoxml>1301050</errnoxml>
      *               <xmlerrmsg>IPC timeout busy</xmlerrmsg>
      *               </error>
      *      duration:
      *        perm - set and use new defaults all requests
      *        orig - reset and use original compile defaults (see plugconfx)
      *      job:
      *        client - *call action applies client side
      *        server - *call action applies server side
      *    -- Notes:
      *      - default timeout/action provided plugconf1-3.rpgle,
      *        but each request may override/reset to fit task(s)
      *      - signal SIGALRM used with this function
      *        can affect user program calls,
      *        *call(0) may be used to turn off timer
      *        during user program calls
      *      - action 'user' allows for custom signal
      *        processing in the RPG code (see plugconfx)
      *      - if duration not specified, attributes
      *        *wait(),*call(),*idle() are temporary
      *        for this call only and return to last defaults.
      *      - if 'job' not specified on *call(),
      *        attribute settings apply to both sides
      *      - end job immed kills XMLSERVICE job (server)
      *        and destroys IPC, so any waiting client is
      *        released with an IPC missing error.
      *----------------------------------------------------
      * -- batch XMLSERVICE processing (version 1.6.2)
      * *batch
      *    - use a free batch slot 1 - 16 (release client)
      *      responses:
      *        <id status='set'>1-16</id> - set batch processing
      *        <id status='full'>0</id>   - no slots available
      *      example: $ctl="*sbmjob *batch";
      *      - *batch holds output XML memory until retrieved
      *      - *get(n) retrieve of XML memory (some time later)
      *      - *batch releases XMLSERVICE client (caller), and
      *        returns batch slot number (n) assigned for work.
      * *get[(n)]           
      *    - get XML results from batch slot 1 - 16 (release slot)
      *      responses (report not available):
      *        <id status='small'>1-16</id> - buffer too small
      *        <id status='done'>1-16</id>  - complete removed
      *      example: $ctl="*get";
      *      example: $ctl="*get(3)";
      *      - use with *wait(sec/busy) to avoid hang during
      *        *batch running (do something else while waiting)
      *      - *get without slot number will get one result 
      *        any completed batch slot
      *      - *get(3) will only get result of batch slot 3
      *----------------------------------------------------
      * -- flight data options (affects performance) --
      * *justproc
      *    - call stored proc, get into XMLSERVICE client,
      *      do nothing while in XMLSERVICE, return back
      *      - used to check transport speed only
      * -- in memory flight record ---
      * *fly
      *    - flight record performance
      * *nofly
      *    - no flight record performance (default)
      * *rpt
      *    - performance report last call
      * -- log to database file  (1.7.1) --
      * *log[(key)]
      *    - log records into database
      * *nolog
      *    - no log records into database (default)
      *   Note: 
      *   - *log key is unique allowing both PHP and XMLSERVICE
      *     to record event log data and produce queries of collected
      *     reports.
      *     Log file layout:
      *     create table XMLSERVLOG/LOG (
      *       key varchar(64) NOT NULL WITH DEFAULT, 
      *       log TIMESTAMP NOT NULL WITH DEFAULT, 
      *       text varchar(64) NOT NULL WITH DEFAULT)
      *     Supplemental log dump XML data layout:
      *     create table XMLSERVLOG/DUMP (
      *       key varchar(64) NOT NULL WITH DEFAULT, 
      *       log TIMESTAMP NOT NULL WITH DEFAULT, 
      *       text clob(15M) NOT NULL WITH DEFAULT)
      *  - programers/vendors can alter xmlservice log database
      *    with plugconf1-3 (or custom)
      *****************************************************
      * embedded XML control overrides and function
      *****************************************************
      * sbmjob full user override of SBMJOB for XMLSERVICE start-up  -- (1.6.12+)
      *  <sbmjob>SBMJOB CMD(CALL PGM(ZENDSVR/XMLSERVICE) PARM('/tmp/override'))</sbmjob>      
      *  Where SBMJOB can be any user settings (cut/paste green screen command) ...
      *   ... required parameters for for XMLSERVICE to start CALL + PARM
      *   example:
      *       CMD(CALL PGM(ZENDSVR/XMLSERVICE) PARM('/tmp/xxxxxx')) <-- xmlservice test lib
      *       -- or --
      *       CMD(CALL PGM(ZENDSVR/XMLSERVICE) PARM('/tmp/xxxxxx')) <-- Zend Server production lib
      *       -- all other sbmjob parms at your control --
      *   Note: 
      *   - SBMJOB full control allows user to set any type of LIBL,
      *     or SBMJOB options, or even custom PGM to call XMLSERVICE
      *****************************************************
      * start/use/stop exclusive use shared IPC (hotel reservation) -- (1.6.8+)
      *  <start>KEY</start>  - acquire IPC -- first request
      *  <use>KEY</use>      - match IPC   -- each request
      *  <stop>KEY</stop>    - release IPC -- last request
      *  Where KEY anything managed by user (key-2-IPC session data) ...
      *   ... random based key -- scaling open any users,
      *       want benefit of private RPG call (open files, etc),
      *       do not care about reservation multi-request transaction
      *       -> hybrid stateless/private call,
      *          hold IPC for life of script only and release,
      *          but limit jobs
      *   ... user based key -- scaling come/go users, 
      *       want benefit of private RPG call (open files, etc), 
      *       also want reservation transactions
      *       -> hybrid persistent/private, 
      *          transaction across multi-request (browser clicks), 
      *          but limited jobs
      *   ... task based key -- everyone uses same task/tasks 
      *       limited pool jobs and all must wait a turn
      *       -> hybrid private/persistent with pre-start pool,
      *          transaction across multi-request (browser clicks), 
      *          load balancing design to limit machine stress 
      *   example many requests exclusive use IPC
      *    -- no time out --
      *     $ctl .= " *idle(0)"
      *    -- request 1 --
      *     <?xml version="1.0"?>
      *     <script>
      *     <start>unique-user-key</start>
      *     </script>
      *    -- request 2 (two minutes later) --
      *     <?xml version="1.0"?>
      *     <script>
      *     <use>unique-user-key</use>
      *     <cmd exec='rexx'>RTVJOBA USRLIBL(?)</cmd>
      *     </script>
      *    -- request 3 (1/2 hour later) --
      *     <?xml version="1.0"?>
      *     <script>
      *     <use>unique-user-key</use>
      *     <pgm name='ZZCALL'> 
      *      <parm>
      *       <data type='1A'>a</data>
      *      </parm> 
      *      <return>
      *       <data type='10i0'>0</data>
      *      </return> 
      *     </pgm> 
      *     </script>
      *    -- request n (2 hours later) --
      *     <?xml version="1.0"?>
      *     <script>
      *     <stop>unique-user-key</stop>
      *     </script>
      *   Note: 
      *   - <start>unique-user-key</start>
      *     acquire exclusive IPC if available,
      *   - <use>unique-user-key</use>
      *     must appear XML every request
      *     job held forever until see <stop>
      *   - <stop>unique-user-key</stop>
      *     release IPC for any other use
      *   - <start>no-match-key</start> 
      *     or <use>unique-user-key</use>
      *     non-matching key results in error
      *     almost instantly (no wait)
      *       busy response (1301060):
      *         <error>
      *         <errnoxml>1301060</errnoxml>
      *         <xmlerrmsg>IPC owner busy</xmlerrmsg>
      *         </error>
      *   - thoughtful setting server idle timeout
      *     can control unwanted reservation hangs
      *     due to careless users or errors 
      *     $ctl .= " *idle(60)"
      *************************************************************************
     DXFLAGS           ds
     D xNONE                         10    inz('*none')
     D xTEST                         10    inz('*test')
     D xIGNORE                       10    inz('*ignore')
     D xJUSTPROC                     10    inz('*justproc')
     D xDEBUG                        10    inz('*debug')
     D xDEBUGPROC                    10    inz('*debugproc')
     D xDEBUGCGI                     10    inz('*debugcgi')
     D xNOSTART                      10    inz('*nostart')
     D xIMMED                        10    inz('*immed')
     D xHERE                         10    inz('*here')
     D xRPT                          10    inz('*rpt')
     D xNOFLY                        10    inz('*nofly')
     D xDOFLY                        10    inz('*fly')
     D xNOLOG                        10    inz('*nolog')
     D xDOLOG                        10    inz('*log')
     D xLIC                          10    inz('*license')
     D xSES                          10    inz('*session')
     D xSBM                          10    inz('*sbmjob')
     D xCLEAR                        10    inz('*clear')
     D xHACK                         10    inz('*hack')
     D xBATCH                        10    inz('*batch')
     D xGET                          10    inz('*get')
     D xIDLE                         10    inz('*idle')
     D xWAIT                         10    inz('*wait')
     D xCALL                         10    inz('*call')
     D xHEX                          10    inz('*hex')
     D xBEFORE                       10    inz('*before')
     D xAFTER                        10    inz('*after')
     D xPASE                         10    inz('*pase')
     D xCDATA                        10    inz('*cdata')
     D xJVM                          10    inz('*java')
     D xSQLJVM                       10    inz('*sqljava')
     D xDBGJVM                       10    inz('*dbgjava')
     D xESCP                         10    inz('*escp')                         
      *
     D XFLAGMAX        c                   %div(%size(XFLAGS):%size(xNONE)) 
     D pXFLAGS         s               *   inz(%addr(XFLAGS))
     D XFLAGARRAY      s             10    dim(XFLAGMAX) based(pXFLAGS)

      *****************************************************
      * IPC flag methods 
      *****************************************************
     D ipcDoTest       PR            10i 0
     D ipcDoCDATA      PR             1N
     D ipcDoLogKey     PR            64A
     D ipcDoJVM        PR             1N
     D ipcDoSQLJVM     PR             1N
     D ipcDoDbgJVM     PR             1N

      *****************************************************
      * IPC locking
      * sequence of ipc client/server communication 
      *****************************************************
      * 0 ipcServerWaitUse - ipc wait server use (never waits)
      * 0 ipcClientWaitUse - ipc wait race other clients for turn
      * 1 ipcServerAcceptClient - ipc go   accept a client (one)
      * 2 ipcClientWaitCopyIn - ipc wait for server to allow copyin
      * 3 ipcServerAcceptCopyIn - ipc go   ask client to copy in
      * 4 ipcServerWaitCopyIn - ipc wait client copy in complete
      * 5 ipcClientRunXMLScript - ipc go   ask server make the call
      * 6 ipcClientWaitCopyOut - ipc wait server call to finish
      * 7 ipcServerDoneCopyOut - ipc go   ask client to copy out
      * 8 ipcServerWaitCopyOut - ipc wait client copy out complete
      * 9 ipcClientDoneRelease - ipc go   server released for work
      *   > xxxCltxxx - client side
      *   > xxxSvrxxx - server side
     D ipcClientWaitUse...       
     D                 PR             1N
     D ipcClientWaitCopyIn...
     D                 PR             1N
     D ipcClientRequestRunXML...
     D                 PR             1N
     D ipcClientWaitCopyOut...
     D                 PR             1N
     D ipcClientDoneRelease...
     D                 PR             1N

     D ipcServerWaitUse...
     D                 PR             1N
     D ipcServerAcceptClient...
     D                 PR             1N
     D ipcServerAcceptCopyIn...
     D                 PR             1N
     D ipcServerWaitCopyIn...
     D                 PR             1N
     D ipcServerDoneCopyOut...
     D                 PR             1N
     D ipcServerWaitCopyOut...
     D                 PR             1N

      *****************************************************
      * IPC resource
     D ipcStatic       PR              *
     D   reDo                         1N   value
     D   pIPCSP                    1024A   value
     D   pCtlSP                    1024A   value
     D   pIClob                        *   value
     D   szIClob                     10i 0 value
     D   pOClob                        *   value
     D   szOClob                     10i 0 value

     D ipcCopyIn       PR              *
     D   reDo                         1N   value
     D   srcMemP                       *   value

     D ipcRunMem       PR              *

     D ipcMake         PR             1N

     D ipcLock         PR             1N
     D   doCreate                     1N   value

     D ipcRunHere      PR             1N

     D ipcAlive        PR             1N
     D   myErrno                     10i 0

     D ipcPanic        PR             1N

     D ipcAttach       PR             1N
     D   doCreate                     1N   value

     D ipcAttach2      PR             1N

     D ipcAttach3      PR             1N
     D   doCreate                     1N   value

     D spawnJob        PR             1N

     D sbmJob          PR             1N

     D ipcDetach       PR             1N

     D ipcDetach3      PR             1N

     D ipcDestroy      PR             1N

     D ipcIsOk         PR             1N

     D ipcOwnJob       PR             1N
     D   jobKey                     128A   value

     D ipcOwnUse       PR             1N
     D   jobKey                     128A   value
     D   ipcLocked                    1N   value

     D ipcOwnEnd       PR             1N
     D   jobKey                     128A   value
     
     D ipcOwnSbm       PR             1N
     D   mySbm                     4096A   value

     D ipcEndJobImmed...
     D                 PR

     D ipcEndJobBusy...
     D                 PR

     D ipcOwnJobBusy...
     D                 PR

     D ipcPthXMLf      PR          1024A
     D   jobName                     10A   value
     D   jobUserID                   10A   value
     D   jobNbr                       6A   value

     D ipcWrtXMLf      PR             1N
     D   pData                         *   value
     D   pSize                       10i 0 value
     D   pTmpFile                  1024A   value

     D ipcBotXMLf      PR            10i 0
     D   pData                         *   value
     D   pSize                       10i 0 value
     D   pTmpFile                  1024A   value

     D ipcRmvXMLf      PR             1N

     D ipcFtok         PR            32A

     D ipcIPC          PR          1024A




