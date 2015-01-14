--TEST--
XML i Toolkit: OPM 64 parms
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

// good
echo "Success\n";

function getxml($zz0cnt) {
$clob = <<<ENDPROC
<?xml version='1.0' encoding='ISO-8859-1' ?>
<script>
<pgm mode='opm'  name='ZZCALL' lib='xyzlibxmlservicexyz'>
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
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
<parm io='in'><data type='1A'/></parm>
</pgm>
</script>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success

