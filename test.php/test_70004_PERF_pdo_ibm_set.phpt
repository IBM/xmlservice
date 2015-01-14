--TEST--
XML i Toolkit: PDO_IBM inout PGM - performance loop call
--SKIPIF--
<?php require_once('skipifpdo.inc'); ?>
--FILE--
<?php
$i5loop = 5000;
require_once('connection.inc');

// include connect performance 
// (worst connect situation)
$start_time = microtime();
try {
  $db = new PDO("ibm:".$database, 
                strtoupper($user), 
                strtoupper($password), 
                array(PDO::ATTR_AUTOCOMMIT=>true));
} catch( Exception $e ) { 
  die("bad connect"); 
}
for ($i=0;$i<$i5loop;$i++) {
  // get the xml simulate changed data
  // randomly happening througout php script
  $ctl .= " *hack";
  $clobIn = getxml();
  $clobOut = "";
  try {
    // some bug pdo_ibm
    // redo the prepare
    $stmt = $db->prepare("call $procLib.iPLUGR4K(?,?,?)");
  } catch( Exception $e ) { 
    $err = $db->errorInfo();
    $cod = $db->errorCode();
    die($cod." ".$err[0]." ".$err[1]." ".$err[2]);
  }
  try {
    // rebind parms simulate changed data bindings
    // randomly happening througout php script 
    $ret = $stmt->execute(array($ipc,$ctl,$clobIn));
    while( $row = $stmt->fetch(PDO::FETCH_NUM,PDO::FETCH_ORI_NEXT) ) {
      $clobOut .= driverJunkAway($row[0]);
    }
  } catch( Exception $e ) {
    $err = $stmt->errorInfo();
    $cod = $stmt->errorCode();
    die($cod." ".$err[0]." ".$err[1]." ".$err[2]);
  }
  // remove var dump because screen output will
  // be the greatest timing factor dwarfing other data 
  // echo " IN:\n"; var_dump($clobIn);  
  // echo "OUT:\n"; var_dump($clobOut);
  if (strpos($clobOut,'4444444444.44')<1) {
    var_dump($clobOut);
    die("test failed loop count $i\n");
  }
  $ctl = "*ignore"; // high performance ignore flags
}
$end_time = microtime();
$wire_time= control_microtime_used($start_time,$end_time)*1000000;

// result times
$look = round($wire_time/1000000,2);
echo 
  sprintf("Time (loop=$i5loop) total=%1.2f sec (%1.2f ms per call)\n", 
  round($wire_time/1000000,2),
  round(($wire_time/$i5loop)/1000,2));
// less than two minutes (usually around one minute) 
if ($look<120) echo "ok\n";
else echo "fail - too slow\n";

function control_microtime_used($i5before,$i5after) {
  return (substr($i5after,11)-substr($i5before,11))+(substr($i5after,0,9)-substr($i5before,0,9));
}

function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<pgm name='ZZCALL' lib='xyzlibxmlservicexyz'>
 <parm  io='both'>
   <data type='1A'>a</data>
 </parm>
 <parm  io='both'>
   <data type='1A'>b</data>
 </parm>
 <parm  io='both'>
   <data type='7p4'>11.1111</data>
 </parm>
 <parm  io='both'>
   <data type='12p2'>222.22</data>
 </parm>
 <parm  io='both'>
  <ds>
   <data type='1A'>x</data>
   <data type='1A'>y</data>
   <data type='7p4'>66.6666</data>
   <data type='12p2'>77777.77</data>
  </ds>
 </parm>
 <return>
  <data type='10i0'>0</data>
 </return>
</pgm>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
ok

