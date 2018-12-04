--TEST--
XML i Toolkit: IBM_DB2 inout SQL - prepare parm
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
$sqls = $xmlobj->xpath('/script/sql/prepare');
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
// output parm header
// -----------------
echo "Parameters (execute '?'):\n";
$parms = $xmlobj->xpath('/script/sql/count/parmcount');
if (!$parms) die("Missing XML parms info");
$format = "Parameter: %'.15.15s \n";
printf ($format, ("parmcount(".(string)$parms[0].")"));
// -----------------
// output row header
// -----------------
echo "Result set (fetch):";
$cols = $xmlobj->xpath('/script/sql/count/colcount');
if (!$cols) die("Missing XML cols info");
$format = "%'.15.15s ";
printf ($format, ("colcount(".(string)$cols[0].")"));
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
<prepare><![CDATA[select * from animal where ID < ? and weight > ?]]></prepare>
<execute>
<parm io='in'>7</parm>
<parm io='in'>10.0</parm>
</execute>
<count desc='both'/>
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

