--TEST--
XML i Toolkit: IBM_DB2 inout SQL - query animal
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
for ($i=0;$i<999;$i++) {
if ($i==0) $clobIn = getxml1();
else if ($i==1) $clobIn = getxml2();
else $clobIn = getxml3();
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
if (strpos($clobOut,"error")) {
  if ($i>2) break;
  else {
    var_dump($clobOut);
    die("missing steps\n");
  }
} 
// -----------------
// output processing
// -----------------
// dump raw XML (easy test debug)
var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML returned");
}
// good
echo "Success\n";

function getxml1() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sql>
<query>select * from animal</query>
</sql>
</script>
ENDPROC;
return $clob;
}
function getxml2() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sql>
<describe desc='col'/>
</sql>
</script>
ENDPROC;
return $clob;
}
function getxml3() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sql>
<fetch block='2' desc='on'/>
</sql>
</script>
ENDPROC;
return $clob;
}
?>
--EXPECTF--
%s
Success

