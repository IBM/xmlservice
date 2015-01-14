--TEST--
XML i Toolkit: ODBC result set SRVPGM - RPG step var incrementing
--SKIPIF--
<?php require_once('skipifodbc.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
// call IBM i
if ($i5persistentconnect) $conn = odbc_pconnect($database,$user,$password);
else $conn = odbc_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");
for ($i=0; $i<5; $i++) {
  $stmt = odbc_prepare($conn, "call $procLib.iPLUGR4K(?,?,?)");
  if (!$stmt) die("Bad prepare: ".odbc_errormsg());
  $ctl .= " *hack";
  $clobIn = getxml();
  $clobOut = "";
  // bad behavior odbc extension (IBM i result set warn???)
  error_reporting(~E_ALL); 
  $ret=odbc_execute($stmt,array($ipc,$ctl,$clobIn));
  if (!$ret) die("Bad execute: ".odbc_errormsg());
  error_reporting(E_ALL); 
  while(odbc_fetch_row($stmt)) {
    $clobOut .= driverJunkAway(odbc_result($stmt, 1));
  }
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

