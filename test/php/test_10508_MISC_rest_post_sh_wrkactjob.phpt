--TEST--
XML i Toolkit: REST POST SH - system 'wrkactjob'
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
     'xmlout' => 5000000    // size expected XML output
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
$expect = 'E N D  O F  L I S T I N G'; // should be in the list
$missing = true;
foreach ($sh[0]->row as $row) {
  $data = (string)$row;
  if (strpos($data,$expect)>0) {
    $missing = false;
    break;
  } 
}
if ($missing) die("XML sh data missing ($expect)");

// good
echo "Success (PASE sh)\n";

// 5250:
// call qp2term
// /QOpenSys/usr/bin/system -i 'wrkactjob'
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sh rows='on'>/QOpenSys/usr/bin/system -i 'wrkactjob'</sh>
</script>
ENDPROC;
return $clob;
}
?>
--EXPECTF--
%s
Success (%s)

