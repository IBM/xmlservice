--TEST--
XML i Toolkit: IBM_DB2 inout - multiple calls
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG32K(?,?,?,?)");
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
// -----------------
// output pgm call #1
// -----------------
// first program this XML script
$pgm = $allpgms[0];
$name = $pgm->attributes()->name;
$lib  = $pgm->attributes()->lib;
// pgm parms
$parm = $pgm->xpath('parm');
if (!$parm) die("Missing XML pgm parms ($lib/$name)");
if ((string)$parm[0]->data != 'C') die("1) INCHARA not 'C'");
if ((string)$parm[1]->data != 'D') die("2) INCHARB not 'D'");
if ((string)$parm[2]->data != '321.1234') die("3) INDEC1  not '321.1234'");
if ((string)$parm[3]->data != '1234567890.12') die("4) INDEC2  not '1234567890.12'");
// parm 5 data structure
$ds = $parm[4]->ds;
if ((string)$ds->data[0] != 'E') die("5) INDS1.DSCHARA not 'E'");
if ((string)$ds->data[1] != 'F') die("5) INDS1.DSCHARB not 'F'");
if ((string)$ds->data[2] != '333.3330') die("5) INDS1.DSDEC1  not '333.3330'");
if ((string)$ds->data[3] != '4444444444.44') die("5) INDS1.DSDEC2  not '4444444444.44'");
// pgm return
$retn = $pgm->xpath('return');
if (!$retn) die("No XML pgm return ($lib/$name)");
if ((string)$retn[0]->data != '0') die("return not '0'");
// -----------------
// output pgm call #2
// -----------------
$pgm = $allpgms[1];
$name1 = $pgm->attributes()->name;
$lib1  = $pgm->attributes()->lib;
$func1 = $pgm->attributes()->func;
// pgm return
$retn = $pgm->xpath('return');
if (!$retn) die("No XML pgm return ($lib1/$name1.$func1)");
if ((string)$retn[0]->data == 0) die("return not greater than '0'");

// good
echo "Success ($lib/$name and $lib1/$name1.$func1)\n";

// Make two different program calls at once: 
// 1) first call this PGM ...
//     D  INCHARA        S              1a
//     D  INCHARB        S              1a
//     D  INDEC1         S              7p 4        
//     D  INDEC2         S             12p 2
//     D  INDS1          DS                  
//     D   DSCHARA                      1a
//     D   DSCHARB                      1a           
//     D   DSDEC1                       7p 4      
//     D   DSDEC2                      12p 2            
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * main(): Control flow
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     C     *Entry        PLIST                   
//     C                   PARM                    INCHARA
//     C                   PARM                    INCHARB
//     C                   PARM                    INDEC1
//     C                   PARM                    INDEC2
//     C                   PARM                    INDS1
// 2) then call this SRVPGM ...
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zzstep: check private (stateful)
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzstep          B                   export
//     D zzstep          PI            10i 0
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZCALL' lib='xyzlibxmlservicexyz'>
 <parm  io='both'>
   <data type='1A'>a</data>
 </parm>
 <parm  io='both'>
   <data type='1A'>b</data>
 </parm>
 <parm  io='both'>
   <data type='7p4'>11.1111</data>
 </parm>
 <parm  io='both'>
   <data type='12p2'>222.22</data>
 </parm>
 <parm  io='both'>
  <ds>
   <data type='1A'>x</data>
   <data type='1A'>y</data>
   <data type='7p4'>66.6666</data>
   <data type='12p2'>77777.77</data>
  </ds>
 </parm>
 <return>
  <data type='10i0'>0</data>
 </return>
</pgm>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZSTEP'>
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
Success (%s)

