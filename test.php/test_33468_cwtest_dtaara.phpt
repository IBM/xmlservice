--TEST--
XML i Toolkit: - cwtest dtaara
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');

echo h2('Data areas');
$dtaara = "$demoLib/ALLEYOOP";
$ret = i5_data_area_create($dtaara, 72); 
if ($ret) {
	echo "Created data area $dtaara successfully.<BR>";
} else {
	echo "Could not create data area $dtaara.<BR>";
    die();
}

$ret = i5_data_area_delete($dtaara); 
if ($ret) {
	echo "Deleted data area $dtaara successfully.<BR>";
} else {
	echo "Could not delete data area $dtaara.<BR>";
    die();
}

$dtaara = 'BETTYBOOP';
$ret = i5_data_area_create($dtaara, 100); 
if ($ret) {
	echo "Created data area $dtaara successfully.<BR>";
} else {
	echo "Could not create data area $dtaara. Reason: " . i5_errormsg() . " (it may already exist)<BR>";
}

$dtaara = 'BETTYBOOP';
$stringToWrite = 'Very nice';
$ret = i5_data_area_write($dtaara, $stringToWrite, 5, 20); 
if ($ret) {
	echo "Wrote '$stringToWrite' to data area $dtaara successfully.<BR>";
	
	// try to read now.
	$start = microtime(true);
	$readData = i5_data_area_read($dtaara, 3, 40);
	$end = microtime(true);
	$elapsed = $end - $start;

    if ($readData) {
    	echo "Read a portion of '$readData' from data area $dtaara successfully in $elapsed seconds.<BR>";
    } else {
    	echo "Could not read from data area $dtaara. Reason: " . i5_errormsg() . "<BR>";
        die();
    }	
	
	// try to read now.
	$start = microtime(true);
	$readData = i5_data_area_read($dtaara); // the whole thing
	$end = microtime(true);
	$elapsed = $end - $start;

    if ($readData) {
    	echo "Read ALL of '$readData' from data area $dtaara successfully in $elapsed seconds.<BR>";
    } else {
    	echo "Could not read from data area $dtaara. Reason: " . i5_errormsg() . "<BR>";
        die();
    }	
	
    

} else {
	echo "Could not write to data area $dtaara. Reason: " . i5_errormsg() . "<BR>";
    die();
}


// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

