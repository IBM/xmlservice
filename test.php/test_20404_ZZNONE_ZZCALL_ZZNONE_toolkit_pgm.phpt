--TEST--
XML i Toolkit: - Zend Toolkit PGM with DS
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
'plug'=>"iPLUG512K"));              // max size data i/o (iPLUG4K,32K,65K.512K,1M,5M,10M,15M)
echo "my ipc is $ipc ... \n";
for ($i=0; $i<3; $i++) {
  $param = array();
  $ds = array();
  switch($i) {
  case 0:
    echo "Call ZZNONE ... \n";
    $result  = $ToolkitServiceObj->PgmCall('ZZNONE', $testLib, null, null, null);
    var_dump($result);
    break;
  case 1:
    echo "Call ZZCALL ... \n";
    $param[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'INCHARA', 'var1', 'Y');
    $param[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'INCHARB', 'var2', 'Z');
    $param[] = $ToolkitServiceObj->AddParameterPackDec('both',  7,4,'INDEC1',  'var3', '001.0001');
    $param[] = $ToolkitServiceObj->AddParameterPackDec('both', 12,2,'INDEC2',  'var4', '0000000003.04');
       $ds[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'DSCHARA', 'ds1',  'A');
       $ds[] = $ToolkitServiceObj->AddParameterChar   ('both',  1,  'DSCHARB', 'ds2',  'B');
       $ds[] = $ToolkitServiceObj->AddParameterPackDec('both',  7,4,'DSDEC1',  'ds3',  '005.0007');
       $ds[] = $ToolkitServiceObj->AddParameterPackDec('both', 12,2,'DSDEC1',  'ds4',  '0000000006.08');
    $param[] = $ToolkitServiceObj->AddDataStruct($ds);
    $result  = $ToolkitServiceObj->PgmCall('ZZCALL', $testLib, $param, null, null);
    var_dump($result);
    break;
  case 2:
    echo "Call ZZNONE ... \n";
    $result  = $ToolkitServiceObj->PgmCall('ZZNONE', $testLib, null, null, null);
    var_dump($result);
    break;
  default:
    die("loop bad");
    break;
  }
  if (!$result) die("Failure");
}
echo "Success\n";
?>
--EXPECTF--
%s
Success
