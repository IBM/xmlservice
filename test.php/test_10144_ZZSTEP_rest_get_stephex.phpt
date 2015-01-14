--TEST--
XML i Toolkit: REST GET SRVPGM - RPG step var incrementing
--SKIPIF--
<?php require_once('skipifrest.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
for ($i=0; $i<5; $i++) {
  // http GET parms
  $clobIn = getxml();
  $clobOut = "";
  $parm  = "?db2=$i5restdb";
  $parm .= "&uid=$user";
  $parm .= "&pwd=$password";
  $parm .= "&ipc=$ipc";
  $parm .= "&ctl=$ctl";
  $parm .= "&xmlin=".urlencode($clobIn);
  $parm .= "&xmlout=32768";  // size expected XML output
  // execute
  $linkall = "$i5resturl".htmlentities($parm);
  $getOut = simplexml_load_file($linkall);
  // result
  if ($getOut) $clobOut = $getOut->asXML();
  else $clobOut = "";
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

