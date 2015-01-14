<?php
// *** $ctl .= " *hack"; ***
// some drivers (result set) ... 
// possible junk end record, therefore
// xmlservice provided $ctl='*hack' 
// record</hack>junk
function driverJunkAway($xml)
{
  // trim blanks (NO we need them)
  $clobOut = $xml;
  // *BLANKS returned forget it
  if (! trim($clobOut)) return $clobOut;
  // result set end of record marker ($ctl='*hack')
  $fixme = '</hack>';
  $pos = strpos($clobOut,$fixme);
  if ($pos > -1) {
    $clobOut = substr($clobOut,0,$pos);
  }
  else {
    // traditional end of script
    $fixme = '</script>';
    $pos = strpos($clobOut,$fixme);
    if ($pos > -1) {
      $clobOut = substr($clobOut,0,$pos+strlen($fixme));
    }
    // maybe error/performance report
    else {
      $fixme = '</report>';
      $pos = strpos($clobOut,$fixme);
      if ($pos > -1) {
        $clobOut = substr($clobOut,0,$pos+strlen($fixme));
      }
    }
  }
  return $clobOut;
}

// xml common text replacement
function test_lib_replace($xml) {
  global $testLib, $procOPM;
  if (!$procOPM) {
    $was = array("xyzlibxmlservicexyz");
    $now = array("$testLib");
  }
  else {
    $was = array("xyzlibxmlservicexyz","<pgm");
    $now = array("$testLib","<pgm mode='opm'");
  }
  $out = str_replace($was,$now,$xml);
  return $out;
}

function driverTime() {
  $t = localtime(time(), true);
  return $t['tm_hour'].":".$t['tm_min'].":".$t['tm_sec'];
}

?>
