--TEST--
XML i Toolkit: IBM_DB2 - UTF8 NLS test
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
$ctlstart = "$ctl";

// connect to IBM i
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");

// nls conversion attempts
$hebrew_xml_ccsid      = "<data type='200A' hex='on' before='819/424' after='424/819'>"; // encoding 1100
$hebrew_raw_ascii_data ='אֵין בְּעָיָה! עַל לֹא דָּבָר';
$farsi_xml_ccsid       = "<data type='200A' hex='on' before='819/1098' after='1098/819'>"; // encoding 1100
$farsi_raw_ascii_data  = 'دستشویی/داروخانه) کجاست؟';
$russia_xml_ccsid      = "<data type='200A' hex='on' before='819/880' after='880/819'>"; // encoding 1100
$russia_raw_ascii_data = 'Беда́ никогда́ не прихо́дит одна';
$italy_xml_ccsid       = "<data type='200A' hex='on' before='819/280' after='280/819'>"; // encoding 1100
$italy_raw_ascii_data  = 'risorse perché il loro unico obiettivo è produrre a costi più';
$german_xml_ccsid      = "<data type='200A' hex='on' before='819/273' after='273/819'>"; // encoding 1100
$german_raw_ascii_data = 'Ä Ö Ü ä ö ü hier befindet sich die größte datenbank an deutschen untertiteln';
$korea_xml_ccsid      = "<data type='200A' hex='on' before='819/1088' after='1088/819'>"; // encoding 2100
$korea_raw_ascii_data = '길을 잃어버렸어요';
$japan_xml_ccsid       = "<data type='200A' hex='on' before='1208/13488' after='13488/1208'>"; // encoding 7200 (61952, 13488)
$japan_raw_ascii_data  = 'ラドクリフ、マラソン五輪代表に1万m出場にも含み';
$china_xml_ccsid       = "<data type='200A' hex='on' before='1208/13488' after='13488/1208'>"; // encoding 7200 (61952, 13488)
$china_raw_ascii_data  = '顆老鼠屎壞了一鍋粥(一颗老鼠屎坏了一锅粥';

$nls = array(
array("Hebrew",$hebrew_xml_ccsid, $hebrew_raw_ascii_data),
array("Farsi",$farsi_xml_ccsid, $farsi_raw_ascii_data),
array("Russia",$russia_xml_ccsid, $russia_raw_ascii_data),
array("Italy",$italy_xml_ccsid, $italy_raw_ascii_data),
array("Germany",$german_xml_ccsid, $german_raw_ascii_data),
array("Korea",$korea_xml_ccsid, $korea_raw_ascii_data),
array("Japan",$japan_xml_ccsid, $japan_raw_ascii_data),
array("China",$china_xml_ccsid, $china_raw_ascii_data)
);

foreach($nls as $nlsthis) {
$title              = $nlsthis[0];
$nls_xml_ccsid      = $nlsthis[1];
$nls_raw_ascii_data = $nlsthis[2];

echo "***********************************************************\n";
echo "           $title\n";
echo "***********************************************************\n";

// ***********************************************************
// *** setup (XML input) ***
$clobIn   =
"<?xml version='1.0'?>
<script>
<pgm name='ZZSRV' lib='XMLSERVICE' func='ZZ200'>
<parm  io='both'>
$nls_xml_ccsid"
.bin2hex($nls_raw_ascii_data).
"</data>
</parm>
</pgm>
</script>";
$clobOut  = "";
// ***********************************************************
// *** call IBM i XMLSERVICE (XML input) ***
$stmt = db2_prepare($conn, "call $procLib.iPLUG32K(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Bad execute: ".db2_stmt_errormsg());

// ***********************************************************
// *** back from XMLSERVICE call with results (XML output) *** 
echo "=== $nls_xml_ccsid ===\n";
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) {
  var_dump($clobOut);
  echo("--->Bad XML returned<----\n");
}
else echo("--->Good XML returned<----\n");
$allpgms = $xmlobj->xpath('/script/pgm');
if (!$allpgms) {
  var_dump($clobOut);
  die("Missing XML pgm info");
}
$pgm = $allpgms[0];
$name = $pgm->attributes()->name;
$lib  = $pgm->attributes()->lib;
$parm = $pgm->xpath('parm');
if (!$parm) {
  var_dump($clobOut);
  die("Missing XML pgm parms ($lib/$name)");
}
// how do chars look?
$nls_return_from_xmlservice_data = pack("H*",(string)$parm[0]->data);
echo "Input...$nls_raw_ascii_data\n";
echo "Return..$nls_return_from_xmlservice_data\n";
$inhex = bin2hex($nls_raw_ascii_data);
$outhex = bin2hex($nls_return_from_xmlservice_data);
echo "Input...$inhex\n";
echo "Return..$outhex\n";
if ($inhex != $outhex) die("--->Bad HEX returned<----\n");
else echo("--->Good HEX returned<----\n");
// ***********************************************************
} // end nls loop

echo "Success\n";

?>

--EXPECTF--
%s
Success

