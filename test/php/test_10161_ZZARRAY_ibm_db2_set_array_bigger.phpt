--TEST--
XML i Toolkit: IBM_DB2 result set SRVPGM - really big data
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
if (!$conn) die("Bad connect: $database,$user");
$stmt = db2_prepare($conn, "call $procLib.iPLUGR1M(?,?,?)");
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
$myName1 = 'Ranger';  // expected name
$myMax1  = 212;       // expected max
$myCount1= 212;       // expected count
$size = strlen($clobOut);
echo substr($clobOut,$size-400)."\n";
if ($size < 917000) die("Failed ($size < 917000)\n");
for ($i=0;$i<$myCount1;$i++) {
  // DS records expected
  $irpg     = $i+1;
  $dcMyName = ">".$myName1.$irpg."<";
  if (strpos($clobOut,$dcMyName)<1) die("Fail dcMyName $dcMyName missing\n");
  $dcMyRank = ">".(10+$irpg)."<";
  if (strpos($clobOut,$dcMyRank)<1) die("Fail dcMyRank $dcMyRank missing\n");
  $dcMyPay  = ">".sprintf("%1.2f", 13.42*$irpg)."<";
  if (strpos($clobOut,$dcMyPay)<1) die("Fail dcMyPay $dcMyPay missing\n");
}
// good
echo "Success ($size)\n";

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
<script>
<cmd comment='addlible'>ADDLIBLE LIB(xyzlibxmlservicexyz) POSITION(*FIRST)</cmd>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZARRAY'>
 <parm comment='search this name'>
  <data var='myName' type='10A'>Ranger</data>
 </parm>
 <parm comment='max allowed return'>
  <data var='myMax' type='10i0'>212</data>
 </parm>
 <parm comment='actual count returned'>
  <data var='myCount' type='10i0' enddo='mycount'>0</data>
 </parm>
 <return>
  <ds var='dcRec_t' dim='999' dou='mycount'>
    <data var='dcMyName' type='10A'>na</data>
    <data var='dcMyJob' type='4096A'>na</data>
    <data var='dcMyRank' type='10i0'>0</data>
    <data var='dcMyPay' type='12p2'>0.0</data>
  </ds>
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

