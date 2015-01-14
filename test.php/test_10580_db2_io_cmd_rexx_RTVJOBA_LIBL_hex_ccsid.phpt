--TEST--
XML i Toolkit: IBM_DB2 rexx RTVJOBA LIBL hex ccsid
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
// var_dump($clobOut);

// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML output");

// -----------------
// output cmd call
// -----------------
$sh = $xmlobj->xpath('/script/cmd');
if (!$sh) die("Missing XML cmd info");
// expected
$hexrows = $xmlobj->xpath('/script/cmd/row');
$data = "";
foreach($hexrows as $row) {
  $hexdata = $row->xpath('data/hex'); 
  foreach($hexdata as $hex) {
    $data .= " \n-> ".pack("H*", $hex);
  } 
}
echo "$data\n";
if (strpos($data,"QSYS")<1) die("Missing QSYS\n");

// good
echo "Success\n";

function getxml() {
$clob = "<?xml version='1.0'?>\n";
$clob .= "<script>\n";
$clob .= "<cmd exec='rexx' hex='on' before='819/37' after='37/819'>";
$clob .= bin2hex("RTVJOBA USRLIBL(?) SYSLIBL(?)");
$clob .= "</cmd>\n";
$clob .= "</script>\n";
return $clob;
}
?>
--EXPECTF--
%s
Success

