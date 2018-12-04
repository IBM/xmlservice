--TEST--
XML i Toolkit: - Zend Toolkit time ISO
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
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zztime: check time parm
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zztime          B                   export
//     D zztime          PI              T
//     D  myTime                         T   timfmt(*iso)
//      * vars
//     D  retTime        s               T   timfmt(*iso)
//      /free
//       retTime=myTime;
//       myTime=t'12.34.56';
//       return retTime;
//      /end-free
//     P                 E
$param[] = $ToolkitServiceObj->AddParameterChar   ('both',  8,  'ZZTIME', 'myTime', '09.45.29');
$retrn[] = $ToolkitServiceObj->AddParameterChar   ('both',  8,  'ZZTIME', 'retTime', '02.02.02');
$result  = $ToolkitServiceObj->PgmCall('ZZSRV', $testLib, $param, $retrn, array('func'=>'ZZTIME'));
// var_dump($result);
/* in/out param myDate */
$myTime = "XMLSERVICE i/o param myTime: ".$result["io_param"]["myTime"];
echo "$myTime\n";
$expect = '12.34.56';
if (strpos($myTime,$expect)<1) die("Fail missing $expect\n");
/* return value retTime */
$retTime = "XMLSERVICE return retTime: ".$result["retvals"]["retTime"];
echo "$retTime\n";
$expect = '09.45.29';
if (strpos($retTime,$expect)<1) die("Fail missing $expect\n");
/* all good */
echo "Success\n";
?>
--EXPECTF--
%s
Success

