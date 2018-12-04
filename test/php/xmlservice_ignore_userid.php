<?php
function ibm_db2_Status($myfile) {
  $rc = 0;
  $output = `cat $myfile`;
  if (strpos($output,'sion=ibm_db2')>0) $rc += 1;
  if (strpos($output,'i5_ignore_userid')>0) $rc += 1;
  if (strpos($output,'pear test only')>0) $rc += 1;
  return $rc;
}

function ibm_db2_IgnoreOn() {
 global $curr_ibm_db2_file, $save_ibm_db2_file, $here_ibm_db2_file;
 // already set
 $rc = ibm_db2_Status($curr_ibm_db2_file);
 if ($rc < 3) {
   // assure backup
   $diff = trim(`diff $curr_ibm_db2_file $save_ibm_db2_file`);
   if ($diff) `cp $curr_ibm_db2_file $save_ibm_db2_file`; // curr to save
   // set up ignore_userid
   `cp $here_ibm_db2_file $curr_ibm_db2_file`; // here to curr
 }
 echo `cat $curr_ibm_db2_file`;
}

function ibm_db2_IgnoreOff() {
 global $curr_ibm_db2_file, $save_ibm_db2_file, $here_ibm_db2_file;
 // using pear test ini, then return to normal
 $rc = ibm_db2_Status($curr_ibm_db2_file);
 if ($rc > 2) `cp $save_ibm_db2_file $curr_ibm_db2_file`; // save to curr
 echo `cat $curr_ibm_db2_file`;
}

?>
