--TEST--
XML i Toolkit: - cwtest job log list
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');

// job log.
if ($doJobLogs) {

echo h2('Job logs');	
	
// Try current job. Good, it works, except for not enough data coming back from PHP wrapper.
echo "About to get joblog (partial data) for current job<BR>";
$list = i5_jobLog_list();
if (!$list) {
	echo 'No joblogs found<BR>';
} else {
	
    while ($listItem = i5_jobLog_list_read($list)) {
			echo printArray($listItem);
	}
	echo '<BR>End of list.<BR><BR>';
}
i5_jobLog_list_close($list);

} //(if do joblogs)


// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

