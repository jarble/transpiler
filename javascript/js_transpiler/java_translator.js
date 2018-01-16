"use strict";
var types = {};
var defined_vars = {};
var function_name;
var ws = "";
var ws_ = " ";
var class_name = "";
var parsers =
		{
			"java":java_parser,
			"kotlin":kotlin_parser,
			"javascript":javascript_parser,
			"octave":octave_parser,
			"smt_lib":smt_lib_parser,
			"typescript":typescript_parser,
			"wolfram":wolfram_parser,
			"erlang":erlang_parser,
			"mathematical notation":mathematical_notation_parser,
			"maxima":maxima_parser,
			"c++":cpp_parser,
			"ada":ada_parser,
			"lua":lua_parser,
			"c#":c_sharp_parser,
			"ruby":ruby_parser,
			"go":go_parser,
			"minizinc":minizinc_parser,
			"rust":rust_parser,
			"scala":scala_parser,
			"haskell":haskell_parser,
			"prolog":prolog_parser,
			"coq":coq_parser,
			"common lisp":common_lisp_parser,
			"clojure":clojure_parser,
			"clips":clips_parser,
			"julia":julia_parser,
			"php":php_parser,
			"jison":jison_parser,
			"c":c_parser,
			"haxe":haxe_parser,
			"perl":perl_parser,
			"constraint handling rules":prolog_parser,
			"pddl":pddl_parser
		}; 

function test_examples(){
	var lang1;
	var inputText;
	var output_array = "";
	var test_cases = [
			["$a = array_search([1,2,4,3],4);","php","get first occurrence in array"],
			["public class Example{public double set_num(int a){return a;}}","java","class instance method"],
			["public class Example{public static double set_num(int a){return a;}}","java","class static method"],
			["public class Example{public Example(int a){a=a+1;}}","java","class constructor"],
			["import myLibrary;","java","import functions"],
			["import myFunction from \"myLibrary\";","javascript","import one function from another file"],
			["$a1 = range(1,5);","php","generate range of numbers"],
			["raise \"message\"","ruby","throw error"],
			["assert(1 === 1+2);","javascript","assert"],
			["int a1 = 1;","java","initialize variable"],
			["int a1 = Math.abs(1.1);","java","absolute value"],
			["final int a1 = 1;","java","declare constant"],
			["var a1:number = 1; var a:number = ((a1>3) ? 3 : 4);","typescript","ternary operator"],
			["int parsed_int = Integer.parseInt(\"2\");","java","convert string to integer"],
			["comprehension -> [X || X <- [1,2,3], X > 3].","erlang","list comprehension"],
			["comprehension = [x+2*x+x/2 | x <- [1,2,3,4]]","haskell","list comprehension"],
			["String reversed_string = new StringBuilder(\"hello\").reverse().toString();","java","reverse string"],
			["$a = array_reverse(array(1,2,3));","php","reverse array"],
			["$shuffled_array = shuffle(array(1,2,3,4));","php","shuffle array in place"],
			["String the_substring = \"Hello\".substring(0,3);","java","substring"],
			["var slice_arr = [1,2,3,4].slice(0,2);","javascript","array slice"],
			["int str_index = \"hi,stuff\".indexOf(\",\");","java","index of substring"],
			["String[] a = \"hi,stuff\".split(\",\");","java","split string"],
			["String[] a = \"hi,stuff\".split(\",\"); String g = a.join(\",\");","java","join string"],
			["boolean g = false;","java","false"],
			["boolean g = true;","java","true"],
			["boolean g = true && false;","java","and operator"],
			["boolean g = true || false;","java","not operator"],
			["boolean g = !true;","java","not operator"],
			["int a1 = 0; while(a1 < 10){a1 = a1 + 1;}","java","while loop"],
			["for(int a1 = 0; a1 < 10; a1++){System.out.println(a1);}","java","\"for loop\""],
			["int string_length = \"A string\".length();","java","string length"],
			["int a1 = Math.floor(3.5);","java","floor"],
			["int a1 = Math.random();","java","random"],
			["double a1 = Math.PI;","java","pi"],
			["double a1 = Math.exp(1);","java","exp"],
			["int a1 = Math.round(3.4);","java","round"],
			["int a1 = Math.ceil(3.4);","java","ceiling"],
			["int a1 = 0; a1--;","java","minus minus"],
			["int a1 = 0; a1 += 2;","java","plus equals operator"],
			["int a1 = 0; a1 -= 2;","java","minus equals"],
			["int a1 = 0; a1 *= 2;","java","times equals"],
			["int a1 = 0; a1 /= 2;","java","divide equals"],
			["int a1 = 0; a1 %= 2;","java","modulo equals operator"],
			["int[] a = {3,4,5};for(int i:a){System.out.println(i);}","java","foreach loop"],
			["int a1 = Math.pow(2,3);","java","exponent"],
			["int a1 = Math.log(3);","java","logarithm"],
			["int a1 = Math.log10(3);","java","log10"],
			["double a1 = log2(3);","c","log2"],
			//["public static boolean add(int a, int b){if(a < b){return a == b;}else if(a > b){return a == b;}else{return a == b;}}"],
			["String str1 = \"hi\" + \"hi\";","java","concatenate string"],
			["String str1 = \"hi\".toUpperCase();","java","uppercase"],
			["String str1 = \"hi\".toLowerCase();","java","lowercase"],
			["char char1 = Character.toUpperCase('c');","java","character to uppercase"],
			["char char1 = Character.toLowerCase('c');","java","character to lowercase"],
			["HashMap<String, String> myMap = new HashMap<String, String>(); myMap.add(\"1\",\"2\"); String str2 = myMap.get(\"2\");","java","associative array"],
			["int[] arr1 = {1,2,3}; arr1[0] = 2; arr1[1] = arr1[2];","java","array index"],
			//["public class Example{private static int b; private int a; public static int add(int a, int b){return a + b;} public int subtract(int a, int b){return a - b;}}"],
			//["public class Example extends SecondExample{public int subtract(int a, int b){return a - b;}}"],
			["int a1 = 0; switch(a1){case 1: return 2; break; case 3: return 3; break; default: return 4;}","java","switch statement"],
			["public static int add(int a, int b=1){return a + b;}","c#","optional parameter"],
			["Object a = \"Hi\"; if(a instanceof String){System.out.println(a);}","java","type checking"],
			["var numbers = [1,2,3]; var doubles = function(x) {return x * 2;};","javascript","anonymous function"],
			["var doubles = numbers.map(function(x) {return x * 2;});","javascript","map"],
			["var numbers = [0, 1, 2, 3]; var result = numbers.reduce(function(accumulator, currentValue) {return accumulator + currentValue;});",'javascript','array reduce'],
			["var words = [\"spray\", \"limit\", \"elite\", \"exuberant\", \"destruction\", \"present\", \"happy\"]; var longWords = words.filter(function(word){return word.length > 6;});","javascript","filter"],
			["boolean a = true | false;","java","eager or operator"],
			["boolean a = true & false;","java","eager and operator"],
			["double d1 = Math.sin(1);","java","sin"],
			["double d1 = Math.cos(1);","java","cos"],
			["double d1 = Math.tan(1);","java","tan"],
			["double d1 = Math.asin(1);","java","asin"],
			["double d1 = Math.acos(1);","java","acos"],
			["double d1 = Math.atan(1);","java","atan"],
			["double d1 = atanh(1);","c","atanh"],
			["double d1 = acosh(1);","c","acosh"],
			["double d1 = asinh(1);","c","asinh"],
			["double d1 = Math.sinh(1);","java","sinh"],
			["double d1 = Math.cosh(1);","java","cosh"],
			["double d1 = Math.tanh(1);","java","tanh"],
			["$randomnumber = rand(1,5);","php","random number in range"],
			["randomnumber = [1,2].sample","ruby","pick random from array"],
			["public static int add(int... a){return a[0]+a[1];}","java","varargs"],
			["ranged = 3...5","ruby","exclusive range operator"],
			["ranged = 3..5","ruby","inclusive range operator"],
			["var thing = a_function(...a);","javascript","unpack array arguments"]	
		];
		var parsed_texts = [];
		for(var i = 0; i < test_cases.length;i++){
			parsed_texts.push(parsers[test_cases[i][1]].parse(test_cases[i][0]));
		}
	//for(lang1 of ["java","perl","prolog","haxe","ocaml","common lisp","c++","c#","swift","go","typescript","lua","ruby","python","php","wolfram","minizinc","scala","visual basic .net","haskell","r","typescript","erlang"]){
	var list_of_langs;
	if(arguments.length === 0){
		list_of_langs = "prolog";
	}
	else{
		list_of_langs = arguments[0];
	}
	
	for(lang1 of list_of_langs){
		output_array += "These are not defined for "+lang1+":\n"
		var search_query = [];
		for(var j = 0; j < test_cases.length;j++){
			try{
				//console.log(lang1);
				//alert(j);
				
				//clear var types before generating code
				Object.keys(types).forEach(function (prop) {
					delete types[prop];
				});
	
				generate_code(test_cases[j][1],lang1.trim().toLowerCase(),"\n",parsed_texts[j]);
			}
			catch(e){
				console.log("Error for "+test_cases[j][0])
				console.log(e);
				var output_array_text = "<pre>    " + test_cases[j][0].replace(/&/g, "&amp;")
				.replace(/</g, "&lt;")
				.replace(/>/g, "&gt;")
				.replace(/"/g, "&quot;")
				.replace(/'/g, "&#039;")+"\n</pre>";
				if(test_cases[j][2] !== undefined){
					var query_url = "https://www.google.com/search?q=%22"+lang1+"%22 "+test_cases[j][2];
					output_array += "<a href = \""+query_url+"\" target=\"blank_\">"+output_array_text+"</a>";
				}
			}
		}
	}
	return output_array;
}

//from http://ourcodeworld.com/articles/read/189/how-to-create-a-file-and-generate-a-download-with-javascript-in-the-browser-without-a-server
function download_file(filename, text) {
    var pom = document.createElement('a');
    pom.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
    pom.setAttribute('download', filename);

    if (document.createEvent) {
        var event = document.createEvent('MouseEvents');
        event.initEvent('click', true, true);
        pom.dispatchEvent(event);
    }
    else {
        pom.click();
    }
}

function matches_symbol(item,symbol,symbols){
	if(symbol in symbols && typeof(symbol) === "string"){
		if((symbols[symbol] !== undefined) && (symbols[symbol] !== item)){
			return false;
		}
		symbols[symbol] = item;
		return true;
	}
	return false;
}

function rewrite_term(input_text,pattern,output_pattern){
	var symbols = {};
	get_uppercase_symbols(pattern,symbols);
	var to_return;
	if(matches_pattern(input_text,pattern,symbols)){
		to_return = copy_with_symbols(output_pattern,symbols);
	}
	else{
		to_return = input_text;
	}
	if(typeof(to_return) === "string"){
		return to_return;
	}
	else{
		for(var i = 0; i < to_return.length; i++){
			to_return[i] = rewrite_term(to_return[i],pattern,output_pattern);
		}
		return to_return;
	}
}

function get_uppercase_symbols(arr,newArr){
	for(var i = 0; i < arr.length; i++){
		if(Array.isArray(arr[i])){
			get_uppercase_symbols(arr[i],newArr);
		}
		else if(is_uppercase(arr[i])){
			newArr[arr[i]] = undefined;
		}
	}
}

function is_uppercase(word){
	return word[0] === word[0].toUpperCase();
}

var rewrite_rules = [];

function understand_text(input){
	rewrite_rules = [];
	var output = english_parser.parse(input);
	var output_stuff = [];
	for(var i = 0; i < output[1].length; i++){
		output[1][i] = recursive_rewrite(output[1][i]);
		if(output[1][i].length === 3 && output[1][i][1] === "means"){
			output[1][i][2] = recursive_rewrite(output[1][i][2]);
			rewrite_rules = rewrite_rules.concat([[output[1][i][0],output[1][i][2]]]);
		}
		else{
			output_stuff = output_stuff.concat([output[1][i]]);
		}
	}
	//alert(JSON.stringify(output_stuff));
	return ["top_level_statements",output_stuff];
}

function recursive_rewrite(output){
	for(var j = 0; j < rewrite_rules.length; j++){
		//alert("rewriting " + JSON.stringify(rewrite_rules[j]));
		output = rewrite_term(output,rewrite_rules[j][0],rewrite_rules[j][1]);
	}
	return output;
}

//alert(JSON.stringify(understand_text("A is a kitty means A is a cat. bob is a kitty. A is a mammal means A is a animal. A is a creature means A is a mammal. B is a creature.")));
//alert(JSON.stringify(rewrite_rules));

function copy_with_symbols(input,symbols){
	if(typeof(input) === "string"){
		if(input in symbols && symbols[input] !== undefined){
			return symbols[input];
		}
		else{
			return input;
		}
	}
	else{
		var newArr = [];
		for(var i = 0; i < input.length; i++){
			newArr = newArr.concat([copy_with_symbols(input[i],symbols)]);
		}
		return newArr;
	}
}

function matches_pattern_(arr,pattern,symbols){
	if((typeof arr) === (typeof pattern)){
		if((typeof arr === "string") || (typeof arr === "number")){
			return (arr === pattern) || matches_symbol(arr,pattern,symbols);
		}
		
		if(arr.length !== pattern.length){
			return false;
		}
		for(var i = 0; i < arr.length; i++){
			if(!(matches_pattern(arr[i],pattern[i],symbols) || matches_symbol(arr[i],pattern[i],symbols))){
				return false;
			}
		}
		return true;
	}
	else{
		return false;
	}
}

function matches_pattern(arr,pattern,symbols){
	var to_return;
	if(Array.isArray(arr) && member(arr[0],["==","!=","||","&&","|","&","logic_and","logic_or"])){
		//if the symbol is commutative
		to_return = matches_pattern_([arr[0],arr[1],arr[2]],pattern,symbols) || matches_pattern_([arr[0],arr[2],arr[1]],pattern,symbols);
	}
	else{
		//otherwise
		to_return = matches_pattern_(arr,pattern,symbols);
	}
	if(to_return){
		return to_return;
	}
	else{
		for(var key in symbols){
			if (!symbols.hasOwnProperty(key)) {
				continue;
			}
			symbols[key] = undefined;
		}
		return false;
	}
}

function member(lang,list){
	if(list === undefined){
		return false;
	}
	return list.indexOf(lang) !== -1;
}

function var_name(lang,var1){
	if(member(lang,["php","tcl","autoit"])){
		if(var1.startsWith("$")){
			return var1;
		}
		else{
			same_var_type("$"+var1, var1);
			return "$"+var1;
		}
	}
	else if(member(lang,['nearley'])){
		if(var1 === var1.toUpperCase()){
			return "$"+var1;
		}
		else{
			return var1;
		}
	}
	else if(member(lang,["perl","perl 6"])){
		if(var1.startsWith("$")){
			return var1;
		}
		else{
			same_var_type("$"+var1, var1);
			return "$"+var1;
		}
	}
	else if(member(lang,["clips","pddl"])){
		same_var_type("?"+var1,var1);
		return "?"+var1;
	}
	else if(member(lang,["prolog","picat","logtalk","erlang","constraint handling rules","chr.js"])){
		var to_return = var1.charAt(0).toUpperCase() + var1.slice(1);
		same_var_type(to_return,var1);
		return to_return;
	}
	else{
		return var1;
	}
}


function var_type(input_lang,lang,type){
	//console.log(type);
	var to_return;
	if((type[0] === "ArrayList") || (input_lang === "haxe" && type[0] === "Array")){
		if(lang === "java")
			return "ArrayList<"+type[1][0]+">";
		else if(lang === "haxe")
			return "Array<"+type[1][0]+">";
		else
			return var_type(input_lang,lang,[type[1][0],"[]"]);
	}
	else if(type[0] == "HashMap"){
		if(lang === "java"){
			return "HashMap<"+var_type(input_lang,lang,type[1][0])+","+var_type(input_lang,lang,type[1][1])+">";
		}
		else if(lang === "scala"){
			return "Map["+var_type(input_lang,lang,type[1][0])+","+var_type(input_lang,lang,type[1][1])+"]";
		}
		else if(lang === "swift"){
			return "["+var_type(input_lang,lang,type[1][0])+":"+var_type(input_lang,lang,type[1][1])+"]";
		}
		else if(member(lang,["haxe","typescript"])){
			return "Map<"+var_type(input_lang,lang,type[1][0])+","+var_type(input_lang,lang,type[1][1])+">";
		}
		else if(lang === "c#"){
			return "Dictionary<"+var_type(input_lang,lang,type[1][0])+","+var_type(input_lang,lang,type[1][1])+">";
		}
		else if(member(lang,["c++"])){
			return "std::map<"+var_type(input_lang,lang,type[1][0])+","+var_type(input_lang,lang,type[1][1])+">";
		}
		else if(member(lang,["go"])){
			return "map["+var_type(input_lang,lang,type[1][0])+"]"+var_type(input_lang,lang,type[1][1]);
		}
	}
	else if(member(type,["Object","auto","object"])){
		if(member(lang,["c#"])){
			return "object";
		}
		if(member(lang,["c++"])){
			return "auto";
		}
		else if(member(lang,['java','gnu smalltalk','visual basic .net'])){
			return "Object";
		}
	}
	else if(member(type, ["char"])){
		if(member(lang,['java','c','standard ml'])){
			return "char";
		}
	}
	else if(member(type, ["int","Int","Integer","integer","integer!","i32"])){
		if(member(lang,['hack','standard ml',"glsl",'mercury','nim','elm','ats','python','coconut','systemverilog','transact-sql','dafny','janus','chapel','minizinc','engscript','cython','algol 68','d','octave','tcl','ml','awk','julia','gosu','ocaml','f#','pike','objective-c','go','cobra','dart','groovy','hy','java','c#','c','c++','vala','nemerle'])){
			return "int";
		}
		else if(member(lang,['javascript',"lua",'typescript','coffeescript'])){
			return "number";
		}
		else if(member(lang,['rust'])){
			return "i32";
		}
		else if(member(lang,['protobuf'])){
			return "int32";
		}
		else if(member(lang,['ceylon','haskell','ada','ruby','cosmos','gambas','openoffice basic','pascal','erlang','delphi','visual basic','visual basic .net'])){
			return "Integer";
		}
		else if(member(lang,['php','fortran','vhdl','prolog','constraint handling rules','common lisp','picat'])){
            return "integer";
        }
        else if(member(lang,["rebol"])){
			return "integer!";
		}
		else if(member(lang,['haxe','idris','z3','kotlin','ooc','swift','scala','perl 6','smt-lib','monkey x'])){
			return "Int";
		}
	}
	else if(member(type,["double","Double","number","\"number\""])){
		if(member(lang,['java','thrift','c','c#','c++','dart','vala'])){
			return "double";
		}
		else if(member(lang,['javascript','coffeescript','typescript'])){
			return "number";
		}
		else if(member(lang,['visual basic .net','scala'])){
			return "Double";
		}
		else if(member(lang,['go'])){
			return "float64";
		}
		else if(member(lang,['javascript','coffeescript','python','coconut','haxe','minizinc'])){
			return "float";
		}
		else if(member(lang,['smt-lib'])){
			return "Real";
		}
	}
	else if(member(type,["String","string","\"string\"","str"])){
		if(member(lang,['vala','standard ml','thrift','protobuf','lua','systemverilog','seed7','octave','picat','mathematical notation','polish notation','reverse polish notation','prolog','constraint handling rules','d','chapel','minizinc','genie','hack','nim','algol 68','typescript','coffeescript','octave','tcl','awk','julia','c#','f#','perl','javascript','go','php','nemerle','erlang'])){
			return "string";
		}
		else if(member(lang,['smt-lib','elm','ruby','cosmos','visual basic .net','java','ceylon','gambas','dart','gosu','groovy','scala','pascal','swift','haxe','haskell','visual basic','monkey x'])){
			return "String";
		}
		else if(member(lang,["c++"])){
			return "std::string";
		}
		else if(member(lang,['c'])){
			return "char*";
		}
		else if(member(lang,['hy','python','coconut','cython'])){
			return "str";
		}
		else if(member(lang,["rebol"])){
			return "string!";
		}
		else if(member(lang,['smt-lib','cosmos','visual basic .net','java','ceylon','gambas','dart','gosu','groovy','scala','pascal','swift','haxe','haskell','visual basic','monkey x'])){
			return type;
		}
	}
	else if(type === "void"){
		if(member(lang,['engscript','seed7','php','hy','cython','go','pike','objective-c','java','c','c++','c#','vala','typescript','d','javascript','dart'])){
			return "void";
		}
		else if(member(lang,["scala"])){
			return "Unit";
		}
	}
	else if(member(type,["boolean","bool","Bool","Boolean"])){
		if(member(lang,['typescript','vhdl','seed7','hy','python','coconut','java','javascript','coffeescript','perl'])){
            return "boolean";
        }
		else if(member(lang,['c++','algol 68','protobuf','thrift','mercury','coq','nim','octave','dafny','chapel','c','rust','minizinc','engscript','dart','d','vala','go','cobra','c#','f#','php','hack'])){
            return "bool";
        }
		else if(member(lang,['haxe','idris','z3','haskell','swift','julia','perl 6','smt-lib','smt-lib','smt-libpy','monkey x'])){
			return "Bool";
		}
		else if(member(lang,['visual basic','visual basic .net','openoffice basic','ceylon','delphi','pascal','scala'])){
            return "Boolean";
        }
		else if(member(lang,['fortran'])){
			return "LOGICAL";
		}
	}
	else if((type[1] === "[]") && (type.length === 2)){
		if(member(lang,['c','c#','typescript'])){
			return var_type(input_lang,lang,type[0])+"[]";
		}
		else if(member(lang,['java'])){
			return "ArrayList<"+type[0]+">";
		}
		else if(member(lang,['coq'])){
			return "list "+type[0];
		}
		else if(member(lang,['visual basic .net'])){
			return var_type(input_lang,lang,type[0])+"()";
		}
		else if(member(lang,['minizinc'])){
			return "array[" + var_type(input_lang,lang,type[0]) + "] of var "+var_type(input_lang,lang,type[0]);
		}
		else if(member(lang,['scala'])){
			return "Array[" + var_type(input_lang,lang,type[0])+"]";
		}
		else if(member(lang,['haxe'])){
			return "Array<" + var_type(input_lang,lang,type[0])+">";
		}
		else if(member(lang,['c++'])){
			return "std::vector<" + var_type(input_lang,lang,type[0])+">";
		}
		else if(member(lang,['swift'])){
			return "[" + var_type(input_lang,lang,type[0])+"]";
		}
	}
	
	throw "var_type " + JSON.stringify(type) + " is not defined for " + lang;
}

function same_var_type(a,b){
	//console.log("Same var type: "+a+","+b);
	if((types[b] === undefined) && (types[a] !== undefined)){
		types[b] = get_type(a);
	}
	else if((types[a] === undefined) && (types[b] !== undefined)){
		types[a] = get_type(b);
	}
	else if(!(member(undefined,[types[a],types[b]]) || member("Object",[types[a],types[b]]) || matches_pattern(types[a],types[b],{}))){
		//if a and b do not have the same type or one of them is an Object
		throw "Type of "+a+":"+JSON.stringify(types[a])+" does not match type of "+b+":"+JSON.stringify(types[b]);
	}
}

function get_type(the_object){
	//console.log("Get type of "+the_object);
	if(typeof the_object === 'String' && the_object.startsWith("\"")){
		//detect string literals
		types[the_object] = "String";
		return "String";
	}
	if(typeof the_object === 'char' && the_object.startsWith("\"")){
		//detect char literal
		types[the_object] = "char";
		return "char";
	}
	else if(the_object.length === 2 && the_object[0] === "." && !isNaN(the_object[1])){
		return "int";
	}
	else if(types[the_object] == undefined){
		throw "type  of " + the_object + " is unknown";
	}
	else{
		return types[the_object];
	}
}


function semicolon(lang,statement){
	if(member(lang,['visual basic .net','standard ml','matlab','agda','autoit','applescript','reverse polish notation','sidef','tex','racket','gosu','mercury','idris','coq','nim','emacs lisp','chr.js','bash','tcl','elixir','maxima','coconut','english','elm','ats','z3py','cython','kotlin','wolfram','clojure','hack','ocaml','coffeescript','python','coconut','smt-lib','smt-lib','scala','clips','pddl','sympy','r','constraint handling rules','pydatalog','common lisp','gnu smalltalk','ruby','lua','hy','picolisp','logtalk','minizinc','swift','rebol','awk','fortran','go','picat','julia','prolog','haskell','mathematical notation','erlang','smt-lib'])){
		return statement;
	}
	else if(member(lang,['c','glsl','lc++','reasoned-php','logicjs','yacas','gap','vhdl','f#','php','dafny','chapel','katahdin','frink','falcon','aldor','idp','processing','seed7','drools','engscript','openoffice basic','ada','algol 68','d','ceylon','rust','typescript','octave','autohotkey','pascal','delphi','javascript','pike','objective-c','java','dart','c#','c++','bc','perl','perl 6','nemerle','vala','haxe'])){
		return statement+";";
	}
	else{
		throw "semicolon is not defined for "+lang;
	}
}

function prefix_arithmetic_lang(lang){
	return member(lang,['racket','scheme','smt-lib','smt-lib','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript']);
}
function infix_arithmetic_lang(lang){
	return member(lang,['pascal','glsl','agda','applescript','sidef','idris','lc++','chr.js','mercury','constraint handling rules','yacas','english','jison','prolog','elm','z3py','logtalk','picat','prolog','sympy','vhdl','elixir','python','coconut','visual basic .net','ruby','lua','scriptol', 'smt-libpy','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']);
}

function set_var_type(input_lang,lang,a,b){
	if(typeof b === "string"){
		types[a] = var_type(input_lang,"java",b);
	}
	else if(b.length === 2 && b[1] === "[]"){
		types[a] = [var_type(input_lang,"java",b[0]),"[]"];
	}
}

function parameter(input_lang,lang,x){
	if(typeof(x) === "string"){
		return parameter(input_lang,lang,["Object",x]);
	}
	else if(x.length === 2){
		set_var_type(input_lang,lang,x[1],x[0]);
		var type = types[x[1]];
		var name = x[1];
		//console.log("types: "+JSON.stringify(types));
		if(member(lang,["java","c#",'fortran'])){
			return var_type(input_lang,lang,x[0])+" "+x[1];
		}
		if(member(lang,["cython"])){
			if(x[0] === "Object"){
				return name;
			}
			else{
				return var_type(input_lang,lang,x[0])+" "+name;
			}
		}
		else if(member(lang,["go"])){
			return name+" "+var_type(input_lang,lang,x[0]);
		}
		else if(member(lang,["rebol"])){
			if(x[0] === "Object"){
				return name;
			}
			else{
				return name+" ["+var_type(input_lang,lang,x[0])+"]";
			}
		}
		else if(member(lang,["julia"])){
			if(x[0] === "Object"){
				return name;
			}
			else{
				return name+"::"+var_type(input_lang,lang,x[0]);
			}
		}
		else if(member(lang,["smt-lib"])){
			return "("+name+" "+var_type(input_lang,lang,x[0])+")";
		}
		else if(member(lang,["typescript","haxe","standard ml"]) && member(x[0],["Object","object"])){
			return name;
		}
		else if(member(lang,['haxe','standard ml','ada','ats','vhdl','dafny','chapel','pascal','rust','genie','hack','nim','typescript','gosu','delphi','nemerle','scala','swift'])){
			return name+":"+var_type(input_lang,lang,x[0]);
		}
		else if(member(lang,['coq'])){
			return "(" + name+":"+var_type(input_lang,lang,x[0]) + ")";
		}
		else if(member(lang,['minizinc'])){
			return "var " +var_type(input_lang,lang,x[0])+":"+name;
		}
		else if(member(lang,["c","glsl","c++","d","algol 68","vala"])){
			return var_type(input_lang,lang,x[0])+" "+x[1];
		}
		else if(member(lang,["wolfram"])){
			return x[1]+"_";
		}
		else if(member(lang,["perl"])){
			return "$"+x[1];
		}
		else if(member(lang,["tcl"])){
			return x[1];
		}
		else if(member(lang,['haskell','agda','mercury','idris','lc++','emacs lisp','chr.js','reasoned-php','logicjs','yacas','elixir','erlang','elm','z3py','php','prolog','pddl','picat','definite clause grammars','nearley','sympy','pydatalog','python','autoit','coconut','applescript','english','ruby','lua','gap','hy','perl 6','cosmos','polish notation','reverse polish notation','scheme','mathematical notation','lispyscript','clips','clojure','f#','ml','racket','ocaml','common lisp','newlisp','frink','picat','idp','powershell','maxima','icon','coffeescript','octave','autohotkey','constraint handling rules','logtalk','awk','kotlin','dart','javascript','sidef','nemerle','erlang','php','autoit','r','bc'])){
			var to_return = var_name(lang,x[1]);
			types[x[1]] = x[0];
			return to_return;
		}
		else if(member(lang,['openoffice basic','gambas','visual basic .net'])){
			return name+" As "+var_type(input_lang,lang,x[0]);
		}
	}
	//optional parameters
	else if(x[0] === "default_parameter"){
		types[x[2]] = x[1];
		var type = x[1];
		var name = x[2];
		var body = generate_code(input_lang,lang,"",x[3]);
		if(member(lang,["c#","c++","vala"])){
			return var_type(input_lang,lang,type) + " "+name+"="+body;
		}
		else if(member(lang,["scala","swift"])){
			return name + ":" + var_type(input_lang,lang,type) + "=" + body;
		}
		else if(member(lang,["python",'coconut',"octave",'autohotkey','julia','nemerle','php','javascript','r'])){
			return name+"="+body;
		}
		else if(member(lang,["ruby"])){
			return name+":"+body;
		}
		else if(member(lang,["tcl"])){
			return "{"+name+" "+body+"}";
		}
		throw "default_parameter is not defined for "+lang;
	}
	else if(x[0] === "varargs"){
		types[x[2]] = [x[1],"[]"];
		var type = x[1];
		var name = x[2];
		if(member(lang,["java"])){
			return var_type(input_lang,lang,type) + "... "+name;
		}
		else if(member(lang,["kotlin"])){
			return "vararg " + var_type(input_lang,lang,type) + ":"+name;
		}
		else if(member(lang,["go"])){
			return name + "... " + var_type(input_lang,lang,type);
		}
		else if(member(lang,["scala"])){
			return name + ":" + var_type(input_lang,lang,type)+"*";
		}
		else if(member(lang,["javascript",'coffeescript','typescript',"php"])){
			return "..." + var_name(lang,name);
		}
		else if(member(lang,["python",'coconut',"ruby"])){
			return "*" + name;
		}
		else if(member(lang,["c#"])){
			return "params " + var_type(input_lang,lang,type) + "[] "+name;
		}
		else if(member(lang,["visual basic .net"])){
			return "ParamArray " + var_type(input_lang,lang,type) + "() As "+name;
		}
		throw "varargs is not defined for "+lang;
	}
	else if(x[0] === "ref_parameter"){
		var type = x[1];
		var name = var_name(lang,x[2]);
		types[name] = type;
		if(member(lang,["c#"])){
			return "ref " + var_type(input_lang,lang,type) + " "+name;
		}
		else if(member(lang,["php"])){
			return "&" + name;
		}
		else if(member(lang,["visual basic .net"])){
			return "ByRef " + var_type(input_lang,lang,type) + " As "+name;
		}
		else if(member(lang,["c++"])){
			return var_type(input_lang,lang,type) + " &"+name;
		}
		else if(member(lang,["c"])){
			return var_type(input_lang,lang,type) + " *"+name;
		}
		else if(member(lang,["prolog"])){
			return name;
		}
		throw "ref_parameter is not defined for "+lang;
	}
	else if(x[0] === "out_parameter"){
		var type = x[1];
		var name = var_name(lang,x[2]);
		types[name] = type;
		if(member(lang,["c#"])){
			return "out " + var_type(input_lang,lang,type) + " "+name;
		}
		else if(member(lang,["prolog"])){
			return name;
		}
		throw "out_parameter is not defined for "+lang;
	}
	throw "parameter is not defined for "+lang+": "+x;
}

function function_call_parameters(input_lang,lang,params){
	if(params === ""){
		return params;
	}
	params = params.map(function(x){return generate_code(input_lang,lang,"",x)});
	if(member(lang,['pseudocode','yacas','gosu','gap','awk','z3py','peg.js','english','ruby','definite clause grammars','nearley','sympy','systemverilog','vhdl','visual basic .net','perl','constraint handling rules','lua','ruby','python','coconut','javascript','logtalk','nim','seed7','pydatalog','e','vbscript','monkey x','livecode','ceylon','delphi','englishscript','cython','vala','dafny','wolfram','gambas','d','frink','chapel','swift','perl 6','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','fortran','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','typescript','dart','haxe','scala','visual basic'])){
		return params.join(",");
	}
	else if(member(lang,['hy','pddl','ocaml','f#','polish notation','reverse polish notation','smt-lib','scheme','racket','common lisp','clips','rebol','haskell','racket','clojure'])){
		return params.join(" ");
	}
	throw "function_call_parameters is not defined for "+lang;
}


function access_array_parameters(input_lang,lang,params){
	params = params.map(function(x){return generate_code(input_lang,lang,"",x)});
	if(member(lang,['c#','minizinc','wolfram'])){
		return params.join(",");
	}
	else if(member(lang,['scala','visual basic .net'])){
		return params.join(")(");
	}
	else if(member(lang,['smt-lib','smt-lib'])){
		return params.join(")(");
	}
	else if(member(lang,['haskell'])){
		return params.join("!!");
	}
	else if(member(lang,['c','coffeescript','cython','javascript','go','julia','python','coconut','java','swift','typescript','c++','lua','ruby','perl','php','haxe'])){
		return params.join("][");
	}
	throw "access_array_parameters is not defined for "+lang;
}

function parameters(input_lang,lang,params){
	if(params === "" || (Array.isArray(params) && params.length === 0)){
		return "";
	}
	params = params.map(function(x){return parameter(input_lang,lang,x)});
	if(member(lang,['pseudocode','standard ml',"glsl",'bc','autoit','applescript','algol 68','ada','sidef','gosu','mercury','lc++','chr.js','reasoned-php','logicjs','yacas','gap','elixir','awk','ats','z3py','kotlin','english','ruby','definite clause grammars','nearley','sympy','systemverilog','vhdl','visual basic .net','perl','constraint handling rules','lua','ruby','python','coconut','javascript','logtalk','nim','seed7','pydatalog','e','vbscript','monkey x','livecode','ceylon','delphi','englishscript','cython','vala','dafny','wolfram','gambas','d','frink','chapel','swift','perl 6','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','typescript','dart','haxe','scala','visual basic'])){
		return params.join(",");
	}
	else if(member(lang,['fortran','pddl','agda','idris','coq','emacs lisp','tcl','elm','hy','ocaml','f#','polish notation','reverse polish notation','smt-lib','scheme','racket','common lisp','clips','rebol','haskell','racket','clojure'])){
		return params.join(" ");
	}
	throw "parameters is not defined for "+lang;
}


function statements(input_lang,lang,indent,arr){
		//console.log("statements: "+ JSON.stringify(arr[1]));
		var a = arr[1].map(function(a){
			return generate_code(input_lang,lang,indent,a);
		});
		//console.log(JSON.stringify(arr[1]));
		if(member(lang,['java','glsl','applescript','sidef','tex','protobuf','chapel','idris','coq','lc++','chr.js','reasoned-php','logicjs','tcl','yacas','coconut','gap','lark',"pypeg",'canopy','ats','z3py',"peg.js","antlr","nearley",'jison','vhdl','c','pseudocode','perl 6','haxe','javascript','c++','c#','php','dart','actionscript','typescript','processing','vala','bc','ceylon','hack','perl'])){
			return a.join("");
		}
		else if(member(lang,['picat','maxima','lpeg','prolog','constraint handling rules','logtalk','erlang','lpeg'])){
			return a.join(",");
		}
		else if(member(lang,['minizinc'])){
			return a.join("/\\");
		}
		else if(member(lang,['wolfram'])){
			return a.join(";");
		}
		else if(member(lang,['pydatalog','python','coconut','pddl','visual basic .net','lua','ruby','hy','pegjs','racket','vbscript','monkey x','livecode','polish notation','reverse polish notation','clojure','clips','common lisp','emacs lisp','scheme','dafny','smt-lib','elm','bash','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','agda','pl/i','rexx','idp','falcon','processing','sympy','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','autoit','cobra','julia','groovy','scala','ocaml','gambas','matlab','rebol','red','go','awk','haskell','r','visual basic'])){
			return a.join(" ");
		}
		else{
			throw "statements is not defined for "+lang;
		}
}

function generate_code(input_lang,lang,indent,arr){
	if(member(lang,["vb .net","vb.net"])){
		lang = "visual basic .net";
	}
	else if(lang === "mathematica"){
		lang = "wolfram";
	}
	else if(lang === "latex"){
		lang = "tex";
	}
	else if(lang === "gallina"){
		lang = "coq";
	}
	else if(lang === "apache thrift"){
		lang = "thrift";
	}
	else if(lang === "protocol buffers"){
		lang = "protobuf";
	}
	else if(lang === "z3"){
		lang = "smt-lib";
	}
	
	var to_return;
	var pattern_array = {value:undefined};
	var matching_symbols = {"$a":undefined,"$b":undefined,"$c":undefined,"$d":undefined};
	console.log("Generating code: " + JSON.stringify(arr));
	
	if(arr === "true" || matches_pattern(arr,[".",["true"]],{})){
		if(member(lang,	['java','standard ml','forth','reverse polish notation','sidef','mercury','coq','tcl','clojure','ruby','lua','constraint handling rules','livecode','gap','dafny','smt-lib','perl 6','chapel','c','frink','elixir','pseudocode','pascal','minizinc','engscript','picat','rust','clojure','nim','hack','ceylon','d','groovy','coffeescript','typescript','octave','prolog','julia','f#','swift','nemerle','vala','c++','dart','javascript','erlang','c#','haxe','go','ocaml','scala','php','rebol'])){
			to_return = "true";
		}
		else if(member(lang,['python','coconut','idris','yacas','visual basic .net','pydatalog','hy','cython','autoit','haskell','vbscript','visual basic','monkey x','wolfram','delphi'])){
			to_return = "True";
		}
		else if(member(lang,['clips','r','ada'])){
			to_return = "TRUE";
		}
		else if(member(lang,['perl'])){
			to_return = "1";
		}
		types[to_return] = "boolean";
	}
	else if(arr === "undefined" || matches_pattern(arr,[".",["undefined"]],{})){
		if(member(lang,["javascript","typescript","coffeescript"]))
			return "undefined";
		else if(member(lang,["python",'coconut'])){
			return "None";
		}
	}
	else if(arr === "false" || matches_pattern(arr,[".",["false"]],{})){
		if(member(lang,	['java','standard ml','forth','reverse polish notation','sidef','mercury','coq','tcl','clojure','ruby','lua','constraint handling rules','livecode','gap','dafny','smt-lib','perl 6','chapel','c','frink','elixir','pseudocode','pascal','minizinc','engscript','picat','rust','clojure','nim','hack','ceylon','d','groovy','coffeescript','typescript','octave','prolog','julia','f#','swift','nemerle','vala','c++','dart','javascript','erlang','c#','haxe','go','ocaml','scala','php','rebol'])){
			to_return = "false";
		}
		else if(member(lang,['python','coconut','idris','yacas','visual basic .net','pydatalog','hy','cython','autoit','haskell','vbscript','visual basic','monkey x','wolfram','delphi'])){
			to_return = "False";
		}
		else if(member(lang,['clips','r','ada'])){
			to_return = "FALSE";
		}
		else if(member(lang,['perl'])){
			to_return = "0";
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c','php'],[".",["M_PI"]]],
		[['yacas'],[".",["Pi"]]],
		[['java','pseudocode','javascript','typescript','c#'],[".",["Math","PI"]]],
		[['lua','python'],[".",["math","pi"]]],
		[['perl','perl 6','octave','rebol'],[".",["pi"]]],
		[["erlang"],[".",["math",["function_call","pi",[]]]]],
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//array of parameters in the current function
		//[['javascript'],"arguments"],
		[['javascript'],"arguments"],
		[['javascript'],[".",["arguments"]]],
		[['perl'],"@_"],
		[['perl'],[".",["@_"]]],
		[["php"],["function_call","func_get_args",[]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = ["Object","[]"];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//represents undefined variables
		[['c','c++'],[".",["NULL"]]],
		[['java','c#'],['.',['null']]],
		[['python'],[".",['None']]],
		[['lua'],[".",['nil']]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//e^x
		[["r","octave","php",'python','maple','c','c++','common lisp','perl'],["function_call","exp",["$a"]]],
		[["wolfram"],["function_call","exp",["$a"]]],
		[["javascript","java"],[".",["Math",["function_call","exp",["$a"]]]]],
		[["lua","erlang"],[".",["math",["function_call","exp",["$a"]]]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['java','ruby','javascript',"coffeescript",'typescript','haxe','coffeescript','clojure'],[".",["Math",["function_call","cos",["$a"]]]]],
		[["c#",'visual basic .net'],[".",["Math",["function_call","Cos",["$a"]]]]],
		[["python","cython",'coconut',"lua","erlang"],[".",["math",["function_call","cos",["$a"]]]]],
		[["go","wolfram",'yacas','autohotkey'],["function_call","Cos",["$a"]]],
		[['rebol'],["function_call","cos/radians",["$a"]]],
		[['c','standard ml','opencl','glsl','mathematical notation','mathematical notation','reverse polish notation','reverse polish notation',"ocaml",'r','tcl','reduce','sympy','seed7','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'],["function_call","cos",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["c"]) && types[output] === "double"){
				to_return = "cos("+output+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['java','ruby','javascript',"coffeescript",'typescript','haxe','tan'],[".",["Math",["function_call","tan",["$a"]]]]],
		[["c#",'visual basic .net'],[".",["Math",["function_call","Tan",["$a"]]]]],
		[["go"],[".",["math",["function_call","Tan",["$a"]]]]],
		[["wolfram",'yacas','autohotkey'],["function_call","Tan",["$a"]]],
		[['rebol'],["function_call","tangent/radians",["$a"]]],
		[["python",'coconut',"cython","lua","erlang"],[".",["math",["function_call","tan",["$a"]]]]],
		[['c','standard ml','opencl','glsl','reverse polish notation','ocaml','seed7','r','tcl','picat','reduce','mathematical notation','maxima','sympy','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'],["function_call","tan",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["c"]) && types[output] === "double"){
				to_return = "tan("+output+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","javascript","coffeescript","typescript","haxe"],[".",["Math",["function_call","ceil",["$a"]]]]],
		[["python",'coconut',"lua","scala","nim","erlang"],[".",["math",["function_call","ceil",["$a"]]]]],
		[["rebol"],[".",["math",["function_call","round/ceiling",["$a"]]]]],
		[["c#",'visual basic .net'],[".",["Math",["function_call","Ceiling",["$a"]]]]],
		[['c','standard ml','reverse polish notation','tcl','minizinc',"c++",'perl','php','pl/i','octave','swift','julia'],["function_call","ceil",["$a"]]],
		[['perl 6','prolog'],["function_call","ceiling",["$a"]]],
		[["go"],[".",["math",["function_call","Ceil",["$a"]]]]],
		[['wolfram'],["function_call","Ceiling",["$a"]]],
		[['yacas','autohotkey',"frink","yacas"],["function_call","Ceil",["$a"]]],
		[['ruby'],[".",[["$a"],"ceil"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["haskell","common lisp"])){
			to_return = "(ceiling "+output+")";
		}
		else if(member(lang,["wolfram"])){
			to_return = "Ceiling["+output+"]";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['java','ruby','javascript',"coffeescript",'typescript','haxe','clojure'],[".",["Math",["function_call","asin",["$a"]]]]],
		[["c#",'visual basic .net'],[".",["Math",["function_call","Asin",["$a"]]]]],
		[["c++",'opencl','glsl','perl 6',"mathematical notation",'reverse polish notation','tcl',"haskell","maxima","sympy","c","perl","prolog","swift","php",'julia','octave',"minizinc"],["function_call","asin",["$a"]]],
		[["go"],["function_call","Asin",["$a"]]],
		[['rebol'],["function_call","arcsine/radians",["$a"]]],
		[['autohotkey'],["function_call","ASin",["$a"]]],
		[["wolfram","yacas"],["function_call","ArcSin",["$a"]]],
		[["python",'coconut',"lua","erlang"],[".",["math",["function_call","asin",["$a"]]]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['java','ruby','javascript',"coffeescript",'typescript','haxe','clojure'],[".",["Math",["function_call","acos",["$a"]]]]],
		[["c#",'visual basic .net'],[".",["Math",["function_call","Acos",["$a"]]]]],
		[["c++",'opencl','glsl','perl 6',"mathematical notation","reverse polish notation",'tcl',"haskell","c","sympy","perl","maxima","prolog","swift","php","minizinc",'julia','octave'],["function_call","acos",["$a"]]],
		[["python",'coconut',"lua","erlang"],[".",["math",["function_call","acos",["$a"]]]]],
		[["wolfram","yacas"],["function_call","ArcCos",["$a"]]],
		[["go"],["function_call","Acos",["$a"]]],
		[['rebol'],["function_call","arccosine/radians",["$a"]]],
		[["autohotkey"],["function_call","ACos",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['java','ruby','javascript',"coffeescript",'typescript','haxe','clojure'],[".",["Math",["function_call","atan",["$a"]]]]],
		[["c#",'visual basic .net'],[".",["Math",["function_call","Atan",["$a"]]]]],
		[["c++",'opencl','glsl','perl 6',"mathematical notation",'reverse polish notation','tcl',"c","c++","haskell","sympy","perl","maxima","prolog","swift","php","minizinc",'julia','octave'],["function_call","atan",["$a"]]],
		[["python",'coconut',"lua","erlang"],[".",["math",["function_call","atan",["$a"]]]]],
		[["go"],["function_call","Atan",["$a"]]],
		[['autohotkey'],["function_call","ATan",["$a"]]],
		[['rebol'],["function_call","arctangent/radians",["$a"]]],
		[["wolfram",'yacas'],["function_call","ArcTan",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c','octave','c++','perl','php','julia'],["function_call","atanh",["$a"]]],
		[["erlang",'python'],[".",["math",["function_call","atanh",["$a"]]]]],
		[["wolfram"],["function_call","ArcTanh",["$a"]]],
		[['javascript','ruby'],[".",["math",["function_call","atanh",["$a"]]]]],
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c','octave','c++','perl','php','julia'],["function_call","acosh",["$a"]]],
		[["erlang",'python'],[".",["math",["function_call","acosh",["$a"]]]]],
		[["wolfram"],["function_call","ArcCosh",["$a"]]],
		[['javascript','ruby'],[".",["math",["function_call","acosh",["$a"]]]]],
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c','octave','c++','perl','php','julia'],["function_call","asinh",["$a"]]],
		[["erlang",'python'],[".",["math",["function_call","asinh",["$a"]]]]],
		[["wolfram"],["function_call","ArcSinh",["$a"]]],
		[['javascript','ruby'],[".",["math",["function_call","asinh",["$a"]]]]],
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"mathematical notation",'reverse polish notation','prolog','haskell','tcl','c++','minizinc','php','perl','julia','octave'],
			["function_call","sinh",["$a"]]],
		[["wolfram"],
			["function_call","Sinh",["$a"]]],
		[['java','ruby','javascript','typescript','coffeescript','haxe'],
			[".",["Math",["function_call","sinh",["$a"]]]]],
		[['erlang','python','coconut','lua'],
			[".",["math",["function_call","sinh",["$a"]]]]],
		[['c#'],
			[".",["Math",["function_call","Sinh",["$a"]]]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"mathematical notation",'reverse polish notation','prolog','haskell','tcl','c++','minizinc','php','perl','octave','julia'],
			["function_call","cosh",["$a"]]],
		[['java','ruby','javascript','typescript','coffeescript','haxe'],
			[".",["Math",["function_call","cosh",["$a"]]]]],
		[['erlang','python','coconut','lua'],
			[".",["math",["function_call","cosh",["$a"]]]]],
		[['c#'],
			[".",["Math",["function_call","Cosh",["$a"]]]]],
		[["wolfram"],
			["function_call","Cosh",["$a"]]],
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"mathematical notation",'reverse polish notation','prolog','haskell','tcl','c++','minizinc','php','perl','octave','julia'],
			["function_call","tanh",["$a"]]],
		[['java','ruby','javascript',"coffeescript",'typescript','haxe'],
			[".",["Math",["function_call","tanh",["$a"]]]]],
		[['erlang','python','coconut','lua'],
			[".",["math",["function_call","tanh",["$a"]]]]],
		[['c#'],
			[".",["Math",["function_call","Tanh",["$a"]]]]],
		[["wolfram"],
			["function_call","Tanh",["$a"]]],
		]
	,matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['octave'],["function_call","perms",["$a"]]],
		[["wolfram"],["function_call","Permutations",["$a"]]],
		[['python','coconut'],
			[".",["itertools",["function_call","permutations",["$a"]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = [types[a],"[]"];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['r'],
			["function_call","median",["$a"]]],
		[['wolfram'],
			["function_call","Median",["$a"]]]
		]
	,matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['r'],
			["function_call","mean",["$a"]]],
		[['wolfram'],
			["function_call","Mean",["$a"]]],
		[['python','coconut'],
			[".",["statistics",["function_call","mean",["$a"]]]]],
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//$a is the needle, $b is the haystack
		[['php'],
			["function_call","array_search",["$a","$b"]]],
		[['python'],
			[".",["$b",["function_call","index",["$a"]]]]]
	],matching_symbols)){
		//var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		//types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['prolog'],["function_call","nonvar",["$a"]]],
		[['php'],["function_call","isset",["$a"]]],
		[['perl'],["function_call","defined",["$a"]]],
		[['julia'],["function_call","isdefined",["$a"]]],
		[['javascript'],
			["!=","$a",[".",["undefined"]]]],
		[['python','coconut'],
			["!=","$a",[".",["None"]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["prolog","php","javascript"])){
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		else if(lang === "ruby"){
			to_return = "(defined?" + a + ")";
		}
		else{
			to_return = "";
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['javascript'],
			["==","$a",[".",["undefined"]]]],
		[['prolog'],
			["function_call","var",["$a"]]],
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(lang === "php"){
			to_return = "!isset("+a+")";
		}
		else if(lang === "perl"){
			to_return = "!defined("+a+")";
		}
		else if(lang === "julia"){
			to_return = "!isdefined("+a+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['seed7','standard ml','opencl','glsl','mathematical notation','reverse polish notation','r','tcl','sympy','reduce','minizinc','c','ocaml','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'],
			["function_call","sin",["$a"]]],
		[['java','ruby','javascript',"coffeescript",'typescript','haxe','clojure'],
			[".",["Math",["function_call","sin",["$a"]]]]],
		[['rebol'],
			["function_call","sine/radians",["$a"]]],
		[["c#",'visual basic .net'],
			[".",["Math",["function_call","Sin",["$a"]]]]],
		[["python",'coconut',"cython","lua","erlang"],
			[".",["math",["function_call","sin",["$a"]]]]],
		[["go","wolfram","yacas",'autohotkey'],
			["function_call","Sin",["$a"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['javascript','java','scala','c','c++','lua','swift','php','ceylon','clojure','d'],
			["function_call","assert",["$a"]]],
		[['r'],
			["function_call","stopifnot",["$a"]]],
		[["visual basic .net","c#"],
			[".",["Debug",["function_call","Assert",["$a"]]]]],
		]
	,matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang, ["python",'coconut','cython',"haskell","java"])){
			to_return = "assert " + a;
		}
		else if(member(lang,["reverse polish notation","mathematical notation"])){
			to_return = a;
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "void";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		/*
			Get user input without text prompt:
			https://rosettacode.org/wiki/User_input/Text
		*/
		[['maple','swift'],
			["function_call","readline",[]]],
		[['sidef'],
			["function_call","read",["String"]]],
		[['seed7'],
			["function_call","readln",["string_input"]]],
		[['ocaml'],
			["function_call","read_line",[]]],
		[['ruby'],
			[".","gets"]],
		[['perl'],
			[".","<>"]],
		[['scala'],[".",["console","readLine"]]],
		]
	,matching_symbols)){
		if(member(lang,["lua"])){
			return "io.stdin:read()";
		}
		else if(member(lang,["perl"])){
			return "<>";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		/*
			Get user input without text prompt:
			https://rosettacode.org/wiki/User_input/Text
		*/
		[['python','coconut','matlab'],
			["function_call","input",["$a"]]],
		[['erlang'],
			[".",["io",["function_call","fread",["$a","\"~s\""]]]]],
		[['wolfram'],
			["function_call","InputString",["$a"]]],
		[['perl 6'],
			["function_call","prompt",["$a"]]],
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//generate range of numbers from a (inclusive) to b (inclusive)
		[['php'],
			["function_call","range",["$a","$b"]]],
		[['wolfram'],
			["function_call","Range",["$a","$b"]]],
		]
	,matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["ruby"])){
			to_return = "("+a+" .. "+b+").to_a";
		}
		else if(member(lang,["perl"])){
			to_return = "("+a+" .. "+b+")";
		}
		else if(member(lang,["haskell"])){
			to_return = "["+a+" .. "+b+"]";
		}
		else if(member(lang,["python","cython","coconut"])){
			to_return = "range("+a+", "+b+"+1)";
		}
		else if(member(lang,["php"])){
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = ["int","[]"];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['java','javascript','typescript','coffeescript','haxe','ruby'],[".",["Math",["function_call","sqrt",["$a"]]]]],
		[['python','coconut','cython','lua'],[".",["math",["function_call","sqrt",["$a"]]]]],
		[["go","wolfram"],["function_call","Sqrt",["$a"]]],
		[["c#"],[".",["Math",["function_call","Sqrt",["$a"]]]]],
		[['c',"tcl",'c++','reduce','sidef','seed7','julia','perl','php','perl 6','maxima','minizinc','prolog','octave','d','haskell','swift','mathematical notation','dart','picat','reverse polish notation','rebol'],["function_call","sqrt",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['javascript',"coffeescript",'java','typescript','haxe','actionscript','scala'],[".",["Math",["function_call","pow",["$a","$b"]]]]],
		[['erlang'],[".",["math",["function_call","pow",["$a","$b"]]]]],
		[['rebol'],[".",["math",["function_call","power",["$a","$b"]]]]],
		[["c#","visual basic .net"],[".",["Math",["function_call","Pow",["$a","$b"]]]]],
		[['c','perl','tcl','c++','php','hack','swift','minizinc','dart','d','sidef'],["function_call","pow",["$a","$b"]]],
		[['hy','common lisp','racket','clojure'],["function_call","expt",["$a","$b"]]],
		[['clips',"mathematical notation"],["function_call","**",["$a","$b"]]],
		[["lua",'julia'],["^","$a","$b"]],
		[["ruby","haskell","ada"],["**","$a","$b"]]
	],matching_symbols)){
		var arr1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var arr2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,['seed7','prolog','sympy','python','coconut','cython','ruby','chapel','haskell','cobol','picat','ooc','pl/i','rexx','maxima','awk','r','f#','autohotkey','tcl','autoit','groovy','octave','perl','perl 6','fortran'])){
			to_return = "("+arr1+"**"+arr2+")";
		}
		else if(member(lang,['julia','reduce','lua','engscript','visual basic','gambas','ceylon','wolfram','mathematical notation'])){
			to_return = "(" + arr1 + "^" + arr2 + ")";
		}
		else if(member(lang,['tex'])){
			to_return = arr1 + "^{" + arr2 + "}";
		}
		else if(member(lang,['reverse polish notation'])){
			to_return = arr1 + " " + arr2 + " ^";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//reverse an array (not in-place)
		[['javascript','haxe','coffeescript','typescript'],[".",["$a",["function_call","split",[[".",["\"\""]]]],["function_call","reverse",[]],["function_call","join",[[".",["\"\""]]]]]]],
		[['php'],["function_call","array_reverse",["$a"]]],
		[['perl','julia','rebol','frink'],["function_call","reverse",["$a"]]],
		[['ruby'],[".",["$a","reverse"]]],
		[['python','coconut'],["function_call","reversed",["$a"]]],
		[['erlang'],[".",["lists",["function_call","reverse",["$a"]]]]],
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		//same_var_type(to_return,a);
	}
	else if(input_lang === "php" && matches_pattern(arr,["function_call","array","$a"],matching_symbols)){
		return generate_code(input_lang,lang,indent,["initializer_list","Object",matching_symbols["$a"]]);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['java','javascript','haxe','typescript','coffeescript'],[".",["$a",["function_call","toUpperCase",[]]]]],
		[['rust','picat'],[".",["$a",["function_call","to_uppercase",[]]]]],
		[['lua'],[".",["string",["function_call","toUpperCase",["$a"]]]]],
		[['go'],[".",["string",["function_call","ToLower",["$a"]]]]],
		[['julia','rebol'],["function_call","uppercase",["$a"]]],
		[['c#','visual basic .net'],[".",["$a",["function_call","ToUpper",[]]]]],
		[['swift'],[".",["$a",["function_call","uppercased",[]]]]],
		[['python','coconut','cython'],[".",["$a",["function_call","upper",[]]]]],
		[['php'],["function_call","strtoupper",["$a"]]],
		[['wolfram'],["function_call","ToUpperCase",["$a"]]],
		[['r','octave','tcl'],["function_call","toupper",["$a"]]],
		[['haskell'],["function_call","toUpper",["$a"]]],
		[['perl'],["function_call","uc",["$a"]]],
		[['erlang'],["function_call","string:uppercase",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,['scala'])){
			to_return = a+".toUpperCase";
		}
		else if(member(lang,['ruby'])){
			to_return = a+".upcase";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "String";
	}
	else if(arr[0] === "method_call"){
		 var a,b,args;
		 //["method_call",["string_literal","\"hello,something\""],["function_call",["var_name","split"],[["string_literal","\",\""]]]]
		 if(arr === ["method_call",a,["function_call",["var_name",name],args]]){
		    return a + args;	 
		 }
	}
	else if(arr[0] === "." && Array.isArray(arr[1]) && (arr[1].length >2)){
		arr = ["."].concat(arr[1]);
		while(arr.length > 2){
			arr[1] = [".",[arr[1],arr.splice(2,1)[0]]];
		}
		return generate_code(input_lang,lang,indent,arr[1]);
		//alert(JSON.stringify(arr));
	}
	else if(
		//check if array contains item
		matching_patterns(pattern_array,input_lang,lang,arr,[
			[["java"],[".",[[".",["Arrays",["function_call","asList",["$a"]]]],["function_call","contains",["$b"]]]]],
			[["javascript","typescript","coffeescript"],["!=",[".",["$a",["function_call","indexOf",["$b"]]]],["-",[".",["1"]]]]],
			[["php"],["function_call","in_array",["$b","$a"]]],
			[["wolfram"],["function_call","MemberQ",["$a","$b"]]]
		],matching_symbols)
	){
		var a1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var a2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = array_contains(lang,a1,a2);
	}
	else if(
		//get last index of a substring
		matching_patterns(pattern_array,input_lang,lang,arr,[
			[['haxe','javascript','typescript','coffeescript','java'],[".",["$a",["function_call","LastIndexOf",["$b"]]]]],
		],matching_symbols)
	){
		var a1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var a2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(
		//get index of substring
		matching_patterns(pattern_array,input_lang,lang,arr,[
			[['java','haxe','javascript','typescript','coffeescript'],[".",["$a",["function_call","indexOf",["$b"]]]]],
			[['go'],[".",["strings",["function_call","Index",["$a","$b"]]]]],
			[['ruby'],[".",["strings",["function_call","index",["$a","$b"]]]]],
			[['lua'],[".",["string",["function_call","find",["$a","$b"]]]]],
			[['c#','visual basic .net'],[".",["$a",["function_call","IndexOf",["$b"]]]]],
			[['python','coconut','ruby'],[".",["$a",["function_call","index",["$b"]]]]],
			[['perl'],["function_call","index",["$a","$b"]]],
			[['php'],["function_call","strpos",["$a","$b"]]]
		],matching_symbols)
	){
		var a1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var a2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(arr[0] === "!="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["smt-lib","smt-lib"])){
			to_return = "(not (= "+a+" "+b+"))";
		}
		else if(member(lang,["scheme"])){
			to_return = "(not (eq? "+a+" "+b+"))";
		}
		else if(member(lang,['java','glsl','yacas',"minizinc",'ruby','python','coconut','cosmos','nim','octave','r','picat','englishscript','perl 6','wolfram','c','c++','d','c#','julia','perl','haxe','cython','minizinc','scala','swift','go','rust','vala'])){
			to_return = a + " != " + b;
		}
		else if(member(lang,['lua'])){
			to_return = a + " ~= " + b;
		}
		else if(member(lang,['elixir','wolfram','purescript','ocaml','standard ml','coq'])){
			to_return = a + " <> " + b;
		}
		else if(member(lang,['haskell'])){
			to_return = a + " /= " + b;
		}
		else if(member(lang,['haskell'])){
			to_return = "neq(" + a + "," + b + ")";
		}
		else if(member(lang,['clips'])){
			to_return = "(neq " + a + " " + b + ")";
		}
		else if(member(lang,['prolog','constraint handling rules'])){
			to_return = "dif(" + a + "," + b + ")";
		}
		else if(member(lang,['php','javascript','typescript','coffeescript'])){
			to_return = a + " !== " + b;
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "continue" && arr.length === 1){
		if(member(lang,["javascript","java","python",'coconut',"php","haxe","c","c++","c#"])){
			to_return = "continue";
		}
		if(member(lang,["ruby","perl"])){
			to_return = "next";
		}
	}
	else if(arr[0] === "break" && arr.length === 1){
		if(member(lang,["javascript",'typescript','coffeescript',"java","python",'coconut',"php","haxe","c","c++","c#"])){
			to_return = "break";
		}
	}
	else if(arr[0] === "!"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,['java','chapel','tcl','autohotkey','ruby','perl 6','katahdin','coffeescript','frink','d','ooc','ceylon','processing','janus','pawn','autohotkey','groovy','scala','hack','rust','octave','typescript','julia','awk','swift','scala','vala','nemerle','pike','perl','c','c++','objective-c','tcl','javascript','r','dart','java','go','php','haxe','c#','wolfram'])){
			to_return = "!"+a;
		}
		else if(member(lang,['python','coconut','scheme','smt-lib','lua','cython','pddl','mathematical notation','emacs lisp','minizinc','picat','genie','seed7','z3','idp','maxima','clips','engscript','hy','ocaml','clojure','erlang','pascal','delphi','f#','ml','racket','common lisp','rebol','haskell','sibilant'])){
			to_return = "(not "+a+")";
		}
		else if(member(lang,['visual basic','visual basic .net','autoit','livecode','monkey x','vbscript'])){
			to_return = "(Not "+a+")";
		}
		else if(member(lang,['coq'])){
			to_return = "~"+a;
		}
		else if(member(lang,['reverse polish notation'])){
			to_return = a+" not";
		}
		else if(member(lang,['z3py','yacas'])){
			to_return = "Not("+a+")";
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "function_call_ref"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,['c#'])){
			to_return = "ref "+a;
		}
		else if(member(lang,['php'])){
			to_return = a;
		}
		else if(member(lang,['c','c++'])){
			to_return = "&"+a;
		}
		types[to_return] = types[a];
	}
	else if(arr[0] === "await"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,['c#','javascript','python','coconut','typescript'])){
			to_return = "await "+a;
		}
		same_var_type(to_return,a);
	}
	else if(arr[0] === "parentheses"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(infix_arithmetic_lang(lang) || lang === "tex"){
			to_return = "("+a+")";
		}
		else{
			to_return = a;
		}
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",[[".",[["new","StringBuilder",["$a"]],["function_call","reverse",[]]]],["function_call","toString",[]]]]],
		[['javascript','haxe','coffeescript','typescript'],[".",["$a",["function_call","split",[[".",["\"\""]]]],["function_call","reverse",[]],["function_call","join",[[".",["\"\""]]]]]]],
		[['php'],["function_call","strrev",["$a"]]],
		[['python','coconut','common lisp','haskell'],["function_call","reversed",["$a"]]],
		[['scala'],[".",["$a","reverse"]]],
	],matching_symbols)){
		//reverse a string
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["perl"])){
			to_return = "(scalar reverse("+a+"))";
		}
		else if(member(lang,"c++")){
			//only works for reversing strings in place
			//to_return = "std::reverse("+a+".begin(),"+a+".end())";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,indent,arr,[[["java"],[".",["$a",["function_call","put",["$b","$c"]]]]]],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		if(member(lang,["javascript","python",'coconut',"ruby","lua"])){
			to_return = a+"["+b+"] ="+c;
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "void";
		
		if(to_return !== undefined){
			return indent+to_return;
		}
	}
	//add an item in an arraylist at an index
	//set_dict in grammar file
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["$a",["function_call","add",["$b","$c"]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		if(member(lang,['javascript','coffeescript','typescript','php','lua','c++','haxe','c#','ruby','python','coconut','haxe','swift'])){
			to_return = a+"["+b+"] ="+c;
		}
		else if(member(lang,['scala'])){
			to_return = a+"("+b+") ="+c;
		}
		else if(member(lang,['prolog'])){
			to_return = "member("+b+":"+c+","+a+")";
		}
		else if(member(lang,['perl'])){
			to_return = a+"{"+b+"} ="+c;
		}
		else if(member(lang,["java"])){
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "void";
		if(to_return !== undefined){
			return indent+to_return;
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["Arrays",["function_call","sort",["$a"]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["javascript","python",'coconut'])){
			to_return = a+".sort()";
		}
		else if(member(lang,["ruby"])){
			to_return = a+".sort()";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		
		if(to_return !== undefined){
			return indent+to_return;
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",[".",[[".",["$a","getClass"]],["function_call","isArray",[]]]]]],
		[["javascript"],[".",["Array",["function_call","isArray",["$a"]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["javascript"])){
			to_return = "Array.isArray("+a+")";
		}
		else if(member(lang,["prolog"])){
			to_return = "is_list("+a+")";
		}
		else if(member(lang,["python",'coconut'])){
			to_return = "(type("+a+") == list)";
		}
		else if(member(lang,["php"])){
			to_return = "is_array("+a+")";
		}
		else if(member(lang,["ruby"])){
			to_return = "("+a+".instance_of? Array)";
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//javascript array concatenation
		[["javascript"],[".",["$a",["function_call","concat",["$b"]]]]]
	],matching_symbols)){
		var a = matching_symbols["$a"];
		var b = matching_symbols["$b"];
		if(member(lang, ["python",'coconut',"ruby"])){
			return generate_code(input_lang,lang,indent,["+",a,b]);
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//java string concatenation
		[["java"],[".",["$a",["function_call","concat",["$b"]]]]]
	],matching_symbols)){
		var a = matching_symbols["$a"];
		var b = matching_symbols["$b"];
		if(types[generate_code(input_lang,lang,indent,a)] === "String"){
			return generate_code(input_lang,lang,indent,["+",a,b]);
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['javascript','java'],[".",["$a",["function_call","trim",[]]]]],
		[['c#'],[".",["$a",["function_call","Trim",[]]]]],
		[['python','coconut'],[".",["$a",["function_call","strip",[]]]]],
		[['ruby'],[".",["$a","strip"]]],
		[['perl 6'],[".",["$a","trim"]]],
		[['php'],["function_call","trim",["$a"]]],
		[['octave'],["function_call","strtrim",["$a"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['javascript'],[".",["$a",["function_call","hasOwnProperty",["$b"]]]]],
		[['ruby'],[".",["$a",["function_call","key?",["$b"]]]]],
		[['php'],["function_call","array_key_exists",["$b","$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["python","coconut"])){
			to_return = "(" + b + " in " + a +")";
		}
		else if(lang === "perl"){
			to_return = "(" + a + "[" + b + "] != nil)";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c#'],[".",["$a",["function_call","TrimEnd",[]]]]],
		[['python','coconut'],[".",["$a",["function_call","rstrip",[]]]]],
		[['ruby'],[".",["$a","rstrip"]]],
		[['php'],["function_call","rtrim",["$a"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c#'],[".",["$a",["function_call","TrimStart",[]]]]],
		[['python','coconut'],[".",["$a",["function_call","lstrip",[]]]]],
		[['ruby'],[".",["$a","lstrip"]]],
		[['php'],["function_call","ltrim",["$a"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(lang === "java" && matches_pattern(arr,["set_var",["access_array","$a",["$b"]],"$c"],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		to_return = a+".set("+b+","+c+")";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['javascript','coffeescript','haxe','groovy','java','typescript','rust','dart','ruby'],
			[".",["$a",["function_call","join",["$b"]]]]],
		[['python','coconut'],
			[".",["$b",["function_call","join",["$a"]]]]],
		[['scala'],
			[".",["$a",["function_call","mkstring",["$b"]]]]],
		[['go'],
			[".",["Strings",["function_call","join",["$a","$b"]]]]],
		[['c#'],
			[".",["String",["function_call","Join",["$b","$a"]]]]],
		[['erlang'],
			[".",["String",["function_call","join",["$b","$a"]]]]],
		[['php'],
			["function_call","implode",["$b","$a"]]],
		[['perl'],
			["function_call","join",["$b","$a"]]],
		[['d','julia'],
			["function_call","join",["$a","$b"]]]
	],matching_symbols)){
		var a_string = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var a_separator = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['javascript','ruby','coffeescript','java','dart','scala','groovy','haxe','rust','typescript','python','coconut','cython','vala'],
			[".",["$a",["function_call","split",["$b"]]]]],
		[['go'],
			[".",["strings",["function_call","split",["$a","$b"]]]]],
		[['erlang'],
			[".",["string",["function_call","tokens",["$a","$b"]]]]],
		[['visual basic .net'],
			[".",["$a",["function_call","Split",["$b"]]]]],
		[['visual basic .net'],
			[".",["string",["function_call","split",["$a","$b"]]]]],
		[['swift'],
			[".",["$a",["function_call","componentsSeparatedByString",["$b"]]]]],
		[["perl","processing"],
			["function_call","split",["$b","$a"]]],
		[['picat','d','julia','maxima'],
			["function_call","split",["$a","$b"]]],
		[['haskell'],
			["function_call","splitOn",["$a","$b"]]],
		[['octave'],
			["function_call","strsplit",["$a","$b"]]],
		[['wolfram'],
			["function_call","StringSplit",["$a","$b"]]],
		[["php"],
			["function_call","explode",["$b","$a"]]]
	],matching_symbols)){
		var a_string = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var a_separator = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["c#"])){
			to_return = a_separator+".Split(new[] {"+a_string+"}, StringSplitOptions.None)";
		}
		else if(member(lang,["rebol"])){
			to_return = "split "+a_string+" "+a_separator;
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = ["String","[]"];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//get random from a (inclusive) to b (exclusive)
		[["python",'coconut'],[".",["random",["function_call","randrange",["$a","$b"]]]]],
		[["php"],["function_call","rand",["$a","$b"]]],
	],matching_symbols)){
		a = matching_symbols["$a"];
		b = matching_symbols["$b"];
		if(member(lang,["javascript"])){
			to_return = "(Math.random() * ("+b+" - "+a+") + "+a+")";
		}
		else if(member(lang,["lua"])){
			to_return = "math.random("+a+","+b+"-1)";
		}
		else if(member(lang,["ruby"])){
			to_return = "rand("+a+".."+b+")";
		}
		else if(member(lang,["perl"])){
			to_return = "(rand("+b+" - "+a+") + "+a+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//shuffle array without modifying original array
		[["ruby"],[".",["$a","shuffle"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//shuffle array in-place
		[["php"],["function_call","shuffle",["$a"]]],
		[["python",'coconut'],[".",["random",["function_call","shuffle",["$a"]]]]],
		[["haxe"],[".",["Random",["function_call","shuffle",["$a"]]]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//get random number between 0 and 1
		[["octave"],["function_call","random",["1"]]],
		[["java","javascript","coffeescript","typescript"],[".",["Math",["function_call","random",[]]]]],
		[["python",'coconut'],[".",["random",["function_call","random",[]]]]],
		[["ruby",'c','c++'],["function_call","rand",[]]],
		[["perl"],["function_call","rand",["1"]]],
		[["wolfram"],["function_call","RandomReal",[]]],
		[["tcl"],["function_call","rand",[]]]
	],matching_symbols)){
		if(member(lang,['c'])){
			to_return = "((double)rand() / (double)RAND_MAX)";
		}
		else if(member(lang,['php'])){
			to_return = "(float)mt_rand()/(float)mt_getrandmax()";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "double";
	}
	else if(arr[0] === "convert"){
		var type1 = arr[1];
		var type2 = arr[2];
		var expr = generate_code(input_lang,lang,indent,arr[3]);
		to_return = type_conversion(input_lang,lang,type1,type2, expr);
	}
	/*else if(input_lang === "javascript" && (arr[0] === "typeof")){
		var expr = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,["python"])){
			to_return = "type("+expr+")";
		}
		else if(member(lang,["php"])){
			to_return = "gettype("+expr+")";
		}
		else if(member(lang,["javascript"])){
			to_return = "(typeof "+expr+")";
		}
		types[to_return] = "String";
	}*/
	else if(input_lang === "javascript" && matches_pattern(arr,["==",["parentheses",["typeof","$a"]],"$b"],matching_symbols)){
		return generate_code(input_lang,lang,indent,["instanceof",matching_symbols["$a"],matching_symbols["$b"]])
	}
	else if(input_lang === "javascript" && matches_pattern(arr,["==",["typeof","$a"],"$b"],matching_symbols)){
		return generate_code(input_lang,lang,indent,["instanceof",matching_symbols["$a"],matching_symbols["$b"]])
	}
	else if(arr[0] === "instanceof"){
		var expr = generate_code(input_lang,lang,indent,arr[1]);
		var type = arr[2][1][0];
		types[expr] = type;
		if(member(lang,["python",'coconut'])){
			to_return = "type("+expr+") == "+var_type(input_lang,lang,type);
		}
		else if(member(lang,["ruby"])){
			to_return = "(" + expr+".is_a? "+var_type(input_lang,lang,type) + ")";
		}
		else if(member(lang,["rebol"])){
			to_return = var_type(input_lang,lang,type) + "? "+expr;
		}
		else if(member(lang,["lua"])){
			to_return = "type("+expr+") == \""+var_type(input_lang,lang,type)+"\"";
		}
		else if(member(lang,["julia"])){
			to_return = "isa("+expr+","+var_type(input_lang,lang,type)+")";
		}
		else if(member(lang,["javascript","typescript",'coffeescript'])){
			to_return = "typeof("+expr+") == \""+var_type(input_lang,lang,type)+"\"";
		}
		else if(member(lang,["haskell"])){
			to_return = "(typeOf "+expr+") =="+var_type(input_lang,lang,type)+"";
		}
		else if(member(lang,["c#","kotlin"])){
			to_return = "("+expr+" is "+var_type(input_lang,lang,type)+")";
		}
		else if(member(lang,["scala"])){
			to_return = "("+expr+" as? "+var_type(input_lang,lang,type)+")";
		}
		else if(member(lang,["java"])){
			to_return = expr+" instanceof "+var_type(input_lang,lang,type);
		}
		else if(member(lang,["scala"])){
			to_return = expr+".isInstanceOf["+var_type(input_lang,lang,type)+"]";
		}
		else if(type === "String"){
			if(member(lang,["php"])){
				to_return = "is_string("+expr+")";
			}
			else if(member(lang,["yacas"])){
				to_return = "IsString("+expr+")";
			}
			else if(member(lang,["prolog"])){
				to_return = "string("+expr+")";
			}
		}
		else if(type === "int"){
			if(member(lang,["perl"])){
				to_return = "Scalar::Util::looks_like_number("+expr+")";
			}
			else if(member(lang,["php"])){
				to_return = "is_int("+expr+")";
			}
		}
		else if(type === "boolean"){
			if(member(lang,["php"])){
				to_return = "is_boolean("+expr+")";
			}
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "ternary_operator"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		var c = generate_code(input_lang,lang,indent+"    ",arr[2]);
		if(member(lang,["java","vala","sidef","dart","tcl",'autohotkey',"javascript","typescript","c","c#","haxe","c++","perl","ruby","julia","awk","swift"])){
			to_return = a+"?"+b+":"+c;
		}
		else if(member(lang,["php"])){
			to_return = "("+a+"?"+b+":"+c+")";
		}
		else if(member(lang,["perl 6"])){
			to_return = "("+a+"??"+b+"!!"+c+")";
		}
		else if(member(lang,["algol 68"])){
			to_return = "("+a+"|"+b+"|"+c+")";
		}
		else if(member(lang,["coffeescript",'standard ml',"ada","coq","chapel","haskell","ada","mercury"])){
			to_return = "(if "+a+" then "+b+" else "+c+")";
		}
		else if(member(lang,["python",'coconut'])){
			to_return = "("+b+" if "+a+" else "+c+")";
		}
		else if(member(lang,["nim"])){
			to_return = "(if "+a+": " +b+ " else: "+c+")";
		}
		else if(member(lang,["rust"])){
			to_return = "(if "+a+"{"+b+"} else {"+c+"})";
		}
		else if(member(lang,["lua"])){
			to_return = "(("+a+") and ("+b+") or ("+c+"))";
		}
		else if(member(lang,["visual basic .net"])){
			to_return = "If("+a+","+b+","+c+")";
		}
		else if(member(lang,["octave"])){
			to_return = "ifelse("+a+","+b+","+c+")";
		}
		else if(member(lang,["coffeescript","kotlin","r"])){
			to_return = "(if ("+a+") "+b+" else "+c+")";
		}
		same_var_type(to_return,b);
	}
	else if(arr[0] === "unless"){
		var if_statement1 = generate_code(input_lang,lang,indent,arr[1]);
		var if_statement2 = generate_code(input_lang,lang,indent+"    ",arr[2]);
		if(lang === "perl"){
			to_return = "unless("+if_statement1+"){"+if_statement2+indent+"}";
		}
		else if(lang === "ruby"){
			to_return = "unless "+if_statement1+if_statement2+indent+"end";
		}
		else{
			to_return = generate_code(input_lang,lang,indent,["if",["!",["parentheses",arr[1]]],arr[2]]);
		}
	}
	else if(arr[0] === "if"){
		var if_statement1 = generate_code(input_lang,lang,indent,arr[1]);
		var if_statement2 = generate_code(input_lang,lang,indent+"    ",arr[2]);
		if(arr.length === 3){
			if(member(lang,['d','kotlin','e','php','perl','mathematical notation','chapel','pawn','ceylon','scala','typescript','autohotkey','awk','r','groovy','gosu','katahdin','java','swift','nemerle','c','dart','vala','javascript','c#','c++','haxe'])){
				to_return = "if(" + if_statement1 + "){" + if_statement2 +indent+ "}";
			}
			else if(member(lang,["rust","go"])){
				to_return = "if " + if_statement1 + " {" + if_statement2 +indent+ "}";
			}
			else if(member(lang,["algol 68"])){
				to_return = "if " + if_statement1 + "then " + if_statement2 +indent+ "fi";
			}
			else if(member(lang,["reverse polish notation"])){
				to_return = if_statement1 + " " + if_statement2 +indent+ " if";
			}
			else if(member(lang,["yacas"])){
				to_return = "If(" + if_statement1 + ",[" + if_statement2 +indent+ "]);";
			}
			else if(member(lang,["prolog"])){
				to_return = "(" + if_statement1 + "-> (" + if_statement2 + ")";
			}
			else if(member(lang,["tex"])){
				to_return = "(" + if_statement1 + " \\implies " + if_statement2 + ")";
			}
			else if(member(lang,["erlang"])){
				to_return = "if " + if_statement1 + " ->" + if_statement2 + indent + "end";
			}
			else if(member(lang,["sympy"])){
				to_return = "Piecewise(("+if_statement2+","+if_statement1+"))";
			}
			else if(member(lang,["rebol"])){
				to_return = "case [" +indent+""+ if_statement1 + "["+if_statement2+"]"+indent+ "]";
			}
			else if(lang === 'fortran'){
				to_return = "if("+if_statement1+") then "+if_statement2 + indent+ "end if";
			}
			else if(lang === 'minizinc'){
				to_return = "if "+if_statement1+" then "+if_statement2 + indent+ "endif";
			}
			else if(member(lang,['python','coconut'])){
				to_return = "if "+if_statement1+":"+if_statement2;
			}
			else if(member(lang,['coffeescript'])){
				to_return = "if "+if_statement1+if_statement2;
			}
			else if(lang === 'ocaml'){
				to_return = "(if "+if_statement1+" then "+if_statement2 + indent+ ")";
			}
			else if(member(lang,['ruby','lua','picat','gap'])){
				to_return = "if " + if_statement1 + " then "  + if_statement2 +indent+ "end";
			}
			else if(member(lang,['julia'])){
				to_return = "if " + if_statement1 + if_statement2 +indent+ "end";
			}
			else if(member(lang,['visual basic .net'])){
				to_return = "If " + if_statement1 + " Then "  + if_statement2 +indent+ "End If";
			}
			else if(member(lang,['forth'])){
				to_return = "begin " + if_statement1 + " if " + if_statement2 + indent+ "then";
			}
			else if(member(lang,['haskell','standard ml','elm','maxima'])){
				to_return = "(if " + if_statement1 + " then "  + if_statement2 + ")";
			}
			else if(member(lang,['smt-lib'])){
				to_return = "(=> " + if_statement1 + " "  + if_statement2 + ")";
			}
		}
		else{
			var elif_or_else = generate_code(input_lang,lang,indent,arr[3]);
			if(member(lang,['d','kotlin','e','php','perl','mathematical notation','chapel','pawn','ceylon','scala','typescript','autohotkey','awk','r','groovy','gosu','katahdin','java','swift','nemerle','c','dart','vala','javascript','c#','c++','haxe'])){
				to_return = "if(" + if_statement1 + "){" + if_statement2 +indent+ "}" + elif_or_else;
			}
			else if(member(lang,["rust","go"])){
				to_return = "if " + if_statement1 + " {" + if_statement2 +indent+ "}" + elif_or_else;
			}
			else if(member(lang,["algol 68"])){
				to_return = "if " + if_statement1 + "then " + if_statement2 + elif_or_else +indent+ "fi";
			}
			else if(member(lang,["prolog"])){
				to_return = "(" + if_statement1 + "-> (" + if_statement2 + ");" + elif_or_else+")";
			}
			else if(member(lang,["erlang"])){
				to_return = "if " + if_statement1 + " ->" + if_statement2 + ";" + elif_or_else+indent+"end";
			}
			else if(member(lang,["sympy"])){
				to_return = "Piecewise(("+if_statement2+","+if_statement1+"),"+elif_or_else+")";
			}
			else if(member(lang,["rebol"])){
				to_return = "case [" +indent+""+ if_statement1 + "["+if_statement2+"]"+ elif_or_else +indent+ "]";
			}
			else if(lang === 'fortran'){
				to_return = "if("+if_statement1+") then "+if_statement2 + " " + elif_or_else + indent+ "end if";
			}
			else if(lang === 'minizinc'){
				to_return = "if "+if_statement1+" then "+if_statement2 + " " + elif_or_else + indent+ "endif";
			}
			else if(member(lang,['python','coconut'])){
				to_return = "if "+if_statement1+":"+if_statement2 + elif_or_else;
			}
			else if(member(lang,['coffeescript'])){
				to_return = "if "+if_statement1+if_statement2 + elif_or_else;
			}
			else if(lang === 'ocaml'){
				to_return = "(if "+if_statement1+" then "+if_statement2 + " " + elif_or_else + indent+ ")";
			}
			else if(member(lang,['ruby','lua','picat','gap'])){
				to_return = "if " + if_statement1 + " then "  + if_statement2 + " " + elif_or_else +indent+ "end";
			}
			else if(member(lang,['julia'])){
				to_return = "if " + if_statement1 + if_statement2 + " " + elif_or_else +indent+ "end";
			}
			else if(member(lang,['visual basic .net'])){
				to_return = "If " + if_statement1 + " Then "  + if_statement2 + " " + elif_or_else +indent+ "End If";
			}
			else if(member(lang,['haskell','standard ml','elm','maxima'])){
				to_return = "(if " + if_statement1 + " then "  + if_statement2 + " " + elif_or_else + ")";
			}
			else if(member(lang,['smt-lib'])){
				to_return = "(ite " + if_statement1 + " "  + if_statement2 + " " + elif_or_else + ")";
			}
			else if(member(lang,['wolfram'])){
				to_return = "If[" + if_statement1 + ",(" + if_statement2 + "),(" + elif_or_else + ")]";
			}
			else if(member(lang,['yacas'])){
				to_return = "If(" + if_statement1 + ",[" + if_statement2 + "],[" + elif_or_else + "])";
			}
		}
	}
	else if(arr[0] === "else"){
		var statements1 = generate_code(input_lang,lang,indent+"    ",arr[1]);
		if(member(lang,['hack','kotlin','e','ooc','englishscript','mathematical notation','dafny','perl 6','frink','chapel','katahdin','pawn','powershell','puppet','ceylon','d','rust','typescript','scala','autohotkey','gosu','groovy','java','swift','dart','awk','javascript','haxe','php','c#','go','perl','c++','c','tcl','r','vala','bc'])){
			to_return = "else{"+statements1+indent+"}";
		}
		else if(member(lang,["prolog","smt-lib"])){
			to_return = statements1;
		}
		else if(member(lang,["wolfram"])){
			to_return = "("+statements1+")";
		}
		else if(member(lang,["sympy"])){
			to_return = "("+statements1+",True)";
		}
		else if(member(lang,["common lisp"])){
			to_return = "(t "+statements1+")";
		}
		else if(member(lang,["rebol"])){
			to_return = "true ["+statements1+indent+"]";
		}
		else if(member(lang,["erlang"])){
			to_return = "true ->"+statements1+indent;
		}
		else if(member(lang,['seed7','standard ml','elixir','gap','elm','coffeescript','fortran','vhdl','ruby','lua','livecode','janus','haskell','clips','minizinc','julia','octave','picat','pascal','delphi','maxima','ocaml','f#'])){
			to_return = "else " + statements1
		}
		else if(member(lang,"python",'coconut'))
			to_return = "else:"+statements1;
		else if(member(lang,['visual basic .net'])){
			to_return = "Else " + statements1
		}
	}
	else if(arr[0] === "switch"){
		var expr = generate_code(input_lang,lang,indent,arr[1]);
		var statements1 = arr[2].map(function(a){
			return generate_code(input_lang,lang,indent+"    ",a);
		});
		if(member(lang,["ocaml"])){
			statements1 = statements1.join(indent + "    |");
		}
		else{
			statements1 = statements1.join("");
		}
		
		if(member(lang,['java','d','powershell','nemerle','d','typescript','hack','swift','groovy','dart','awk','c#','javascript','c++','php','c','go','haxe','vala'])){
			to_return = "switch("+expr+"){"+statements1+indent+"}";
		}
		else if(member(lang,["tcl"])){
			to_return = "switch "+expr+"{"+statements1 +indent+ "}";
		}
		else if(member(lang,["octave"])){
			to_return = "switch("+expr+")"+statements1+indent+ "endswitch";
		}
		else if(member(lang,["ruby"])){
			to_return = "case "+expr+" "+statements1 +indent+ "end";
		}
		else if(member(lang,["forth"])){
			to_return = expr+" case"+statements1 +indent+ "endcase";
		}
		else if(member(lang,["coconut"])){
			to_return = "case "+expr+":"+statements1;
		}
		else if(member(lang,["coq"])){
			to_return = "match "+expr+" with "+statements1 + indent + "end";
		}
		else if(member(lang,["clips"])){
			to_return = "(switch "+expr+" "+statements1 +indent+ ")";
		}
		else if(member(lang,["clojure"])){
			to_return = "(case "+expr+" "+statements1 +indent+ ")";
		}
		else if(member(lang,["ruby"])){
			to_return = "coffeescript "+expr+" "+statements1;
		}
		else if(member(lang,["ocaml"])){
			to_return = "match "+expr+" with"+statements1;
		}
		else if(member(lang,["coffeescript"])){
			to_return = "switch "+expr+statements1;
		}
		else if(member(lang,["rust"])){
			to_return = "match "+expr+"{"+statements1+indent+"}";
		}
		else if(member(lang,["visual basic .net"])){
			to_return = "Select Case " + expr + statements1 + indent + "End Select";
		}
		else if(member(lang,["fortran"])){
			to_return = "select case " + expr + statements1 + indent + "end select";
		}
		else if(member(lang,["scala"])){
			to_return = expr+" match{"+statements1 +indent+ "}";
		}
		else if(member(lang,["rebol"])){
			to_return = "switch " +expr+ " ["+statements1 +indent+ "]";
		}
		else if(member(lang,["wolfram"])){
			to_return = "Switch ["+expr+statements1 +indent+ "]";
		}
		else if(member(lang,["perl 6"])){
			to_return = "given " +expr+ "{"+statements1 +indent+ "}";
		}
		else if(member(lang,["haskell","standard ml"])){
			to_return = "case "+expr+" of"+statements1;
		}
		else if(member(lang,["erlang"])){
			to_return = "case "+expr+" of"+statements1 +indent+ "end";
		}
	}
	else if(arr[0] === "case"){
		var expr = generate_code(input_lang,lang,indent+"",arr[1]);
		var statements1 = generate_code(input_lang,lang,indent+"    ",arr[2]);
		if(member(lang,['javascript','d','java','c#','c','c++','typescript','dart','php','hack'])){
			to_return = "case "+expr+": "+statements1+indent+"    break;";
		}
		else if(member(lang,['go','haxe','swift'])){
			to_return = "case "+expr+": "+statements1;
		}
		else if(member(lang,['forth'])){
			to_return = expr+" of "+statements1+"endof";
		}
		else if(member(lang,['visual basic .net'])){
			to_return = "Case "+expr+statements1;
		}
		else if(member(lang,['awk'])){
			to_return = "case "+expr+": "+statements1+indent+"    break";
		}
		else if(member(lang,['octave','fortran'])){
			to_return = "case "+expr+statements1;
		}
		else if(member(lang,['coffeescript'])){
			to_return = "when "+expr+" then"+statements1;
		}
		else if(member(lang,['ruby'])){
			to_return = "when "+expr+statements1;
		}
		else if(member(lang,['perl 6','chapel'])){
			to_return = "when "+expr+"{"+statements1+indent+"}";
		}
		else if(member(lang,['coconut'])){
			to_return = "match "+expr+":"+statements1;
		}
		else if(member(lang,['rebol'])){
			to_return = expr+" ["+statements1+"]";
		}
		else if(member(lang,['tcl'])){
			to_return = expr+" {"+statements1+indent+"}";
		}
		else if(member(lang,['clips'])){
			to_return = "(case "+expr+" then "+statements1+")";
		}
		else if(member(lang,['haskell','elixir','ocaml'])){
			to_return = expr+" ->"+statements1;
		}
		else if(member(lang,["erlang"])){
			to_return = expr + " ->"+statements1+";";
		}
		else if(member(lang,['scala','rust'])){
			to_return = expr+" =>"+statements1;
		}
		else if(member(lang,['standard ml'])){
			to_return = expr+" => "+statements1 + "|";
		}
		else if(member(lang,['coq'])){
			to_return = "|" + expr+" =>"+statements1;
		}
		else if(member(lang,['clojure'])){
			to_return = expr+" "+statements1;
		}
		else if(member(lang,['wolfram'])){
			to_return = ","+expr+","+statements1;
		}
	}
	else if(arr[0] === "default"){
		var statements1 = generate_code(input_lang,lang,indent+"    ",arr[1]);
		member(lang,['javascript','coconut','haxe','awk','swift','d','java','c#','c','c++','typescript','dart','go','php','hack'])
			&& (to_return = "default:" + statements1)
		|| member(lang,['haskell','erlang','ocaml','elixir'])
			&& (to_return = "_ ->" + statements1)
		|| member(lang,['wolfram'])
			&& (to_return = ";" + statements1)
		|| member(lang,['octave'])
			&& (to_return = "otherwise" + statements1)
		|| member(lang,['rust','scala'])
			&& (to_return = "_ =>" + statements1)
		|| member(lang,['tcl'])
			&& (to_return = "default {" + statements1 + indent + "}")
		|| member(lang,['visual basic .net'])
			&& (to_return = "Case Else" + statements1)
		|| member(lang,['clips'])
			&& (to_return = "(default " + statements1+")")
		|| member(lang,['fortran'])
			&& (to_return = "case default " + statements1)
		|| member(lang,['perl 6'])
			&& (to_return = "default{" + statements1+indent+"}")
		|| member(lang,['rebol'])
			&& (to_return = "][" + statements1)
		|| member(lang,['clojure'])
			&& (to_return = statements1)
		|| member(lang,['ruby','coffeescript','pascal','delphi'])
			&& (to_return = "else" + statements1);
	}
	else if(arr[0] === "defrule"){
		var name = arr[1];
		var condition = generate_code(input_lang,lang,indent,arr[2]);
		var body = generate_code(input_lang,lang,indent,arr[3]);
		
		member(lang,["constraint handling rules","prolog"])
			&& (to_return = name + " @ " + condition + " ==> " + body)
		|| member(lang,["clips"])
			&& (to_return = "(defrule " + name + " " + condition + " => (assert " + body + "))")
		|| member(lang,["pddl"])
			&& (to_return = "(:action " +name + " :parameters () :precondition " + condition + " :effect " + body + ")");
	}
	else if(arr[0] === "named_simplification_rule"){
		var name = arr[1];
		var condition = generate_code(input_lang,lang,indent,arr[2]);
		var body = generate_code(input_lang,lang,indent,arr[3]);
		
		if(member(lang,["constraint handling rules"])){
			to_return = name + " @ " + condition + " <=> " + body;
		}
	}
	else if(arr[0] === "unpack_array"){
		var name = arr[1];
		
		member(lang,["javascript","php"])
			&& (to_return = "..." + name)
		|| member(lang,["perl"])
			&& (to_return = ".." + name)
		|| member(lang,["python",'coconut',"ruby"])
			&& (to_return = "*" + name)
		|| member(lang,["common lisp"])
			&& (to_return = "(apply " + name + ")");
			
		same_var_type(to_return,arr[1]);
	}
	else if(arr[0] === "implies"){
		var condition = generate_code(input_lang,lang,indent,arr[1]);
		var body = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["chr.js","constraint handling rules"])){
			to_return = condition + " ==> " + body;
		}
		else if(member(lang,["prolog","minizinc","abella"])){
			to_return = condition + " -> " + body;
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "simplification_rule"){
		var condition = generate_code(input_lang,lang,indent,arr[1]);
		var body = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["chr.js","constraint handling rules","prolog"])){
			to_return = condition + " <=> " + body;
		}
	}
	else if(arr[0] === "propagation_rule"){
		var condition = generate_code(input_lang,lang,indent,arr[1]);
		var body = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["chr.js","constraint handling rules","prolog"])){
			to_return = condition + " ==> " + body;
		}
	}
	else if(arr[0] === "elif"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		var c;
		if(arr[3] === undefined){
			c = "";
		}
		else{
			c = generate_code(input_lang,lang,indent,arr[3]);
		}
		if(member(lang,['d','e','mathematical notation','chapel','pawn','ceylon','scala','typescript','autohotkey','awk','r','groovy','gosu','katahdin','java','swift','nemerle','c','dart','vala','javascript','c#','c++','haxe'])){
			to_return = "else if("+a+"){"+b+indent+"}"+c;
		}
		else if(member(lang,["rust","go"])){
			to_return = "else if "+a+" {"+b+indent+"}"+c;
		}
		else if(member(lang,["sympy"])){
			(c === "")
				&& (to_return = "("+b+","+a+")")
				|| (to_return = "("+b+","+a+"),"+c);
		}
		else if(member(lang,["erlang"])){
			(c === "")
				&& (to_return = a + " ->"+b)
				|| (to_return = a + " ->"+b+";"+ c);
		}
		else if(member(lang,['python','coconut','cython'])){
			to_return = "elif " + a + ":" + b + c;
		}
		else if(member(lang,['prolog'])){
			(c === "")
				&& (to_return = a + "-> (" + b + ")")
				|| (to_return = a + "-> (" + b + ");" + c);
		}
		else if(member(lang,['rebol'])){
			to_return = a + "["+b+"]"+c;
		}
		else if(member(lang,['coffeescript'])){
			to_return = "else if " + a + b + c;
		}
		else if(member(lang,['minizinc','picat','lua'])){
			to_return = "elseif "+a+" then "+b + " " + c;
		}
		else if(member(lang,['gap'])){
			to_return = "elif "+a+" then "+b + " " + c;
		}
		else if(member(lang,['julia'])){
			to_return = "elseif "+a+" "+b + " " + c;
		}
		else if(member(lang,['ocaml','haskell','standard ml','elm','pascal','maxima','delphi','f#','livecode'])){
			to_return = "else if "+a+" then "+b + " " + c;
		}
		else if(lang === 'fortran'){
			to_return = "else if("+a+") then "+b + " " + c;
		}
		else if(member(lang,["php","hack","perl"])){
			to_return = "elseif("+a+"){"+b+indent+"}"+c;
		}
		else if(member(lang,['ruby'])){
			to_return = "elsif " +a + " " + b+ " " + c;
		}
		else if(member(lang,['perl 6'])){
			to_return = "elsif " +a + "{" + b+ "}" + c;
		}
		else if(member(lang,['visual basic .net'])){
			to_return = "ElseIf " +a + " Then " + b + " " + c;
		}
		else if(member(lang,["wolfram"])){
			to_return = "If[" +a + ",(" + b + "),(" + c+")]";
		}
		else if(member(lang,["yacas"])){
			to_return = "If(" +a + ",[" + b + "],[" + c+"])";
		}
		else if(member(lang,['smt-lib'])){
			(c === "")
				&& (to_return = "(=> "+a+" "+b+")")
				|| (to_return = "(ite "+a+" "+b+" "+c+")");
		}
	}
	else if(arr[0] === "class_extends"){
		//return arr.toString();
		var access_modifier = arr[1];
		var name = arr[2];
		var name1 = arr[3];
		var body = generate_code(input_lang,lang,indent+"    ",arr[4]);
		
		member(lang,["java","c#"])
			&& (to_return = access_modifier + " class "+name+" extends "+name1+"{"+body+indent+"}")
		|| member(lang,["logtalk"])
			&& (to_return = "object("+name+", extends("+name1+"))."+indent+body+indent+":- end_object")
		|| member(lang,['haxe','php','javascript','dart','typescript'])
			&& (to_return = "class "+name+" extends "+name1+"{"+body+indent+"}")
		|| member(lang,['c++'])
			&& (to_return = "class "+name+": public "+name1+"{"+body+indent+"};")
		|| member(lang,['swift','chapel','d','swift'])
			&& (to_return = "class "+name+":"+name1+"{"+body+indent+"}")
		|| member(lang,['python','coconut'])
			&& (to_return = "class "+name+"("+name1+"):"+body)
		|| member(lang,['ruby'])
			&& (to_return = "class "+name+" << "+name1+" "+body+indent+"end");
	}
	else if(arr[0] === "class_implements"){
		//return arr.toString();
		var access_modifier = arr[1];
		var name = arr[2][1];
		var name1 = arr[3][1];
		var body = generate_code(input_lang,lang,indent,arr[4]);
		if(member(lang,["java","c#"])){
			to_return = access_modifier + " class "+name+" implements "+name1+"{"+body+"}";
		}
	}
	else if(arr[0] === "interface"){
		//return arr.toString();
		var access_modifier = arr[1];
		var name = arr[2][1];
		var body = generate_code(input_lang,lang,indent+"    ",arr[3]);
		
		member(lang,["java","c#"])
			&& (to_return = access_modifier + " interface "+name+"{"+body+indent+"}")
		|| member(lang,["c++"])
			&& (to_return = "class "+name+"{"+body+indent+"};")
		|| member(lang,["protobuf"])
			&& (to_return = "message "+name+"{"+body+indent+"}")
		|| member(lang,['swift','haxe','php'])
			&& (to_return = "interface "+name+"{"+body+indent+"}");
	}
	else if(arr[0] === "struct"){
		//return arr.toString();
		var name = arr[1];
		var body = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		if(member(lang,["c"])){
			to_return = "struct "+name+"{"+body+indent+"}";
		}
		else if(member(lang,["go"])){
			to_return = "type "+name+" struct{"+body+indent+"}";
		}
	}
	else if(arr[0] === "enum_statement"){
		//return arr.toString();
		if(member(lang,['java','seed7','vala','perl 6','swift','c++','c#','haxe','fortran','typescript','c','ada','scala'])){
			return arr[1];
		}
		else if(member(lang,"go")){
			return arr[1]+"=iota";
		}
	}
	else if(arr[0] === "enum"){
		//return arr.toString();
		var access_modifier = arr[1];
		var name = arr[2][1];
		var body = indent + "    " + arr[3].map(function(x){return generate_code(input_lang,lang,"",x)});

		if(member(lang,["java","c#"])){
			return access_modifier + " enum "+name+"{"+body+indent+"}";
		}
		else if(member(lang,["haxe"])){
			return "enum "+name+"{"+body+indent+"}";
		}
		else if(member(lang,["c++"])){
			return "enum "+name+"{"+body+indent+"};";
		}
	}
	else if(Array.isArray(arr[0])){
		return generate_code(input_lang,lang,indent,arr[0]);
	}
	else if(arr[0] === "class"){
		//return arr.toString();
		var access_modifier = arr[1];
		var name = arr[2];
		class_name = name;
		var body = generate_code(input_lang,lang,indent+"    ",arr[3]);
		
		member(lang,["java","c#"])
			&& (to_return = access_modifier + " class "+name+"{"+body+indent+"}")
		|| member(lang,["logtalk"])
			&& (to_return = "object("+name+")."+indent+body+indent+":- end_object")
		|| member(lang,["coffeescript"])
			&& (to_return = "class "+name+body)
		|| member(lang,["visual basic .net"])
			&& (to_return = access_modifier.charAt(0).toUpperCase() + access_modifier.slice(1) +" Class " + name + body+indent+"End Class")
		|| member(lang,['perl'])
			&& (to_return = "{package "+name+";"+body+indent+"}")
		|| member(lang,['c++'])
			&& (to_return = "class "+name+"{"+body+indent+"};")
		|| member(lang,['python','coconut'])
			&& (to_return = "class "+name+":"+body)
		|| member(lang,['ruby'])
			&& (to_return = "class "+name+" "+body+indent+"end")
		|| member(lang,['javascript','hack','php','scala','haxe','chapel','swift','d','typescript','dart','perl 6'])
			&& (to_return = "class "+name+"{"+body+indent+"}");
	}
	else if(arr[0] === "interface_static_method"){
		//return arr.toString();
		var type = arr[2];
		var name = arr[3][1];
		var params = parameters(input_lang,lang,arr[4]);
		var access_modifier = arr[1];
		types[name] = type;
		
		member(lang,['java','c#'])
			&& (to_return = access_modifier + " static " + var_type(input_lang,lang,type) + " " + name + "("+params+")"+";")
		|| member(lang,['c++'])
			&& (to_return = "static virtual " + var_type(input_lang,lang,type) + " " + name + "("+params+")"+"=0;")
		|| member(lang,['haxe'])
			&& (to_return = "static "+access_modifier+" function " + name + "("+params+"): "+var_type(input_lang,lang,type)+";")
		|| member(lang,['php'])
			&& (to_return = access_modifier + " static function " + name + "("+params+");");
	}
	else if(arr[0] === "interface_instance_method"){
		//return arr.toString();
		var type = arr[2];
		var name = arr[3][1];
		var params = parameters(input_lang,lang,arr[4]);
		var access_modifier = arr[1];
		types[name] = type;
		
		member(lang,['java','c#'])
			&& (to_return = access_modifier + " " + var_type(input_lang,lang,type) + " " + name + "("+params+")"+";")
		|| member(lang,['haxe'])
			&& (to_return = access_modifier + " function " + name + "("+params+"):"+var_type(input_lang,lang,type)+";")
		|| member(lang,['php'])
			&& (to_return = access_modifier + " function " + name + "("+params+");")
		|| member(lang,['c++'])
			&& (to_return = "virtual " + var_type(input_lang,lang,type) + " " + name + "("+params+")"+"=0;");
		types[to_return] = type;
	}
	//This overloading method is defined outside of a class
	else if(arr[0] === "overload_operator"){
		//return arr.toString();
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["swift"])){
			type = var_type(input_lang,lang,type);
			to_return = "func " + name + "("+params+") -> " +type+ "{"+body+indent+"}";
		}
	}
	else if(arr[0] === "static_overload_operator"){
		//return arr.toString();
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["c#"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier + " static " + type + " operator " + name + "("+params+"){"+body+indent+"}";
		}
	}
	else if(arr[0] === "instance_overload_operator"){
		//return arr.toString();
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["c++"])){
			to_return = type + " operator " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["ruby"])){
			to_return = "def " + name + "("+params+")"+body+indent+"end";
		}
		else if(member(lang,["python",'coconut'])){
			name==="+"
				&& (name1="add")
			|| name==="-"
				&& (name1="sub")
			|| name==="/"
				&& (name1="truediv")
			|| name==="*"
				&& (name1="mul")
			|| name==="!="
				&& (name1="ne")
			|| name==="=="
				&& (name1="eq")
			|| name===">="
				&& (name1="ge")
			|| name===">"
				&& (name1="gt")
			|| name==="<"
				&& (name1="lt")
			|| name==="%"
				&& (name1="mod")
			|| name==="<="
				&& (name1="le");
			to_return = "__"+name1+"__(self,"+params+"):"+body;
		}
	}
	else if(arr[0] === "static_method"){
		//return arr.toString();
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["java","c#"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier + " static " + type + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,['coffeescript'])){
			to_return ="@" + name + ": ("+params+") ->"+body;
		}
		else if(member(lang,['perl'])){
			to_return = "sub " + name + "{my ("+params+") = @_; "+body+indent+"}";
		}
		else if(member(lang,["visual basic .net"])){
			to_return = access_modifier.charAt(0).toUpperCase() + access_modifier.slice(1) + " Shared " + name + "("+params+")"+" As "+var_type(input_lang,lang,type)+body+indent+"End Function";
		}
		else if(member(lang,["python",'coconut'])){
			to_return = "@staticmethod"+indent+"def " + name + "("+params+"):"+body;
		}
		else if(member(lang,["c++","dart"])){
			to_return = "static " + var_type(input_lang,lang,type) + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["swift"])){
			to_return = ["class",ws_,"func",ws_,name,ws,"(",ws,params,ws,")",ws,"->",ws,var_type(input_lang,lang,type),ws,"{",ws,body,indent,"}"].join("");
		}
		else if(member(lang,["php"])){
			to_return = access_modifier + " static function " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["haxe"])){
			type = var_type(input_lang,lang,type);
			to_return = "static "+access_modifier+" function " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["typescript"])){
			to_return = "static " +  name + "(" + params + ")" +":" +var_type(input_lang,lang,type) + "{"+body+indent+"}";
		}
		else if(member(lang,["javascript"])){
			to_return = "static " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["ruby"])){
			to_return = "def self." + name + "("+params+") "+body+indent+"end";
		}
	}
	else if(arr[0] === "constructor"){
		//return JSON.stringify(arr);
		var access_modifier = arr[1];
		var name = arr[2];
		var params = parameters(input_lang,lang,arr[3]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[4]);
		if(member(lang,["java","c#","vala"])){
			to_return = "public " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["c++","dart"])){
			to_return = name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["python",'coconut'])){
			to_return = "def " + "__init__" + "(self,"+params+"):"+body;
		}
		else if(member(lang,["perl"])){
			to_return = "sub new {"
			+indent+"    my($class,"+params+") = @_;"
			+indent+"    my $self = {};"
			+indent+"    bless $self, $class;"
			+body
			+indent+"    return $self;"
			+indent+"}";
		}
		else if(member(lang,["javascript"])){
			to_return = "constructor("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["haxe"])){
			to_return = "public function new("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["swift"])){
			to_return = "init("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["ruby"])){
			to_return = "def initialize("+params+") "+body+indent+"end";
		}
		else if(member(lang,["php"])){
			to_return = "function __construct("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["gosu"])){
			to_return = "construct("+params+"){"+body+indent+"}";
		}
	}
	else if(arr[0] === "instance_method"){
		types[arr[3]] = arr[2];
		arr[4] = parameters(input_lang,lang,arr[4]);
		arr[5] = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		var type = arr[2];
		var name = arr[3];
		var params = arr[4];
		var body = arr[5];
		if(member(lang,["java","c#"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier + " " + type + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["logtalk"])){
			to_return = name+"("+params+") :- "+body+".";
		}
		else if(member(lang,["perl 6"])){
			to_return = "method " + name+"("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["lc++"])){
			to_return = name+"("+params+") -= "+body;
		}
		else if(member(lang,["c++"])){
			type = var_type(input_lang,lang,type);
			to_return = type + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["scala"])){
			type = var_type(input_lang,lang,type);
			to_return = "def " + name + "("+params+"):"+type+" = {"+body+indent+"}";
		}
		else if(member(lang,['coffeescript'])){
			to_return =name + ": ("+params+") ->"+body;
		}
		else if(member(lang,['perl'])){
			to_return = "sub " + name + "{my ("+params+") = @_; "+body+indent+"}";
		}
		else if(member(lang,["visual basic .net"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier.charAt(0).toUpperCase() + access_modifier.slice(1) + " " + name + "("+params+")"+" As "+type+body+indent+"End Function";
		}
		else if(member(lang,['python','coconut'])){
			to_return = "def " + name + "(self,"+params+"):"+body;
		}
		else if(member(lang,['swift'])){
			type = var_type(input_lang,lang,type);
			to_return = "func " + name + "("+params+")->"+type+"{"+body+indent+"}";
		}
		else if(member(lang,["haxe"])){
			to_return = access_modifier + " function " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["typescript"])){
			type = var_type(input_lang,lang,type);
			to_return = name + "("+params+")"+":" +type+"{"+body+indent+"}";
		}
		else if(member(lang,["javascript"])){
			to_return = name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,"php")){
			to_return = access_modifier + " function " +name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["ruby"])){
			to_return = "def " + name + "("+params+") "+body+indent+"end";
		}
	}
	else if(arr[0] === "access_dict"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["java"])){
			to_return = a+".get("+b+")";
		}
		else if(member(lang,['javascript','c++','c#','haxe','typescript','python','coconut','php','lua','ruby','swift'])){
			to_return = a+"["+b+"]";
		}
		else if(member(lang,['scala','visual basic .net'])){
			to_return = a+"("+b+")";
		}
		else if(member(lang,['perl'])){
			to_return = a+"{"+b+"}";
		}
		else if(member(lang,['haskell'])){
			to_return = "("+a+" !! "+b+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		if(to_return !== undefined){
			console.log("type of dict: " + types[a]);
			if(types[arr[1]][0] === "HashMap")
			same_var_type(to_return,arr[1][2]);
			return to_return;
		}
	}
	else if(arr[0] === "access_array"){
		var name = generate_code(input_lang,lang,indent,arr[1]);
		//if(input_lang === "javascript")
		//alert(types[name]);
		
		if(types[name][0] === "dict"){
			//alert("dict");
			return generate_code(input_lang,lang,indent,["access_dict",arr[1],arr[2]]);
		}
		
		var params = access_array_parameters(input_lang,lang,arr[2]);
		if(member(lang,['ruby','yacas','python','coconut','c#','julia','d','swift','julia','janus','minizinc','picat','nim','autoit','python_temp','cython','coffeescript','dart','typescript','awk','vala','perl','javascript','go','c++','php','haxe','c'])){
			to_return = name + "["+params+"]";
		}
		else if(member(lang,['java'])){
			to_return = name + ".get("+params+")";
		}
		else if(member(lang,['lua'])){
			to_return = name + "["+params+"+ 1]";
		}
		else if(member(lang,['wolfram'])){
			to_return = name + "[["+params+"]]";
		}
		else if(member(lang,['haskell'])){
			to_return = "(" + name + " !! "+params+")";
		}
		else if(member(lang,['smt-lib','smt-lib'])){
			to_return = "(select " + name + " "+params+" )";
		}
		else if(member(lang,['smt-lib'])){
			to_return = name + "(select "+name+" "+params+")";
		}
		else if(member(lang,['scala','visual basic .net'])){
			to_return = name + "("+params+")";
		}
		if(types[arr[1]] !== undefined){
			types[to_return] = types[arr[1]][0];
		}
	}
	else if(arr[0] === "anonymous_function"){
		//return arr.toString();
		var type = arr[1];
		function_name = name;
		var params = parameters(input_lang,lang,arr[2]);
		var body;
		
		//lambdas should contain only one return statement
		
		member(lang,['python','coconut'])
			&& (body = generate_code(input_lang,lang,indent+"    ",arr[3][1][0][1][1]))
		||
			(body = generate_code(input_lang,lang,indent+"    ",arr[3]));
		
		types[name] = type;
		
		member(lang,['javascript','typescript','haxe','r','php'])
			&& (to_return = "function("+params+"){"+body+indent+"}")
		|| member(lang,['python','coconut'])
			&& (to_return = "lambda "+params+":"+body)
		|| member(lang,["c++"])
			&& (to_return = "[](" + params + ") -> " + var_type(input_lang,lang,type) + "{"+body+indent+"}")
		|| member(lang,["lua","julia"])
			&& (to_return = "function("+params+")"+body+indent+"end")
		|| member(lang,["erlang"])
			&& (to_return = "fun("+params+")"+body+indent+"end")
		|| member(lang,["octave"])
			&& (to_return = "(@("+params+") "+body+indent+")")
		|| member(lang,["perl"])
			&& (to_return = "sub{"+params+body+indent+"}")
		|| member(lang,["wolfram"])
			&& (to_return = "Function[{"+params+"},"+body+","+indent+"]")
		|| member(lang,["rust"])
			&& (to_return = "fn("+params+"){"+body+indent+"}")
		|| member(lang,["ocaml"])
			&& (to_return = "(fun("+params+") -> "+body+indent+")")
		|| member(lang,["standard ml"])
			&& (to_return = "(fn("+params+") => "+body+indent+")")
		|| member(lang,["haskell"])
			&& (to_return = "(\\"+params+" -> "+body+")")
		|| member(lang,["rebol"])
			&& (to_return = "func["+params+"]["+body+indent+"]")
		|| member(lang,["emacs lisp","scheme","clojure"])
			&& (to_return = "(lambda ("+params+") "+body+")")
		|| member(lang,["java"])
			&& (to_return = "("+params+") -> {"+body+indent+"}")
		|| member(lang,["scala"])
			&& (to_return = "("+params+") => {"+body+indent+"}");
		types[to_return] = type;
	}
	else if(arr[0] === "grammar_statement"){
		var name = arr[1];
		var body = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,['jison','antlr','lark'])
			&& (to_return = name+":"+body+";")
		|| member(lang,['pypeg'])
			&& (to_return = "def "+name+"():"+indent+"    return "+body)
		|| member(lang,['rebol'])
			&& (to_return = name+": ["+body+"]")
		|| member(lang,['perl 6'])
			&& (to_return = "rule "+name+"{"+body+"}")
		|| member(lang,['peg.js','lpeg','abnf'])
			&& (to_return = name+" = "+body)
		|| member(lang,['coco/r'])
			&& (to_return = name+": "+body+".")
		|| member(lang,['prolog'])
			&& (to_return = name+"-->"+body)
		|| member(lang,['waxeye','canopy'])
			&& (to_return = name+"<-"+body)
		|| member(lang,['marpa'])
			&& (to_return = name+"::="+body)
		|| member(lang,['nearley'])
			&& (to_return = name+"->"+body)
		|| member(lang,['perl 6'])
			&& (to_return = "rule " + name+"{"+body+"}");
	}
	else if(arr[0] === "grammar_macro"){
		var name = arr[1];
		var params = arr[2].join(",");
		var body = generate_code(input_lang,lang,indent+"    ",arr[3]);
		
		member(lang,['prolog'])
			&& (to_return = name+"("+params+") -->"+body)
		|| member(lang,['nearley'])
			&& (to_return = name+"["+params+"] ->"+body)
		|| member(lang,['peg.js'])
			&& (to_return = name+" = "+body+" {return [\""+name+"\","+params+"];}");
	}
	else if(arr[0] === "grammar_var"){
		member(lang,["perl 6"])
			&& (to_return = "<"+arr[1]+">")
		|| member(lang,["lpeg"])
			&& (to_return = "lpeg.V\""+arr[1]+"\"")
		|| (to_return = arr[1]);
	}
	else if(arr[0] === "logic_or"){
		if(member(lang,['nearley','abnf','peg.js','antlr','marpa','wirth syntax notation','jison'])){
			to_return = generate_code(input_lang,lang,indent,["grammar_or",arr[1],arr[2]]);
		}
		
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,['prolog'])
			&& (to_return = a+"|"+b)
		|| member(lang,['sympy'])
			&& (to_return = a+" or "+b)
		|| member(lang,['minizinc','abella'])
			&& (to_return = a+" \\/ "+b)
		|| member(lang,['javascript'])
			&& (to_return = "logic.or("+a+","+b+")")
		|| member(lang,['smt-lib'])
			&& (to_return = "(or "+a+" "+b+")");
		types[to_return] = "grammar";
	}
	else if(arr[0] === "logic_and"){
		if(member(lang,['nearley','abnf','peg.js','antlr','marpa','wirth syntax notation','jison'])){
			to_return = generate_code(input_lang,lang,indent,["grammar_and",arr[1],arr[2]]);
		}
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,['prolog'])
			&& (to_return = a+","+b)
		|| member(lang,['sympy'])
			&& (to_return = a+" and "+b)
		|| member(lang,['javascript'])
			&& (to_return = "logic.and("+a+","+b+")")
		|| member(lang,['smt-lib','clips'])
			&& (to_return = "(and "+a+" "+b+")");
		
		types[to_return] = "boolean";
	}
	else if(arr[0] === "logic_equals"){
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,['prolog'])
			&& (to_return = a+"="+b)
		|| member(lang,['sympy'])
			&& (to_return = "Eq("+a+","+b+")")
		|| member(lang,['python','coconut'])
			&& (to_return = "sympy.Eq("+a+","+b+")")
		|| member(lang,['javascript'])
			&& (to_return = "logic.eq("+a+","+b+")")
		|| member(lang,['minizinc'])
			&& (to_return = a+"=="+b)
		|| member(lang,['smt-lib','clips'])
			&& (to_return = "(= "+a+" "+b+")");
		types[to_return] = "grammar";
	}
	else if(arr[0] === "grammar_or"){
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,['marpa','lark','coco/r','wirth syntax notation','rebol','yapps','antlr','jison','waxeye','ometa','ebnf','nearley','parslet','yacc','perl 6','rebol','hampi','earley-parser-js'])
			&& (to_return = a+"|"+b)
		|| member(lang,['prolog'])
			&& (to_return = a+";"+b)
		|| member(lang,['pypeg'])
			&& (to_return = "["+a+","+b+"]")
		|| member(lang,['peg.js','abnf','treetop','canopy'])
			&& (to_return = a+"/"+b)
		|| member(lang,['lpeg'])
			&& (to_return = a+" + "+b);
		types[to_return] = "grammar";
	}
	else if(arr[0] === "grammar_and"){
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,['nearley','perl 6','canopy','coco/r','abnf','peg.js','antlr','marpa','wirth syntax notation','jison'])
			&& (to_return = a+" "+b)
		|| member(lang,['prolog'])
			&& (to_return = a+","+b)
		|| member(lang,['pypeg'])
			&& (to_return = "("+a+","+b+")")
		|| member(lang,['lpeg'])
			&& (to_return = a+" * "+b);
			
		types[to_return] = "grammar";
	}
	else if(arr[0] === "predicate"){
		if(member(lang,["clips"])){
			return generate_code(input_lang,lang,indent,["defrule",arr[1],["function_call",arr[1],arr[2]],arr[3]]);
		}
		
		var name = arr[1];
		var params = parameters(input_lang,lang,arr[2]);
		var body = generate_code(input_lang,lang,"",arr[3]);
		
		member(lang,["pddl"])
			&& (to_return = "(:action " +name + " :parameters ("+params+") :precondition " + body + " :effect (" +name+" " + params + "))")
		|| member(lang,["prolog","logtalk"])
			&& (to_return = name+"("+params+") :- "+body)
		|| member(lang,["constraint handling rules"])
			&& (to_return = name+"("+params+") :- "+body)
		|| member(lang,["sympy"])
			&& (to_return = "def("+params+"):"+"\n    return "+body)
		|| member(lang,["javascript"])
			&& (to_return = "function("+params+"){"+body+"}")
		|| member(lang,["pydatalog"])
			&& (to_return = name + "[" + params + "]" + "<=" + body);
	}
	else if(arr[0] === "async_function"){
		//return arr.toString();
		var access_modifier = arr[1];
		var type = arr[2];
		var name = arr[3];
		function_name = name;
		var params = parameters(input_lang,lang,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		set_var_type(input_lang,lang,name,type);
		
		member(lang,["c#"])
			&& (to_return = access_modifier + " static async " + var_type(input_lang,lang,type) + " " + name + "("+params+"){"+body+indent+"}")
		|| member(lang,["javascript"])
			&& (to_return = "async function "+name+"("+params+"){"+body+"}")
		|| member(lang,["python",'coconut'])
			&& (to_return = "async def "+name+"("+params+"):"+body);
	}
	else if(arr[0] === "haskell_function"){
		//return arr.toString();
		if(!member(lang,["javascript","scala"])){
			arr[0] = "function";
			return generate_code(input_lang,lang,indent,arr);
		}
		else{
			var access_modifier = arr[1];
			var type = arr[2];
			var name = arr[3];
			set_var_type(input_lang,lang,name,type);
			function_name = name;
			var params = parameters(input_lang,lang,arr[4]);
			var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		}
	}
	else if(arr[0] === "macro"){
		//return arr.toString();
		var name = arr[1];
		var params = parameters(input_lang,lang,arr[2]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[3]);
		if(member(lang,["c"])){
			to_return = "#define " + name + "("+params+") ("+body+")";
		}
	}
	else if(arr[0] === "function"){
		//return arr.toString();
		var access_modifier = arr[1];
		var type = arr[2];
		var name = arr[3];
		set_var_type(input_lang,lang,name,type);
		function_name = name;
		var params = parameters(input_lang,lang,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		if(member(lang,["java","c#"])){
			to_return = access_modifier + " static " + var_type(input_lang,lang,type) + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["pddl"])){
			to_return = "(:action " +name + " :parameters ("+params+") :precondition " + body + " :effect (" +name+" " + params + "))";
		}
		else if(member(lang,["algol 68"])){
			to_return = "PROC "+name+" = (" + params + ") " +var_type(input_lang,lang,type)+ ": (" + body +indent+ ")";
		}
		else if(member(lang,["clojure"])){
			to_return = "(defn "+name+"["+params+"] "+body+")";
		}
		else if(member(lang,["standard ml"])){
			to_return = "fun "+name+"("+params+") = "+body;
		}
		else if(member(lang,["reverse polish notation"])){
			to_return = "("+params+") "+name+" "+body+" =";
		}
		else if(member(lang,["coq"])){
			to_return = "Fixpoint "+name+" "+params+":"+var_type(input_lang,lang,type)+" := "+body;
		}
		else if(member(lang,["pydatalog"])){
			to_return = name+"["+params+"] = "+body;
		}
		else if(member(lang,["constraint handling rules","chr.js"])){
			to_return = name+"("+params+") ==> " + body;
		}
		else if(member(lang,["elixir"])){
			to_return = name+" = fun("+params+") = "+body+indent+"end";
		}
		else if(member(lang,["tcl"])){
			to_return = "proc "+name+" {"+params+"} {"+body+indent+"}";
		}
		else if(member(lang,["clips"])){
			to_return = "(deffunction "+name+"("+params+") "+body+")";
		}
		else if(member(lang,["haxe"])){
			if(type === "Object"){
				to_return = access_modifier+" function " + name + "("+params+"){"+body+indent+"}";
			}
			else{
				type = var_type(input_lang,lang,type);
				to_return = access_modifier+" function " + name + "("+params+"):"+type+"{"+body+indent+"}";
			}
		}
		else if(member(lang,["gosu"])){
			if(type === "Object"){
				to_return = "function " + name + "("+params+"){"+body+indent+"}";
			}
			else{
				type = var_type(input_lang,lang,type);
				to_return = "function " + name + "("+params+"):"+type+"{"+body+indent+"}";
			}
		}
		else if(member(lang,["kotlin"])){
			type = var_type(input_lang,lang,type);
			to_return = "fun " + name + "("+params+"):"+type+"{"+body+indent+"}";
		}
		else if(member(lang,["standard ml"])){
			type = var_type(input_lang,lang,type);
			to_return = "fun " + name + "("+params+"):"+type+"{"+body+indent+"}";
		}
		else if(member(lang,["common lisp","emacs lisp"])){
			to_return = "(defun " + name + "("+params+")"+body+indent+")";
		}
		else if(member(lang,["racket"])){
			to_return = "(defun " + name + "("+params+")"+body+indent+")";
		}
		else if(member(lang,["wolfram"])){
			to_return = name + "["+params+"] := ("+body+indent+")";
		}
		else if(member(lang,["yacas"])){
			to_return = name + "("+params+") := ("+body+indent+")";
		}
		else if(member(lang,["mathematical notation"])){
			to_return = name + "("+params+") = {"+body+indent+"}";
		}
		else if(member(lang,["maxima"])){
			to_return = name + "("+params+") := block([],"+body+indent+")";
		}
		else if(member(lang,["picat"])){
			to_return = name+"("+params+") = Return =>"+body;
		}
		else if(member(lang,["prolog"])){
			to_return =  name + "("+params+") :- "+body;
		}
		else if(member(lang,["lc++"])){
			to_return = "lassert("+name + "("+params+") -= "+body+")";
		}
		else if(member(lang,["rebol"])){
			to_return = name + ": func" + "["+params+"]["+body+indent+"]";
		}
		else if(member(lang,["coffeescript"])){
			to_return = name + " = ("+params+") ->"+body;
		}
		else if(member(lang,["r"])){
			to_return = name + " <- ("+params+"){"+body+indent+"}";
		}
		else if(lang === "fortran"){
			var words_list = arr[4].map(function(x){return x[1]}).join(", ");
			to_return = var_type(input_lang,lang,type) + " function " + name + "("+words_list+") "+params+" "+body+" return end";
		}
		else if(member(lang,['visual basic','visual basic .net'])){
			to_return = "Function " + name + "("+params+") As "+var_type(input_lang,lang,type)+" "+body+indent+"End Function";
		}
		else if(member(lang,["minizinc"])){
			to_return = "function var " + var_type(input_lang,lang,type) + ":" + name + "("+params+") = "+body;
		}
		else if(member(lang,["erlang"])){
			to_return = name + "(" + params + ") -> " + body;
		}
		else if(member(lang,["perl"])){
			to_return = "sub " + name + "{my ("+params+") = @_; "+body+indent+"}";
		}
		else if(member(lang,["perl 6"])){
			to_return = "sub " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["swift"])){
			to_return = "func " + name + "("+params+") -> "+var_type(input_lang,lang,type)+"{"+body+indent+"}";
		}
		else if(member(lang,["smt-lib"])){
			var words_list = arr[4].map(function(x){return x[1]}).join(" ");
			to_return = "(declare-fun " + name + "("+params+") "+var_type(input_lang,lang,type)+")"+" (assert (forall ("+params+") (= (" + name + " " + words_list + ") "+body+")))";
		}
		else if(member(lang,["rust"])){
			to_return = "fn " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["go"])){
			to_return = "func " + name + "("+params+") "+var_type(input_lang,lang,type)+"{"+body+indent+"}";
		}
		else if(member(lang,["sidef"])){
			to_return = "func " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,['c++','glsl','vala','c','dart','ceylon','pike','d'])){
			to_return = var_type(input_lang,lang,type) + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,['ada'])){
			to_return = "function " + name + "("+params+") return " +var_type(input_lang,lang,type)+ " is begin "+body+indent+"end "+name+";";
		}
		else if(member(lang,["javascript","logicjs","php","reasoned-php","awk"])){
			to_return = "function " + name + "("+params+")"+body+indent+"}";
		}
		else if(member(lang,["bc"])){
			to_return = "define " + name + "("+params+")"+body+indent+"}";
		}
		else if(member(lang,["python",'coconut',"cython","z3py"])){
			to_return = "def " + name + "("+params+"):"+body;
		}
		else if(member(lang,["nim"])){
			to_return = "proc " + name + "("+params+"): "+var_type(input_lang,lang,type)+" ="+body;
		}
		else if(member(lang,["sympy"])){
			to_return = "def " + name + "("+params+"):"+"\n    return ("+body+")";
		}
		else if(member(lang,["typescript"])){
			if(type === "Object"){
				to_return = "function " + name + "("+params+"){"+body+indent+"}";
			}
			else{
				to_return = "function " + name + "("+params+"):"+var_type(input_lang,lang,type)+"{"+body+indent+"}";
			}
		}
		else if(member(lang,["delphi"])){
			to_return = "function " + name + "("+params+"):"+var_type(input_lang,lang,type)+"; begin"+body+indent+"end;";
		}
		else if(member(lang,["haskell"])){
			var types_list = arr[4].map(function(x) {
				return var_type(input_lang,lang,x[0]);
			});
			to_return = name + "::" + types_list.join(" -> ") + " -> " + var_type(input_lang,lang,type) + indent + name + " " + params+" = "+body;
		}
		else if(member(lang,["agda"])){
			var types_list = arr[4].map(function(x) {
				return var_type(input_lang,lang,x[0]);
			});
			to_return = name + ":" + types_list.join("  ") + " -> " + var_type(input_lang,lang,type) + indent + name + " " + params+" = "+body;
		}
		else if(member(lang,["mercury"])){
			var types_list = arr[4].map(function(x) {
				return var_type(input_lang,lang,x[0]);
			});
			to_return = ":- func " + name + "(" + types_list.join(",") + ") = " + var_type(input_lang,lang,type) + "." + indent + name + "(" + params+") = "+body;
		}
		else if(member(lang,["idris"])){
			var types_list = arr[4].map(function(x) {
				return var_type(input_lang,lang,x[0]);
			});
			to_return = name + ":" + types_list.join(" -> ") + " -> " + var_type(input_lang,lang,type) + indent + name + " " + params+" = "+body;
		}
		else if(member(lang,["elm"])){
			var types_list = arr[4].map(function(x) {
				return var_type(input_lang,lang,x[0]);
			});
			to_return = name + ":" + types_list.join(" -> ") + " -> " + var_type(input_lang,lang,type) + indent + name + " " + params+" = "+body;
		}
		else if(member(lang,["ocaml"])){
			to_return = "let "  + name + " " + params+" = "+body;
		}
		else if(member(lang,["lua","julia"])){
			to_return = "function " + name + "("+params+") "+body+indent+"end";
		}
		else if(member(lang,["octave"])){
			to_return = "function " + name + "("+params+") "+body+indent+"endfunction";
		}
		else if(member(lang,["autoit"])){
			to_return = "Func " + name + "("+params+") "+body+indent+"EndFunc";
		}
		else if(member(lang,["applescript"])){
			to_return = "on " + name + "("+params+") "+body+indent+"end";
		}
		else if(member(lang,["gap"])){
			to_return = name + " := function("+params+") "+body+indent+"end;";
		}
		else if(member(lang,["scala"])){
			to_return = "def " + name + "("+params+"):"+ var_type(input_lang,lang,type) + " = {" +body + indent + "}";
		}
		else if(member(lang,["ruby"])){
			to_return = "def " + name + "("+params+") "+body+indent+"end";
		}
	}
	else if(arr[0] === "member_variable"){
		var access_modifier = arr[1];
		var name = generate_code(input_lang,lang,indent,arr[2]);
		var expr = generate_code(input_lang,lang,indent,arr[3]);
		//console.log("initialize_var: "+ name + " "+arr[1]);
		set_var_type(input_lang,lang,name,arr[2]);
		if(member(lang, ["java","c#"])){
			to_return = access_modifier + " " + var_type(input_lang,lang,types[name]) + " " + name + "=" + expr;
		}
		if(member(lang, ["php"])){
			to_return = access_modifier + " " + name + "=" + expr;
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[[["java"],[".",["this","$a"]]]],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,['java','engscript','dart','groovy','typescript','javascript','c#','c++','haxe','chapel','julia'])){
			to_return = "this."+a;
		}
		else if(member(lang,['php','hack'])){
			to_return = "$this->"+a;
		}
		else if(member(lang,['perl'])){
			to_return = "$self->"+a;
		}
		else if(member(lang,['coffeescript','ruby'])){
			to_return = "@"+a;
		}
		else if(member(lang,['python','coconut'])){
			to_return = "self."+a;
		}
		set_var_type(input_lang,lang,to_return,a);
	}
	else if(arr[0] === "for"){
		var initial = generate_code(input_lang,lang,"",arr[1]);
		var condition = generate_code(input_lang,lang,"",arr[2]);
		var update = generate_code(input_lang,lang,"",arr[3]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[4]);
		if(member(lang,['java','glsl','c++','d','pawn','groovy','javascript','dart','typescript','php','hack','c#','perl','c++','awk','pike'])){
			to_return = "for("+initial+";"+condition+";"+update+"){"+body+indent+"}";
		}
		else if(member(lang,['go'])){
			to_return = "for "+initial+";"+condition+";"+update+"{"+body+indent+"}";
		}
		else if(member(lang,['tcl'])){
			to_return = "for {"+initial+"} {"+condition+"} {"+update+"} {"+body+indent+"}";
		}
		else if(member(lang,["yacas"])){
			to_return = "For("+initial+","+condition+","+update+")["+body+indent+"];";
		}
		else if(member(lang,['wolfram'])){
			to_return = "For["+initial+","+condition+","+update+", "+body+indent+"]";
		}
		
		//for languages that have while-loops but not for-loops
		else if(member(lang,['haxe','rebol','picat','julia','python','coconut','kotlin','lua','ruby','scala','swift','visual basic .net'])){
			to_return = indent+semicolon(lang,initial) +indent+ while_loop(lang,condition, indent+"    "+semicolon(lang,update)+body,indent);
		}
		else if(member(lang,['picat'])){
			to_return = indent+semicolon(lang,initial)+indent+ while_loop(lang,condition, indent+"    "+semicolon(lang,update)+body,indent);
		}
	}
	else if(arr[0] === "array_length"){
		var array = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,['javascript','java'])){
			to_return = array+".length";
		}
		else if(member(lang,'python','coconut')){
			to_return = "len("+array+")";
		}
	}
	else if(arr[0] === "empty_member_variable"){
		var access_modifier = arr[1];
		var name = generate_code(input_lang,lang,indent,arr[3]);
		types[name] = arr[2];
		if(member(lang, ["java","c#"])){
			to_return = access_modifier + " " + var_type(input_lang,lang,types[name]) + " " + name;
		}
		else if(member(lang,['haxe','nim'])){
			if(type === "Object"){
				to_return = "var "+name;
			}
			else{
				to_return = "var "+name+":"+var_type(input_lang,lang,types[name]);
			}
		}
		else if(member(lang,['php'])){
			to_return = access_modifier + " "+name;
		}
		else if(member(lang,['c++'])){
			to_return = var_type(input_lang,lang,types[name]) + " " + name;
		}
		else if(member(lang,['ruby','python','coconut','javascript'])){
			return "";
		}
	}
	else if(arr[0] === "initialize_constant"){
		//console.log(JSON.stringify(arr));
		var name = var_name(lang,arr[2]);
		var expr = generate_code(input_lang,lang,indent,arr[3]);
		//console.log("initialize_var: "+ name + " "+arr[1]);
		types[name] = arr[1];
		
		if(member(lang, ['erlang','mathematical notation','haskell','prolog','logtalk','minizinc','reverse polish notation'])){
			// for all declarative programming languages
			return generate_code(input_lang,lang,indent,["initialize_var",arr[1],arr[2],arr[3]]);
		}
		else if(member(lang, ["java"])){
			to_return = "final " + var_type(input_lang,lang,arr[1]) + " " + name + "=" + expr;
		}
		else if(member(lang, ['c++','glsl','c','d','c#'])){
			to_return = "const " + var_type(input_lang,lang,arr[1]) + " " + name + "=" + expr;
		}
		else if(member(lang, ['perl 6'])){
			to_return = "constant " + var_type(input_lang,lang,arr[1]) + " " + name + "=" + expr;
		}
		else if(member(lang, ['php','javascript','dart','julia'])){
			to_return = "const " + name + "=" + expr;
		}
		else if(member(lang, ['rust'])){
			to_return = "let " + name + "=" + expr;
		}
		else if(member(lang, ["typescript","chapel"])){
			to_return = "const " + name + ":" + var_type(input_lang,lang,arr[1]) + "=" + expr;
		}
		else if(member(lang,['swift','nim'])){
			if(var_type(input_lang,"java",arr[1]) === "Object"){
				to_return = "let "+name+"="+expr;
			}
			else{
				to_return = "let "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
			}
		}
		else if(member(lang,['scala','kotlin'])){
			if(var_type(input_lang,"java",arr[1]) === "Object"){
				to_return = "val "+name+"="+expr;
			}
			else{
				to_return = "val "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
			}
		}
	}
	else if(arr[0] === "initialize_var"){
		//console.log(JSON.stringify(arr));
		var name = var_name(lang,arr[2]);
		var expr = generate_code(input_lang,lang,indent,arr[3]);
		//console.log("initialize_var: "+ name + " "+arr[1]);
		
		if(arr[1] !== "Object"){
			types[name] = arr[1];
			types[expr] = arr[1];
		}
		else{
			same_var_type(name,expr);
			//alert("type of "+expr+" is "+types[expr]);
		}
		
		if(member(lang, ["java","glsl","c","c++","c#","vala"])){
			to_return = var_type(input_lang,lang,arr[1]) + " " + name + "=" + expr;
		}
		else if(member(lang, ["rust"])){
			to_return = "let mut " + name + "=" + expr;
		}
		else if(member(lang, ["tcl"])){
			to_return = "set " + name.substring(1) + " [expr {" + expr+"}]";
		}
		else if(member(lang, ["minizinc"])){
			to_return = var_type(input_lang,lang,arr[1]) + ":" + name + "=" + expr;
		}
		else if(member(lang, ["reverse polish notation"])){
			to_return = name +" "+ expr + " =";
		}
		else if(member(lang,['ruby','matlab','tex','frink','coffeescript','erlang','php','prolog','constraint handling rules','logtalk','picat','octave','wolfram','elm','haskell','python','mathematical notation','coconut','cython','julia','awk'])){
			to_return = name + "=" + expr;
		}
		else if(member(lang,["sympy"])){
			to_return = "Eq("+name+","+expr+")";
		}
		else if(member(lang,["logicjs"])){
			to_return = "eq("+name+","+expr+")";
		}
		else if(member(lang,['r'])){
			to_return = name + " <- " + expr;
		}
		else if(member(lang,['rebol','red','maxima'])){
			to_return = name + ": " + expr;
		}
		else if(member(lang,['visual basic','visual basic .net','openoffice basic'])){
			to_return = "Dim "+name+" As "+var_type(input_lang,lang,arr[1]) +"="+expr;
		}
		else if(member(lang, ["javascript","dart","sidef"])){
			to_return = "var " + name + "=" + expr;
		}
		else if(member(lang, ["ocaml","standard ml"])){
			to_return = "let " + name + "=" + expr;
		}
		else if(member(lang, ["algol 68"])){
			to_return = var_type(input_lang,lang,arr[1]) + " " + name + ":=" + expr;
		}
		else if(member(lang, ["go","autohotkey","gnu smalltalk"])){
			to_return =  name + ":=" + expr;
		}
		else if(member(lang, ["perl",'perl 6'])){
			to_return = "my " + name + "=" + expr;
			console.log(JSON.stringify(["types",name,types[name],expr,types[expr]]));
		}
		else if(member(lang, ["smt-lib","smt-lib"])){
			to_return = "(define-fun " + name + " () " + var_type(input_lang,lang,arr[1]) + " " + expr + ")";
		}
		else if(member(lang,['systemverilog','java','scriptol','c','cosmos','c++','d','englishscript','ceylon'])){
			to_return = name + "=" + expr;
		}
		else if(member(lang,['chapel'])){
			to_return = "var "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
		}
		else if(member(lang,['nim'])){
			if(var_type(input_lang,"java",arr[1]) === "Object"){
				to_return = "var "+name+"="+expr;
			}
			else{
				to_return = "var "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
			}
		}
		else if(member(lang,['kotlin'])){
			if(var_type(input_lang,"java",arr[1]) === "Object"){
				to_return = "val "+name+"="+expr;
			}
			else{
				to_return = "val "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
			}
		}
		else if(member(lang,['haxe','gosu','scala','typescript','swift'])){
			if(arr[1] === "Object"){
				to_return =  "var "+name+"="+expr;
			}
			else{
				to_return =  "var "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
			}
		}
		else if(member(lang,['fortran'])){
			to_return =  var_type(input_lang,lang,arr[1])+"::"+name+"="+expr;
		}
		else if(member(lang,["lua","julia","gap","bash"])){
			to_return =  "local " + name + "=" + expr;
		}
		else if(member(lang,["yacas"])){
			to_return =  name + ":=" + expr;
		}
		else if(member(lang,['ruby','erlang','php','prolog','constraint handling rules','logtalk','picat','octave','wolfram'])){
			to_return =  name + "=" + expr;
		}
	}
	else if(arr[0] === "initialize_static_instance_var_with_value"){

		
		//console.log(JSON.stringify(arr));
		var name = var_name(lang,arr[3]);
		var expr = generate_code(input_lang,lang,indent,arr[4]);
		//console.log("initialize_var: "+ name + " "+arr[1]);
		types[name] = arr[2];
		types[arr[3]] = arr[2];
		if(member(lang, ["java","c#"])){
			to_return = arr[1] + " static " + var_type(input_lang,lang,types[name]) + " " + name + "=" + expr + ";";
		}
		
		else if(member(lang, ["java","c#"])){
			to_return = "static " + name + ":" + var_type(input_lang,lang,types[name]) + "=" + expr + ";";
		}
				
		else if(member(lang,["c++"])){
			to_return = "static " + var_type(input_lang,lang,types[name]) + " " + name + "=" + expr + ";"; 
		}
		else if(member(lang,["ruby"])){
			to_return = "@@" + name + "=" + expr;
		}
		else if(member(lang,["python","coconut"])){
			to_return = name + "=" + expr;
		}
	}
	else if(arr[0] === "initialize_instance_var_with_value"){
		
		if(member(lang,["swift","c++","haxe"])){
			return indent+semicolon(lang,generate_code(input_lang,lang,indent,["initialize_var",arr[2],arr[3],arr[4]]));
		}
		
		//console.log(JSON.stringify(arr));
		var name = var_name(lang,arr[3]);
		var expr = generate_code(input_lang,lang,indent,arr[4]);
		//console.log("initialize_var: "+ name + " "+arr[1]);
		types[name] = arr[2];
		types[arr[3]] = arr[2];
		if(member(lang, ["java","c#"])){
			to_return = arr[1] + " " + var_type(input_lang,lang,types[name]) + " " + name + "=" + expr + ";";
		}
		else if(member(lang, ["protobuf"])){
			to_return = "required " + var_type(input_lang,lang,types[name]) + " " + name + "=" + expr + ";";
		}
		else if(member(lang, ["php"])){
			to_return = arr[1] + " " + name + "=" + expr + ";";
		}
		else if(member(lang, ["javascript","python","coconut","ruby"])){
			to_return = "";
		}
	}
	else if(arr[0] === "initialize_static_instance_var"){
		
		if(member(lang,["swift","c++","haxe"])){

		}
		
		//console.log(JSON.stringify(arr));
		var name = var_name(lang,arr[3]);
		//console.log("initialize_var: "+ name + " "+arr[1]);
		types[name] = arr[2];
		types[arr[3]] = arr[2];
		if(member(lang, ["java","c#"])){
			to_return = arr[1] + " static " + var_type(input_lang,lang,types[name]) + " " + name + ";";
		}
		else if(member(lang, ["c++"])){
			to_return = "static " + var_type(input_lang,lang,types[name]) + " " + name + ";";
		}
		else if(member(lang, ["python","coconut"])){
			to_return = name + " = None";
		}
		else if(member(lang, ["haxe"])){
			to_return = "static " + name + ":" + var_type(input_lang,lang,types[name]) + ";";
		}
	}
	else if(arr[0] === "initialize_instance_var"){
		
		if(member(lang,["swift","c++","haxe"])){
			return indent+semicolon(lang,generate_code(input_lang,lang,indent,["initialize_empty_vars",arr[2],[arr[3]]]));
		}
		
		//console.log(JSON.stringify(arr));
		var name = var_name(lang,arr[3]);
		//console.log("initialize_var: "+ name + " "+arr[1]);
		types[name] = arr[2];
		types[arr[3]] = arr[2];
		if(member(lang, ["java","c#"])){
			to_return = arr[1] + " " + var_type(input_lang,lang,types[name]) + " " + name + ";";
		}
		else if(member(lang, ["javascript","python","coconut","ruby"])){
			to_return = "";
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","javascript"],[".",["$a",["function_call","endsWith",["$b"]]]]],
		[["cython","python",'coconut'],[".",["$a",["function_call","endsWith",["$b"]]]]],
		[["ruby"],[".",["$a",["function_call","end_with?",["$b"]]]]],
		[["swift"],[".",["$a",["function_call","hasSuffix",["$b"]]]]],
		[["c#","f#"],[".",["$a",["function_call","EndsWith",["$b"]]]]]
	],matching_symbols)){
		var Str1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var Str2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
        if(member(lang,['haxe']))
                to_return = ["StringTools.endsWith(",ws,Str1,ws,",",ws,Str2,ws,")"].join("");
        else if(member(lang,['go']))
                to_return = ["strings.hasSuffix(",ws,Str1,ws,",",ws,Str2,ws,")"].join("");
        else if(member(lang,['julia']))
                to_return = ["endswith(",ws,Str1,ws,",",ws,Str2,ws,")"].join("");
        else if(member(lang,['haskell']))
                to_return = ["(isSuffixOf",ws_,Str1,ws_,Str2,ws,")"].join("");
        else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","cython","python",'coconut',"ruby"],[".",["$a",["function_call","replace",["$b","$c"]]]]],
		[["c#"],[".",["$a",["function_call","Replace",["$b","$c"]]]]],
		[["php"],["function_call","str_replace",["$b","$c","$a"]]],
		[["haxe"],[".",["StringTools",["function_call","replace",["$a","$b","$c"]]]]]
	],matching_symbols)){
		//console.log("matched replace");
		var Str1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var Str2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var Str3 = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		types[Str1] = "String";
		types[Str2] = "String";
		types[Str3] = "String";
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		if(to_return !== undefined){
			types[to_return] = "String";
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","javascript"],[".",["$a",["function_call","startsWith",["$b"]]]]],
		[["ruby"],[".",["$a",["function_call","start_with?",["$b"]]]]],
		[["python",'coconut'],[".",["$a",["function_call","startswith",["$b"]]]]],
		[["c#","f#"],[".",["$a",["function_call","StartsWith",["$b"]]]]],
		[["swift"],[".",["$a",["function_call","hasPrefix",["$b"]]]]],
		[["haxe"],[".",["StringTools",["function_call","startsWith",["$a","$b"]]]]],
		[["go"],[".",["strings",["function_call","hasPrefix",["$a","$b"]]]]],
		[["julia"],["function_call","startswith",["$a","$b"]]]
	],matching_symbols)){
		var Str1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var Str2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
        if(member(lang,['php'])){
				to_return = "(substr(Str1, 0, strlen("+Str2+")) === "+Str2+")";
		}
        else if(member(lang,['haskell']))
                to_return = ["(",ws,"isPrefixOf",ws_,Str1,ws_,Str2,ws,")"].join("");
        else if(member(lang,['c']))
                to_return = ["(",ws,"strncmp",ws,"(",ws,Str1,ws,",",ws,Str2,ws,",",ws,"strlen",ws,"(",ws,Str2,ws,")",ws,")",ws,"==",ws,"0",ws,")"].join("");
        else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "boolean";
	}
	//check if an arraylist contains something 
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["$a",["function_call","contains",["$b"]]]]],
		[["c#"],[".",["$a",["function_call","Contains",["$b"]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = array_contains(lang,a,b);
		types[to_return] = "boolean";
		if(to_return !== undefined){
			return to_return;
		}
	}
	//append an item to an arraylist
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["$a",["function_call","add",["$b"]]]]],
		[["php"],["function_call","array_push",["$a","$b"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["c#"])){
			to_return = a+".add("+b+")";
		}
		else if(member(lang,["javascript","typescript"])){
			to_return = a+".push("+b+")";
		}
		else if(member(lang,["javascript","python",'coconut'])){
			to_return = a+".append("+b+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		
		if(to_return !== undefined){
			return indent + to_return;
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["$a",["function_call","get",["$b"]]]]]
	],matching_symbols)){
		return generate_code(input_lang,lang,indent,["access_dict",matching_symbols["$a"],matching_symbols["$b"]]);
	}
	/*
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["Arrays",["function_call","asList","$a"]]]]
	],matching_symbols)){
		var a = matching_symbols["$a"];
		//console.log("generating arraylist");
		a=a.map(function(x){return generate_code(input_lang,lang,indent,x)});
		if(lang === "java"){
			
		}
		to_return = generate_code(input_lang,lang,indent,["initializer_list",types[a[0]],a]);
		types[to_return] = ["ArrayList", types[a[0]]];
	}
	*/
	else if(arr[0] === "associative_array"){
		var key_type = arr[1];
		var value_type = arr[2];
		var list_inner = arr[3].map(function(x){return generate_code(input_lang,lang,indent,["key_value",x])});
		if(member(lang,['python','coconut', 'coffeescript', 'english_temp', 'cosmos', 'ruby', 'lua', 'dart','javascript','typescript','c++','engscript'])){
			to_return = "{"+list_inner.join(",")+"}";
		}
		else if(member(lang,['haxe','frink','swift','elixir','d','wolfram','prolog','constraint handling rules'])){
			to_return = "["+list_inner.join(",")+"]";
		}
		else if(member(lang,['picat'])){
			to_return = "new_map(["+list_inner.join(",")+"])";
		}
		else if(member(lang,['julia'])){
			to_return = "Dict("+list_inner.join(",")+")";
		}
		else if(member(lang,['php'])){
			to_return = "array("+list_inner.join(",")+")";
		}
		else if(member(lang,['haskell'])){
			to_return = "(Data.Map.fromlist ["+list_inner.join(",")+"])";
		}
		else if(member(lang,['scala','perl'])){
			to_return = "("+list_inner.join(",")+")";
		}
		else if(member(lang,['octave'])){
			to_return = "struct("+list_inner.join(",")+")";
		}
		else if(member(lang,['rebol'])){
			to_return = "to-hash ["+list_inner.join(" ")+"]";
		}
		else if(member(lang,['prolog'])){
			if(list_inner.length === 0){
				to_return = "[_|_]";
			}
		}
		else if(member(lang,['c#','java',"swift"])){
			var key_type = var_type(input_lang,lang,arr[1]);
			var value_type = var_type(input_lang,lang,arr[2]);
			if(lang === "c#"){
				to_return = "new Dictionary<"+var_type(input_lang,lang,key_type)+", "+var_type(input_lang,lang,value_type)+"> {"+list_inner.join(",")+"}";
			}
			else if(lang === "swift"){
				to_return = "["+var_type(input_lang,lang,key_type)+":"+var_type(input_lang,lang,value_type)+"]("+list_inner.join(",")+")";
			}
			else if(lang === "java"){
				to_return = "new HashMap<"+var_type(input_lang,lang,key_type)+", "+var_type(input_lang,lang,value_type)+">(){{"+list_inner.join(",")+"}}";
			}
		}
		types[to_return] = ["dict",key_type,value_type];
	}
	else if(arr[0] === "key_value"){
		var the_key = arr[1][0];
		var the_value = generate_code(input_lang,lang,indent,arr[1][1]);
		if(member(lang,['javascript','python','cython','coconut'])){
			return the_key+":"+the_value;
		}
		else if(member(lang,['php','haxe','perl','ruby','julia'])){
			return the_key+"=>"+the_value;
		}
		else if(member(lang,['scala','wolfram'])){
			return the_key+"->"+the_value;
		}
		else if(member(lang,['picat','lua'])){
			return the_key+"="+the_value;
		}
		else if(member(lang,['rebol'])){
			return the_key+" "+the_value;
		}
		else if(member(lang,['c#','c++','haskell'])){
			return "{"+the_key+","+the_value+"}";
		}
		else if(member(lang,['java'])){
			return "put("+the_key+","+the_value+")";
		}
	}
	else if(arr[0] === "named_parameter"){
		var the_key = arr[1];
		var the_value = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,['c#',"ruby"])){
			return the_key+":"+the_value;
		}
		if(member(lang,['python','cython','coconut'])){
			return the_key+"="+the_value;
		}
	}
	else if(arr[0] === "initializer_list"){
		var list_inner = arr[2].map(function(x){return generate_code(input_lang,lang,indent,x)});
		if(member(lang,['ruby','standard ml','coq','erlang','maxima','elm','cosmos', 'python','coconut', 'cython', 'nim','d','frink','octave','julia','prolog','constraint handling rules','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','rebol','polish notation','swift'])){
			to_return = "["+list_inner.join(",")+"]";
		}
		else if(member(lang,["rebol"])){
			to_return = "["+list_inner.join(" ")+"]";
		}
		else if(member(lang,["perl","chapel"])){
			to_return = "("+list_inner.join(",")+")";
		}
		else if(member(lang,["emacs lisp","common lisp","scheme"])){
			to_return = "(list "+list_inner.join(" ")+")";
		}
		else if(member(lang,["ocaml"])){
			//This is a list, not an array
			to_return = "["+list_inner.join(";")+";]";
		}
		else if(member(lang,["php"])){
			to_return = "array("+list_inner.join(",")+")";
		}
		else if(member(lang,["kotlin"])){
			to_return = "arrayOf("+list_inner.join(",")+")";
		}
		else if(member(lang,["fortan"])){
			to_return = "(/"+list_inner.join(",")+"/)";
		}
		else if(member(lang,["go"])){
			to_return = "[]"+var_type(input_lang,lang,types[list_inner[0]])+"{"+list_inner.join(",")+"}";
		}
		else if(member(lang,["java"])){
			to_return = "new ArrayList<>(Arrays.asList("+list_inner.join(",")+"))";
		}
		else if(member(lang,["c++"])){
			to_return = var_type(input_lang,lang,arr[1]) + "{"+list_inner.join(",")+"}";
		}
		else if(member(lang,["r"])){
			to_return = "s("+list_inner.join(",")+")";
		}
		else if(member(lang,["scala"])){
			to_return = "array("+list_inner.join(",")+")";
		}
		else if(member(lang,["tcl"])){
			to_return = "{"+list_inner.join(" ")+"}";
		}
		else if(member(lang,['lua','gosu','yacas','pseudocode','picat','c#','c++','c','visual basic','visual basic .net','wolfram'])){
			to_return = "{"+list_inner.join(",")+"}";
		}
		//console.log(JSON.stringify(arr));
		types[to_return] = [types[list_inner[0]],"[]"];
	}
	else if(arr[0] === "foreach_with_index"){
		types[arr[3]] = arr[1];
		types[arr[2]] = "int";
		var the_list = generate_code(input_lang,lang,indent,arr[4]);
		var item = generate_code(input_lang,lang,indent,arr[3]);
		var index = generate_code(input_lang,lang,indent,arr[2]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		types[item] = arr[1];
		if(member(lang, ["python",'coconut'])){
			to_return =  "for "+index+","+item+" in enumerate("+the_list+"):"+body;
		}
		else if(member(lang, ["go"])){
			to_return = "for "+index+","+item+" := range "+the_list+"{"+body+indent+"}";
		}
		else if(member(lang, ["php"])){
			to_return = "foreach("+the_list+" as "+index+" => "+item+"){"+body+indent+"}";
		}
		else if(member(lang, ["lua"])){
			to_return = "for "+index+","+item+" in pairs("+the_list+") do "+body+indent+"end";
		}
	}
	else if(arr[0] === "list_comprehension"){
		//list comprehension without condition
		//see https://rosettacode.org/wiki/List_comprehensions
		var result = generate_code(input_lang,lang,indent,arr[1]);
		var variable = generate_code(input_lang,lang,indent,arr[2]);
		var the_list = generate_code(input_lang,lang,indent,arr[3]);
		var condition;
		if(arr.length === 4){
			if(member(lang,["haskell"])){
				to_return = "["+result + "|" + variable + "<-" + the_list + "]";
			}
			else if(member(lang,["frink"])){
				to_return = "select[ " + the_list + ", { |variable | " + result + "} ]";
			}
			else if(member(lang,["php"])){
				to_return ="array_map(function(" + variable + "){return " + result + ";}, " + the_list + ")";
			}
			else if(member(lang,["c#"])){
				to_return = "(from " + variable + " in " + the_list + " select " + result+")";
			}
			else if(member(lang,["minizinc"])){
				to_return = "["+ result + "|" + variable + " in " + the_list + "]";
			}
			else if(member(lang,["python","cython","coconut","julia"])){
				to_return = "[" + result + " for " + variable + " in " + the_list + "]";
			}
			else if(member(lang,["coffeescript"])){
				to_return = "(" + result + " for " + variable + " in " + the_list + ")";
			}
			else if(member(lang,["javascript","typescript"])){
				to_return = the_list + ".map(" + variable + "){return " + result + ";}";
			}
			else if(member(lang,["ruby"])){
				to_return = the_list + ".map{|" + variable + "|" + result + "}";
			}
			else if(member(lang,["erlang"])){
				to_return = "[" + result + "||" + variable + "<-" + the_list + "]";
			}
		}
		else{
			condition = generate_code(input_lang,lang,indent,arr[4]);
			if(member(lang,["python","cython","coconut","julia"])){
				to_return = "[" + result + " for " + variable + " in " + the_list + " if "+condition+"]";
			}
			else if(member(lang,["c#"])){
				to_return = "(from " + variable + " in " + the_list + " where " + condition + " select " + result+")";
			}
			else if(member(lang,["ruby"])){
				to_return = the_list + ".select{|" + variable + "|" + condition + "}.collect{|" + variable + "|" + result + "}";
			}
			else if(member(lang,["coffeescript"])){
				to_return = "(" + result + " for " + variable + " in " + the_list + " when "+condition+")";
			}
			else if(member(lang,["scala"])){
				to_return = "(for("+variable+" <- "+the_list+" if "+condition+") yield "+result+")";
			}
			else if(member(lang,["erlang"])){
				to_return = "[" + result + "||" + variable + "<-" + the_list + "," + condition + "]";
			}
			else if(member(lang,["haskell"])){
				to_return = "[" + result + "|" + variable + "<-" + the_list + "," + condition + "]";
			}
			else if(member(lang,["picat"])){
				to_return = "[" + variable + ":" + variable + " in " + the_list + "," + condition + "]";
			}
			else if(member(lang,["minizinc"])){
				to_return = "[" + result + "|" + variable + " in " + the_list + " where " + condition + "]";
			}
		}
		types[to_return] = [types[output],"[]"];
	}
	else if(arr[0] === "foreach"){
		types[arr[2]] = arr[1];
		var the_list = generate_code(input_lang,lang,indent,arr[3]);
		var item = generate_code(input_lang,lang,indent,arr[2]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[4]);
		types[item] = arr[1];
		if(member(lang, ["java"])){
			to_return = "for("+var_type(input_lang,lang,arr[1])+" "+item+":"+the_list+"){"+body+indent+"}";
		}
		else if(member(lang, ["coq"])){
			to_return = "(forall ("+item+":"+var_type(input_lang,lang,arr[1])+") ("+the_list+":list "+var_type(input_lang,lang,arr[1])+"), "+body+")";
		}
		else if(member(lang,["erlang"])){
			to_return = "lists:foreach(fun(" + item + ") ->" +
                      body+indent+
            "end,"+the_list+")";
		}
		else if(member(lang, ["julia"])){
			to_return = "for "+item+"="+the_list+body+indent+"end";
		}
		else if(member(lang, ["rebol"])){
			to_return = "foreach "+item+" "+the_list+" ["+body + "]";
		}
		else if(member(lang, ["octave"])){
			to_return = "foreach "+item+" = "+the_list+body+indent+"endfor";
		}
		else if(member(lang, ["tcl"])){
			to_return = "foreach "+item+" "+the_list+"{"+body+indent+"}";
		}
		else if(member(lang, ["c#"])){
			to_return = "foreach("+var_type(input_lang,lang,arr[1])+" "+item+" in "+the_list+"){"+body+indent+"}";
		}
		else if(member(lang, ["visual basic .net"])){
			to_return = "For Each"+" "+item+" as "+ var_type(input_lang,lang,arr[1]) +" in "+the_list+body+indent+"Next";
		}
		else if(member(lang,["scala"])){
			to_return = "for("+item+" <- "+the_list+"){"+body+indent+"}";
		}
		else if(member(lang,["ruby"])){
			to_return = the_list + ".each do|" + item + "|" + body + indent + "end";
		}
		else if(member(lang, ["go"])){
			to_return = "for _, "+item+" := range "+the_list+"{"+body+indent+"}";
		}
		else if(member(lang, ["prolog"])){
			to_return = "forall(member("+item+","+the_list+"),("+body+indent+")))";
		}
		else if(member(lang, ["picat"])){
			to_return = "foreach("+item+" in "+the_list+")"+body+indent+"end";
		}
		else if(member(lang, ["python","cython","coconut"])){
			to_return =  "for "+item+" in "+the_list+":"+body;
		}
		else if(member(lang, ["coffeescript"])){
			to_return =  "for "+item+" in "+the_list+body;
		}
		else if(member(lang, ["haxe","groovy","sidef"])){
			to_return =  "for("+item+" in "+the_list+"){"+body+indent+"}";
		}
		else if(member(lang, ["swift","chapel"])){
			to_return =  "for "+item+" in "+the_list+"{"+body+indent+"}";
		}
		else if(member(lang, ["javascript","typescript"])){
			to_return = the_list+".forEach(function("+item+"){"+body+indent+"});"
		}
		else if(member(lang, ["lua"])){
			to_return = "for _,"+item + " in pairs("+the_list+") do "+body+indent+"end";
		}
		else if(member(lang, ["php"])){
			to_return = "foreach("+the_list+" as "+item+"){"+body+indent+"}";
		}
		else if(member(lang, ["minizinc"])){
			to_return = "forall(" + item + " in " + the_list + ")(" + body + indent + ")";
		}
		else if(member(lang,["c++"])){
			to_return = "for(" + var_type(input_lang,lang,arr[1]) + " & " + item + ":" + the_list + "){"+body+indent+"}";
		}
		else if(member(lang, ["perl"])){
			to_return = "foreach "+item+"("+the_list+"){"+body+indent+"}";
		}
		else if(member(lang, ["dart"])){
			to_return = "for(var "+item+" in "+the_list+"){"+body+indent+"}";
		}
		else if(member(lang, ["r"])){
			to_return = "for("+item+" in "+the_list+"){"+body+indent+"}";
		}
	}
	else if(arr[0] === "while"){
		var arr1 = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var arr2 = generate_code(input_lang,lang,indent+"    ",arr[2]);
		to_return = while_loop(lang, arr1, arr2, indent);
	}
	else if(arr[0] === "do_while"){
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		if(member(lang,["java","c","glsl","c++","javascript","perl"])){
			to_return = "do {" + a +indent + "}"+indent+"while(" + b + ");";
		}
		else if(member(lang,["yacas"])){
			to_return = "Until (" + a + ") [" + b + indent +"];";
		}
	}
	else if(Array.isArray(arr) && arr.length === 1){
		to_return = generate_code(input_lang,lang,indent,arr[0]);
	}
	else if(arr[0] === "semicolon"){
		return indent+semicolon(lang,generate_code(input_lang,lang,indent,arr[1]));
	}
	else if(arr[0] === "set_var"){
		//console.log(JSON.stringify(arr));
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		//console.log("initialize_var: "+ arr[2] + " "+arr[1]);
		same_var_type(a,b);
		if(member(lang,['javascript','tex',"coffeescript",'cython','haskell','python','coconut','minizinc','systemverilog','elixir','visual basic .net','lua','ruby','scriptol','mathematical notation','perl 6','wolfram','chapel','katahdin','frink','picat','ooc','d','genie','janus','ceylon','idp','processing','java','boo','gosu','pike','kotlin','icon','powershell','engscript','pawn','freebasic','hack','nim','openoffice basic','groovy','typescript','rust','fortran','awk','go','swift','vala','c','julia','scala','cobra','erlang','autoit','dart','java','ocaml','haxe','c#','matlab','c++','php','perl','gambas','octave','visual basic','bc'])){
			to_return = a + "=" + b;
		}
		else if(member(lang,["sympy"])){
			to_return = "Eq("+a+","+b+")";
		}
		else if(member(lang,["logicjs"])){
			to_return = "eq("+a+","+b+")";
		}
		else if(member(lang,["reverse polish notation"])){
			to_return = a+" "+b+" =";
		}
		else if(member(lang,["tcl"])){
			to_return = "set "+a.substring(1)+" [expr {"+b+"}]";
		}
		else if(member(lang,["prolog","logtalk"])){
			if(member(types[a],["int","float","double"])){
				to_return = a+" is "+b;
			}
			else{
				to_return = a+"="+b;
			}
		}
		else if(member(lang,['r'])){
			to_return = a + " <- " + b;
		}
		else if(member(lang,['smt-lib','smt-lib'])){
			to_return =  "(= "+a+" "+b+")";
		}
		else if(member(lang,['smt-lib','smt-lib'])){
			to_return =  "(= "+a+" "+b+")";
		}
		else if(member(lang,['gap','ada','algol 68','seed7','delphi','vhdl','yacas'])){
			to_return = a + " := " + b;
		}
		else if(member(lang,['rebol','maxima'])){
			to_return = a + " : " + b;
		}
	}
	else if(arr[0] === "number"){
		types[arr[1]] = "float";
		to_return = arr[1];
	}
	else if(arr[0] === "string_literal"){
		types[arr[1]] = "String";
		to_return = arr[1];
	}
	else if(!isNaN(arr)){
		types[arr] = "int";
		to_return = arr;
	}
	else if(typeof arr === 'string' && arr.startsWith("\"")){
		//detect string literals
		types[arr] = "String";
		to_return = arr;
	}
	else if(typeof arr === 'string' && arr.startsWith("\'")){
		//detect character literals
		types[arr] = "char";
		to_return = arr;
	}
	//do this if it's an identifier
	else if(typeof arr === 'string' && /^[$A-Z_][0-9A-Z_$]*$/i.test(arr)){
		to_return = var_name(lang,arr);
	}
	else if(arr.length === 2 && arr[0] === "." && (arr[1].length === 1)){
		if(!isNaN(arr[1])){
			to_return = arr[1][0];
			types[to_return] = "int"
		}
		else if(typeof arr[1][0] === 'string' && /^[$A-Z_][0-9A-Z_$]*$/i.test(arr[1][0])){
			return var_name(lang,arr[1][0]);
		}
		else{
			return generate_code(input_lang,lang,indent,arr[1]);
		}
	}
	else if(arr[0] === "+" || arr[0] === ".." || (member(input_lang,["haskell","coq","picat"]) && arr[0] === "++") || arr[0] === ".." || (member(input_lang,["php","perl"]) && arr[0] ==="." && arr.length === 3)){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(input_lang === "lua" & arr[0] === ".." || member(input_lang,["php","perl"]) && a ==="."){
			types[a] = "String";
			types[b] = "String";
		}
		
		if((infix_arithmetic_lang(lang) || lang === "tex") && (types[a] !== "String") && (types[b] !== "String")){
			to_return = a + "+" + b;
			same_var_type(to_return,a);
		}
		else if(prefix_arithmetic_lang(lang) && !member(types[a] !== "String") && (types[b] !== "String")){
			to_return = "(+ " + a + " " + b + ")";
			same_var_type(to_return,a);
		}
		else if(member(lang,['forth','reverse polish notation'])){
			to_return = a + " " + b + " +";
			same_var_type(to_return,a);
		}
		else if(get_type(a) === "String" || get_type(b) === "String"){
			//console.log("doing string concat");
			//console.log([types[a],types[b]])
			if(!member(get_type(a),["String","Object"])){
				a = type_conversion(input_lang,lang,get_type(a),"String",b);
			}
			else if(!member(get_type(b),["String","Object"])){
				b = type_conversion(input_lang,lang,get_type(a),"String",b);
			}
			//console.log(JSON.stringify(types));
			if(member(lang,["php","autohotkey","hack","perl"])){
				to_return = a + " . " + b;
			}
			else if(member(lang,['c','ruby','python','coconut','cosmos','z3py','monkey x','englishscript','mathematical notation','go','java','chapel','frink','freebasic','nemerle','d','cython','ceylon','coffeescript','typescript','dart','gosu','groovy','scala','swift','f#','javascript','c#','haxe','c++','vala'])){
				to_return = a + " + " + b;
			}
			else if(member(lang,["fortran"])){
				to_return = a + " // " + b;
			}
			else if(member(lang,["reverse polish notation"])){
				to_return = a + " " + b + " +";
			}
			else if(member(lang,["perl 6"])){
				to_return = a + " ~ " + b;
			}
			else if(member(lang,['elixir','wolfram','purescript'])){
				to_return = a + " <> " + b;
			}
			else if(member(lang,['visual basic','seed7','visual basic .net','gambas','nim','autoit','openoffice basic','livecode','vbscript'])){
				to_return =a + " & " + b;
			}
			else if(member(lang,['ocaml','standard ml'])){
				to_return =a + "^" + b;
			}
			else if(member(lang,["r"])){
				to_return ="paste0("+a + "," + b+")";
			}
			else if(member(lang,["erlang"])){
				to_return ="string:concat("+a + "," + b+")";
			}
			else if(member(lang,["octave"])){
				to_return ="strcat("+a + "," + b+")";
			}
			else if(member(lang,["delphi"])){
				to_return ="Concat("+a + "," + b+")";
			}
			else if(member(lang,["octave","julia"])){
				to_return ="string("+a + "," + b+")";
			}
			else if(member(lang,["common lisp"])){
				to_return ="(concatenate_string "+a + " " + b+")";
			}
			else if(member(lang,["racket"])){
				to_return ="(string-append "+a + " " + b+")";
			}
			else if(member(lang,["clips"])){
				to_return ="(str-cat "+a + " " + b+")";
			}
			else if(member(lang,["emacs lisp"])){
				to_return ="(concat "+a + " " + b+")";
			}
			else if(member(lang,["clojure"])){
				to_return ="(str "+a + " " + b+")";
			}
			else if(member(lang,["lua"])){
				to_return =a + " .. " + b;
			}
			else if(member(lang,['haskell','minizinc','picat','elm','coq'])){
				to_return =a + " ++ " + b;
			}
			else if(member(lang,["rebol"])){
				to_return = "join " + a + " " + b;
			}
			types[to_return] = "String";
		}
		else{
			throw "+ is not defined for " + types[a] + " and " + types[b] + " in " + lang;
		}
	}
	else if(member(input_lang, ["java"]) && (matches_pattern(arr,[".",["Arrays",["function_call","deepEquals",["$a","$b"]]]],matching_symbols) || matches_pattern(arr,[".",["Arrays",["function_call","equals",["$a","$b"]]]],matching_symbols))){
		//console.log("Equals "+ matching_symbols["$a"] + " "+ matching_symbols["$b"]);
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["java"])){
			to_return = "Arrays.deepEquals("+a+","+b+")";
		}
		else if(member(lang,["php"])){
			to_return = a+" === "+b;
		}
		else if(member(lang,["ruby","c++"])){
			to_return = a+" == "+b;
		}
		else if(member(lang,["scala"])){
			to_return = "("+a+".deep == "+b+".deep)";
		}
		else if(member(lang,["c#"])){
			to_return = a+".SequenceEqual("+b+")";
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["$a",["function_call","equals",["$b"]]]]]
	],matching_symbols)){
		//console.log("Equals "+ matching_symbols["$a"] + " "+ matching_symbols["$b"]);
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(types[a] === "String"){
			if(member(lang,['pydatalog','ruby','lua','perl 6','python','coconut','cython','englishscript','chapel','julia','fortran','minizinc','picat','go','vala','autoit','rebol','ceylon','groovy','scala','coffeescript','awk','haskell','haxe','dart','swift'])){
				to_return = a + "==" + b;
			}
			else if(member(lang,['sympy'])){
				to_return = "Eq("+a+ + "," + b+")";
			}
			else if(member(lang,['logicjs'])){
				to_return = "eq("+a+ + "," + b+")";
			}
			else if(member(lang,['visual basic','mathematical notation','visual basic .net','delphi','vbscript','f#','prolog','mathematical notation','ocaml','livecode','monkey x'])){
				to_return = a + "=" + b;
			}
			else if(member(lang,['javascript','php','typescript','hack'])){
				to_return = a + "===" + b;
			}
			else if(member(lang,['perl'])){
				to_return = a + " eq " + b;
			}
			else if(member(lang,['java'])){
				to_return = a + ".equals(" + b + ")";
			}
			else if(member(lang,['c#'])){
				to_return = a + ".Equals(" + b + ")";
			}
			else if(member(lang,['c++','systemverilog'])){
				to_return = a + ".compare(" + b + ")";
			}
			same_var_type(to_return,a);
		}
	}
	else if(arr[0] === "=="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		same_var_type(a,b);
		if(member(lang,['nim','mathematical notation','lc++','cython','lua','python','coconut','smt-libpy','pydatalog','e','ceylon','perl 6','englishscript','cython','dafny','wolfram','d','rust','r','minizinc','frink','picat','pike','pawn','processing','c++','ceylon','coffeescript','octave','swift','awk','julia','groovy','erlang','haxe','scala','vala','dart','c#','c','go','haskell'])){
			to_return = a + arr[0] + b;
		}
		else if(member(lang,['sympy'])){
			to_return = "Eq("+a + "," + b + ")";
		}
		else if(member(lang,['reverse polish notation'])){
			to_return = a + " " + b + " =";
		}
		else if(member(lang,['logicjs','reasoned-php'])){
			to_return = "eq("+a + "," + b + ")";
		}
		else if(member(lang,['perl'])){
			if(types[a] === "String"){
				to_return = a +" eq "+ b;
			}
			else if(member(types[a],["int","double","float"])){
				to_return = a +" == "+ b;
			}
		}
		else if(member(lang,['java'])){
			if(types[a] === "String"){
				to_return = a +".equals("+b+")";
			}
			else if(member(types[a],["int","double","float"])){
				to_return = a +" == "+ b;
			}
		}
		else if(member(lang,["prolog","constraint handling rules"])){
			if(member(types[a], ["int","double","float"])){
				to_return = a + " is " + b;
			}
			else{
				to_return = a + " = " + b;
			}
		}
		else if(member(lang,["ruby"])){
			to_return = a + " == " + b;
		}
		else if(member(lang,["tex"])){
			to_return = a + " = " + b;
		}
		else if(member(types[a], ["int","float","double","long"]) && member(lang,['maxima','standard ml','seed7','monkey x','gap','rebol','f#','autoit','pascal','delphi','visual basic','visual basic .net','ocaml','livecode','vbscript'])){
			to_return = a + " = " + b;
		}
		else if(member(lang,['javascript','chr.js','php','typescript','hack'])){
			to_return = a + "===" + b;
		}
		else if(member(lang,['c','c++','c#','haskell'])){
			if(member(types[a],['int','double','char','float','boolean'])){
				to_return = a + arr[0] + b;
			}
		}
		else if(member(lang,['smt-lib','smt-lib','emacs lisp','common lisp','clips','racket'])){
			if(member(types[a],['int','double','char','float','boolean'])){
				to_return = "(= " + a + " " + b + ")";
			}
		}
		else{
			throw arr[0]+" is not defined for "+lang;
		}
		same_var_type(to_return,a);
	}
	else if(member(arr[0],["-","*","/"])){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		types[a] = "int";
		types[b] = "int";
		same_var_type(a,b);
		if(infix_arithmetic_lang(lang)){
			to_return = a + arr[0] + b;
			same_var_type(to_return,a);
		}
		else if(lang === "tex"){
			if(arr[0] === "*")
				to_return = a + " \\times " + b;
			else if(arr[0] === "+")
				to_return = a + " + " + b;
			else if(arr[0] === "-")
				to_return = a + " - " + b;
			else if(arr[0] === "/")
				to_return = "\\frac{"+a+"}{"+b+"}";
			same_var_type(to_return,a);
		}
		else if(prefix_arithmetic_lang(lang)){
			to_return =  "("+arr[0] + " " + a + " " + b+")";
			same_var_type(to_return,a);
		}
	}
	else if(member(arr[0],["exclusive_range"])){
		//range 1...3 is [1,2] in Ruby
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		types[a] = "int";
		types[b] = "int";
		same_var_type(a,b);
		if(member(lang,['ruby','haxe'])){
			to_return = a + "..." + b;
		}
		else if(member(lang,['swift'])){
			to_return = a + ".." + b;
		}
		else if(member(lang,['haskell'])){
			to_return = a + "..(" + b+"-1)";
		}
		else if(member(lang,['python','cython','coconut'])){
			to_return = "range(" + a + "," + b + ")";
		}
		else if(member(lang,['php'])){
			to_return = "range(" + a + "," + b + "-1)";
		}
		types[to_return] = ["int","[]"];
	}
	else if(member(arr[0],["inclusive_range"])){
		// 1..3 is [1,2,3] in Ruby
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		types[a] = "int";
		types[b] = "int";
		same_var_type(a,b);
		if(member(lang,['ruby','perl','haskell'])){
			to_return = a + ".." + b;
		}
		else if(member(lang,['swift'])){
			to_return = a + "..." + b;
		}
		else if(member(lang,['haxe'])){
			to_return = a + "...(" + b + "+1)";
		}
		else if(member(lang,['python','cython','coconut'])){
			to_return = "range(" + a + "," + b + "+1)";
		}
		else if(member(lang,['php'])){
			to_return = "range(" + a + "," + b + ")";
		}
		types[to_return] = ["int","[]"];
	}
	else if(member(arr[0],["%"])){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,['java','lua','ruby','perl 6','python','coconut','cython','rust','typescript','frink','ooc','genie','pike','ceylon','pawn','powershell','coffeescript','gosu','groovy','engscript','awk','julia','scala','f#','swift','r','perl','nemerle','haxe','php','hack','vala','tcl','go','dart','javascript','c','c++','c#'])){
			to_return = a + arr[0] + b;
		}
		else if(member(lang,['haskell','seed7','minizinc','ocaml','delphi','pascal','picat','livecode'])){
			to_return = a + " mod " + b;
		}
		else if(member(lang,['erlang'])){
			to_return = a + " rem " + b;
		}
		else if(member(lang,['visual basic','monkey x'])){
			to_return = a + " Mod " + b;
		}
		else if(member(lang,['forth'])){
			to_return = a + b + " mod";
		}
		else if(member(lang,['prolog','octave','matlab','autohotkey','fortran'])){
			to_return = "mod("+a + "," + b+")";
		}
		else if(member(lang,['rebol'])){
			to_return = "mod "+a + " " + b;
		}
		else if(member(lang,['wolfram'])){
			to_return = "Mod["+a + "," + b+"]";
		}
		else if(member(lang, ['clips','clojure','common lisp','z3'])){
			to_return = "(mod "+a + " " + b+")";
		}
		else{
			throw arr[0]+" is not defined for "+lang;
		}
		types[to_return] = "int";
	}
	else if(member(arr[0],[">","<",">=","<="])){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		same_var_type(a,b);
		if(infix_arithmetic_lang(lang)){
			to_return = a + arr[0] + b;
		}
		else if(lang === "tex"){
			to_return = a + " " + {"<=":"\\leq",">=":"\\geq","<":"<",">":">"}[arr[0]] + " " + b
		}
		else if(member(lang,["forth","reverse polish notation"])){
			to_return = a + " " + b+" "+arr[0];
		}
		else if(prefix_arithmetic_lang(lang)){
			to_return = "("+arr[0]+" "+a + " " + b+")";
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "eager_or"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,['javascript','python','c++','c#','php','smalltalk','perl','ruby','java','julia','matlab','r','swift'])){
			to_return = a + "|" + b;
		}
		else if(member(lang,['erlang','pascal'])){
			to_return = a + " or " + b;
		}
		else if(member(lang,['prolog'])){
			to_return = a + "; " + b;
		}
		else if(member(lang,['erlang','pascal'])){
			to_return = a + " Or " + b;
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "eager_and"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,['javascript','python','c++','c#','php','smalltalk','perl','ruby','java','julia','matlab','r','swift'])){
			to_return = a + "&" + b;
		}
		else if(member(lang,['erlang','pascal'])){
			to_return = a + " and " + b;
		}
		else if(member(lang,['prolog'])){
			to_return = a + ", " + b;
		}
		else if(member(lang,['erlang','pascal'])){
			to_return = a + " And " + b;
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "||"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,['javascript',"sidef",'coq','lc++','tcl','autohotkey','katahdin','perl 6','ruby','wolfram','chapel','elixir','frink','ooc','picat','janus','processing','pike','nools','pawn','matlab','hack','gosu','rust','autoit','autohotkey','typescript','ceylon','groovy','d','octave','awk','julia','scala','f#','swift','nemerle','vala','go','perl','java','haskell','haxe','c','c++','c#','dart','r'])){
			to_return = a + "||" + b;
		}
		else if(member(lang,['reverse polish notation'])){
			to_return = a + " " + b+" or";
		}
		else if(member(lang,['reasoned-php'])){
			to_return = "conde([" + a + "," + b+"])";
		}
		else if(member(lang,['minizinc','abella'])){
			to_return = a + "\\/" + b;
		}
		else if(member(lang,['algol 68'])){
			to_return = a + " orelse " + b;
		}
		else if(member(lang,['visual basic','monkey x','visual basic .net','yacas'])){
			to_return = a + " Or " + b;
		}
		else if(member(lang,['logicjs','reasoned-php'])){
			to_return = "or(" + a + "," + b + ")";
		}
		else if(member(lang,['mathematical notation'])){
			to_return = a + "\u2228" + b;
		}
		else if(member(lang,['cosmos','cython','vhdl','python','coconut','lua','seed7','livecode','englishscript','cython','gap','mathematical notation','genie','idp','maxima','engscript','ada','newlisp','ocaml','nim','coffeescript','pascal','delphi','erlang','rebol','php'])){
			to_return = a + " or " + b;
		}
		else if(member(lang,['smt-lib','common lisp','clips','pddl','clojure','common lisp','emacs lisp','clojure','racket'])){
			to_return = "(or "+a+" "+b+")";
		}
		else if(member(lang,['z3py'])){
			to_return = "Or("+a+","+b+")";
		}
		else if(member(lang,['prolog','constraint handling rules'])){
			to_return = a+";"+b;
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "&&"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		to_return;
		if(member(lang,['javascript','coq','lc++','tcl','autohotkey','ats','ruby','katahdin','perl 6','wolfram','chapel','elixir','frink','ooc','picat','janus','processing','pike','nools','pawn','matlab','hack','gosu','rust','autoit','autohotkey','typescript','ceylon','groovy','d','octave','awk','julia','scala','f#','swift','nemerle','vala','go','perl','java','haskell','haxe','c','c++','c#','dart','r'])){
			to_return = a + "&&" + b;
		}
		else if(member(lang,['logicjs','reasoned-php'])){
			to_return = "and("+a + "," + b+")";
		}
		else if(member(lang,['algol 68'])){
			to_return = a + " andif " + b;
		}
		else if(member(lang,['tex'])){
			to_return = "(" + a + " \\land " + b + ")";
		}
		else if(member(lang,['visual basic','monkey x','visual basic .net','yacas'])){
			to_return = a + " And " + b;
		}
		else if(member(lang,['mathematical notation'])){
			to_return = a + "\u2227" + b;
		}
		else if(member(lang,['prolog','constraint handling rules','logtalk'])){
			to_return = a + "," + b;
		}
		else if(member(lang,['minizinc'])){
			to_return = a + "/\\" + b;
		}
		else if(member(lang,['reverse polish notation'])){
			to_return = a + " " + b+" and";
		}
		else if(member(lang,['pydatalog'])){
			to_return = a + " & " + b;
		}
		else if(member(lang,['cosmos','cython','vhdl','python','coconut','lua','seed7','livecode','englishscript','cython','gap','mathematical notation','genie','idp','maxima','engscript','ada','newlisp','ocaml','nim','coffeescript','pascal','delphi','erlang','rebol','php'])){
			to_return = a + " and " + b;
		}
		else if(member(lang,['common lisp','smt-lib','clips','pddl','clojure','common lisp','emacs lisp','clojure','racket'])){
			return "(and "+a+" "+b+")";
		}
		else if(member(lang,['z3py'])){
			to_return = "And("+a+" "+b+")";
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "*="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["javascript","glsl","chapel","nim","octave","coffeescript",'cython','julia',"kotlin","swift","typescript","go","php","ruby","haxe","java","c","c++","c#","perl","perl 6","visual basic .net","scala","python",'coconut'])){
			to_return = a + "*=" + b;
		}
		else if(member(lang,["lua","ada","delphi","tcl","wolfram","rebol","ocaml","picat",'maxima','r'])){
			return generate_code(input_lang,lang,indent,["set_var",a,["*",a,b]]);
		}
	}
	else if(arr[0] === "/="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["javascript","glsl",'vala',"chapel",'nim','cython','julia',"kotlin","scala","typescript","go","swift","java","c","c++","c#","perl","python",'coconut',"ruby","visual basic .net","php","coffeescript","haxe"])){
			to_return = a + "/=" + b;
		}
		else if(member(lang,["lua","ada","delphi","tcl","octave","wolfram","rebol","ocaml","picat",'maxima','r'])){
			return generate_code(input_lang,lang,indent,["set_var",a,["/",a,b]]);
		}
	}
	else if(arr[0] === "+="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		console.log(JSON.stringify(["types",a,types[a],b,types[b]]));
		if(member(lang,["javascript","bash",'python','coconut','haxe','awk',"kotlin",'visual basic .net',"java","c++","c#","c","ruby","typescript"])){
			//this is for languages that use the same operator to concatenate strings and numbers
			to_return = a + "+=" + b;
		}
		else if(member(lang,["tcl"])){
			if(types[a] === "String" || types[b] === "String"){
				to_return =  "append " + a.substring(1) + " " + b;
			}
			else if(member(types[a],["int","double","long","float"])){
				to_return = "incr " + a.substring(1) + " [expr {" + b+"}]";
			}
		}
		else if(member(lang,["lua","wolfram","rebol","ocaml","picat",'maxima','yacas','delphi','ada'])){
			//for languages that don't have the += operator
			return generate_code(input_lang,lang,indent,["set_var",a,["+",a,b]]);
		}
		else if(member(lang,["perl","php"])){
			if(types[a] === "String" || types[b] === "String"){
				to_return =  a + ".=" + b;
			}
			else if(member(types[a],["int","double","long","float"])){
				to_return =  a + "+=" + b;
			}
		}
		else if(member(types[a],["int","double","long","float",])){
			if(member(lang,['janus','octave','chapel','julia','coffeescript','visual basic','visual basic .net','nim','cython','vala','perl 6','dart','typescript','java','c','c++','c#','javascript','haxe','chapel','perl','julia','scala','rust','go','swift'])){
				to_return = a + " += " + b;
			}
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["System","out",["function_call","print",["$a"]]]]],
		[["prolog",'constraint handling rules'],["function_call","write",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["c++"])){
			to_return = "cout << "+a;
		}
		else if(member(lang,["c"])){
			if(types[a] === "String"){
				to_return = "printf(\"%s\","+a+")";
			}
			else if(types[a] === "int" || !isNaN(a)){
				to_return = "printf(\"%d\","+a+")";
			}
		}
		else if(member(lang,["c#"])){
			to_return = "Console.Write("+arr[1]+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		to_return = indent + to_return;
		types[to_return] = "void";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",[[".",["System","out"]],["function_call","println",["$a"]]]]],
		[["c#","visual basic .net"],[".",[[".",["System","Console"]],["function_call","WriteLine",["$a"]]]]],
		[["javascript","typescript","coffeescript"],[".",["console",["function_call","log",["$a"]]]]],
		[["go"],[".",["fmt",["function_call","Println",["$a"]]]]],
		[['cython','rebol','lua','ceylon','r','gosu','dart','vala','perl','php','hack','awk'],["function_call","print",["$a"]]],
		[['ruby','tcl'],["function_call","puts",["$a"]]],
		[['python','cython','coconut','haskell','common lisp'],["function_call","print",["$a"]]],
		[['prolog'],["function_call","writeln",["$a"]]],
		[['scala','julia','swift','picat','kotlin'],["function_call","println",["$a"]]],
		[['haxe'],["function_call","trace",["$a"]]],
		[['wolfram'],["function_call","Print",["$a"]]],
		[['yacas'],["function_call","Write",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,['erlang'])){
			to_return = "io:fwrite("+a+")";
		}
		else if(member(lang,["c++"])){
			to_return = "cout << "+a+"<< \"\\n\"";
		}
		else if(member(lang,["c"])){
			if(types[a] === "String"){
				to_return =  "printf(\"%s\\n\","+a+")";
			}
			else if(types[a] === "double" || !isNaN(a)){
				to_return =  "printf(\"%f\\n\","+a+")";
			}
			else if(types[a] === "int" || !isNaN(a)){
				to_return =  "printf(\"%d\\n\","+a+")";
			}
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		if(to_return !== undefined){
			to_return = indent + to_return;
		}
		types[to_return] = "void";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//takes one array as the argument
		[["javascript"],[".",[[".",["Math","apply"]],["function_call","max",[[".",["null"]],"$a"]]]]],
		[["python","cython","coconut","php"],["function_call","max",["$a"]]],
		[["yacas","wolfram"],["function_call","Max",["$a"]]],
		[["lua"],[".",["math",["function_call","max",["$a"]]]]],
		[["c#"],[".",["$a",["function_call","Max",[]]]]],
		[["ruby"],[".",["$a","max"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
		else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//takes one array as the argument
		[["javascript"],[".",[[".",["Math","apply"]],["function_call","min",[[".",["null"]],"$a"]]]]],
		[["python",'coconut',"cython","php"],["function_call","min",["$a"]]],
		[["yacas",'wolfram'],["function_call","Min",["$a"]]],
		[["lua"],[".",["math",["function_call","min",["$a"]]]]],
		[["c#"],[".",["$a",["function_call","Min",[]]]]],
		[["ruby"],[".",["$a","min"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(arr[0] === "function_call"){
		var name = arr[1];
		var params = function_call_parameters(input_lang,lang,arr[2]);
		to_return = function_call(lang,name,params);
		same_var_type(to_return,name);
	}
	else if(arr[0] === "-="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["javascript","glsl",'vala',"chapel",'nim',"coffeescript",'dart','cython','awk',"go",'julia',"kotlins","haxe","typescript","swift","picat","php","ruby","java","c","c++","c#","perl","python",'coconut',"scala","visual basic .net"])){
			to_return = a + "-=" + b;
		}
		else if(member(lang,["lua",'ada',"delphi","tcl","octave","maxima","wolfram","rebol","ocaml","picat","r","yacas"])){
			return generate_code(input_lang,lang,indent,["set_var",a,["-",a,b]]);
		}
	}
	else if(arr[0] === "%="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["java","c","php","perl"])){
			to_return = a + "%=" + b;
		}
	}
	else if(arr[0] === "&="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["c","c++","java","ruby","perl","php","haxe","javascript"])){
			to_return = a + "&=" + b;
		}
	}
	else if(arr[0] === "|="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["c","c++","java","ruby","perl","php","haxe","javascript"])){
			to_return = a + "|=" + b;
		}
	}
	else if(arr[0] === "import" && arr.length === 2){
		var name = arr[1];
		if(member(lang,['java','julia','python','coconut','d','haxe','ceylon','haskell','purescript','scala','go','groovy','picat','elm','swift','monkey x'])){
			to_return = "import "+ name;
		}
		else if(member(lang,['php'])){
			to_return = "require_once('"+name+".php')";
		}
		else if(member(lang,['lua','ruby'])){
			to_return = "require \""+name+"\"";
		}
		else if(member(lang,['prolog'])){
			to_return = ":-use_module("+name+")";
		}
		else if(member(lang,['c'])){
			to_return = "#include \""+name+".h\"";
		}
	}
	else if(arr[0] === "import_from" && arr.length === 3){
		var the_function = arr[1];
		var the_file = arr[2];
		if(member(lang,['javascript'])){
			to_return = "import "+the_function+" from "+the_file;
		}
		else if(member(lang,['python'])){
			to_return = "from "+the_function+" import "+the_file;
		}
	}
	else if(arr[0] === "++" && arr.length === 2){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,["javascript","octave","glsl","gosu",'yacas',"typescript","php","kotlin","dart","java","c","c++","c#","perl","perl 6","haxe","go","wolfram"])){
			to_return = a + "++";
		}
		else if(member(lang,["tcl"])){
			to_return = "incr " + a.substring(1);
		}
		else if(member(lang,["python",'coconut',"julia","ruby","swift","lua","visual basic .net","ruby","scala"])){
			to_return = a + " += 1";
		}
		else if(member(lang,["lua","maxima","wolfram","rebol","ocaml","picat"])){
			to_return = generate_code(input_lang,lang,indent,["set_var",a,["+",a,"1"]]);
		}
	}
	else if(arr[0] === "--"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,["javascript","glsl","perl 6","vala","gosu","octave","coffeescript",'yacas',"typescript","php","kotlin","haxe","scala","java","c","c++","c#","perl","go"])){
			to_return = a + "--";
		}
		else if(member(lang,["tcl"])){
			to_return = "incr " + a.substring(1) + " -1";
		}
		else if(member(lang,["python",'coconut','cython',"julia","ruby","swift","lua","visual basic .net","ruby","scala","chapel"])){
			to_return = a + "-= 1";
		}
		else if(member(lang,["lua","maxima","wolfram","rebol","ocaml","picat"])){
			to_return = generate_code(input_lang,lang,indent,["set_var",a,["-",a,"1"]]);
		}
	}
	else if(arr[0] === "yield"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,['c#'])){
			to_return = "yield return " + a;
		}
		else if(member(lang,['ruby','python','cython','coconut','javascript','scala'])){
			to_return = "yield " + a;
		}
		//console.log(to_return);
	}
	else if(arr[0] === "throw"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,	['javascript','dart','java','c++','swift','rebol','haxe','c#','picat','scala'])){
			to_return = "throw " + a;
		}
		else if(member(lang,['julia','r'])){
			to_return = "throw("+a+")";
		}
		else if(member(lang,['php'])){
			to_return = "throw  new Exception("+a+")";
		}
		else if(member(lang,['python','cython','coconut','ruby'])){
			to_return = "raise "+a;
		}
		else if(member(lang,['standard ml'])){
			to_return = "raise Fail "+a;
		}
		else if(member(lang,['perl','sidef'])){
			to_return = "die "+a;
		}
		//console.log(to_return);
	}
	else if(arr[0] === "return"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,	['pseudocode','octave','glsl','applescript','sidef','reasoned-php','logicjs','coconut','ats','cython','z3py','kotlin','coffeescript','systemverilog','vhdl','lua','ruby','java','seed7','xl','e','livecode','englishscript','gap','kal','engscript','pawn','ada','powershell','rust','d','ceylon','typescript','hack','autohotkey','gosu','swift','pike','objective-c','c','groovy','scala','julia','dart','c#','javascript','go','haxe','php','c++','perl','vala','rebol','awk','bc','chapel','perl 6','python'])){
			to_return = "return " + a;
		}
		else if(member(lang,['r','maxima'])){
			to_return = "return("+a+")";
		}
		else if(member(lang,['tcl'])){
			to_return = "return [expr {"+a+"}]";
		}
		//else if(member(lang,['wolfram'])){
		//	to_return = "Return["+a+"]";
		//}
		else if(member(lang,['pseudocode','visual basic','visual basic .net','autoit','monkey x'])){
			to_return = "Return " + a;
		}
		else if(member(lang,['fortran'])){
			to_return = function_name + " = " + a;
		}
		else if(member(lang,['pascal'])){
			to_return = function_name + " := " + a;
		}
		else if(member(lang,['picat'])){
			to_return = "Return = " + a;
		}
		else if(member(lang,['delphi'])){
			to_return = "Result := " + a;
		}
		else if(member(lang,['nim'])){
			to_return = "result = " + a;
		}
		else if(member(lang,['prolog', 'pddl', 'mercury', 'idris', 'coq', 'lc++', 'chr.js', 'constraint handling rules', 'yacas', 'wolfram', 'elixir', 'elm', 'sympy', 'haskell','agda','scheme','smt-lib','minizinc','logtalk','pydatalog','polish notation','reverse polish notation','mathematical notation','emacs lisp','smt-lib','erlang','standard ml','icon','oz','clips','newlisp','hy','sibilant','lispyscript','algol 68','clojure','common lisp','f#','ocaml','ml','racket','nemerle'])){
			to_return = a;
		}
		//console.log(to_return);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//convert one character to uppercase
		[['java'],[".",["Character",["function_call","toUpperCase",["$a"]]]]],
		[['c#'],[".",["Char",["function_call","ToUpper",["$a"]]]]],
		[['c','c++'],["function_call","toupper",["$a"]]],
		[['haskell'],["function_call","ToUpper",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//convert one character to lowercase
		[['java'],[".",["Character",["function_call","toLowerCase",["$a"]]]]],
		[['c','c++'],["function_call","tolower",["$a"]]],
		[['haskell'],["function_call","ToLower",["$a"]]],
		[['c#'],[".",["Char",["function_call","ToLower",["$a"]]]]],
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "char";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['php'],["function_call","md5",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "char";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//convert a string to uppercase or lowercase
		[['java','javascript','haxe','typescript','coffeescript'],[".",["$a",["function_call","toLowerCase",[]]]]],
		[['rust','picat'],[".",["$a",["function_call","to_lowercase",[]]]]],
		[['c#','visual basic .net'],[".",["$a",["function_call","ToLower",[]]]]],
		[['swift'],[".",["$a",["function_call","lowercased",[]]]]],
		[['python','cython','coconut'],[".",["$a",["function_call","lower",[]]]]],
		[['php'],["function_call","strtolower",["$a"]]],
		[['julia','rebol'],["function_call","lowercase",["$a"]]],
		[['perl'],["function_call","lc",["$a"]]],
		[['haskell'],["function_call","toLower",["$a"]]],
		[['octave','r','tcl'],["function_call","tolower",["$a"]]],
		[["lua"],[".",["string",["function_call","lower",["$a"]]]]],
		[["go"],[".",["strings",["function_call","ToLower",["$a"]]]]],
		[["wolfram"],[".",["strings",["function_call","ToLowerCase",["$a"]]]]],
		[['erlang'],["function_call","string:lowercase",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,['scala'])){
			to_return = a+".toLowerCase";
		}
		else if(member(lang,['ruby'])){
			to_return = a+".downcase";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "String";
	}
	
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//array lengths
		[['java','picat','scala','d','typescript','dart','vala','javascript','coffeescript','haxe','cobra','ruby'],[".",["$a","length"]]],
		[["python",'cython','coconut'],["function_call","len",["$a"]]],
		[["haskell","emacs lisp","scheme","racket","minizinc","julia","r","octave","seed7"],["function_call","length",["$a"]]],
		[["php"],["function_call","sizeof",["$a"]]],
		[["common lisp"],["function_call","list-length",["$a"]]],
		[["perl"],["function_call","scalar",["$a"]]],
		[["wolfram"],["function_call","Length",["$a"]]],
		[["clojure"],["function_call","count",["$a"]]]
	],matching_symbols)){
		var text = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,['java','picat','scala','d','typescript','dart','vala','javascript','haxe','cobra','ruby'])){
			to_return = text + ".length";
		}
		else if(member(lang,["c#"])){
			to_return = text + ".Length";
		}
		else if(member(lang,["python",'cython','coconut'])){
			to_return = "len(" + text + ")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols)
		}
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["$a",["function_call","size",[]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(types[a][0] === "HashMap"){
			if(member(lang, ["java","c++"])){
				to_return = a+".size()";
			}
		}
		else if(types[a][0] === "ArrayList"){
			if(member(lang, ["c#"])){
				to_return = a+"Count";
			}
			else if(member(lang,["python",'cython','coconut'])){
				to_return = "len("+a+")";
			}
		}
		types[to_return]="int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//string length
		[['java','c++','kotlin'],[".",["$a",["function_call","length",[]]]]],
		[["lua"],[".",["string",["function_call","len",["$a"]]]]],
		[["python",'cython','coconut',"fortran"],["function_call","len",["$a"]]],
		[["gambas","visual basic .net"],["function_call","Len",["$a"]]],
		[["wolfram"],["StringLength",["$a"]]],
		[['javascript',"coffeescript",'typescript','scala','gosu','picat','haxe','ocaml','d','dart','ruby'],[".",["$a","length"]]],
		[['c#','nemerle'],[".",["$a","Length"]]],
		[["racket","scheme"],["string-length",["$a"]]],
		[['minizinc','julia','perl','seed7','octave',"common lisp","haskell","coq"],["function_call","length",["$a"]]],
		[['php','c','pawn','hack'],["function_call","strlen",["$a"]]],
		[['autohotkey'],["function_call","StrLen",["$a"]]],
		[['swift'],["function_call","countElements",["$a"]]],
		[['rebol'],["function_call","length?",["$a"]]],
		[['yacas'],["function_call","Length",["$a"]]],
		[["erlang"],["function_call","string:length",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int"
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//substring of a from b to c
		[['javascript','coffeescript','typescript','java','scala','dart'],[".",["$a",["function_call","substring",["$b","$c"]]]]],
		[['c#','nemerle'],[".",["$a",["function_call","Substring",["$b","$c"]]]]],
		[['erlang'],[".",["string",["function_call","sub_string",["$a","$b","$c"]]]]],
		[['haxe','perl 6'],[".",["$a",["function_call","substr",["$b","$c"]]]]],
		[['php','awk','perl','hack'],["function_call","substr",["$a","$b","$c"]]],
		[['clojure'],["function_call","subs",["$a","$b","$c"]]],
		[['racket'],["function_call","substring",["$a","$b","$c"]]],
		[['lua'],["function_call","sub",["$a","$b","$c"]]],
		[['common lisp'],["function_call","subseq",["$a","$b","$c"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		if(member(lang,["python","cython","coconut","julia"])){
			to_return = a + "["+a+":"+b+"]"
		}
		else if(member(lang,["ruby"])){
			to_return = a + "["+a+"..."+b+"]"
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['javascript','haxe','coffeescript','typescript',],[".",["$a",["function_call","slice",["$b","$c"]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		if(member(lang,["python","cython",'coconut',"cobra","go"])){
			to_return = a + "["+b+":"+c+"]";
		}
		else if(member(lang,["ruby"])){
			to_return = a + "["+b+"..."+c+"]";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = get_type(a);
	}
	else if(arr[0] === "initialize_empty_constants"){
		if(lang === "prolog"){
			return arr[2].map(function(x){types[x] = arr[1]; return var_type(input_lang,lang,arr[1])+"("+var_name(lang,x)}).join(",")+")";
		}
		else{
			arr[2] = arr[2].map(function(x){types[x] = arr[1]; return var_name(lang,x)}).join(",");
		}
		if(member(lang, ["java"])){
			to_return = "final " + var_type(input_lang,lang,arr[1]) + " " + arr[2];
		}
		else if(member(lang, ["c","c++","c#","glsl"])){
			to_return = "const " + var_type(input_lang,lang,arr[1]) + " " + arr[2];
		}
	}
	else if(arr[0] === "initialize_empty_vars"){
		if(lang === "prolog"){
			return arr[2].map(function(x){types[x] = arr[1]; return var_type(input_lang,lang,arr[1])+"("+var_name(lang,x)}).join(",")+")";
		}
		else if(lang === "smt-lib"){
			return arr[2].map(function(x){types[x] = arr[1]; return "(declare-const " + var_name(lang,x) + " " + var_type(input_lang,lang,arr[1]) + ")"}).join("\n");
		}
		else{
			arr[2] = arr[2].map(function(x){types[x] = arr[1]; return var_name(lang,x)}).join(",");
		}
		if(member(lang, ["java","c","glsl","c++","c#","algol 68","simula"])){
			to_return = var_type(input_lang,lang,arr[1]) + " " + arr[2];
		}
		else if(member(lang, ["z3py"])){
			to_return = arr[2] + "=" + var_type(input_lang,'z3',arr[1]) + "s(" + arr[2].split(",").join(" ") + ")";
		}
		else if(member(lang, ["minizinc"])){
			to_return = "var " + arr[2]+":"+var_type(input_lang,lang,arr[1]);
		}
		else if(member(lang, ["haxe","typescript"])){
			if(var_type(input_lang,"java",arr[1]) === "Object"){
				to_return = "var " + arr[2];
			}
			else{
				to_return = "var " + arr[2]+":"+var_type(input_lang,lang,arr[1]);
			}
		}
		else if(member(lang, ["delphi"])){
			to_return = arr[2]+":"+var_type(input_lang,lang,arr[1]);
		}
		else if(member(lang, ["go"])){
			to_return = "var "+arr[2]+" "+var_type(input_lang,lang,arr[1]);
		}
		else if(member(lang, ["javascript"])){
			to_return = "var " + arr[2];
		}
		else if(member(lang, ["perl"])){
			to_return = "my " + arr[2];
		}
		else if(member(lang, ["lua","gap"])){
			to_return = "local " + arr[2];
		}
		else if(member(lang, ["python",'cython','coconut'])){
			to_return = "";
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
			[["c","tcl","php","d"],["function_call","log10",["$a"]]],
			[["c#"],[".",["Math",["function_call","Log10",["$a"]]]]],
			[["java","javascript"],[".",["Math",["function_call","log10",["$a"]]]]],
			[["lua","python","cython","coconut",'erlang'],[".",["math",["function_call","log10",["$a"]]]]]
		],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
			[["c","c++"],["function_call","log2",["$a"]]],
		],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
			//natural logarithm
			[["java","scala","javascript","haxe","ruby","typescript","coffeescript","typescript"],[".",["Math",["function_call","log",["$a"]]]]],
			[["c#","visual basic .net"],[".",["Math",["function_call","Log",["$a"]]]]],
			[["python",'cython','coconut',"lua","haskell","erlang"],[".",["math",["function_call","log",["$a"]]]]],
			[["c",'tcl',"c++","r","perl","awk","sympy","maxima","php","prolog","swift","julia","common lisp","octave"],["function_call","log",["$a"]]],
			[["autohotkey","go","wolfram"],["function_call","Log",["$a"]]],
			[["minizinc",'standard ml',"reverse polish notation","mathematical notation"],["function_call","ln",["$a"]]],
			[["yacas"],["function_call","Ln",["$a"]]],
			[["rebol"],["function_call","log-e",["$a"]]],
			[['perl 6'],[".",["$a","log"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[[["java"],[".",["Integer",["function_call","parseInt",["$a"]]]]]],matching_symbols)){
		to_return = type_conversion(input_lang,lang,"String","int", generate_code(input_lang,lang,indent,matching_symbols["$a"]));
	}
	else if(member(input_lang, ["java"]) && matches_pattern(arr,[".",["Boolean",["function_call","valueOf",["$a"]]]],matching_symbols) || matches_pattern(arr,[".",["Boolean",["function_call","parseBoolean",["$a"]]]],matching_symbols)){
		to_return = type_conversion(input_lang,lang,"String","boolean", generate_code(input_lang,lang,indent,matching_symbols["$a"]));
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[[["java"],[".",["Double",["function_call","parseDouble",["$a"]]]]]],matching_symbols)){
		to_return = type_conversion(input_lang,lang,"String","double", generate_code(input_lang,lang,indent,matching_symbols["$a"]));
	}
	else if(member(input_lang, ["java"]) && matches_pattern(arr,[".",["Integer",["function_call","toString",["$a"]]]],matching_symbols) || matches_pattern(arr,[".",["String",["function_call","valueOf",["$a"]]]],matching_symbols)){
		to_return = type_conversion(input_lang,lang,"int","String", generate_code(input_lang,lang,indent,matching_symbols["$a"]));
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['java'],["new",["HashMap",["$a","$b"]],[]]]
	],matching_symbols)){
		var a = var_type(input_lang,lang,matching_symbols["$a"]);
		var b = var_type(input_lang,lang,matching_symbols["$b"]);
		return generate_code(input_lang,lang,indent,["associative_array",a,b,[]]);
	}
		else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['wolfram'],["function_call","Det",["$a"]]],
		[['maxima'],["function_call","determinant",["$a"]]],
		[['sympy'],[".",["$a",["function_call","det",[]]]]],
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	// see http://rosettacode.org/wiki/Real_constants_and_functions
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","javascript","coffeescript","typescript","haxe"],[".",["Math",["function_call","abs",["$a"]]]]],
		[["c#","f#"],[".",["Math",["function_call","Abs",["$a"]]]]],
		[["lua"],[".",["math",["function_call","abs",["$a"]]]]],
		[["vala"],[".",["$a",["function_call","abs",[]]]]],
		[["go","wolfram","yacas"],["function_call","Abs",["$a"]]],
		[['ruby','perl 6'],[".",["$a","abs"]]],
		[['c','standard ml','octave','haskell','common lisp','reverse polish notation','rebol','c++','julia','tcl','perl','php','python','cython','coconut','erlang','prolog','swift','frink'],["function_call","abs",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,['mathematical notation'])){
			to_return = "|"+output+"|";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript","coffeescript","typescript","java","haxe"],[".",["$a",["function_call","filter",["$b"]]]]],
		[["haskell","python",'cython','coconut'],["function_call","filter",["$b","$a"]]],
		[["php"],["function_call","array_filter",["$a","$b"]]],
	],matching_symbols)){
		var arr = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var callback = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		//types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript","coffeescript","java","haxe"],[".",["$a",["function_call","map",["$b"]]]]],
		[["c#"],[".",["$a",["function_call","Select",["$b"]]]]],
		[["php"],["function_call","array_map",["$b","$a"]]],
		[["haskell","python",'cython','coconut',"perl","julia"],["function_call","map",["$b","$a"]]],
	],matching_symbols)){
		var arr = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var callback = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		//types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript","coffeescript","typescript"],[".",["$a",["function_call","reduce",["$b"]]]]],
		[["haxe"],[".",["$a",["function_call","fold",["$b","0"]]]]],
		[["swift"],[".",["$a",["function_call","reduce",["0","$b"]]]]],
		[["ruby"],[".",["$a",["function_call","inject",["0","$b"]]]]],
		[["rust","kotlin"],[".",["$a",["function_call","fold",["0","$b"]]]]],
		[["php"],["function_call","array_reduce",["$b","$a"]]],
		[["python",'coconut'],["function_call","reduce",["$b","$a"]]],
		[["haskell"],["function_call","fold",["$b","$a"]]],
		[["scheme"],["function_call","fold-left",["$b","0","$a"]]],
		[["r"],["function_call","reduce",["$b","$a","0"]]],
		[["maxima"],["function_call","reduce",["$b","$a","0"]]],
	],matching_symbols)){
		var arr = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var callback = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		//types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//right fold
		[["scheme"],["function_call","fold-right",["$b","0","$a"]]],
		[["haskell"],["function_call","foldr",["$b","0","$a"]]],
		[["maxima"],["function_call","rreduce",["$b","$a","0"]]],
		[["oz"],["function_call","fold-right",["$a","$b","0"]]]
	],matching_symbols)){
		var arr = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var callback = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		//types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//floor function
		[["java","javascript","coffeescript","typescript","haxe"],[".",["Math",["function_call","floor",["$a"]]]]],
		[["python",'coconut',"lua","erlang"],[".",["math",["function_call","floor",["$a"]]]]],
		[["c#",'visual basic .net'],[".",["Math",["function_call","Floor",["$a"]]]]],
		[['c','standard ml','reverse polish notation','tcl','minizinc','c++','perl','php','pl/i','octave','prolog','swift','perl'],["function_call","floor",["$a"]]],
		[['go','wolfram','yacas','autohotkey'],["function_call","Floor",["$a"]]],
		[['haskell','common lisp','julia','yacas'],["function_call","floor",["$a"]]],
		[['rebol'],["function_call","round/floor",["$a"]]],
		[['ruby','perl 6'],[".",[["$a"],"floor"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		// pick random from array
		// See here: https://rosettacode.org/wiki/Pick_random_element
		[['ruby'],[".",["$a","sample"]]],
		[['php'],["function_call","array_rand",["$a"]]],
		[["python",'coconut'],[".",["random",["function_call","sample",["$a"]]]]],
		[["julia"],["function_call","rand",["$a"]]],
		[["wolfram"],["function_call","RandomChoice",["$a"]]],
		[["r"],["function_call","sample",["$a","1"]]],
		[["falcon"],["function_call","randomPick",["$a","1"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		member(lang,['javascript','coffeescript','typescript']) && (to_return = a + "[Math.floor(Math.random() * " + a + ".length)]")
		|| lang === 'erlang' && (to_return = "lists:nth(random:uniform(length("+a+")),"+a+")")
		|| lang === 'lua' && (to_return = a + "[math.random(#"+a+")]")
		|| (to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols));
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","javascript","coffeescript",'typescript',"haxe"],[".",["Math",["function_call","round",["$a"]]]]],
		[["c#","visual basic .net"],[".",["Math",["function_call","Round",["$a"]]]]],
		[["yacas"],["function_call","Round",["$a"]]],
		[["prolog",'standard ml','reverse polish notation',"julia","tcl",'minizinc',"php","c","c++","perl","haskell","python",'coconut',"octave","yacas","rebol","frink"],["function_call","round",["$a"]]],
		[['ruby','perl 6'],[".",["$a","round"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["wolfram"],
			["function_call","LaplaceTransform",["$a","$b","$c"]]],
		[['maxima'],
			["function_call","laplace",["$a","$b","$c"]]],
		[['sympy'],
			["function_call","laplace_transform",["$a","$b","$c"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['sympy'],
			["function_call","fourier_transform",["$a","$b","$c"]]],
		[["wolfram"],
			["function_call","FourierTransform",["$a","$b","$c"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['sympy'],
			["function_call","InverseFunction",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//derivative of a function
		//$a is the expression, $b is the variable
		[['sympy','maxima','maple','reduce'],
			["function_call","diff",["$a","$b"]]],
		[["wolfram"],
			["function_call","D",["$a","$b"]]]
	],matching_symbols)){
		if(lang === "mathematical notation"){
			var expression = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
			var variable = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
			to_return = "d/d"+b+"("+a+")"
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//indefinite integral
		[['maxima','sympy'],
			["function_call","integrate",["$a","$b"]]],
		[['maple','reduce'],
			["function_call","int",["$a","$b"]]],
		[["wolfram"],
			["function_call","Integrate",["$a","$b"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//cartesian product
		[['wolfram'],
			["function_call","CartesianProduct",["$a","$b"]]],
		[['racket'],
			["function_call","cartesian_product",["$a","$b"]]],
		[['python'],
			[".",["itertools",["function_call","product",["$a","$b"]]]]],
		[['ruby'],
			[".",["$a",["function_call","product",["$b"]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(lang === "perl 6"){
			to_return = a + " X " + b;
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//definite integral
		[['maxima'],
		["function_call","integrate",["$a","$b","$c","$d"]]],
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		var d = generate_code(input_lang,lang,indent,matching_symbols["$d"]);
		if(lang === "sympy"){
			to_return = "integrate(" + a + ", (" + b +","+ c +","+ d + "))";
		}
		else if(lang === "wolfram"){
			to_return = "Integrate[" + a + ", {" + b +","+ c +","+ d + "}]";
		}
		else if(lang === "tex"){
			to_return = "int_" + c + "^" + d +" "+ a +";\mathrm{d}"+b;
		}
		else if(lang === "maple"){
			to_return = "int(" + a + ", " + b +"="+ c +".."+ d + ")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['maple'],
			["function_call","CrossProduct",["$a","$b"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['maple'],
			["function_call","DotProduct",["$a","$b"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["wolfram",'sympy'],
			["function_call","TensorProduct",["$a","$b"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['prolog'],
			["function_call","append",["$a","$b","$c"]]],
		[['reasoned-php'],
			["function_call","appendo",["$a","$b","$c"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['wolfram'],
			["function_call","Variance",["$a"]]],
		[['r'],
			["function_call","var",["$a"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['wolfram'],
			["function_call","StandardDeviation",["$a"]]],
		[['r'],
			["function_call","sd",["$a"]]]
		]
	,matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(member(arr[0],["statements"])){
		return statements(input_lang,lang,indent,arr);
	}
	else if(arr[0] === "class_statements"){
		//console.log("class statements: " + JSON.stringify(arr));
		return arr[1].map(function(a){
			return generate_code(input_lang,lang,indent,a);
		}).join("");
	}
	else if(arr[0] === "top_level_statements"){
		if(member(lang,['picat','erlang','coq','english','prolog','constraint handling rules','logtalk','erlang,','mercury'])){
			var a = arr[1].map(function(a1){
				return generate_code(input_lang,lang,indent,a1);
			});
			return a.join(". ")+".";
		}
		else if(member(lang,['english'])){
			var a = arr[1].map(function(a1){
				return generate_code(input_lang,lang,indent,a1);
			});
			return a.join(".\n")+".";
		}
		else if(member(lang,['tex'])){
			var a = arr[1].map(function(a1){
				return generate_code(input_lang,lang,indent,a1);
			});
			return a.join(" \\newline ");
		}
		if(member(lang,['minizinc','maxima','ocaml'])){
			var a = arr[1].map(function(a1){
				return generate_code(input_lang,lang,indent,a1);
			});
			return a.join("; ")+";";
		}
		else{
			return statements(input_lang,lang,indent,arr);
		}
	}
	
	if(to_return === ""){
		return to_return;
	}
	else if(to_return !== undefined){
		if(!member(input_lang,["php","prolog","pddl","mathematical notation","reverse polish notation","wolfram","english","ruby","haskell","constraint handling rules","clips","prolog","lua","javascript","jison"]) && types[to_return] == undefined && !is_a_statement(arr[0])){
				throw arr[0] + ", The type of " + to_return + " is not yet defined"; 
		}
		else{
			if(is_a_statement(arr[0]) && !is_semicolon_statement(arr[0])){
				to_return = indent + to_return;
			}
			return to_return;
		}
	}
	else if(typeof(arr) === "string"){
		return arr;
	}
	else{
		throw ("Can't generate code for:\n"+JSON.stringify(arr)+" in "+lang);
	}
}

function is_a_statement(the_statement){
	return is_semicolon_statement(the_statement) || member(the_statement,["overload_operator","struct","interface","unless","default","case","switch","async_function","named_parameter","static_overload_operator","instance_overload_operator","class_extends","constructor","defrule","grammar_macro","predicate","grammar_statement","foreach_with_index","function","else","else if","elif","if","if_statement","instance_method","static_method","class","while","for","foreach"]);
}

function is_semicolon_statement(the_statement){
	return member(the_statement,["initialize_var","initialize_empty_constants","yield","initialize_static_instance_var","initialize_instance_var","initialize_instance_var_with_value","initialize_static_instance_var_with_value","++","--","+=","-=","*=","/=","return","set_var","set_array_size","initialize_empty_constants","throw","continue","break","import","initialize_empty_vars","return"])
}

function parse_lang(input_lang,output_lang,input_text){
	input_lang = input_lang.trim().toLowerCase();
	output_lang = output_lang.trim().toLowerCase();
	var to_return;
	if(member(input_lang,["detect language",""])){
		for(var lang of Object.keys(parsers)){
			try{
				to_return = parse_lang_(lang,output_lang,input_text)
			}
			catch(e){console.log(e);console.log("The language isn't "+lang);}
		}
	}
	else{
		to_return = parse_lang_(input_lang,output_lang,input_text);
	}
	return to_return;
}

function parse_lang_(input_lang,output_lang,input_text){
	var parsed_text;
	if(parsers.hasOwnProperty(input_lang)){
		parsed_text = parsers[input_lang].parse(input_text);
	}
	else if(input_lang === "english"){
		parsed_text = understand_text(input_text);
	}
	else{
		throw "Input language \""+input_lang+"\" not recognized";
	}
	
	//clear var types before generating code
	Object.keys(types).forEach(function (prop) {
		delete types[prop];
	});
	
	var generated_code = generate_code(input_lang,output_lang,"\n",parsed_text);
	//console.log(types);
	
	return generated_code;
}

function type_conversion(input_lang,lang,type1, type2, expr){
		var to_return;
		if(member(lang,["python",'coconut',"swift"])){
			to_return = var_type(input_lang,lang,type2) +"("+expr+")";
		}
		else if(member(lang,["perl"])){
			var equivalent_types = ["int",'double','float','String','boolean'];
			member(type1, equivalent_types) && member(type2, equivalent_types)
				&& (to_return = expr);
		}
		else if(member(lang,["javascript"])){
			(type2 === "String")
				&& (type1 === "int")
					&& (to_return = "("+expr+").toString()")
			|| member(type2,["int","double","float"])
				&& (type1 === "String")
					&& (to_return = "Number("+expr+")");
		}
		else if(member(lang,["vala"])){
			member(type2,["int"])
				&& (type1 === "String")
					&& (to_return = "int.parse("+expr+")");
		}
		else if(member(lang,["ruby"])){
			member(type2,["int","double","float"])
				&& (type1 === "String")
					&& (to_return = expr+".to_i");
		}
		else if(member(lang,["php"])){
			member(type2,["int"])
				&& (type1 === "String")
					&& (to_return = "(int)("+expr+")");
		}
		else if(member(lang,["c#"])){
			(type2 === "int")
				&& (to_return ="Convert.ToInt32("+expr+")")
			|| (type2 === "double")
				&& (to_return ="Convert.ToDouble("+expr+")")
			|| (type2 === "boolean")
				&& (to_return ="Convert.ToBoolean("+expr+")")
			|| (type2 === "String")
				&& (to_return ="Convert.ToString("+expr+")");
		}
		else if(member(lang,["rebol"])){
			(type2 === "int")
				&& (to_return ="to Integer! "+expr)
			||
			type2 === "String"
				&& (to_return ="to-string "+expr)
			|| member(type2,["double","float"])
				&& (to_return ="to-decimal "+expr);
		}
		else if(member(lang,["haskell"])){
			member(type2,["int","float"]) && (to_return ="(read "+expr+")");
		}
		else if(member(lang,["erlang"])){
			member(type2,["int"]) && type1 === "String"
				&& (to_return ="list_to_integer("+expr+")")
			|| member(type2,["String"]) && type1 === "int"
				&& (to_return ="integer_to_list("+expr+")");
		}
		else if(member(lang,["octave"])){
			member(type2,["int"]) && type1 === "String"
				&& (to_return ="base2dec("+expr+",10)")
			| member(type2,["String"]) && type1 === "int"
				&& (to_return ="dec2base("+expr+",10)");
		}
		else if(member(lang,["c++"])){
			(type1 === "String"
				&& type2 === "int"
					&& (to_return ="std::stoi("+expr+")")
				|| type2 === "double"
					&& (to_return ="std::stod("+expr+")"))
			|| (member(type1,["double","int"]) && type2 === "String" &&
				(to_return ="std::to_string("+expr+")"));
		}
		else if(member(lang,["java"])){
			(type1 === "String")
				&& (type2 === "int"
					&& (to_return ="Integer.parseInt("+expr+")")
				||
				type2 === "double"
					&& (to_return = "Double.parseDouble("+expr+")")
				||
				type2 === "boolean"
					&& (to_return ="Boolean.valueOf("+expr+")"))
			|| (type1 === "int"
				&& type2 === "String"
					&& (to_return ="Integer.toString("+expr+")"));
		}
		else if(member(lang,["kotlin"])){
			(type1 === "String")
				&& (type2 === "int"
					&& (to_return = expr + ".toInt()"))
			||
			(type1 === "int")
				&& (type2 === "String"
					&& (to_return = expr + ".toString()"));
		}
		if(to_return === undefined){
			throw "type_conversion from "+type1+" to "+type2+" is not defined for " + lang;
		}
		else{
			types[to_return] = type2;
			return to_return;
		}
}

function while_loop(lang,arr1,arr2,indent){
	if(member(lang,['c','glsl','typescript','perl 6','katahdin','chapel','ooc','processing','pike','kotlin','pawn','powershell','hack','gosu','autohotkey','ceylon','d','typescript','actionscript','nemerle','dart','swift','groovy','scala','java','javascript','php','c#','perl','c++','haxe','r','awk','vala'])){
		return "while(" + arr1 + "){" + arr2 + indent + "}";
	}
	else if(member(lang,['go','autohotkey'])){
		return "for " + arr1 + "{" + arr2 + indent+ "}";
	}
	else if(member(lang,['algol 68'])){
		return "while " + arr1 + " do" + arr2 + indent+ "od";
	}
	else if(member(lang,['ada'])){
		return "while " + arr1 + " loop " + arr2 + indent+ "end loop;";
	}
	else if(member(lang,['tcl'])){
		return "while{" + arr1 + "}{" + arr2 + indent + "}";
	}
	else if(member(lang,['rust','frink','dafny'])){
		return "for " + arr1 + "{" + arr2 + indent+ "}";
	}
	else if(member(lang,["yacas"])){
		return "While (" + a + ") [" + b + indent +"];";
	}
	else if(member(lang,["rebol"])){
			return "while[" + arr1 + "] [" + arr2 + indent+ "]";
	}
	else if(member(lang,["python",'coconut',"cython","nim"])){
		return "while " + arr1 + ":" + arr2;
	}
	else if(member(lang,["coffeescript"])){
		return "while " + arr1 + arr2;
	}
	else if(member(lang,['visual basic','visual basic .net','vbscript'])){
		return "While " + arr1 + arr2 + indent + "End While";
	}
	else if(member(lang,['wolfram'])){
		return "While[" + arr1 +","+ arr2 + indent + "]";
	}
	else if(member(lang,['yacas'])){
		return "While(" + arr1 +") ["+ arr2 + indent + "]";
	}
	else if(member(lang,["lua","ruby"])){
		return "while " + arr1 + " do " + arr2 + indent + "end";
	}
	else if(member(lang,["octave"])){
		return "while(" + arr1 + ")" + arr2 + indent + "end";
	}
	else if(member(lang,["delphi"])){
		return "while " + arr1 + " do " + arr2 + indent + "end";
	}
	else if(member(lang,["maxima"])){
		return "while " + arr1 + " do (" + arr2 + indent + ")";
	}
	else if(member(lang,["gap"])){
		return "while " + arr1 + " do " + arr2 + indent + "od;";
	}
	else if(member(lang,["ocaml"])){
		return "while " + arr1 + " do " + arr2 + indent + "done";
	}
	else if(member(lang,["julia","picat"])){
		return "while " + arr1 + arr2 + indent + "end";
	}
}

function substring_(lang,a,b,c){
		if(member(lang,['javascript','coffeescript','typescript','java','scala','dart'])){
			return a+".substring("+b+","+c+")";
		}
		else if(member(lang,['c#','nemerle'])){
			return a+".Substring("+b+","+c+"-"+b+"+1)";
		}
		else if(member(lang,['perl'])){
			return "substr("+a+","+b+","+c+"-"+b+"+1)";
		}
		else if(member(lang,['lua'])){
			return a+".sub("+b+"+1,"+c+"+1)";
		}
		else if(member(lang,['haxe'])){
			return a+".substr("+b+","+c+")";
		}
		else if(member(lang,["python",'coconut','cython','icon','go'])){
			return a+"["+b+":"+c+"]";
		}
		else if(member(lang,['pike','groovy','nim'])){
			return a+"["+b+".."+c+"]";
		}
}

function array_contains(lang,a1,a2){
		if(member(lang,['python','coconut','julia','minizinc'])){
			return "("+a1+" in "+a2+")";
		}
		else if(member(lang,["javascript","typescript"])){
			return "("+a1+".indexOf("+a2+")!==-1)";
		}
		else if(member(lang,["coffeescript"])){
			return "("+a1+".indexOf("+a2+")!=-1)";
		}
		else if(member(lang,['haskell'])){
                return "(elem "+a1+" "+a2+")";
		}
		else if(member(lang,['coq'])){
                return "(In "+a1+" "+a2+")";
		}
		else if(member(lang,['wolfram'])){
                return "MemberQ["+a1+","+a2+"]";
		}
		else if(member(lang,['swift'])){
                return a1+".contains("+a2+")";
		}
		//else if(member(lang,['visual basic .net'])){
        //        return a1+".Contains("+a2+")";
		//}
		else if(member(lang,['perl'])){
                return "("+a1+" ~~ "+a2+")";
		}
		else if(member(lang,['rebol'])){
                return ["not",ws_,"none?",ws_,"find",ws_,a1,ws_,a2].join("");
        }
        else if(member(lang,['java'])){
                return [a1,ws,".",ws,"contains",ws,"(",ws,a2,ws,")"].join("");
        }
        else if(member(lang,['php'])){
                return ["in_array",ws,"(",ws,a1,ws,",",ws,a2,ws,")"].join("");
        }
        else if(member(lang,['prolog','minizinc'])){
                return ["member",ws,"(",ws,a2,ws,",",ws,a1,ws,")"].join("");
        }
        else if(member(lang,['reasoned-php'])){
                return ["membero",ws,"(",ws,a2,ws,",",ws,a1,ws,")"].join("");
        }
        else if(member(lang,['lua'])){
               return [a1,ws,"[",ws,a2,ws,"]",ws,"~=",ws,"nil"].join("");
        }
		else if(member(lang,['haxe'])){
			return ["Lambda",ws,".",ws,"has",ws,"(",ws,a1,ws,",",ws,a2,ws,")"].join("");
        }
        else if(member(lang,['ruby'])){
			return [a1,ws,".",ws,"include?",ws,"(",ws,a2,ws,")"].join("");
        }
        else if(member(lang,['c#'])){
		//	return [a1,ws,".",ws,"Contains",ws,"(",ws,a2,ws,")"].join("");
			return "(Array.indexOf("+a1+","+a2+") > -1)";
		}
		else if(member(lang,['c++'])){
			return ["(",ws,"std",ws,"::",ws,"find",ws,"(",ws,"Std",ws,"(",ws,a1,ws,")",ws,",",ws,"std",ws,"::",ws,"end",ws,"(",ws,a1,ws,")",ws,",",ws,a2,ws,")",ws,"!=",ws,"std",ws,"::",ws,"end",ws,"(",ws,a1,ws,")",ws,")"].join("");
		}
}

function matching_patterns(pattern_array,input_lang,lang,arr,patterns,matching_symbols){
	for(let pattern of patterns){
		if(member(input_lang, pattern[0]) &&  matches_pattern(arr,pattern[1],matching_symbols)){
			for(let pattern1 of patterns){
				if(member(lang, pattern1[0])){
					pattern_array.value = pattern1[1];
				}
			}
			return true;
		}
	}
	return false;
}

function unparse(input_lang,lang,indent,pattern_array,matching_symbols){
	//console.log("unparse " + JSON.stringify(pattern_array));
	//console.log("unparse " + JSON.stringify(matching_symbols));
	if(pattern_array.length === 1 && typeof(pattern_array[0]) === "string"){
		return pattern_array[0];
	}
	else if(pattern_array[0] === "." && pattern_array.length === 2){
		var dot_separator;
		if(member(lang,["erlang","prolog","logtalk"])){
			dot_separator = ":";
		}
		else if(lang === 'clojure'){
			dot_separator = "/";
		}
		else{
			dot_separator = ".";
		}
		return pattern_array[1].map(function(x){
			return unparse(input_lang,lang,indent,x,matching_symbols);
		}).join(dot_separator);
	}
	else if(pattern_array[0] === "function_call"){
		var name = pattern_array[1];
		var params = function_call_parameters(input_lang,lang,pattern_array[2].map(function(x){
			return unparse(input_lang,lang,indent,x,matching_symbols)
		}));
		return function_call(lang,name,params);
	}
	else if(pattern_array in matching_symbols){
		return generate_code(input_lang,lang,indent,matching_symbols[pattern_array]);
	}
	else if(typeof pattern_array === 'string'){
		return pattern_array;
	}
	else{
		throw("unparse is not defined for "+JSON.stringify(pattern_array) +" in "+lang);
	}
}

function function_call(lang, name, params){
	if(member(lang,['c','tex','sidef','z3py','constraint handling rules','prolog','visual basic .net','english_temp','sympy','lua','cython','definite clause grammars','python','coconut','ruby','logtalk','nim','seed7','gap','mathematical notation','chapel','elixir','janus','perl 6','pascal','rust','hack','katahdin','minizinc','pawn','aldor','picat','d','genie','ooc','pl/i','delphi','standard ml','rexx','falcon','idp','processing','maxima','swift','boo','r','matlab','autoit','pike','gosu','awk','autohotkey','gambas','kotlin','nemerle','engscript','groovy','scala','coffeescript','julia','typescript','fortran','octave','c++','go','cobra','vala','f#','java','ceylon','erlang','c#','haxe','javascript','dart','bc','visual basic','php','perl'])){
		return name + "("+params+")";
	}
	else if(member(lang,["peg.js"])){
		return params+":"+name;
	}
	else if(member(lang,["wolfram"])){
		return name+"["+params+"]";
	}
	else if(member(lang,['haskell','clips','pddl','ocaml','smt-lib','smt-lib','clips','clojure','common lisp','clips','racket','scheme'])){
		return "(" + name + " " + params + ")";
	}
	else if(member(lang,['rebol'])){
		return name + " " + params;
	}
	else if(member(lang,['reverse polish notation'])){
		return params + " " + name;
	}
}
