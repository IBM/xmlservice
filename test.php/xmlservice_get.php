<?php
// PHP driver: xmlservice_get.php
// Notes:
// Assumes you have XMLSERVICE REST driver enabled
// HTTP Server (Apache) and a IBM i version match
// XMLSERVICE/XMLCGI.PGM (you compiled).
//
// You may use XMLSERVICE REST driver on IBM i (1-tier)
// or from Linux/Windows to IBM i (2-tier).
// For help:
// http://www.youngiprofessionals.com/wiki/index.php/XMLService

// *** XMLSERVICE call (REST GET + internal RPG DB2 driver) ***
// Example: /www/zendsvr/conf/httpd.conf
// ScriptAlias /cgi-bin/ /QSYS.LIB/XMLSERVICE.LIB/
// <Directory /QSYS.LIB/XMLSERVICE.LIB/>
//   AllowOverride None
//   order allow,deny
//   allow from all
//   SetHandler cgi-script
//   Options +ExecCGI
// </Directory>
function xmlservice($xml) {
global $i5persistentconnect, $database, $user, $password, $ipc, $ctl, $procConn, $procLib, $procPlug, $procPlugR, 
       $i5resturl, $i5restdb, $i5restuser, $i5restpass, $i5restsz;
  $was = array('"');
  $now = array("'");
  $xmlIn = str_replace($was,$now,$xml);
  $xmlOut = '';
  $parm  = "?db2=$i5restdb";
  $parm .= "&uid=$i5restuser";
  $parm .= "&pwd=$i5restpass";
  $parm .= "&ipc=$ipc";
  $parm .= "&ctl=$ctl";
  $parm .= "&xmlin=".urlencode($xmlIn);
  $parm .= "&xmlout=$i5restsz";  // size expected XML output
  $linkall = "$i5resturl".htmlentities($parm);
  $xmlOut = file_get_contents($linkall);
  return driverJunkAway($xmlOut);                         // just in case driver odd
                                                          // ... possible junk end record,
                                                          // record</script>junk
}
?>
