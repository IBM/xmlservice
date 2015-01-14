--TEST--
XML i Toolkit: IBM_DB2 inout SRVPGM - DS records returned
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
// -----------------
// output pgm call
// -----------------
$myName1 = 'Ranger';  // expected name
$myMax1  = 5;         // expected max
$myCount1= 5;         // expected count
$allpgms = $xmlobj->xpath('/script/pgm');
if (!$allpgms) die("Fail XML pgm missing\n");
$pgm  = $allpgms[0];
$name = $pgm->attributes()->name;
$lib  = $pgm->attributes()->lib;
$func = $pgm->attributes()->func;
// pgm parms
$parm = $pgm->xpath('parm');
if (!$parm) die("Fail XML pgm parms missing ($lib/$name.$func)\n");
$myName = (string)$parm[0]->data;
$myMax  = (string)$parm[1]->data;
$myCount= (string)$parm[2]->data;
if ($myName != $myName1) die("Fail myName ($myName not $myName1) ($lib/$name.$func)\n");
if ($myMax != $myMax1) die("Fail (myMax $myMax not $myMax1) ($lib/$name.$func)\n");
if ($myCount != $myCount1) die("Fail myCount ($myCount not $myCount1) ($lib/$name.$func)\n");
// pgm data structure returned dim(999)
$retn = $pgm->xpath('return');
if (!$retn) die("Fail XML pgm return missing ($lib/$name.$func)\n");
$dsret = $retn[0]->ds; // DS records returned
if (count($dsret) != $myCount) {
  die("Fail XML pgm not return $myCount DS records ($lib/$name.$func)\n");
}
$AAAs = "";
for ($j=0;$j<4095;$j++) $AAAs .= "A";
$i=0; // DS records
foreach($dsret as $ds) {
  // DS records expected
  $irpg     = $i+1;
  $dcMyName = $myName1.$irpg;
  if ($myMax > 10) $dcMyJob = $AAAs;
  else             $dcMyJob = "Test 10".$irpg;
  $dcMyRank = 10+$irpg;
  $dcMyPay  = sprintf("%1.2f", 13.42*$irpg);
  $data1 = array($dcMyName,$dcMyJob,$dcMyRank,$dcMyPay);
  // DS data elements
  for ($j=0;$j<4;$j++) {
    $var    = $ds->data[$j]->attributes()->var;
    $actual = (string)$ds->data[$j];
    $expect = $data1[$j];
    if ((string)$actual != $expect) {
      die("Fail dcRec_t[$i].$var ($actual != $expect) ($lib/$name.$func)\n");
    }
  }
  $i++;
}

// good
echo "Success ($lib/$name.$func)\n";

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
  <data var='myMax' type='10i0'>5</data>
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

