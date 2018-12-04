--TEST--
XML i Toolkit: - cwtest user space
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');

$bigDesc = array(
array ("DSName"=>"BIGDS", "DSParm"=>array (
array ("Name"=>"P1", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10, "Count"=>5),
array ("Name"=>"P2C", "IO"=>I5_INOUT,"Type"=>I5_TYPE_LONG, "Length"=>4),
array ("Name"=>"P2", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>1, "CountRef"=>"P2C" ),
array ("DSName"=>"PS", "Count"=>2, "DSParm"=>array (
array ("Name"=>"PS1", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10),
array ("Name"=>"PS2", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10),
array ("Name"=>"PS3", "IO"=>I5_INOUT, "Type"=>I5_TYPE_CHAR, "Length"=>10)
)
)))
);

$bigInputValues = array(
"BIGDS"=>array(
"P1"=>array("t1", "t2", "t3", "t4", "t5"),
"P2C"=>2,
"P2"=>array("a", "b"),
"PS"=>array(
array("PS1"=>"test1", "PS2"=>"test2", "PS3"=>"test3"),
array("PS1"=>"test3", "PS2"=>"test4", "PS3"=>"test5")
)
));
	
	
if ($doUserSpace) {
echo h2('User spaces');	
	
$userSpaceName = 'DEMOSPACE';
$userSpaceLib = $demoLib;

$usObj = new UserSpace($conn);
$usObj->setUSName($userSpaceName, $userSpaceLib); 

// toolkit does not have an i5_userspace_delete so delete with a command.
$ret = i5_command("DLTUSRSPC USRSPC($userSpaceLib/$userSpaceName)");
if (function_exists('i5_output')) extract(i5_output()); // i5_output() required if called in a function

$status = ($ret) ? 'successfully' : 'badly';
echo "deleted user space: $status<BR>";
//$us = $usObj->CreateUserSpace('ALANUS', 'ALAN', $InitSize =1024, $Authority = '*ALL', $InitChar=' ' );
$usProperties = array(I5_NAME=>$userSpaceName, I5_LIBNAME=>$userSpaceLib, I5_INIT_VALUE=>'Y');
echo "About to create user space.<BR>";
$us = i5_userspace_create($usProperties, $conn);
if (!$us) {
	die("Error returned: " . printArray(i5_error()) . "<BR><BR>");
} else {
	echo "Success!<BR><BR>";
}

// prepare userspace for a put
$us = i5_userspace_prepare("$userSpaceLib/$userSpaceName", $bigDesc, $conn);
if (!$us) {
	die("Error returned from user space prepare $userSpaceLib/$userSpaceName: " . printArray(i5_error()) . "<BR><BR>");
} else {
	echo "Success preparing user space.<BR><BR>";
}

// do the userspace put
$success = i5_userspace_put($us, $bigInputValues);
if (!$success) {
	die("Error returned from user space put: " . printArray(i5_error()) . "<BR><BR>");
} else {
	echo "Success putting data into user space.<BR><BR>";
}

// do the userspace get
// removed counfref because doesn't work when getting.
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

/*
*/

// prepare userspace for a get
$us = i5_userspace_prepare("$userSpaceLib/$userSpaceName", $bigDesc, $conn);
if (!$us) {
	die("Error returned from user space prepare: " . printArray(i5_error()) . "<BR><BR>");
} else {
	echo "Success preparing user space.<BR><BR>";
}


$success = i5_userspace_get($us, array("BIGDS"=>"BIGDS"));
if (function_exists('i5_output')) extract(i5_output()); // i5_output() required if called in a function

if (!$success) {
	die("Error returned from user space get: " . i5_error() . "<BR><BR>");
} else {
	echo "Success getting data from user space. BIGDS=" . printArray($BIGDS) . "<BR><BR>";
}
	

} //(user space)
	


// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

