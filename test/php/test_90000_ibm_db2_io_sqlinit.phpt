--TEST--
XML i Toolkit: IBM_DB2 inout SQL- prepare tests
--SKIPIF--
<?php require_once('skipifdb2.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
require_once('db2sql.inc');

// -----------------
// schema
// -----------------
$sql_crt_schema = "<query error='off'>$db2_crt_schema</query>";

// -----------------
// table animal
// -----------------
$sql_drp_animal  = "<query error='off'>$db2_drp_animal</query>";
$sql_crt_animal  = "<query>$db2_crt_animal</query>";
$sql_prep_animal = "<prepare>$db2_prep_animal</prepare>";
$sql_add_animal  = "<execute><parm io='in'>zzid</parm><parm io='in'>zzbreed</parm><parm io='in'>zzname</parm><parm io='in'>zzweight</parm><parm io='in'>zzheight</parm></execute>";

// -----------------
// table animal1 (clob/blob)
// -----------------
$sql_drp_animal1  = "<query error='off'>$db2_drp_animal1</query>";
$sql_crt_animal1  = "<query>$db2_crt_animal1</query>";
$sql_prep_animal1 = "<prepare>$db2_prep_animal1</prepare>";
$sql_add_animal1  = "<execute><parm io='in'>zzid</parm><parm io='in'>zzessay</parm><parm io='in'>zzpicture</parm></execute>";

// ------------
// stored procedure 1
// ------------
$sql_drp_sp1 = "<query error='off'>$db2_drp_sp1</query>";
$sql_crt_sp1 = "<query>$db2_crt_sp1</query>";

// ------------
// stored procedure 2
// ------------
$sql_drp_sp2 = "<query  error='off'>$db2_drp_sp2</query>";
$sql_crt_sp2 = "<query>$db2_crt_sp2</query>";

// -----------------
// table animal2 (identity notes)
// -----------------
$sql_drp_animal2 = "<query error='off'>$db2_drp_animal2</query>";
$sql_crt_animal2 = "<query>$db2_crt_animal2</query>";
$sql_idrp_animal2 = "<query>$db2_idrp_animal2</query>";
$sql_icrt_animal2 = "<query>$db2_icrt_animal2</query>";
$sql_fkdrp_animal2 = "<query>$db2_fkdrp_animal2</query>";
$sql_fkcrt_animal2 = "<query>$db2_fkcrt_animal2</query>";

// -----------------
// table qtemp/animal
// -----------------
$sql_drp_animalq = "<query error='off'>$db2_drp_animalq</query>";
$sql_crt_animalq = "<query>$db2_crt_animalq</query>";
$sql_prep_animalq = "<prepare>$db2_prep_animalq</prepare>";
$sql_add_animalq = "<execute><parm io='in'>zzid</parm><parm io='in'>zzbreed</parm><parm io='in'>zzname</parm><parm io='in'>zzweight</parm><parm io='in'>zzheight</parm></execute>";

// -----------------
// free everything
// -----------------
$sql_last = "<free/>";

// -----------------
// common
// -----------------
$sql_beg = "<?xml version='1.0'?>\n<script>\n<sql>\n";
$sql_end = "\n</sql>\n</script>";

// ------------
// call IBM i
// ------------
if ($i5persistentconnect) $conn = db2_pconnect($database,$user,$password);
else $conn = db2_connect($database,$user,$password);
if (!$conn) die("Bad connect: $database,$user");

$sql = "call $procLib.iPLUG512K(?,?,?,?)";
$stmt = db2_prepare($conn, $sql);
check_ret("prep $sql",$stmt);

$ret=db2_bind_param($stmt, 1, "ipc", DB2_PARAM_IN, DB2_CHAR);
check_ret("bind1",$ret);
$ret=db2_bind_param($stmt, 2, "ctl", DB2_PARAM_IN, DB2_CHAR);
check_ret("bind2",$ret);
$ret=db2_bind_param($stmt, 3, "clobIn", DB2_PARAM_IN, DB2_CHAR);
check_ret("bind3",$ret);
$ret=db2_bind_param($stmt, 4, "clobOut", DB2_PARAM_INOUT, DB2_CHAR);
check_ret("bind4",$ret);

foreach ($actions as $action=>$sql) {
    echo "*** action  =$action \n";
    switch ($action) {
    case "schema-create":
      $clobIn = $sql_beg;
      $clobIn .= "$sql_crt_schema\n";
      $clobIn .= $sql_end;
      break;
    case "cmd_libl":
    case "cmd_end":
      $clobIn = "<?xml version='1.0'?>\n<script>\n<cmd>$chglibl</cmd>\n<cmd>CHGAUT OBJ('/qsys.lib/{$schematest}.lib') USER(*PUBLIC) DTAAUT(*RWX) OBJAUT(*ALL) SUBTREE(*ALL)</cmd>\n</script>";
      break;
    case "table-animal-drop":
      $clobIn = $sql_beg;
      $clobIn .= $sql_drp_animal;
      $clobIn .= $sql_end;
      break;
    case "table-animal-create":
      $clobIn = $sql_beg;
      $clobIn .= $sql_crt_animal;
      $clobIn .= $sql_end;
      break;
    case "table-animal-insert":
      $clobIn = $sql_beg;
      $clobIn .= $sql_prep_animal;
	  foreach ($animals as $r) {
        $was = array("zzid","zzbreed","zzname","zzweight","zzheight");
        $now = array($r[0],$r[1],$r[2],$r[3],$r[4]);
        $out = str_replace($was,$now,$sql_add_animal);
        $clobIn .= $out;
	  }
      $clobIn .= $sql_end;
      break;
    case "table-animal1-drop":
      $clobIn = $sql_beg;
      $clobIn .= $sql_drp_animal1;
      $clobIn .= $sql_end;
      break;
    case "table-animal1-create":
      $clobIn = $sql_beg;
      $clobIn .= $sql_crt_animal1;
      $clobIn .= $sql_end;
      break;
    case "table-animal1-insert":
      $clobIn = $sql_beg;
      $was = array("zzuser");
      $now = array("$user");
      $clobIn .= $sql_prep_animal1;
	  foreach ($animals as $r) {
        $was = array("zzid","zzessay","zzpicture");
        $now = array($r[0],$essay,$hexpng);
        $out = str_replace($was,$now,$sql_add_animal1);
        $clobIn .= $out;
	  }
      $clobIn .= $sql_end;
      break;
    case "proc-sp1-drop":
      $clobIn = $sql_beg;
      $clobIn .= $sql_drp_sp1;
      $clobIn .= $sql_end;
      break;
    case "proc-sp1-create":
      $clobIn = $sql_beg;
      $clobIn .= $sql_crt_sp1;
      $clobIn .= $sql_end;
      break;
    case "proc-sp2-drop":
      $clobIn = $sql_beg;
      $clobIn .= $sql_drp_sp2;
      $clobIn .= $sql_end;
      break;
    case "proc-sp2-create":
      $clobIn = $sql_beg;
      $clobIn .= $sql_crt_sp2;
      $clobIn .= $sql_end;
      break;
    case "table-animal2-drop":
      $clobIn = $sql_beg;
      $clobIn .= $sql_drp_animal2;
      $clobIn .= $sql_end;
      break;
    case "table-animal2-create":
      $clobIn = $sql_beg;
      $clobIn .= $sql_crt_animal2;
      $clobIn .= $sql_end;
      break;
    case "index-index2-drop":
      $clobIn = $sql_beg;
      $clobIn .= $sql_idrp_animal2;
      $clobIn .= $sql_end;
      break;
    case "index-index2-create":
      $clobIn = $sql_beg;
      $clobIn .= $sql_icrt_animal2;
      $clobIn .= $sql_end;
      break;
    case "table-fkey-drop":
      $clobIn = $sql_beg;
      $clobIn .= $sql_fkdrp_animal2;
      $clobIn .= $sql_end;
      break;
    case "table-fkey-create":
      $clobIn = $sql_beg;
      $clobIn .= $sql_fkcrt_animal2;
      $clobIn .= $sql_end;
      break;
    case "table-animalq-drop":
      $clobIn = $sql_beg;
      $clobIn .= $sql_drp_animalq;
      $clobIn .= $sql_end;
      break;
    case "table-animalq-create":
      $clobIn = $sql_beg;
      $clobIn .= $sql_crt_animalq;
      $clobIn .= $sql_end;
      break;
    case "table-animalq-insert":
      $clobIn = $sql_beg;
      $clobIn .= $sql_prep_animalq;
      foreach ($animals as $r) {
        $was = array("zzid","zzbreed","zzname","zzweight","zzheight");
        $now = array($r[0],$r[1],$r[2],$r[3],$r[4]);
        $out = str_replace($was,$now,$sql_add_animalq);
        $clobIn .= $out;
      }
      $clobIn .= $sql_end;
      break;
    case "kill-all-last":
      $clobIn = $sql_beg;
      $clobIn .= $sql_last;
      $clobIn .= $sql_end;
      break;
    default:
      die("bad action $action");
    }
    $clobOut = "";

    $ret=db2_execute($stmt);
    check_ret("execute $sql",$ret);

    // dump raw XML (easy test debug)
    // var_dump($clobIn);
    var_dump($clobOut);
    // if (strlen($clobOut)==0) die("Bad return\n");	
}

$ret=db2_free_stmt($stmt);
check_ret("free",$ret);

if ($i5persistentconnect) db2_pclose($conn);
else db2_close($conn);

foreach ($actions as $action=>$sql) {
    echo "*** action  =$action\n";
}
// good
echo "Success\n";
function check_ret($title, $ret) {
  if (!$ret) die("*** Bad statement $title ".db2_stmt_errormsg()."\n");
}
?>
--EXPECTF--
%s
Success

