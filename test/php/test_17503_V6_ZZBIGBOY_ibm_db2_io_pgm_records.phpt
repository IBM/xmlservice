--TEST--
XML i Toolkit: IBM_DB2 inout PGM - BIG BOY DATA
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
// $ctl .= " *test";
$bigdata = 30000;
$clobIn = getxml($bigdata);
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
// var_dump($clobIn);
// var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML returned");
$allpgms = $xmlobj->xpath('/script/pgm');
if (!$allpgms) die("Missing XML pgm info");
// -----------------
// output pgm call
// -----------------
// only one program this XML script
$pgm = $allpgms[0];
$name = $pgm->attributes()->name;
$lib  = $pgm->attributes()->lib;

if (strpos($clobOut,"{$bigdata}.1")<1) die("Missing {$bigdata}.1");
echo substr($clobOut,0,400)."\n";
echo "...\n";
echo substr($clobOut,-300)."\n";

// good
echo "Success ($lib/$name)\n";

function getxml($recs) {
$clob = "<?xml version='1.0'?>\n";
$clob .= "<script>\n";
$clob .= "<pgm name='ZZBIGBOY' lib='xyzlibxmlservicexyz'>\n";
$clob .= " <parm  io='both'>\n";
$clob .= "   <data type='7s0' var='STEP1'>$recs</data>\n";
$clob .= " </parm>\n";
$clob .= " <parm  io='both'>\n";
$clob .= " <ds dim='$recs' data='records'>\n";
$clob .= "   <data type='7A' var='NAME1'>nada1</data>\n";
$clob .= "   <data type='7s1'  var='YEARWIN1'>1.0</data>\n";
$clob .= " </ds>";
$clob .= " <records delimit=':'>";
for ($i=0;$i<$recs;$i++) $clob .= ":nada1:1.0";
$clob .= ":";
$clob .= "</records>\n";
$clob .= " </parm>\n";
$clob .= " <return>\n";
$clob .= "  <data type='10i0'>0</data>\n";
$clob .= " </return>\n";
$clob .= "</pgm>\n";
$clob .= "</script>";
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success (%s)

