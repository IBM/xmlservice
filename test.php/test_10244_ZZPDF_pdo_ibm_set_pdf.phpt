--TEST--
XML i Toolkit: PDO_IBM result set PDF - binary data
--SKIPIF--
<?php require_once('skipifpdo.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
// read pdf file into hex string
$handle = fopen($pdfInFile, "rb");
$hexpdf = strtoupper( bin2hex( fread( $handle, filesize($pdfInFile) ) ) );
fclose($handle);
// -----------------
// make the call
// -----------------
// call IBM i
$database = "ibm:".$database;
try {
  $db = new PDO($database, 
                strtoupper($user), 
                strtoupper($password), 
                array(PDO::ATTR_AUTOCOMMIT=>true));
  if (!$db) throw new Exception('foo');
} catch( Exception $e ) { 
  die("Bad connect: $database,$user"); 
}
try {
  $stmt = $db->prepare("call $procLib.iPLUGR1M(?,?,?)");
  if (!$stmt) throw new Exception('bar');
} catch( Exception $e ) { 
  $err = $db->errorInfo();
  $cod = $db->errorCode();
  die("Bad prepare: ".$cod." ".$err[0]." ".$err[1]." ".$err[2]);
}
try {
  $ctl .= " *hack";
  $clobIn = getxml($hexpdf);
  $clobOut = "";
  $ret = $stmt->execute(array($ipc,$ctl,$clobIn));
  if (!$ret) throw new Exception('yoyo');
  while( $row = $stmt->fetch(PDO::FETCH_NUM,PDO::FETCH_ORI_NEXT) ) {
    $clobOut .= driverJunkAway($row[0]);
  }
} catch( Exception $e ) {
  $err = $stmt->errorInfo();
  $cod = $stmt->errorCode();
  die("Bad execute: ".$cod." ".$err[0]." ".$err[1]." ".$err[2]);
}
// -----------------
// output processing
// -----------------
// dump raw XML (easy test debug)
// var_dump($clobOut);
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
if (!$parm) die("Missing XML pgm parms ($lib/$name.$func)\n");
$var    = $parm[0]->data->attributes()->var;
$hexret = (string)$parm[0]->data;
$size = 32;
$max  = strlen($hexpdf); 
for ($i=0;$i<$max;$i+=$size) {
  if ($i + $size > $max) $size = $max - $i;
  $a = substr($hexpdf,$i,$size);
  $b = substr($hexret,$i,$size);
  if ($a<>$b) {
     echo "offset $i: $a\n";
     echo "offset $i: $b\n";
     die("Fail XML $var in/out not match ($lib/$name.$func)\n");
  }
}
// pgm data returned
$retn = $pgm->xpath('return');
if (!$retn) die("Fail XML pgm return missing ($lib/$name.$func)\n");
$var  = $retn[0]->data->attributes()->var;
$actual = (string)$retn[0]->data;
$expect = '1';
if ($actual != $expect) die("$var ($actual not $expect) ($lib/$name.$func)\n");

// good
// file_put_contents($pdfOutFile, pack("H*", $hexret));
echo substr($hexret,0,400)."\n";
echo "Success ($lib/$name.$func)\n";

//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zzpdf: check binary 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzpdf           B                   export
//     D zzpdf           PI            10i 0
//     D  myPDF                     65000A
function getxml($hexpdf) {
$clob1 = <<<ENDPROC1
<?xml version='1.0'?>
<script>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZPDF'>
 <parm comment='binary data'>
  <data var='myPDF' type='xxsizeb'>
ENDPROC1;
$clob3 = <<<ENDPROC3
  </data>
 </parm>
 <return>
  <data var='myRet' type='10i0'>0</data>
 </return>
</pgm>
</script>
ENDPROC3;
$was = array('xxsize');
$now = array(strlen($hexpdf)/2);
$clob1 = str_replace($was,$now,$clob1);
$clob = $clob1;
$clob .= $hexpdf;
$clob .= $clob3;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success (%s)

