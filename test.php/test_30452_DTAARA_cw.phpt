--TEST--
XML i Toolkit: - CW Toolkit REXX RTVMSG command
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
require_once('CW/cw.php'); // new toolkit compatibility (Alan)

echo "Test of BETTYBOOP";

/* connect */
// this test seems to fail when running localhost
// due to switch CCSID, but works private connect
// $conn = i5_connect("localhost", $user, $password);
$conId = '42';
$conn = i5_pconnect("", $user, $password, array(I5_OPTIONS_PRIVATE_CONNECTION => $conId));
if (!$conn)
{ $tab = i5_error();
  die("Connect: ".$tab[2]." "."$tab[3], $tab[0]");
}


$cmdString = "CHGJOB ccsid(273)";
$start = microtime(true);
$success = i5_command($cmdString, array(), array(), $conn);
$end = microtime(true);
$elapsed = $end - $start;
echo "Ran command $cmdString using a single string in $elapsed seconds. \n";
if ($success) echo "Successful\n";
else echo "Failed with this error: " . print_r(i5_error(), true) . "\n";


$dtaara = "$testLib/BETTYBOOP";

$ret = i5_data_area_delete($dtaara); 
if ($ret) {
	echo "Deleted data area $dtaara successfully.\n";
} else {
	echo "Could not delete data area $dtaara.\n";
}


$ret = i5_data_area_create($dtaara, 100); 
if ($ret) {
	echo "Created data area $dtaara successfully.\n";
} else {
	echo "Could not create data area $dtaara. Reason: " . i5_errormsg() . " (it may already exist)\n";
}

// Ä Ö Ü ä ö ü
$dtaara = "$testLib/BETTYBOOP";
$stringToWrite = 'Ä Ö Ü ä ö ü';
$ret = i5_data_area_write($dtaara, $stringToWrite, 5, 20); 
if ($ret) {
	echo "Wrote '$stringToWrite' ".bin2hex($stringToWrite)." to data area $dtaara successfully.\n";
	// try to read now.
	$start = microtime(true);
	$readData = i5_data_area_read($dtaara, 3, 40);
	$end = microtime(true);
	$elapsed = $end - $start;

    if ($readData) {
    	echo "Read a portion of '$readData' ".bin2hex($readData)." from data area $dtaara successfully in $elapsed seconds.\n";
    } else {
    	echo "Could not read from data area $dtaara. Reason: " . i5_errormsg() . "\n";
        die();
    }
} else {
	echo "Could not write to data area $dtaara. Reason: " . i5_errormsg() . "\n";
    die();
}
	

// good
echo "I have ... \n";
echo "Success\n";
?>
--EXPECTF--
%s
Success

