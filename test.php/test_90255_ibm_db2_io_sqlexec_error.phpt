--TEST--
XML i Toolkit: IBM_DB2 inout SQL - error query animalnotthere
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

$allerror = array("fast","off","on");
foreach ($allerror as $myerror) {
  $stmt = db2_prepare($conn, "call $procLib.iPLUG15M(?,?,?,?)");
  if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
  $clobIn = getxml($myerror);
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
  // -----------------
  // output processing
  // -----------------
  // dump raw XML (easy test debug)
  var_dump($clobOut);
  // xml check via simplexml vs. expected results
  $xmlobj = simplexml_load_string($clobOut);
  if (!$xmlobj) die("Bad XML returned");
  switch($myerror) {
    case "fast":
      $sqlcode = $xmlobj->xpath('/script/sql/query/error/sqlcode');
      if (!$sqlcode) die("Bad error='fast' prepare missed sqlcode");
      $sqlstate = $xmlobj->xpath('/script/sql/query/error/sqlstate');
      if (!$sqlstate) die("Bad error='fast' prepare missed sqlstate");
      $error = $xmlobj->xpath('/script/sql/query/error');
      if (!$error) die("Bad error='fast' query missed error");
      $joblog = $xmlobj->xpath('/script/sql/query/joblog');
      if ($joblog) die("Bad error='fast' query included joblog");

      $error = $xmlobj->xpath('/script/sql/fetch/error');
      if (!$error) die("Bad error='fast' fetch missed error");
      $joblog = $xmlobj->xpath('/script/sql/fetch/joblog');
      if ($joblog) die("Bad error='fast' fetch included joblog");
      break;
    case "off":
      $sqlcode = $xmlobj->xpath('/script/sql/query/error/sqlcode');
      if (!$sqlcode) die("Bad error='fast' prepare missed sqlcode");
      $sqlstate = $xmlobj->xpath('/script/sql/query/error/sqlstate');
      if (!$sqlstate) die("Bad error='fast' prepare missed sqlstate");
      $error = $xmlobj->xpath('/script/sql/query/error');
      if (!$error) die("Bad error='off' query missing error");
      $joblog = $xmlobj->xpath('/script/sql/query/joblog');
      if (!$joblog) die("Bad error='off' query missing joblog");

      $error = $xmlobj->xpath('/script/sql/fetch/error');
      if (!$error) die("Bad error='off' fetch missing error");
      $joblog = $xmlobj->xpath('/script/sql/fetch/joblog');
      if (!$joblog) die("Bad error='off' fetch missing joblog");
      break;
    case "on":
      $error = $xmlobj->xpath('/report/error');
      if (!$error) die("Bad error='on' missing error");
      $joblog = $xmlobj->xpath('/report/joblog');
      if (!$joblog) die("Bad error='on' missing joblog");
      break;
    default:
      break;
  }
}
// good
echo "Success\n";

function getxml($now) {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sql>
<query error='xyzerror'>select * from animalnotthere</query>
<fetch block='all' error='xyzerror'/>
</sql>
</script>
ENDPROC;
$clob = str_replace("xyzerror",$now,$clob);
return $clob;
}
?>
--EXPECTF--
%s
Success


