--TEST--
XML i Toolkit: IBM_DB2 inout JVM test ZZJAVA2 return classpath
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
$options = array('plugSize'=>'4K','customControl'=>'*java','stateless'=>true);
$ToolkitServiceObj->setToolkitServiceParams($options);

$yours = "/QIBM/ProdData/OS400/Java400/ext/db2routines_classes.jar:/QIBM/ProdData/OS400/Java400/ext/runtime.zip:/QIBM/ProdData/OS400/Java400/ext/sqlj_classes.jar:/QIBM/ProdData/OS400/Java400/ext/db2_classes.jar";
$mine = "/home/adc";
$ours = $mine.':'.$yours;
$result  = $ToolkitServiceObj->CLCommand("ADDENVVAR ENVVAR(CLASSPATH) VALUE('{$ours}') REPLACE(*YES)");
var_dump($result);

echo "calling java now ...\n";
$param = array();
$param[] = $ToolkitServiceObj->AddParameterChar   ('both', 4096,  'classpath', 'classpath', '');
$result  = $ToolkitServiceObj->PgmCall('ZZJAVA2', 'XMLSERVICE', $param, null, null);
var_export($result);

if (strpos($result["io_param"]["classpath"],$mine)<1) die("ZZJAVA missing $mine");

echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success


