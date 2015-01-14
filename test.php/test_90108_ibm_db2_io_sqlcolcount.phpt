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
// var_dump($clobIn);
$xmlobj = simplexml_load_string($clobIn);
if (!$xmlobj) die("Bad XML input");
$sqls = $xmlobj->xpath('/script/sql/query');
if (!$sqls) die("Missing XML sql input info");
foreach($sqls as $sql) {
  echo (string)$sql."\n";
}
// -----------------
// output processing
// -----------------
// dump raw XML (easy test debug)
// var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML returned");
// -----------------
// output row header
// -----------------
$colcount = $xmlobj->xpath('/script/sql/count/colcount');
if (!$colcount) die("Missing XML colcount info");
$format = "%'.15.15s ";
printf ($format, ("colcount(".(string)$colcount[0].")"));
echo "\n";
// -----------------
// output row data
// -----------------
$rows = $xmlobj->xpath('/script/sql/fetch/row');
if (!$rows) die("Missing XML rows info");
foreach($rows as $row) {
  foreach($row->data as $data) {
    printf ($format, (string)$data);
  }
  echo "\n";
}
// good
echo "Success\n";

function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sql>
<query>select * from animal</query>
<count desc='col'/>
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

