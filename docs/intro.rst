XMLSERVICE Introduction
=======================

`Goto Main Page`_

.. _Goto Main Page: index.html

XMLSERVICE Introduction
-----------------------

XMLSERVICE is Open Source RPG, created for web programming simplicity and deployment flexibility, 
any language, any transport, avoiding complexities dealing with big package 'web services'. 
Internally, XMLSERVICE is designed Plain Old XML (POX), which enables simple REST XML protocol, 
avoiding complexity of SOAP/WSDL based Web Services. XMLSERVICE is 100% RPG, never requires Java, 
PHP, or any other front end language to serve your IBM i RPG programs to the web. In fact, 
XMLSERVICE is so simple, that you can almost run your entire IBM i machine using only simple 
HTML/XML (demonstrated later section).

XMLSERVICE is a single library of Open Source RPG code that enables XML scripting calls of System i resources.
XMLSERVICE RPG server library does not require other language products to run on your IBM i, however language teams often provide a client toolkit to greatly simplify XML calls to XMLSERVICE.

XMLSERVICE, as name implies, enables XML services on your IBM i machine. XMLSERVICE library is simply 
a collection of Open Source RPG modules that essentially allow your to access anything on your IBM i machine, 
assuming proper profile authority. Simply stated, XMLSERVICE accepts XML document containing actions/parameters 
``(<pgm>,<cmd>,<sh>,<sql>,etc.)``, performs requested operations on IBM i, then sends an XML document of results back to the client. This simple concept has become a powerful tool for scripting language clients on IBM i including Zend Server PHP Toolkit and PowerRuby Toolkit. However, PHP and Ruby are not unique to XMLSERVICE, XML is a universal protocol support by nearly every language, therefore nearly any language can use XMLSERVICE, and most any transport between client/server.

Installation
------------
**Build requirements**

Building requires Python 3 and GNU make. These can be installed with yum: yum install python3 make-gnu

You will also need the ILE RPG compiler installed (5770-WDS option 31) along with the following PTFs::

  7.3: SI62605
  7.2: SI62604
  7.1: SI62580

**Building**

::

  PATH=/QOpenSys/pkgs/bin:$PATH

  git clone https://github.com/IBM/xmlservice.git

  cd xmlservice

  python3 ./configure

  make

**Customizing the Build**

You can customize the build by passing options to configure::

  --library: set the build library
  --debug: set the debug level (DBGVIEW CL parameter)


REST interface
^^^^^^^^^^^^^^

Optional: Set up your Apache to enable XMLSERVICE REST using RPG program XMLCGI.PGM included in XMLSERVICE installation, then restart your Apache instance.

::

  /www/apachedft/conf/httpd.conf:
  ScriptAlias /cgi-bin/ /QSYS.LIB/XMLSERVICE.LIB/
  <Directory /QSYS.LIB/XMLSERVICE.LIB/>
    AllowOverride None
    order allow,deny
    allow from all
    SetHandler cgi-script
    Options +ExecCGI
  </Directory>

  stop/start Apache instance:
  endTCPSVR SERVER(*HTTP) HTTPSVR(APACHEDFT)
  STRTCPSVR SERVER(*HTTP) HTTPSVR(APACHEDFT)

Operation and transports
------------------------

XMLSERVICE XML documents can be transported between IBM i and clients over any connection, any language.


XMLSERVICE APIs (included)
^^^^^^^^^^^^^^^^^^^^^^^^^^

XMLSERVICE library includes language transports for popular REST and DB2 connections, which fulfills needs for most internet services applications.

* XMLSERVICE/XMLCGI.PGM-- RPG CGI HTTP/REST method GET or POST (traditional web service interface)
  
  * http://myibmi/cgi-bin/xmlcgi.pgm?db2=x@uid=x@pwd=x@ipc=x@ctl=x@xmlin=x@xmlout=x

* XMLSERVICE/XMLSTOREDP.SRVPGM -- RPG DB2 stored procedure (IBM i's premier DB2 for i)

  * DB2 drivers local/remote with stored procedure IN/OUT capabilities (traditional DB2 interface)

  ::

    iPLUG4K  (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CHAR(4064),  OUT XMLOUT CHAR(4064))
    iPLUG32K (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(32000), OUT XMLOUT CLOB(32000))
    iPLUG65K (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(65K),   OUT XMLOUT CLOB(65K))
    iPLUG512K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(512K),  OUT XMLOUT CLOB(512K))
    iPLUG1M  (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(1M),    OUT XMLOUT CLOB(1M))
    iPLUG5M  (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(5M),    OUT XMLOUT CLOB(5M))
    iPLUG10M (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(10M),   OUT XMLOUT CLOB(10M))
    iPLUG15M (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(15M),   OUT XMLOUT CLOB(15M))

  * DB2 drivers local/remote without stored procedure IN/OUT capabilities (loop fetch required)
  
  ::

    iPLUGR4K  (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CHAR(4064))
    iPLUGR32K (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(32000))
    iPLUGR65K (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(65K))
    iPLUGR512K(IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(512K))
    iPLUGR1M  (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(1M))
    iPLUGR5M  (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(5M))
    iPLUGR10M (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(10M))
    iPLUGR15M (IN IPC CHAR(1024), IN CTL CHAR(1024), IN XMLIN CLOB(15M))
  
* XMLSERVICE/XMLSTOREDP.SRVPGM -- optional custom transport (programmers only)
  
  * if included XMLSERVICE transports do not fill your need, please feel free to create your own (sockets, data queues, ftp, etc.). Multiple entry APIs exist in XMLSERVICE that you may find useful:

  ::

    xmlstoredp.srvpgm - *SRVPGM interface for calls

      Native stored procedure call target (iPLUG4K - iPLUG15M):
        D iPLUG4K         PR             1N   extproc(*CL:'iPLUG4K')
        D pIPC                        1024A
        D pCtl                        1024A
        D pXmlIn                          *
        D pXmlOut                         *

      RPG call target:
        D runClient       PR             1N
        D   pIPCSP                    1024A
        D   pCtl                      1024A
        D   pIClob                        *
        D   szIClob                     10i 0
        D   pOClob                        *
        D   szOClob                     10i 0

      PASE call target (also use RPG when CCSID issues):
        D runASCII        PR             1N
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


IBM i CCSID 65535
^^^^^^^^^^^^^^^^^

XMLSERVICE REST and DB2 connections have implicit CCSID conversion between client and server, therefore your XMLIN/XMLOUT XML document will be implicitly CCSID converted by the transport layer, to wit, XMLSERVICE should just work. However, IBM i CCSID 65535 (hex), will destroy the entire XMLSERVICE scheme, and you will witness horrible hangs, junk data, dead processes, etc., so please take action on your IBM i to live with the modern ASCII world (all clients, all new scripting languages, remote/local including PASE).

**Check your IBM i for CCSID convert safety.**

If you see DSPSYSVAL 65535, you have a big problem with the ASCII world, but you can take corrective IBM i action.

::

  DSPSYSVAL SYSVAL(QCCSID)
  Coded character set
    identifier . . . . . :   65535      1-65535
  

Here are some corrective IBM i suggestions (CCSID 37 an example), but remember you have to end current running jobs and restart for the CCSID changes to enable (including XTOOLKIT jobs):

* change system ccsid

::

  CHGSYSVAL SYSVAL(QCCSID) VALUE(37)
  
* change Apache instances (/www/instance/httpd.conf)

::

  # protect FastCGI against bad CCSID (dspsysval qccsid 65535)
  DefaultFsCCSID 37
  CGIJobCCSID 37

* change user profile(s)

::

  CHGUSRPRF USRPRF(FRED) CCSID(37)
  

Connection public or private
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

XMLSERVICE parameters CTL and IPC enable two types of connections.

* public connection -- XMLSERVICE stateless, many jobs, every use a fresh start
  
  * ``CTL='*here' , IPC="*NA"``

    * "public" because any IBM i profile use is a fresh start
    * life scope -- life of a single XML IN/OUT request

* private connection -- XMLSERVICE state full, single job, where a given profile is routed to XTOOLKIT job(s)

  + ``CTL='*sbmjob' , IPC="/tmp/myjob1"``

    + ``CTL='*sbmjob'`` -- if not running, submit a new XTOOLKIT job
    + ``IPC="/tmp/myjob1"`` -- all requests of IPC route to XTOOLKIT job (\*sbmjob)
    + "private" because ONE IBM i profile owns XTOOLKIT job, any other IBM i profile will fail to attach
    + life scope -- forever, until ended by operator or user program ends XTOOLKIT job (like a 5250)

**When to use XMLSERVICE public or private?**

Of course any discussion that presumes to predict usage is likely to have legitimate user exception, but a guideline may be appropriate for use of XMLSERVICE public vs. private connection.

**Web programming style (public, stateless)**

XMLSERVICE public connections are generally used when IBM i resource can be called once by many different user profiles, 
current data returned, no lasting persistent data needed by the IBM i resource. The programmer meta description of 
transient resource services is "stateless programming".

XMLSERVICE public "stateless"
(CTL='\*here', IPC='\*NA')

- profile FRED (any public QSQ)
- profile SALLY (any public QSQ)
- profile RITA (any public QSQ)
- profile XAVIER (any public QSQ)

XMLSTOREDP->XMLSERVICE (QSQ)

- QSQ temporary profile use (stateless)
- QSQ return to pool on script end
- XMLSERVICE restart every request (web style)


Although very handy, clean wrkactjob, no hanging locks, etc., public connection is not a high performance use of XMLSERVICE.

* public connection -- XMLSERVICE stateless, many jobs, every use a fresh start
  
  + ``CTL='*here' , IPC="*NA"`` -- profile FRED (RPG company stock service)
  + ``CTL='*here' , IPC="*NA"`` -- profile SALLY (RPG IRS flat tax rate service)
  + ``CTL='*here' , IPC="*NA"`` -- profile RITA (RPG calculate pound to kilo)
  + ``CTL='*here' , IPC="*NA"`` -- profile XAVIER (RPG company stock service)

**Traditional programming style (private, state full)**

XMLSERVICE private connections are generally used when IBM i resource will be called many times by the same user profile, lasting persistent data needed by the IBM i resource (RPG variables, open files, etc.). The programmer meta description of required data services is "state full programming".

XMLSERVICE private "state full"
(CTL='\*sbmjob', IPC='/tmp/xxxx')

- profile FRED XTOOLKIT myjob1,myjob2 (private)
- profile SALLY XTOOLKIT sallyjob1 (private)
- profile RITA XTOOLKIT nursejob (private)
- profile XAVIER XTOOLKIT xjob1 - xjob5 (private)

XMLSTOREDP (QSQ)

- QSQ temporary profile use (stateless)
- QSQ return to pool on script end

XMLSERVICE (XTOOLKIT)

- XTOOLKIT owned by profile (private)
- XTOOLKIT job never ends (until killed)
- XTOOLKIT full state programming (5250 style)


Traditional RPG programs usually need to track local variables, open files, etc., between requests, both for correct functionality and performance. The XTOOLKIT jobs that result from ``CTL='*sbmjob' , IPC="/tmp/xxxx"`` are similar to 5250 jobs, where a user profile signs on, then uses 5250 job to run other programs (aka XMLSERVICE design), also, like multiple 5250 sessions (PC emulators), many different XTOOLKIT jobs can be used by the same user profile.

* private connection -- XMLSERVICE state full, single job, where a given profile is routed to same XTOOLKIT job
  
  + ``CTL='*sbmjob' , IPC="/tmp/myjob1"`` -- profile FRED XTOOLKIT myjob1 (Fred's use only RPG payroll application)
  + ``CTL='*sbmjob' , IPC="/tmp/myjob2"`` -- profile FRED XTOOLKIT myjob2 (Fred's use only RPG inventory application)
  + ``CTL='*sbmjob' , IPC="/tmp/sallyjob1"`` -- profile SALLY XTOOLKIT sallyjob1 (Sally's use only RPG admissions application)
  + ``CTL='*sbmjob' , IPC="/tmp/nursejob"`` -- profile RITA XTOOLKIT nursejob (Rita's use only RPG nurse scheduling application)
  + ``CTL='*sbmjob' , IPC="/tmp/xjob1"`` -- profile XAVIER XTOOLKIT xjob1 (Xavier's use only RPG payroll application)
  + ``CTL='*sbmjob' , IPC="/tmp/xjob2"`` -- profile XAVIER XTOOLKIT xjob2 (Xavier's use only RPG inventory application)
  + ``CTL='*sbmjob' , IPC="/tmp/xjob3"`` -- profile XAVIER XTOOLKIT xjob3 (Xavier's use only RPG admissions application)
  + ``CTL='*sbmjob' , IPC="/tmp/xjob4"`` -- profile XAVIER XTOOLKIT xjob4 (Xavier's use only RPG nurse scheduling application)
  + ``CTL='*sbmjob' , IPC="/tmp/xjob5"`` -- profile XAVIER XTOOLKIT xjob5 (Xavier's use only RPG super hero application)
  + IBM i programmer: Profile Xavier is using many XTOOLKIT jobs (xjob1 - xjob5), many different applications, but Xavier cannot use Fred's, Sally's or Rita's XTOOLKIT jobs (myjob1,myjob2,sallyjob1,nursejob), because Xavier does not own other profile XTOOLKIT jobs. XTOOLKIT jobs should be an easy pattern for RPG programmers familiar with single session 5250 job(s), owned by a profile, one thing at a time (not threaded), long running RPG programs, many IBM i files open, etc.
    
    * However, XTOOLKIT jobs have an interesting characteristic that 5250 emulator jobs cannot match, profile owned XTOOLKIT jobs can be accessed by many different client devices all at the same time, to wit, Xavier can use a laptop and a smart phone to all jobs at the same time (xjob1 - xjob5), or Xavier can leave his work laptop running (connected), go home, have dinner, and continue working all XTOOLKIT jobs from the family iPAD.

  * IBM i operator: You may wrkactjob and kill ``*immed`` XTOOLKIT jobs (same as 5250).
    
    * However, an ipcs administrative cleaner solution may suggest you write a custom XMLSERVICE program ``CTL='*immed' , IPC="/tmp/myjob1"``, to remove "in the way" XTOOLKIT jobs (suggestion only).

Open Source goal
----------------

XMLSERVICE is constantly growing Open Source, so new functions are added over time. 
XMLSERVICE goal is never impact existing applications with new features, to date, 
XML's natural ability to add keywords and attributes has been very successful in keeping this goal. 

XMLSERVICE CMDs
^^^^^^^^^^^^^^^
::

  <?xml version='1.0'?>
  <script>
  <cmd exec='rexx'>RTVJOBA USRLIBL(?) SYSLIBL(?)</cmd>
  <cmd>DLTDTAQ DTAQ(MYLIB/MYDATAQ)</cmd>
  <cmd>CRTDTAQ DTAQ(MYLIB/MYDATAQ) MAXLEN(100) AUT(*EXCLUDE)</cmd>
  </script>

XMLSERVICE PASE
^^^^^^^^^^^^^^^

::

  <?xml version='1.0'?>
  <script>
  <sh rows='on'>/QOpenSys/usr/bin/ls -l /tmp</sh>
  <sh rows='on'>/QOpenSys/usr/bin/system -i 'wrkactjob'</sh>
  </script>

XMLSERVICE DB2
^^^^^^^^^^^^^^

::

  <?xml version='1.0'?>
  <script>
  <sql>
  <options options='noauto' autocommit='off'/>
  <connect conn='myconn' options='noauto'/>
  <query conn='myconn' stmt='myupdate'>UPDATE animal SET id = 9 where ID = 3</query>
  <query conn='myconn' stmt='myselect'>select count(*) from animal where ID = 9</query>
  <fetch stmt='myselect' block='all' desc='off'/>
  <free stmt='myselect'/>
  <commit conn='myconn' action='rollback'/>
  <query conn='myconn' stmt='myselect'>select count(*) from animal where ID = 9</query>
  <fetch stmt='myselect' block='all' desc='off'/>
  <free/>
  </sql>
  </script>


XMLSERVICE PGMs, SRVPGMs, APIs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

  PGM:
  <?xml version='1.0'?>
  <script>
  <pgm name='ZZCALL' lib='XMLSERVICE'>
  <parm  io='both'>
    <data type='1A' var='INCHARA'>a</data>
  </parm>
  <parm  io='both'>
    <data type='1A' var='INCHARB'>b</data>
  </parm>
  <parm  io='both'>
    <data type='7p4' var='INDEC1'>11.1111</data>
  </parm>
  <parm  io='both'>
    <data type='12p2' var='INDEC2'>222.22</data>
  </parm>
  <parm  io='both'>
    <ds>
    <data type='1A' var='INDS1.DSCHARA'>x</data>
    <data type='1A' var='INDS1.DSCHARB'>y</data>
    <data type='7p4' var='INDS1.DSDEC1'>66.6666</data>
    <data type='12p2' var='INDS1.DSDEC2'>77777.77</data>
    </ds>
  </parm>
  <return>
    <data type='10i0'>0</data>
  </return>
  </pgm>
  </script>

  SRVPGM:
  <?xml version='1.0'?>
  <script>
  <pgm name='ZZSRV' lib='XMLSERVICE' func='ZZVARY'>
  <parm comment='search this name' io='in'>
    <data var='myName' type='10A' varying='on'><![CDATA[<Ranger>]]></data>
  </parm>
  <return>
    <data var='myNameis' type='20A' varying='on'><![CDATA[<Mud>]]></data>
  </return>
  </pgm>
  </script>

  System APIs:
  <?xml version='1.0'?>
  <script>
  <pgm name='QSNDDTAQ'>
  <parm io='in'>
    <data type='10A'>MYDATAQ</data>
  </parm>
  <parm  io='in'>
    <data type='10A'>XMLSERVICE</data>
  </parm>
  <parm  io='in'>
    <data type='5p0'>50</data>
  </parm>
  <parm  io='in'>
    <data type='100A'>System i data queues forever</data>
  </parm>
  </pgm>
  </script>


XMLSERVICE HTML/XML interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Using your IBM i and XMSERVICE download (see installation), without writing one line of code in any language, we can already check out XMLSERVICE functions using HTML/XML forms. We should note, that by any standard the following trivial XMLSERVICE example is clearly REST web services, but no SOAP, no WSDL, no Java, no PHP, no Ruby, nothing but 2 cents worth of HTML/XML.


**XMLSERVICE input** - Plain Old XML input to XMLSERVICE for request ``select * from db2/animals``.

::

  <myscript>
  <sql>
  <query>select * from db2/animals</query>
  <fetch block='all' desc='on'></fetch>
  </sql>
  </myscript>

**XMLSERVICE output** - Plain Old XML output from XMLSERVICE with records returned from ``db2/animals``.

::

  <myscript>
  <query conn='conn1' stmt='stmt1'>
  <success><![CDATA[+++ success select * from db2/animals]]></success>
  </query>
  <fetch block='all' desc='on' stmt='stmt1'>
  <row>
  <data desc='ID'><![CDATA[0]]></data>
  <data desc='BREED'><![CDATA[cat]]></data>
  <data desc='NAME'><![CDATA[Pook]]></data>
  <data desc='WEIGHT'><![CDATA[3.20]]></data>
  </row>
  </myscript>


Instructions for your IBM i machine
-----------------------------------

**Step 1)** - Add XMLSERVICE to any Apache instance (APACHEDFT)

Set up your Apache to enable XMLSERVICE REST using RPG program XMLCGI.PGM included in XMLSERVICE installation, then restart your Apache instance.

::

  /www/apachedft/conf/httpd.conf:
  ScriptAlias /cgi-bin/ /QSYS.LIB/XMLSERVICE.LIB/
  <Directory /QSYS.LIB/XMLSERVICE.LIB/>
    AllowOverride None
    order allow,deny
    allow from all
    SetHandler cgi-script
    Options +ExecCGI
  </Directory>

  start Apache instance:
  STRTCPSVR SERVER(*HTTP) HTTPSVR(APACHEDFT)


**Step 2)** - Ready to use XMLSERVICE for HTML/XML

Cut/Paste following HTML/XML form to your laptop Desktop/strsql.html:

* change action target to your actual machine ``action="http://myibmi/cgi-bin/xmlcgi.pgm"``
* point your favorite browser at the HTML file ``file:///home/adc/Desktop/strsql.html``
    
  * enter database (\*LOCAL), user (your profile), password (your password)
  * enter a SQL query in HTML strsql command and press button ``STRSQL`` 

::

  desktop/strsql.html:
  <html>
  <head>
  <script>
  function getVal() {
  xml = "<?xml version='1.0'?>";
  xml += "<myscript>";
  xml += "<sql>";
  xml += "<query>";
  xml += document.getElementById('strsql').value;
  xml += "</query>";
  xml += "<fetch block='all' desc='on'>";
  xml += "</fetch>";
  xml += "</sql>";
  xml += "</myscript>";
  document.getElementById('xmlin').value = xml;
  }
  </script>
  </head>
  <body>
  <h3>STRSQL</h3>
  <form onsubmit="getVal();" name="input" action="http://myibmi/cgi-bin/xmlcgi.pgm" method="post">
  <br><input type="text" name="db2" value="*LOCAL" size="40" > database
  <br><input type="text" name="uid" value="MYUID" size="40" > user
  <br><input type="password" name="pwd" value="MYPWD" size="40" > password
  <input type="hidden" name="ipc" value="*NA">
  <input type="hidden" name="ctl" value="*here *cdata">
  <input type="hidden" name="xmlin" id="xmlin" value="na">
  <input type="hidden" name="xmlout" value="500000">
  <br><input type="text" name="strsql" id="strsql" size="40" /> strsql command (select * from db2/animals)
  </table>
  <br><br><input type="submit" value="STRSQL" />
  </form>
  </body>
  </html>


**desktop/strsql.html example**

As strsql.html name implies, this simple html enables STRSQL running from your laptop to your IBM i. Enter any SQL statement you wish in the html form and XMLSERVICE will run just like STRSQL green screen when you press the ``STRSQL`` button. XMLSERVICE output returned will be XML (of course), so if your browser has issues displaying XML, you may have to view page source.

HTML form strsql.html uses simple JavaScript function ``getVal()`` with ``document.getElementById('strsql').value``, which reads HTML text input ``<input id='strsql'`` and adds user SQL request to XML document to HTML text input ``<input id="xmlin"``. All XMLSERVICE required REST tag elements can bee seen in the following HTML form ``http://myibmi/cgi-bin/xmlcgi.pgm?db2=*LOCAL@uid=MYUID@pwd=MYPWD@ipc=*NA@ctl="*here *cdata"@xmlin=(see JavaScript)@xmlout=500000``, but we will cover this in later sections.

**What is happening?**

If we change ``method="post"`` to ``method="get"``, the fully encoded document will appear on the browser URL line. As you can see, when input arrives from our browser (or REST client), XMLSERVICE/XMLCGI.PGM has much HTTP decoding before actually parsing the XML document and servicing the request.

::

  <form onsubmit="getVal();" name="input" action="http://myibmi/cgi-bin/xmlcgi.pgm" method="post">
  -- change --
  <form onsubmit="getVal();" name="input" action="http://myibmi/cgi-bin/xmlcgi.pgm" method="get">

  The follow cut/paste is one continuous browser line (split for viewing):
  http://myibmi/cgi-bin/xmlcgi.pgm?db2=*LOCAL
  &uid=MYUID
  &pwd=MYPWD
  &ipc=*NA
  &ctl=*here+*cdata
  &xmlin=%3C%3Fxml+version%3D%271.0%27%3F%3E
        %3Cmyscript%3E
        %3Csql%3E
        %3Cquery%3Eselect+*+from+db2%2Fanimals
        %3C%2Fquery%3E
        %3Cfetch+block%3D%27all%27+desc%3D%27on%27%3E
        %3C%2Ffetch%3E
        %3C%2Fsql%3E
        %3C%2Fmyscript%3E
  &xmlout=500000
  &strsql=select+*+from+db2%2Fanimals


The flow:

* We point our browser ``file:///home/adc/Desktop/strsql.html``, enter SQL query and press ``STRSQL`` button
* IBM i Apache XMLCGI.PGM receives our encoded HTML/XML form ``action="http://myibmi/cgi-bin/xmlcgi.pgm"``
* XMLCGI.PGM calls XMLSERVICE.PGM (using DB2 stored procedures iPLUGxxx, but you do not need to know this yet).
* XMLSERVICE.PGM parses XML input and runs internal DB2 driver ``<sql><query>...</query></sql>``.
* XMLSERVICE.PGM parses result set from DB2 driver into output XML document ``<sql><fetch/></sql>``
* browser sees XML return of DB2 data

XMLSERVICE is Open Source, so you can examine internals of XMLCGI.PGM, for now , we simply need to understand XMLCGI.PGM decodes HTML/XML document, passes XML document request to XMLSERVICE.PGM (DB2 request example), and returns XML output to client (browser). If REST client is not a browser, but a scripting language like PHP or Ruby, exact same sequence occurs, except additionally most languages offer an XML parser to parse output XML into variables or structures (PHP Toolkit or Ruby Toolkit).

Quick test functions HTML/XML
-----------------------------

XMLSERVICE HTML/XML technique can be used for nearly anything on IBM i machine CMD, PGM, SRVPGM, system APIs, PASE utilities, DB2, etc. Feel free to copy strsql.html form, modify, and try other XMLSERVICE functions ``<myscript>other functions</myscript>``. HTML/XML technique is a very handy testing a potential XMLSERVICE program service without writing a line of code, and, clearly demonstrates elegant simplicity embodied by XMLSERVICE.

XMLSERVICE DB2 interface
^^^^^^^^^^^^^^^^^^^^^^^^

DB2 connection is not a web service, but many languages support high speed DB2 local/remote requests, so XMLSERVICE included a stored procedures interface (iPLUG4K - iPLUG15M). The nature of DB2 stored procedures requires a size specified on in/out parameters, therefore XMLSERVICE library includes various iPLUGxx sizes to fit your XML document data needs (4K, 32K, 65K, 512K, 1M, 5M, 10M, up to 15M).

We should note, XMLSERVICE DB2 is much faster over REST interface, so many language toolkits offer DB2 connection as the premier service.

* RPG DB2 (no toolkit)

::

       myIPC = '/tmp/thebears1';
       myCtl = '*sbmjob';
       // call XMLSERVICE/ZZCALL(...) using XML only
       myXmlIn =
         '<?xml version="1.0" encoding="ISO-8859-1"?>'         + x'0D'
       + '<script>'                                            + x'0D'
       + '<pgm name="ZZCALL" lib="XMLSERVICE">'                + x'0D'
       + '<parm><data type="1a" v="1">Y</data></parm>'         + x'0D'
       + '<parm><data type="1a" v="2">Z</data></parm>'         + x'0D'
       + '<parm><data type="7p4" v="3">001.0001</data></parm>' + x'0D'
       + '<parm><data type="12p2" v="4">0003.04</data></parm>' + x'0D'
       + '<parm>'                                              + x'0D'
       + ' <ds>'                                               + x'0D'
       + '  <data type="1a" v="5">A</data>'                    + x'0D'
       + '  <data type="1a" v="6">B</data>'                    + x'0D'
       + '  <data type="7p4" v="7">005.0007</data>'            + x'0D'
       + '  <data type="12p2" v="8">0000000006.08</data>'      + x'0D'
       + ' </ds>'                                              + x'0D'
       + '</parm>'                                             + x'0D'
       + '</pgm>'                                              + x'0D'
       + '</script>'                                           + x'00';
       myXmlOut = *BLANKS;
       // make call to XMLSERVICE provided stored procedure(s)
       // sizes from iPLUG4k to iPLUG15M (see crtsql xmlservice package)
       Exec Sql call XMLSERVICE/iPLUG4K(:myIPC,:myCtl,:myXmlIn,:myXmlOut);

* PHP DB2 (toolkit)

::

  require_once("ToolkitService.php");
  try { $ToolkitServiceObj = ToolkitService::getInstance($database, $user, $password); }
  catch (Exception $e) { die($e->getMessage()); }
  $ToolkitServiceObj->setToolkitServiceParams(
  array('InternalKey'=>$ipc,         // route to same XMLSERVICE job /tmp/myjob1
  'subsystem'=>"QGPL/QDFTJOBD",      // subsystem/jobd to start XMLSERVICE (if not running)
  'plug'=>"32K"));                   // max size data i/o (iPLUG4K,32K,65K, 512K,1M,5M,10M,15M)
  $param[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'INCHARA', 'var1', 'Y');
  $param[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'INCHARB', 'var2', 'Z');
  $param[] = $ToolkitServiceObj->AddParameterPackDec('both',  7,4,'INDEC1',  'var3', '001.0001');
  $param[] = $ToolkitServiceObj->AddParameterPackDec('both', 12,2,'INDEC2',  'var4', '0000000003.04');
    $ds[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'DSCHARA', 'ds1',  'A');
    $ds[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'DSCHARB', 'ds2',  'B');
    $ds[] = $ToolkitServiceObj->AddParameterPackDec('both',  7,4,'DSDEC1',  'ds3',  '005.0007');
    $ds[] = $ToolkitServiceObj->AddParameterPackDec('both', 12,2,'DSDEC1',  'ds4',  '0000000006.08');
  $param[] = $ToolkitServiceObj->AddDataStruct($ds);
  $result  = $ToolkitServiceObj->PgmCall('ZZCALL', $testLib, $param, null, null);
  echo "good so far ...\n";
  var_dump($result);


* PHP DB2 (without toolkit)

::

  $fast = false;
  $ipc = "*NA";
  $ctl = "*here *cdata";
  $xmlIn   = "<?xml version='1.0' encoding='ISO-8859-1'?>
  <script>
  <pgm name='ZZCALL' lib='ZENDSVR'>
  <parm><data type='1a'>Y</data></parm>
  <parm><data type='1a'>Z</data></parm>
  <parm><data type='7p4'>001.0001</data></parm>
  <parm><data type='12p2'>0000000003.04</data></parm>
  <parm>
  <ds>
    <data type='1a'>A</data>
    <data type='1a'>B</data>
    <data type='7p4'>005.0007</data>
    <data type='12p2'>0000000006.08</data>
  </ds>
  </parm>
  </pgm>
  </script>";
  $xmlOut = '';
  if ($fast) $conn = db2_pconnect($db, $user, $pass);     // persistent/pooled connection
  else $conn = db2_connect($db, $user, $pass);            // full open/close connection
  if (!$conn) die("Bad connect: $db, $user");
  $stmt = db2_prepare($conn, "call $lib.$plug(?,?,?,?)"); // Call XMLSERVICE
                                                          // stored procedure interface
                                                          // in/out parameter (xmlOut)
                                                          // sizes: iPLUG4K - iPLUG15M
  if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
  $ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);     // ? - /tmp/raw_$user (*sbmjob)
  $ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);     // ? - *here or *sbmjob
  $ret=db2_bind_param($stmt, 3, "xmlIn", DB2_PARAM_IN);   // ? - XML input script
  $ret=db2_bind_param($stmt, 4, "xmlOut", DB2_PARAM_OUT); // ? - XML output return
  $ret=db2_execute($stmt);
  if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
  var_dump($xmlOut);
  


  PowerRuby DB2 (toolkit)
  -----------------------

::

  require 'active_record'
  require 'xmlservice'

  ActiveRecord::Base.establish_connection(
    :adapter   => 'ibm_db',
    :database => '*LOCAL',
    :username => 'MYUID',
    :password => 'MYPWD'
  )
  ActiveXMLService::Base.establish_connection(
    :connection => 'ActiveRecord',
    :install => "XMLSERVICE",
    :ctl => "*here *cdata",
    :ipc => "*NA",
    :size => 4096,
    :head => "<?xml version='1.0'?>"
  )
  zzcall = XMLService::I_PGM.new("zzcall","xmlservice")
  zzcall << XMLService::I_a.new('inchara',1,'a')
  zzcall << XMLService::I_a.new('incharb',1,'b')
  zzcall << XMLService::I_p.new('indec1',7,4,11.1111)
  zzcall << XMLService::I_p.new('indec2',12,2,222.22)
  zzcall << XMLService::I_DS.new('inds1',1,
            [XMLService::I_a.new('dschara',1,'x'),
            XMLService::I_a.new('dscharb',1,'y'),
            XMLService::I_p.new('dsdec1',7,4,66.6666),
            XMLService::I_p.new('dsdec2',12,2,77777.77)])
  zzcall.xmlservice
  puts zzcall.out_xml

* PowerRuby DB2 (without toolkit)

::

  require 'active_record'

  ipc = "*NA"
  ctl = "*here *cdata"
  xmlin = '<?xml version="1.0"?>
  <script>
  <pgm name="ZZCALL" lib="XMLSERVICE">
  <parm  io="both">
    <data type="1A">a</data>
  </parm>
  <parm  io="both">
    <data type="1A">b</data>
  </parm>
  <parm  io="both">
    <data type="7p4">11.1111</data>
  </parm>
  <parm  io="both">
    <data type="12p2">222.22</data>
  </parm>
  <parm  io="both">
    <ds>
    <data type="1A">x</data>
    <data type="1A">y</data>
    <data type="7p4">66.6666</data>
    <data type="12p2">77777.77</data>
    </ds>
  </parm>
  <return>
    <data type="10i0">0</data>
  </return>
  </pgm>
  </script>'
  xmlout = ""
  ActiveRecord::Base.establish_connection(
    :adapter   => 'ibm_db',
    :database => '*LOCAL',
    :username => 'MYUID',
    :password => 'MYPWD'
  )
  conn = ActiveRecord::Base.connection.connection
  stmt = IBM_DB::prepare(conn, 'CALL XMLSERVICE.iPLUG512K(?,?,?,?)')
  ret = IBM_DB::bind_param(stmt, 1, "ipc", IBM_DB::SQL_PARAM_INPUT)
  ret = IBM_DB::bind_param(stmt, 2, "ctl", IBM_DB::SQL_PARAM_INPUT)
  ret = IBM_DB::bind_param(stmt, 3, "xmlin", IBM_DB::SQL_PARAM_INPUT)
  ret = IBM_DB::bind_param(stmt, 4, "xmlout", IBM_DB::SQL_PARAM_OUTPUT)
  ret = IBM_DB::execute(stmt)
  puts xmlout


* Java DB2 (no toolkit)

::

  import java.io.*;
  import java.util.*;
  import java.sql.*;
  import java.math.*;

  public class javaXMLserviceDemoJDBC {
  public static void main(String[] args)   {
    Connection conn = null;
    Statement stmt=null;
    CallableStatement cstmt = null ;
    PreparedStatement pstmt = null;
    String url = "jdbc:db2://localhost"; // Set URL for data source
    String user = "MYUID";
    String password = "MYPWD";
    try
    { // Load the DB2(R) Universal JDBC Driver with DriverManager
      Class.forName("com.ibm.db2.jdbc.app.DB2Driver");
      conn = DriverManager.getConnection(url, user, password);
      String inputClob =
          "<?xml version='1.0'?>"
        + " <script>"
        + " <pgm name='ZZCALL' lib='XMLSERVICE'>"
        + " <parm><data type='1A'>a</data></parm>"
        + " <parm><data type='1A'>b</data></parm>"
        + " <parm><data type='7p4'>11.1111</data></parm>"
        + " <parm><data type='12p2'>222.22</data></parm>"
        + " <parm>"
        + " <ds>"
        + " <data type='1A'>x</data>"
        + " <data type='1A'>y</data>"
        + " <data type='7p4'>66.6666</data>"
        + " <data type='12p2'>77777.77</data>"
        + " </ds>"
        + " </parm>"
        + " <return><data type='10i0'>0</data></return>"
        + " </pgm>"
        + " </script>";
      String sql="CALL XMLSERVICE.iPLUG512K(?,?,?,?)";
      cstmt = conn.prepareCall(sql);
      System.out.println("Calling with valid name");
      cstmt.setString(1,"/tmp/packers01");
      cstmt.setString(2,"*sbmjob");
      cstmt.setString(3,inputClob);
      cstmt.registerOutParameter(4, Types.CLOB);
      cstmt.execute();
      String doc = cstmt.getString(4);
      System.out.println("****** Documento XML: **********");
      System.out.println(doc);
    }
    catch (Exception e)
    { System.out.println("******* Eccezione !!! *********");
      e.printStackTrace();
    }
  }
  }


* perl DB2 (no toolkit)

::

  use DBI;
  use DBD::DB2::Constants;
  use DBD::DB2;

  $dbh = DBI->connect("dbi:DB2:*LOCAL")
              or die $DBI::errstr;

  $stmt = 'call XMLSERVICE.iPLUG65K(?,?,?,?)';
  $sth = $dbh->prepare($stmt)
    or die "prepare got error " . $dbh->err;
  $ipc = "/tmp/perlme";
  $sth->bind_param(1, $ipc)
    or die "bind 1 got error " . $dbh->err;
  $ctl = "*sbmjob";
  $sth->bind_param(2, $ctl)
    or die "bind 2 got error " . $dbh->err;
  $xmlin = '<?xml version="1.0"?>
  <script>
  <pgm name="ZZCALL" lib="XMLSERVICE">
  <parm  io="both">
    <data type="1A">a</data>
  </parm>
  <parm  io="both">
    <data type="1A">b</data>
  </parm>
  <parm  io="both">
    <data type="7p4">11.1111</data>
  </parm>
  <parm  io="both">
    <data type="12p2">222.22</data>
  </parm>
  <parm  io="both">
    <ds>
    <data type="1A">x</data>
    <data type="1A">y</data>
    <data type="7p4">66.6666</data>
    <data type="12p2">77777.77</data>
    </ds>
  </parm>
  <return>
    <data type="10i0">0</data>
  </return>
  </pgm>
  </script>
  ';
  $sth->bind_param(3, $xmlin)
    or die "bind 3 got error " . $dbh->err;
  $xmlout = "";
  $xmloutlen = 4096;
  $sth->bind_param_inout(4, \$xmlout, $xmloutlen)
    or die "bind 4 got error " . $dbh->err;
  $sth->execute()
    or die "execute got error" . $dbh->err;



XMLSERVICE REST interface
^^^^^^^^^^^^^^^^^^^^^^^^^

XMLSERVICE includes a simple REST interface (XMLCGI.PGM), we demonstrated using the REST service using only HTML/XML in a previous section. Most languages support REST calls, so XMLSERVICE REST interface can be very useful for cloud applications where DB2 drivers are not available. XMLSERVICE has REST production clients in most every scripting language you can imagine (PHP, Ruby, perl, python, etc.).

* JavaScript REST (no toolkit)

::

  <html>
  <head>
  <script src="http://ajax.googleapis.com/ajax/libs/dojo/1.5/dojo/dojo.xd.js" type="text/javascript"></script>
  <script language="javascript">
  dojo.require("dojox.xml.parser");
  // you will need actual uid/pwd
  // *NONE not enabled by default
  var msgin = "xmlservice input";
  var msgout = "xmlservice output";
  var xmlhttp = null;
  var url = encodeURI("http://"
          + self.location.hostname
          + "/cgi-bin/xmlcgi.pgm?"
          + "db2=*LOCAL"
          + "&uid=MYUID"
          + "&pwd=MYPWD"
          + "&ipc=/tmp/rangerhtmlonly"
          + "&ctl=*sbmjob"
          + "&xmlin="
          + "<?xml version='1.0'?>"
          + " <myscript>"
          + " <pgm name='ZZCALL' lib='XMLSERVICE'>"
          + " <parm var='p1'><data type='1A' var='d1'>a</data></parm>"
          + " <parm var='p2'><data type='1A' var='d2'>b</data></parm>"
          + " <parm var='p3'><data type='7p4' var='d3'>11.1111</data></parm>"
          + " <parm var='p4'><data type='12p2' var='d4'>222.22</data></parm>"
          + " <parm var='p5'>"
          + " <ds var='myds'>"
          + " <data type='1A' var='ds1'>x</data>"
          + " <data type='1A' var='ds2'>y</data>"
          + " <data type='7p4' var='ds3'>66.6666</data>"
          + " <data type='12p2' var='ds4'>77777.77</data>"
          + " </ds>"
          + " </parm>"
          + " <return var='rc'><data type='10i0' var='d1'>0</data></return>"
          + " </pgm>"
          + " </myscript>"
          + "&xmlout=32768");
  function readNode(baseNode,output)
  { // @copy: http://blog.char95.com/post/simple-javascript-xml2array-parser/
    var node = baseNode.firstChild;
    if (output==undefined) var output = {};
    while(node)
    { var nodeData = {};
      if (node.attributes)
      { var nNodes = node.attributes.length;
        while(nNodes--) nodeData['$'+node.attributes[nNodes].nodeName] = node.attributes[nNodes].nodeValue;
      }
      if (output[node.nodeName]==undefined) output[node.nodeName] = new Array(nodeData);
      else output[node.nodeName].push(nodeData);
      var id = output[node.nodeName].length-1;
      output[node.nodeName][id] = readNode(node,output[node.nodeName][id]);
      if (node.firstChild) nodeData['#text'] = node.firstChild.nodeValue;
      node = node.nextSibling;
    }
    return output;
  }
  function processXMLSERVICE2()
  { var args =
    { url:url,
      handleAs:"xml",
      preventCache:true,
      load:function(data)
      { var xmlArray = readNode(data);
        var table = document.createElement('table');
        var output =
          "<th>parm</th>"
        + "<th>ds</th>"
        + "<th>var</th>"
        + "<th>value</th>\n";
        parms = xmlArray['myscript'][0]['pgm'][0]['parm'];
        for (var i=0;i<parms.length;i++)
        { if (i<parms.length - 1)
          { output += "<tr>"
            + "<td>" + parms[i].$var + "</td>\n"
            + "<td>" + "(na)" + "</td>\n"
            + "<td>" + parms[i]['data'][0].$var + "</td>\n"
            + "<td>" + parms[i]['data'][0]['#text'] + "</td>\n"
            + "</tr>";
          }
          else
          { dsvar = parms[i]['ds'][0].$var;
            dsdata = parms[i]['ds'][0]['data'];
            for (var j=0;j<dsdata.length;j++)
            { output += "<tr>"
              + "<td>" + parms[i].$var + "</td>\n"
              + "<td>" + dsvar + "</td>\n"
              + "<td>" + dsdata[j].$var + "</td>\n"
              + "<td>" + dsdata[j]['#text'] + "</td>\n"
              + "</tr>";
            }
          }
        }
        output += "</table>\n";
        table.setAttribute("border","1")
        table.innerHTML = output;
        document.getElementById("addtable").appendChild(table);
      },
      error:function(error)
      { alert("Error:" + error);
      }
    };
    var ajaxCall = dojo.xhrGet(args);
  }
  </script>
  </head>
  <body>
  <p>This page demonstrates calling XMLSERVICE by JavaScript. Display source in your browser to see JavaScript used.</p>
  <form>
  <ul>
  <li><a href="javascript: processXMLSERVICE2();">{XMLSERVICE JavaScript table (click me)}</a> - DoJo REST call RPG build table element</li>
  </eul>
  <p>
  <div id="addtable"></div>
  </p>
  </form>
  </body>
  </html>
  

* PHP REST (no toolkit)

::

  <?php
  function getxml() {
  $clob = <<<ENDPROC
  <?xml version='1.0'?>
  <script>
  <pgm name='ZZCALL' lib='XMLSERVICE'>
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
  <return><data type='10i0'>0</data></return>
  </pgm>
  </script>
  ENDPROC;
  return $clob;
  }
  // make the call
  $i5persistentconnect = false;
  $database = "*LOCAL";
  $user = "MYUID";
  $password = "MYPWD";
  $libxmlservice = "XMLSERVICE";
  $ipc = '/tmp/rangerhtmlonly';
  $ctl = '*sbmjob';
  $clobIn = getxml();
  $clobOut = "";
  $clobOutMax = "32000";
  $i5rest = "http://174.79.32.155/cgi-bin/xmlcgi.pgm";
  $postdata = http_build_query(
    array(
      'db2' => $database,
      'uid' => $user,
      'pwd' => $password,
      'ipc' => $ipc,
      'ctl' => $ctl,
      'xmlin' => $clobIn,
      'xmlout' => $clobOutMax    // size expected XML output
    )
    );
  $opts = array('http' =>
    array(
      'method'  => 'POST',
      'header'  => 'Content-type: application/x-www-form-urlencoded',
      'content' => $postdata
    )
    );
  $context  = stream_context_create($opts);
  $clobOut = file_get_contents($i5rest, false, $context);
  ?>


* PowerRuby REST (no toolkit)

::

  require 'adapters/abstract_adapter'
  require 'net/http'
  require 'uri'

  xmlin = '<?xml version="1.0"?>
  <script>
  <pgm name="ZZCALL" lib="XMLSERVICE">
  <parm  io="both">
    <data type="1A">a</data>
  </parm>
  <parm  io="both">
    <data type="1A">b</data>
  </parm>
  <parm  io="both">
    <data type="7p4">11.1111</data>
  </parm>
  <parm  io="both">
    <data type="12p2">222.22</data>
  </parm>
  <parm  io="both">
    <ds>
    <data type="1A">x</data>
    <data type="1A">y</data>
    <data type="7p4">66.6666</data>
    <data type="12p2">77777.77</data>
    </ds>
  </parm>
  <return>
    <data type="10i0">0</data>
  </return>
  </pgm>
  </script>'
  xmlout = ""

  post_args = {
  :db2 => "*LOCAL",
  :uid => "MYUID",
  :pwd => "MYPWD",
  :ipc => "*NA",
  :ctl => "*here *cdata",
  :xmlin => xmlin,
  :xmlout => 4096
  }
  uri = URI("http://myibmi/cgi-bin/xmlcgi.pgm")
  res = Net::HTTP.post_form(uri, post_args)
  xmlout = res.body
  puts xmlout


* Java REST (no toolkit)

::

  import java.net.*;
  import java.io.*;
  public class javaXMLserviceDemoREST {
    public static void main(String[] args)
    { try
      { // The URL class does not itself encode or decode any URL components according to the escaping mechanism defined in RFC2396.
        // It is the responsibility of the caller to encode any fields, which need to be escaped prior to calling URL,
        // and also to decode any escaped fields, that are returned from URL. Furthermore, because URL has no knowledge of URL escaping,
        // it does not recognise equivalence between the encoded or decoded form of the same URL
        String inputURL =
            "http://174.79.32.155/cgi-bin/xmlcgi.pgm?"
          + java.net.URLEncoder.encode(
            "db2=*LOCAL"
          + "&uid=MYUID"
          + "&pwd=MYPWD"
          + "&ipc=/tmp/rangerhtmlonly"
          + "&ctl=*sbmjob"
          + "&xmlin="
          + "<?xml version='1.0'?>"
          + " <script>"
          + " <pgm name='ZZCALL' lib='XMLSERVICE'>"
          + " <parm><data type='1A'>a</data></parm>"
          + " <parm><data type='1A'>b</data></parm>"
          + " <parm><data type='7p4'>11.1111</data></parm>"
          + " <parm><data type='12p2'>222.22</data></parm>"
          + " <parm>"
          + " <ds>"
          + " <data type='1A'>x</data>"
          + " <data type='1A'>y</data>"
          + " <data type='7p4'>66.6666</data>"
          + " <data type='12p2'>77777.77</data>"
          + " </ds>"
          + " </parm>"
          + " <return><data type='10i0'>0</data></return>"
          + " </pgm>"
          + " </script>"
          + "&xmlout=32768",
            "ISO-8859-1");
        // make REST call to XMLSERVICE
        URL restUrl = new URL(inputURL);
        URLConnection conn = restUrl.openConnection();
        // output processing
        System.out.println("Content type: " + conn.getContentType());
        System.out.println("Content length: " + conn.getContentLength());
        BufferedReader strm = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        String doc = "";
        while ((inputLine = strm.readLine()) != null) {
        doc = doc + inputLine;
        }
        System.out.println("****** Documento XML: **********");
        System.out.println(doc);
      }
      catch (Exception e)
      { System.out.println("******* Eccezione !!! *********");
        e.printStackTrace();
      }
    }
  }
  ``


RPG and XMLSERVICE
------------------

RPG is usually considered server side of XMLSERVICE, a called RPG PGM or SRVPGM (web service), but RPG is well versed in DB2, therefore can also be used as RPG client to XMLSERVICE. In fact, client RPG DB2 connection to XMLSERVICE will likely be fastest and easiest choice, especially for your remote IBM i systems (WRKRDBDIRE).

The RPG client examples will demonstrate RPG CGI using XMLSERVICE via Apache configuration, but the techniques also work as batch or green screen application, after using XMLSERVICE for a while, you may realize just how little code you have to write to do a great deal of work.

* Apache CGI configuration (httpd.conf) 

::

  ScriptAlias /cgi-bin/ /QSYS.LIB/XMLSERVICE.LIB/
  <Directory /QSYS.LIB/XMLSERVICE.LIB/>
    order allow,deny
    allow from all
    SetHandler cgi-script
    Options +ExecCGI
  </Directory>


* RPG client XMLSERVICE (\*PGM)

RPG program ZZRPGSQL.PGM demonstrates client use of XMLSERVICE calling a \*PGM (ZZCALL.pgm).

::

  XMLSERVICE/ZZCALL (*PGM)
      D  INCHARA        S              1a
      D  INCHARB        S              1a
      D  INDEC1         S              7p 4
      D  INDEC2         S             12p 2
      D  INDS1          DS
      D   DSCHARA                      1a
      D   DSCHARB                      1a
      D   DSDEC1                       7p 4
      D   DSDEC2                      12p 2
        *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * main(): Control flow
        *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      C     *Entry        PLIST
      C                   PARM                    INCHARA
      C                   PARM                    INCHARB
      C                   PARM                    INDEC1
      C                   PARM                    INDEC2
      C                   PARM                    INDS1


The simple example is of course a bit contrived, simply extracting strings between ``<data>output</data>`` returned XMLSERVICE output, but serves to demonstrate XMLSERVICE call using ``Exec Sql call XMLSERVICE/iPLUG4K(:myIPC,:myCtl,:myXmlIn,:myXmlOut);``.

ZZRPGSQL.PGM calling XMLSERVICE via ``Exec Sql call XMLSERVICE/iPLUG4K``

::

     H AlwNull(*UsrCtl)
     H BNDDIR('QC2LE')

      * vars
     D myIPC           s           1024A   inz(*BLANKS)
     D myCtl           s           1024A   inz(*BLANKS)
     D myXmlIn         s           4096A   inz(*BLANKS)
     D myXmlOut        s           4096A   inz(*BLANKS)

     D i               s             10i 0 inz(0)
     D rn              s             10i 0 inz(0)

     D data            s          65000A   inz(*BLANKS)
     D xml1            s          65000A   inz(*BLANKS)
     D xml2            s          65000A   inz(*BLANKS)
     D xml3            s          65000A   inz(*BLANKS)
     D xml4            s          65000A   inz(*BLANKS)

     D strstr          PR              *   ExtProc('strstr')
     D  pVal1                          *   Value options(*string)
     D  pVal2                          *   Value options(*string)

     D strlen          PR            10I 0 ExtProc('strlen')
     D  pVal                           *   Value options(*string)

     D writeIFS        PR            20I 0 ExtProc('write')
     D   fd                          10I 0 value
     D   buf                           *   value
     D   size                        10I 0 value

     D xmlfind         PR         65000A
     D  xml                            *   value
     D  nbr                          10i 0 value
     D  xbeg                         32A   value
     D  xbeg1                        32A   value
     D  xend                         32A   value

     D Main            PR                  ExtPgm('ZZRPGSQL')
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Main            PI
      /free
       Monitor;

       // -----
       // input

       myIPC = '*NA';
       myCtl = '*here';
       myXmlIn =
         '<?xml version="1.0" encoding="ISO-8859-1"?>'                + x'0D'
       + '<script>'                                                   + x'0D'
       + '<pgm name="ZZCALL" lib="XMLSERVICE">'                       + x'0D'
       + '<parm><data type="1a" var="INCHARA">Y</data></parm>'        + x'0D'
       + '<parm><data type="1a" var="INCHARB">Z</data></parm>'        + x'0D'
       + '<parm><data type="7p4" var="INDEC1">001.0001</data></parm>' + x'0D'
       + '<parm><data type="12p2" var="INDEC2">0003.04</data></parm>' + x'0D'
       + '<parm>'                                                     + x'0D'
       + ' <ds>'                                                      + x'0D'
       + '  <data type="1a" var="DSCHARA">A</data>'                   + x'0D'
       + '  <data type="1a" var="DSCHARB">B</data>'                   + x'0D'
       + '  <data type="7p4" var="DSDEC1">005.0007</data>'            + x'0D'
       + '  <data type="12p2" var="DSDEC2">0000000006.08</data>'      + x'0D'
       + ' </ds>'                                                     + x'0D'
       + '</parm>'                                                    + x'0D'
       + '</pgm>'                                                     + x'0D'
       + '</script>'                                                  + x'00';
       myXmlOut = *BLANKS;

       // -----
       // sql call XMLSERVICE provided stored procedure(iPLUG4k -iPLUG15M)
       Exec Sql call XMLSERVICE/iPLUG4K(:myIPC,:myCtl,:myXmlIn,:myXmlOut);

       // -----
       // output (CGI)

       // -----
       // send header + end (LFLF)
       data = 'Content-type: text/html' + x'15' + x'15' + x'00';
       rn = writeIFS(1:%addr(data):strlen(%addr(data)));
       // -----
       // send return data
       // HTML table
       data  = '<h3>RPG call XMLSERVICE</h3>'                 + x'0D';
       data  = %trim(data) + '<table border="1">'             + x'0D';
       data  = %trim(data) + '<th>Parameter name</th>'        + x'0D';
       data  = %trim(data) + '<th>Type value</th>'            + x'0D';
       data  = %trim(data) + '<th>Input value</th>'           + x'0D';
       data  = %trim(data) + '<th>Output value</th>'          + x'0D';
       for i = 1 to 8;
         xml1  = xmlfind(%addr(myXmlIn): i:'var=' :'"':'"');
         xml2  = xmlfind(%addr(myXmlIn): i:'type=':'"':'"');
         xml3  = xmlfind(%addr(myXmlIn): i:'<data':'>':'</data>');
         xml4  = xmlfind(%addr(myXmlOut):i:'<data':'>':'</data>');
         // HTML table row
         data  = %trim(data) + '<tr>'                         + x'0D';
         data  = %trim(data) + '<td>' + %trim(xml1) + '</td>' + x'0D';
         data  = %trim(data) + '<td>' + %trim(xml2) + '</td>' + x'0D';
         data  = %trim(data) + '<td>' + %trim(xml3) + '</td>' + x'0D';
         data  = %trim(data) + '<td>' + %trim(xml4) + '</td>' + x'0D';
         data  = %trim(data) + '</tr>'                        + x'0D';
       endfor;
       data  = %trim(data) + '</table>'                       + x'00';
       rn = writeIFS(1:%addr(data):strlen(%addr(data)));

       On-error;
       Endmon;

       return;
      /end-free

      *****************************************************
      * xmlfind
      *****************************************************
     P xmlfind         B
     D xmlfind         PI         65000A
     D  xml                            *   value
     D  nbr                          10i 0 value
     D  xbeg                         32A   value
     D  xbeg1                        32A   value
     D  xend                         32A   value
      * vars
     D i               s             10i 0 inz(0)
     D cbeg            s             33A   inz(*BLANKS)
     D cbeg1           s             33A   inz(*BLANKS)
     D cend            s             33A   inz(*BLANKS)
     D pbeg            s               *   inz(*NULL)
     D pend            s               *   inz(*NULL)
     D xmlFragment     s          65000A   inz(*BLANKS)
      /free
       cbeg = %trim(xbeg) + x'00';
       cbeg1 = %trim(xbeg1) + x'00';
       cend = %trim(xend) + x'00';
       pbeg = xml;
       for i = 1 to nbr;
         // <item stuff>123</item>
         // x
         if pbeg <> *NULL;
           pbeg = strstr(pbeg + 1:%addr(cbeg));
         endif;
       endfor;
       // <item stuff>123</item>
       //            x
       if pbeg <> *NULL;
         pbeg = strstr(pbeg:%addr(cbeg1));
       endif;
       if pbeg <> *NULL;
         // <item stuff>123</item>
         //             x  x
         pbeg += 1;
         pend = strstr(pbeg:%addr(cend));
         if pend <> *NULL and pend > pbeg;
           xmlFragment = %str(pbeg:pend - pbeg);
         endif;
       endif;
       return xmlFragment;
      /end-free
     P                 E


**What is happening?**

The flow of ZZRPGSQL.PGM is similar to HTML/XML, except we are using the XMLSERVICE provided stored procedure interface to call XMLSERVICE.

* We point our browser to ``http://lp0364d:10022/cgi-bin/zzrpgsql.pgm``, which is RPG CGI program ZZRPGSQL.PGM.
* ZZRPGSQL.PGM uses XMLSERVICE DB2 interface ``Exec Sql call XMLSERVICE/iPLUG4K(:myIPC,:myCtl,:myXmlIn,:myXmlOut);``, passing XML input request myXmlIn to XMLSERVICE.
* XMLSERVICE.PGM parses XML input and dynamically loads/activates/calls target ZZCALL.PGM with included parameters ``<parm>...</parm>``.
* ZZCALL.PGM runs using normal in/out parameters (memory)
* XMLSERVICE.PGM parses in/out parameters from ZZCALL.PGM into output XML document
* ZZRPGSQL.PGM myXmlOut variable contains XML output document
* ZZRPGSQL.PGM parses myXmlOut into a HTML table output (writeIFS)
* browser sees the HTML table of ZZCALL data

* RPG client XMLSERVICE (\*SRVPGM)

RPG program ZZVRYSQL.PGM demonstrates client use of XMLSERVICE calling a \*SRVPGM (ZZSRV.ZZVARY). As you read source code for ZZVRYSQL.PGM, you will see it is nearly identical to previous example ZZRPGSQL.PGM.

::

  XMLSERVICE/ZZSRV.ZZVARY (*SRVPGM)
      P zzvary          B                   export
      D zzvary          PI            20A   varying
      D  myName                       10A   varying

XMLSERVICE called ZZSRV.ZZARRY SRVPGM demonstrates advance functions problematic for PCML based web services.

* difficult -- parameter ``10A varying`` - PCML requires multiple XML definitions for length, data
* impossible -- return ``20A varying`` - PCML has no ability to return complex data (only single integer)


ZZVRYSQL.PGM calling XMLSERVICE via ``Exec Sql call XMLSERVICE/iPLUG4K``

::

      H AlwNull(*UsrCtl)
      H BNDDIR('QC2LE')

        * vars
      D myIPC           s           1024A   inz(*BLANKS)
      D myCtl           s           1024A   inz(*BLANKS)
      D myXmlIn         s           4096A   inz(*BLANKS)
      D myXmlOut        s           4096A   inz(*BLANKS)

      D i               s             10i 0 inz(0)
      D rn              s             10i 0 inz(0)

      D data            s          65000A   inz(*BLANKS)
      D xml1            s          65000A   inz(*BLANKS)
      D xml2            s          65000A   inz(*BLANKS)
      D xml3            s          65000A   inz(*BLANKS)
      D xml4            s          65000A   inz(*BLANKS)

      D strstr          PR              *   ExtProc('strstr')
      D  pVal1                          *   Value options(*string)
      D  pVal2                          *   Value options(*string)

      D strlen          PR            10I 0 ExtProc('strlen')
      D  pVal                           *   Value options(*string)

      D writeIFS        PR            20I 0 ExtProc('write')
      D   fd                          10I 0 value
      D   buf                           *   value
      D   size                        10I 0 value

      D xmlfind         PR         65000A
      D  xml                            *   value
      D  nbr                          10i 0 value
      D  xbeg                         32A   value
      D  xbeg1                        32A   value
      D  xend                         32A   value

      D Main            PR                  ExtPgm('ZZVRYSQL')
        *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        * main(): Control flow
        *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      D Main            PI
        /free
        Monitor;

        // -----
        // input
        //     P zzvary          B                   export
        //     D zzvary          PI            20A   varying
        //     D  myName                       10A   varying
        myIPC = '*NA';
        myCtl = '*here';
        myXmlIn =
          '<?xml version="1.0" encoding="ISO-8859-1"?>'                + x'0D'
        + '<script>'                                                   + x'0D'
        + '<pgm name="ZZSRV" lib="XMLSERVICE" func="ZZVARY">'          + x'0D'
        + '<parm>'                                                     + x'0D'
        + '<data type="10a" var="myName" varying="on">Ranger</data>'   + x'0D'
        + '</parm>'                                                    + x'0D'
        + '<return>'                                                   + x'0D'
        + '<data var="retName" type="20A" varying="on">Mud</data>'     + x'0D'
        + '</return>'                                                  + x'0D'
        + '</pgm>'                                                     + x'0D'
        + '</script>'                                                  + x'00';
        myXmlOut = *BLANKS;

        // -----
        // sql call XMLSERVICE provided stored procedure(iPLUG4k -iPLUG15M)
        Exec Sql call XMLSERVICE/iPLUG4K(:myIPC,:myCtl,:myXmlIn,:myXmlOut);

        // -----
        // output (CGI)

        // -----
        // send header + end (LFLF)
        data = 'Content-type: text/html' + x'15' + x'15' + x'00';
        rn = writeIFS(1:%addr(data):strlen(%addr(data)));
        // -----
        // send return data
        // HTML table
        data  = '<h3>RPG call XMLSERVICE</h3>'                 + x'0D';
        data  = %trim(data) + '<table border="1">'             + x'0D';
        data  = %trim(data) + '<th>Parameter name</th>'        + x'0D';
        data  = %trim(data) + '<th>Type value</th>'            + x'0D';
        data  = %trim(data) + '<th>Input value</th>'           + x'0D';
        data  = %trim(data) + '<th>Output value</th>'          + x'0D';
        for i = 1 to 2;
          xml1  = xmlfind(%addr(myXmlIn): i:'var=' :'"':'"');
          xml2  = xmlfind(%addr(myXmlIn): i:'type=':'"':'"');
          xml3  = xmlfind(%addr(myXmlIn): i:'<data':'>':'</data>');
          xml4  = xmlfind(%addr(myXmlOut):i:'<data':'>':'</data>');
          // HTML table row
          data  = %trim(data) + '<tr>'                         + x'0D';
          data  = %trim(data) + '<td>' + %trim(xml1) + '</td>' + x'0D';
          data  = %trim(data) + '<td>' + %trim(xml2) + '</td>' + x'0D';
          data  = %trim(data) + '<td>' + %trim(xml3) + '</td>' + x'0D';
          data  = %trim(data) + '<td>' + %trim(xml4) + '</td>' + x'0D';
          data  = %trim(data) + '</tr>'                        + x'0D';
        endfor;
        data  = %trim(data) + '</table>'                       + x'00';
        rn = writeIFS(1:%addr(data):strlen(%addr(data)));

        On-error;
        Endmon;

        return;
        /end-free

        *****************************************************
        * xmlfind
        *****************************************************
      P xmlfind         B
      D xmlfind         PI         65000A
      D  xml                            *   value
      D  nbr                          10i 0 value
      D  xbeg                         32A   value
      D  xbeg1                        32A   value
      D  xend                         32A   value
        * vars
      D i               s             10i 0 inz(0)
      D cbeg            s             33A   inz(*BLANKS)
      D cbeg1           s             33A   inz(*BLANKS)
      D cend            s             33A   inz(*BLANKS)
      D pbeg            s               *   inz(*NULL)
      D pend            s               *   inz(*NULL)
      D xmlFragment     s          65000A   inz(*BLANKS)
        /free
        cbeg = %trim(xbeg) + x'00';
        cbeg1 = %trim(xbeg1) + x'00';
        cend = %trim(xend) + x'00';
        pbeg = xml;
        for i = 1 to nbr;
          // <item stuff>123</item>
          // x
          if pbeg <> *NULL;
            pbeg = strstr(pbeg + 1:%addr(cbeg));
          endif;
        endfor;
        // <item stuff>123</item>
        //            x
        if pbeg <> *NULL;
          pbeg = strstr(pbeg:%addr(cbeg1));
        endif;
        if pbeg <> *NULL;
          // <item stuff>123</item>
          //             x  x
          pbeg += 1;
          pend = strstr(pbeg:%addr(cend));
          if pend <> *NULL and pend > pbeg;
            xmlFragment = %str(pbeg:pend - pbeg);
          endif;
        endif;
        return xmlFragment;
        /end-free
      P                 E


RPG client XMLSERVICE (DataQueue)
---------------------------------

RPG program ZZQUESQL.PGM demonstrates client use of XMLSERVICE calling a CMDs and System APIs for Data Queue. As you read source code for ZZQUESQL.PGM, you will see it is nearly identical to previous example ZZRPGSQL.PGM.

::

  DLTDTAQ DTAQ(XMLSERVICE/MYDATAQ)
  CRTDTAQ DTAQ(XMLSERVICE/MYDATAQ) MAXLEN(100)
  ***************************************
  * Send Data Queue (QSNDDTAQ) API
  ***************************************
  * 1 Data queue name     Input Char(10)
  * 2 Library name        Input Char(10)
  * 3 Length of data      Input Packed(5,0)
  * 4 Data Input Char(*)  Input
  ***************************************
  * Receive Data Queue (QRCVDTAQ) API
  ***************************************
  * 1 Data queue name  Input Char(10)
  * 2 Library name     Input Char(10)
  * 3 Length of data   Input Packed(5,0)
  * 4 Data Char(*)     Output
  * 5 Wait time        Input Packed(5,0)


ZZQUESQL.PGM calling XMLSERVICE via ``Exec Sql call XMLSERVICE/iPLUG4K`` 

::

     H AlwNull(*UsrCtl)
     H BNDDIR('QC2LE')

      * vars
     D myIPC           s           1024A   inz(*BLANKS)
     D myCtl           s           1024A   inz(*BLANKS)
     D myXmlIn         s           4096A   inz(*BLANKS)
     D myXmlOut        s           4096A   inz(*BLANKS)

     D i               s             10i 0 inz(0)
     D rn              s             10i 0 inz(0)

     D data            s          65000A   inz(*BLANKS)
     D xml1            s          65000A   inz(*BLANKS)
     D xml2            s          65000A   inz(*BLANKS)
     D xml3            s          65000A   inz(*BLANKS)
     D xml4            s          65000A   inz(*BLANKS)

     D strstr          PR              *   ExtProc('strstr')
     D  pVal1                          *   Value options(*string)
     D  pVal2                          *   Value options(*string)

     D strlen          PR            10I 0 ExtProc('strlen')
     D  pVal                           *   Value options(*string)

     D writeIFS        PR            20I 0 ExtProc('write')
     D   fd                          10I 0 value
     D   buf                           *   value
     D   size                        10I 0 value

     D xmlfind         PR         65000A
     D  xml                            *   value
     D  nbr                          10i 0 value
     D  xbeg                         32A   value
     D  xbeg1                        32A   value
     D  xend                         32A   value

     D Main            PR                  ExtPgm('ZZVRYSQL')
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Main            PI
      /free
       Monitor;

       // -----
       // input
       // ***************************************
       // * Send Data Queue (QSNDDTAQ) API
       // ***************************************
       // * 1 Data queue name     Input Char(10)
       // * 2 Library name        Input Char(10)
       // * 3 Length of data      Input Packed(5,0)
       // * 4 Data Input Char(*)  Input
       // ***************************************
       // * Receive Data Queue (QRCVDTAQ) API
       // ***************************************
       // * 1 Data queue name  Input Char(10)
       // * 2 Library name     Input Char(10)
       // * 3 Length of data   Input Packed(5,0)
       // * 4 Data Char(*)     Output
       // * 5 Wait time        Input Packed(5,0)
       myIPC = '*NA';
       myCtl = '*here';
       myXmlIn =
         '<?xml version="1.0" encoding="ISO-8859-1"?>'                + x'0D'
       + '<script>'                                                   + x'0D'
       + '<cmd error="fast">DLTDTAQ DTAQ(XMLSERVICE/MYDATAQ)</cmd>'   + x'0D'
       + '<cmd error="fast">CRTDTAQ DTAQ(XMLSERVICE/MYDATAQ) MAXLEN(100)</cmd>'
       + x'0D'
       + '<pgm name="QSNDDTAQ">'                                      + x'0D'
       + ' <parm>'                                                    + x'0D'
       + '   <data type="10A" var="sndque">MYDATAQ</data>'            + x'0D'
       + ' </parm>'                                                   + x'0D'
       + ' <parm>'                                                    + x'0D'
       + '   <data type="10A" var="sndlib">XMLSERVICE</data>'         + x'0D'
       + ' </parm>'                                                   + x'0D'
       + ' <parm>'                                                    + x'0D'
       + '   <data type="5p0" var="sndlen">50</data>'                 + x'0D'
       + ' </parm>'                                                   + x'0D'
       + ' <parm>'                                                    + x'0D'
       + '   <data type="100A" var="snddata">i data queues</data>'    + x'0D'
       + ' </parm>'                                                   + x'0D'
       + '</pgm>'                                                     + x'0D'
       + '<pgm name="QRCVDTAQ">'                                      + x'0D'
       + ' <parm>'                                                    + x'0D'
       + '   <data type="10A" var="rcvque">MYDATAQ</data>'            + x'0D'
       + ' </parm>'                                                   + x'0D'
       + ' <parm>'                                                    + x'0D'
       + '   <data type="10A" var="rcvlib">XMLSERVICE</data>'         + x'0D'
       + ' </parm>'                                                   + x'0D'
       + ' <parm>'                                                    + x'0D'
       + '   <data type="5p0" var="rcvlen">50</data>'                 + x'0D'
       + ' </parm>'                                                   + x'0D'
       + ' <parm>'                                                    + x'0D'
       + '   <data type="100A" var="rcvdata">bad stuff</data>'        + x'0D'
       + ' </parm>'                                                   + x'0D'
       + ' <parm>'                                                    + x'0D'
       + '   <data type="5p0" var="rcvwait">0</data>'                 + x'0D'
       + ' </parm>'                                                   + x'0D'
       + '</pgm>'                                                     + x'0D'
       + '<cmd error="fast">DLTDTAQ DTAQ(XMLSERVICE/MYDATAQ)</cmd>'   + x'0D'
       + '</script>'                                                  + x'00';
       myXmlOut = *BLANKS;

       // -----
       // sql call XMLSERVICE provided stored procedure(iPLUG4k -iPLUG15M)
       Exec Sql call XMLSERVICE/iPLUG32K(:myIPC,:myCtl,:myXmlIn,:myXmlOut);

       // -----
       // output (CGI)

       // -----
       // send header + end (LFLF)
       data = 'Content-type: text/html' + x'15' + x'15' + x'00';
       rn = writeIFS(1:%addr(data):strlen(%addr(data)));
       // -----
       // send return data
       // HTML table
       data  = '<h3>RPG call XMLSERVICE</h3>'                 + x'0D';
       data  = %trim(data) + '<table border="1">'             + x'0D';
       data  = %trim(data) + '<th>Parameter name</th>'        + x'0D';
       data  = %trim(data) + '<th>Type value</th>'            + x'0D';
       data  = %trim(data) + '<th>Input value</th>'           + x'0D';
       data  = %trim(data) + '<th>Output value</th>'          + x'0D';
       for i = 1 to 9;
         xml1  = xmlfind(%addr(myXmlIn): i:'var=' :'"':'"');
         xml2  = xmlfind(%addr(myXmlIn): i:'type=':'"':'"');
         xml3  = xmlfind(%addr(myXmlIn): i:'<data':'>':'</data>');
         xml4  = xmlfind(%addr(myXmlOut):i:'<data':'>':'</data>');
         // HTML table row
         data  = %trim(data) + '<tr>'                         + x'0D';
         data  = %trim(data) + '<td>' + %trim(xml1) + '</td>' + x'0D';
         data  = %trim(data) + '<td>' + %trim(xml2) + '</td>' + x'0D';
         data  = %trim(data) + '<td>' + %trim(xml3) + '</td>' + x'0D';
         data  = %trim(data) + '<td>' + %trim(xml4) + '</td>' + x'0D';
         data  = %trim(data) + '</tr>'                        + x'0D';
       endfor;
       data  = %trim(data) + '</table>'                       + x'00';
       rn = writeIFS(1:%addr(data):strlen(%addr(data)));

       On-error;
       Endmon;

       return;
      /end-free

      *****************************************************
      * xmlfind
      *****************************************************
     P xmlfind         B
     D xmlfind         PI         65000A
     D  xml                            *   value
     D  nbr                          10i 0 value
     D  xbeg                         32A   value
     D  xbeg1                        32A   value
     D  xend                         32A   value
      * vars
     D i               s             10i 0 inz(0)
     D cbeg            s             33A   inz(*BLANKS)
     D cbeg1           s             33A   inz(*BLANKS)
     D cend            s             33A   inz(*BLANKS)
     D pbeg            s               *   inz(*NULL)
     D pend            s               *   inz(*NULL)
     D xmlFragment     s          65000A   inz(*BLANKS)
      /free
       cbeg = %trim(xbeg) + x'00';
       cbeg1 = %trim(xbeg1) + x'00';
       cend = %trim(xend) + x'00';
       pbeg = xml;
       for i = 1 to nbr;
         // <item stuff>123</item>
         // x
         if pbeg <> *NULL;
           pbeg = strstr(pbeg + 1:%addr(cbeg));
         endif;
       endfor;
       // <item stuff>123</item>
       //            x
       if pbeg <> *NULL;
         pbeg = strstr(pbeg:%addr(cbeg1));
       endif;
       if pbeg <> *NULL;
         // <item stuff>123</item>
         //             x  x
         pbeg += 1;
         pend = strstr(pbeg:%addr(cend));
         if pend <> *NULL and pend > pbeg;
           xmlFragment = %str(pbeg:pend - pbeg);
         endif;
       endif;
       return xmlFragment;
      /end-free
     P                 E




