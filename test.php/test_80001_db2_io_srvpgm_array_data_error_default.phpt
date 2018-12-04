--TEST--
XML i Toolkit: IBM_DB2 srvpgm error bad array element error default
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

// check if good
if (strpos($clobOut,'<report>')<1) die("Missing error <report>\n");
if (strpos($clobOut,'<error>')<1) die("Missing error <error>\n");
if (strpos($clobOut,"<joblogscan>")<1) die("Missing <joblogscan>\n");
if (strpos($clobOut,'<joblog')<1) die("Missing error <joblog>\n");
if (strpos($clobOut,'baddata')<1) die("Missing error baddata\n");

echo "Success\n";

//     D ARRAYMAX        c                   const(999)
//     D dcRec_t         ds                  qualified based(Template)
//     D  dcMyName                     10A
//     D  dcMyJob                    4096A
//     D  dcMyRank                     10i 0
//     D  dcMyPay                      12p 2
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zzarray: check return array aggregate 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzarray         B                   export
//     D zzarray         PI                  likeds(dcRec_t) dim(ARRAYMAX)
//     D  myName                       10A
//     D  myMax                        10i 0
//     D  myCount                      10i 0
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZARRAY'>
 <parm comment='ok data'>
  <data var='myName' type='10A'>1282635</data>
 </parm>
 <parm  comment='bad data'>
  <data var='myMax' type='10i0'>baddata</data>
 </parm>
 <parm  comment='bad data'>
  <data var='myCount' type='10i0' enddo='mycount'>baddata</data>
 </parm>
 <return>
  <ds var='dcRec_t' dim='10' dou='mycount' comment='bad data'>
    <data var='dcMyName' type='10A'>na</data>
    <data var='dcMyJob' type='4096A'>na</data>
    <data var='dcMyRank' type='10i0'>baddata</data>
    <data var='dcMyPay' type='12p2'>baddata</data>
  </ds>
 </return>
</pgm>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success

