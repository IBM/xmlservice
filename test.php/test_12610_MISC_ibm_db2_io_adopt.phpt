--TEST--
XML i Toolkit: IBM_DB2 inout multi sys api - adopt profile
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

$ctl = "*here";
$newProfile = QSYGETPH($adoptuser1,$adoptpass1);
$oldProfile = QSYGETPH();
QWTSETP($newProfile);
diag();
QWTSETP($oldProfile);
diag();
QSYRLSPH($newProfile);
QSYRLSPH($oldProfile);

// good
echo "Success (adopt)\n";

// call IBM i
function callme ($xmlIn) {
  global $procLib, $conn, $ipc, $ctl;
  $stmt = db2_prepare($conn, "call $procLib.iPLUG65K(?,?,?,?)");
  if (!$stmt) die("Fail prepare: ".db2_stmt_errormsg());
  $clobIn = $xmlIn;
  $clobOut = "";
  $ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
  $ret=db2_execute($stmt);
  if (!$ret) die("Fail execute: ".db2_stmt_errormsg());
  return $clobOut;
}
// diag check 00000003979133CD36843001
function diag() {
 $xmlIn  = "<?xml version='1.0'?>\n";
 $xmlIn .= "<script>\n";
 $xmlIn .= "<diag/>\n";
 $xmlIn .= "</script>";
 $clobOut = callme ($xmlIn);
 var_dump($clobOut);
 $xmlobj = simplexml_load_string($clobOut);
 if (!$xmlobj) die("Fail XML returned\n");
 $allparms = $xmlobj->xpath('/script/diag/jobinfo/curuser');
 if (!$allparms) die("Fail XML diag missing\n");
 var_dump($allparms);
}

// Get Profile Handle (QSYGETPH) API
function QSYGETPH($user="*CURRENT",$pwd="*NOPWD") {
 $xmlIn  = "<?xml version='1.0'?>\n";
 $xmlIn .= "<script>\n";
 $xmlIn .= "<pgm name='QSYGETPH'>\n";
 $xmlIn .= "<parm io='in'><data type='10A'>$user</data></parm>\n";
 $xmlIn .= "<parm io='in'><data type='10A'>$pwd</data></parm>\n";
 $xmlIn .= "<parm io='out'><data type='12b'/></parm>\n";
 $xmlIn .= "<parm io='in'><data type='10i0'>0</data></parm>\n";
 if (substr($pwd, 0, 1) != '*') {
   $xmlIn .= "<parm io='in'><data type='10i0'>".strlen($pwd)."</data></parm>\n";
   $xmlIn .= "<parm io='in'><data type='10i0'>-1</data></parm>\n";
 }
 $xmlIn .= "</pgm>\n";
 $xmlIn .= "</script>";
 // var_dump($xmlIn);
 $clobOut = callme ($xmlIn);
 // var_dump($clobOut);
 $xmlobj = simplexml_load_string($clobOut);
 if (!$xmlobj) die("Fail XML returned\n");
 $allparms = $xmlobj->xpath('/script/pgm/parm');
 if (!$allparms) die("Fail XML parm missing\n");
 $profile = (string)$allparms[0]->data;
 if (!$profile) die("Fail XML profile missing\n");
 return $profile;
}
// Set Profile Handle (QWTSETP, QsySetToProfileHandle) API
function QWTSETP($profile) {
 $xmlIn  = "<?xml version='1.0'?>\n";
 $xmlIn .= "<script>\n";
 $xmlIn .= "<pgm name='QWTSETP'>\n";
 $xmlIn .= "<parm io='in'><data type='12b'>$profile</data></parm>\n";
 $xmlIn .= "<parm io='in'><data type='10i0'>0</data></parm>\n";
 $xmlIn .= "</pgm>\n";
 $xmlIn .= "</script>";
 // var_dump($xmlIn);
 $clobOut = callme ($xmlIn);
 // var_dump($clobOut);
 $xmlobj = simplexml_load_string($clobOut);
 if (!$xmlobj) die("Fail XML returned\n");
}
// Release Profile Handle (QSYRLSPH, QsyReleaseProfileHandle) API
function QSYRLSPH($profile) {
 $xmlIn  = "<?xml version='1.0'?>\n";
 $xmlIn .= "<script>\n";
 $xmlIn .= "<pgm name='QSYRLSPH'>\n";
 $xmlIn .= "<parm io='in'><data type='12b'>$profile</data></parm>\n";
 $xmlIn .= "</pgm>\n";
 $xmlIn .= "</script>";
 // var_dump($xmlIn);
 $clobOut = callme ($xmlIn);
 // var_dump($clobOut);
 $xmlobj = simplexml_load_string($clobOut);
 if (!$xmlobj) die("Fail XML returned\n");
}

?>
--EXPECTF--
%s
Success (%s)

