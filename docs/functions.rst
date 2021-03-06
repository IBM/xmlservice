XMLSERVICE Functions
====================
`Goto Main Page`_

.. _Goto Main Page: index.html

XMLSERVICE features
-------------------
* :ref:`face`

  * `REST interface (xmlcgi.pgm)`_
  * `DB2 stored procedure interface (lib/iPLUGxxx - xmlstoredp.srvpgm)`_

* :ref:`ctl`
* :ref:`cmd`
* :ref:`sh`
* :ref:`pgm`
* :ref:`db2`


One sample worth 1,000 words
----------------------------
* XMLSERVICE can handle multiple requests in a single XML input document.
* XMLSERVICE works with standard ``https://``, wherein, "secure" as any other web facility SSL encrypted (actual user profile, see xmlcgi.pgm).
* XMLSERVICE works with Basic Auth, etc., because XMLSERVICE is just another RPG CGI (\*NONE user/pwd, see crtnone.clp/xmlnone.pgm).
* XMLSERVICE REST example is simple html/xml, but any language will do, with/without a language toolkit (Common lab):
  ::

    <form id="myForm" name="myForm" action="https://common1.frankeni.com:47700/cgi-bin/xmlcgi.pgm" method="post">
    <input type="hidden" name="db2" value="*LOCAL">
    <br>User: <input type="input" name="uid" value=""> (see instructor)
    <br>Password: <input type="password" name="pwd" value="">
    <input type="hidden" name="ipc" value="*na">
    <input type="hidden" name="ctl" value="*here">
    <br>XML Input:
    <br><textarea readonly name="xmlin" rows="20" cols="100">
    <?xml version='1.0'?>
    <xmlservice>
    <cmd>CHGLIBL LIBL(XMLSERVICE) CURLIB(XMLSERVICE)</cmd>
    <pgm name='ZZCALL'>
    <parm><data type='1A'>a</data></parm>
    <parm><data type='1A'>b</data></parm>
    <parm><data type='7p4'>11.1111</data></parm>
    <parm><data type='12p2'>222.22</data></parm>
    <parm>
      <ds>
      <data type='1A'>x</data>
      <data type='1A'>y</data>
      <data type='7p4'>66.6666</data>
      <data type='12p2'>77777.77</data>
      </ds>
    </parm>
    </pgm>
    <sql>
    <query>select * from QIWS.QCUSTCDT where LSTNAM='Jones'</query>
    <fetch block='all'/>
    </sql>
    </xmlservice>
    </textarea>
    <input type="hidden" name="xmlout" value="512000">
    <br><input type="submit" name=submit" value="submit" />
    </form>
    </body>
    </html>


.. _face:

XMLSERVICE interfaces (with download)
-------------------------------------

XMLSERVICE includes two basic interfaces, REST (Apache), and, database (DB2). Either interface receives XML input and returns XML output.
The samples below show XMLSERVICE library (download/test library), but multiple language products ship XMLSERVICE in different libraries,
so adjust your LIB accordingly (PHP - ZENDSVR/ZENDSVR6, Ruby-POWERRUBY, etc.). XMLSERVICE uses hard coded library schemes (PLUGCONF), to
avoid interfering with user set library lists, therefore, you can only SAV/RST XMLSERVICE to
the original library. If you move XMLSERVICE non-originating libraries it will fail at runtime.

.. _`REST interface (xmlcgi.pgm)`:

* REST interface (xmlcgi.pgm)

::

  http://myibmi/cgi-bin/xmlcgi.pgm?db2=x&uid=x&pwd=x&ipc=x&ctl=x&xmlin=x&xmlout=x&persis=x
      db2 - what database (*LOCAL tested)
      uid - user profile (*NONE - no uid version 1.5+)
      pwd - profile password (*NONE - no password version 1.5+)
      ipc - IPC key name/security route to XMLSERVICE job (/tmp/fred01, etc.)
      ctl - CTL admin control XMLSERVICE job (see control below)
      xmlin - XML input document (request)
      xmlout - expected size of XML output document (response size in bytes)
      optional:
        persis - name persistent DB2 connection 8 chars or less (not often used)

  Configure (LIB match actual product, php, ruby, etc.):
  /www/myinstance/conf/httpd.conf
  ScriptAlias /cgi-bin/ /QSYS.LIB/XMLSERVICE.LIB/
  <Directory /QSYS.LIB/XMLSERVICE.LIB/>
    AllowOverride None
    order allow,deny
    allow from all
    SetHandler cgi-script
    Options +ExecCGI
  </Directory>

.. _`DB2 stored procedure interface (lib/iPLUGxxx - xmlstoredp.srvpgm)`:

* DB2 stored procedure interface (lib/iPLUGxxx - xmlstoredp.srvpgm)

::

  call XMLSERVICE.iPLUG512K(ipc, ctl, xmlin [, xmlout])
      IN IPC CHAR(1024) - IPC key name/security
      IN CTL CHAR(1024) - CTL admin control XMLSERVICE job
      IN CI CLOB(15M) - XML input document (request)
      OUT CO CLOB(15M) - XML output document (response)
          Note: iPLUGRxxx procedures return a result set that is collected by fetch.

  call XMLSERVICE.iPLUG512K(ipc, ctl, xmlin xmlout)
  ---
  XMLSERVICE.iPLUG4K(IN IPC CHAR(1024), IN CTL CHAR(1024),IN CI CHAR(4064), OUT C0 CHAR(4064))
  XMLSERVICE.iPLUG32K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(32000), OUT CO CLOB(32000))
  XMLSERVICE.iPLUG65K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(65K), OUT CO CLOB(65K))
  XMLSERVICE.iPLUG512K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(512K), OUT CO CLOB(512K))
  XMLSERVICE.iPLUG1M(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(1M), OUT CO CLOB(1M))
  XMLSERVICE.iPLUG5M(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(5M), OUT CO CLOB(5M))
  XMLSERVICE.iPLUG10M(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(10M), OUT CO CLOB(10M))
  XMLSERVICE.iPLUG15M(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(15M), OUT CO CLOB(15M))

  stmt = call XMLSERVICE.iPLUG512K(ipc, ctl, xmlin)
  while (row = fetch(stmt)) xmlout += row[0]
  ---
  XMLSERVICE.iPLUGR4K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CHAR(4096))
  XMLSERVICE.iPLUGR32K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CHAR(32000))
  XMLSERVICE.iPLUGR65K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(65K))
  XMLSERVICE.iPLUGR512K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(512K))
  XMLSERVICE.iPLUGR1M(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(1M))
  XMLSERVICE.iPLUGR5M(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(5M))
  XMLSERVICE.iPLUGR10M(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(10M))
  XMLSERVICE.iPLUGR15M(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI CLOB(15M))

  Enable DB2 drivers with no LOB support (JTOpen lite enabler - 1.9.0+):
  XMLSERVICE.iPLUGRC32K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN CI VARCHAR(32700), IN CNT INTEGER)
  Note iPLUGRC32K:
    XML input VARCHAR(32700) can be a limit, therefore interface allows
    accumulated sends of partial XML document. Any call with non-zero
    counter (CNT > 0), XMLSERVICE assumes to be XML document partial
    accumulation. When counter reaches zero (CNT = 0),
    XMLSERVICE will process the request.

.. _ctl:

XMLSERVICE Control words
------------------------

Control (CTL) keywords for operator control over XMLSERVICE jobs.

* stateless connection --  xmlservice here ``($ctl="*here";)`` -- run in QSQSRVR job, db2_connect current profile control. \*here overrides/ignores ipc, runs "\*here" in the QSQSRVR job.
* private connection 1 -- xmlservice spawn ``($ctl=""; $ipc="/tmp/user";)`` -- inherit parent job attributes, include QSQ job profile, and, job description. Per manual (below), xmlservice spawn server job has always been default when ipc included (internalKey), but missing \*sbmjob.

  * Change: 1.9.3 - Rod asked QSQSRVR name changed on spawn (spawn child name also QSQSRVR), therefore, new name spawn child will be XMLSERVICE (XMLSERVICE PGM-XMLSERVICE).

* private connection 2 -- xmlservice sbmjob ``($ctl="*sbmjob"; $ipc="/tmp/user";)`` -- control sbmjob, job description, etc. \*sbmjob allows control of job description for xmlservice server job.

  * Alternative \*sbmjob, xmlservice allows full control via ``<sbmjob>SBMJOB CMD(CALL PGM(XMLSERVICE/XMLSERVICE) PARM('/tmp/user') ... other sbmjob parms ...)</sbmjob>`` (XTOOLKIT PGM-XMLSERVICE).

::

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
      * -- escape xml reserved chars
      * *escp
      *    5 chars will be escaped in the output
      *       &  --> &amp;
      *       >  --> &gt;
      *       <  --> &lt;
      *       '  --> &apos;
      *       "  --> &quot;
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
      *      - default timeout/action provided plugconf.rpgle,
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
      * -- flight data options (affects performance, state of disrepair) --
      * *rpt
      *    - performance report last call
      * *fly
      *    - flight record performance
      * *nofly
      *    - no flight record performance (default)
      * *justproc
      *    - call stored proc, get into XMLSERVICE client,
      *      do nothing while in XMLSERVICE, return back
      *      - used to check transport speed only
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
      *    with plugconf (or custom)
      *****************************************************
      * embedded XML control overrides and function
      *****************************************************
      * sbmjob full user override of SBMJOB for XMLSERVICE start-up  -- (1.7.0+)
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


.. _cmd:

XMLSERVICE call CMD
-------------------
Syntax can largely be cut/paste from a 5250 command line.

::

      *************************************************************************
      * 1) call i CMD
      * XMLSERVICE allows calls of *CMDS on IBM i. Typically, you cut/paste
      * from a 5250 QCMD line using prompt (F4). You may use choose the utility
      * to run your command with attribute 'exec'. However, *CMDS with
      * in/out parameters, like RTVJOBA., you must use 'exec'='rexx'.
      * ---
      * <cmd [exec='cmd|system|rexx'
      *       hex='on'
      *       before='cc1/cc2/cc3/cc4'
      *       after='cc4/cc3/cc2/cc1'
      *       error='on|off|fast'
      *       ]>values (see IBM i *CMD)</cmd>
      * ---
      * cmd         - command tag
      *  values     - (see IBM i *CMD IBM i- 5250 cut/paste)
      * options
      *  exec
      *     cmd     - qcmdexe only return true/false (default)
      *     system  - system utility return CPFxxxx
      *     rexx    - rexx output parms and return CPFxxxx
      *                 (?) character type
      *                 (?N) explicit cast numeric
      *  hex (1.6.8)
      *     on      - input character hex (5147504C20202020)
      *  before
      *     cc(n)   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  after
      *     cc(n)   - output ccsid1->ccsid2->ccsid3->ccsid4
      *  error (1.7.6)
      *     on      - script stops, full error report
      *     off     - script continues, job error log (default)
      *     fast    - script continues, brief error log
      * ---
      * example run command (original)
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <cmd>ADDLIBLE LIB(DB2) POSITION(*FIRST)</cmd>
      *  </xmlservice>
      * ---
      * example output command (exec='rexx')
      *  <?xml version='1.0'?>
      *  <xmlservice>
      *  <cmd exec='rexx'>RTVJOBA USRLIBL(?) SYSLIBL(?)</cmd>
      *  <cmd exec='rexx'>RTVJOBA CCSID(?N) OUTQ(?)</cmd>
      *  <cmd exec='rexx'>RTVSYSVAL SYSVAL(QDATETIME) RTNVAR(?)</cmd>
      *  </xmlservice>
      * ---
      *   Note:
      *   - <cmd>command</cmd> should be all on one line (no LFs)
      *   - <cmd> run in XMLSERVICE job.
      *     cmd    - qcmdexe only return true/false       (default)
      *     system - system utility return CPFxxxx        (1.5.2)
      *              <cmd exec='system'><error>CPF2103</error></cmd>
      *     rexx   - rexx output parms and return CPFxxxx (1.5.2)
      *              <cmd exec='rexx'><error>CPF2103</error></cmd>
      *   - exec='rexx'
      *     All parms are assume to be character unless
      *     (?N) to explicit cast to numeric (rtvjoba). Most
      *     RTVxxxx that ask for a CL variable RTNVAR will
      *     not require the (?N) cast (IBM i manuals).
      *     QTEMP/XMLREXX(HOW) is created on demand
      *     by RPG module plugile (Github download).
      *     QTEMP/OUTREXX(OUTREXX) is created for
      *     command temp data between RPG and REXX.
      *   - Up to four conversions can take place
      *     for the truly complex ccsid issues (1.6.8)
      *     <cmd hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'>
      *       flow:
      *       -> PHP client bin2hex('wild_ascii_raw_chars')
      *       -> xmlservice hex2bin back to 'wild_ascii_raw_chars'
      *       -> xmlservice convert cc1->cc2->cc3->cc4 (before)
      *       -> xmlservice make ILE call
      *       -> xmlservice convert cc4->cc3->cc2->cc1 (after)
      *       -> xmlservice tohex "xml_hex_back"
      *       -> PHP client $chars = pack('H*',"xml_hex_back")
      *       output (incompatible change hex/ccsid 1.7.4+):
      *       <cmd exec='rexx' hex='on' before='819/37' after='37/819'>
      *         <success><![CDATA[+++ success RTVJOBA USRLIBL(?) SYSLIBL(?)]]></success>
      *         <row><data desc='USRLIBL'><hex><![CDATA[5147504C20202020202020]]></hex></data></row>
      *         <row><data desc='SYSLIBL'><hex><![CDATA[5153595320202020202020]]></hex></data></row>
      *       </cmd>
      *   - error='on,off,fast' (1.7.6)
      *       on  - script stops, full error report
      *       off - script continues, job error log (default)
      *       fast - script continues, brief error log
      *************************************************************************

.. _sh:

XMLSERVICE call PASE
--------------------

Syntax can mostly be cut/paste from PASE shell (call qp2term).

::

      *************************************************************************
      * 2) call PASE utility
      * XMLSERVICE allows calls of PASE utilities on IBM i. Typically, you cut/paste
      * from a PASE command line (call qp2term). PASE shell 'sh' is used for
      * execution of your utilities, which, is default behavior of PASE popen() API.
      * ---
      * <sh [rows='on|off'
      *      hex='on'
      *      before='cc1/cc2/cc3/cc4'
      *      after='cc4/cc3/cc2/cc1'
      *      error='on|off|fast'
      *      ]>values (see PASE utility)</sh>
      * ---
      * sh          - shell tag
      *  values     - (see PASE utility - call qp2term cut/paste)
      * options
      *  rows
      *     on      - return rows lines
      *     off     - return one string (default)
      *  hex (1.7.4)
      *     on      - input character hex (5147504C20202020)
      *  before
      *     cc(n)   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  after
      *     cc(n)   - output ccsid1->ccsid2->ccsid3->ccsid4
      * ---
      *  error (1.7.6)
      *     on      - script stops, full error report
      *     off     - script continues, job error log (default)
      *     fast    - script continues, brief error log
      * ---
      * example run PASE shell
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <sh rows='on'>/QOpenSys/usr/bin/system 'wrkactjob' | grep -i fr</sh>
      *  </xmlservice>
      * ---
      * Note:
      *   - syntax looks as if typed on console (call qp2term)
      *     <sh>pase utility</sh> runs "slower" because a child job
      *     is created to run each PASE utility (normal Unix behavior).
      *     All other XML/ILE functions run within XMLSERVICE job.
      *   - Using nested shells within this sh shell may
      *     produce unpredictable results.
      *   - hex='on' before='' after='' -- same as <cmd> (1.7.0)
      *       output (incompatible change hex/ccsid 1.7.4+):
      *       <sh rows='on' hex='on' before='819/37' after='37/819'>
      *         <row><hex>746F74616C2031363636313034</hex></row>
      *       </sh>
      *       output (rows='off' 1.7.4+):
      *       <sh hex='on' before='819/37' after='37/819'>
      *         <hex>746F74616C2031363636313034</hex>
      *       </sh>
      *   - error='on,off,fast' (1.7.6)
      *       on  - script stops, full error report
      *       off - script continues, job error log (default)
      *       fast - script continues, brief error log
      *************************************************************************


.. _qsh:

XMLSERVICE call QSH (1.9.8+)
----------------------------

Syntax can mostly be cut/paste from QSH shell (qsh).
::

      *************************************************************************
      * 2.5) call QSH utility (1.9.8+)
      * XMLSERVICE allows calls of QSH utilities on IBM i. Typically, you cut/paste
      * from a QSH command line. STRQSH is used for execution of your utilities.
      * ---
      * <qsh [rows='on|off'
      *      hex='on'
      *      before='cc1/cc2/cc3/cc4'
      *      after='cc4/cc3/cc2/cc1'
      *      error='on|off|fast'
      *      ]>values (see QSH utility)</qsh>
      * ---
      * qsh         - shell tag
      *  values     - (see QSH utility - qsh cut/paste)
      * options
      *  rows
      *     on      - return rows lines
      *     off     - return one string (default)
      *  hex (1.7.4)
      *     on      - input character hex (5147504C20202020)
      *  before
      *     cc(n)   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  after
      *     cc(n)   - output ccsid1->ccsid2->ccsid3->ccsid4
      * ---
      *  error (1.7.6)
      *     on      - script stops, full error report
      *     off     - script continues, job error log (default)
      *     fast    - script continues, brief error log
      * ---
      * example run QSH shell
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <qsh rows='on'>/usr/bin/system 'wrkactjob' | /usr/bin/grep -i fr</qsh>
      *  </xmlservice>
      * ---
      * Note:
      *   - Recommend qualify qsh utilities with /usr/bin.
      *     This will avoid ccsid conversion between PASE/QSH utilities.
      *   - syntax looks as if typed on console (qsh)
      *     <qsh>QSH utility</qsh> runs "slower" because a child job
      *     is created to run each QSH utility (normal Unix behavior).
      *   - Using nested shells within this qsh shell may
      *     produce unpredictable results.
      *   - hex='on' before='' after='' -- same as <cmd> (1.7.0)
      *   - error='on,off,fast' (1.7.6)
      *       on  - script stops, full error report
      *       off - script continues, job error log (default)
      *       fast - script continues, brief error log


.. _pgm:

XMLSERVICE call PGM
-------------------

Call PGM, SRVPGM, or system API, using XML syntax.

1) Call PGM using this XML syntax.

2) Call SRVPGM using this XML syntax.

::

      *************************************************************************
      * 3) call PGM/SRVPGM
      * XMLSERVICE allows calls of *PGM and *SRVPGM on IBM i. Typically, you match
      * call parameters, including data structures, and/or simple data elements.
      * ---
      * pgm name (*PGM or *SRVPGM)
      * <pgm name=''
      *      [lib=''
      *       func=''
      *       mode='opm|ile'
      *       error='on|off|fast'
      *       ]>values (see <parm> and <return>) </pgm>
      * ---
      * pgm         - IBM i *PGM or *SRVPGM name (tag)
      *  values     - (see parm and return)
      * options
      *  lib
      *     library - IBM i library name
      *  func
      *     function- IBM i *SRVPGM function name
      *  mode
      *     ile     - ILE and PASE memory (default)
      *     opm     - ILE only memory (PASE can not view)
      *  error (1.7.6)
      *     on      - script stops, full error report
      *     off     - script continues, job error log (default)
      *     fast    - script continues, brief error log
      *
      * ---
      * pgm parameters
      * <parm [io='in|out|both|omit'
      *        by='val|ref'
      *        ]>values (see <ds> and <data>)</parm>
      * ---
      * parm        - parm name (tag)
      *  values     - (see ds or data)
      * options
      *  io
      *     in      - input only
      *     out     - output only
      *     both    - input/output only (default)
      *     omit    - omit (1.2.3)
      *  by
      *     ref     - pass by reference (default)
      *     val     - pass by value (1.9.9.3+)
      *
      * ---
      * pgm return
      * <return>values (see <ds> and <data>)</return>
      * ---
      * return      - return tag
      *  values     - (see ds or data)
      * options
      *  na         - no options
      *
      * ---
      * pgm data structure
      * <ds [dim='n' dou='label'
      *      len='label'
      *      data='records'
      *      ]>values (see <ds> or <data>)</ds>
      * ---
      * ds          - data structure tag
      * values      - (see ds or data)
      * options
      *  dim
      *   n         - array dimension value (default dim1)
      *  dou
      *   label     - match array dou terminate parm label (see data)
      *  len (1.5.4)
      *   label     - match calculate length of ds parm lable (see data)
      *  data (1.7.5)
      *   records   - data in records tag
      *
      * ---
      * pgm data elements
      * <data type='data types'
      *       [dim='n'
      *       varying='on|off|2|4'
      *       enddo='label'
      *       setlen='label'
      *       offset='label'
      *       hex='on|off' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'
      *       trim='on|off'
      *       next='label'
      *       ]>(value)</data>
      * ---
      * data        - data value name (tag)
      *  values     - value,
      * type
      *     3i0                   int8/byte     D myint8   3i 0
      *     5i0                   int16/short   D myint16  5i 0
      *     10i0                  int32/int     D myint32 10i 0
      *     20i0                  int64/int64   D myint64 20i 0
      *     3u0                   uint8/ubyte   D myint8   3u 0
      *     5u0                   uint16/ushort D myint16  5u 0
      *     10u0                  uint32/uint   D myint32 10u 0
      *     20u0                  uint64/uint64 D myint64 20u 0
      *     32a                   char          D mychar  32a
      *     32a   {varying2} varchar            D mychar  32a   varying
      *     32a   {varying4} varchar4           D mychar  32a   varying(4)
      *     12p2                  packed        D mydec   12p 2
      *     12s2                  zoned         D myzone  12s 2
      *     4f2                   float         D myfloat  4f
      *     8f4                   real/double   D myfloat  8f
      *     3b                    binary        D mybin   (any)
      *     40h                   hole (no out) D myhole  (any)
      * options
      *  dim
      *     n       - array dimension value (default dim1)
      *  varying
      *     on      - character varying data (same as varying2)
      *     off     - character non-varying data (default)
      *     2       - character varying data
      *     4       - character varying data
      *  enddou
      *     label   - match array dou terminate parm label (see ds)
      *  setlen (1.5.4)
      *     label   - match calculate length of ds parm lable (see ds)
      *  offset
      *     label   - match offset label (see overlay)
      *  hex (1.6.8)
      *     on      - input character hex (5147504C20202020)
      *  before
      *     cc(n)   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  after
      *     cc(n)   - output ccsid1->ccsid2->ccsid3->ccsid4
      *  trim (1.7.1)
      *     on      - trim character (default)
      *     off     - no trim character
      *  next (1.9.2)
      *     label   - match next offset label (see overlay)
      *
      * ---
      * pgm parameters/return overlay
      * <overlay
      *       [io='in|out|both'
      *        offset='n|label'
      *        top='on|off|n'
      *        setnext='nextoff'
      *        ]>(see <ds> and <data>)</overlay>
      * ---
      * overlay     - structure overlay name (tag)
      *  values     - (see ds or data)
      * options
      *  io
      *     in      - input only
      *     out     - output only
      *     both    - input/output only (default)
      *  offset
      *     n       - overlay bytes offset relative
      *     label   - overlay match bytes offset label (see data)
      *  setnext (1.9.2)
      *     label   - overlay match next offset label (see data)
      *  top
      *     n       - overlay parm number (see parm)
      *     on      - overlay parm first (see parm)
      *     off     - overlay parm last seen (see parm)
      * ---
      * example run a PGM
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <cmd>CHGLIBL LIBL(XMLSERVICE) CURLIB(XMLSERVICE)</cmd>
      *  <pgm name='ZZCALL' lib=''>
      *   <parm  io='both'>
      *     <data type='1A' var='INCHARA'>a</data>
      *   </parm>
      *   <parm  io='both'>
      *     <data type='1A' var='INCHARB'>b</data>
      *   </parm>
      *   <parm  io='both'>
      *     <data type='7p4' var='INDEC1'>11.1111</data>
      *   </parm>
      *   <parm  io='both'>
      *     <data type='12p2' var='INDEC2'>222.22</data>
      *   </parm>
      *   <parm  io='both'>
      *    <ds>
      *     <data type='1A' var='INDS1.DSCHARA'>x</data>
      *     <data type='1A' var='INDS1.DSCHARB'>y</data>
      *     <data type='7p4' var='INDS1.DSDEC1'>66.6666</data>
      *     <data type='12p2' var='INDS1.DSDEC2'>77777.77</data>
      *    </ds>
      *   </parm>
      *   <return>
      *    <data type='10i0'>0</data>
      *   </return>
      *  </pgm>
      *  </xmlservice>
      * ---
      * example run a SRVPGM
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <pgm name='ZZSRV' lib='XMLSERVICE' func='ZZARRAY'>
      *   <parm comment='search this name'>
      *    <data var='myName' type='10A'>Ranger</data>
      *   </parm>
      *   <parm comment='max allowed return'>
      *    <data var='myMax' type='10i0'>5</data>
      *   </parm>
      *   <parm comment='actual count returned'>
      *    <data var='myCount' type='10i0' enddo='mycount'>0</data>
      *   </parm>
      *   <return>
      *    <ds var='dcRec_t' dim='999' dou='mycount'>
      *      <data var='dcMyName' type='10A'>na</data>
      *      <data var='dcMyJob' type='4096A'>na</data>
      *      <data var='dcMyRank' type='10i0'>0</data>
      *      <data var='dcMyPay' type='12p2'>0.0</data>
      *    </ds>
      *   </return>
      *  </pgm>
      *  </xmlservice>
      * ---
      * example optional ccsid convert name/lib format (1.6.8)
      *  <?xml version="1.0"?>
      *  <xmlservice>
      *  <pgm>
      *   <name hex='on' before='cc1/cc2/cc3/cc4'>bin2hex('&fredflin')</name>
      *   <lib hex='on' before='cc1/cc2/cc3/cc4'>bin2hex('omlated')</lib>
      *   <func hex='on' before='cc1/cc2/cc3/cc4'>bin2hex('me&proc')</func>
      *   <parm>
      *    <ds dim='3'>
      *      <data type='1A'>a</data>
      *    </ds>
      *   </parm>
      *   <return>
      *    <ds dim='999'>
      *      <data type='10i0'>0</data>
      *    </ds>
      *    </return>
      *  </pgm>
      *  </xmlservice>
      * ---
      * Note:
      *   - data types (similar RPG):
      *     ----------------------------------------------------------------------
      *     int8/byte     D myint8   3i 0            <data type='3i0'/>
      *     int16/short   D myint16  5i 0            <data type='5i0'/>
      *     int32/int     D myint32 10i 0            <data type='10i0'/>
      *     int64/int64   D myint64 20i 0            <data type='20i0'/>
      *     uint8/ubyte   D myint8   3u 0            <data type='3u0'/>
      *     uint16/ushort D myint16  5u 0            <data type='5u0'/>
      *     uint32/uint   D myint32 10u 0            <data type='10u0'/>
      *     uint64/uint64 D myint64 20u 0            <data type='20u0'/>
      *     char          D mychar  32a              <data type='32a'/>
      *     varchar       D mychar  32a   varying    <data type='32a' varying='2'/>
      *     varchar4      D mychar  32a   varying(4) <data type='32a' varying='4'/>
      *     packed        D mydec   12p 2            <data type='12p2'/>
      *     zoned         D myzone  12s 2            <data type='12s2'/>
      *     float         D myfloat  4f              <data type='4f2'/>
      *     real/double   D myfloat  8f              <data type='8f4'/>
      *     binary        D mybin   (any)            <data type='3b'>F0F1F2</data>
      *     hole (no out) D myhole  (any)            <data type='40h'/>
      *     ------------------------------------------------------------------------
      *     type='na' [varying='on|off|2|4'] - character (32A)
      *       <data type='32a'/>
      *       <data type='32a' varying='on'>ranger</data>
      *       <data type='32a'><![CDATA[<i am ranger>]]></data>
      *       <data type='200A' hex='on' before='1208/930' after='930/1208'>
      *       bin2hex($japan_raw_ascii_data)
      *       </data>
      *     type='npn' - packed decimal (12p2)
      *       <data type='12p2'/>
      *       <data type='12p2'>30.29</data>
      *     type='nsn' - zoned decimal (12s2)
      *       <data type='12s2'/>
      *       <data type='12s2'>30.29</data>
      *     type='nin' - signed integer (5i0, 10i0, 20i0)
      *       <data type='20i0'/>
      *       <data type='10i0'>-30</data>
      *     type='nun' - unsigned integer (5u0, 10u0, 20u0)
      *       <data type='20u0'/>
      *       <data type='10u0'>30</data>
      *     type='nfn' - floating point (4f2, 8f4)
      *       <data type='4f2'/>
      *       <data type='4f2'>30.34</data>
      *       <data type='8f4'>30.34</data>
      *     type='nb' - binary HEX char (2b, 400b)
      *       <data type='5b'>F0F1F2CDEF</data>
      *       <data type='2b'>1FBC</data>
      *       <data type='2b'>0F0F</data>
      *       - HEX upper case ('1FBC' not '1fbc')
      *       - high/low bits (HEX='0F0F' not HEX='F0F')
      *     type='nh' - 'hole' zero in, nothing out (4096h) (1.2.3)
      *       <data type='400h'/>
      *   - PGM/SRVPGM calls (<pgm>,<parm>,<data>,<return>) use syntax
      *     that looks like RPG to describe the data parameters
      *     (type='4b', type='32a', type='4f', type='10i0', type='12p2',
      *     etc.).
      *   - <data dim='n'> - dim='n' is new to 1.2 version and beyond,
      *     older versions did not include this feature.
      *   - Parameters using dou='label', enddo='label',
      *     label must match for this to work,
      *     then processing will only return records up to enddo limits.
      *   - Type 'h' for 'hole' is used to input x'00' fill 'hole'
      *     in the parameter geometry. It can be used to skip over
      *     a chunk of complex data that you really did not want to
      *     deal with or see in output XML. It is also very handy to
      *     use with overlay when output data is variable
      *     or unpredictable (1.2.3)
      *     input:
      *      <ds>
      *        <data type='40a'>good stuff</data>     <---offset 0
      *        <data type='400h'/>                    <---400 x'00' input
      *        <data type='32a'>more good stuff</data><---offset 440
      *      </ds>
      *     output:
      *      <ds>
      *        <data type='40a'>stuff back</data>     <--- offset 0
      *        <data type='400h'> </data>             <--- ignored output
      *        <data type='32a'>stuff back</data>     <--- offset 440
      *      </ds>
      *   - Added parm='omit' for RPG OPTIONS(*OMIT) parameter. A
      *     *NULL will be passed in this location.
      *     All parm io='omit' will be excluded from XML
      *     output returned because *NULL parameter has no data (1.2.3).
      *       <parm comment='my name' io='omit'>
      *         <data var='myName' type='10A'>Ranger</data> <--ignore *NULL
      *       </parm>
      *       RPG procedure (SRVPGM function):
      *       D zzomit PI 50A varying
      *       D myName 10A options(*OMIT) <---- optional omitted (*NULL)
      *       D yourName 10A
      *   - Added len='label'/setlen='label' to allow for
      *     automatic length calculation for various system
      *     APIs that want a %size(thing) parameter.
      *     This should work across parameters and within
      *     parameters (any order), but nesting len/setlen is
      *     not allowed.
      *       <parm  io="both" comment='Error code'>
      *        <ds comment='Format ERRC0100' len='rec2'>
      *         <data type='10i0' comment='returned'>0</data>
      *         <data type='10i0' comment='available' setlen='rec2'>0</data>
      *         <data type='7A' comment='Exception ID'> </data>
      *         <data type='1A' comment='Reserved'> </data>
      *        </ds>
      *       </parm>
      *   - Up to four conversions can take place
      *     for the truly complex ccsid issues (1.6.8)
      *      <data type='A' hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'>
      *      flow:
      *      -> PHP client bin2hex('wild_ascii_raw_chars')
      *      -> xmlservice hex2bin back to 'wild_ascii_raw_chars'
      *      -> xmlservice convert cc1->cc2->cc3->cc4 (before)
      *      -> xmlservice make ILE call
      *      -> xmlservice convert cc4->cc3->cc2->cc1 (after)
      *      -> xmlservice tohex "xml_hex_back"
      *      -> PHP client $chars = pack('H*',"xml_hex_back")
      *   - V5R4 accomidation for OPM programs like CLP (1.6.8)
      *      - mode='opm' uses non-teraspace memory to build parm lists
      *        that are used with _CALLPGMV for a "pure" OPM call mode
      *      - mode='ile' default using teraspace for "mixed" memory
      *        compatible with PASE calls (IBM i possiblilities)
      *   - Allow trim control character/binary <data ... trim='on|off'>
      *      - trim='on'  -- right trim  (default character type='na')
      *      - trim='off' -- include all (default binary type='nb')
      *   - see <overlay> for offset='label'
      *      <data offset='label'>            <-- memory location to pop off a
      *                                           variable/changing offset value
      *                                           for use in overlay()
      *      <overlay top='n' offset='label'> <-- top='n' overlay parameter 'n',
      *                                           then add offset='label' pop value
      *      - offset='label' allows label location to pop off a <data> offset value
      *        at this data location to add position offset <overlay offset='label'>
      *      - 'label' is NOT a position location for <overlay>, it only holds
      *        a offset value in this <data> memory location for things like
      *        system APIs with offset-2-next.
      *   - data='records' - data follows in record format
      *      fast "many records" i/o big data (see below)  (1.7.5)
      *      <parm comment='wsopstdcnt'>
      *       <data type='3s0' enddo='wsopstdcnt'/>
      *      </parm>
      *      <parm comment='findMe1'>
      *       <ds var='findMe1' data='records'>
      *        <ds var='dcRec1_t' array='on'>
      *         <ds var='dcRec1_t'>
      *          <data var='dcMyName1' type='10A'/>
      *          <ds var='dcRec2_t'>
      *           <data var='dcMyName2' type='10A'/>
      *           <ds var='dcRec3_t'>
      *            <data var='dcMyName3' type='10A'/>
      *            <ds var='dcRec_t' dim='999' dou='wsopstdcnt'>
      *             <data var='dcMyName' type='10A'/>
      *             <data var='dcMyJob' type='4096A'/>
      *             <data var='dcMyRank' type='10i0'/>
      *             <data var='dcMyPay' type='12p2'/>
      *            </ds>
      *           </ds>
      *          </ds>
      *         </ds>
      *        </ds>
      *       </ds>
      *       <records delimit=':'>:Rgr:B:Ok:nd1:nd1:1:1.1:...:</records>
      *      </parm>
      *      a) <records delimit=':'> simply match in order input
      *         of any complex structure. Output matches
      *         order input (see above)
      *      b) <records  delimit=':'> delimit can be any character
      *         not in your complex records (see above)
      *      c) works with any <parm> or <return>
      *      d) dou/enddo works, but tricky script to design (be careful)
      *   - setnext='nextoff' / next='nextoff' - see overlay  (1.9.2)
      *   - len/setlen - auto-len calculate ds setlen='here' (1.5.4)
      *   - error='on,off,fast' (1.7.6)
      *       on  - script stops, full error report (default)
      *       off - script continues, job error log
      *      fast - script continues, brief error log
      *   - pgm parameters/return overlay (custom offset='bytes', input/output):
      *     <overlay> works "relative" to "previous" <parm> in
      *               "order of appearance XML"
      *               or absolute position to (top='n')
      *     <pgm>
      *     --->absolute parm             <---relative parm
      *     ---><parm>complex stuff</parm><-------------------
      *     |   <overlay>complex over parm 1   </overlay>____|
      *     |
      *     |--><parm>complex stuff</parm><-------------------
      *     ||  <overlay>complex over parm 2   </overlay>____|
      *     ||  :
      *     ||  <parm>complex stuff</parm><-------------------
      *     ||  <overlay>complex over last parm</overlay>____|
      *     ||  :
      *     |___<overlay top='on'>over top parm</overlay>
      *      |  :
      *      |__<overlay top='2'>over parm 2  </overlay>
      *     </pgm>
      *   - top='on|n' allow overlay position to parameter n
      *      ... top='on' absolute parm='1' (1.2.1)
      *      ... top='n' absolute parm='n' (1.2.2)
      *      ... offset='n' bytes offset relative
      *          to top='n' position (parm 1,2,3, etc)
      *   - Once the top='n' parm location is etablished, offset='n'
      *     will move overlay to offset within the parameter.
      *     <data offset='label'>            <-- memory location to pop off a
      *                                          variable/changing offset value
      *                                          for use in overlay()
      *     <overlay top='n' offset='label'> <-- top='n' overlay parameter 'n',
      *                                          then add offset='label' pop value
      *     - offset='label' allows label location to pop off a <data> offset value
      *       at this data location to add position offset <overlay offset='label'>
      *     - 'label' is NOT a position location for <overlay>, it only holds
      *       a offset value in this <data> memory location for things like
      *       system APIs with offset-2-next.
      *   - setnext='nextoff' / next='nextoff'  (1.9.2)
      *      <pgm name='QSZRTVPR'>
      *       <parm io='both'>
      *        <ds comment='PRDR0200'>
      *         :
      *         <data type='10i0' offset='myOffset'></data>
      *         :
      *       </ds>
      *      </parm>
      *       :
      *      <overlay io='out' top='1' offset='myOffset'>
      *       <ds>
      *        <data type='10A'></data>
      *        <data type='2A'></data>
      *        <data type='10i0' enddo='prim'></data>
      *        <data type='10i0' offset='myOffset2'></data>
      *       </ds>
      *       </overlay>
      *       <overlay io='out' top='1' offset='myOffset2'
      *                dim='10' dou='prim' setnext='nextoff'>
      *       <ds>
      *        <data type='10i0' next='nextoff'></data>
      *        <data type='10A'></data>
      *        <data type='10A'></data>
      *        <data type='10A'></data>
      *        <data type='10A'></data>
      *        <data type='10A'></data>
      *        <data type='10A'></data>
      *        <data type='10i0'></data>
      *        <data type='10A'></data>
      *       </ds>
      *      </overlay>
      *************************************************************************


*Note: Additional XML attributes added for comments, var names, and documentation will simply be returned untouched, so you may build your own label conventions for XML parsing in client code.*

*Hint: use your own labels and comments XML attributes for easy client XML parsing work (var='MYVAR').*


Advanced CCSID
^^^^^^^^^^^^^^

Using default PHP toolkit DB2 clob interface (iPLUGxxx/iPLUGRxxx), ccsid conversion occurs naturally as DB2 client/server and you will not have to code before/after, but method is available if you have a specific concern or you have scripts returning many different languages.

Theory follows that most of XML document “intent” will remain immutable across db2 clob conversion (keywords, numbers, etc.), but for character data on some occasion there will be mixed/competing client/server ccsid conversion intention (client running 819, but data 1208), or there may be multiple language ccsid in the same XML document request (German, English, French), therefore using a combination of transfer in hex (hex=‘on’) and IBM i server ccsid translation before/after should allow complete control over transforms at user need.

Example::

  <data type='200A' hex='on' before='819/424' after='424/819'>bin2hex('Hebrew_ascii_raw_chars')</data>
  <data type='200A' hex='on' before='819/1098' after='1098/819'>bin2hex('Farsi_ascii_raw_chars')</data>
  <data type='200A' hex='on' before='819/880' after='880/819'>bin2hex('Russia_ascii_raw_chars')</data>
  <data type='200A' hex='on' before='819/280' after='280/819'>bin2hex('Italy_ascii_raw_chars')</data>
  <data type='200A' hex='on' before='819/273' after='273/819'>bin2hex('Germany_ascii_raw_chars')</data>
  <data type='200A' hex='on' before='819/1088' after='1088/819'>bin2hex('Korea_ascii_raw_chars')</data>
  <data type='200A' hex='on' before='1208/13488' after='13488/1208'>bin2hex('Japan_ascii_raw_chars')</data>
  <data type='200A' hex='on' before='1208/13488' after='13488/1208'>bin2hex('China_ascii_raw_chars')</data>
  where:
  before    - XMLSERVICE convert CCSID before ILE program call
  after     - XMLSERVICE convert CCSID after ILE program call for client return
  bin2hex() - script hex string unaltered ascii image (also returned hex string avoid any conversion)
  pack()    - script uses pack('H*',"xml_hex_back") function in PHP program for ascii characters
  Note:
  Up to four conversions can take place for the truly complex ccsid conversion issues
  <data type='A' hex='on' before='cc1/cc2/cc3/cc4' after='cc4/cc3/cc2/cc1'>bin2hex('wild_ascii_raw_chars')</data>
  flow:
  -> PHP client bin2hex('wild_ascii_raw_chars')
  -> xmlservice hex2bin back to 'wild_ascii_raw_chars'
  -> xmlservice convert cc1->cc2->cc3->cc4 (before)
  -> xmlservice make ILE call
  -> xmlservice convert cc4->cc3->cc2->cc1 (after)
  -> xmlservice tohex "xml_hex_back"
  -> PHP client $chars = pack('H*',"xml_hex_back")


.. _db2:

XMLSERVICE DB2 SQL
------------------

DB2 queries using only XML with syntax cut/paste STRSQL (cool, cool, cool version 1.5+).

*Note: DB2 SQL XML does not work in-line stateless ($ctl='\*here'), but works fine with normal private connections (ipc='/tmp/fred', $ctl='\*sbmjob').*

::

      *****************************************************
      * Run XML SQL statements:
      *  <sql>...</sql> - start/end run XML SQL statements
      *
      * Example easy way (chglibl, default connection, default statement):
      *  Input:
      *   <?xml version='1.0'?>
      *   <script>
      *   <cmd>CHGLIBL LIBL(XMLSERVTST QTEMP) CURLIB(XMLSERVTST)</cmd>
      *   <sql>
      *   <query>select breed, name from animal</query>
      *   <fetch block='all' desc='on'/>
      *   </sql>
      *   </script>
      *   Note: You only need chglibl once for all scripts because
      *         XMLSERVICE jobs remain active until killed (*immed).
      *         XMLSERVICE default is system naming (not sql naming),
      *         so library list is significant for unqualified
      *         statements (see options below).
      *  Output:
      *   <?xml version='1.0'?>
      *   <script>
      *   <cmd>+++ success CHGLIBL LIBL(XMLSERVTST QTEMP) CURLIB(XMLSERVTST)</cmd>
      *   <sql>
      *   <query conn='conn1' stmt='stmt1'>
      *   +++ success select breed, name from animal</query>
      *   <fetch block='all' desc='on' stmt='stmt1'>
      *   <row><data desc='BREED'>cat</data><data desc='NAME'>Pook</data></row>
      *   <row><data desc='BREED'>dog</data><data desc='NAME'>Peaches</data></row>
      *   <row><data desc='BREED'>horse</data><data desc='NAME'>Smarty</data></row>
      *   <row><data desc='BREED'>gold fish</data><data desc='NAME'>Bubbles</data></row>
      *   <row><data desc='BREED'>budgerigar</data><data desc='NAME'>Gizmo</data></row>
      *   <row><data desc='BREED'>goat</data><data desc='NAME'>Rickety Ride</data></row>
      *   <row><data desc='BREED'>llama</data><data desc='NAME'>Sweater</data></row>
      *   </fetch>
      *   </sql>
      *   </script>
      *
      * Reserved SQL words (syntax):
      * <sql>
      *
      * Connect to DB2 (optional):
      * <connect [conn='label' db='x' uid='x' pwd='x' options='label']/>
      *
      * Options template (optional):
      * <options [options='label' error='on|off|fast'
      *  Environment level (SQLSetEnvAttr) ...
      *   servermode='on'                               (default=off)
      *  Connection level (SQLSetConnAttr) ...
      *   autocommit='on|off'                           (default=on)
      *   commit='none|uncommitted|committed|repeatable|serializable'
      *                                         (default=uncommitted)
      *   naming='system|sql'                           (default=system)
      *   sqllib='mylib'                                (default=na)
      *   libl='curlib1 mylib2 mylib3'                  (default=na)
      *   datefmt='iso|usa|eur|jis|mdy|dmy|ymd|jul|job' (default=na)
      *   datesep='slash|dash|period|comma|blank|job'   (default=na)
      *   timefmt='iso|usa|eur|jis|hms|job'             (default=na)
      *   timesep='colon|period|comma|blank|job'        (default=na)
      *   decimalsep='period|comma|blank|job'           (default=na)
      *   optimize='first|all'                          (default=na)
      *  Statement level (SQLSetStmtAttr) (version 1.5.1+) ...
      *   scrollable='on|off'                           (default=off)
      *   sensitive='unspecified|sensitive|insensitive' (default=unspecified)
      *   cursor='forward|static|dynamic'               (default=forward)
      *   fetchonly='on|off'                            (deafult=on)
      *   fullopen='on|off'                             (deafult=off)
      * ]/>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      * Note:
      *  commit sets transaction-isolation level
      *  - none         - no commit        (*NONE)
      *  - uncommitted  - uncommitted read (*CHG)
      *  - committed    - cursor stability (*CS)
      *  - repeatable   - read stability   (*RS, *ALL)
      *  - serializable - repeatable read  (*RR, *ALL)
      *
      * Commit or rollback transaction (optional):
      * <commit [conn='label' action='rollback' error='on|off|fast']/>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      *
      * Execute statement directly (SQLExecDirect):
      * <query [conn='label' stmt='label' options='label' error='on|off|fast']>
      *  call storedproc('fred flinrock',42.42)
      *    -- or --
      *  select * from table where abc = 'abc'
      *    -- or (use CDATA if xml trouble special characters) --
      *  <![CDATA[select * from animal where ID < 5 and weight > 10.0]]>
      * </query>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      * Note:
      * - options='label' (version 1.5.1+)
      *
      * Prepare a statement (SQLPrepare/SQLExecute):
      * <prepare [conn='label' stmt='label' options='label' error='on|off|fast']>
      *  call storedproc(?,?)
      *    -- or --
      *  select * from table where abc = ?
      *    -- or (use CDATA if xml trouble special characters) --
      *  <![CDATA[select * from animal where ID < ? and weight > ?]]>
      * </prepare>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      * Note:
      * - options='label' (version 1.5.1+)
      *
      * Execute a prepared statement (SQLPrepare/SQLExecute):
      * <execute [stmt='label'  error='on|off|fast']>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report (default)
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      *   <parm [io='in|out|both']>my string</parm>
      *   <parm [io='in|out|both']>42.42</parm>
      * </execute>
      * Note:
      * - substitution parameters '?' are taken in order of
      *   appearence with data types decided internally in
      *   XMLSERVICE (SQLNumParams/SQLDescribeParam)
      *   and bound at call time (SQLBindParameter)
      *
      * Fetch result(s) of a statement:
      * <fetch [stmt='label' block='all|n' rec='n' desc='on|off' error="on|off|fast"/>
      *                      (default=all)         (default=on)  (default='off')
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report
      *              off - script continues, job error log (default)
      *              fast - script continues, brief error log
      *   Output (column description included via desc='on'):
      *   <fetch>
      *    <row><data desc='NAME'>Rip</data><data desc='ID'>9</data></row>
      *    <row><data desc='NAME'>Bee</data><data desc='ID'>3</data></row>
      *   </fetch>
      * Note:
      * - result set column types and descriptions are
      *   decided internally in XMLSERVICE (SQLNumResultCols/SQLDescribeCol)
      *   and bound at call time (SQLBindCol)
      * - rec='n' (version 1.5.1+)
      *
      * After query/execute statement:
      * Statment rows affected by change (SQLRowCount):
      * <rowcount [stmt='label' error='on|off']/>
      *                         (default=off)
      *  Output:
      *   <rowcount ...>24</rowcount>
      *
      * After insert of identity id:
      * Statment last identity id (IDENTITY_VAL_LOCAL):
      * <identity [conn='label' error='on|off']/>
      *                         (default=off)
      *  Output:
      *   <identity ...>23</identity>
      *
      * Statment describe parms (SQLNumParams/SQLDescribeParam):
      *                   columns (SQLNumResultCols/SQLDescribeCol):
      * <describe [stmt='label' desc='col|parm|both' error='on|off']/>
      *                                              (default=off)
      *  Output (parm):
      *   <describe ...>
      *    <parm> or <col>
      *      <name>FRED</name>
      *      <dbtype>DECIMAL</dbtype>
      *      <size>12</size>
      *      <scale>2</scale>
      *      <nullable>0</nullable>
      *    </parm> or </col>
      *   </describe>
      *
      * Statment count parms (SQLNumParams):            (1.7.6)
      *                columns (SQLNumResultCols):
      * <count [stmt='label' desc='col|parm|both' error='on|off']/>
      *                                           (default=off)
      *  Output (parm):
      *   <count ...>
      *    <colcount>nbr</colcount>
      *    <parmcount>nbr</parmcount>
      *   </count>
      *
      * Free resources:
      * <free [conn='all|label'
      *        cstmt='label'
      *        stmt='all|label'
      *        options='all|label'
      *        error='on|off|fast']/>
      * These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report
      *              off - script continues, job error log (default)
      *              fast - script continues, brief error log
      *
      * Meta data - tables:
      * <tables [conn='label' error='on|off|fast'>
      *                       (default=off)
      *   <parm>qualifier or catalog<parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      *   <parm>table type</parm>
      * </tables>
      * Output (desc varies V5R4 to V6+):
      *   <tables ...>
      *     <row>
      *       <data desc='TABLE_CAT'>LP0164D</data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='TABLE_NAME'>ANIMAL</data>
      *       <data desc='TABLE_TYPE'>BASE TABLE</data>
      *       <data desc='REMARKS'></data>
      *     </row>
      *   </tables>
      *
      * Meta data - table privileges:
      * <tablepriv [conn='label' error='on|off|fast'>
      *                       (default=off)
      *   <parm>qualifier or catalog<parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      * </tablepriv>
      * Output (desc varies V5R4 to V6+):
      *   <tablepriv ...>
      *     <row>
      *       <data desc='TABLE_CAT'>LP0164D</data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='TABLE_NAME'>ANIMAL</data>
      *       <data desc='GRANTOR'></data>
      *       <data desc='GRANTEE'>PUBLIC</data>
      *       <data desc='PRIVILEGE'>SELECT</data>
      *       <data desc='IS_GRANTABLE'>NO</data>
      *       <data desc='DBNAME'></data>
      *     </row>
      *   </tablepriv>
      *
      * Meta data - columns:
      * <columns [conn='label' error='on|off|fast'>
      *                        (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      *   <parm>column name</parm>
      * </columns>
      * Output (desc varies V5R4 to V6+):
      *   <columns ...>
      *     <row>
      *       <data desc='TABLE_CAT'>LP0164D</data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='TABLE_NAME'>ANIMAL</data>
      *       <data desc='COLUMN_NAME'>BREED</data>
      *       <data desc='DATA_TYPE'>12</data>
      *       <data desc='TYPE_NAME'>VARCHAR</data>
      *       <data desc='LENGTH_PRECISION'>0</data>
      *       <data desc='BUFFER_LENGTH'>34</data>
      *       <data desc='NUM_SCALE'>0</data>
      *       <data desc='NUM_PREC_RADIX'>0</data>
      *       <data desc='NULLABLE'>1</data>
      *       <data desc='REMARKS'></data>
      *       <data desc='COLUMN_DEF'>
      *       </data><data desc='DATETIME_CODE'>0</data>
      *       <data desc='CHAR_OCTET_LENGTH'>32</data>
      *       <data desc='ORDINAL_POSITION'>2</data>
      *     </row>
      *   </columns>
      *
      * Meta data - special columns:
      * <special [conn='label' error='on|off|fast'>
      *                           (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      *   <parm>row|transaction|session</parm>
      *   <parm>no|nullable</parm>
      * </special>
      *
      * Meta data - column privileges:
      * <columnpriv [conn='label' error='on|off|fast'>
      *                           (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      *   <parm>column name</parm>
      * </columnpriv>
      * Output (desc varies V5R4 to V6+):
      *   <columnpriv ...>
      *     <row>
      *       <data desc='TABLE_CAT'>LP0164D</data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       data desc='TABLE_NAME'>ANIMAL</data>
      *       <data desc='COLUMN_NAME'>BREED</data>
      *       <data desc='GRANTOR'></data>
      *       <data desc='GRANTEE'>PUBLIC</data>
      *       <data desc='PRIVILEGE'>SELECT</data>
      *       <data desc='IS_GRANTABLE'>NO</data>
      *       <data desc='DBNAME'></data>
      *     </row>
      *   </columnpriv>
      *
      * Meta data - procedures:
      * <procedures [conn='label' error='on|off|fast'>
      *                        (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>procedure name</parm>
      * </procedures>
      * Output (desc varies V5R4 to V6+):
      *   <procedures ...>
      *     <row>
      *       <data desc='PROCEDURE_CAT'>LP0164D</data>
      *       <data desc='PROCEDURE_SCHEM'>XMLSERVTST</data>
      *       <data desc='PROCEDURE_NAME'>MATCH1</data>
      *       <data desc='NUM_INPUT_PARAMS'>2</data>
      *       <data desc='NUM_OUTPUT_PARAMS'>1</data>
      *       <data desc='NUM_RESULT_SETS'>1</data>
      *       <data desc='REMARKS'></data>
      *     </row>
      *
      * Meta data - procedure columns:
      * <pcolumns [conn='label' error='on|off|fast'>
      *                        (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>proc name</parm>
      *   <parm>column name</parm>
      * </pcolumns>
      * Output (desc varies V5R4 to V6+):
      *   <pcolumns ...>
      *     <row>
      *       <data desc='PROCEDURE_CAT'>LP0164D</data>
      *       <data desc='PROCEDURE_SCHEM'>XMLSERVTST</data>
      *       <data desc='PROCEDURE_NAME'>MATCH1</data>
      *       <data desc='COLUMN_NAME'>FIRST_NAME</data>
      *       <data desc='COLUMN_TYPE'>1</data>
      *       <data desc='DATA_TYPE'>12</data>
      *       <data desc='TYPE_NAME'>CHARACTER VARYING</data>
      *       <data desc='PRECISION'>0</data>
      *       <data desc='LENGTH'>128</data>
      *       <data desc='SCALE'>0</data>
      *       <data desc='RADIX'>0</data>
      *       <data desc='NULLABLE'>YES</data>
      *       <data desc='REMARKS'></data>
      *       <data desc='COLUMN_DEF'>0</data>
      *       <data desc='SQL_DATA_TYPE'>12</data>
      *       <data desc='SQL_DATETIME_SUB'>0</data>
      *       <data desc='CHAR_OCTET_LENGTH'>128</data>
      *       <data desc='ORDINAL_POSITION'>1</data>
      *       <data desc='IS_NULLABLE'>YES</data>
      *     </row>
      *   </pcolumns>
      *
      * Meta data - primary keys:
      * <primarykeys [conn='label' error='on|off|fast'>
      *                           (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      * </primarykeys>
      * Output (desc varies V5R4 to V6+):
      *   <primarykeys ...>
      *     <row>
      *       <data desc='TABLE_CAT'>LP0164D</data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='TABLE_NAME'>ANIMAL2</data>
      *       <data desc='COLUMN_NAME'>NOTEID</data>
      *       <data desc='KEY_SEQ'>1</data>
      *       <data desc='PK_NAME'>Q_XMLSERVTST_ANIMAL2_NOTEID_00001</data>
      *     </row>
      *   </primarykeys>
      *
      * Meta data - foreign keys:
      * <foreignkeys [conn='label' error='on|off|fast'>
      *                           (default=off)
      *   <parm>primary qualifier or catalog</parm>
      *   <parm>primary schema name</parm>
      *   <parm>primary table name</parm>
      *   <parm>foreign qualifier or catalog</parm>
      *   <parm>foreign schema name</parm>
      *   <parm>foreign table name</parm>
      * </foreignkeys>
      * Output (desc varies V5R4 to V6+):
      *   <foreignkeys ...>
      *     <row>
      *       <data desc='PKTABLE_CAT'>LP0164D</data>
      *       <data desc='PKTABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='PKTABLE_NAME'>ANIMAL2</data>
      *       <data desc='PKCOLUMN_NAME'>NOTEID</data>
      *       <data desc='FKTABLE_CAT'>LP0164D</data>
      *       <data desc='FKTABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='FKTABLE_NAME'>FKEY2</data>
      *       <data desc='FKCOLUMN_NAME'>IDF</data>
      *       <data desc='KEY_SEQ'>1</data>
      *       <data desc='UPDATE_RULE'>3</data>
      *       <data desc='DELETE_RULE'>3</data>
      *       <data desc='FK_NAME'>Q_XMLSERVTST_FKEY2_IDF_00001</data>
      *       <data desc='PK_NAME'>Q_XMLSERVTST_ANIMAL2_NOTEID_00001</data>
      *     </row>
      *   </foreignkeys>
      *
      * Meta data - statistics:
      * <statistics [conn='label' error='on|off|fast'>
      *                           (default=off)
      *   <parm>qualifier or catalog</parm>
      *   <parm>schema name</parm>
      *   <parm>table name</parm>
      *   <parm>all|unique</parm>
      * </statistics>
      * Output (desc varies V5R4 to V6+):
      *   <statistics ...>
      *     <row>
      *       <data desc='TABLE_CAT'></data>
      *       <data desc='TABLE_SCHEM'>XMLSERVTST</data>
      *       <data desc='TABLE_NAME'>ANIMAL2</data>
      *       <data desc='NON_UNIQUE'>1</data>
      *       <data desc='00005'>XMLSERVTST</data>
      *       <data desc='00006'>INDEX2</data>
      *       <data desc='TYPE'>3</data>
      *       <data desc='ORDINAL_POSITION'>1</data>
      *       <data desc='00009'>ANIMALID</data>
      *       <data desc='COLLATION'>A</data>
      *       <data desc='CARDINALITY'>0</data>
      *       <data desc='PAGES'>0</data>
      *     </row>
      *   </statistics>
      *
      * </sql>
      *
      * NOTES:
      *
      * The XMLSERVICE sql rules:
      * > Connection rules:
      *   - if connect is omitted, then XMLSERVICE will open
      *     a default connection under the current profile.
      *   - if servermode='na' (off default), ONLY ONE connection
      *     allowed for the XMLSERVICE job. This is a DB2 rule of
      *     one activation equals one active connection/transaction,
      *     so you must free/commit a connection/transaction before
      *     attempting to create a new connection/transaction
      *     (or connect another profile). This is the correct
      *     mode for sharing QTEMP with XMLSERVICE called
      *     PGMs/SRVPGMs, so it is also the XMLSERVICE default.
      *   - if servermode='on', XMLSERVICE may have multiple
      *     connection/transactions active, BUT each connection
      *     will be running in a seperate QSQSRVR job. This means
      *     QTEMP in XMLSERVICE job will NOT BE USEABLE to communicate
      *     between XMLSERVICE called PGM/SRVPGM, etc. (QTEMP useless).
      *     Once an XMLSERVICE job enters servermode='on',
      *     it will NEVER stop using server mode until the
      *     process is ended (choose wisely).
      * > Commit rules (see options):
      *   - default is autocommit='on', where all create, insert,
      *     delete actions will be committed at operation time.
      *   - if autocommit='off', commit action may be delayed
      *     across multiple requests to XMLSERVICE and you
      *     may also rollback the transaction.
      * > Statement rules:
      *   - if stmt='label' is omitted (normal), the first active
      *     statement available will be used for a sql operation
      *     such as fetch or describe. Therefore it is not wise
      *     to mix stmt='label' and omitted in the same XMLSERVICE
      *     task.
      *   - if a stmt is left active (no free), and a subsequent
      *     'label'/omitted is attempted, the active statement will
      *     be released along with all result sets, etc. (free),
      *     and the new statement will become the active statement.
      *     Therefore if you are attempting to use multiple result
      *     sets from different queries, you should manually
      *     specify stmt='label' to avoid fetching from the
      *     wrong result set.
      * > Options rules:
      *   -Using servermode='on' universally executes statements
      *    in child process (QSQSRVR jobs), not XMLSERVICE job.
      *    Once servermode='on', it stays 'on' for all connections
      *    for the life of the XMLSERVICE job, therefore you cannot
      *    expect to share QTEMP between PGM calls/DB2 SQL, etc.
      *    (ie. think very careful before you use this option)
      *   -Default mode is servermode='na' (off), or 'normal mode',
      *    which means a single connect/transaction is allowed
      *    active at any given time. Therefore, you must end
      *    any transation with <commit> and <free conn='all'>,
      *    before attempting to switch between connection profiles.
      *    (normal CLI rules transaction/connect in a single process)
      *   -System vs. SQL naming libl, where:
      *    - naming='system' with libl='curlib1 mylib2' (list)
      *      example: select * from mylib3/table (specific library)
      *               select * from table (uses library list)
      *      (system naming is the default naming mode XMLSERVICE)
      *    - naming='sql' with *sqllib='mylib' (one)
      *      example: select * from mylib3.table (specific schema)
      *               select * from table (uses *sqllib='schema')
      *    Do not try to mix these two modes in the same
      *    connection as this always leads to program errors
      *    (ie. make up your mind before you write your scripts).
      * > Connection/statements/options label rules (optional labels):
      *   conn='label'    - unique name connection (optional)
      *   stmt='label'    - unique name statement (optional)
      *   options='label' - unique name options template (optional)
      *   - a label is ten characters or less
      *   - a unique 'label' is used as XMLSERVICE/DB2 routing 'key'
      *     thereby allowing multiple XML <sql> calls to XMLSERVICE
      *     routing back to open/active DB2 connection(s)/statement(s)
      *   - If optional conn/stmt 'label' is omitted, XMLSERVICE
      *     will return a unique 'label' attribute in output XML
      *     for subsequent sql prepare, execute, fetch, etc.
      *   - If optional conn/stmt 'label' is omitted, XMLSERVICE
      *     will attempt to use any active conn/stmt. No 'label(s)'
      *     works just fine with less XML, but you need to be very careful
      *     that other scripts do not introduce additional conn/stmt
      *     'label(s)' that spoil your generic XML DB2 statements.
      * > Connection/statements/options free rules (optional free):
      *   - Connections/statements remain active/open until released:
      *     <free/>                 - release all
      *     <free options='label'/> - release options template
      *     <free options='all'/>   - release all options template
      *     <free conn='label'/>    - release connection (and statements)
      *     <free conn='all'/>      - release all connections (and statements)
      *     <free cstmt='label'/>   - release all statements 'label' connection
      *     <free stmt='label'/>    - release this statement
      *     <free stmt='all'/>      - release all statements
      *   - conn='all'   : free all connections,
      *                    also frees all statements
      *   - cstmt='label': free all statements under 'label' connection,
      *                    other connections/statements remain active
      *   - stmt='all'   : free all statements,
      *                    connections remain active
      * > These alternate db2 features available ...
      *       error='on,off,fast' (1.7.6)
      *              on  - script stops, full error report
      *              off - script continues, job error log
      *              fast - script continues, brief error log
      *
      *****************************************************

XMLSERVICE job log
------------------
Job log info has been added to all XMLSERVICE returned fatal errors. An additonal function was also added to retrieve a job of the XMLSERVICE job or another job (1.5.8+).
::

      * 0) Optional get diagnostics (1.5.8)
      * <diag [info='joblog|conf' job='job' user='uid' nbr='nbr']/>
      *   example run
      *     <?xml version="1.0"?>
      *     <diag info='joblog'/>
      *     Note:
      *       The current XMLSERVICE job log is assumed if optional
      *       attributes job='job' user='uid' nbr='nbr' missing.
      *       if you wish to provide custom diagnostics,
      *       info='conf' calls optional hook in plugconfx.


One sample by value (xmlservice 1.9.9.3+)
------------------------------------------

This is only about RPG parameters marked 'const' or 'value'. If you do not understand these 'by value' RPG parameter types, this will only confuse (ignore).

A fix was added for by value in xmlservice 1.9.9.3. All data types test work except zoned decimal by value (although may work). This will be handled later in next base version of xjservice. Please note ``by="val"`` is an attribute of ``<parm>``, not ``<data>`` (see below).

BTW -- Attribute of ``<parm by='val'>`` is not an error (no debate). That is, ``by='ref,val'`` is indeed attribute of ``<parm>``, same as ``io='in,out,both'``, and other exotic parameter attributes like \*omit and \*nopass. Unfortunately RPG syntax obfuscates spoken words 'passing parameters' into minds eye of 'passing data(s) and structures and arrays of data' (which make no sense). Aka, ``<parm by='val' io='in'>`` is correct.
::

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

       xjInData =
         '<?xml version="1.0"?>'
       + '<xmlservice>'
       + '<cmd error="fast" exec="cmd" var="chglibl">'
       + 'CHGLIBL LIBL('+TEST_LIB+')'
       + '</cmd>'
       + '<pgm error="fast" func="GETPACKED" name="TESTZSRV" var="packme">'

       + '<parm io="both" by="val" var="p8">'
       + '<data type="8a" var="i2d">1</data></parm>'

       + '<parm io="both" by="val" var="pp1">'
       + '<data type="4p2" var="pp">1</data></parm>'

       + '<parm io="both" by="val" var="pp2">'
       + '<data type="3p2" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="pp3">'
       + '<data type="12p2" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="pp4">'
       + '<data type="6p2" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="pp5">'
       + '<data type="8p2" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="pp6">'
       + '<data type="24p4" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="pp7">'
       + '<data type="48p8" var="zz">1</data></parm>'

       + '<parm io="both" by="val" var="p2">'
       + '<data type="15a" var="ppd">1</data></parm>'

       + '<parm io="both" var="p4">'
       + '<data type="30a" var="zzd">1</data></parm>'

       + '<parm io="both" by="val" var="p7">'
       + '<data type="5i0" var="i2">1</data></parm>'

       + '<parm io="both" var="p6">'
       + '<data type="30a" var="i1d">1</data></parm>'

       + '<parm io="both" by="val" var="p9">'
       + '<data type="10i0" var="i4">1</data></parm>'

       + '<parm io="both" by="val" var="p11">'
       + '<data type="20i0" var="i8">1</data></parm>'

       + '<parm io="both" by="val" var="p13">'
       + '<data type="4f" var="f4">1</data></parm>'

       + '<parm io="both" var="p14">'
       + '<data type="30a" var="f4d">1</data></parm>'

       + '<parm io="both" by="val" var="p15">'
       + '<data type="8f" var="f8">1</data></parm>'

       + '<parm io="both" var="p10">'
       + '<data type="30a" var="i4d">1</data></parm>'

       + '<parm io="both" var="p12">'
       + '<data type="30a" var="i8d">1</data></parm>'

       + '<parm io="both" var="p16">'
       + '<data type="30a" var="f8d">1</data></parm>'

       + '<parm io="both" by="val" var="p5">'
       + '<data type="3i0" var="i1">1</data></parm>'

       + '</pgm>'
       + '</xmlservice>'
       + x'00';




.. 
  [--Author([[http://youngiprofessionals.com/wiki/index.php/XMLSERVICE/XMLSERVICEQuick?action=expirediff | s ]])--]
  [--Tony "Ranger" Cairns - IBM i PHP / PASE--]
