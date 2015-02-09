--TEST--
XML i Toolkit: IBM_DB2 inout JVM test ZZJAVA sleeper
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
require_once('connection.inc');
require_once("ToolkitService.php");

// IBM i
$conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");

// normal RPG java: 'customControl'=>'*java' -- set your own classpath 
// SP SQL java: 'customControl'=>'*sqljava' or 'customControl'=>'*dbgjava' -- your classpath ignored
try { $ToolkitServiceObj = ToolkitService::getInstance($conn); } catch (Exception $e) { die($e->getMessage()); }
$options = array('plugSize'=>'4K','customControl'=>'*sqljava','stateless'=>true);
$ToolkitServiceObj->setToolkitServiceParams($options);
$ms = 5000; // 5 seconds
echo "java RPG w/java stored procedure now sleep($ms ms) ...\n";
$param = array();
$param[] = $ToolkitServiceObj->AddParameterInt32('both', "ms", "ms", $ms);
$result  = $ToolkitServiceObj->PgmCall('ZZJAVA', 'XMLSERVICE', $param, null, null);
var_dump($result);

if ($result["io_param"]["ms"] != $ms) die("ZZJAVA missing $ms ");

echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success


