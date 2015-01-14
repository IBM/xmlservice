--TEST--
XML i Toolkit: - Zend Toolkit date USA
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
//      * zzdateUSA: check date parm
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzdateUSA       B                   export
//     D zzdateUSA       PI              D   datfmt(*USA)
//     D  myDate                         D   datfmt(*USA)
//      * vars
//     D  retDate        s               D   datfmt(*USA)
//      /free
//       retDate=myDate;
//       myDate=d'2007-09-30';
//       return retDate;
//      /end-free
//     P                 E
$param[] = $ToolkitServiceObj->AddParameterChar   ('both',  10,  'ZZDATEUSA', 'myDate', '05/11/2009');
$retrn[] = $ToolkitServiceObj->AddParameterChar   ('both',  10,  'ZZDATEUSA', 'retDate', '2002-02-02');
$result  = $ToolkitServiceObj->PgmCall('ZZSRV', $testLib, $param, $retrn, array('func'=>'ZZDATEUSA'));
// var_dump($result);
/* in/out param myDate */
$myDate = "XMLSERVICE i/o param myDate: ".$result["io_param"]["myDate"];
echo "$myDate\n";
$expect = '09/30/2007';
if (strpos($myDate,$expect)<1) die("Fail missing $expect\n");
/* return value retDate */
$retDate = "XMLSERVICE return retDate: ".$result["retvals"]["retDate"];
echo "$retDate\n";
$expect = '05/11/2009';
if (strpos($retDate,$expect)<1) die("Fail missing $expect\n");
/* all good */
echo "Success\n";
?>
--EXPECTF--
%s
Success

