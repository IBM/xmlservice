<?php
// PHP driver: xmlservice_pdo_ibm.php
// Notes:
// Assumes you have PHP pdo_ibm driver enabled in Zend Server.
// You may use PHP pdo_ibm driver on IBM i (1-tier)
// or from Linux/Windows to IBM i (2-tier).
// For help:
// http://www.youngiprofessionals.com/wiki/index.php/PHP/DB2
if (!extension_loaded('pdo_ibm')) {
  die('Error: pdo_ibm extension not loaded, use Zend Server GUI to enable.');
}

// *** XMLSERVICE call (DB2 driver) ***
// Note: 
// Connection ($procConn) is global to avoid looping
// re-open/re-close that errors most drivers 
function xmlservice($xml) {
global $i5persistentconnect, $database, $user, $password, $ipc, $ctl, $procConn, $procLib, $procPlug, $procPlugR;
  $xmlIn = $xml;
  $xmlOut = '';
  if (!$procConn) {
    $database = "ibm:".$database;
    try {
      if ($i5persistentconnect) $opt = array(PDO::ATTR_PERSISTENT=>true, PDO::ATTR_AUTOCOMMIT=>true);  // persistent/pooled connection
      else $opt = array(PDO::ATTR_AUTOCOMMIT=>true);                                    // full open/close connection
      $procConn = new PDO($database, strtoupper($user), strtoupper($password), $opt);
      if (!$procConn) throw new Exception("Bad");
    } catch( Exception $e ) { 
      die("Bad connect: $database, $user"); 
    }
  }
  try {
    $stmt = $procConn->prepare("call $procLib.$procPlug(?,?,?,?)");   // Call XMLSERVICE 
                                                          // stored procedure interface
                                                          // in/out parameter (xmlOut)
                                                          // sizes: iPLUG4K - iPLUG15M
    if (!$stmt) throw new Exception('Bad');
  } catch( Exception $e ) { 
    $err = $procConn->errorInfo();
    $cod = $procConn->errorCode();
    die("Bad prepare: ".$cod." ".$err[0]." ".$err[1]." ".$err[2]);
  }
  try {
    $r1=$stmt->bindParam(1,$ipc, PDO::PARAM_STR);
    $r2=$stmt->bindParam(2,$ctl, PDO::PARAM_STR);
    $r3=$stmt->bindParam(3,$xmlIn, PDO::PARAM_STR);
    $r4=$stmt->bindParam(4,$xmlOut, PDO::PARAM_STR|PDO::PARAM_INPUT_OUTPUT);
    $ret = $stmt->execute();
    if (!$ret) throw new Exception('Bad');
  } catch( Exception $e ) {
    $err = $stmt->errorInfo();
    $cod = $stmt->errorCode();
    die("Bad execute: ".$cod." ".$err[0]." ".$err[1]." ".$err[2]);
  }
  return driverJunkAway($xmlOut);                         // just in case driver odd
                                                          // ... possible junk end record,
                                                          // record</script>junk
}
?>
