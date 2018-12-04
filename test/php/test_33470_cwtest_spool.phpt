--TEST--
XML i Toolkit: - cwtest spool
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');

if ($doSpooledFiles) {

echo h2('Spooled Files');

$splUser = 'QTMHHTTP';
echo "Get up to 5 spooled files for user $splUser<BR>";
$list = i5_spool_list(array(I5_USERNAME=>$splUser), $conn);
if (!$list) {
	echo 'Error getting spool list: ' . printArray(i5_error()) . '<BR>';
    die();
} else {
        $spoolCount = 0;
	    while (($listItem = i5_spool_list_read($list)) && (++$spoolCount <= 5)) {
	        echo "<BR>list item: " . printArray($listItem) . "<BR>";
	        echo '<BR>Output data for this spool file: <BR>';
	        $data = i5_spool_get_data($listItem['SPLFNAME'],
	                                  $listItem['JOBNAME'],
	                                  $listItem['USERNAME'],
	                                  $listItem['JOBNBR'],
	                                  $listItem['SPLFNBR']);
	        if (!$data) {
	        	echo '<BR>No spool data. Error info: ' . printArray(i5_error()) . '<BR>';
	        } else {
	        	echo "<PRE>$data</PRE><BR>";
	        } //(if data)
	        
	    }    	
}
i5_spool_list_close($list);


$outq = 'QGPL/QPRINT';
echo "<BR>Get up to 5 spooled files for outq $outq (may get permissions message if user's authority is insufficient)<BR>";
$list = i5_spool_list(array(I5_OUTQ=>$outq), $conn);
if (!$list) {
	echo 'Error getting spool list: ' . printArray(i5_error()) . '<BR>';
    die();
} else {

        $spoolCount = 0;
	    while (($listItem = i5_spool_list_read($list)) && (++$spoolCount <= 5)) {
	
	        echo "<BR>list item: " . printArray($listItem) . "<BR>";
	        echo '<BR>Output data for this spool file: <BR>';
	        $data = i5_spool_get_data($listItem['SPLFNAME'],
	                                  $listItem['JOBNAME'],
	                                  $listItem['USERNAME'],
	                                  $listItem['JOBNBR'],
	                                  $listItem['SPLFNBR']);
	        if (!$data) {
	        	echo '<BR>No spool data. Error info: ' . printArray(i5_error()) . '<BR>';
	        } else {
	        	echo "<PRE>$data</PRE><BR>";
	        } //(if data)
	        
	    } //(while spool files) 	
}
i5_spool_list_close($list);


} //(spooled files)


// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

