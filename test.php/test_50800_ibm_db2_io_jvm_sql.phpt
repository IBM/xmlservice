--TEST--
XML i Toolkit: IBM_DB2 inout SQL JVM
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
$ctl = "*here *sqljava";
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

$rows = $xmlobj->xpath('/script/sql/fetch/row');
if (!$rows) die("Missing XML rows info");
foreach($rows as $row) {
  foreach($row->data as $data) {
   echo $data;
  }
  echo "\n";
}

if (strpos($data, "db2_classes.jar") < 1) die("missing db2_classes.jar\n");

// good
echo "\nSuccess\n";

function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sql>
<free/>
<options options='sqlmode' naming='sql'/>
<connect conn='mydot' options='sqlmode'/>
<query conn='mydot'>set schema xmlservice</query>
<query>select getProperty('java.class.path') from sysibm.sysdummy1</query>
<fetch block='all' desc='on'/>
</sql>
</script>
ENDPROC;
return $clob;
}
?>
--EXPECTF--
%s
Success

