--TEST--
XML i Toolkit: - Zend Toolkit return array full
--SKIPIF--
<?php require_once('skipiftoolkit.inc'); ?>
--FILE--
<?php
require_once('connection.inc');
// assume /usr/local/zendsvr/share/ToolkitAPI
require_once("ToolkitService.php");
// new toolkit
try { $ToolkitServiceObj = ToolkitService::getInstance($database, $user, $password); }
catch (Exception $e) { echo  $e->getMessage(), "\n"; exit();}
$ToolkitServiceObj->setToolkitServiceParams(
array('InternalKey'=>$ipc, // route to same XMLSERVICE job /tmp/myjob1
'subsystem'=>"QGPL/QDFTJOBD",      // subsystem/jobd to start XMLSERVICE (if not running) 
'plug'=>"iPLUG5M"));               // max size data i/o (iPLUG4K,32K,65K.512K,1M,5M,10M,15M)
//     D ARRAYMAX        c                   const(999)
//     D dcRec_t         ds                  qualified based(Template)
//     D  dcMyName                     10A
//     D  dcMyJob                    4096A
//     D  dcMyRank                     10i 0
//     D  dcMyPay                      12p 2
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zzarray: check return array aggregate 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzarray         B                   export
//     D zzarray         PI                  likeds(dcRec_t) dim(ARRAYMAX)
//     D  myName                       10A
//     D  myMax                        10i 0
//     D  myCount                      10i 0
$param = array();  // reset array
$result = array(); // reset array
$max = 10;
$param[] = $ToolkitServiceObj->AddParameterChar        ('both',    10,  "name",          "myName",      "nada");
$param[] = $ToolkitServiceObj->AddParameterInt32       ('both',          "max",           "myMax",        $max);
$param[] = $ToolkitServiceObj->AddParameterInt32       ('both',        "count",         "myCount",           0);
for ($h=0;$h<$max;$h++) {
  $dcRec_t[] =  $ToolkitServiceObj->AddParameterChar   ('both',    10,  "name",    "dcMyName{$h}",         'A');
  $dcRec_t[] =  $ToolkitServiceObj->AddParameterChar   ('both',  4096,   "job",     "dcMyJob{$h}",         'B');
  $dcRec_t[] =  $ToolkitServiceObj->AddParameterInt32  ('both',         "rank",    "dcMyRank{$h}",           1);
  $dcRec_t[] =  $ToolkitServiceObj->AddParameterPackDec('both', 12, 2,   "pay",     "dcMyPay{$h}",         9.2);
}
$result[] = $ToolkitServiceObj->AddDataStruct($dcRec_t);
$output = $ToolkitServiceObj->PgmCall("ZZSRV", $testLib, $param, $result, array('func'=>"ZZARRAY"));
if (!$output) echo "Failure " . $ToolkitServiceObj->getLastError();
else var_dump($output);
echo "Success\n";
?>
--EXPECTF--
array(2) {
  ["io_param"]=>
  array(3) {
    ["myName"]=>
    string(4) "nada"
    ["myMax"]=>
    string(2) "10"
    ["myCount"]=>
    string(2) "10"
  }
  ["retvals"]=>
  array(40) {
    ["dcMyName0"]=>
    string(5) "nada1"
    ["dcMyJob0"]=>
    string(8) "Test 101"
    ["dcMyRank0"]=>
    string(2) "11"
    ["dcMyPay0"]=>
    string(5) "13.42"
    ["dcMyName1"]=>
    string(5) "nada2"
    ["dcMyJob1"]=>
    string(8) "Test 102"
    ["dcMyRank1"]=>
    string(2) "12"
    ["dcMyPay1"]=>
    string(5) "26.84"
    ["dcMyName2"]=>
    string(5) "nada3"
    ["dcMyJob2"]=>
    string(8) "Test 103"
    ["dcMyRank2"]=>
    string(2) "13"
    ["dcMyPay2"]=>
    string(5) "40.26"
    ["dcMyName3"]=>
    string(5) "nada4"
    ["dcMyJob3"]=>
    string(8) "Test 104"
    ["dcMyRank3"]=>
    string(2) "14"
    ["dcMyPay3"]=>
    string(5) "53.68"
    ["dcMyName4"]=>
    string(5) "nada5"
    ["dcMyJob4"]=>
    string(8) "Test 105"
    ["dcMyRank4"]=>
    string(2) "15"
    ["dcMyPay4"]=>
    string(5) "67.10"
    ["dcMyName5"]=>
    string(5) "nada6"
    ["dcMyJob5"]=>
    string(8) "Test 106"
    ["dcMyRank5"]=>
    string(2) "16"
    ["dcMyPay5"]=>
    string(5) "80.52"
    ["dcMyName6"]=>
    string(5) "nada7"
    ["dcMyJob6"]=>
    string(8) "Test 107"
    ["dcMyRank6"]=>
    string(2) "17"
    ["dcMyPay6"]=>
    string(5) "93.94"
    ["dcMyName7"]=>
    string(5) "nada8"
    ["dcMyJob7"]=>
    string(8) "Test 108"
    ["dcMyRank7"]=>
    string(2) "18"
    ["dcMyPay7"]=>
    string(6) "107.36"
    ["dcMyName8"]=>
    string(5) "nada9"
    ["dcMyJob8"]=>
    string(8) "Test 109"
    ["dcMyRank8"]=>
    string(2) "19"
    ["dcMyPay8"]=>
    string(6) "120.78"
    ["dcMyName9"]=>
    string(6) "nada10"
    ["dcMyJob9"]=>
    string(9) "Test 1010"
    ["dcMyRank9"]=>
    string(2) "20"
    ["dcMyPay9"]=>
    string(6) "134.20"
  }
}
%s

