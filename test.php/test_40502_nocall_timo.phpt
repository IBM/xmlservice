--TEST--
XML i Toolkit: Timo massive data
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG15M(?,?,?,?)");
if (!$stmt) die("Fail prepare: ".db2_stmt_errormsg());
$ctl .= " *test";
$clobIn = getxml();
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobIn);
if (!$xmlobj) die("Fail XML input\n");
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
if (!$xmlobj) die("Fail XML output\n");

if (strpos($clobOut,"fred flinstone") < 1) die("missing fred flinstone\n");
echo "Good we see fred flinstone\n";

// good
echo "Success\n";

function getxml() {
$clob = <<<ENDPROC
<?xml version="1.0" encoding="ISO-8859-1" ?>
<script>
<pgm name='RMETUH' lib='*LIBL'>
<parm io='in' comment='PI_Caller'><data var='PI_Caller' type='18a' /></parm>
<parm io='in' comment='PI_Action'><data var='PI_Action' type='1a' /></parm>
<parm io='in' comment='PI_Pyks'><data var='PI_Pyks' type='2a' /></parm>
<parm io='in' comment='PI_Vano'><data var='PI_Vano' type='15a' /></parm>
<parm io='in' comment='PI_Asno'><data var='PI_Asno' type='15a' /></parm>
<parm io='in' comment='PI_Kiekdi'><data var='PI_Kiekdi' type='3a' /></parm>
<parm io='in' comment='PI_Myyja'><data var='PI_Myyja' type='15a' /></parm>
<parm io='in' comment='PI_Rows'><data var='PI_Rows' type='5s0'>0</data></parm>
<parm comment='PI_ProdTable'>
<ds var='PI_ProdTable' array='on'>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
<ds var='PI_ProdTable'>
<data var='PI_Pr_Tuno' type='20a' />
<data var='PI_Pr_Toim' type='15a' />
<data var='PI_Pr_Mra' type='9s2'>0</data>
<data var='PI_Pr_Myks' type='3a' />
</ds>
</ds>
</parm>
<parm io='out' comment='PO_OutCode'><data var='PO_OutCode' type='1a' /></parm>
<parm io='out' comment='PO_ErrNbr'><data var='PO_ErrNbr' type='3s0' /></parm>
<parm comment='PO_Err'><ds var='PO_Err' array='on'>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
<ds var='PO_Err'>
<data var='Err_Id' type='7a' />
<data var='Err_Msg' type='132a' />
<data var='Err_Field' type='30a' />
<data var='Err_Sev' type='1s0'>0</data>
<data var='Err_Row' type='5s0'>0</data>
</ds>
</ds>
</parm>
<parm io='out' comment='PO_Valk'><data var='PO_Valk' type='3a' /></parm>
<parm io='out' comment='PO_Rows'><data var='PO_Rows' type='5s0' /></parm>
<parm comment='PO_ProdTable'><ds var='PO_ProdTable' array='on'>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
<ds var='PO_ProdTable'>
<data var='PO_Pr_Error' type='1a' />
<data var='PO_Pr_NoPrice' type='1a' />
<data var='PO_Pr_Tuno' type='20a' />
<data var='PO_Pr_Vetn' type='20a' />
<data var='PO_Pr_Toim' type='15a' />
<data var='PO_Pr_TuSta' type='3a' />
<data var='PO_Pr_Vapaa' type='9s2'>0</data>
<data var='PO_Pr_TuDesc' type='40a' />
<data var='PO_Pr_Tvalm' type='3a' />
<ds var='PO_PriceTable' array='on'>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
<ds var='PO_PriceTable'>
<data var='PO_Pr_Hity' type='3a' />
<data var='PO_Pr_Myhi' type='13a' />
<data var='PO_Pr_Vthi' type='13a' />
<data var='PO_Pr_Ale1' type='7a' />
<data var='PO_Pr_Ale2' type='7a' />
<data var='PO_Pr_Ale3' type='7a' />
<data var='PO_Pr_Alvp' type='7a' />
<data var='PO_Pr_Hikt' type='3a' />
<data var='PO_Pr_Mhalr' type='11a' />
<data var='PO_Pr_Myks' type='3a' />
<data var='PO_Pr_Vano' type='15a' />
</ds>
</ds>
</ds>
</ds>
</parm>
</pgm>
<comment>fred flinstone</comment>
</script>
ENDPROC;
return $clob;
}
?>
--EXPECTF--
%s
Success

