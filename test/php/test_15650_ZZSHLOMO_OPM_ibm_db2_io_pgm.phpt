--TEST--
XML i Toolkit: IBM_DB2 inout PGM OPM CLP - ZZSHLOMO CLP test
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
$mode = $pgm->attributes()->mode;
// pgm parms
$parm = $pgm->xpath('parm');
if (!$parm) die("Missing XML pgm parms ($lib/$name $mode)");
if ((string)$parm[0]->data != "I am 15") die("1) not 'I am 15'");
if ((string)$parm[1]->data != 12.2) die("2) not '12.2'");
if ((string)$parm[2]->data != "ALAN HOW ARE YOU TEST one of one") die("3) not 'ALAN HOW ARE YOU TEST one of one'");

// good
echo "Success ($lib/$name $mode)\n";

//PGM PARM(&CHAR1 &NUM2 &RTNVAL)                                 
//      DCL VAR(&CHAR1) TYPE(*CHAR) LEN(15)                            
//      DCL VAR(&NUM1) TYPE(*DEC) LEN(10)                              
//      DCL VAR(&NUM2) TYPE(*CHAR) LEN(10)                             
//      DCL VAR(&RTNVAL) TYPE(*CHAR) LEN(100)                          
//      CHGVAR VAR(&CHAR1) VALUE('I am 15')             
//      CHGVAR VAR(&NUM2) VALUE(12.2)             
//      CHGVAR VAR(&RTNVAL) VALUE('ALAN HOW ARE YOU TEST one of one')  
// ENDPGM: +                                                           
//     ENDPGM                                                         
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm mode='opm' name='ZZSHLOMO' lib='xyzlibxmlservicexyz'>
<parm io='both'>
<data type='15A'>frog</data>           
</parm>
<parm io='both'>
<data type='10A'>12.2</data>           
</parm>
<parm io='both'>
<data type='100A'>dude</data>           
</parm>
</pgm>
</script>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success (%s)

