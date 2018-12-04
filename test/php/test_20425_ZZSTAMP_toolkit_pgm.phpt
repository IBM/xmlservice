--TEST--
XML i Toolkit: - Zend Toolkit timestamp
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
//      * zzstamp: check timestamp parm
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzstamp         B                   export
//     D zzstamp         PI              Z
//     D  myStamp                        Z
//      * vars
//     D  retStamp       s               Z
//      /free
//       retStamp=myStamp;
//       myStamp=z'1960-12-31-12.32.23.000000';
//       return retStamp;
//      /end-free
//     P                 E
$param[] = $ToolkitServiceObj->AddParameterChar   ('both',  26,  'ZZSTAMP', 'myStamp', '2011-12-29-12.45.29.000000');
$retrn[] = $ToolkitServiceObj->AddParameterChar   ('both',  26,  'ZZSTAMP', 'retStamp', '2002-02-02-02.02.02.000000');
$result  = $ToolkitServiceObj->PgmCall('ZZSRV', $testLib, $param, $retrn, array('func'=>'ZZSTAMP'));
// var_dump($result);
/* in/out param myDate */
$myStamp = "XMLSERVICE i/o param myStamp: ".$result["io_param"]["myStamp"];
echo "$myStamp\n";
$expect = '1960-12-31-12.32.23.000000';
if (strpos($myStamp,$expect)<1) die("Fail missing $expect\n");
/* return value retStamp */
$retStamp = "XMLSERVICE return retStamp: ".$result["retvals"]["retStamp"];
echo "$retStamp\n";
$expect = '2011-12-29-12.45.29.000000';
if (strpos($retStamp,$expect)<1) die("Fail missing $expect\n");
/* all good */
echo "Success\n";
?>
--EXPECTF--
%s
Success

