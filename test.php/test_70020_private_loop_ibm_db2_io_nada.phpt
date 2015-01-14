--TEST--
XML i Toolkit: IBM_DB2 inout -- loop private start/stop
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
$loopme = 100;
$ctlsave = $ctl;

// call IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");

for ($i=0;$i<$loopme;$i++) {
 for ($j=0;$j<2;$j++) {

  if (!$j) $ctl = $ctlsave; // start up
  else $ctl = "*immed"; // end immed

  $stmt = db2_prepare($conn, "call $procLib.iPLUG4K(?,?,?,?)");
  if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
  $clobIn = getxml(); // XML in
  $clobOut = "";      // XML out
  $ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
  $ret=db2_execute($stmt);
  if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
  // check raw XML no error?
  if (strpos($clobOut,"error")>0) {
    var_dump($clobOut);
    die("Fail\n");
  }
  else echo "$i) Success($ctl)\n";

 }
}
echo "Success\n";
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zznada: check no parms 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zznada          B                   export
//     D zznada          PI
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZNADA'>
<parm>
<ds comment='silly' />
</parm>
</pgm>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success

