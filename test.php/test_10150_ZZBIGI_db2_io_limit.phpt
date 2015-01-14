--TEST--
XML i Toolkit: IBM_DB2 inout ZZBIGI - call integer limits
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG4K(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
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
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML returned");
$allpgms = $xmlobj->xpath('/script/pgm');
if (!$allpgms) die("Missing XML pgm info");
$pgm  = $allpgms[0];
$name = $pgm->attributes()->name;
$lib  = $pgm->attributes()->lib;
$func = $pgm->attributes()->func;
$parms = $xmlobj->xpath('/script/pgm/parm');
$int = array(
"-128",
"-32768",
"-2147483648",
"-9223372036854775808",
"127",
"32767",
"2147483647",
"9223372036854775807",
"255",
"65535",
"4294967295",
"18446744073709551615"
);
$i=0;
foreach($parms as $parm) {
  $mytype = (string)($parm->data->attributes()->type);
  $myval = (string)($parm->data);
  echo "$mytype {$int[$i]} == $myval\n";
  if ($int[$i] != $myval) die("Bad value");
  $i++;
}

// good
echo "Success ($lib/$name($func))\n";

/*
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * zzbigi: check ints 
      * int8  -128                  +127
      * int16 -32768                +32767
      * int32 -2147483648           +2147483647
      * int64 -9223372036854775808  +9223372036854775807
      * uint8                       +255
      * uint16                      +65535
      * uint32                      +4294967295
      * uint64                      +18446744073709551615
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P zzbigi          B                   export
     D zzbigi          PI            20u 0
     D  mmint8                        3i 0
     D  mmint16                       5i 0
     D  mmint32                      10i 0
     D  mmint64                      20i 0
     D  myint8                        3i 0
     D  myint16                       5i 0
     D  myint32                      10i 0
     D  myint64                      20i 0
     D  myuint8                       3u 0
     D  myuint16                      5u 0
     D  myuint32                     10u 0
     D  myuint64                     20u 0
*/
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZBIGI'>
 <parm  io='both'>
   <data type='3i0'>-128</data>
 </parm>
 <parm  io='both'>
   <data type='5i0'>-32768</data>
 </parm>
 <parm  io='both'>
   <data type='10i0'>-2147483648</data>
 </parm>
 <parm  io='both'>
   <data type='20i0'>-9223372036854775808</data>
 </parm>
 <parm  io='both'>
   <data type='3i0'>127</data>
 </parm>
 <parm  io='both'>
   <data type='5i0'>32767</data>
 </parm>
 <parm  io='both'>
   <data type='10i0'>2147483647</data>
 </parm>
 <parm  io='both'>
   <data type='20i0'>9223372036854775807</data>
 </parm>
 <parm  io='both'>
   <data type='3u0'>255</data>
 </parm>
 <parm  io='both'>
   <data type='5u0'>65535</data>
 </parm>
 <parm  io='both'>
   <data type='10u0'>4294967295</data>
 </parm>
 <parm  io='both'>
   <data type='20u0'>18446744073709551615</data>
 </parm>
 <return>
  <data type='20u0'>0</data>
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

