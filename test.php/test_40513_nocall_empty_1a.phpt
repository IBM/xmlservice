--TEST--
XML i Toolkit: DSUDIMVAL1
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// -----------------
// make the call
// -----------------
// see connection.inc param details ...
require_once('connection.inc');
// call IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Fail connect: $database,$user");
$stmt = db2_prepare($conn, "call $procLib.iPLUG15M(?,?,?,?)");
if (!$stmt) die("Fail prepare: ".db2_stmt_errormsg());
$ctl .= " *test";
$zz0cnt = 3;
$clobIn = getxml($zz0cnt);
// xml check via simplexml vs. expected results
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

// good
echo "Success\n";

function getxml($zz0cnt) {
$clob = <<<ENDPROC
<?xml version='1.0' encoding='ISO-8859-1' ?>
<script>
<pgm name='JUSTONE'>
<parm io='in' comment='test mode flag'><data type='1A' var='tmode' /></parm>
</pgm>
</script>
ENDPROC;
$was = array("zz0cnt");
$now = array("$zz0cnt");
return str_replace($was,$now,$clob);
}
?>
--EXPECTF--
%s
Success

