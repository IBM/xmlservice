--TEST--
XML i Toolkit: - cwtest pgm simple
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');

if ($doPgmCallSimple) {

	echo h2('Program calls');
    echo 'Program call with simple parameters<BR>';
	
$progname = "$demoLib/TESTSTP2";

$desc = array (
array ("Name"=>"code", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>"10"),
array ("Name"=>"name", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>"10")
);
$desc = Array (
             0 => Array ( 'type' => 0, 'name' => 'code', 'length' => 10, 'io' => 3 ), 
             1 => Array ( 'type' => 0, 'name' => 'name', 'length' => 10, 'io' => 3 ) ) ;
echo "<b>About to call $progname with two char parameters.</b><BR>";

$prog = i5_program_prepare($progname, $desc);
if ($prog === FALSE) {
	$errorTab = i5_error();
	echo "Program prepare failed <br>\n";
	var_dump($errorTab);
	die();
}
/* Execute Program */
$params = array ("code"=>"123","name"=>"ABC");
$retvals = array("code"=>"code","name"=>"name");
$ret = i5_program_call($prog, $params, $retvals) ;
if (function_exists('i5_output')) extract(i5_output()); // i5_output() required if called in a function

if ($ret === FALSE)
{
$errorTab = i5_error();
echo "FAIL : i5_program_call failure message: " . $conn->getLastError() . " with code <br>";
var_dump($errorTab);
die();
}else {
    // success
    echo "Success! The return values are: <br>", "Name: ", $name, "<br> Code: ", $code, "<br><BR>";
}
$close_val = i5_program_close ($prog);
if ($close_val === false )
{
print ("FAIL : i5_program_close returned fales, closing an open prog.<br>\n");
$errorTab = i5_error();
var_dump($errorTab);
die();
}


} // (simple call)

// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

