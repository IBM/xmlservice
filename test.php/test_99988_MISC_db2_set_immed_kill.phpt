--TEST--
XML i Toolkit: CTL - kill server
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
ibm_db2_IgnoreOff(); // remove ibm_db2.i5_ignore_userid=1

$ipc2    = "/tmp/ipc_cw_".$user."_42"; // cw tests
$ipc3    = "/tmp/Toolkit"; // cw or toolkit tests

// call IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) {
  echo("Bad connect: $database,$user");
  continue;
}

$allipc = array($ipc,$ipc2,$ipcover,$ipc3);

foreach ($allipc as $ipc) {

$ctl = "*immed"; // kill XMLSERVICE NOW
$clobIn = "";
$sql = "call $procLib.iPLUGR4K('$ipc','$ctl','$clobIn')";
$stmt=db2_exec($conn,$sql);
if (!$stmt) echo("Bad execute ($database,$user): ".db2_stmt_errormsg());
$ret=db2_free_stmt($stmt);
if (!$ret) echo("Bad free stmt ($database,$user): ".db2_stmt_errormsg());

}

if ($i5persistentconnect) $ret=db2_pclose($conn);
else $ret=db2_close($conn);
if (!$ret) echo("Bad close ($database,$user): ".db2_stmt_errormsg());
echo "i am ...\n";
echo "dead\n";

?>
--EXPECTF--
%s
dead

