--TEST--
XML i Toolkit: REST GET SRVPGM - varying cdata
--SKIPIF--
<?php require_once('skipifrest.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');

// http GET parms
$clobIn = getxml();
$clobOut = "";
$parm  = "?db2=$i5restdb";
$parm .= "&uid=$user";
$parm .= "&pwd=$password";
$parm .= "&ipc=$ipc";
$parm .= "&ctl=$ctl";
$parm .= "&xmlin=".urlencode($clobIn);
$parm .= "&xmlout=32768";  // size expected XML output
// execute
$linkall = "$i5resturl".htmlentities($parm);
$getOut = simplexml_load_file($linkall);
// result
if ($getOut) $clobOut = $getOut->asXML();
else $clobOut = "";
// -----------------
// output processing
// -----------------
// dump raw XML (easy test debug)
var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML returned");
$allpgms = $xmlobj->xpath('/script/pgm');
if (!$allpgms) die("Missing XML pgm info");
// -----------------
// output pgm call
// -----------------
// only one program this XML script
$pgm = $allpgms[0];
$name = $pgm->attributes()->name;
$lib  = $pgm->attributes()->lib;
$func = $pgm->attributes()->func;
// pgm parms
$parm = $pgm->xpath('parm');
if ($parm) die("Unexpected XML pgm parms io='in' ($lib/$name.$func)\n");
// pgm data returned
$retn = $pgm->xpath('return');
if (!$retn) die("Fail XML pgm return missing ($lib/$name.$func)\n");
$var  = $retn[0]->data->attributes()->var;
$actual = (string)$retn[0]->data;
$expect = 'my name is <Ranger>';
if ($actual != $expect) die("$var ($actual not $expect) ($lib/$name.$func)\n");

// good
echo "Success ($lib/$name.$func)\n";

//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zzvary: check return varying 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzvary          B                   export
//     D zzvary          PI            20A   varying
//     D  myName                       10A   varying
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0' encoding='ISO-8859-1' ?>
<script>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZVARY'>
 <parm comment='search this name' io='in'>
  <data var='myName' type='10A' varying='on'><![CDATA[<Ranger>]]></data>
 </parm>
 <return>
  <data var='myNameis' type='20A' varying='on'><![CDATA[<Mud>]]></data>
 </return>
</pgm>
</script>
ENDPROC;
$test = simplexml_load_string($clob);
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success (%s)

