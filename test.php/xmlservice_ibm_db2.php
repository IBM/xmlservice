<?php
// PHP driver: xmlservice_ibm_db2.php
// Notes:
// Assumes you have PHP ibm_db2 driver enabled in Zend Server.
// You may use PHP ibm_db2 driver on IBM i (1-tier)
// or from Linux/Windows to IBM i (2-tier).
// For help:
// http://www.youngiprofessionals.com/wiki/index.php/PHP/DB2
if (!extension_loaded('ibm_db2')) {
  die('Error: ibm_db2 extension not loaded, use Zend Server GUI to enable.');
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
    if ($i5persistentconnect) $procConn = db2_pconnect($database, $user, $password);   // persistent/pooled connection
    else $procConn = db2_connect($database, $user, $password);          // full open/close connection
  }
  if (!$procConn) die("Bad connect: $database, $user");
  $stmt = db2_prepare($procConn, "call $procLib.$procPlug(?,?,?,?)"); // Call XMLSERVICE 
                                                          // stored procedure interface
                                                          // in/out parameter (xmlOut)
                                                          // sizes: iPLUG4K - iPLUG15M
  if (!$stmt) die("Bad prepare: ".db2_stmt_errormsg());
  $ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN);     // ? - /tmp/raw_$user (*sbmjob)
  $ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN);     // ? - *here or *sbmjob
  $ret=db2_bind_param($stmt, 3, "xmlIn", DB2_PARAM_IN);   // ? - XML input script
  $ret=db2_bind_param($stmt, 4, "xmlOut", DB2_PARAM_OUT); // ? - XML output return
  $ret=db2_execute($stmt);
  if (!$ret) die("Bad execute: ".db2_stmt_errormsg());
  return driverJunkAway($xmlOut);                         // just in case driver odd
                                                          // ... possible junk end record,
                                                          // record</script>junk
}
?>
