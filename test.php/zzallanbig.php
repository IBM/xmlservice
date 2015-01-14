<?php
// -----------------
// make the call
// -----------------
// see connection.inc param details ...
require_once('connection.inc');

// $mytest = "zzallansmaller.txt";
$mytest = "zzallangigantic.txt";
$procLib = "XMLSERVICE";
// $procLib = "XMLSERV201";

// call IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Fail connect: $database,$user");
$stmt = db2_prepare($conn, "call $procLib.iPLUG15M(?,?,?,?)");
if (!$stmt) die("Fail prepare: ".db2_stmt_errormsg());
// -----------------
// run test 
// -----------------
$ctl .= " *test";
$clobIn = file_get_contents($mytest);
$xmlobj = simplexml_load_string($clobIn);
if (!$xmlobj) die("Fail XML input\n");
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
var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Fail XML output\n");
// -----------------
// kill xtoolkit job
// -----------------
exit(1);
// -----------------
// kill xtoolkit job
// -----------------
$ctl .= " *immed";
$clobIn = "<?xml version='1.0'?>";
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Fail execute: ".db2_stmt_errormsg());
?>
