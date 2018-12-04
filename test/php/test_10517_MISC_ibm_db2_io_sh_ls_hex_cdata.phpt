--TEST--
XML i Toolkit: IBM_DB2 inout SH - ls /usr/local/zendsvr/bin
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG10M(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
$ctl .= " *cdata";
$clobIn = getxml();
$clobOut = "";
echo $clobIn;
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

if (strpos($clobOut,"packer")<1) {
  var_dump($clobOut);
  die("packer missing\n");
}

// good
echo "Success (PASE sh)\n";

// 5250:
// call qp2term
// /QOpenSys/usr/bin/ls /tmp
function getxml() {
$clob = "<?xml version='1.0'?>\n";
$clob .= "<script>\n";
$clob .= "<sh after='37/424/37/424'>";
$clob .= "/QOpenSys/usr/bin/ls /tmp";
$clob .= "</sh>\n";
$clob .= "</script>\n";
return $clob;
}
?>
--EXPECTF--
%s
Success (%s)

