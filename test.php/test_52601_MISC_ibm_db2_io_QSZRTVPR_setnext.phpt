--TEST--
XML i Toolkit: IBM_DB2 inout sys api setnext - QSZRTVPR prod info
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
$stmt = db2_prepare($conn, "call ".$procLib.".iPLUG512K(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
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

if (strpos($clobOut, "QSYSNLS")<1) dies ("Failed missing QSYSNLS\n");

echo "\nSuccess\n"; 

function getxml() {
$clob = <<<ENDPROC
<?xml version="1.0"?>
<script>
<pgm name='QSZRTVPR'>
 <parm io="both" comment='Receiver variable'>
  <ds comment='PRDR0200 Format' len='rec1'>
   <data type='10i0' comment='Bytes returned'>0</data>
   <data type='10i0' comment='Bytes available' >0</data>
   <data type='10i0' comment='Reserved'>0</data>
   <data type='7A' comment='Product ID'> </data>
   <data type='6A' comment='Release level'> </data>
   <data type='4A' comment='Product option'> </data>
   <data type='4A' comment='Load ID'> </data>
   <data type='10A' comment='Load type'> </data>
   <data type='10A' comment='Symbolic load state'> </data>
   <data type='10A' comment='Load error indicator'> </data>
   <data type='2A' comment='Load state'> </data>
   <data type='1A' comment='Supported flag'> </data>
   <data type='2A' comment='Registration type'> </data>
   <data type='14A' comment='Registration value'> </data>
   <data type='2A' comment='Reserved'> </data>
   <data type='10i0' offset='myOffset' comment='beyond size of PRDR0100'></data>
   <data type='4A' comment='Primary language load identifier'> </data>
   <data type='6A' comment='Minimum target release'> </data>
   <data type='6A' comment='Minimum VRM of *BASE required'> </data>
   <data type='1A' comment='Requirements met between base'> </data>
   <data type='3A' comment='Level'> </data>
   <data type='2048h' comment='leave some space for PRDR0200'/>
 </ds>   
</parm>   
 <parm  comment='Length of receiver variable'>
   <data type='10i0' setlen='rec1'>0</data>
 </parm>
 <parm  comment='Format name'>
   <data type='8A'>PRDR0200</data>
 </parm>
 <parm  comment='Product information'>
   <data type='100A'>*OPSYS *CUR  0021*CODE</data>
 </parm>
 <parm  io="both" comment='Error code'>
  <ds comment='Format ERRC0100' len='rec2'>
   <data type='10i0' comment='Bytes returned'>0</data>
   <data type='10i0' comment='Bytes available' setlen='rec2'>0</data>
   <data type='7A' comment='Exception ID'> </data>
   <data type='1A' comment='Reserved'> </data>
  </ds>
 </parm>
 
 <overlay io="out" top="1" offset='myOffset'>  
 <ds>
  <data type='10A' comment='Second language library'></data>
  <data type='2A' comment='Reserved'></data>
  <data type='10i0' enddo='prim' comment='Number of Primary languages'></data>
  <data type='10i0' offset="myOffset2" comment='Offset to library records'></data>
 </ds>
 </overlay>  

 <overlay io="out" top="1" offset="myOffset2" dim='10' dou='prim' setnext='nextoff'>
 <ds>
  <data type='10i0' next='nextoff' comment='Offset to next library record'></data>
  <data type='10A' comment='Primary library name'></data>
  <data type='10A' comment='Installed library name'></data>
  <data type='10A' comment='Library type'></data>
  <data type='10A' comment='Library authority'></data>
  <data type='10A' comment='Library create authority'></data>
  <data type='10A' comment='Postoperation exit program name'></data>
  <data type='10i0' comment='Number of preoperation exit program names'></data>
  <data type='10A' comment='Preoperation exit program names'></data>
 </ds>
 </overlay> 
  
</pgm>
</script>
ENDPROC;
return $clob;
}
?>
--EXPECTF--
%s
Success

