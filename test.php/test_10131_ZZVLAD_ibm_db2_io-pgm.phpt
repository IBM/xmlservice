--TEST--
XML i Toolkit: IBM_DB2 inout PGM - call pgm complex ds
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG512K(?,?,?,?)");
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
// good
echo "Success ($lib/$name)\n";

//     D job_t           ds                  qualified based(Template)
//     D  dsMyHire                       D   datfmt(*iso)
//     D  dsMyLeav                       D   datfmt(*iso)
//     D  dsMyJob                      64A   varying
//     D  dsMyPay                      12p 2
//
//     D MyDsArray       ds                  likeds(job_t) dim(3)
//
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * main(): Control flow
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     C     *Entry        PLIST                   
//     C                   PARM                    MyDsArray
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZVLAD' lib='xyzlibxmlservicexyz'>
 <parm  io='both'>
  <ds dim='2' var='job_t'>
    <data type='10a' var='begin'>2011-05-11</data>
    <data type='10a' var='end'>2011-07-12</data>
    <data type='64a' varying='on' var='job'>Frog wrangler</data>
    <data type='12p2' var='salary'>7.25</data>
  </ds>
  <ds var='job_t'>
    <data type='10a' var='begin'>2010-01-11</data>
    <data type='10a' var='end'>2010-07-12</data>
    <data type='64a' varying='on' var='job'>Toad wrangler</data>
    <data type='12p2' var='salary'>4.29</data>
  </ds>
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

