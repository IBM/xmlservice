--TEST--
XML i Toolkit: - Zend Toolkit vary char
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
//      * zzvary: check return varying 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzvary          B                   export
//     D zzvary          PI            20A   varying
//     D  myName                       10A   varying
//      * vars
//     D tmp             S             20A   varying
//      /free
//       tmp = 'my name is ';
//       tmp = tmp + myName;
//       return tmp;
//      /end-free
//     P                 E
$param[] = $ToolkitServiceObj->AddParameterChar('both', 10, 'ZZVARY', 'myVary', 'Ranger', 'on'); // 6th parameter--'on'--is for varying
$retrn[] = $ToolkitServiceObj->AddParameterChar('both', 20, 'ZZVARY', 'retVary', 'Mud', 'on'); // 6th parameter--'on'--is for varying
$result  = $ToolkitServiceObj->PgmCall('ZZSRV', $testLib, $param, $retrn, array('func'=>'ZZVARY'));
// var_dump($result);
/* in/out param myDate */
$myVary = "XMLSERVICE i/o param myVary: ".$result["io_param"]["myVary"];
echo "$myVary\n";
$expect = 'Ranger';
if (strpos($myVary,$expect)<1) die("Fail missing $expect\n");
/* return value retVary */
$retVary = "XMLSERVICE return retVary: ".$result["retvals"]["retVary"];
echo "$retVary\n";
$expect = 'my name is Ranger';
if (strpos($retVary,$expect)<1) die("Fail missing $expect\n");
/* all good */
echo "Success\n";
?>
--EXPECTF--
%s
Success

