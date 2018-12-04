--TEST--
XML i Toolkit: IBM_DB2 - check warning error
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// -----------------
// make the call
// -----------------
// see connection.inc param details ...
require_once('connection.inc');
// call IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Fail connect: $database,$user");
$stmt = db2_prepare($conn, "call $procLib.iPLUG65K(?,?,?,?)");
if (!$stmt) die("Fail prepare: ".db2_stmt_errormsg());
$clobIn = getxml();
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Fail execute: ".db2_stmt_errormsg());
// -----------------
// output processing
// -----------------
// dump raw XML (easy test debug)
// var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Fail XML returned\n");
// -----------------
// output error report
// -----------------
$mybads = array("bad1", "bad2", "bad3");
$mypaths = array("version", "error", "jobinfo", "joblog");
foreach ($mybads as $bad) {
 foreach ($mypaths as $path) {
  $look = "/script/$bad/cmd/$path";
  $allerrors = $xmlobj->xpath($look);
  if (!$allerrors) die("Fail XML errors missing $look\n");
  else echo "Good XML $look\n";
 }
}

// good
echo "Success\n";


function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0' encoding='ISO-8859-1' ?>    
<script>
<cmd>addlible xmlservice</cmd>
<bad1><cmd exec='cmd'>addlible xmlservice</cmd></bad1>
<bad2><cmd exec='system'>addlible xmlservice</cmd></bad2>
<bad3><cmd exec='rexx'>addlible xmlservice</cmd></bad3>
</script>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success

