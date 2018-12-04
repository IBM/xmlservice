--TEST--
XML i Toolkit: IBM_DB2 inout SRVPGM - RPG step var incrementing
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
for ($i=0; $i<5; $i++) {
  $stmt = db2_prepare($conn, "call $procLib.iPLUG4K(?,?,?,?)");
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
  // output processing
  // -----------------
  // dump raw XML (easy test debug)
  var_dump($clobOut);
  // xml check via simplexml vs. expected results
  $xmlobj = simplexml_load_string($clobOut);
  if (!$xmlobj) die("Bad XML returned");
  $allpgms = $xmlobj->xpath('/script/pgm');
  if (!$allpgms) die("Missing XML pgm info");
  $pgm = $allpgms[0];
  $name = $pgm->attributes()->name;
  $lib  = $pgm->attributes()->lib;
  $func = $pgm->attributes()->func;
  // pgm return
  $retn = $pgm->xpath('return');
  if (!$retn) die("No XML pgm return ($lib/$name.$func)");
  $data = (string)$retn[0]->data;
  if ($data == 0) die("return not greater than '0'");
  // good
  echo "Success ($lib/$name.$func return $data)\n";
}

function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZSTEP'>
 <return>
  <data type='10i0'>0</data>
 </return>
</pgm>
</script>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success (%s)
%s
Success (%s)
%s
Success (%s)
%s
Success (%s)
%s
Success (%s)

