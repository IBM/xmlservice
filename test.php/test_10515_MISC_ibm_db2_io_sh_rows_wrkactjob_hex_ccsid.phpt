--TEST--
XML i Toolkit: IBM_DB2 inout SH - hex wrkactjob
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG15M(?,?,?,?)");
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
// var_dump($clobOut);

// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML returned");

// expected
$hex = (string)$xmlobj->sh->hex;
// var_dump($hex);

$clobOut = pack("H*",$hex);
// var_dump($clobOut);
if (strpos($clobOut,"E N D  O F  L I S T I N G")<1) die("E N D  O F  L I S T I N G missing\n");
echo "I am completed\n";

// good
echo "Success (PASE sh)\n";

// 5250:
// call qp2term
// /QOpenSys/usr/bin/ls /tmp
function getxml() {
$clob = "<?xml version='1.0'?>\n";
$clob .= "<script>\n";
$clob .= "<sh hex='on' before='819/37' after='37/819'>";
$sh = "/QOpenSys/usr/bin/system -i 'wrkactjob'";
for ($i=0;$i<10;$i++) $sh .= ";/QOpenSys/usr/bin/system -i 'wrkactjob'";
$clob .= bin2hex($sh);
$clob .= "</sh>\n";
$clob .= "</script>\n";
return $clob;
}
?>
--EXPECTF--
%s
Success (%s)


