<?php
require_once('connection.inc');
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");
$stmt = db2_prepare($conn, "call $procLib.iPLUG512K(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
$ctl = "*idle(14400/kill) *cdata *sbmjob(ZENDSVR/ZSVR_JOBD/XTOOLKIT) *test";
$ipc = "/tmp/test_RQCYBER";
$clobIn = getxml();
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
var_dump($clobOut);

function getxml() {
$clob = <<<ENDPROC
<?xml version="1.0" encoding="ISO-8859-1" ?>
<script>
<pgm name='CCRCVDQ' lib='@PG2'>
<parm comment='dq'><data var='dq' type='10A'>RQCYBER</data></parm>
<parm comment='lib'><data var='lib' type='10A'>@DATAX</data></parm>
<parm comment='rtndata'><data var='rtndata' type='571A'>2014-09-25T15.25.35.150000BLEAMAN   395735ADDHZB&NIBNINTEST & PO           000000                      9997000120363516      USD000000014750000000000000000000400                                                                                                                                                                                                                                                                                                                                                          MIS@INVUESECURITY.COM </data></parm>
<parm comment='rtnok'><data var='rtnok' type='1A'>Y</data></parm>
<parm comment='timeout'><data var='timeout' type='5A'></data></parm>
</pgm>
</script>
ENDPROC;
return $clob;
}
