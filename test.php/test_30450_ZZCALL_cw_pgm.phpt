--TEST--
XML i Toolkit: - CW Toolkit ZZCALL
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('connection.inc');
require_once('CW/cw.php'); // new toolkit compatibility (Alan)

/* connect */
$conn = i5_connect("localhost", $user, $password);
if (!$conn)
{ $tab = i5_error();
  die("Connect: ".$tab[2]." "."$tab[3], $tab[0]");
}
 
//     D  INCHARA        S              1a
//     D  INCHARB        S              1a
//     D  INDEC1         S              7p 4        
//     D  INDEC2         S             12p 2
//     D  INDS1          DS                  
//     D   DSCHARA                      1a
//     D   DSCHARB                      1a           
//     D   DSDEC1                       7p 4      
//     D   DSDEC2                      12p 2            
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      * main(): Control flow
//      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//     C     *Entry        PLIST                   
//     C                   PARM                    INCHARA
//     C                   PARM                    INCHARB
//     C                   PARM                    INDEC1
//     C                   PARM                    INDEC2
//     C                   PARM                    INDS1


/* prepare */
$description = 
array
( 
  // single parms
  array
  ( "Name"=>"INCHARA","IO"=>I5_IN|I5_OUT,"Type"=>I5_TYPE_CHAR,"Length"=>"1"),
  array
  ( "Name"=>"INCHARB","IO"=>I5_IN|I5_OUT,"Type"=>I5_TYPE_CHAR,"Length"=>"1"),
  array
  ( "Name"=>"INDEC1","IO"=>I5_IN|I5_OUT,"Type"=>I5_TYPE_PACKED,"Length"=>"7.4"),
  array
  ( "Name"=>"INDEC2","IO"=>I5_IN|I5_OUT,"Type"=>I5_TYPE_PACKED,"Length"=>"12.2"),
  // structure parm 
  array
  ( "DSName"=>"INDS1",
    "Count"=>1,
    "DSParm"=>
    array
    ( 
     array
     ( "Name"=>"DSCHARA","IO"=>I5_IN|I5_OUT,"Type"=>I5_TYPE_CHAR,"Length"=>"1"),
     array
     ( "Name"=>"DSCHARB","IO"=>I5_IN|I5_OUT,"Type"=>I5_TYPE_CHAR,"Length"=>"1"),
     array
     ( "Name"=>"DSDEC1","IO"=>I5_IN|I5_OUT,"Type"=>I5_TYPE_PACKED,"Length"=>"7.4"),
     array
     ( "Name"=>"DSDEC2","IO"=>I5_IN|I5_OUT,"Type"=>I5_TYPE_PACKED,"Length"=>"12.2"),
    )
  )
);
$pgm = i5_program_prepare("$testLib/ZZCALL", $description);
if (!$pgm)
{ $tab = i5_error();
  die("Prepare: ".$tab[2]." "."$tab[3], $tab[0]");
}

// *** parameter list allocation
$list=
array
( 
  "DSCHARA"=>"x",  
  "DSCHARB"=>"y", 
  "DSDEC1"=>66.6666,
  "DSDEC2"=>77777.77,
);
// *** parameter values passed to procedure
$in = 
array
( 
  "INCHARA"=>"a",  
  "INCHARB"=>"b", 
  "INDEC1"=>11.1111,
  "INDEC2"=>222.22,
  "INDS1"=>$list,
);
// *** name of variables created for out parameters
$out = 
array
(
  "INCHARA"=>"INCHARA",  
  "INCHARB"=>"INCHARB", 
  "INDEC1"=>"INDEC1",
  "INDEC2"=>"INDEC2",
  "INDS1"=>"INDS1",
);
$rc=i5_program_call($pgm, $in, $out);
if ($rc != false)
{
  if ($INCHARA != 'C') die("bad C == $INCHARA\n");
  if ($INCHARB != 'D') die("bad D == $INCHARB\n");
  if ($INDEC1 != 321.1234) die("bad 321.1234 == $INDEC1\n");
  if ($INDEC2 != 1234567890.12) die("bad 1234567890.12 = $INDEC2\n");
  if ($INDS1["DSCHARA"] != 'E'
  ||  $INDS1["DSCHARB"] != 'F'
  ||  $INDS1["DSDEC1"] != 333.333
  ||  $INDS1["DSDEC2"] != 4444444444.44) 
  {
    var_dump($INDS1);
    die("bad DS not correct\n");
  }

}
else
{ $tab = i5_error();
  die("Call: ".$tab[2]." "."$tab[3], $tab[0]");
}


// good
echo "I have ... \n";
echo "Success\n";
?>
--EXPECTF--
%s
Success

