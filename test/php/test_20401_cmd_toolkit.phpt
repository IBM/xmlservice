--TEST--
XML i Toolkit: - Zend Toolkit CMDs
--SKIPIF--
<?php require_once('skipiftoolkit.inc'); ?>
--FILE--
<?php
require_once('connection.inc');
// assume /usr/local/zendsvr/share/ToolkitAPI
require_once("ToolkitService.php");
// new toolkit
try { $ToolkitServiceObj = ToolkitService::getInstance($database, $user, $password); }
catch (Exception $e) { die($e->getMessage()); }
$ToolkitServiceObj->setToolkitServiceParams(
array('InternalKey'=>$ipc, // route to same XMLSERVICE job /tmp/myjob1
'subsystem'=>"QGPL/QDFTJOBD",      // subsystem/jobd to start XMLSERVICE (if not running) 
'plug'=>"iPLUG32K"));              // max size data i/o (iPLUG4K,32K,65K.512K,1M,5M,10M,15M)
// execute command
$cmd = "addlible $testLib";
$Result = $ToolkitServiceObj->CLCommand($cmd);
$Rows = $ToolkitServiceObj->CLInteractiveCommand("DSPLIBL");
if(!$Rows) die($ToolkitServiceObj->getLastError());
var_dump($Rows);
if (strpos(implode(",",$Rows),$testLib)<1) die("missing $testLib");
echo "Success\n";
?>
--EXPECTF--
%s
Success

