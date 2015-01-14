--TEST--
XML i Toolkit: IBM_DB2 inout PGM - deep nested structures
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG10M(?,?,?,?)");
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

// pgm parms
$parm = $pgm->xpath('parm');
if (!$parm) die("Fail XML pgm parms missing ($lib/$name)\n");

$expect = "Oh my, this is complex";
if (!strpos($clobOut,$expect)) die("Failed not find: $expect\n");

// good
echo "Success ($lib/$name)\n";


function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZDEEP' lib='xyzlibxmlservicexyz'>
 <parm  io='out'>
  <ds var='INDS1'>
    <data var='1-I1' type='10i0'/>
    <data var='1-C2' type='10a'/>
    <data var='1-P1' type='12p2'/>
    <data var='1-Z2' type='12s2'/>
    <ds var='INDS2' dim='2'>
      <data var='2-I1' type='10i0'/>
      <data var='2-C2' type='10a'/>
      <data var='2-P1' type='12p2'/>
      <data var='2-Z2' type='12s2'/>
      <ds var='INDS3' dim='3'>
        <data var='3-I1' type='10i0'/>
        <data var='3-C2' type='10a'/>
        <data var='3-P1' type='12p2'/>
        <data var='3-Z2' type='12s2'/>
        <ds var='INDS4' dim='4'>
          <data var='4-I1' type='10i0'/>
          <data var='4-C2' type='10a'/>
          <data var='4-P1' type='12p2'/>
          <data var='4-Z2' type='12s2'/>
          <ds var='INDS5' dim='5'>
            <data var='5-I1' type='10i0'/>
            <data var='5-C2' type='10a'/>
            <data var='5-P1' type='12p2'/>
            <data var='5-Z2' type='12s2'/>
            <data var='5-R2' type='8f4'/>
            <data var='5-R3' type='4f2'/>
          </ds>
        </ds>
      </ds>
    </ds>
        <ds var='INDS4' dim='4'>
          <data var='4-I1' type='10i0'/>
          <data var='4-C2' type='10a'/>
          <data var='4-P1' type='12p2'/>
          <data var='4-Z2' type='12s2'/>
          <ds var='INDS5' dim='5'>
            <data var='5-I1' type='10i0'/>
            <data var='5-C2' type='10a'/>
            <data var='5-P1' type='12p2'/>
            <data var='5-Z2' type='12s2'/>
            <data var='5-R2' type='8f4'/>
            <data var='5-R3' type='4f2'/>
          </ds>
        </ds>
          <ds var='INDS5'>
            <data var='5-I1' type='10i0'/>
            <data var='5-C2' type='10a'/>
            <data var='5-P1' type='12p2'/>
            <data var='5-Z2' type='12s2'/>
            <data var='5-R2' type='8f4'/>
            <data var='5-R3' type='4f2'/>
          </ds>
          <ds var='INDS6'>
            <data var='6-I1' type='10i0'/>
            <data var='6-C2' type='10a'/>
            <data var='6-P1' type='12p2'/>
            <data var='6-Z2' type='12s2'/>
            <data var='6-R2' type='8f4'/>
            <data var='6-R3' type='4f2'/>
          </ds>
    <data var='1-R2' type='8f4'/>
    <data var='1-R3' type='4f2'/>
    <data var='1-C3' type='60a'/>
    <data var='1-Z3' type='12s3'/>
    <data var='1-Z4' type='12s4'/>
  </ds>
 </parm>
 <return>
  <data var='ret' type='10i0'>0</data>
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

