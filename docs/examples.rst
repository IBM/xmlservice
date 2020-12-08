

XMLSERVICE Examples
===================
`Goto Main Page`_

.. _Goto Main Page: index.html

The following foils include running examples you can click to help get started as you learn about this Open Source.

* :ref:`part-1`
* :ref:`part-2`

Goal of Open Source XMLSERVICE RPG library is flexibility, enabling ANY sort of transport local/remote connection with any language available in your enterprise to call resources on your IBM i machine. XMLSERVICE primary transport interface in production today is DB2 connections using included stored procedures (xmlstoredp.srvpgm iPLUGxxxx). XMLSERVICE secondary transport interface used mostly demos is Apache REST connection (xmlcgi.pgm). However, XMLSERVICE allows writing your own custom transport (anything you imagine). XML Service and Toolkit on-going mission is to add new function, improve performance, expand uses, with goal of never impacting existing customers.


**Warning**: This is an active IBM i education machine, occasionally examples may not work, try back later.

.. _part-1:

Part 1 - Protect your investment
--------------------------------

* XML Service Access Native IBM i Objects from any language using XML
* XML Service completely free/safe commercial use download (Github)
* XML Service examples HTML/XML (no PHP, no RPG)
* XML Service examples RPG (no PHP)
* XML Service vs. DB2 Stored Procedures - Why use XML Service at all?
* XML Service protect your investment summary


XML Service - is free
^^^^^^^^^^^^^^^^^^^^^

* XML Service is completely free/safe commercial use 
  
  * BSD license, download, keep any source copy forever (safe)

* XML Service written in RPG open source (you can change it)
  
  * Techniques used IBM i calls are stable, unlikely to change (ever)

* XML Service is supported Open Source
  
  * XML Service fix/add improvement goal is never impact current customers


XML Service - XML everything
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* XML input <> XML output

  * Any device
  * Any language
  * Any local/remote connection
  * Any IBM i service (PGM, CMD, System API, DB2, PASE)



XML Service - IBM i Native Access through XML
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Access Native IBM i Objects from any language using XML
 
  * Local or remote IBM i: IBM i local, IBM i-2-IBM i, Linux/Unix/Windows-2-IBM, etc.
  * Any language access: PHP, Ruby, Java, Perl, RPG, no language at all (HTML/XML)
  * Many Native Object Types: DB2 SQL and Native, Program call, Procedure call, Data Area, Data Queue, Message Queue, Commands, System values, Spool files, PASE utilities

* Local or remote call interfaces to XMLSERVICE (included RPG download)
 
  * Primary: call DB2 stored procedures local or remote (iPLUG4K - iPLUG15M)
  * Secondary: call REST HTTP local or remote (xmlcgi.pgm)


XML Service - Moving Parts
^^^^^^^^^^^^^^^^^^^^^^^^^^

* Any language
  
  * Browser HTML/XML
  * Script PHP, Ruby, JavaScript, etc.
  * Compiled RPG, C, etc.

* Any local/remote connection
  
  * Linux/Unix/Windows/Mac ibm_db2/odbc/REST to IBM i
  * Native IBM i ibm_db2/odbc/REST to IBM i


XML Service public "stateless" (\*here)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* XMLSERVICE public "stateless" (CTL='\*here', IPC='\*NA')
  
  * profile FRED (any public QSQ)
  * profile SALLY (any public QSQ)
  * profile RITA (any public QSQ)
  * profile XAVIER (any public QSQ)

* XMLSTOREDP->XMLSERVICE (QSQ)
  
  * QSQ temporary profile use (stateless)
  * QSQ return to pool on script end
  * XMLSERVICE restart every request (web style)


XML Service private "state full" (\*sbmjob)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* XMLSERVICE private "state full" (CTL='\*sbmjob', IPC='/tmp/xxxx')

  * profile FRED XTOOLKIT myjob1,myjob2 (private)
  * profile SALLY XTOOLKIT sallyjob1 (private)
  * profile RITA XTOOLKIT nursejob (private)
  * profile XAVIER XTOOLKIT xjob1,xjob2,xjob3,xjob4,xjob5 (private)

* XMLSTOREDP (QSQ)
  
  * QSQ temporary profile use (stateless)
  * QSQ return to pool on script end

* XMLSERVICE (XTOOLKIT)
  
  * XTOOLKIT owned by profile (private)
  * XTOOLKIT job never ends (until killed)
  * XTOOLKIT full state programming (5250 style)



XML Service Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^

* Apache REST (xmlcgi.pgm)
* DB2 stored procedures (xmlstoredp.srvpgm iPLUGxx)


XML Service - Example HTML/XML (no PHP, no RPG)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* XML Service HTTP browser direct (xmlcgi.pgm)
  
  * web enable via httpd.conf

  ::

    <form method='POST' action='/cgi-bin/xmlcgi.pgm'>
    ScriptAlias /cgi-bin/ /QSYS.LIB/XMLSERVICE.LIB/
    <Directory /QSYS.LIB/XMLSERVICE.LIB/>
      order allow,deny
      allow from all
      SetHandler cgi-script
      Options +ExecCGI
    </Directory>


XML Service - Example RPG (no PHP)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* XML Service stored procedure interface
  
  (1) RPG DB2 using Exec Sql (iPLUGxxx)
  (2) RPG DB2 using CLI (iPLUGxxx)

* web enable via httpd.conf

::

  # demo callpase
  ScriptAlias /demo/ /QSYS.LIB/CALLPASE.LIB/
  <Directory /QSYS.LIB/CALLPASE.LIB/>
    order allow,deny
    allow from all
    SetHandler cgi-script
    Options +ExecCGI
  </Directory>
  
Note: Exec Sql RPG CGI uses profile QTMHHTP1, however PHP is usually running QTMHHTTP, so you may fail authorisation sharing same XMLSERVICE job (1). Therefore, i recommend use RPG CLI technique to run any profile, where XMLSERVICE job(s) PHP/RPG is no problem (2).



XML Service vs. DB2 Stored Procedures - Why use XML Service at all?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Why not write my own stored procedures? Why use XML Service at all?

+------------------------------------------+-------------------------------------------+
|  XML Service                             |  Stored procedure                         |
+==========================================+===========================================+
|                        Device, protocol, & language portability                      |
+------------------------------------------+-------------------------------------------+
|browser, REST, DB2, RPG...                |device/driver/language specific            |
+------------------------------------------+-------------------------------------------+
|                               Complex Data Structures                                |
+------------------------------------------+-------------------------------------------+
|trivial                                   |near impossible                            |
+------------------------------------------+-------------------------------------------+
|                               Call CMDs and collect data                             |
+------------------------------------------+-------------------------------------------+
|trivial                                   |very difficult                             |
+------------------------------------------+-------------------------------------------+
|                           Call PASE utilities and collect data                       |
+------------------------------------------+-------------------------------------------+
|trivial                                   |very difficult                             |
+------------------------------------------+-------------------------------------------+
|                           Route same job (IPC/internalKey)                           |
+------------------------------------------+-------------------------------------------+
|trivial                                   | near impossible                           |
+------------------------------------------+-------------------------------------------+
|                           30,000 records around 2 seconds                            |
+------------------------------------------+-------------------------------------------+
|fast                                      |faster                                     |
+------------------------------------------+-------------------------------------------+


Protect your investment
^^^^^^^^^^^^^^^^^^^^^^^

* XML Service protects your wallet 100% free download
* XML Service protects your skills 100% RPG source code
* XML Service protects your project costs with XML based low budget features
* XML Service protects your investment applications functions/performance over time
* XML Service protects your investment across device proliferation
* XML Service protects your investment across script language proliferation
* XML Service protects your investment across any transport driver (XML is a string)


.. _part-2:

Part 2 - Production use today
-----------------------------

**Topics**

* PHP Toolkit included with Zend Server for IBM i
* XML Interface ibm_db2, pdo_ibm, odbc included with Zend Server for IBM i
* XML Interface and PHP Toolkit - Performance
* XML Interface and PHP Toolkit - Debugging
* XML Interface and PHP Toolkit - Active community/support


New PHP Toolkit included with Zend Server for IBM i
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


* Zend Server PHP Toolkit (included)
  
  * PHP CW Layer - old toolkit
  * PHP New Toolkit - OO toolkit


XML Interface ibm_db2, pdo_ibm, odbc included with Zend Server for IBM i
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* XML Service stored procedure interface (included)
  
  * DB2 ibm_db2 param in/out (iPLUG 4k-15m)
  * DB2 odbc result set (iPLUGR 4k-15m)

..
  XML Service - Performance Speed Limits
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  +--------------------------------------------------------------------------------------+
  |  **Avg IBM i machine speed limits today (Oct 2012)**                                 |
  +--------------------------------------------------------------------------------------+
  |* Avg Apache serves HTML 800/hits second (non-FRCA)                                   |
  |* Avg persistent DB2 driver serves 400/hits second (db2_pconnect)                     |
  |* Avg non-persistent DB2 driver serves 40/hits second (db2_connect)                   |
  +--------------------------------------------------------------------------------------+
  |  **PHP direct XMLSERVICE**                                                           |
  +--------------------------------------------------------------------------------------+
  |* Avg PHP direct 200-400 calls/sec                                                    |
  |* 30,000 records around 2 seconds                                                     |
  +--------------------------------------------------------------------------------------+

XML Interface and PHP Toolkit - Active community/support
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You are not alone, seek out help ...

* `Zend Server IBM i forums`_

.. _Zend Server IBM i forums: http://forums.zend.com/viewforum.php?f=67

* `PHP Toolkit forum`_

.. _PHP Toolkit forum: http://forums.zend.com/viewforum.php?f=113

* `Zend Manuals`_

.. _Zend Manuals: http://files.zend.com/help/Zend-Server-IBMi/zend-server.htm#php_toolkit_xml_service_functions.htm


Debug technique: It's as easy as 1-2-3-4-5-6-7-8-9 :)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Run the test script that contains control "\*debug" and script will "hang" while it waits on #2

  ::

    $ctl .= "*debug";

2. A MSGW inquiry message in DSPMSG QSYSOPR will be generated by the toolkit. Note the job information (number, name, user) provided in the MSGW.

#. STRSRVJOB using that job information as parameters.

#. STRDBG with the program and library you wish to debug.

#. Answer the MSGW. Any answer will do--"G" is fine.

#. The RPG program source will appear in debug mode in your terminal, ready to step through, allowing you to inspect variables, etc.

#. When done inspecting and stepping, let the RPG program complete (using function keys indicated on screen).

#. ENDDBG

#. ENDSRVJOB

Other debug options ...
::

            Job1 (threaded)   Job 2                        Job 3 (DB2 userid/password)    Job 4 (optional XTOOLKIT job)
                              (ctl=*debugcgi)              (ctl=*debugproc)                (ctl=*debug)
  browser -> Apache          ->XMLCGI (Apache CGI child) -> QSQSRVR (XMLSERVICE *here)
                                                        -> QSQSRVR (XMLSERVICE client) -> XTOOLKIT (XMLSERVICE ipc=/tmp/flinstone)

  $ctl .= " *debugcgi";  // Job 2 - debug XMLCGI to see REST/HTTP data passed by client (when using REST only)
  $ctl .= " *debugproc"; // Job 3 - debug XMLSERVICE "client" to see DB2 passed data (DB2 interface)
  $ctl .= " *debug";     // Job 4 - debug XMLSERVICE "server" to see XMLSERVICE calls (DB2 interface)
                        // Note:   when ctl='*here', both XMLSERVICE "client"/"server"
                        //         are in QSQSRVSR job (NO XTOOLKIT job)
                        // remote: Attaching with LUW drivers changes QSQSRVR ...
                        //   CLIENT (Client Access drivers) <==> QZDAxxxx
                        //   CLIENT (DB2 Connect drivers)   <==> QRWxxxx




..
  [--Author([[http://youngiprofessionals.com/wiki/index.php/XMLSERVICE/XMLSERVICEIntro?action=expirediff | s ]])--]
  [--Tony "Ranger" Cairns - IBM i PHP / PASE--]
