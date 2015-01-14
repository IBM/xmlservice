--TEST--
XML i Toolkit: IBM_DB2 inout PGM - More data
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
// var_dump($clobOut);
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
if (!$parm) die("Missing XML pgm parms ($lib/$name)");

if (strpos($clobOut,"var='INCHARA'>F0F0")<1) die("missing var='INCHARA'>F0F0");
if (strpos($clobOut,"var='INCHARB'>F0F0")<1) die("missing var='INCHARB'>F0F0");
if (strpos($clobOut,"var='INCHARC'>F0F0")<1) die("missing var='INCHARC'>F0F0");
if (strpos($clobOut,"var='INCHARD'>F0F0")<1) die("missing var='INCHARD'>F0F0");

// good
echo "I am ... \n";
echo "Success ($lib/$name)\n";

//     D  INCHARA        S             64a
//     D  INCHARB        S          32000a
//     D  INCHARC        S          32000a       
//     D  INCHARD        S              4a
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * main(): Control flow
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     C     *Entry        PLIST                   
//     C                   PARM                    INCHARA
//     C                   PARM                    INCHARB
//     C                   PARM                    INCHARC
//     C                   PARM                    INCHARD
function getxml() {
  global $testLib;
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZMORE' lib='xyzlibxmlservicexyz'>
 <parm co='a' io='both'>
   <data type='64A' var='INCHARA'>xyzINCHARA</data>
 </parm>
 <parm co='b' io='both'>
   <data type='32000A' var='INCHARB'>xyzINCHARB</data>
 </parm>
 <parm co='c' io='both'>
   <data type='32000A' var='INCHARC'>xyzINCHARC</data>
 </parm>
 <parm co='d' io='both'>
   <data type='4A' var='INCHARD'>xyzINCHARD</data>
 </parm>
</pgm>
</script>
ENDPROC;
$data = "";
for ($i=0;$i<32000;$i++) $data .= 'F0';
$was = array(
"xyzlibxmlservicexyz",
"xyzINCHARA",
"xyzINCHARB",
"xyzINCHARC",
"xyzINCHARD"
);
$now = array(
"$testLib",
substr($data,0,64),
substr($data,0,32000),
substr($data,0,32000),
substr($data,0,4)
);
$xml = str_replace($was,$now,$clob);
return $xml;
}
?>
--EXPECTF--
%s
Success (%s)

