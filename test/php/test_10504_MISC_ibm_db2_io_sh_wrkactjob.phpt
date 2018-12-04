--TEST--
XML i Toolkit: IBM_DB2 inout SH - system 'wrkactjob'
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
// call IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");
$stmt = db2_prepare($conn, "call $procLib.iPLUG5M(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
$clobIn = getxml();
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
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
// /QOpenSys/usr/bin/system -i 'wrkactjob SBS(QUSRWRK)'
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sh rows='on'>/QOpenSys/usr/bin/system -i 'wrkactjob SBS(QUSRWRK)'</sh>
</script>
ENDPROC;
return $clob;
}
?>
--EXPECTF--
%s
Success (%s)

