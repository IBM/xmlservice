--TEST--
XML i Toolkit: CTL - kill server
--SKIPIF--
<?php require_once('skipifrest.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
ibm_db2_IgnoreOff(); // remove ibm_db2.i5_ignore_userid=1

$ipc2    = "/tmp/ipc_cw_".$user."_42"; // cw tests

$allipc = array($ipc,$ipc2,$ipcover);

foreach ($allipc as $ipc) {


// call IBM i
$ctl = "*immed"; // kill XMLSERVICE NOW
$clobIn = "<?xml version='1.0'?>"; // XML in
$parm  = "?db2=$i5restdb";
$parm .= "&uid=$user";
$parm .= "&pwd=$password";
$parm .= "&ipc=$ipc";
$parm .= "&ctl=$ctl";
$parm .= "&xmlin=".urlencode($clobIn);
$parm .= "&xmlout=32768";  // size expected XML output
// execute
$linkall = "$i5resturl".htmlentities($parm);
$getOut = simplexml_load_file($linkall);

}

echo "i am ...\n";
echo "dead\n";
?>
--EXPECTF--
%s
dead

