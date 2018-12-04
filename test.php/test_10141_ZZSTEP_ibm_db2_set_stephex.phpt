--TEST--
XML i Toolkit: IBM_DB2 result set SRVPGM - RPG step hex incrementing
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
  $stmt = db2_prepare($conn, "call $procLib.iPLUGR4K(?,?,?)");
  if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
  $clobIn = getxml();
  $clobOut = "";
  $ret=db2_execute($stmt,array($ipc,$ctl,$clobIn));
  if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
  while ($row = db2_fetch_array($stmt)){
    $clobOut .= $row[0];
  }
  $clobOut = trim($clobOut);
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
  if (strlen($data) < 8) die("return not greater than '0'");
  // good
  echo "Success ($lib/$name.$func return $data)\n";
}

function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZSTEP'>
 <return>
  <data type='4b'>C6BF1461</data>
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

