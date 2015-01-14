--TEST--
XML i Toolkit: IBM_DB2 inout - after adopt profile
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
if ($i5persistentconnect) $conn = db2_pconnect($database,$adoptuser1,$adoptpass1);
else $conn = db2_connect($database,$adoptuser1,$adoptpass1);
if (!$conn) die("Fail connect: $database,$adoptuser1");

// $ctl .= "*debugproc";
diag();

// good
echo "Success (aftermath)\n";

// call IBM i
function callme ($xmlIn) {
  global $procLib, $conn, $ipc, $ctl;
  $stmt = db2_prepare($conn, "call $procLib.iPLUG65K(?,?,?,?)");
  if (!$stmt) die("Fail prepare: ".db2_stmt_errormsg());
  $clobIn = $xmlIn;
  $clobOut = "";
  $ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
  $ret=db2_execute($stmt);
  if (!$ret) die("Fail execute: ".db2_stmt_errormsg());
  return $clobOut;
}
// diag check
function diag() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZCALL' lib='xyzlibxmlservicexyz'>
 <parm  io='both'>
   <data type='1A' var='INCHARA'>a</data>
 </parm>
 <parm  io='both'>
   <data type='1A' var='INCHARB'>b</data>
 </parm>
 <parm  io='both'>
   <data type='7p4' var='INDEC1'>11.1111</data>
 </parm>
 <parm  io='both'>
   <data type='12p2' var='INDEC2'>222.22</data>
 </parm>
 <parm  io='both'>
  <ds>
   <data type='1A' var='INDS1.DSCHARA'>x</data>
   <data type='1A' var='INDS1.DSCHARB'>y</data>
   <data type='7p4' var='INDS1.DSDEC1'>66.6666</data>
   <data type='12p2' var='INDS1.DSDEC2'>77777.77</data>
  </ds>
 </parm>
 <return>
  <data type='10i0'>0</data>
 </return>
</pgm>
</script>
ENDPROC;
$xmlIn = test_lib_replace($clob);
$clobOut = callme ($xmlIn);
var_dump($clobOut);
}

?>
--EXPECTF--
%s
Success (%s)

