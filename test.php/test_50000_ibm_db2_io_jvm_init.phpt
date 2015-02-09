--TEST--
XML i Toolkit: IBM_DB2 inout create JVM test
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
require_once('connection.inc');
require_once("ToolkitService.php");

// IBM i
$conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");

// force schema
$r = db2_exec($conn, "set schema xmlservice");

// java stored procedure 1
$r = db2_exec($conn, "create procedure gc() language java parameter style java external name 'java.lang.System.gc'");
$stmt = db2_exec($conn, "call gc()");
if (!$stmt) die("Failed: call gc");

// java UDF
$r = db2_exec($conn, "create function getProperty(prop varchar(1024)) returns varchar(1024) language java parameter style java external name 'java.lang.System.getProperty'");
$stmt = db2_exec($conn, "select getProperty('java.class.path') from sysibm.sysdummy1");
if (!$stmt) die("Failed: select getProperty");
while ($row = db2_fetch_array($stmt)) { var_dump($row); echo "\n"; }

// java stored procedure 2
$r = db2_exec($conn, "create procedure sleeper(millis BIGINT) language java parameter style java external name 'java.lang.Thread.sleep'");
$stmt = db2_exec($conn, "call sleeper(2)");
if (!$stmt) die("Failed: call sleeper(2)");


echo "Success\n";
?>
--EXPECTF--
%s
Success


