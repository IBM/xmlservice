--TEST--
XML i Toolkit: IBM_DB2 inout sys api - QSZRTVPR prod info
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
// pgm parms
$parm = $pgm->xpath('parm');
if (!$parm) die("Missing XML pgm parms ($name)");
// parm data structure Format PRDR0100
$ds = $parm[0]->ds;
$count = 0;
foreach($ds->data as $data) {
  echo $data->attributes()->comment.": ".(string)$data."\n";
  $count++;
}
if ($count <> 22) die("Fail XML Format PRDR0100");
// parm data structure Format ERRC0100
$ds = $parm[1]->ds;
$count = 0;
foreach($ds->data as $data) {
  echo $data->attributes()->comment.": ".(string)$data."\n";
  $count++;
}
if ($count <> 4) die("Fail XML Format ERRC0100");

// good
echo "Success ($name)\n";

/*
***************************************
* QSZRTVPR prod info
***************************************
* QSZRTVPR
* 1 Receiver variable            Output Char(*)
* 2 Length of receiver variable  Input  Binary(4)
* 3 Format name                  Input  Char(8)
* 4 Product information          Input  Char(*)
* 5 Error code                   I/O    Char(*)
*
* PRDR0100 Format
* 0   0   BINARY(4)  Bytes returned
* 4   4   BINARY(4)  Bytes available
* 8   8   BINARY(4)  Reserved
* 12  C   CHAR(7)    Product ID
* 19  13  CHAR(6)    Release level
* 25  19  CHAR(4)    Product option
* 29  1D  CHAR(4)    Load ID
* 33  21  CHAR(10)   Load type
* 43  2B  CHAR(10)   Symbolic load state
* 53  35  CHAR(10)   Load error indicator
* 63  3F  CHAR(2)    Load state
* 65  41  CHAR(1)    Supported flag
* 66  42  CHAR(2)    Registration type
* 68  44  CHAR(14)   Registration value
* 82  52  CHAR(2)    Reserved
* 84  54  BINARY(4)  Offset to additional information
* 88  58  CHAR(4)    Primary language load identifier
* 92  5C  CHAR(6)    Minimum target release
* 98  62  CHAR(6)    Minimum VRM of *BASE required
* 104 68  CHAR(1)    Requirements met between base
* 105 69  CHAR(3)    Level
* 108 6C  CHAR(*)    Reserved
*
* Format ERRC0100 for the error code
* 0 0 INPUT BINARY(4) Bytes provided
* 4 4 OUTPUT BINARY(4) Bytes available
* 8 8 OUTPUT CHAR(7) Exception ID
* 15 F OUTPUT CHAR(1) Reserved
*/
function getxml() {
$clob = <<<ENDPROC
<?xml version="1.0"?>
<script>
<pgm name='QSZRTVPR'>
 <parm io="out" comment='Receiver variable'>
  <ds comment='PRDR0100 Format' len='rec1'>
   <data type='10i0' comment='Bytes returned'>0</data>
   <data type='10i0' comment='Bytes available'>0</data>
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
   <data type='10i0' comment='Offset to additional information'>0</data>
   <data type='4A' comment='Primary language load identifier'> </data>
   <data type='6A' comment='Minimum target release'> </data>
   <data type='6A' comment='Minimum VRM of *BASE required'> </data>
   <data type='1A' comment='Requirements met between base'> </data>
   <data type='3A' comment='Level'> </data>
   <data type='5A' comment='pad'> </data>
  </ds>
 </parm>
 <parm  io="in" comment='Length of receiver variable'>
   <data type='10i0' setlen='rec1'>8</data>
 </parm>
 <parm  io="in" comment='Format name'>
   <data type='8A'>PRDR0100</data>
 </parm>
 <parm  io="in" comment='Product information'>
   <data type='100A'>*OPSYS *CUR  0033*CODE</data>
 </parm>
 <parm  io="both" comment='Error code'>
  <ds comment='Format ERRC0100' len='rec2'>
   <data type='10i0' comment='Bytes returned'>0</data>
   <data type='10i0' comment='Bytes available' setlen='rec2'>0</data>
   <data type='7A' comment='Exception ID'> </data>
   <data type='1A' comment='Reserved'> </data>
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


