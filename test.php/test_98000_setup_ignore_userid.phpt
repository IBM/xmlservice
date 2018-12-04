--TEST--
XML i Toolkit: IBM_Db2 ignore userid - setup special ibm_db2.ini
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
echo "set up ibm_db2.i5_ignore_userid=1 ... \n";
ibm_db2_IgnoreOn(); // ibm_db2.i5_ignore_userid=1
// good
echo "Success\n";
?>
--EXPECTF--
%s
Success


