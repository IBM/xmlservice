--TEST--
XML i Toolkit: IBM_DB2 inout SRVPGM - hang qsysopr
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');

$filename = "/QOpenSys/usr/bin/system";
if (file_exists($filename)===false) die("Fail IBM i only missing ($filename)\n");

$job1 = "XHANGME";
$job2 = "XWATCHME";

// -------------------
// call IBM i
// -------------------
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");

$ctl = "*sbmjob(QSYS/QSRVJOB/$job1) *wait(5) *call(5/busy/client) *call(40/kill/server) *idle(10)";

// -------------------
// kill current xmlservice
// -------------------
echo driverTime()." $job1 kill any XMLSERVICE on $ipc ... \n";
$ctlkill = "*immed"; // kill XMLSERVICE NOW
$clobIn = "";
$sql = "call $procLib.iPLUGR4K('$ipc','$ctlkill','$clobIn')";
$stmt=db2_exec($conn,$sql);
if (!$stmt) die("Bad execute ($database,$user): ".db2_stmt_errormsg());
$ret=db2_free_stmt($stmt);
if (!$ret) die("Bad free stmt ($database,$user): ".db2_stmt_errormsg());


// -------------------
// *sbmjob(QSYS/QSRVJOB/XHANGME)
// -------------------
echo driverTime()." $job1 calling hang program $ctl\n";
$stmt = db2_prepare($conn, "call $procLib.iPLUG32K(?,?,?,?)");
if (!$stmt) die("Bad prepare (1): ".db2_stmt_errormsg());
$clobIn = getxmlhangme();
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) echo("Bad execute (1): ".db2_stmt_errormsg());
echo driverTime()." $job1 timeout back from calling hang program\n";
var_dump($clobOut);
if (strpos($clobOut,'busy')<1) die("busy error message missing\n"); 

// -------------------
// how doing?
// -------------------
$assume = "Failure\n";
for ($i = 1; $i < 10; $i++) {
 echo driverTime()." $job2 looking $job1 ...\n";
 $clobOut = `/QOpenSys/usr/bin/system wrkactjob`;
 // var_dump($clobOut);
 if (strpos($clobOut,$job1)>0) {
  echo driverTime()." $job2 wrkactjob fail still see $job1 ...\n";
 }
 else {
  echo driverTime()." $job2 wrkactjob no longer see $job1 ...\n";
  $assume = "Success\n";
  break;
 }
 echo driverTime()." $job2 sleeping 20 seconds ...\n";
 set_time_limit(0); // Remove the time limit for command-line usage;
 $counter = 0; // Some simple counter;
 while ($counter < 200) { // Do nothing for 100*100 miliseconds (10 seconds);
  $counter++;
  usleep(100000); // Sleep for 100 miliseconds;
 }
} // end loop


// -------------------
// kill current xmlservice
// -------------------
echo driverTime()." $job1 kill any XMLSERVICE on $ipc ... \n";
$ctlkill = "*immed"; // kill XMLSERVICE NOW
$clobIn = "";
$sql = "call $procLib.iPLUGR4K('$ipc','$ctlkill','$clobIn')";
$stmt=db2_exec($conn,$sql);
if (!$stmt) die("Bad execute ($database,$user): ".db2_stmt_errormsg());
$ret=db2_free_stmt($stmt);
if (!$ret) die("Bad free stmt ($database,$user): ".db2_stmt_errormsg());

// test result
echo $assume;


//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zzhang: bad function hang up
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzhang          B                   export
//     D zzhang          PI
function getxmlhangme() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZHANG'>
</pgm>
</script>
ENDPROC;
return test_lib_replace($clob);
}

?>
--EXPECTF--
%s
Success

