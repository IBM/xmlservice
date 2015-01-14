--TEST--
XML i Toolkit: ibm_db2 result set SRVPGM - binary data
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
// -----------------
// output pgm call
// -----------------
// only one program this XML script
$pgm = $allpgms[0];
$name = $pgm->attributes()->name;
$lib  = $pgm->attributes()->lib;
$func = $pgm->attributes()->func;
// pgm parms
$parm = $pgm->xpath('parm');
if (!$parm) die("Fail XML pgm parms missing ($lib/$name.$func)\n");
$var  = $parm[0]->data->attributes()->var;
$actual = (string)$parm[0]->data;
$expect='A1A2A3A4A5A6A7A8A9AAA1A2A3A4A5A6A7A8A9AA';
if ($actual != $expect) die("parm: $var ($actual not $expect) ($lib/$name.$func)\n");
// pgm data returned
$retn = $pgm->xpath('return');
if (!$retn) die("Fail XML pgm return missing ($lib/$name.$func)\n");
$var  = $retn[0]->data->attributes()->var;
$actual = (string)$retn[0]->data;
$expect='A1A2A3A4A5A6A7A8A9AAA1A2A3A4A5A6A7A8A9AA';
if ($actual != $expect) die("return: $var ($actual not $expect) ($lib/$name.$func)\n");

// good
echo "Success ($lib/$name.$func)\n";

//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zzbinary: check return binary 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzbinary        B                   export
//     D zzbinary        PI            20A
//     D  myBinary                     20A
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZBINARY'>
 <parm comment='binary data'>
  <data var='myBinary' type='20B'>A1A2A3A4A5A6A7A8A9AAA1A2A3A4A5A6A7A8A9AA</data>
 </parm>
 <return>
  <data var='myBinRet' type='20B'>F1F2F3F4F5F6F7F8F9FAF1F2F3F4F5F6F7F8F9FA</data>
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

