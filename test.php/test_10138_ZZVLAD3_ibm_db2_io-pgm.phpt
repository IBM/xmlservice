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


//     d MyErrorDs       ds                  qualified based(Template)
//     d  ErrorId                       8a
//     d  Severity                      3u 0
//     d  Description                  80a
//     d ErrorParm       ds                  likeds(MyErrorDs) dim(20)
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * main(): Control flow
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     C     *Entry        PLIST                   
//     C                   PARM                    ErrorParm
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZVLAD3' lib='xyzlibxmlservicexyz'>
<parm io='in' dim='20' comment='init all'>
<ds var='MyErrorDs' comment='first data'>
<data type='8a' var='ErrorId'/>
<data type='3u0' var='Severity'/>
<data type='80a' var='Description'/>
</ds>
</parm>
<overlay io='both' top='on' comment='set any number messages'>
<ds var='MyErrorDs' comment='first data'>
<data type='8a' var='ErrorId'>12345678</data>
<data type='3u0' var='Severity'>1</data>
<data type='80a' var='Description'>Toad wrangler</data>
</ds>
<ds var='MyErrorDs' comment='right behind first'>
<data type='8a' var='ErrorId'>87654321</data>
<data type='3u0' var='Severity'>3</data>
<data type='80a' var='Description'>Frog wrangler</data>
</ds>
</overlay>
</pgm>
</script>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success (%s)

