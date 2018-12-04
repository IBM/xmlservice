--TEST--
XML i Toolkit: IBM_DB2 blank ipc stateless
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG4K(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
$ipc = '';
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

// check if good
// pgm ran, but should appear
if (strpos($clobOut,'<pgm')<1) die("Missing error <pgm\n");
// bad IPC
if (strpos($clobOut,'<jobipcskey>FFFFFFFF</jobipcskey>')<1) die("Missing error <jobipcskey>FFFFFFFF</jobipcskey>\n");
// QSQSRVR because bad IPC will run *here
if (strpos($clobOut,'<jobname>QSQSRVR</jobname>')<1) die("Missing error <jobname>QSQSRVR</jobname>\n");
// joblog status
if (strpos($clobOut,'<joblog')>0) die("Error contains <joblog, but should not sh error='fast'\n");

// good
echo "Success\n";

function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZNADA' error='fast'>
</pgm>
<diag error='fast'/>
</script>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success

