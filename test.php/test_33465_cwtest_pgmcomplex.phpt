--TEST--
XML i Toolkit: - cwtest pgm complex
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');

// *** data structure call! ***

if ($doPgmCallComplex) {

echo '<BR>Program call with complex parameters<BR>';	
	
$progname = "$demoLib/RPCTEST";

echo "<b>About to call $progname with data structure parameters.</b>";

/*Call a program with parameters that include a DS */

$desc = array (
array ("Name"=>"P1", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10, "Count"=>5),
array ("Name"=>"P2C", "IO"=>I5_INOUT,"Type"=>I5_TYPE_LONG, "Length"=>4),
array ("Name"=>"P2", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>1, "CountRef"=>"P2C" ),
array ("DSName"=>"PS", "Count"=>2, "DSParm"=>array (
array ("Name"=>"PS1", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10),
array ("Name"=>"PS2", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10),
array ("Name"=>"PS3", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10)
)
));

$prog = i5_program_prepare($progname, $desc);
if ($prog === FALSE) {
	$errorTab = i5_error();
	echo "Program prepare failed <br>\n";
	var_dump($errorTab);
	die();
}
/* Execute Program */

// The nameless elements in array.
$params1 = array(
array("PS1"=>"test1", "PS2"=>"test2", "PS3"=>"test3"),
array("PS1"=>"test3", "PS2"=>"test4", "PS3"=>"test5")
);

$params2 = Array(
"P1"=>array("t1", "t2", "t3", "t4", "t5"),
"P2C"=>2,
"P2"=>array("a", "b"),
"PS"=>$params1);
$retvals = array("P1"=>"P1", "PS"=>"PS", "P2"=>"P2", "P2C"=>"P2C");

$ret = i5_program_call($prog, $params2, $retvals) ;
if (function_exists('i5_output')) extract(i5_output()); // i5_output() required if called in a function

if ($ret === FALSE)
{
$errorTab = i5_error();
echo "FAIL : i5_program_call failure message: " . $conn->getLastError() . " with code <br>";
var_dump($errorTab);
die();
}else {
    // success
    echo "<BR><BR>Success! The return values are: <br>";
    echo "P1 : " . printArray($P1) . "<BR>";
    echo "P2C : " . $P2C . "<BR>";
    echo "P2 : " . printArray($P2) . "<BR>";
    echo "PS: " . printArray($PS) . "<BR>";
}
$close_val = i5_program_close ($prog);
if ($close_val === false )
{
print ("FAIL : i5_program_close returned fales, closing an open prog.<br>\n");
$errorTab = i5_error();
var_dump($errorTab);
die();
}

} //(pgmcall complex)


// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

