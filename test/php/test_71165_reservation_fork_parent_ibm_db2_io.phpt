--TEST--
XML i Toolkit: IBM_DB2 inout fork multi reservation processing
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
$iamdead = false;

// sequence of jobs
echo "Parent fork 4 sequence children jobs now ...\n";
$out0 = `php test_71166_reservation_child.php2 0`;
$out1 = `php test_71166_reservation_child.php2 1`;
$out2 = `php test_71166_reservation_child.php2 2`;
$out3 = `php test_71166_reservation_child.php2 3`;
checkItNow("OUTPUT getxml0 (dsplibl): good exclusive key IPC ...",$out0);
checkItNow("OUTPUT getxml1 (RTVSYSVAL): good exclusive key IPC ...",$out1);
checkItNow("OUTPUT getxml2 (ZZCALL): good exclusive key IPC stop ...",$out2);
checkItNow("OUTPUT getxml3 (ls /tmp): good free key IPC ...",$out3);

// independent jobs
$max = 8;
for ($loop=0;$loop<$max;$loop++) {
  `echo 'test waiting ...' > "/tmp/test_71166_reservation_0_{$loop}.test"`;
  `echo 'test waiting ...' > "/tmp/test_71166_reservation_1_{$loop}.test"`;
  `echo 'test waiting ...' > "/tmp/test_71166_reservation_2_{$loop}.test"`;
  `echo 'test waiting ...' > "/tmp/test_71166_reservation_3_{$loop}.test"`;
}
// fork jobs (&)
for ($loop=0;$loop<$max;$loop++) {
  echo "Parent fork 4 independent children jobs now (loop = $loop) ...\n";
  $pid = pcntl_fork();
  if ($pid == -1) {
    die('Failure could not fork');
  }
  // child
  if (!$pid) { 
    $out0 = `php test_71166_reservation_child.php2 0 > "/tmp/test_71166_reservation_0_{$loop}.test" &`;
    $out1 = `php test_71166_reservation_child.php2 1 > "/tmp/test_71166_reservation_1_{$loop}.test" &`;
    $out2 = `php test_71166_reservation_child.php2 2 > "/tmp/test_71166_reservation_2_{$loop}.test" &`;
    $out3 = `php test_71166_reservation_child.php2 3 > "/tmp/test_71166_reservation_3_{$loop}.test" &`;
    exit(0);
  }
}
// collect output
for ($loop=0;$loop<$max;$loop++) {
  echo "Parent collect data 4 independent children jobs now (loop = $loop) ...\n";
  $fork0[$loop] = true;
  $fork1[$loop] = true;
  $fork2[$loop] = true;
  $fork3[$loop] = true;
}
// retry over time period
$retry = true;
$reservation = true;
for ($h=0; $retry && $h<40;$h++) {
  usleep(500000); // Sleep for 500 miliseconds;
  // look at all files
  for ($loop=0;$loop<$max;$loop++) {
    if ($fork0[$loop]) $fork0[$loop] = continueLookingFile("OUTPUT getxml0 (dsplibl): good exclusive key IPC ...","0","$loop");
    if ($fork1[$loop]) $fork1[$loop] = continueLookingFile("OUTPUT getxml1 (RTVSYSVAL): good exclusive key IPC ...","1","$loop");
    if ($fork2[$loop]) $fork2[$loop] = continueLookingFile("OUTPUT getxml2 (ZZCALL): good exclusive key IPC stop ...","2","$loop");
    if ($fork3[$loop]) $fork3[$loop] = continueLookingFile("OUTPUT getxml3 (ls /tmp): good free key IPC ...","3","$loop");
  } // loop

  // all files reported Success???
  $retry = false;
  for ($loop=0;$loop<$max;$loop++) {
    if ($fork0[$loop] || $fork1[$loop] || $fork2[$loop] || $fork3[$loop]) $retry = true;
  } // loop
 
  // check all <use>myspecialkey</use> complete
  // make sure <stop>myspecialkey</stop> occurrs
  // allow getxml3 (ls /tmp): good free key IPC ...
  if ($retry || $reservation) {
    $reservation = false;
    for ($loop=0;$loop<$max;$loop++) {
      if ($fork0[$loop] || $fork1[$loop] || $fork2[$loop]) $reservation = true;
    } // loop
    if ($reservation) {
      $out2 = `php test_71166_reservation_child.php2 2`;
      checkItNow("OUTPUT getxml2 (ZZCALL): good exclusive key IPC stop ...",$out2);
    }
  }

} // h

// bad 
if ($retry) {
  for ($loop=0;$loop<$max;$loop++) {
    if ($fork0[$loop] || $fork1[$loop] || $fork2[$loop] || $fork3[$loop]) $retry = true;
    if ($fork0[$loop]) $fork0[$loop] = continueLookingFile("OUTPUT getxml0 (dsplibl): good exclusive key IPC ...","0","$loop",true);
    if ($fork1[$loop]) $fork1[$loop] = continueLookingFile("OUTPUT getxml1 (RTVSYSVAL): good exclusive key IPC ...","1","$loop",true);
    if ($fork2[$loop]) $fork2[$loop] = continueLookingFile("OUTPUT getxml2 (ZZCALL): good exclusive key IPC stop ...","2","$loop",true);
    if ($fork3[$loop]) $fork3[$loop] = continueLookingFile("OUTPUT getxml3 (ls /tmp): good free key IPC ...","3","$loop",true);
  } // loop
}

// allow free use RPC next test
$out2 = `php test_71166_reservation_child.php2 2`;
checkItNow("OUTPUT getxml2 (ZZCALL): good exclusive key IPC stop ...",$out2);

// clear
pcntl_wait($status); //Protect against Zombie children
`rm /tmp/test_71166_reservation_*`;

// bad
if ($retry) die("Failure ($max x 4) independent child forks did not report in Success\n");

// good or bad
if ($iamdead) {
  var_dump($iamdead);
  die("Failure\n");
}
echo "Success\n";

function continueLookingFile($title, $id, $lp, $dumpError=false) {
  global $iamdead;
  $cmd = "cat /tmp/test_71166_reservation_{$id}_{$lp}.test";
  // echo "$cmd ($id, $lp)\n";
  $data = `$cmd`;
  // child serious error
  if (strpos($data,'am dead')>1) {
    echo ("*** ERROR dead child program ($cmd) $title \n");
    if ($dumpError) echo "$data\n";
    $iamdead[] = "*** ERROR dead child program ($cmd) $title\n\n$data\n";
    return false; // done with child
  }
  // child worked
  if (strpos($data,'Success')<1) {
    echo ("Still waiting child program ($cmd) $title \n");
    if ($dumpError) echo "$data\n";
    return true; // waiting on child
  }
  /// child needs to run 
  echo ("Good child program ($cmd) $title \n");
  return false; // done with child
}
function checkItNow($title, $data) {
  if (strpos($data,'Success')<1) {
    // var_dump($data);
    die("Failure program $title \n");
  }
  echo ("Good program $title \n");
}
?>

--EXPECTF--
%s
Success

