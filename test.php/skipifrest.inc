<?php
// see license here
require_once('license.inc');
require_once('authorization.php');
error_reporting(0);           // **** NO ERRORS please
$clobIn = "<?xml version='1.0'?><script><sh>/QOpenSys/usr/bin/uname -a</sh></script>";
$clobOut = "";
$parm  = "?db2=$i5restdb";
$parm .= "&uid=$user";
$parm .= "&pwd=$password";
$parm .= "&ipc=$ipc";
$parm .= "&ctl=$ctl";
$parm .= "&xmlin=".urlencode($clobIn);
$parm .= "&xmlout=32768";     // size expected XML output
$linkall = "$i5resturl".htmlentities($parm);
$xmlobj = simplexml_load_file($linkall);
if (!$xmlobj) die('skip');
$sh = $xmlobj->xpath('/script/sh');
if (!$sh) die('skip');
$data = (string)$sh[0];
if (!$data) die('skip');
if (isset($_SERVER['PHP_SELF'])) $HANDLER = $_SERVER['PHP_SELF'];
else $HANDLER = $argv[0];
if (strpos($data," 4 5 ")>0 && strpos($HANDLER,"V6")>0) die('skip');
$clobIn  = "";
$clobOut = "";
$sh      = "";
$data    = "";
$HANDLER = "";
$xmlobj  = "";
error_reporting(E_ALL);       // **** OK ERRORS please
?>

