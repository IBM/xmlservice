--TEST--
XML i Toolkit: - cwtest commands
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');


echo h2('Commands');

$msg = 'HELLO';
$cmdString = "SNDMSG MSG($msg) TOUSR($user)";
$start = microtime(true);
$commandSuccessful = i5_command($cmdString, array(), array(), $conn);
$end = microtime(true);
$elapsed = $end - $start;
echo "Ran command $cmdString using a single string in $elapsed seconds. Return: " . OkBad($commandSuccessful) . "<BR><BR>";

$badUser = 'jerk';
$msg = 'HELLO';
$cmdString = "SNDMSG MSG($msg) TOUSR($badUser)";
$start = microtime(true);
$commandSuccessful = i5_command($cmdString, array(), array(), $conn);
$end = microtime(true);
$elapsed = $end - $start;
echo "Ran command $cmdString using a single string to BAD user in $elapsed seconds.. Return: " . OkBad($commandSuccessful). "<BR>";
if (!$commandSuccessful) {
	echo "Error returned: " . printArray(i5_error()) . "<BR><BR>";
}

$cmdString = 'RTVJOBA';
$input = array();
// we want variable name ccsid to be created
$output = array('ccsid'    => array('ccsid', 'dec(5 0)'),
                'dftccsid' => array('defaultCcsid', 'dec(5 0)'),
                'curuser'=>'currentUser', 'nbr'=>'jobNumber', 'job'=>'jobName', 'user'=>'jobUser',
                               'usrlibl' => 'userLibl');
$start = microtime(true);
$commandSuccessful = i5_command($cmdString, $input, $output, $conn);
if (function_exists('i5_output')) extract(i5_output()); // i5_output() required if called in a function
$end = microtime(true);

$elapsed = $end - $start;

echo "Ran command $cmdString with an output array in $elapsed seconds. Return: " . 
     OkBad($commandSuccessful) . 
     " with CCSID '$ccsid', default CCSID '$defaultCcsid', current user '$currentUser', job name '$jobName', job number '$jobNumber', job user '$jobUser', with user liblist '$userLibl'.<BR><BR>";

// Note: old toolkit cannot get interactive output of this sort (DSPJOBLOG). This is additional functionality of the new toolkit.
$cmdString ="DSPJOBLOG JOB($jobNumber/$jobUser/$jobName)";
echo "About to run " . $cmdString .".<BR>";
$conn->setToolkitServiceParams(array('plug'=>'iPLUG5M')); // bigger to handle large joblog
$interactiveOutput = $conn->CLInteractiveCommand($cmdString);
$conn->setToolkitServiceParams(array('plug'=>'iPLUG512K')); // put back to default
echo printArray($interactiveOutput) . "<BR><BR>";

$msg = 'HELLO_WITH_INPUTS_ARRAY';
$cmdString = "SNDMSG";
$inputs = array('MSG'=>$msg, 'TOUSR'=>$user);
$commandSuccessful = i5_command($cmdString, $inputs);
echo "Ran command $cmdString with an input array: " . printArray($inputs) . "Return:  " . OkBad($commandSuccessful) . ".<BR><BR>";

$msg = "MixedCaseNoSpaces";
$cmdString = "SNDMSG";
$inputs = array('MSG'=>$msg, 'TOUSR'=>$user);
$commandSuccessful = i5_command($cmdString, $inputs);
echo "Ran command $cmdString with an input array: " . printArray($inputs) . "Return:  " . OkBad($commandSuccessful) . ".<BR><BR>";


$msg = "Davey Jones embedded spaces without quotes--caused error in old toolkit";
$cmdString = "SNDMSG";
$inputs = array('MSG'=>$msg, 'TOUSR'=>$user);
$commandSuccessful = i5_command($cmdString, $inputs);
echo "Ran command $cmdString with an input array: " . printArray($inputs) . "Return:  " . OkBad($commandSuccessful) . ".<BR><BR>";

$msg = "O'flanagan single quote--caused error in old toolkit";
$cmdString = "SNDMSG";
$inputs = array('MSG'=>$msg, 'TOUSR'=>$user);
$commandSuccessful = i5_command($cmdString, $inputs);
echo "Ran command $cmdString with an input array: " . printArray($inputs) . "Return: " . OkBad($commandSuccessful) . ".<BR><BR>";

echo h2('Error functions');
echo "Let's test i5_errormsg() and i5_errno()<BR>Get last error message: " . i5_errormsg();
echo "<BR>Get last error number: " . i5_errno(). "<BR><BR>";


// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

