--TEST--
XML i Toolkit: - CW Toolkit REXX RTVMSG command
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
require_once('CW/cw.php'); // new toolkit compatibility (Alan)

/* connect */
$conn = i5_connect("localhost", $user, $password);
// $conId = '42';
// $conn = i5_pconnect("", $user, $password, array(I5_OPTIONS_PRIVATE_CONNECTION => $conId));
if (!$conn)
{ $tab = i5_error();
  die("Connect: ".$tab[2]." "."$tab[3], $tab[0]");
}

$msgid = "CPF0010";
$msgf = "QCPFMSG";
   
if (!i5_command("RTVMSG", array("MSGID" => $msgid, "MSGF" => $msgf), array("MSG" => array("msg", "char(200)")), $conn)) die(i5_errormsg());
if (function_exists('i5_output')) extract(i5_output());   
echo "Description of $msgid: $msg\n";

if (strpos($msg,'support')<1) die("$msg not contain support");

// good
echo "I have ... \n";
echo "Success\n";
?>
--EXPECTF--
%s
Success

