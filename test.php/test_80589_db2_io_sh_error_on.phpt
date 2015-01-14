--TEST--
XML i Toolkit: IBM_DB2 check sh error on
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
if (!$xmlobj) die("Bad XML input");

// check if good
if (strpos($clobOut,'<report>')>0) die("Error contains <report>, but should not sh default\n");
if (strpos($clobOut,'<error>')>0) die("Error contains <error>, but should not sh default\n");
if (strpos($clobOut,'<joblog')>0) die("Error contains <joblog>, but should not sh default\n");
if (strpos($clobOut,"<error>CPF")>0) die("Error contains <error>CPFxxx</error>, but should not sh default\n");
if (strpos($clobOut,"hdhdgd not found")<1) die("Missing hdhdgd not found\n");

// good
echo "Success\n";

function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sh error='on'><![CDATA[/QOpenSys/usr/bin/ls /hdhdgd 2>&1]]></sh>
<sh error='on'><![CDATA[/QOpenSys/usr/bin/ls /hdhdgd 2>&1]]></sh>
</script>
ENDPROC;
return $clob;
}
?>
--EXPECTF--
%s
Success

