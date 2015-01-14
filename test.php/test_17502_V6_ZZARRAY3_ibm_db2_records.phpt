--TEST--
XML i Toolkit: IBM_DB2 inout SRVPGM - DS records parm
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
$max = 5;
$clobIn = getxml($max);
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
if (!$xmlobj) die("Fail XML returned\n");
// -----------------
// output pgm call
// -----------------
$myName1 = 'Ranger';  // expected name
$myMax1  = 5;         // expected max
$myCount1= 5;         // expected count
$allpgms = $xmlobj->xpath('/script/pgm');
if (!$allpgms) die("Fail XML pgm missing\n");
$pgm  = $allpgms[0];
$name = $pgm->attributes()->name;
$lib  = $pgm->attributes()->lib;
$func = $pgm->attributes()->func;

// good
echo "Success ($lib/$name.$func)\n";

//     D ARRAYMAX        c                   const(999)
//     D dcRec_t         ds                  qualified based(Template)
//     D  dcMyName                     10A
//     D  dcMyJob                    4096A
//     D  dcMyRank                     10i 0
//     D  dcMyPay                      12p 2
//
//     D dcRec3_t        ds                  qualified based(Template)
//     D  dcMyName3                    10A
//     D  dcRec3                             likeds(dcRec_t) dim(ARRAYMAX)
//
//     D dcRec2_t        ds                  qualified based(Template)
//     D  dcMyName2                    10A
//     D  dcRec2                             likeds(dcRec3_t)
//
//     D dcRec1_t        ds                  qualified based(Template)
//     D  dcMyName1                    10A
//     D  dcRec1                             likeds(dcRec2_t)
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zzarray2: check parameter array aggregate 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     D zzarray3        PR
//     D  myName                       10A
//     D  myMax                         3s 0
//     D  myCount                       3s 0
//     D  findMe1                            likeds(dcRec1_t)
//     D  findMe2                            likeds(dcRec2_t)
//     D  findMe3                            likeds(dcRec3_t)
function getxml($max) {
$clob = "";
$clob .= "<?xml version='1.0'?>";
$clob .= "<script>";
$clob .= "<pgm name='ZZSRV6' lib='xyzlibxmlservicexyz' func='ZZARRAY3'>";
$clob .= " <parm comment='search this name'>";
$clob .= "  <data var='myName' type='10A'>Ranger</data>";
$clob .= " </parm>";
$clob .= " <parm comment='max allowed return'>";
$clob .= "  <data var='myMax' type='3s0'>$max</data>";
$clob .= " </parm>";
$clob .= " <parm comment='wskdist'><data var='wskdist' type='3a'>012</data></parm>";
$clob .= " <parm comment='wskyear'><data var='wskyear' type='4a'>2011</data></parm>";
$clob .= " <parm comment='wskytyp'><data var='wskytyp' type='1a'>R</data></parm>";
$clob .= " <parm comment='wskschl'><data var='wskschl' type='4a'>0011</data></parm>";
$clob .= " <parm comment='wskusr'><data var='wskusr' type='20a'>BISCA080</data></parm>";
$clob .= " <parm comment='wsksdate'><data var='wsksdate' type='8a'>20110104</data></parm>";
$clob .= " <parm comment='wskscrse'><data var='wskscrse' type='8a'> </data></parm>";
$clob .= " <parm comment='wskssect'><data var='wskssect' type='4a'> </data></parm>";
$clob .= "<parm comment='wsksmod'><data var='wsksmod' type='2a'>01</data></parm>";
$clob .= "<parm comment='wsoptai'><data var='wsoptai' type='1a'/></parm>";
$clob .= "<parm comment='wsopatdt'><data var='wsopatdt' type='1a'/></parm>";
$clob .= "<parm comment='wsoplslot'><data var='wsoplslot' type='2a'/></parm>";
$clob .= "<parm comment='wsopstdcnt'><data var='wsopstdcnt' type='3s0' enddo='wsopstdcnt'/></parm>";
$clob .= "<parm comment='wsoperrtbl'><data var='wsoperrtbl' type='48000a'/></parm>";
$clob .= "<parm comment='findMe1'>";
$clob .= " <ds var='findMe1' data='records'>";
$clob .= "  <ds var='dcRec1_t' array='on'>";
$clob .= "   <ds var='dcRec1_t'>";
$clob .= "    <data var='dcMyName1' type='10A'/>";
$clob .= "    <ds var='dcRec2_t'>";
$clob .= "     <data var='dcMyName2' type='10A'/>";
$clob .= "     <ds var='dcRec3_t'>";
$clob .= "      <data var='dcMyName3' type='10A'/>";
$clob .= "      <ds var='dcRec_t' dim='$max' dou='wsopstdcnt'>";
$clob .= "       <data var='dcMyName' type='10A'/>";
$clob .= "       <data var='dcMyJob' type='4096A'/>";
$clob .= "       <data var='dcMyRank' type='10i0'/>";
$clob .= "       <data var='dcMyPay' type='12p2'/>";
$clob .= "      </ds>";
$clob .= "     </ds>";
$clob .= "    </ds>";
$clob .= "   </ds>";
$clob .= "  </ds>";
$clob .= " </ds>";
$clob .= "<records delimit=':'>";
$clob .= ":Ranger:B:Good";
for ($i=0; $i<$max; $i++) $clob .= ":nada{$i}:nada{$i}:1:1.1";
$clob .= ":</records>";
$clob .= "</parm>";
$clob .= "<parm comment='findMe2'>";
$clob .= " <ds var='findMe2' data='records'>";
$clob .= "  <ds var='dcRec2_t' array='on'>";
$clob .= "   <ds var='dcRec2_t'>";
$clob .= "    <data var='dcMyName2' type='10A'/>";
$clob .= "    <ds var='dcRec3_t'>";
$clob .= "     <data var='dcMyName3' type='10A'/>";
$clob .= "     <ds var='dcRec_t' dim='$max' dou='wsopstdcnt'>";
$clob .= "      <data var='dcMyName' type='10A'/>";
$clob .= "      <data var='dcMyJob' type='4096A'/>";
$clob .= "      <data var='dcMyRank' type='10i0'/>";
$clob .= "      <data var='dcMyPay' type='12p2'/>";
$clob .= "     </ds>";
$clob .= "    </ds>";
$clob .= "   </ds>";
$clob .= "  </ds>";
$clob .= " </ds>";
$clob .= "<records delimit=':'>";
$clob .= ":B:Good";
for ($i=0; $i<$max; $i++) $clob .= ":nada{$i}:nada{$i}:1:1.1";
$clob .= ":</records>";
$clob .= "</parm>";
$clob .= "<parm comment='findMe3'>";
$clob .= " <ds var='findMe3' data='records'>";
$clob .= "  <ds var='dcRec3_t' array='on'>";
$clob .= "   <ds var='dcRec3_t'>";
$clob .= "    <data var='dcMyName3' type='10A'/>";
$clob .= "    <ds var='dcRec_t' dim='999' dou='wsopstdcnt'>";
$clob .= "     <data var='dcMyName' type='10A'/>";
$clob .= "     <data var='dcMyJob' type='4096A'/>";
$clob .= "     <data var='dcMyRank' type='10i0'/>";
$clob .= "     <data var='dcMyPay' type='12p2'/>";
$clob .= "    </ds>";
$clob .= "   </ds>";
$clob .= "  </ds>";
$clob .= " </ds>";
$clob .= "<records delimit=':'>";
$clob .= ":Good";
for ($i=0; $i<$max; $i++) $clob .= ":nada{$i}:nada{$i}:1:1.1";
$clob .= ":</records>";
$clob .= "</parm>";
$clob .= "</pgm>";
$clob .= "</script>";
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success (%s)

