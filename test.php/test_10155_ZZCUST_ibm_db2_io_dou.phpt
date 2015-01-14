--TEST--
XML i Toolkit: IBM_DB2 inout PGM - DOU DS records returned
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG65K(?,?,?,?)");
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
ob_start(); 
echo "<h1>Easy Peasy XMLSERVICE</h1>\n";
echo "<table border='1'>\n";
// echo "<th>RPG anyone?</th>\n";
echo "<th>Easy peasy simpleXML</th>\n";
// echo "<th>Easy peasy text XML</th>\n";
echo "<th>Easy peasy PHP arrays</th>\n";
echo "<th>Easy peasy JSON</th>\n";
echo "<tr>\n";

// echo "<td valign='top'><pre>\n";
// echo file_get_contents("./zzcust.rpgle");
// echo "</pre></td>\n";

$xmlobj = new SimpleXmlIterator($clobOut);
echo "<td valign='top'><pre>\n";
var_dump( $xmlobj );
echo "</pre></td>\n";

// $rawxml = $xmlobj->asXML();
// echo "<td valign='top'>\n";
// var_dump( $rawxml );
// echo "</td>\n";

$phparray = sxiToArray( $xmlobj );
echo "<td valign='top'><pre>\n";
var_dump( $phparray );
echo "</pre></td>\n";

$jsonobj = json_encode( $xmlobj );
echo "<td valign='top'>\n";
var_dump( $jsonobj );
echo "</td>\n";

echo "</tr>\n";
echo "</table>\n";

$myout = ob_get_clean(); 

//---------------
// check the data 
if (strpos($myout,'"data":["good item 7","7.000","700.0000"]') < 1) die("Missing data \n".$myout);

// good
echo $myout;
echo "Success\n";

//     D pcustomer_id    s              8p 0
//     D plines          s              4p 0
//     D pline_ds        DS                  Dim(10) qualified
//     D item                          35a
//     D qty                           11p 3
//     D price                         14p 4
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * main(): Control flow
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     C     *Entry        PLIST                   
//     C                   PARM                    pcustomer_id
//     C                   PARM                    plines
//     C                   PARM                    pline_ds
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZCUST' lib='xyzlibxmlservicexyz'>
 <parm><data var='pcustomer_id' type='8p0'>12345678</data></parm>
 <parm><data var='plines' type='10i0' enddo='plines'>0</data></parm>
 <parm>
  <ds var='pline_ds' dim='10' dou='plines'>
    <data var='item' type='35A'/>
    <data var='qty' type='11p3'/>
    <data var='price' type='14p4'/>
  </ds>
 </parm>
</pgm>
</script>
ENDPROC;
return test_lib_replace($clob);
}

// -----------------------
// helper functions
// -----------------------
function sxiToArray($sxi)
{    // copy  : http://php.net/manual/en/class.simplexmliterator.php
    // author: ratfactor at gmail dot com
    // note  : @ADC - added attributes processing
    $a = array();
    for( $sxi->rewind(); $sxi->valid(); $sxi->next() ) {
        if(!array_key_exists($sxi->key(), $a)){
            $a[$sxi->key()] = array();
        }
        if($sxi->hasChildren()){
            // @ADC - added attributes processing
            $attributes = $sxi->current()->attributes();
            $att = array();
            foreach ($attributes as $attributeName => $attributeValue)
            {
                $attribName = strtolower(trim((string)$attributeName));
                $attribVal = trim((string)$attributeValue);
                $att[$attribName] = $attribVal;
            }
            $a[$sxi->key()][] = array('@attr'=>$att);
            // child
            $a[$sxi->key()][] = sxiToArray($sxi->current());
        }
        else{
            // @ADC - added attributes processing
            $attributes = $sxi->current()->attributes();
            $att = array();
            foreach ($attributes as $attributeName => $attributeValue)
            {
                $attribName = strtolower(trim((string)$attributeName));
                $attribVal = trim((string)$attributeValue);
                $att[$attribName] = $attribVal;
            }
            $a[$sxi->key()][] = array('@attr'=>$att,'@value'=>strval($sxi->current()));
        }
    }
    return $a;
}
?>
--EXPECTF--
%s
Success

