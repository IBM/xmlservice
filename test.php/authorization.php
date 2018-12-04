<?php
// **** authorization ***
$database   = '*LOCAL';     // i5 only side 
// $database   = 'LP0364D';    // i5 or LINUX side
$user       = 'DB2';        // tests profile
$password   = 'PWD';
$adoptuser1 = 'TKITU1';     // swap profile tests
$adoptpass1 = 'PWD';
$adoptuser2 = $user;
$adoptpass2 = $password;
// *** DB2 interface (iPLUGxxx, iPLUGRxxx) ***
$i5persistentconnect = false;   // persistent db2 connection
$procDrive  = 'ibm_db2';        // choose get, post, odbc, ibm_db2, pdo_ibm
$procConn   = false;            // QXMLSERV - IBM production library
$procOPM    = false;            // run V5R4 OPM mode
$procLib = 'XMLSERVICE';     // XMLSERVICE - new release testing library
// $procLib = 'ZENDSVR';        // ZENDSVR - Zend Server production library
// $procLib    = 'QXMLSERV';       // QXMLSERV - IBM production library
$procPlug   = "iPLUG5M";        // iPLUGxxx various sizes
$procPlugR  = "iPLUGR5M";       // iPLUGRxxx various sizes (result set)
// REST interface (xmlcgi.pgm) ***
$i5resturl  = "http://ut28p63/cgi-bin/xmlcgi.pgm";
$i5restdb   = "*LOCAL";         // only *LOCAL tested
if ($user == '') {
  $i5restuser = '*NONE';        // *NONE not allowed by default compile
  $i5restpass = '*NONE';        // *NONE not allowed by default compile
}
else {
  $i5restuser = $user;
  $i5restpass = $password;
}
$i5restsz   = "512000";         // size expected XML output
// *** default parameters xmlservice ***
$ctlhere    = "*here";          // stateless run (xmlservice in-process)
$ctllog     = "*sbmjob *log";   // state full run logging (xmlservice seperate process)
$ctl        = "*sbmjob";        // state full run (xmlservice seperate process)
$ipc        = "/tmp/packers";   // ipc ignored $ctl="*here"
$ipcover    = "/tmp/override";  // ipc ignored $ctl="*here"
$ipcpecl    = "/tmp/peclme";    // ipc ignored $ctl="*here"
$clobIn     = "";               // *** XML input script
$clobOut    = "";               // *** XML output returned
$pase_ccsid = 819;              // *** pecl ccsid pase
$ebcdic_ccsid = 37;             // *** pecl ccsid ebcidic
// *** pear tests ***
// *** php.ini and etc/config.d/*.ini 
// *** enable ibm_db2, odbc, pdo_ibm, xml, and pcntl
$testLib       = 'XMLSERVICE';  // XMLSERVICE - testing call programs, etc.
$schematest    = 'XMLSERVTST';  // XMLSERVTST - testing DB2 by XML
$chglibl       = "CHGLIBL LIBL($schematest QTEMP) CURLIB($schematest)";
$pdfInFile     = "ZendCall.pdf";
$pdfOutFile    = "ZendCallOut.pdf";
$pngstar       = "ZendStar.png";
$txtessay      = "ZendEssay.txt";
$curr_ibm_db2_file = "/usr/local/zendsvr/etc/conf.d/ibm_db2.ini";
$save_ibm_db2_file = "/usr/local/zendsvr/etc/conf.d/ibm_db2.ini-orig";
$here_ibm_db2_file = "ibm_db2.ini-here";
// *** pear cw tests ***
// *** CW, toolkit tests use Alan's CWDEMO library (download php toolkit)
$cwdb          = 'localhost';

// *** driver includes, etc.
require_once 'xmlservice_drivers.php';
require_once 'xmlservice_junk_away.php';
require_once 'xmlservice_ignore_userid.php';
require_once 'xmlservice_perf_report.php';

?>
