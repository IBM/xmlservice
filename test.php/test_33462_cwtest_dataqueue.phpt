--TEST--
XML i Toolkit: - cwtest data queue
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');


// data queue
if ($doDataQueue) {

	echo h2('Data queues');
	
	$queueName = 'KEYEDQ';
	$keyLen = 10;
	$qObj = new DataQueue($conn);
	echo "<BR>About to delete data queue $queueName. (Will fail if doesn't exist yet)<BR>";
	try {
	    $qObj->DeleteDQ($queueName, $demoLib);
	    echo "Success deleting data queue $queueName.";
	} catch (Exception $e) {
		echo("Error deleting data queue: " . $e . "<BR><BR>");
	}
	
	echo "<BR>About to create data queue $queueName.<BR>";
	try {
	    $qObj->CreateDataQ($queueName, $demoLib, 128, '*KEYED', $keyLen); // length 10 key
	    echo "Success creating data queue $queueName.";
	} catch (Exception $e) {
		die("Error creating data queue: " . $e . "<BR><BR>");
	}
	
	// test case adapted from p398 of Zend Server 5.1 manual
	$simpleStructure = 
	array(
  'DSName' => 'PS',
  'DSParm' => 
  array (
   
    array (
      'type' => 0,
      'name' => 'PS1',
      'length' => '10',
    ),
   
    array (
      'type' => 6,
      'name' => 'PS2',
      'length' => '10.4',
    ),
   
    array (
      'type' => 0,
      'name' => 'PS3',
      'length' => '10',
    ),
  )
);
	// prepare
	$queue = i5_dtaq_prepare("$demoLib/$queueName", $simpleStructure, $keyLen);
    if (!$queue) {
    	die("Error preparing data queue.<BR><BR>");
    }	


    // send
    $key = 'abc';
	$data = array('PS1' => 'test1', 'PS2' => 13.1415, 'PS3' => 'test2');
    
    echo "<BR>About to send simple structure to keyed data queue $queueName with key $key.<BR>";
	$success = i5_dtaq_send($queue, $key, $data);
	// 
	if (!$success) {
		die("Error returned from data queue send: " . printArray(i5_error()) . "<BR><BR>");
	} else {
		echo "Success sending data to data queue.<BR><BR>";
	}

    echo "<BR>About to receive simple structure from keyed data queue $queueName with key $key.<BR>";
	$data = i5_dtaq_receive($queue, 'EQ', $key);
	
	// receive
	if (!$data) {
		die("Error returned from simple data queue receive: " . printArray(i5_error()));
	} else {
		echo "Success getting simple data structure from data queue: " . printArray($data);
	}
		
	echo '<BR>';
	
	// unkeyed queue with complex structure
	
	$queueName = 'NEWQ';
	$qObj = new DataQueue($conn);
	echo "<BR>About to delete data queue $queueName. (Will fail if doesn't exist yet)<BR>";
	try {
	    $qObj->DeleteDQ($queueName, $demoLib);
	    echo "Success deleting data queue $queueName.";
	} catch (Exception $e) {
		echo("Error deleting data queue: " . $e . "<BR><BR>");
	}
	
	echo "<BR>About to create data queue $queueName.<BR>";
	try {
	    $qObj->CreateDataQ($queueName, $demoLib);
	    echo "Success creating data queue $queueName.";
	} catch (Exception $e) {
		die("Error creating data queue: " . $e . "<BR><BR>");
	}

	
		$bigDesc = array(
array ("DSName"=>"BIGDS", "DSParm"=>array (
array ("Name"=>"P1", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10, "Count"=>5),
array ("Name"=>"P2C", "IO"=>I5_INOUT,"Type"=>I5_TYPE_LONG, "Length"=>4),
array ("Name"=>"P2", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>1, "Count"=>2),
array ("DSName"=>"PS", "Count"=>2, "DSParm"=>array (
array ("Name"=>"PS1", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10),
array ("Name"=>"PS2", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10),
array ("Name"=>"PS3", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10)
))
))
);
	
	
	// prepare
	$queue = i5_dtaq_prepare("$demoLib/$queueName", $bigDesc);
    if (!$queue) {
    	die("Error preparing data queue.<BR><BR>");
    }	
	// send


    // send
    echo "<BR>About to send big data structure to data queue $queueName.<BR>";
	$success = i5_dtaq_send($queue, '', $bigInputValues);
	// 
	if (!$success) {
		die("Error returned from data queue send: " . i5_error() . "<BR><BR>");
	} else {
		echo "Success sending data to data queue.<BR><BR>";
	}
    
    
    echo "<BR>About to receive big data structure from data queue $queueName.<BR>";
	$data = i5_dtaq_receive($queue);//, $operator = null, $key = '', $timeout = 0)
	
	// receive
	if (!$data) {
		die("Error returned from data queue receive: " . printArray(i5_error()));
	} else {
		echo "Success getting data from data queue: " . printArray($data);
	}
		
	echo '<BR>';
	
	
	// Now a short-form DQ test
	
	// short-form description
	$littleDesc = array ("Name"=>"sometext", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>20);
	$littleInput = "Small text input";
	
	echo "<BR>About to send small short-form data structure to data queue $queueName.<BR>";
	
	// prepare
	$queue = i5_dtaq_prepare("$demoLib/$queueName", $littleDesc);
    if (!$queue) {
    	die("Error preparing data queue.<BR><BR>");
    }	

    // send
	$success = i5_dtaq_send($queue, '', $littleInput);
	// 
	if (!$success) {
		die("Error returned from data queue send of small input: " . i5_error() . "<BR><BR>");
	} else {
		echo "Success sending the string '$littleInput' to data queue.<BR><BR>";
	}
    
    
    echo "<BR>About to receive small data structure from data queue $queueName.<BR>";
	$data = i5_dtaq_receive($queue);//, $operator = null, $key = '', $timeout = 0)
	// receive
	if (!$data) {
		die("Error returned from data queue receive of small data: " . i5_error() . "<BR><BR>");
	} else {
		echo "Success getting small data from data queue: '$data'<BR><BR>";
	}
	
	echo '<BR><BR>';
	
	// end, short-form DQ test
	
	
} //(data queue)



// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

