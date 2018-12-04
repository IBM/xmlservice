--TEST--
XML i Toolkit: IBM_DB2 inout LIC - license
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
$clobIn   = "<?xml version='1.0'?>"; // XML in
$clobOut  = "";                      // XML out
$ctl     .= " *license";             // show license
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
// dump XML out
var_dump($clobOut);
// XML check
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML returned\n");
// check raw XML no error?
if (strpos($clobOut,"Copyright")<1) die("Fail Copyright ($ctl)\n");
echo "Success\n";
?>
--EXPECTF--
%s
Success

