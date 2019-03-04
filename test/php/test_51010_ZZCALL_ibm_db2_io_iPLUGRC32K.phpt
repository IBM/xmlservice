--TEST--
XML i Toolkit: IBM_DB2 inout iPLUGRC32K partial input
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
$stmt = db2_prepare($conn, "call $procLib.iPLUGRC32K(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
$clobIn = getxml_part1();
$count = 1; // 0=run; 1=accumulate input xml
$clobOut = "";
$ret=db2_execute($stmt,array($ipc,$ctl,$clobIn,$count));
if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
$clobIn = getxml_part2();
$count = 0; // 0=run; >0=accumulate input xml
$clobOut = "";
$ret=db2_execute($stmt,array($ipc,$ctl,$clobIn,$count));
if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
while ($row = db2_fetch_array($stmt)){
  $clobOut .= $row[0];
}
$clobOut = trim($clobOut);
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
// output pgm call
// -----------------
// only one program this XML script
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

// good
echo "Success ($lib/$name)\n";

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
function getxml() {
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

function getxml_part1() {
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
ENDPROC;
return test_lib_replace($clob);
}

function getxml_part2() {
$clob = <<<ENDPROC
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
Success (%s)

