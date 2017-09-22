



function infix_arithmetic_langs(lang){
	return ["javascript","perl","python","java","lua","c","c++","perl","ruby","haxe"].indexOf(lang) !== -1;
}

function last_char(the_string){
	return the_string.charAt((the_string.length) - 1);
}

function index_in_array(the_arr,to_find){
	var i = 0;
	while(i < the_arr.length){
		var the_index = the_arr[i];
		if(the_index+0 === to_find){
			return the_arr[i];
		}
		else{
			i++;
		}
	}
	return -1;
}

function matches_pattern(arr,pattern){
	if(pattern.length !== arr.length){
		return false;
	}
	else{
		var i = 0;
		while(i<arr.length){
			if((last_char(pattern[i]) !== '_') && (pattern[i] !== arr[i])){
				return false;
			}
			else{
				i++;
			}
		}
	}
	return true;
}

function string_matches_pattern(str1,pattern){
	return matches_pattern(str1.split(" "),pattern.split(" "));
}
var z = string_matches_pattern("hello stuff","hello 1_");
function while_loop(lang,a,b){
	if(["javascript","java","c","c++"].indexOf(lang) !== -1){
		return "while("+a+"){"+ b +"}";
	}
	else{
		return "undefined";
	}
}

function if_statement(lang,a,b){
	if(["javascript","java","c","c++"].indexOf(lang) !== -1){
		return "if("+a+"){"+ b +"}";
	}
	else{
		return "undefined";
	}
}

function elif_statement(lang,a,b){
	if([("java"+"script"),"java","c","c++"].indexOf(lang) !== -1){
		return "else if("+a+"){"+ b +"}";
	}
	else{
		return "undefined";
	}
}

function infix_operator(lang,operator,a,b){
	if(infix_arithmetic_langs(lang)){
		return a + " "+operator+" " + b;
	}
	else{
		return "("+operator+" "+a+" "+b+")";
	}
}

function add(lang,a,b){
	return infix_operator(lang,"+",a,b);
}

function subtract(lang,a,b){
	return infix_operator(lang,"-",a,b);
}

function multiply(lang,a,b){
	return infix_operator(lang,"*",a,b);
}

function divide(lang,a,b){
	return infix_operator(lang,"/",a,b);
}

function less_than(lang,a,b){
	return infix_operator(lang,"=",a,b);
}

function less_than_or_equal(lang,a,b){
	return infix_operator(lang,"<=",a,b);
}

function greater_than_or_equal(lang,a,b){
	return infix_operator(lang,">=",a,b);
}

function greater_than(lang,a,b){
	return infix_operator(lang,">",a,b);
}

function compare(lang,a,b){
	return infix_operator(lang,"==",a,b);
}

function concatenate_string(lang,a,b){
	if(["lua"].indexOf(lang) !== -1){
		return infix_operator(lang,"..",a,b);
	}
	else if(["php","perl"].indexOf(lang) !== -1){
		return infix_operator(lang,".",a,b);
	}
	else if(["haskell"].indexOf(lang) !== -1){
		return infix_operator(lang,"++",a,b);
	}
	else{
		return infix_operator(lang,"+",a,b);
	}
}

function compare_strings(lang,a,b){
	if(['php','javascript'].indexOf(lang) !== -1){
		return infix_operator(lang,"===",a,b);
	}
	else if(['prolog'].indexOf(lang) !== -1){
		return infix_operator(lang,"=",a,b);
	}
	else if(['python'].indexOf(lang) !== -1){
		return infix_operator(lang,"==",a,b);
	}
	else{
		return "undefined";
	}
}

function indent_line(line,number_of_indents){
	var i = 0;
	while(i < number_of_indents){
		line = "    "+line;
		i++;
	}
	return line;
}
