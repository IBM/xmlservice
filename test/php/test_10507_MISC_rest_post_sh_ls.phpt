--TEST--
XML i Toolkit: REST POST SH - ls /usr/local/zendsvr/bin
--SKIPIF--
<?php require_once('skipifrest.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');

// http POST parms
$clobIn = getxml();
$clobOut = "";
$postdata = http_build_query(
   array(
     'db2' => "*LOCAL",
     'uid' => $user,
     'pwd' => $password,
     'ipc' => $ipc,
     'ctl' => $ctl,
     'xmlin' => $clobIn,
     'xmlout' => 1000000    // size expected XML output
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
// execute
$linkall = $i5resturl;
$result = file_get_contents($linkall, false, $context);
// result
if ($result) {
  $getOut = simplexml_load_string($result);
  $clobOut = $getOut->asXML();
}
else $clobOut = "";
// -----------------
// output processing
// -----------------
// dump raw XML (easy test debug)
var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML returned");
// -----------------
// output sh call
// -----------------
$sh = $xmlobj->xpath('/script/sh');
if (!$sh) die("Missing XML sh info");

// good
echo "Success (PASE sh)\n";

// 5250:
// call qp2term
// /QOpenSys/usr/bin/ls /tmp
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sh>/QOpenSys/usr/bin/ls /tmp</sh>
</script>
ENDPROC;
return $clob;
}
?>
--EXPECTF--
%s
Success (%s)

