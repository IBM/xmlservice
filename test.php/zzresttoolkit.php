<?php
require_once("ToolkitService.php");
$ToolkitServiceObj = ToolkitService::getInstance("*LOCAL", "*NONE", "*NONE", "http");
$ToolkitServiceObj->setOptions(
    array('stateless'        => true, // use public shared connection (not private)
          'arrayIntegrity'   => true, // do not collapse arrays to one element (older toolkit behavior) 
          'transportType'    => 'http', // use REST XMLSERVICE xmlcgi.pgm
          'httpTransportUrl' => "http://174.79.32.155/cgi-bin/xmlcgi.pgm", // YIPS machine (*NONE)
          'plugSize'         => '512K')); // return data no larger than 512
$output = $ToolkitServiceObj->CLInteractiveCommand("dsplibl");
if (!$output) {
  echo "Failure " . $ToolkitServiceObj->getLastError();
}
else {
  var_dump($output);
}
?>

