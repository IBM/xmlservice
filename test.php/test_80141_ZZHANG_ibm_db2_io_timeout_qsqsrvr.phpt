--TEST--
XML i Toolkit: IBM_DB2 inout SRVPGM - hang qsysopr
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');

$filename = "/QOpenSys/usr/bin/system";
if (file_exists($filename)===false) die("Fail IBM i only missing ($filename)\n");

$job1 = "QSQSRVR";

// -------------------
// call IBM i
// -------------------
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");

$ctl = "*here *call(15/kill)";

echo driverTime()." $job1 calling hang program $ctl\n";
$stmt = db2_prepare($conn, "call $procLib.iPLUG32K(?,?,?,?)");
if (!$stmt) die("Bad prepare (1): ".db2_stmt_errormsg());
$clobIn = getxmlhangme();
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) echo("Bad execute (1): ".db2_stmt_errormsg());
echo driverTime()." $job1 timeout back from calling hang program\n";

// test result (we make it back)
echo "Success\n";

//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zzhang: bad function hang up
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzhang          B                   export
//     D zzhang          PI
function getxmlhangme() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZHANG'>
</pgm>
</script>
ENDPROC;
return test_lib_replace($clob);
}

?>
--EXPECTF--
%s
Success

