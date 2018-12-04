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
$ctl .= " *cdata";
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

// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML output");

// -----------------
// output cmd call
// -----------------
$sh = $xmlobj->xpath('/script/cmd');
if (!$sh) die("Missing XML cmd info");
// expected
$usualrows = $xmlobj->xpath('/script/cmd/row');
$data = "";
foreach($usualrows as $row) {
  $usualdata = $row->xpath('data'); 
  foreach($usualdata as $mydata) {
    $data .= " \n-> ".$mydata;
  } 
}
echo "$data\n";
if (strpos($data,"QSYS")<1) die("Missing QSYS\n");

// good
echo "Success\n";

function getxml() {
$clob = "<?xml version='1.0'?>\n";
$clob .= "<script>\n";
$clob .= "<cmd exec='rexx' after='37/424/37/424'>";
$clob .= "RTVJOBA USRLIBL(?) SYSLIBL(?)";
$clob .= "</cmd>\n";
$clob .= "</script>\n";
return $clob;
}
?>
--EXPECTF--
%s
Success

