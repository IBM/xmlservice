--TEST--
XML i Toolkit: IBM_DB2 check bad pgm resolve error default
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// -----------------
// make the call
// -----------------
// see connection.inc param details ...
require_once('connection.inc');
// call IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Fail connect: $database,$user");
$stmt = db2_prepare($conn, "call $procLib.iPLUG512K(?,?,?,?)");
if (!$stmt) die("Fail prepare: ".db2_stmt_errormsg());
$clobIn = getxml();
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Fail execute: ".db2_stmt_errormsg());
// -----------------
// output processing
// -----------------
// dump raw XML (easy test debug)
// var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Fail XML returned\n");
// -----------------
// output error report
// -----------------
$allerrors = $xmlobj->xpath('/report/error');
if (!$allerrors) die("Fail XML errors missing\n");
$expect = "resolve failed";
$good = false;
foreach ($allerrors as $error) {
  echo "***** error *****\n";
  echo "-errnoile: ".(string)$error->errnoile."\n";
  echo "-errnopase: ".(string)$error->errnopase."\n";
  echo "-errnoxml: ".(string)$error->errnoxml."\n";
  echo "-xmlerrmsg: ".(string)$error->xmlerrmsg."\n";
  echo "-xmlhint: ".(string)$error->xmlhint."\n";
  if (strpos((string)$error->xmlerrmsg,$expect)) $good=true;
}
if (!$good) die("Fail XML error missing ($expect)");

// good
echo "Success ($expect)\n";

function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0' encoding='ISO-8859-1' ?>    
<script>
<pgm name='TEST_100' lib='ZENDSVR'>
<parm comment='p1' io='both'>
 <data type='500A' var='p1' ><![CDATA[AAA \<TABLE\>]]></data>           
</parm>
<parm comment='p2' io='both'>
 <data type='500A' var='p2' ><![CDATA[ ]]></data>           
</parm>
</pgm>
</script>
ENDPROC;
$test = simplexml_load_string($clob);
if (!$test) die("bad xml");
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success (%s)

