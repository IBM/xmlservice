<?php
$i5resturl = "http://YiPs.iDevCloud.com/cgi-bin/xmlcgi.pgm";
//$i5resturl = "http://174.79.32.155/cgi-bin/xmlcgi.pgm";
//$i5resturl = "http://lp0364d/cgi-bin/xmlcgi.pgm";
$parm  = "?db2=*LOCAL";
$parm .= "&uid=*NONE";
$parm .= "&pwd=*NONE";
$parm .= "&ipc=*NA";
$parm .= "&ctl=*here";
$parm .= "&xmlin=".urlencode(
"<?xml version='1.0'?>
<script>
<cmd>CHGLIBL LIBL(QTEMP XMLSERVTST) CURLIB(XMLSERVTST)</cmd>
</script>"
);
$parm .= "&xmlout=32768";  // size expected XML output
// execute
$linkall = "$i5resturl".htmlentities($parm);
echo $linkall."\n";
// echo simplexml_load_file($linkall);
echo file_get_contents($linkall);
?>
