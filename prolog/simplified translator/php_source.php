

function infix_arithmetic_langs($lang){
	return in_array($lang,array("javascript","perl","python","java","java","c","c++","perl"));
}
function last_char($the_string){
	return $the_string[strlen($the_string)-1];
}
function index_in_array($the_arr,$to_find){
	$i=0;
	while($i<sizeof($the_arr)){
		if($the_arr[$i]+0===$to_find){
			return $the_arr[$i];
		}
		else{
			$i++;
		}
	}
	return -1;
}
function matches_pattern($arr,$pattern){
	if(sizeof($pattern)!==sizeof($arr)){
		return false;
	}
	else{
		$i=0;
		while($i<sizeof($arr)){
			if((last_char($pattern[$i])!=='_')&&($pattern[$i]!==$arr[$i])){
				return false;
			}
			else{
				$i++;
			}
		}
	}
	return true;
}
function string_matches_pattern($str1,$pattern){
	return matches_pattern(explode(" ",$str1),explode(" ",$pattern));
}
$z=string_matches_pattern("hello stuff","hello 1_");
function while_loop($lang,$a,$b){
	if(in_array($lang,array("javascript","java","c","c++"))){
		return "while(".$a."){".$b."}";
	}
	else{
		return "undefined";
	}
}
function if_statement($lang,$a,$b){
	if(in_array($lang,array("javascript","java","c","c++"))){
		return "if(".$a."){".$b."}";
	}
	else{
		return "undefined";
	}
}
function elif_statement($lang,$a,$b){
	if(in_array($lang,array("javascript","java","c","c++"))){
		return "else if(".$a."){".$b."}";
	}
	else{
		return "undefined";
	}
}
function add($lang,$a,$b){
	if(infix_arithmetic_langs($lang)){
		return $a." + ".$b;
	}
	else{
		return "(+ ".$a." ".$b.")";
	}
}
function subtract($lang,$a,$b){
	if(infix_arithmetic_langs($lang)){
		return $a." - ".$b;
	}
	else{
		return "(- ".$a." ".$b.")";
	}
}
function multiply($lang,$a,$b){
	if(infix_arithmetic_langs($lang)){
		return $a." * ".$b;
	}
	else{
		return "(* ".$a." ".$b.")";
	}
}
function divide($lang,$a,$b){
	if(infix_arithmetic_langs($lang)){
		return $a." / ".$b;
	}
	else{
		return "(/ ".$a." ".$b.")";
	}
}
function less_than($lang,$a,$b){
	if(infix_arithmetic_langs($lang)){
		return $a." < ".$b;
	}
	else{
		return "(< ".$a." ".$b.")";
	}
}
function greater_than($lang,$a,$b){
	if(infix_arithmetic_langs($lang)){
		return $a." > ".$b;
	}
	else{
		return "(> ".$a." ".$b.")";
	}
}
function indent_line($line,$number_of_indents){
	$i=0;
	while($i<$number_of_indents){
		$line="    ".$line;
		$i++;
	}
	return $line;
}