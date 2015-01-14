<?php
$i5resturl = "http://YiPs.iDevCloud.com/cgi-bin/xmlcgi.pgm";
//$i5resturl = "http://174.79.32.155/cgi-bin/xmlcgi.pgm";
//$i5resturl = "http://lp0364d/cgi-bin/xmlcgi.pgm";

$postdata = http_build_query(
   array(
     'db2' => "*LOCAL",
     'uid' => "*NONE",
     'pwd' => "*NONE",
     'ipc' => "*NA",
     'ctl' => "*here",
     'xmlin' => 
"<?xml version='1.0'?>
<script>
<cmd>CHGLIBL LIBL(QTEMP XMLSERVTST) CURLIB(XMLSERVTST)</cmd>
</script>",
     'xmlout' => 32768    // size expected XML output
   )
);

echo 

$opts = array('http' =>
   array(
     'method'  => 'POST',
     'header'  => 'Content-type: application/x-www-form-urlencoded',
     'content' => $postdata
   )
);
$context  = stream_context_create($opts);
// execute
$linkall = $i5resturl;
echo file_get_contents($linkall, false, $context);
?>
