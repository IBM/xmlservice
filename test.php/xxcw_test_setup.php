<?php 
// see connection.inc param details ...
require_once('connection.inc');
require_once('CW/cw.php'); // don't need if added auto_append in PHP.INI


// some items to turn on and off in the test
$doPcml = true;
$doUserSpace = true;
$doDataQueue = true;
$doPgmCallComplex = true;
$doPgmCallSimple = true;
$doObjectList = true;
$doJobLists = true;
$doJobLogs = true;
$doSpooledFiles = true;
$doAdoptAuthority = true;

// Use configurable demo lib/name from toolkit ini
$demoLib = trim(getConfigValue('demo', 'demo_library'));
if (!$demoLib) {
   die('Demo library not set in toolkit.ini.');
}

// Use configurable encoding from toolkit ini
// We use encoding in meta tag so characters appear correctly in browser
$encoding = trim(getConfigValue('system', 'encoding'));
if (!$encoding) {
   die('Encoding not set in toolkit.ini. Example: ISO-8859-1');
}

// optional demo values
$setLibList = trim(getConfigValue('demo', 'initlibl', ''));
$setCcsid = trim(getConfigValue('demo', 'ccsid', ''));
$setJobName = trim(getConfigValue('demo', 'jobname', ''));
$setIdleTimeout = trim(getConfigValue('demo', 'idle_timeout', ''));

// optional demo connection values
if (!isset($private)) {
$private = false; // default
$privateNum = false;
$persistent = false;
if ($persistent) {
	// private can only happen with persistence
    $private = trim(getConfigValue('demo', 'private', false));
    $privateNum = trim(getConfigValue('demo', 'private_num', '0'));
} //(persistent)
}

$scriptTitle = 'Test script for IBM i Compatibility Wrapper (CW)';

function OkBad($success = false) {
	if ($success) {
		return 'Successful';
	} else {
		return 'Failed with this error: ' . print_r(i5_error(), true);
	}
} //(OkBad)
function printArray($array) 
{
	return '<PRE>' . print_r($array, true) . '</PRE>';
}

function h1($headString) {
	return "<h1>$headString</h1>";
}

function h2($headString) {
	return "<h2>$headString</h2>";
}

echo h1($scriptTitle);

echo h2('Version check');

// display CW version or warning message.
$downloadSite = 'http://www.youngiprofessionals.com/wiki/XMLSERVICE';
$downloadLink = '<a href="' . $downloadSite . '" target="_blank">' . $downloadSite . '</a>';
if (function_exists('i5_version')) {
	echo "You are running CW version <b>" . i5_version() . "</b>.\n Any updates will be found at $downloadLink.\n";
} else {
	echo "This version of CW is out of date.\nPlease download the latest CW from $downloadLink.\n\n";
} //(if i5_version function exists)

echo h2('Connection');

// choose connection function based on persistence choice
$connFunction = ($persistent) ? 'i5_pconnect' : 'i5_connect';

echo "About to connect with $connFunction($cwdb, $user, xxxxx)";

// options (liblist, ccsid, jobname) can be changed by the user in toolkit.ini.
$options = array();
if ($setLibList) {
	$options[I5_OPTIONS_INITLIBL] = $setLibList;
	echo "I5_OPTIONS_INITLIBL = '$setLibList'\n";
}
if ($setCcsid) {
	$options[I5_OPTIONS_RMTCCSID] = $setCcsid;
	echo "I5_OPTIONS_RMTCCSID = '$setCcsid'\n";
}
if ($setJobName) {
	$options[I5_OPTIONS_JOBNAME] = $setJobName;
	echo "I5_OPTIONS_JOBNAME = '$setJobName'\n";
}
if ($setIdleTimeout) {
	$options[I5_OPTIONS_IDLE_TIMEOUT] = $setIdleTimeout;
	echo "I5_OPTIONS_IDLE_TIMEOUT = '$setIdleTimeout'\n";
}

if ($persistent && $private) {
	$options[I5_OPTIONS_PRIVATE_CONNECTION] = $privateNum;
	echo "I5_OPTIONS_PRIVATE_CONNECTION = '$privateNum'\n";
} // (private and privateNum)

echo '\n';
echo "setup CW private = $private\n";
echo "setup CW privateNum = $privateNum\n";
echo "setup CW persistent = $persistent\n";

/*
 * // Optionally re-use an existing database connection for your transport
 * // If you specify a naming mode (i5/sql) in your connection, make sure they match.
 * $namingMode = DB2_I5_NAMING_ON;
 * $existingDb = db2_pconnect('', '','', array('i5_naming' => $namingMode));
 * // Add to existing connection options                 
 * $options[CW_EXISTING_TRANSPORT_CONN] = $existingDb;
 * $options[CW_EXISTING_TRANSPORT_I5_NAMING] = $namingMode;
*/

$start = microtime(true);

// about to connect. Can use i5_connect or i5_pconnect.                
$conn = $connFunction($cwdb, $user, $password, $options);
$end = microtime(true);
$elapsed = $end - $start;
echo "Ran $connFunction function, with options, in $elapsed seconds.\n";

// if unable to connect, find out why.
if (!$conn) {
    die('\nCould not connect. Reason: ' . printArray(i5_error()));	
} 

echo "Connection object output: '$conn'\n\n";

if ($private) {
	// if a private connection, show what number was used or generated.
    $privateConnNum = i5_get_property(I5_PRIVATE_CONNECTION, $conn);
    echo "Private conn number from i5_get_property(I5_PRIVATE_CONNECTION, \$conn): $privateConnNum\n\n";

    $isNew = i5_get_property(I5_NEW_CONNECTION, $conn);
    echo "Is new connection?: $isNew\n\n";
} //($private)


// CONNECTED. 

// check that demo library exists
echo "About to verify that the demo library, '$demoLib', exists.\n";
$list = i5_objects_list('QSYS', $demoLib, '*LIB', $conn); 
if (!$list) {
	echo 'Error getting object list: ' . printArray(i5_error()) . '\n\n';
} else {
    if ($listItem = i5_objects_list_read($list)) {
	    echo "Demo library '$demoLib' exists.\n\n";
	} else {
	    die ("\nDemo library '$demoLib' NOT found. Ending.");
	} //(if object was read)
} //(if !$list)

i5_objects_list_close($list);

// ON TO ACTUAL FUNCTIONALITY
?>
