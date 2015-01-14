<?php
// *** http://ibmi/test.php?driver=ibm_db2 ***
if (!isset($procDrive)) die('Failure -- authorization.php $procDrive=driver variable is not set.');
if (isset($_GET['driver'])) $procDrive = $_GET['driver'];
if (isset($_POST['driver'])) $procDrive = $_POST['driver'];
switch($procDrive) {
case 'get':
  require_once 'xmlservice_get.php';    // $xmlOut = xmlservice($xmlIn)
  break;
case 'post':
  require_once 'xmlservice_post.php';    // $xmlOut = xmlservice($xmlIn)
  break;
case 'odbc':
  $ctl .= " *hack";                      // quirky odbc drivers (result set) 
  require_once 'xmlservice_odbc.php';    // $xmlOut = xmlservice($xmlIn)
  break;
case 'pdo_ibm':
  require_once 'xmlservice_pdo_ibm.php'; // $xmlOut = xmlservice($xmlIn)
  break;
case 'ibm_db2':
default:
  require_once 'xmlservice_ibm_db2.php'; // $xmlOut = xmlservice($xmlIn)
  break;
}
?>
