--TEST--
XML i Toolkit: inside fetch
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');


// tests criteria
$ctl = "*here"; /* *here *justproc *fly *debug */
$ipc = "";      /* no internal key */
$i5fail = 2;    /* 2 seconds or less */
$i5loop = 256;  /* 256(+) calls      */
$start_time = microtime();

// call IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");

$stmt = db2_prepare($conn, "call $procLib.iPLUG32K(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());

$stmt2 = db2_prepare($conn, "select * from QIWS.QCUSTCDT");
if (!$stmt2) die("Bad prepare: ".db2_stmt_errormsg());

$count = 0;
$rpt = "";
while ($count < $i5loop) {
 $res = db2_execute($stmt2);
 if (!$res) die("Bad execute: ".db2_stmt_errormsg());
 while ($res && $row = db2_fetch_array($stmt2)) {
  $clobIn = getxml($row);
  $clobOut = "";
  $ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
  $ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
  $ret=db2_execute($stmt);
  if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
  $count++;
  // var_dump(implode(":",$row));
  if (strpos($clobOut, '4444444444.44') < 1) die ("BAD call $count\n");
  // var_dump($clobOut);
  //$rpt = $clobOut;
  //echo "$count $count $count\n";
  //if ($count == 1) { fly_rpt($rpt); }
  //elseif ($count == 3) fly_rpt($rpt);
  //elseif ($count == 5) fly_rpt($rpt);
  //elseif ($count > 5) break;
 }
 //break;
}
$end_time = microtime();
$wire_time= control_microtime_used($start_time,$end_time)*1000000;


$opt = "(".trim($ctl)." ".trim($ipc).")";
echo 
  sprintf("$opt -- Time (loop=$count) total=%1.2f sec (%1.2f ms per call)\n", 
  round($wire_time/1000000,2),
  round(($wire_time/$count)/1000,2));

function control_microtime_used($i5before,$i5after) {
  return (substr($i5after,11)-substr($i5before,11))+(substr($i5after,0,9)-substr($i5before,0,9));
}

// result times
$look = round($wire_time/1000000,2);
if ($look>$i5fail) die("$count calls fail - too slow > $i5fail seconds\n");
echo "Success\n";

function getxml($row) {
/* mode='opm' */
$clob = "
<?xml version='1.0'?>
<script>
<pgm name='ZZCALL' lib='xyzlibxmlservicexyz'>
 <parm  io='both'>
   <data type='1A' var='INCHARA'>{$row[2]}</data>
 </parm>
 <parm  io='both'>
   <data type='1A' var='INCHARB'>{$row[5]}</data>
 </parm>
 <parm  io='both'>
   <data type='7p4' var='INDEC1'>{$row[10]}</data>
 </parm>
 <parm  io='both'>
   <data type='12p2' var='INDEC2'>{$row[9]}</data>
 </parm>
 <parm  io='both'>
  <ds>
   <data type='1A' var='INDS1.DSCHARA'>{$row[2]}</data>
   <data type='1A' var='INDS1.DSCHARB'>{$row[5]}</data>
   <data type='7p4' var='INDS1.DSDEC1'>{$row[10]}</data>
   <data type='12p2' var='INDS1.DSDEC2'>{$row[9]}</data>
  </ds>
 </parm>
 <return>
  <data type='10i0'>0</data>
 </return>
</pgm>
</script>
";
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success

