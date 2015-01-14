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
$stmt = db2_prepare($conn, "call $procLib.iPLUG15M(?,?,?,?)");
if (!$stmt) die("Fail prepare: ".db2_stmt_errormsg());
$max = 900;
$clobIn = getxml($max);
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
// var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Fail XML returned\n");
// -----------------
// output pgm call
// -----------------
$myName1 = 'Ranger';  // expected name
$myMax1  = $max;         // expected max
$myCount1= $max;         // expected count
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
$i = 1;
$dsret = (string) $retn[0]->records; // DS records returned
for ($tok = strtok($dsret, ":"); $tok !== false; $tok = strtok(":")) {
  switch($i++) {
  case 1:
    if (strpos($tok,$i)<1) echo "$tok ";
    else die("Missing $i in $tok\n");
    break;
  case 2:
    if (strpos($tok,"AAA")>-1) echo substr($tok,0,40)."... ";
    else die("Missing AAA in $tok\n");
    break;
  case 3:
    echo "$tok ";
    break;
  case 4:
    $i = 1;
    echo "$tok\n";
    break;
  default:
    break;
  }
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
function getxml($max) {
$clob .= "<?xml version='1.0'?>\n";
$clob .= "<script>\n";
$clob .= "<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZARRAY'>\n";
$clob .= " <parm comment='search this name'>\n";
$clob .= "  <data var='myName' type='10A'>Ranger</data>\n";
$clob .= " </parm>\n";
$clob .= " <parm comment='max allowed return'>\n";
$clob .= "  <data var='myMax' type='10i0'>$max</data>\n";
$clob .= " </parm>\n";
$clob .= " <parm comment='actual count returned'>\n";
$clob .= "  <data var='myCount' type='10i0' enddo='mycount'>0</data>\n";
$clob .= " </parm>\n";
$clob .= " <return>\n";
$clob .= "  <ds var='dcRec_t' dim='$max' dou='mycount' data='records'>\n";
$clob .= "    <data var='dcMyName' type='10A'>na</data>\n";
$clob .= "    <data var='dcMyJob' type='4096A'>na</data>\n";
$clob .= "    <data var='dcMyRank' type='10i0'>0</data>\n";
$clob .= "    <data var='dcMyPay' type='12p2'>0.0</data>\n";
$clob .= "  </ds>\n";
$clob .= "<records delimit=':'>";
for ($i=0; $i<$max; $i++) $clob .= ":nada{$i}:nada{$i}:1:1.1";
$clob .= ":</records>";
$clob .= " </return>\n";
$clob .= "</pgm>\n";
$clob .= "</script>\n";
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success (%s)

