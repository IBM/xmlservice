--TEST--
XML i Toolkit: - Zend Toolkit inside fetch
--SKIPIF--
<?php require_once('skipiftoolkit.inc'); ?>
--FILE--
<?php
require_once('connection.inc');
// assume /usr/local/zendsvr/share/ToolkitAPI
require_once("ToolkitService.php");

// tests criteria
$i5fail = 2;   /* 2 seconds or less */
$i5loop = 256; /* 256(+) calls      */
$start_time = microtime();


// IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");
$stmt2 = db2_prepare($conn, "select * from QIWS.QCUSTCDT");
if (!$stmt2) die("Bad prepare: ".db2_stmt_errormsg());

// new toolkit
try { $ToolkitServiceObj = ToolkitService::getInstance($conn); } catch (Exception $e) { die($e->getMessage()); }
// 'stateless'=>true,'v5r4'=>true,'customControl'=>"*justproc",'internalKey'=>$ipc,'plugSize'=>'4K'
$options = array('stateless'=>true,'plugSize'=>'4K');
$ToolkitServiceObj->setToolkitServiceParams($options);
$count = 0;
while ($count < $i5loop) {
 $res = db2_execute($stmt2);
 if (!$res) die("Bad execute: ".db2_stmt_errormsg());
 while ($res && $row = db2_fetch_array($stmt2)) {
  $param = array();
  $ds = array();
  $param[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'INCHARA', 'var1', $row[2]);
  $param[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'INCHARB', 'var2', $row[5]);
  $param[] = $ToolkitServiceObj->AddParameterPackDec('both',  7,4,'INDEC1',  'var3', $row[10]);
  $param[] = $ToolkitServiceObj->AddParameterPackDec('both', 12,2,'INDEC2',  'var4', $row[9]);
     $ds[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'DSCHARA', 'ds1',  $row[2]);
     $ds[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'DSCHARB', 'ds2',  $row[5]);
     $ds[] = $ToolkitServiceObj->AddParameterPackDec('both',  7,4,'DSDEC1',  'ds3',  $row[10]);
     $ds[] = $ToolkitServiceObj->AddParameterPackDec('both', 12,2,'DSDEC1',  'ds4',  $row[9]);
  $param[] = $ToolkitServiceObj->AddDataStruct($ds);
  $result  = $ToolkitServiceObj->PgmCall('ZZCALL', $testLib, $param, null, null);
  $count++;
  // var_dump(implode(":",$row));
  if ($result["io_param"]["ds4"] <> 4444444444.44) die ("BAD call $count\n");
  // var_dump(implode(":",$result["io_param"]));
 }
}
$end_time = microtime();
$wire_time= control_microtime_used($start_time,$end_time)*1000000;

$opt = str_replace("\n","",var_export($options,true));
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


?>
--EXPECTF--
%s
Success


