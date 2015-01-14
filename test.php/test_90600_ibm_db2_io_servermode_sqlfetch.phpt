--TEST--
XML i Toolkit: IBM_DB2 inout SQL - server mode query animal
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');

// -------------
// call IBM i
// -------------
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");
$stmt = db2_prepare($conn, "call $procLib.iPLUG512K(?,?,?,?)");
if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
// ------------
// read png file into hex string (blob)
// ------------
$handle = fopen($pngstar, "rb");
$picture = strtoupper( bin2hex( fread( $handle, filesize($pngstar) ) ) );
fclose($handle);
// ------------
// text (clob)
// ------------
$essay = "
Simple i say, but so was the doctor.

I just flew here from Rochester, may arms are tired.
";
$id = 1;
$clobIn = getxml($schematest, $id, $essay, $picture);
$clobOut = "";
$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_OUT);
$ret=db2_execute($stmt);
if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
// -----------------
// output processing (XML input info)
// -----------------
// dump raw XML (easy test debug)
// var_dump($clobIn);
$xmlobj = simplexml_load_string($clobIn);
if (!$xmlobj) die("Bad XML input");
// -----------------
// output processing
// -----------------
// dump raw XML (easy test debug)
// var_dump($clobOut);
// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Bad XML returned");
// -----------------
// output row header
// -----------------
$cols = $xmlobj->xpath('/script/sql/describe/col');
if (!$cols) die("Missing XML cols info");
$format = "%'.15.15s ";
foreach($cols as $col) {
  printf ($format, ((string)$col->name."(".(string)$col->dbtype.")\n"));
}
echo "\n";
// -----------------
// output row data
// $pdfOutFile = pack("H*", $hexret)
// -----------------
$rows = $xmlobj->xpath('/script/sql/fetch/row');
if (!$rows) die("Missing XML rows info");
foreach($rows as $row) {
  foreach($row->data as $data) {
    echo $data->attributes()->desc."...";
    echo substr($data,0,36)."\n";
  }
  $desc = $row->data[2]->attributes()->desc;
  $pngbin = pack("H*", $row->data[2]);
  $something = substr(strtoupper(bin2hex($pngbin)),0,36);
  echo "do something with picture ($desc):($something)\n";
}
// good
echo "Success\n";

function getxml($schematest, $id, $essay, $picture) {
$clob = "<?xml version='1.0'?>
<script>
<sql>
<free/>
<options options='server' servermode='on' libl='$schematest QTEMP' autocommit='off'/>
<connect options='server'/>
<prepare>UPDATE animal1 SET essay = ?, picture = ? where id = ?</prepare>
<execute>
<parm io='in'>$essay</parm>
<parm io='in'>$picture</parm>
<parm io='in'>$id</parm>
</execute>
<query>select * from animal1</query>
<describe desc='col'/>
<fetch block='all' desc='on'/>
<commit action='rollback'/>
<free/>
</sql>
</script>";
return $clob;
}
?>
--EXPECTF--
%s
Success

