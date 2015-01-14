--TEST--
XML i Toolkit: DOUEVIL1
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// -----------------
// make the call
// -----------------
// see connection.inc param details ...
require_once('connection.inc');
// call IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Fail connect: $database,$user");
$stmt = db2_prepare($conn, "call $procLib.iPLUG15M(?,?,?,?)");
if (!$stmt) die("Fail prepare: ".db2_stmt_errormsg());
$ctl .= " *test";
$zz0cnt = 3;
$clobIn = getxml($zz0cnt);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobIn);
if (!$xmlobj) die("Fail XML input\n");
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Fail execute: ".db2_stmt_errormsg());
// -----------------
// output processing
// -----------------
// dump raw XML (easy test debug)
var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Fail XML output\n");
// pm1
if (substr_count($clobOut,"aa") < 1) die ("aa - missing\n");
if (substr_count($clobOut,"ab") < 1) die ("ab - missing\n");
// pm2
if (substr_count($clobOut,"ba") < 1) die ("ba - missing\n");
if (substr_count($clobOut,"bb") < 1) die ("bb - missing\n");
$x = "cdefghilmno";
$total = $zz0cnt;
for ($i=0;$i<$zz0cnt;$i++) {
  for ($j=0;$i<strlen();$i++) {
    $y = "b".substr($x,$j,1);
    if (substr_count($clobOut,$y) <> $total) die ("$y(1:$total) - missing\n");
  }
}
$x = "jk";
$total = $zz0cnt * $zz0cnt;
for ($i=0;$i<$zz0cnt;$i++) {
  for ($j=0;$i<strlen();$i++) {
    $y = "b".substr($x,$j,1);
    if (substr_count($clobOut,$y) <> $total) die ("$y(1:$total) - missing\n");
  }
}

// good
echo "Success\n";

function getxml($zz0cnt) {
$clob = <<<ENDPROC
<?xml version='1.0' encoding='ISO-8859-1' ?>
<script>
<pgm name='DOUEVIL1'>
<parm prm='pm10000000aa'>
<data var='va10000000ab' type='3s0' enddo='v0cnt'>zz0cnt</data>
</parm>
<parm prm='pm20000000ba'>
<ds   var='ds21000000bb'>
 <ds   var='ds21100000bc' dim='999' dou='v0cnt'>
  <data var='va21100000bd' type='10a'>2012-06-22</data>
  <ds   var='ds21110000be'>
   <data var='va21110000bf' type='17a'>FlinFlam</data>
   <data var='va21110000bg' type='12a'>Fredrich</data>
   <ds   var='ds21111000bh' dim='999' dou='v0cnt'>
    <data var='va21111000bj' type='1a'>R</data>
    <data var='va21111000bk' type='9a'>Regan</data>
   </ds>
   <data var='va21110000bl' type='3a'>101</data>
   <data var='va21110000bm' type='12p2'>42.42</data>
  </ds>
  <data var='va21100000bn' type='1a'>N</data>
  <data var='va21110000bo' type='5s0'>42</data>
 </ds>
</ds>
</parm>
</pgm>
</script>
ENDPROC;
$was = array("zz0cnt");
$now = array("$zz0cnt");
return str_replace($was,$now,$clob);
}
?>
--EXPECTF--
%s
Success

