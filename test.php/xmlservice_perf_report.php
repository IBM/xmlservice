<?php
function fly_rpt($clobOut) {
  // var_dump($clobOut);
  $xmlobj = simplexml_load_string($clobOut);
  // totals
  $ticks_t = 0;
  $ticks_s = 0;
  $perfs = $xmlobj->xpath('/report/performance');
  foreach($perfs as $perf) {
    $recs = $perf->xpath('record');
    foreach($recs as $rec) {
      $label = (string)$rec->label;
      $ticks = (string)$rec->ticks;
      if (strpos($label,"+")>0) continue;
      if (strpos($label,"T_")>-1) $ticks_t += $ticks;     // client ticks
      elseif (strpos($label,"S_")>-1) $ticks_s += $ticks; // server ticks
    }
  }
  $ticks_a = $ticks_t + $ticks_s;

  // report
  $perfs = $xmlobj->xpath('/report/performance');
  foreach($perfs as $perf) {
    $recs = $perf->xpath('record');
    foreach($recs as $rec) {
      $label = (string)$rec->label;
      $ticks = (string)$rec->ticks;
      if (strpos($label,"+")>0) continue;
      if (strpos($label,"T_")>-1) $pctme =$ticks/$ticks_t*100;
      elseif (strpos($label,"S_")>-1) $pctme = $ticks/$ticks_s*100;
      else $pctme = 0;
      $pctall=$ticks/$ticks_a*100;
      echo sprintf("%20s %10d %15.4f%% %15.4f%%\n",$label,$ticks,$pctme,$pctall);
    }
  }
  echo "===\n";
  echo sprintf("%20s client=%d server=%d total=%d\n","ticks",$ticks_t,$ticks_s,$ticks_a);
}
?>
