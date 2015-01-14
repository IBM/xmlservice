--TEST--
XML i Toolkit: IBM_DB2 inout PGM - many simple parms data
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
$ctl .= "*here";
$clobIn = getxml();
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
// -----------------
// output processing
// -----------------
// dump raw XML (easy test debug)
var_dump($clobOut);

// good
echo "Success\n";

//     D ZZSIMP        PR                  ExtPgm 
//     D  HEXHND                       64
//     D  DBID                          2
//     D  SPPGID                       10
//     D  SPOP01                        1
//     D  SPOP02                        1
//     D  SPOP03                        1
//     D  SPOP04                        1
//     D  SPOP05                        1
//     D  SPOP06                        1
//     D  SPOP07                        1
//     D  SPOP08                        1
//     D  SPOP09                        1
//     D  SPOP10                        1
//     D  SPOP11                        1
//     D  SPOP12                        1
//     D  SPOP13                        1
//     D  SPOP14                        1
//     D  SPOP15                        1
function getxml() {
  global $testLib;
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZSIMP' lib='xyzlibxmlservicexyz'>
 <parm co='HEXHND' io='both'>
   <data type='64A' var='HEXHND'>xyzHEXHND</data>
 </parm>
 <parm co='DBID' io='both'>
   <data type='2A' var='DBID'>xyzDBID</data>
 </parm>
 <parm co='SPPGID' io='both'>
   <data type='10A' var='SPPGID'>xyzSPPGID</data>
 </parm>
 <parm co='SPOP01' io='both'>
   <data type='1A' var='SPOP01'>xyzSPOP01</data>
 </parm>
 <parm co='SPOP02' io='both'>
   <data type='1A' var='SPOP02'>xyzSPOP02</data>
 </parm>
 <parm co='SPOP03' io='both'>
   <data type='1A' var='SPOP03'>xyzSPOP04</data>
 </parm>
 <parm co='SPOP04' io='both'>
   <data type='1A' var='SPOP04'>xyzSPOP05</data>
 </parm>
 <parm co='SPOP05' io='both'>
   <data type='1A' var='SPOP05'>xyzSPOP06</data>
 </parm>
 <parm co='SPOP06' io='both'>
   <data type='1A' var='SPOP06'>xyzSPOP07</data>
 </parm>
 <parm co='SPOP08' io='both'>
   <data type='1A' var='SPOP08'>xyzSPOP08</data>
 </parm>
 <parm co='SPOP09' io='both'>
   <data type='1A' var='SPOP09'>xyzSPOP09</data>
 </parm>
 <parm co='SPOP10' io='both'>
   <data type='1A' var='SPOP10'>xyzSPOP10</data>
 </parm>
 <parm co='SPOP11' io='both'>
   <data type='1A' var='SPOP11'>xyzSPOP11</data>
 </parm>
 <parm co='SPOP12' io='both'>
   <data type='1A' var='SPOP12'>xyzSPOP12</data>
 </parm>
 <parm co='SPOP13' io='both'>
   <data type='1A' var='SPOP13'>xyzSPOP13</data>
 </parm>
 <parm co='SPOP14' io='both'>
   <data type='1A' var='SPOP14'>xyzSPOP14</data>
 </parm>
 <parm co='SPOP15' io='both'>
   <data type='1A' var='SPOP15'>xyzSPOP15</data>
 </parm>
</pgm>
</script>
ENDPROC;
$data = "";
for ($i=0;$i<32000;$i++) $data .= 'F0';
//     D  HEXHND                       64
//     D  DBID                          2
//     D  SPPGID                       10
//     D  SPOP01                        1
//     D  SPOP02                        1
//     D  SPOP03                        1
//     D  SPOP04                        1
//     D  SPOP05                        1
//     D  SPOP06                        1
//     D  SPOP07                        1
//     D  SPOP08                        1
//     D  SPOP09                        1
//     D  SPOP10                        1
//     D  SPOP11                        1
//     D  SPOP12                        1
//     D  SPOP13                        1
//     D  SPOP14                        1
//     D  SPOP15                        1
$was = array(
"xyzlibxmlservicexyz",
"xyzHEXHND",
"xyzDBID",
"xyzSPPGID",
"xyzSPOP01",
"xyzSPOP02",
"xyzSPOP03",
"xyzSPOP04",
"xyzSPOP05",
"xyzSPOP06",
"xyzSPOP07",
"xyzSPOP08",
"xyzSPOP09",
"xyzSPOP10",
"xyzSPOP11",
"xyzSPOP12",
"xyzSPOP13",
"xyzSPOP14",
"xyzSPOP15"
);
$now = array(
"$testLib",
substr($data,0,64), // HEXHND
'12',               // DBID
'0123456789',       // SPPGID
'1',                // SPOP01
'2',                // SPOP02
'3',                // SPOP03
'4',                // SPOP04
'5',                // SPOP05
'6',                // SPOP06
'7',                // SPOP07
'8',                // SPOP08
'9',                // SPOP09
'a',                // SPOP10
'b',                // SPOP11
'c',                // SPOP12
'd',                // SPOP13
'e',                // SPOP14
'f'                 // SPOP15
);
$xml = str_replace($was,$now,$clob);
return $xml;
}
?>
--EXPECTF--
%s
Success

