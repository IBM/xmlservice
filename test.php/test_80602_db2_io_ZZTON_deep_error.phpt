--TEST--
XML i Toolkit: IBM_DB2 inout SRVPGM - deep ds bad error
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
$stmt = db2_prepare($conn, "call $procLib.iPLUG1M(?,?,?,?)");
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
var_dump($clobOut);

// xml check via simplexml vs. expected results
$xmlobj = simplexml_load_string($clobOut);
if (!$xmlobj) die("Fail XML returned\n");

// good
echo "Success\n";

//     D TONMAX          c                   const(2)
//     D dcTon_t         ds                  qualified based(Template)
//     D  so7a                          7a
//     D  so4p0                         4p 0
//     D  so8a                          8a
//     D  so5p0                         5p 0
//     D  so3a                          3a
//     D  so6a                          6a
//     D  so3p0                         3p 0
//     D  so22a                        22a
//     D  so2p0                         2p 0
//     D  so2a                          2a
//     D  so4p2                         4p 2
//     D  so1a                          1a
//     D  so3s0                         3s 0
//     D  so4s0                         4s 0
//     D  so9p0                         9p 0
//     D  so12a                        12a
//     D  so12p3                       12p 3
//     D  so15a                        15a
//     D  so17p7                       17p 7
//     D  to7a                          7a
//     D  to4p0                         4p 0
//     D  to8a                          8a
//     D  to5p0                         5p 0
//     D  to3a                          3a
//     D  to6a                          6a
//     D  to3p0                         3p 0
//     D  to22a                        22a
//     D  to2p0                         2p 0
//     D  to2a                          2a
//     D  to4p2                         4p 2
//     D  to1a                          1a
//     D  to3s0                         3s 0
//     D  to4s0                         4s 0
//     D  to9p0                         4p 2
//     D  to12a                        12a
//     D  to12p3                       12p 3
//     D  to15a                        15a
//     D  to17p7                       17p 7
//     D  uo7a                          7a
//     D  uo4p0                         4p 0
//     D  uo8a                          8a
//     D  uo5p0                         5p 0
//     D  uo3a                          3a
//     D  uo6a                          6a
//     D  uo3p0                         3p 0
//     D  uo22a                        22a
//     D  uo2p0                         2p 0
//     D  uo2a                          2a
//     D  uo4p2                         4p 2
//     D  uo1a                          1a
//     D  uo3s0                         3s 0
//     D  uo4s0                         4s 0
//     D  uo9p0                         4p 2
//     D  uo12a                        12a
//     D  uo12p3                       12p 3
//     D  uo15a                        15a
//     D  uo17p7                       17p 7
//     D  vo7a                          7a
//     D  vo4p0                         4p 0
//     D  vo8a                          8a
//     D  vo5p0                         5p 0
//     D  vo3a                          3a
//     D  vo6a                          6a
//     D  vo3p0                         3p 0
//     D  vo22a                        22a
//     D  vo2p0                         2p 0
//     D  vo2a                          2a
//     D  vo4p2                         4p 2
//     D  vo1a                          1a
//     D  vo3s0                         3s 0
//     D  vo4s0                         4s 0
//     D  vo9p0                         4p 2
//     D  vo12a                        12a
//     D  vo12p3                       12p 3
//     D  vo15a                        15a
//     D  vo17p7                       17p 7
//     D  wo7a                          7a
//     D  wo4p0                         4p 0
//     D  wo8a                          8a
//     D  wo5p0                         5p 0
//     D  wo3a                          3a
//     D  wo6a                          6a
//     D  wo3p0                         3p 0
//     D  wo22a                        22a
//     D  wo2p0                         2p 0
//     D  wo2a                          2a
//     D  wo4p2                         4p 2
//     D  wo1a                          1a
//     D  wo3s0                         3s 0
//     D  wo4s0                         4s 0
//     D  wo9p0                         4p 2
//     D  wo12a                        12a
//     D  wo12p3                       12p 3
//     D  wo15a                        15a
//     D  wo17p7                       17p 7
//     D  xo7a                          7a
//     D  xo4p0                         4p 0
//     D  xo8a                          8a
//     D  xo5p0                         5p 0
//     D  xo3a                          3a
//     D  xo6a                          6a
//     D  xo3p0                         3p 0
//     D  xo22a                        22a
//     D  xo2p0                         2p 0
//     D  xo2a                          2a
//     D  xo4p2                         4p 2
//     D  xo1a                          1a
//     D  xo3s0                         3s 0
//     D  xo4s0                         4s 0
//     D  xo9p0                         4p 2
//     D  xo12a                        12a
//     D  xo12p3                       12p 3
//     D  xo15a                        15a
//     D  xo17p7                       17p 7
//     D  yo7a                          7a
//     D  yo4p0                         4p 0
//     D  yo8a                          8a
//     D  yo5p0                         5p 0
//     D  yo3a                          3a
//     D  yo6a                          6a
//     D  yo3p0                         3p 0
//     D  yo22a                        22a
//     D  yo2p0                         2p 0
//     D  yo2a                          2a
//     D  yo4p2                         4p 2
//     D  yo1a                          1a
//     D  yo3s0                         3s 0
//     D  yo4s0                         4s 0
//     D  yo9p0                         4p 2
//     D  yo12a                        12a
//     D  yo12p3                       12p 3
//     D  yo15a                        15a
//     D  yo17p7                       17p 7
//     D  zo7a                          7a
//     D  zo4p0                         4p 0
//     D  zo8a                          8a
//     D  zo5p0                         5p 0
//     D  zo3a                          3a
//     D  zo6a                          6a
//     D  zo3p0                         3p 0
//     D  zo22a                        22a
//     D  zo2p0                         2p 0
//     D  zo2a                          2a
//     D  zo4p2                         4p 2
//     D  zo1a                          1a
//     D  zo3s0                         3s 0
//     D  zo4s0                         4s 0
//     D  zo9p0                         4p 2
//     D  zo12a                        12a
//     D  zo12p3                       12p 3
//     D  zo15a                        15a
//     D  zo17p7                       17p 7
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * zzton: check parm array aggregate 
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     P zzton           B                   export
//     D zzton           PI
//     D  nn1p0                         1p 0
//     D  nn7a                          7a
//     D  nn8p0                         8p 0
//     D  nnDS                               likeds(dcTon_t) dim(TONMAX)
//     D  nn9p0                         9p 0
//     D  nn1a                          1a
//     D  nn60a                        60a
//     D  nn35a                        35a
function getxml() {
$clob = <<<ENDPROC
<?xml version='1.0'?>
<script>
<pgm name='ZZSRV' lib='xyzlibxmlservicexyz' func='ZZTONBAD'>
 <parm io='in'><data type='1p0'>1</data></parm>
 <parm io='in'><data type='7a'>7</data></parm>
 <parm io='in'><data type='8p0'>8</data></parm>
 <parm io='both'>
  <ds var='dcTon_t' dim='2'>
    <data var='s01' type='7A'>1</data>
    <data var='s02' type='4p0'>2</data>
    <data var='s03' type='8A'>3</data>
    <data var='s04' type='5p0'>4</data>
    <data var='s05' type='3A'>5</data>
    <data var='s06' type='6A'>6</data>
    <data var='s07' type='3p0'>7</data>
    <data var='s08' type='22A'>8</data>
    <data var='s09' type='2p0'>9</data>
    <data var='s10' type='2A'>10</data>
    <data var='s11' type='4p2'>11</data>
    <data var='s12' type='1A'>x</data>
    <data var='s13' type='3s0'>13</data>
    <data var='s14' type='4s0'>14</data>
    <data var='s15' type='9p0'>15</data>
    <data var='s16' type='12A'>16</data>
    <data var='s17' type='12p3'>17</data>
    <data var='s18' type='15A'>18</data>
    <data var='s19' type='17p7'>19</data>
    <data var='t01' type='7A'></data>
    <data var='t02' type='4p0'></data>
    <data var='t03' type='8A'></data>
    <data var='t04' type='5p0'></data>
    <data var='t05' type='3A'></data>
    <data var='t06' type='6A'></data>
    <data var='t07' type='3p0'></data>
    <data var='t08' type='22A'></data>
    <data var='t09' type='2p0'></data>
    <data var='t10' type='2A'></data>
    <data var='t11' type='4p2'></data>
    <data var='t12' type='1A'></data>
    <data var='t13' type='3s0'></data>
    <data var='t14' type='4s0'></data>
    <data var='t15' type='9p0'></data>
    <data var='t16' type='12A'></data>
    <data var='t17' type='12p3'></data>
    <data var='t18' type='15A'></data>
    <data var='t19' type='17p7'></data>
    <data var='u01' type='7A'>1</data>
    <data var='u02' type='4p0'>2</data>
    <data var='u03' type='8A'>3</data>
    <data var='u04' type='5p0'4></data>
    <data var='u05' type='3A'>5</data>
    <data var='u06' type='6A'>6</data>
    <data var='u07' type='3p0'>7</data>
    <data var='u08' type='22A'>8</data>
    <data var='u09' type='2p0'>9</data>
    <data var='u10' type='2A'>10</data>
    <data var='u11' type='4p2'>11</data>
    <data var='u12' type='1A'>x</data>
    <data var='u13' type='3s0'>13</data>
    <data var='u14' type='4s0'>14</data>
    <data var='u15' type='9p0'>15</data>
    <data var='u16' type='12A'>16</data>
    <data var='u17' type='12p3'>17</data>
    <data var='u18' type='15A'>18</data>
    <data var='u19' type='17p7'>19</data>
    <data var='v01' type='7A'></data>
    <data var='v02' type='4p0'></data>
    <data var='v03' type='8A'></data>
    <data var='v04' type='5p0'></data>
    <data var='v05' type='3A'></data>
    <data var='v06' type='6A'></data>
    <data var='v07' type='3p0'></data>
    <data var='v08' type='22A'></data>
    <data var='v09' type='2p0'></data>
    <data var='v10' type='2A'></data>
    <data var='v11' type='4p2'></data>
    <data var='v12' type='1A'></data>
    <data var='v13' type='3s0'></data>
    <data var='v14' type='4s0'></data>
    <data var='v15' type='9p0'></data>
    <data var='v16' type='12A'></data>
    <data var='v17' type='12p3'></data>
    <data var='v18' type='15A'></data>
    <data var='v19' type='17p7'></data>
    <data var='w01' type='7A'>1</data>
    <data var='w02' type='4p0'>2</data>
    <data var='w03' type='8A'>3</data>
    <data var='w04' type='5p0'>4</data>
    <data var='w05' type='3A'>5</data>
    <data var='w06' type='6A'>6</data>
    <data var='w07' type='3p0'>7</data>
    <data var='w08' type='22A'>8</data>
    <data var='w09' type='2p0'>9</data>
    <data var='w10' type='2A'>10</data>
    <data var='w11' type='4p2'>11</data>
    <data var='w12' type='1A'>x</data>
    <data var='w13' type='3s0'>13</data>
    <data var='w14' type='4s0'>14</data>
    <data var='w15' type='9p0'>15</data>
    <data var='w16' type='12A'>16</data>
    <data var='w17' type='12p3'>17</data>
    <data var='w18' type='15A'>18</data>
    <data var='w19' type='17p7'>19</data>
    <data var='x01' type='7A'></data>
    <data var='x02' type='4p0'></data>
    <data var='x03' type='8A'></data>
    <data var='x04' type='5p0'></data>
    <data var='x05' type='3A'></data>
    <data var='x06' type='6A'></data>
    <data var='x07' type='3p0'></data>
    <data var='x08' type='22A'></data>
    <data var='x09' type='2p0'></data>
    <data var='x10' type='2A'></data>
    <data var='x11' type='4p2'></data>
    <data var='x12' type='1A'></data>
    <data var='x13' type='3s0'></data>
    <data var='x14' type='4s0'></data>
    <data var='x15' type='9p0'></data>
    <data var='x16' type='12A'></data>
    <data var='x17' type='12p3'></data>
    <data var='x18' type='15A'></data>
    <data var='x19' type='17p7'></data>
    <data var='y01' type='7A'></data>
    <data var='y02' type='4p0'></data>
    <data var='y03' type='8A'></data>
    <data var='y04' type='5p0'></data>
    <data var='y05' type='3A'></data>
    <data var='y06' type='6A'></data>
    <data var='y07' type='3p0'></data>
    <data var='y08' type='22A'></data>
    <data var='y09' type='2p0'></data>
    <data var='y10' type='2A'></data>
    <data var='y11' type='4p2'></data>
    <data var='y12' type='1A'></data>
    <data var='y13' type='3s0'></data>
    <data var='y14' type='4s0'></data>
    <data var='y15' type='9p0'></data>
    <data var='y16' type='12A'></data>
    <data var='y17' type='12p3'></data>
    <data var='y18' type='15A'></data>
    <data var='y19' type='17p7'></data>
    <data var='z01' type='7A'>1</data>
    <data var='z02' type='4p0'>2</data>
    <data var='z03' type='8A'>3</data>
    <data var='z04' type='5p0'>4</data>
    <data var='z05' type='3A'>5</data>
    <data var='z06' type='6A'>6</data>
    <data var='z07' type='3p0'>7</data>
    <data var='z08' type='22A'>8</data>
    <data var='z09' type='2p0'>9</data>
    <data var='z10' type='2A'>10</data>
    <data var='z11' type='4p2'>11</data>
    <data var='z12' type='1A'>x</data>
    <data var='z13' type='3s0'>13</data>
    <data var='z14' type='4s0'>14</data>
    <data var='z15' type='9p0'>15</data>
    <data var='z16' type='12A'>16</data>
    <data var='z17' type='12p3'>17</data>
    <data var='z18' type='15A'>18</data>
    <data var='z19' type='17p7'>19</data>
  </ds>
 </parm>
 <parm io='both'><data type='9p0'>9</data></parm>
 <parm io='both'><data type='1a'>1</data></parm>
 <parm io='both'><data type='60a'>60</data></parm>
 <parm io='both'><data type='35a'>35</data></parm>
</pgm>
</script>
ENDPROC;
return test_lib_replace($clob);
}
?>
--EXPECTF--
%s
Success

