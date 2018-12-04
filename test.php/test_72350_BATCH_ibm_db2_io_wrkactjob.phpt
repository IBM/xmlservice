--TEST--
XML i Toolkit: IBM_DB2 inout multi batch processing
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
// call IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");
$ctlstart = $ctl;
for ($i=0;$i<6;$i++) {
$stmt = db2_prepare($conn, "call $procLib.iPLUG5M(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
echo "=========================\n";
switch($i) {
  case 0:
    echo "INPUT BATCH getxml1 (wrkactjob): Submitted XMLSERVICE batch request ...";
    $ctl = $ctlstart . " *batch *idle(300)";
    $clobIn = getxml1();
    break;
  case 1:
    echo "INPUT BATCH getxml2 (ls /tmp): Submitted XMLSERVICE batch request ...";
    $ctl = $ctlstart . " *batch *idle(300)";
    $clobIn = getxml2();
    break;
  case 2:
    echo "IN/OUT CALL getxml3 (ZZCALL): Doing something else waiting for batch ...";
    $ctl = $ctlstart;
    $clobIn = getxml3();
    break;
  case 3:
  case 4:
    echo "OUTPUT GET BATCH (wrkactjob/ls): Waiting for batch ...";
    $ctl = $ctlstart . " *get *wait(10)";
    $clobIn = "<?xml version='1.0'?>";
    break;
  default:
    echo "OUTPUT BATCH (empty batch): Waiting for batch ...";
    $ctl = $ctlstart . " *get *wait(10)";
    $clobIn = "<?xml version='1.0'?>";
    break;
}
echo "ctl = $ctl\n";
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
// ------------------
// output processing
// ------------------
switch($i) {
  case 0:
    var_dump($clobOut);
    break;
  case 1:
    var_dump($clobOut);
    break;
  case 2:
    if (strpos($clobOut,"<data type='12p2' var='INDS1.DSDEC2'>")>0) {
      echo "Good:\n".substr($clobOut,-200)."\n";
    }
    else {
      var_dump($clobOut);
      die("FAIL");
    }
    break;
  case 3:
  case 4:
    if (strpos($clobOut,"</sh>")>0) {
      echo "Good:\n".substr($clobOut,-200)."\n";
    }
    else {
      var_dump($clobOut);
      die("FAIL");
    }
    break;
  default:
    if (strlen($clobOut)>300) echo substr($clobOut,-200)."\n";
    else var_dump($clobOut);
    break;
}
}
// good
echo "Success (PASE sh)\n";

function getxml1() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sh rows='on'>/QOpenSys/usr/bin/system -i 'wrkactjob'</sh>
</script>
ENDPROC;
return $clob;
}

function getxml2() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<sh>/QOpenSys/usr/bin/ls /tmp</sh>
</script>
ENDPROC;
return $clob;
}

function getxml3() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZCALL' lib='xyzlibxmlservicexyz'>
 <parm  io='both'>
   <data type='1A' var='INCHARA'>a</data>
 </parm>
 <parm  io='both'>
   <data type='1A' var='INCHARB'>b</data>
 </parm>
 <parm  io='both'>
   <data type='7p4' var='INDEC1'>11.1111</data>
 </parm>
 <parm  io='both'>
   <data type='12p2' var='INDEC2'>222.22</data>
 </parm>
 <parm  io='both'>
  <ds>
   <data type='1A' var='INDS1.DSCHARA'>x</data>
   <data type='1A' var='INDS1.DSCHARB'>y</data>
   <data type='7p4' var='INDS1.DSDEC1'>66.6666</data>
   <data type='12p2' var='INDS1.DSDEC2'>77777.77</data>
  </ds>
 </parm>
 <return>
  <data type='10i0'>0</data>
 </return>
</pgm>
</script>
ENDPROC;
return test_lib_replace($clob);
}

?>

--EXPECTF--
%s
Success (%s)

