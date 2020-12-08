
XMLSERVICE Layouts
==================

`Goto Main Page`_

.. _Goto Main Page: index.html

This page is for RPG developers that want to customize XMLSERVICE.


XMLSERVICE source files
-----------------------

::

        -----------------------------------------
        |              Browser                  |
        |---------------------------------------|
   (1)->| Download RPG (1) | Download PHP (2)   |
        | 1) XMLSERVICE    | a) PHP CW Toolkit  |
        |    HTML/XML/REST | b) New PHP Toolkit |
        |    no PHP        |--------------------|
        |    (xmlcgi.pgm)  | c) PHP “Raw XML”   |
        |    (optional)    |   (ibm_db2, odbc)  |
        |    -----------------------------------|
        | 2) XMLSERVICE DB2 stored procedures   |<-(1)
        |    (iPLUG4K, iPLUG32K, ..., iPLUG15M) |
        | 3) XMLSERVICE (xmlservice.pgm)        |<-(1) xmlservice-rpg-x.x.x.zip
        |    call most anything on IBM i ...    |
        |    (PGM, SRVPGM, PASE, DB2, etc.)     |
        -----------------------------------------
  
The following is a brief description of the function of the source files included with the XMLSERVICE library Open Source project.
::

  LIB:
  XMLSERVICE

  QSQLSRC:
  crtsql - db2 utility script to create stored procedures

  QRPGLESRC:
  plugconf_h - compile configuration options
  plugmri_h - translateable messages
  plugcach_h - interface for all cahces
  plugcach - implementation for all caches
  plugbug_h - interface debug (*debug)
  plugbug - implement debug message qsysopr
  plugerr_h - interface errors
  plugerr - implement error collection and report
  plugile_h - ILE ABI interface
  plugile - implement ILE ABI paramter memory layout
  plugipc_h -interface IPC (*nostart)
  plugipc - implement IPC shared memory and semaphore
  pluglic_h - interface license (*license)
  pluglic - implement license report
  plugpase_h - interface PASE functions
  plugpase - implement PASE PGM, SRVPGM, sh
  plugperf_h - interface performance (*rpt)
  plugperf - implement performance collection and report
  plugrun_h - interface run loop (*here *immed *justproc *sbmjob)
  plugrun - implement client/server run loop (RPG cycle)
  plugxml_h - interface XML
  plugxml - implement XML parse and run logic
  plugsql_h - interface sql by XML
  plugsql - implement sql by XML (1.5)
  plugdb2_h - interface sql db2 by XML
  plugdb2 - implement sql db2 by XML
  plugsig_h.rpgle - interface timeout signal (1.6.6)
  plugsig.rpgle - implement timeout signal
  plugconv_h.rpgle - interface ccsid conversion (1.6.6)
  plugconv.rpgle - implement ccsid conversion
  xmlcgi - PGM client interface Apache CGI (HTTP REST)
  xmlmain - PGM client interface RPG-2-RPG (experimental)
  xmlservice - PGM server deamons (XMLSERVICE jobs)
  xmlstoredp - SRVPGM client DB2 stored procedures (DB2 connections)
  zzcall - optional PGM for pear tests
  zzsrv - optional SRVPGM for pear tests


XMLSERVICE hooks plugconf
-------------------------

XMLSERVICE allows for you to customize a few key security and output decisions in the RPG module plugconf or 
provide your own plugconf(x) version. 

**XMLSERVICE hooks APIs plugconf_h**

The hooks are ONLY available with XMLSERVICE version 1.5.5+.

plugconf module must implement the following interfaces prototyped by plugconf_h ... 
failure to implement these APIs will result in compile failure.

There are key hooks in plugrun / xmlcgi that allow your to decline service after you snoop the input XML. 
Likewise, there are key hooks that allow you to manipulate the XML output returned to the clients 
if you wish to "customize" XML (cool), however it should be noted that if you change the output XML 
you may break other clients (like Zend PHP wrapper).


Running with \*NONE from XMLCGI
-------------------------------
XMLSERVICE via XMLCGI may be too powerful using only HTML/XML with no user/password (\*NONE), 
so it is turned OFF by default always. However, if your machine is behind a firewall and you trust your team you can enable \*NONE ...

#. make your own plugconf(x)
#. ``D PLUGNONEOK      S              1N   inz(*ON)``
#. recompile and your machine will be wide open ...

Note: The other setting PLUGDEMOOK is not used is future consideration for demos not from XMLCGI.


XMLSERVICE XMLCGI (RPG CGI)
---------------------------
A sample XMLCGI interface was included to allow REST calls to XMLSERVICE. This was very handy to check out XML to/from XMLSERVICE before ever committing pen to paper on an actual script like PHP. It also seems to very handy fro one off HTML/XML applications that can reside on your laptop (or other device) and use the built in browser to run IBM i.


**BIG DESIGN HINT:**

Although common practice in IBM i circles, I choose not to use Basic Authentication and/or "switch profile" in RPG CGI programs on the web (httpd.conf ServerId). I much prefer to leave all Apache/CGI related jobs as neutral "low authority" like QTMHHTTP (IBM i) or NOBODY (Linux) for clearly understood security. Also, I prefer keeping any security "switch profile" activity in the database connection (DB2) for portability of design and multiple client support (1-tier/2-tier). An example of this "database security" style of CGI is Apache module XMLCGI included in XMLSERVICE download (main page). XMLCGI implements all "security" preferences and "switch profile" using the DB2 CLI interface in RPG.

Briefly, reasons i like keep the "profile security" in the database ...
* portable design idea in tradition of millions of PHP/MySql web sites (idea of profile is in database)
* easy switch/sharing between 1-tier and 2-tier applications across common database design (DB2)
* no "protocol" invention required because most languages support database (including PHP, Java, RPG, Cobol, etc.)
* supporting/sharing applications a wide range of device clients such as PDAs, laptops, servers is much easier as most can handle REST and/or DB2 communications (whatever language is available)

**Do it yourself RPG:**

* **If you are a do it yourself RPG programmer, you may want to download and study XMLCGI RPG source file included as this would allow you to write any RPG front-end (just steal the DB2 CLI stuff in XMLCGI if you want a server with profiles).**
  
  * RPG program XMLCGI is a traditional "Apache/Unix" style CGI server (ala PHP/MySql), therefore you do not need "switch profile" in the XMLCGI job. All/any "switch profile" is occurring at the DB2 database layer via DB2 CLI server mode not the Apache level (without using profiles in httpd.conf)
  * WARNING: Unless https, XMLCGI sends unencrypted password around web and/or leaves them in files (unless using \*NONE), which is a bad idea of course, but this is a demonstration module for testing (without PHP, etc.), you as the RPG programmer are intended to customize to your production world (Open Source RPG code).


XMLSERVICE XMLMAIN (unused)
---------------------------

Also included, is a simple RPG program XMLMAIN that calls client interface XMLSERVICE in processes inside or outside web context, 
has not been extensively tested (very little in fact), but should be general idea for a IBM i RPG centric interface 
(if such a thing is even relevant these Internet days).

*If you wish to build a traditional web IBM i "switch profile" CGI web service (httpd.conf ServerId), 
you would need to combine parts of XMLMAIN (direct call XMLSERVICE) and XMLCGI (excluding DB2 CLI).*



