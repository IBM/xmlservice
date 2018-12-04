--TEST--
XML i Toolkit: - Zend Toolkit erich occurs data
--SKIPIF--
<?php require_once('skipiftoolkit.inc'); ?>
--FILE--
<?php
require_once('connection.inc');
// assume /usr/local/zendsvr/share/ToolkitAPI
require_once("ToolkitService.php");
ob_start();
// new toolkit
try { $ToolkitServiceObj = ToolkitService::getInstance($database, $user, $password); }
catch (Exception $e) { echo  $e->getMessage(), "\n"; exit();}
$ToolkitServiceObj->setToolkitServiceParams(
array('InternalKey'=>$ipc, // route to same XMLSERVICE job /tmp/myjob1
'subsystem'=>"QGPL/QDFTJOBD",      // subsystem/jobd to start XMLSERVICE (if not running) 
'plug'=>"iPLUG5M"));               // max size data i/o (iPLUG4K,32K,65K.512K,1M,5M,10M,15M)
//     D $vevsfi         s              1
//     D $vevsrj         s              2
//     D $vevsob         s              7s 0
//     D $vevsve         s              5s 0
//     D*Ergebnisdaten:
//     D $vevsods        ds                  occurs(200)
//     D $vsukz                  1      1
//     D $vpos                   2      9
//     D $vtxt                  10     39
//     D $vkalw                 40    174  2 dim(15)
//     D $vvsw                 175    309  2 dim(15)
//     D $vvsk                 310    324  0 dim(15)
//     d*
//     D i               S             10i 0 inz(0)
//     D j               S             10i 0 inz(0)
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * main(): Control flow
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     C     *Entry        PLIST
//     c                   parm                    $vevsfi
//     c                   parm                    $vevsrj
//     c                   parm                    $vevsob
//     c                   parm                    $vevsve
//     c                   parm                    $vevsods
$param[] = $ToolkitServiceObj->AddParameterChar        ('both',1,  'vevsfi',       'var1',      'a');
$param[] = $ToolkitServiceObj->AddParameterChar        ('both',2,  'vevsrj',       'var2',      'bb');
$param[] = $ToolkitServiceObj->AddParameterZoned       ('both',7,0,'vevsob',       'var3',      '1.0');
$param[] = $ToolkitServiceObj->AddParameterZoned       ('both',5,0,'vevsve',       'var4',      '1.0');
for ($h=0;$h<200;$h++) {
  $vevsods[] =  $ToolkitServiceObj->AddParameterChar   ('both', 1, "vsukz{$h}",    "ds1{$h}",    'A');
  $vevsods[] =  $ToolkitServiceObj->AddParameterChar   ('both', 8, "vpos{$h}",     "ds2{$h}",    'B');
  $vevsods[] =  $ToolkitServiceObj->AddParameterChar   ('both', 30,"vtxt{$h}",     "ds3{$h}",    'C');
  for ($i=0;$i<15;$i++) 
    $vevsods[] =  $ToolkitServiceObj->AddParameterZoned('both',9,2,"vkalw{$h}{$i}","ds4{$h}{$i}",'9.2' );
  for ($i=0;$i<15;$i++) 
    $vevsods[] =  $ToolkitServiceObj->AddParameterZoned('both',9,2,"vvsw{$h}{$i}", "ds5{$h}{$i}",'9.2' );
  for ($i=0;$i<15;$i++) 
    $vevsods[] =  $ToolkitServiceObj->AddParameterZoned('both',1,0,"vvsk{$h}{$i}", "ds6{$h}{$i}",'1.0' );
}
$param[] = $ToolkitServiceObj->AddDataStruct($vevsods);
$result = $ToolkitServiceObj->PgmCall('ZZERICH', $testLib, $param, null, null);
if (!$result) echo $ToolkitServiceObj->getLastError();
else var_dump($result);
$clobOut = ob_get_contents();
ob_end_clean();
echo substr($clobOut,strlen($clobOut)-140,140);
?>
--EXPECTF--
%s
    string(1) "2"
    ["ds619914"]=>
    string(1) "2"
  }
  ["retvals"]=>
  array(0) {
  }
%s

