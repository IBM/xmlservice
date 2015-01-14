--TEST--
XML i Toolkit: IBM_DB2 inout sys api - QWCRSSTS missing xml values
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
// var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Fail XML returned\n");
// -----------------
// output pgm call
// -----------------
$allpgms = $xmlobj->xpath('/script/pgm');
if (!$allpgms) die("Fail XML pgm missing\n");
$pgm = $allpgms[0];
$name = $pgm->attributes()->name;
$lib = $pgm->attributes()->lib;
// pgm parms
$parm = $pgm->xpath('parm');
if (!$parm) die("Missing XML pgm parms ($name)");
// parm data structure Format SSTS0100
$ds = $parm[0]->ds;
$count = 0;
foreach($ds->data as $data) {
  echo $data->attributes()->comment.": ".(string)$data."\n";
  $count++;
}
if ($count <> 18) die("Fail XML Format SSTS0100");
// parm data structure Format ERRC0100
$ds = $parm[1]->ds;
$count = 0;
foreach($ds->data as $data) {
  echo $data->attributes()->comment.": ".(string)$data."\n";
  $count++;
}
if ($count <> 5) die("Fail XML Format ERRC0100");

// good
echo "Success ($lib/$name)\n";

// QWCRSSTS
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0' encoding='ISO-8859-1'?>
<script>
<pgm name='QWCRSSTS' lib='QSYS'>
 <parm io='both'>
  <ds>
   <data type='10i0' var='BYTES' comment='BYTES'>0</data>
   <data type='10i0' var='RET' comment='RET'>1</data>
   <data type='8B' var='DATE_TIME' comment='DATE_TIME'></data>
   <data type='8A' var='SYSTEM' comment='SYSTEM'></data>
   <data type='10i0' var='USERS' comment='USERS'>0</data>
   <data type='10i0' var='DIS_USERS' comment='DIS_USERS'>0</data>
   <data type='10i0' var='SUSP_JOBS' comment='SUSP_JOBS'>0</data>
   <data type='10i0' var='JB_GP_SUSP' comment='JB_GP_SUSP'>0</data>
   <data type='10i0' var='USER_SIGNED_PRINT_WAIT' comment='USER_SIGNED_PRINT_WAIT'>0</data>
   <data type='10i0' var='MSG_WAIT' comment='MSG_WAIT'>0</data>
   <data type='10i0' var='BATCH_JOBS' comment='BATCH_JOBS'>0</data>
   <data type='10i0' var='HELD_BATCH' comment='HELD_BATCH'>0</data>
   <data type='10i0' var='END_BATCH' comment='END_BATCH'>0</data>
   <data type='10i0' var='WAITING_BATCH' comment='WAITING_BATCH'>0</data>
   <data type='10i0' var='BATCH_HELD_ON_QUE' comment='BATCH_HELD_ON_QUE'>0</data>
   <data type='10i0' var='BATCH_ON_HELD_QUE' comment='BATCH_ON_HELD_QUE'>0</data>
   <data type='10i0' var='UNASGN_BATCH' comment='UNASGN_BATCH'>0</data>
   <data type='10i0' var='BATCH_WAIT_PRINT' comment='BATCH_WAIT_PRINT'>0</data>
  </ds> 
 </parm>
 <parm comment='LEN' io='in'>
  <data type='10i0' var='LEN' >148</data>  		  
 </parm>
 <parm comment='FORMAT' io='in'> 			
  <data type='8A' var='FORMAT' >SSTS0100</data>  		  
 </parm>
 <parm comment='RESET' io='in'> 			
  <data type='10A' var='RESET' >*YES</data>  		  
 </parm>
 <parm io='both'>
  <ds>
   <data type='10i0' var='provided' comment='provided'>0</data>
   <data type='10i0' var='available' comment='available'>0</data>
   <data type='7A' var='Exception' comment='Exception'></data>
   <data type='1A' var='reserved' comment='reserved'></data>
   <data type='10A' var='data' comment='data'></data>
  </ds> 
 </parm>
</pgm>
</script>
ENDPROC;
return $clob;
}
?>
--EXPECTF--
%s
Success (%s)

