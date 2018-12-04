--TEST--
XML i Toolkit: - cwtest object list
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');

if ($doObjectList) {
	
	echo h2('Object lists');

	echo "About to do object list with '$demoLib', '*ALL','*PGM'<BR>";
// object list
$list = i5_objects_list($demoLib, '*ALL', '*PGM', $conn); 
if (!$list) {
	die('Error getting object list: ' . printArray(i5_error()) . '<BR><BR>');
	
} else {
    
	while ($listItem = i5_objects_list_read($list)) {
			echo printArray($listItem);
	}
	echo 'End of list. Error information: ' . printArray(i5_error()) . '<BR><BR>';
}
i5_objects_list_close($list);

} // doObjectList


// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

