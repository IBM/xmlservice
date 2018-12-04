--TEST--
XML i Toolkit: IBM_Db2 ignore userid - reset to normal
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
echo "reset ibm_db2.i5_ignore_userid=1 to normal ... \n";
ibm_db2_IgnoreOff();
// good
echo "Success\n";
?>
--EXPECTF--
%s
Success


