--TEST--
XML i Toolkit: - cwtest pcml
--SKIPIF--
<?php require_once('skipifcw.inc'); ?>
--FILE--
<?php
// see connection.inc param details ...
require_once('xxcw_test_setup.php');

if ($doPcml) {

echo h2('PCML program calls');
	
	$pcml = '<pcml version="4.0">
   <program name="YYPLUS" entrypoint="YYPLUS"  path="/QSYS.LIB/' . $demoLib . '.LIB/YYSRVNORES.SRVPGM" >
      <data name="START" type="int" length="4" precision="31" usage="inputoutput" />
      <data name="RESULT" type="int" length="4" precision="31" usage="inputoutput" />
   </program>
</pcml>';

	echo 'About to do simple PCML program prepare.<BR>';
	$pgmHandle = i5_program_prepare_PCML($pcml);

	if (!$pgmHandle) {
		die('Error preparing simple PCML program: ' . printArray(i5_error()) . '<BR><BR>');
	} else {
		
		$input = array('START' => '25', 'RESULT' => '0');
		$output = array('START' => 'START', 'RESULT' => 'RESULT');
		echo 'About to do simple PCML program call.<BR>';
		$success = i5_program_call($pgmHandle, $input, $output);
	
		if ($success) {
			echo "Success. Output variables: START: $START. RESULT: $RESULT.";
		} else {
			die("Problem calling PCML-described program. Error: " . print_r(i5_error(), true));
		}
		
	} //(if !$pgmHandle)
	

echo '<BR><BR>';

$pcml = "<pcml version=\"4.0\">                                                                
   <struct name=\"S2\">                                                               
      <data name=\"ZOND2\" type=\"zoned\" length=\"10\" precision=\"5\" usage=\"inherit\" />  
      <data name=\"PACK2\" type=\"packed\" length=\"19\" precision=\"5\" usage=\"inherit\" />
      <data name=\"PACK3\" type=\"packed\" length=\"19\" precision=\"5\" usage=\"inherit\" />
      <data name=\"ALPH2\" type=\"char\" length=\"20\" usage=\"inherit\" />                 
   </struct>                                                                        
   <struct name=\"S1\">                                                               
      <data name=\"ZOND\" type=\"zoned\" length=\"10\" precision=\"5\" usage=\"inherit\" />   
      <data name=\"PACK1\" type=\"packed\" length=\"19\" precision=\"5\" usage=\"inherit\" />
      <data name=\"ALPH1\" type=\"char\" length=\"10\" usage=\"inherit\" />                 
   </struct>                                                                        
   <program name=\"TESTSTRUC\" path=\"/QSYS.LIB/{$demoLib}.LIB/TESTSTRUC.PGM\">   
      <data name=\"CODE\" type=\"char\" length=\"10\" usage=\"output\" />                  
      <data name=\"S1\" type=\"struct\" struct=\"S1\" usage=\"inputoutput\" />                  
      <data name=\"S2\" type=\"struct\" struct=\"S2\" usage=\"inputoutput\" />                  
      <data name=\"PACK\" type=\"packed\" length=\"1\" precision=\"1\" usage=\"output\" />   
      <data name=\"CH10\" type=\"char\" length=\"19\" usage=\"output\" />                  
      <data name=\"CH11\" type=\"char\" length=\"20\" usage=\"output\" />                  
      <data name=\"CH12\" type=\"char\" length=\"29\" usage=\"output\" />                  
      <data name=\"CH13\" type=\"char\" length=\"33\" usage=\"output\" />                  
   </program>                                                                           
</pcml>";                                                                                 
	
	echo 'About to do a complex PCML program prepare.<BR>';
	$pgmHandle = i5_program_prepare_PCML($pcml);

	if ($pgmHandle) {
		echo "Successfully prepared complex PCML program description.<BR>";
	} else {
		echo "Problem while preparing complex PCML program description.<BR>";
	}
	// define some input values
$pack3value=7789777.44;
$alph2value=4;

$paramIn = Array(
"S1"=>Array("ZOND"=>54.77, "PACK1"=>16.2, "ALPH1"=>"MyValue"),
"S2"=>Array("ZOND2"=>44.66, "PACK2"=>24444.99945, "PACK3"=>$pack3value, "ALPH2"=>$alph2value)
);

// now we need to define where to place output values; it will create new local variables

$paramOut = array(
					"S1"=>"S1_Value", "S2"=>"S2_Value",
					"CH10"=>"CH10_Value", "CH11"=>"CH11_Value", "CH12"=>"CH12_Value", "CH13"=>"CH13_Value",
					"CODE"=>"Code_Value", "PACK"=>"Pack"
);
	echo 'About to do complex PCML program call.';
	$success = i5_program_call($pgmHandle, $paramIn, $paramOut);
    if (function_exists('i5_output')) extract(i5_output()); // i5_output() required if called in a function

    if ($success) {
		echo "Success.";
		echo "<BR>S1: " . var_export($S1_Value, true);
		echo "<BR>S2: " . var_export($S2_Value, true);
		echo "<BR>CH10: " . var_export($CH10_Value, true);
		echo "<BR>CH11: " . var_export($CH11_Value, true);
		echo "<BR>CH12: " . var_export($CH12_Value, true);
		echo "<BR>CH13: " . var_export($CH13_Value, true);
		echo "<BR>Code: " . var_export($Code_Value, true);
		echo "<BR>Pack: " . var_export($Pack, true);
		
	} else {
		die("Problem calling PCML-described program. Error: " . printArray(i5_error()));
	}
	
} //(doPcml)


// good
echo "\nSuccess\n";
?>
--EXPECTF--
%s
Success

