--TEST--
XML i Toolkit: IBM_DB2 inout PGM - call pgm complex data
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
// -----------------
// output pgm call
// -----------------
// only one program this XML script
$pgm = $allpgms[0];
$name = $pgm->attributes()->name;
$lib  = $pgm->attributes()->lib;

if (strpos($clobOut,":E:F:333.3330:4444444444.44:")<1) die("Missing :E:F:333.3330:4444444444.44:");


// good
echo "Success ($lib/$name)\n";

function getxml() {
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
  <ds data="records">
   <data type='1A' var='INDS1.DSCHARA'>x</data>
   <data type='1A' var='INDS1.DSCHARB'>y</data>
   <data type='7p4' var='INDS1.DSDEC1'>66.6666</data>
   <data type='12p2' var='INDS1.DSDEC2'>77777.77</data>
  </ds>
  <records delimit=':'>:r:o:444.4444:888.88:</records>
 </parm>
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

