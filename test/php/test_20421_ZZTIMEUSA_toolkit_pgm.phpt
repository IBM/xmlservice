--TEST--
XML i Toolkit: - Zend Toolkit time USA
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
//      * zztimeUSA: check time parm
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zztimeUSA       B                   export
//     D zztimeUSA       PI              T   timfmt(*USA)
//     D  myTime                         T   timfmt(*USA)
//      * vars
//     D  retTime        s               T   timfmt(*USA)
//      /free
//       retTime=myTime;
//       myTime=t'12.34.00';
//       return retTime;
//      /end-free
//     P                 E
$param[] = $ToolkitServiceObj->AddParameterChar   ('both',  8,  'ZZTIMEUSA', 'myTime', '09:45 AM');
$retrn[] = $ToolkitServiceObj->AddParameterChar   ('both',  8,  'ZZTIMEUSA', 'retTime', '02:02 PM');
$result  = $ToolkitServiceObj->PgmCall('ZZSRV', $testLib, $param, $retrn, array('func'=>'ZZTIMEUSA'));
// var_dump($result);
/* in/out param myDate */
$myTime = "XMLSERVICE i/o param myTime: ".$result["io_param"]["myTime"];
echo "$myTime\n";
$expect = '12:34 PM';
if (strpos($myTime,$expect)<1) die("Fail missing $expect\n");
/* return value retTime */
$retTime = "XMLSERVICE return retTime: ".$result["retvals"]["retTime"];
echo "$retTime\n";
$expect = '09:45 AM';
if (strpos($retTime,$expect)<1) die("Fail missing $expect\n");
/* all good */
echo "Success\n";
?>
--EXPECTF--
%s
Success

