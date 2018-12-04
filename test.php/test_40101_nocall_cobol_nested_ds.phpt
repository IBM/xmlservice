--TEST--
XML i Toolkit: Customer XML - cobol complex ds
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
$zz0cnt = 2;
$clobIn = getxml($zz0cnt);
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
var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Fail XML output\n");

if (substr_count($clobOut,"var='wskdist'") < 1) die ("var='wskdist' - missing\n");
if (substr_count($clobOut,"var='wskyear'") < 1) die ("var='wskyear' - missing\n");
if (substr_count($clobOut,"var='wskytyp'") < 1) die ("var='wskytyp' - missing\n");
if (substr_count($clobOut,"var='wskschl'") < 1) die ("var='wskschl' - missing\n");
if (substr_count($clobOut,"var='wskusr'") < 1) die ("var='wskusr' - missing\n");
if (substr_count($clobOut,"var='wsksdate'") < 1) die ("var='wsksdate' - missing\n");
if (substr_count($clobOut,"var='wskscrse'") < 1) die ("var='wskscrse' - missing\n");
if (substr_count($clobOut,"var='wskssect'") < 1) die ("var='wskssect' - missing\n");
if (substr_count($clobOut,"var='wsksmod'") < 1) die ("var='wsksmod' - missing\n");
if (substr_count($clobOut,"var='wsoptai'") < 1) die ("var='wsoptai' - missing\n");
if (substr_count($clobOut,"var='wsopatdt'") < 1) die ("var='wsopatdt' - missing\n");
if (substr_count($clobOut,"var='wsoplslot'") < 1) die ("var='wsoplslot' - missing\n");
if (substr_count($clobOut,"var='wsopstdcnt'") < 1) die ("var='wsopstdcnt' - missing\n");
if (substr_count($clobOut,"var='wsoperrtbl'") < 1) die ("var='wsoperrtbl' - missing\n");

if (substr_count($clobOut,"var='wsop1stdt'") < $zz0cnt) die ("var='wsop1stdt' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsop1last'") < $zz0cnt) die ("var='wsop1last' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsop1frst'") < $zz0cnt) die ("var='wsop1frst' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsop1mddl1'") < $zz0cnt) die ("var='wsop1mddl1' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsop1mddl9'") < $zz0cnt) die ("var='wsop1mddl9' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsop1app'") < $zz0cnt) die ("var='wsop1app' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopseor1'") < $zz0cnt) die ("var='wsopseor1' (1:$zz0cnt)- missing\n");

if (substr_count($clobOut,"var='wsopsex'") < $zz0cnt) die ("var='wsopsex' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopsethai'") < $zz0cnt) die ("var='wsopsethai' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopsethas'") < $zz0cnt) die ("var='wsopsethas' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopsethbl'") < $zz0cnt) die ("var='wsopsethbl' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopsethpi'") < $zz0cnt) die ("var='wsopsethpi' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopsethwh'") < $zz0cnt) die ("var='wsopsethwh' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopsethhs'") < $zz0cnt) die ("var='wsopsethhs' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopcrse'") < $zz0cnt) die ("var='wsopcrse' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopsect'") < $zz0cnt) die ("var='wsopsect' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopct1'") < $zz0cnt) die ("var='wsopct1' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopgrd'") < $zz0cnt) die ("var='wsopgrd' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopsstat'") < $zz0cnt) die ("var='wsopsstat' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopseor2'") < $zz0cnt) die ("var='wsopseor2' (1:$zz0cnt)- missing\n");


if (substr_count($clobOut,"var='wsopalrtcon'") < $zz0cnt) die ("var='wsopalrtcon' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopalrthlt'") < $zz0cnt) die ("var='wsopalrthlt' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopalrtnte'") < $zz0cnt) die ("var='wsopalrtnte' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopseor3'") < $zz0cnt) die ("var='wsopseor3' (1:$zz0cnt)- missing\n");

if (substr_count($clobOut,"var='wsoptchr'") < $zz0cnt) die ("var='wsoptchr' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopoff'") < $zz0cnt) die ("var='wsopoff' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsoperldis'") < $zz0cnt) die ("var='wsoperldis' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopprds'") < $zz0cnt) die ("var='wsopprds' (1:$zz0cnt)- missing\n");
if (substr_count($clobOut,"var='wsopseor4'") < $zz0cnt) die ("var='wsopseor4' (1:$zz0cnt)- missing\n");

// good
echo "Success\n";

function getxml($zz0cnt) {
$clob = <<<ENDPROC
<?xml version="1.0" encoding="ISO-8859-1" ?><script>
<pgm name='S241DC' lib='TRMSPGMLIB'>
<parm comment='wskdist'><data var='wskdist' type='3a'>012</data></parm><parm comment='wskyear'><data var='wskyear' type='4a'>2011</data></parm><parm comment='wskytyp'><data var='wskytyp' type='1a'>R</data></parm><parm comment='wskschl'><data var='wskschl' type='4a'>0011</data></parm><parm comment='wskusr'><data var='wskusr' type='20a'>BISCA080</data></parm><parm comment='wsksdate'><data var='wsksdate' type='8a'>20110104</data></parm><parm comment='wskscrse'><data var='wskscrse' type='8a'> </data></parm><parm comment='wskssect'><data var='wskssect' type='4a'> </data></parm><parm comment='wsksmod'><data var='wsksmod' type='2a'>01</data></parm><parm comment='wsoptai'><data var='wsoptai' type='1a' /></parm><parm comment='wsopatdt'><data var='wsopatdt' type='1a' /></parm><parm comment='wsoplslot'><data var='wsoplslot' type='2a' /></parm><parm comment='wsopstdcnt'><data var='wsopstdcnt' type='3s0' enddo='wsopstdcnt'>zz0cnt</data></parm><parm comment='wsoperrtbl'><data var='wsoperrtbl' type='48000a' /></parm><parm comment='wsoptbl01'><ds var='wsoptbl01'><ds var='wsoptbl1ln' array='on'><ds var='wsoptbl1ln' dim='999' dou='wsopstdcnt'><data var='wsop1stdt' type='10a' /><ds var='wsop1name'><data var='wsop1last' type='17a' /><data var='wsop1frst' type='12a' /><ds var='wsop1mddl'><data var='wsop1mddl1' type='1a' /><data var='wsop1mddl9' type='9a' /></ds><data var='wsop1app' type='3a' /></ds><data var='wsopseor1' type='1a' /></ds></ds></ds></parm><parm comment='wsoptbl02'><ds var='wsoptbl02'><ds var='wsopdemln' array='on'><ds var='wsopdemln' dim='999' dou='wsopstdcnt'><data var='wsopsex' type='1a' /><ds var='wsopseth'><data var='wsopsethai' type='1a' /><data var='wsopsethas' type='1a' /><data var='wsopsethbl' type='1a' /><data var='wsopsethpi' type='1a' /><data var='wsopsethwh' type='1a' /><data var='wsopsethhs' type='1a' /></ds><data var='wsopcrse' type='8a' /><data var='wsopsect' type='4a' /><data var='wsopct1' type='4a' /><data var='wsopgrd' type='2a' /><data var='wsopsstat' type='1a' /><data var='wsopseor2' type='1a' /></ds></ds></ds></parm><parm comment='wsoptbl03'><ds var='wsoptbl03'><ds var='wsopalrtln' array='on'><ds var='wsopalrtln' dim='999' dou='wsopstdcnt'><data var='wsopalrtcon' type='1a' /><data var='wsopalrthlt' type='1a' /><data var='wsopalrtnte' type='1a' /><data var='wsopseor3' type='1a' /></ds></ds></ds></parm><parm comment='wsoptbl04'><ds var='wsoptbl04'><ds var='wsopattln' array='on'><ds var='wsopattln' dim='999' dou='wsopstdcnt'><data var='wsoptchr' type='1a' /><data var='wsopoff' type='1a' /><data var='wsoperldis' type='1a' /><data var='wsopprds' type='40a' /><data var='wsopseor4' type='1a' /></ds></ds></ds></parm>
</pgm>
</script>
ENDPROC;
$was = array("zz0cnt");
$now = array("$zz0cnt");
return str_replace($was,$now,$clob);
}
?>
--EXPECTF--
%s
Success

