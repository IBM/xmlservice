--TEST--
XML i Toolkit: IBM_DB2 inout multi sys api - QSNDDTAQ/QRCVDTAQ data queues
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG65K(?,?,?,?)");
if (!$stmt) die("Fail prepare: ".db2_stmt_errormsg());
$clobIn = getxml();
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
if (!$xmlobj) die("Fail XML returned\n");
// -----------------
// output cmd call
// -----------------
$allcmds = $xmlobj->xpath('/script/cmd');
if (!$allcmds) die("Fail XML cmd missing\n");
if (count($allcmds) != 3) die("Fail XML not return 3 CMD records\n");
// -----------------
// output pgm call
// -----------------
$allpgms = $xmlobj->xpath('/script/pgm');
if (!$allpgms) die("Fail XML pgm missing\n");
if (count($allpgms) != 2) die("Fail XML not return 2 PGM records\n");
$expect = "System i data queues forever";
if (strpos($clobOut,$expect)<1) die("XML data missing ($expect)");

// good
echo "Success (data queue script)\n";


// work data queues
// CMD: dltdtaq,crtdtaq
// PGM: Send Data Queue (QSNDDTAQ) API
// 1 Data queue name     Input Char(10)
// 2 Library name        Input Char(10)
// 3 Length of data      Input Packed(5,0)
// 4 Data Input Char(*)  Input
// PGM: Receive Data Queue (QRCVDTAQ) API
// 1 Data queue name  Input Char(10)
// 2 Library name     Input Char(10)
// 3 Length of data   Input Packed(5,0)
// 4 Data Char(*)     Output
// 5 Wait time        Input Packed(5,0)
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<comment>
***************************************
* recreate the data queue
***************************************
</comment>
<cmd comment='dltdtaq MYDATAQ'>DLTDTAQ DTAQ(xyzlibxmlservicexyz/MYDATAQ)</cmd>
<cmd comment='crtdtaq MYDATAQ'>CRTDTAQ DTAQ(xyzlibxmlservicexyz/MYDATAQ) MAXLEN(100) AUT(*EXCLUDE)</cmd>
<comment>
***************************************
* Send Data Queue (QSNDDTAQ) API
***************************************
* 1 Data queue name     Input Char(10)
* 2 Library name        Input Char(10)
* 3 Length of data      Input Packed(5,0)
* 4 Data Input Char(*)  Input
</comment>
<pgm name='QSNDDTAQ'>
 <parm io='in'>
   <data type='10A'>MYDATAQ</data>
 </parm>
 <parm  io='in'>
   <data type='10A'>xyzlibxmlservicexyz</data>
 </parm>
 <parm  io='in'>
   <data type='5p0'>50</data>
 </parm>
 <parm  io='in'>
   <data type='100A'>System i data queues forever</data>
 </parm>
</pgm>
<comment>
***************************************
* Receive Data Queue (QRCVDTAQ) API
***************************************
* 1 Data queue name  Input Char(10)
* 2 Library name     Input Char(10)
* 3 Length of data   Input Packed(5,0)
* 4 Data Char(*)     Output
* 5 Wait time        Input Packed(5,0)
</comment>
<pgm name='QRCVDTAQ'>
 <parm  io='in'>
   <data type='10A'>MYDATAQ</data>
 </parm>
 <parm  io='in'>
   <data type='10A'>xyzlibxmlservicexyz</data>
 </parm>
 <parm  io='in'>
   <data type='5p0'>50</data>
 </parm>
 <parm io='out'>
   <data type='100A'>bad stuff here</data>
 </parm>
 <parm  comment='wait' io='in'>
   <data type='5p0'>0</data>
 </parm>
</pgm>
<cmd comment='dltdtaq MYDATAQ'>DLTDTAQ DTAQ(xyzlibxmlservicexyz/MYDATAQ)</cmd>
</script>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success (%s)

