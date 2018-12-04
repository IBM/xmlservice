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
'plug'=>"iPLUG32K"));              // max size data i/o (iPLUG4K,32K,65K.512K,1M,5M,10M,15M)
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
echo "good so far ...\n";
var_dump($result);
?>
--EXPECTF--
%s
array(2) {
  ["io_param"]=>
  array(8) {
    ["var1"]=>
    string(1) "C"
    ["var2"]=>
    string(1) "D"
    ["var3"]=>
    string(8) "321.1234"
    ["var4"]=>
    string(13) "1234567890.12"
    ["ds1"]=>
    string(1) "E"
    ["ds2"]=>
    string(1) "F"
    ["ds3"]=>
    string(8) "333.3330"
    ["ds4"]=>
    string(13) "4444444444.44"
  }
  ["retvals"]=>
  array(0) {
  }
}

