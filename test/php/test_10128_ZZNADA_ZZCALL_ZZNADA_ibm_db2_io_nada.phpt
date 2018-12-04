--TEST--
XML i Toolkit: IBM_DB2 inout SRVPGM - RPG no parm and no return
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
echo "my ipc is $ipc ... \n";
for ($i=0; $i<3; $i++) {
  switch($i) {
  case 0:
    echo "Call ZZNADA ... \n";
    $clobIn = getxml1(); // XML in
    break;
  case 1:
    echo "Call ZZCALL ... \n";
    $clobIn = getxml2(); // XML in
    break;
  case 2:
    echo "Call ZZNADA ... \n";
    $clobIn = getxml1(); // XML in
    break;
  default:
    die("loop bad");
    break;
  }
  $clobOut = "";      // XML out
  $ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
  $ret=db2_execute($stmt);
  if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
  // dump XML out
  var_dump($clobOut);
  // XML check
  $xmlobj = simplexml_load_string($clobOut);
  if (!$xmlobj) die("Bad XML returned\n");
  // check raw XML no error?
  if (strlen(trim($clobOut))<1 || strpos($clobOut,"error")>0) die("Fail\n");
}
echo "Success\n";
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zznada: check no parms 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zznada          B                   export
//     D zznada          PI
function getxml1() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZNADA'>
</pgm>
ENDPROC;
return test_lib_replace($clob);
}
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zznada: check no parms 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zznada          B                   export
//     D zznada          PI
function getxml2() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZCALL' lib='xyzlibxmlservicexyz'>
 <parm  io='both'>
   <data type='1A' var='INCHARA'>a</data>
 </parm>
 <parm  io='both'>
   <data type='1A' var='INCHARB'>b</data>
 </parm>
 <parm  io='both'>
   <data type='7p4' var='INDEC1'>11.1111</data>
 </parm>
 <parm  io='both'>
   <data type='12p2' var='INDEC2'>222.22</data>
 </parm>
 <parm  io='both'>
  <ds>
   <data type='1A' var='INDS1.DSCHARA'>x</data>
   <data type='1A' var='INDS1.DSCHARB'>y</data>
   <data type='7p4' var='INDS1.DSDEC1'>66.6666</data>
   <data type='12p2' var='INDS1.DSDEC2'>77777.77</data>
  </ds>
 </parm>
 <return>
  <data type='10i0'>0</data>
 </return>
</pgm>
</script>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success

