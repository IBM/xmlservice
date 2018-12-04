--TEST--
XML i Toolkit: - cwtest job list
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');

// job list

if ($doJobLists) {

echo h2('Job lists');
	
echo "About to get up to 5 jobs with jobname ZENDSVR (can also do I5_JOBUSER, I5_USERNAME, I5_JOBNUMBER, and I5_JOBTYPE).<BR>";

$list = i5_job_list(array(I5_JOBNAME=>'ZENDSVR'));
if (!$list) {
	echo 'Error getting job list: ' . printArray(i5_error()) . '<BR>';
    die();
} else {
    $jobCount = 0;
    while (($listItem = i5_job_list_read($list)) && (++$jobCount <= 5)) {
			echo printArray($listItem) .  '<BR>';
	}
	echo 'End of list.<BR><BR>';
}
i5_job_list_close($list);


// Get info about current job
echo "Getting information about current job.<BR>";
$list = i5_job_list();//array(I5_USERNAME=>'*ALL'), $conn);
if (!$list) {
	echo 'Error getting job list: ' . printArray(i5_error()) . '<BR>';
    die();
} else {
	     // should be only one for current job.
	    $listItem = i5_job_list_read($list);
	    echo "<BR>list item for current job: " . printArray($listItem) . "<BR><BR>"; 
	    echo "Job name: {$listItem[I5_JOB_NAME]} user: {$listItem[I5_JOB_USER_NAME]} job number: {$listItem[I5_JOB_NUMBER]}<BR><BR>";
}
i5_job_list_close($list);

} //(if do job lists)




// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

