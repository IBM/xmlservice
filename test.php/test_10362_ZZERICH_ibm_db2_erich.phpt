--TEST--
XML i Toolkit: IBM_DB2 inout PGM - erich occurs data
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG10M(?,?,?,?)");
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
// var_dump($clobOut);
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
if (!$parm) die("Fail XML pgm parms missing ($lib/$name)\n");
// expected
$vevsfi = 'A';
$vevsrj = 'BB';
$vevsob = 22.0;
$vevsve = 33.0;
// $vevsods ds occurs(200)
$vsukz  = '1';
$vpos   = '23456789';
$vtxt   = 'lots o stuff';
$vkalw  = 42.42;
$vvsw   = 43.43;
$vvsk   = 2.0;
// top parms
$vevsfi1 = (string)$parm[0]->data;
$vevsrj1 = (string)$parm[1]->data;
$vevsob1 = (string)$parm[2]->data;
$vevsve1 = (string)$parm[3]->data;
if ($vevsfi != $vevsfi1) die("Fail vevsfi ($vevsfi not $vevsfi1) ($lib/$name)\n");
if ($vevsrj != $vevsrj1) die("Fail vevsrj ($vevsrj not $vevsrj1) ($lib/$name)\n");
if ($vevsob != $vevsob1) die("Fail vevsob ($vevsob not $vevsob1) ($lib/$name)\n");
if ($vevsve != $vevsve1) die("Fail vevsve ($vevsve not $vevsve1) ($lib/$name)\n");
// occurs DS
$dsall = $parm[4]->ds;
if (count($dsall) != 200) {
  die("Fail XML pgm not return 200 DS records ($lib/$name)\n");
}
// expect ds1
$ds1=array($vsukz,$vpos,$vtxt);
for ($j=0;$j<15;$j++) $ds1[]=$vkalw; 
for ($j=0;$j<15;$j++) $ds1[]=$vvsw; 
for ($j=0;$j<15;$j++) $ds1[]=$vvsk; 
// actual ds2
$i=1;
foreach ($dsall as $ds) {
  $vsukz1  = (string)$ds->data[0];
  $vpos1   = (string)$ds->data[1];
  $vtxt1   = (string)$ds->data[2];
  $ds2     = array($vsukz1,$vpos1,$vtxt1);
  for ($j=0;$j<15;$j++) {
    $vkalw1  = (string)$ds->data[$j+3];
    $ds2[]   = $vkalw1;
  }
  for ($j=0;$j<15;$j++) {
    $vvsw1   = (string)$ds->data[$j+18];
    $ds2[]   = $vvsw1;
  }
  for ($j=0;$j<15;$j++) {
    $vvsk1   = (string)$ds->data[$j+33];
    $ds2[]   = $vvsk1;
  }
  // any differences?
  $r = array_diff($ds1,$ds2);
  if ($r && count($r)) {
    echo substr($clobOut,0,3000)." ... \n";
    var_dump($r);
    die("Fail XML occurs($i) ($lib/$name)\n");
  }
  $i++;
}

// pgm data returned
$retn = $pgm->xpath('return');
if (!$retn) die("Fail XML pgm return missing ($lib/$name)\n");
$var  = $retn[0]->data->attributes()->var;
$actual = (string)$retn[0]->data;
$expect='0';
if ($actual != $expect) die("return: $var ($actual not $expect) ($lib/$name)\n");

// good
echo substr($clobOut,0,3000)." ... \n";
echo "Success ($lib/$name)\n";


//     D $vevsfi         s              1
//     D $vevsrj         s              2
//     D $vevsob         s              7s 0
//     D $vevsve         s              5s 0
//     D*Ergebnisdaten:
//     D $vevsods        ds                  occurs(200)
//     D $vsukz                  1      1
//     D $vpos                   2      9
//     D $vtxt                  10     39
//     D $vkalw                 40    174  2 dim(15)
//     D $vvsw                 175    309  2 dim(15)
//     D $vvsk                 310    324  0 dim(15)
//     d*
//     D i               S             10i 0 inz(0)
//     D j               S             10i 0 inz(0)
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * main(): Control flow
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     C     *Entry        PLIST
//     c                   parm                    $vevsfi
//     c                   parm                    $vevsrj
//     c                   parm                    $vevsob
//     c                   parm                    $vevsve
//     c                   parm                    $vevsods
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZERICH' lib='xyzlibxmlservicexyz'>
 <parm  io='both'>
   <data var='vevsfi' type='1A'>a</data>
 </parm>
 <parm  io='both'>
   <data var='vevsrj' type='2A'>bb</data>
 </parm>
 <parm  io='both'>
   <data var='vevsob' type='7s0'>11</data>
 </parm>
 <parm  io='both'>
   <data var='vevsve' type='5s0'>22.0</data>
 </parm>
 <parm  io='both'>
  <ds var='vevsods' dim='200'>
   <data var='vsukz' type='1A'>x</data>
   <data var='vpos' type='8A'>y</data>
   <data var='vtxt' type='30A'>hallo</data>
   <data var='vkalw' type='9s2' dim='15'>9.2</data>
   <data var='vvsw' type='9s2' dim='15'>8.2</data>
   <data var='vvsk' type='1s0' dim='15'>1.0</data>
  </ds>
 </parm>
 <return>
  <data var='ret' type='10i0'>0</data>
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

