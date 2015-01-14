--TEST--
XML i Toolkit: - cwtest loop adopt
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');


for ($i=1;$i<100;$i++) {

if ($i % 2) {
// this user, TKITU1, should exist on the system
$user = $adoptuser1;
$testPw = $adoptpass1;
}
else {
// this user, DB2, should exist on the system
$user = $adoptuser2;
$testPw = $adoptpass2;
}


if ($doAdoptAuthority) {

	echo h2("\n\nAdopt authority loop = $i");	
	
	// Note: only works if you've defined $user and $testPw, and created the user profile.
	echo "About to adopt authority to user $user<BR>";
	$start = microtime(true);
	
	$success = i5_adopt_authority($user, $testPw);
    $end = microtime(true);
    $elapsed = $end - $start;

	
	if (!$success) {
	    echo "Error adopting authority: " . printArray(i5_error()) . "<BR>";
        die();
    } else {
    	echo "Success adopting authority in $elapsed seconds<BR>";
    	
    	echo "About to check current user and other variables after adopting authority.<BR>";
    	
    	$cmdString = 'RTVJOBA';
        $input = array();
        
        $output = array('ccsid'    => array('ccsid', 'dec(5 0)'),
                        'dftccsid' => array('defaultCcsid', 'dec(5 0)'),
                        'curuser'=>'currentUser',
                        'nbr'=>'jobNumber',
                        'job'=>'jobName',
                        'user'=>'jobUser',
                        'usrlibl' => 'userLibl');
        $commandSuccessful = i5_command($cmdString, $input, $output, $conn);
        if (function_exists('i5_output')) extract(i5_output()); // i5_output() required if called in a function
        
        echo "Ran command $cmdString. Return: " . OkBad($commandSuccessful) . 
              " with original job user '$jobUser',  current user '$currentUser', CCSID '$ccsid', default CCSID '$defaultCcsid', job name '$jobName', job number '$jobNumber', with user liblist '$userLibl'.<BR><BR>";
    	
    } //(if $success)
	
} //(if ($doAdoptAuthority))

} // loop


// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

