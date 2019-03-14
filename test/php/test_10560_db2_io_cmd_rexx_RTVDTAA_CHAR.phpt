--TEST--
XML i Toolkit: IBM_DB2 rexx RTVDTAARA CHAR
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');

// -------------
// call IBM i
// -------------
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");
$stmt = db2_prepare($conn, "call $procLib.iPLUG512K(?,?,?,?)");
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
// output processing (XML input info)
// -----------------
// dump raw XML (easy test debug)
var_dump($clobOut);
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML output");
// expected
if (strpos($clobOut,"desc=")<1) die("Missing desc=\n");
// good
echo "Success\n";

function getxml() {
global $testLib;
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<cmd>CRTDTAARA DTAARA($testLib/DA1) TYPE(*CHAR) LEN(3) VALUE(ABC)</cmd>
<cmd exec='rexx'>RTVDTAARA DTAARA($testLib/DA1) RTNVAR(?)</cmd>
<cmd exec='rexx'>RTVDTAARA DTAARA($testLib/DA1 (2 1)) RTNVAR(?)</cmd>
</script>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success

