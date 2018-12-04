--TEST--
XML i Toolkit: - cwtest system value
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');

echo h2('Get system value');
$start = microtime(true);
$date = i5_get_system_value('QDATE');
$end = microtime(true);
$elapsed = $end - $start;
echo "QDATE system value: '$date', obtained in $elapsed seconds.<BR>";


// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

