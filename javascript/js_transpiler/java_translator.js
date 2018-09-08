"use strict";
var types = {};
var defined_vars = [];
var global_vars = [];
var function_name;
var is_recursive;
var retval;
var function_params = {};
var param_index = 0;
var grammar_num=0;
var grammar_vars="";
var first_case = true;
var switch_stack = [];
var ws = "";
var ws_ = " ";
var class_name = "";
var type_parameters = [];

function is_declarative_language(lang){
	return member(lang,["erlang","smt-lib","mathematical notation","haskell","prolog","logtalk","minizinc","reverse polish notation"]);
}

function file_extension(lang){
	if(lang === "c++"){
		return "cpp";
	}
	else if(lang === "clips"){
		return "clp";
	}
	else if(lang === "txl"){
		return "txl";
	}
	else if(lang === "autohotkey"){
		return "ahk";
	}
	else if(lang === "fortran"){
		return "f90";
	}
	else if(lang === "julia"){
		return "jl";
	}
	else if(lang === "coq"){
		return "v";
	}
	else if(lang === "picat"){
		return "pi";
	}
	else if(lang === "php"){
		return "php";
	}
	else if(lang === "wolfram"){
		return "wl";
	}
	else if(lang === "erlang"){
		return "erl";
	}
	else if(lang === "kotlin"){
		return "kts";
	}
	else if(lang === "pddl"){
		return "pddl";
	}
	else if(lang === "standard ml"){
		return "sml";
	}
	else if(lang === "thrift"){
		return "thrift";
	}
	else if(lang === "alt-ergo"){
		return "why";
	}
	else if(lang === "go"){
		return "go";
	}
	else if(lang === "racket"){
		return "rkt";
	}
	else if(lang === "glsl"){
		return "clp";
	}
	else if(lang === "clojure"){
		return "clj";
	}
	else if(lang === "ada"){
		return "ada";
	}
	else if(lang === "rust"){
		return "rust";
	}
	else if(lang === "scala"){
		return "scala";
	}
	else if(lang === "c"){
		return "c";
	}
	else if(lang === "smt-lib"){
		return "smt2";
	}
	else if(member(lang,["octave","matlab"])){
		return "m";
	}
	else if(lang === "seed7"){
		return "s7i";
	}
	else if(member(lang,["rebol","r"])){
		return "r";
	}
	else if(lang === "javascript"){
		return "js";
	}
	else if(lang === "swift"){
		return "swift";
	}
	else if(lang === "common lisp"){
		return "lisp";
	}
	else if(lang === "java"){
		return "js";
	}
	else if(lang === "ruby"){
		return "rb";
	}
	else if(lang === "visual basic .net"){
		return "vb";
	}
	else if(lang === "haxe"){
		return "hx";
	}
	else if(lang === "lua"){
		return "lua";
	}
	else if(lang === "typescript"){
		return "ts";
	}
	else if(lang === "minizinc"){
		return "mzn";
	}
	else if(lang === "haskell"){
		return "hs";
	}
	else if(lang === "c#"){
		return "cs";
	}
	else if(member(lang,["perl","prolog","constraint handling rules"])){
		return "pl";
	}
	else if(member(lang,["jison"])){
		return "jison";
	}
	else if(member(lang,["maxima"])){
		return "mc";
	}
	else if(member(lang,["coffeescript"])){
		return "coffee";
	}
	else if(member(lang,["python"])){
		return "py";
	}
	else if(member(lang,["mysql"])){
		return "sql";
	}
	else if(member(lang,["protobuf"])){
		return "proto";
	}
	else{
		alert("Unknown file extension for "+lang+"!");
	}
}

var parsers =
		{
			"english":english_parser,
			"java":java_parser,
			"kotlin":kotlin_parser,
			"javascript":javascript_parser,
			"delphi":delphi_parser,
			"fortran":fortran_parser,
			"standard ml":standard_ml_parser,
			"thrift":thrift_parser,
			"protobuf":protobuf_parser,
			"mysql":mysql_parser,
			"glsl":glsl_parser,
			"r":r_parser,
			"pseudocode":pseudocode_parser,
			"swift":swift_parser,
			"octave":octave_parser,
			"smt-lib":smt_lib_parser,
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
			"racket":racket_parser,
			"clojure":clojure_parser,
			"clips":clips_parser,
			"julia":julia_parser,
			"php":php_parser,
			"jison":jison_parser,
			"picat":picat_parser,
			"regex":regex_parser,
			"antlr":antlr_parser,
			"txl":txl_parser,
			"c":c_parser,
			"haxe":haxe_parser,
			"perl":perl_parser,
			"constraint handling rules":prolog_parser,
			"pddl":pddl_parser
		};

function parse_multiple(input_text,langs){
	var i;
	try{
		for(i = 0; i < langs.length-1; i++){
			//alert("Translating "+input_text + " from " + langs[i] + " to " + langs[i+1]);
			input_text = parse_lang(langs[i],langs[i+1],input_text);
		}
	}
	catch(e){
		alert("Could not translate "+input_text+" from " + langs[i] + " to " + langs[i+1]);
	}
}

function parse_multiples(input_texts, langs){
	for(var i = 0; i < input_texts.length; i++){
		parse_multiple(input_texts[i],langs);
	}
	for(var lang of Object.keys(parsers)){
		//file_extension(lang);
	}
}

parse_multiples([
	"public static void var_example(){boolean i = 1 == 3;}",
	"public static void print_example(int to_print){System.out.println(to_print);}",
	"public static void loop_example(){int[] i = {1,2,3}; for(int j:i){System.out.println(j);}}"
	],["java","mathematica","lua"]);

function test_examples(){
	var lang1;
	var inputText;
	var output_array = "";
	var test_cases = [
			//["function_example(A,B) :- [A|B] = C.","prolog","list head tail"],
			["int a[3];","java","initialize array size"],
			["a = file_exists(\"sample.txt\")","lua","check if file exists"],
			["boolean regexMatch = Pattern.matches(\"str1\",\"str2\");","java","check if string matches regex"],
			["$myfile = fopen(\"webdictionary.txt\", \"r\"); fclose($myfile);","php","open and close text file"],
			["System.out.println(1);","java","print with newline"],
			["System.out.print(1);","java","print without newline"],
			["struct point {int x; int y;};","c","struct"],
			["function_example(A) :- var(A).","prolog","check if variable is defined"],
			["function_example(A) :- nonvar(A).","prolog","check if variable is defined"],
			["function_example(A) :- integer(A).","prolog","check if variable is integer"],
			["function_example(A) :- number(A).","prolog","check if variable is number"],
			["function_example(A,B) :- number_codes(A,B).","prolog","convert string to integer"],
			["function_example(A,B,C) :- append(A,B,C).","prolog","concatenate string or array"],
			["function_example(A,B) :- findall(A,B,C).","prolog","list comprehension"],
			["function_example(A,B,C) :- nth0(A,B,C).","prolog","list comprehension"],
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
			["var numbers = [0, 1, 2, 3]; var result = numbers.reduce(function(accumulator, currentValue) {return accumulator + currentValue;});","javascript",'array reduce'],
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
		output_array += "These are not defined for "+get_lang(lang1)+":\n"
		var search_query = [];
		for(var j = 0; j < test_cases.length;j++){
			try{
				//console.log(lang1);
				//alert(j);
				
				//clear var types before generating code
				Object.keys(types).forEach(function (prop) {
					delete types[prop];
				});
				Object.keys(type_parameters).forEach(function (prop) {
					delete type_parameters[prop];
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
	input = "farther means further. A is more close to B means A is closer to B. A is more distant from B means A is further from B. nearer means closer. distance from X to Y means distance between X and Y. one means 1. two means 2. three means 3. four means 4. five means 5. six means 6. seven means 7. eight means 8. nine means 9. ten means 10. eleven means 11. twelve means 12. thirteen means 13. fourteen means 14. fifteen means 15. sixteen means 16. seventeen means 17. eighteen means 18. nineteen means 19. twenty means 20. thirty means 30. forty means 40. fifty means 50. sixty means 60. seventy means 70. eighty means 80. ninety means 90. every means each. A who is B means A that is B. A which is B means A that is B. each A in B that is C means each A in B where A is C. the A means A. inside means in. but means and. identical means equal. the A that is in B means A in B. average of A means mean{A}. A is different from B means A does not equal B. smallest number in A means min{A}. largest number in A means max{A}. although means and. yet means and. A is as much as B means A == B. A is as old as B means age of A == age of B. A is as young as B means A is as old as B. A has the same B as C means B of A == B of C. A and B have the same C means A has the same C as B. A and B have a different C means (C of A) is different from (C of B). integral of A with respect to B means integrate{A,B}. sum of A and B means A+B. product of A and B means A*B. derivative of A with respect to B means derivative{A,B}. reciprocal of A means 1/(A). A plus B means A+B. A minus B means A-B. arctangent of A means tanh{A}. arcsine of A means sinh{A}. arccosine of A means acos{A}. greater means more. A or B means A || B. A and B means A && B. A is greater than B means A > B. A is less than B means A < B. square root of A means sqrt{A}. A is not more than B means A <= B. A is not less than B means A >= B. sine of A means sin{A}. cosine of A means cos{A}. tangent of A means tan{A}. A does not equal B means A != B. A equals B means A == B. A is equal to B means a equals B. A is not B by C means ((A is B by C) == false). A is divisible by B means (A%B == 0). absolute value of A means abs{A}. function factorial(a)\{ if(a == 1) return 1; else return a*factorial{a-1};\} factorial of A means factorial{A}. A percent of B means (A*B*0.01). A is a parent of B means B is a child of A. A is a superset of B means B is a subset of A. Y is a factor of X means X is divisible by Y. X is an odd number means X is not divisible by 2. X is an odd-number means X is an odd number. X is an even number means X is divisible by 2. X is a perfect-square means (square root of X) is an integer. A is false means A == false. A is not an B means (A is an B) is false. A is not a B means (A is a B) is false. X is an integer means type{X} == int. X is a string means type{X} == string. A is a boolean means type{X} == boolean. add A to B means B += A. subtract A from B means B -= A. multiply A by B means A *= B. divide A by B means A /= B. print A means print{A}. append A to B means array_push{B,A}. replace A in B with C means replace{B,A,C}. let A be B means A = B. set A to B means let A be B. each A in B where C means A for A in B where C. X is closer to Y than to Z means (the distance between X and Y) is less than (the distance between X and Z). X is further from Y than from Z means X is closer to Z than to Y."+input;
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
	console.log(JSON.stringify(rewrite_rules));
	return ["top_level_statements",output_stuff];
}

function recursive_rewrite(output){
	for(var j = 0; j < rewrite_rules.length; j++){
		//alert("rewriting " + JSON.stringify(rewrite_rules[j]));
		output = rewrite_term(output,rewrite_rules[j][0],rewrite_rules[j][1]);
	}
	return output;
}
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
			if(!(matches_pattern_(arr[i],pattern[i],symbols) || matches_symbol(arr[i],pattern[i],symbols))){
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


function var_type(input_lang,lang,type){
	//console.log(type);
	var to_return;
	if(!case_sensitive_language(input_lang) && (typeof type === "string")){
		type = type.toLowerCase();
	}
	if(member(type,type_parameters)){
		return type;
	}
	else if((type[0] === "ArrayList") || (input_lang === "haxe" && type[0] === "Array")){
		if(lang === "java")
			return "ArrayList<"+type[1][0]+">";
		else if(lang === "haxe")
			return "Array<"+type[1][0]+">";
		else
			return var_type(input_lang,lang,[type[1][0],"[]"]);
	}
	else if(type[0] == "HashMap" || ((input_lang === "smt-lib") && (type[0] === "Array"))){
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
		else if(member(lang,["smt-lib"])){
			return "(Array " + var_type(input_lang,lang,type[1][0]) + " " + var_type(input_lang,lang,type[1][1]) + ")";
		}
	}
	else if(member(type,["Object","auto","object"])){
		if(member(lang,["c#","scala"])){
			return "object";
		}
		if(member(lang,["c++"])){
			return "auto";
		}
		else if(member(lang,["java","gnu smalltalk","visual basic .net"])){
			return "Object";
		}
	}
	else if(member(type, ["char"])){
		if(member(lang,["java","c","standard ml","mysql"])){
			return "char";
		}
	}
	else if(member(type, ["function"])){
		if(member(lang,["javascript","lua"])){
			return "function";
		}
	}
	else if(member(type, ["int","Int","Integer","integer","integer!","i32","int32"])){
		if(member(lang,["hack","alt-ergo","sentient","sql","mysql",'pl/sql',"scriptol","transact-sql","standard ml","glsl","mercury","nim","elm","ats","python","coconut","systemverilog","transact-sql","dafny","janus","chapel","minizinc","engscript","cython","algol 68",'d',"octave","tcl","ml","awk","julia","gosu","ocaml","f#","pike","objective-c","go","cobra","dart","groovy","hy","java","c#",'c',"c++","vala","nemerle"])){
			return "int";
		}
		else if(member(lang,["javascript","lua","typescript","coffeescript"])){
			return "number";
		}
		else if(member(lang,["rust","thrift"])){
			return "i32";
		}
		else if(member(lang,["protobuf"])){
			return "int32";
		}
		else if(member(lang,["ceylon","haskell","ada","ruby","cosmos","gambas","openoffice basic","pascal","erlang","delphi","visual basic","visual basic .net"])){
			return "Integer";
		}
		else if(member(lang,["php","fortran","vhdl","prolog","constraint handling rules","common lisp","picat","seed7"])){
            return "integer";
        }
        else if(member(lang,["rebol"])){
			return "integer!";
		}
		else if(member(lang,["haxe","flix","idris","smt-lib","kotlin","ooc","swift","scala","perl 6","smt-lib","monkey x"])){
			return "Int";
		}
	}
	else if(member(type,["double",'double precision',"Double","number","\"number\""])){
		if(member(lang,["java","thrift","c","c#","c++","dart","vala","mysql"])){
			return "double";
		}
		else if(member(lang,["javascript","coffeescript","typescript","lua"])){
			return "number";
		}
		else if(member(lang,["fortran"])){
			return "double precision";
		}
		else if(member(lang,["visual basic .net","scala"])){
			return "Double";
		}
		else if(member(lang,["go"])){
			return "float64";
		}
		else if(member(lang,["javascript","coffeescript","python","coconut","haxe","minizinc","seed7"])){
			return "float";
		}
		else if(member(lang,["smt-lib","z3py"])){
			return "Real";
		}
	}
	else if(member(type,["float"])){
		if(member(lang,["go"])){
			return "float64";
		}
		else if(member(lang,["javascript","java","glsl","coffeescript","python","coconut","haxe","minizinc","seed7"])){
			return "float";
		}
		else if(member(lang,["smt-lib","z3py"])){
			return "Real";
		}
	}
	else if(member(type,["real"])){
		if(member(lang,["java","c","c++"])){
			return "double";
		}
	}
	else if(member(type,["String","string","\"string\"","str","character(len=*)"])){
		if(member(lang,["vala","coq","standard ml","thrift","protobuf","lua","systemverilog","seed7","octave","picat","mathematical notation","polish notation","reverse polish notation","prolog","constraint handling rules",'d',"chapel","minizinc","genie","hack","nim","algol 68","typescript","coffeescript","octave","tcl","awk","julia","c#","f#","perl","javascript","go","php","nemerle","erlang"])){
			return "string";
		}
		else if(member(lang,["smt-lib","ada","elm","ruby","cosmos","visual basic .net","java","ceylon","gambas","dart","gosu","groovy","scala","pascal","swift","haxe","haskell","visual basic","monkey x"])){
			return "String";
		}
		else if(member(lang,["c++"])){
			return "std::string";
		}
		else if(member(lang,["mysql"])){
			return "varchar(255)";
		}
		else if(member(lang,["fortran"])){
			return "character(len=*)";
		}
		else if(member(lang,["flix"])){
			return "Str";
		}
		else if(member(lang,["c"])){
			return "char*";
		}
		else if(member(lang,["hy","python","coconut","cython"])){
			return "str";
		}
		else if(member(lang,["rebol"])){
			return "string!";
		}
		else if(member(lang,["smt-lib","cosmos","visual basic .net","java","ceylon","gambas","dart","gosu","groovy","scala","pascal","swift","haxe","haskell","visual basic","monkey x"])){
			return type;
		}
	}
	else if(type === "void"){
		if(member(lang,["engscript","thrift","seed7","php","hy","cython","go","pike","objective-c","java",'c',"c++","c#","vala","typescript",'d',"javascript","dart"])){
			return "void";
		}
		else if(member(lang,["scala"])){
			return "Unit";
		}
	}
	else if(member(type,["boolean","bool","Bool","Boolean","BIT","LOGICAL",'logical']) || member(lang,["mysql"]) || type === "bit"){
		if(member(lang,["typescript","vhdl","seed7","hy","python","coconut","java","javascript","coffeescript","perl",'postgresql'])){
            return "boolean";
        }
		else if(member(lang,["c++","alt-ergo","algol 68","protobuf","thrift","mercury","coq","nim","octave","dafny","chapel",'c',"rust","minizinc","engscript","dart",'d',"vala","go","cobra","c#","f#","php","hack"])){
            return "bool";
        }
		else if(member(lang,["haxe","idris","haskell","swift","julia","perl 6","smt-lib","smt-lib",'smt-libpy',"monkey x"])){
			return "Bool";
		}
		else if(member(lang,["visual basic","visual basic .net","openoffice basic","ceylon","delphi","pascal","scala"])){
            return "Boolean";
        }
		else if(member(lang,["fortran"])){
			return "LOGICAL";
		}
		else if(member(lang,["mysql","transact-sql"])){
			return "BIT";
		}
	}
	else if((type[1] === "[]") && (type.length === 2)){
		if(member(lang,["c#","typescript"])){
			return var_type(input_lang,lang,type[0])+"[]";
		}
		else if(member(lang,['c'])){
			return var_type(input_lang,lang,type[0])+"*";
		}
		else if(member(lang,["java"])){
			return "ArrayList<"+type[0]+">";
		}
		else if(member(lang,["coq"])){
			return "list "+type[0];
		}
		else if(member(lang,["visual basic .net"])){
			return var_type(input_lang,lang,type[0])+"()";
		}
		else if(member(lang,["minizinc"])){
			return "array[" + var_type(input_lang,lang,type[0]) + "] of var "+var_type(input_lang,lang,type[0]);
		}
		else if(member(lang,["scala"])){
			return "Array[" + var_type(input_lang,lang,type[0])+"]";
		}
		else if(member(lang,["haxe"])){
			return "Array<" + var_type(input_lang,lang,type[0])+">";
		}
		else if(member(lang,["smt-lib"])){
			return "(Array Int " + var_type(input_lang,lang,type[0]) + ")";
		}
		else if(member(lang,["c++"])){
			return "std::vector<" + var_type(input_lang,lang,type[0])+">";
		}
		else if(member(lang,["swift"])){
			return "[" + var_type(input_lang,lang,type[0])+"]";
		}
	}
	throw "var_type " + JSON.stringify(type) + " is not defined for " + lang;
}

function var_name(lang,input_lang,var1){
	if(defined_vars.indexOf(var1) === -1){
		defined_vars.push(var1);
	}
	
	if(member(lang,["php","tcl","autoit"])){
		if(var1.startsWith("$")){
			return var1;
		}
		else{
			same_var_type("$"+var1, var1);
			return "$"+var1;
		}
	}
	if(member(lang,["ruby-prolog"])){
		if(var1.startsWith(":")){
			return var1;
		}
		else{
			same_var_type(":"+var1, var1);
			return ":"+var1;
		}
	}
	else if(member(lang,["nearley"])){
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
	else if(member(lang,["clips","pddl","sparql","common prolog"])){
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

function case_sensitive_language(lang){
	return !member(lang, ["sql","rebol","mysql","transact-sql","fortran"]);
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
	if(types[the_object] !== undefined){
		return types[the_object];
	}
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
		return undefined;
		//throw "type  of " + the_object + " is unknown";
	}
	else{
		return types[the_object];
	}
}


function semicolon(lang,statement){
	if(member(lang,["visual basic .net",'autohotkey',"rexx","icon","coffeequate","f#","alt-ergo","gdscript","sage","pythological","scriptol","gambas","sql","transact-sql","newlisp","ring","standard ml","agda","autoit","applescript","reverse polish notation","sidef","tex","racket","gosu","mercury","idris","coq","nim","emacs lisp","chr.js",'bash',"tcl","elixir","maxima","coconut","english","elm","ats","z3py","cython","kotlin","wolfram","clojure","ocaml","coffeescript","python","coconut","smt-lib","smt-lib","scala","clips","pddl","sympy","r","constraint handling rules","pydatalog","common lisp","gnu smalltalk","ruby","lua","hy","picolisp","logtalk","minizinc","swift","rebol","awk","fortran","go","picat","julia","prolog","haskell","mathematical notation","erlang","smt-lib"])){
		return statement;
	}
	else if(member(lang,["c","protobuf","thrift","pari/gp","sentient","setl","inform 6","mysql","glsl","hack","lc++","reasoned-php","logicjs","yacas","gap","vhdl","php","dafny","chapel","katahdin","frink","falcon","aldor","idp","processing","seed7","drools","engscript","openoffice basic","ada","algol 68",'d',"ceylon","rust","typescript","octave","matlab","pascal","delphi","javascript","pike","objective-c","java","dart","c#","c++","bc","perl","perl 6","nemerle","vala","haxe"])){
		return statement+";";
	}
	else if(member(lang,["smalltalk"])){
		return statement+".";
	}
	else{
		throw "semicolon is not defined for "+lang;
	}
}

function prefix_arithmetic_lang(lang){
	return member(lang,["racket","common prolog","picolisp","scheme","smt-lib","smt-lib","clips","gnu smalltalk","newlisp","hy","common lisp","emacs lisp","clojure","sibilant","lispyscript"]);
}
function infix_arithmetic_lang(lang){
	return member(lang,["pascal",'coq',"icon","coffeequate","asciimath","pari/gp","dafny","alt-ergo","gdscript",'bash',"flix","sentient","sage","symja","algebrite","symbolicc++","setl","inform 6","transact-sql","mysql","smalltalk","ring","glsl","agda","applescript","sidef","idris","lc++","chr.js","mercury","constraint handling rules","yacas","english","jison","prolog","elm","z3py","logtalk","picat","prolog","sympy","vhdl","elixir","python","coconut","visual basic .net","ruby","lua","scriptol", 'smt-libpy',"ats","pydatalog",'e',"vbscript","livecode","monkey x","perl 6","englishscript","cython","gap","mathematical notation","wolfram","chapel","katahdin","frink","minizinc","picat","java",'eclipse','d',"ooc","genie","janus","ooc","idp","processing","maxima","seed7",'self',"gnu smalltalk","drools","standard ml","oz","cobra","pike","prolog","engscript","kotlin","pawn","freebasic","matlab","ada","freebasic","gosu","gambas","nim","autoit","algol 68","ceylon","groovy","rust","coffeescript","typescript","fortran","octave","ml","hack","autohotkey","scala","delphi","tcl","swift","vala",'c',"f#","c++","dart","javascript","rebol","julia","erlang","ocaml","c#","nemerle","awk","java","perl","haxe","php","haskell","go","r","bc","visual basic"]);
}

function set_var_type(input_lang,lang,a,b){
	if(typeof b === "string"){
		types[a] = var_type(input_lang,"java",b);
	}
	else if(b.length === 2 && b[1] === "[]"){
		console.log("Setting array type: "+a+","+b);
		types[a] = [var_type(input_lang,"java",b[0]),"[]"];
	}
	else if(input_lang === "haxe" && b.length === 2 && b[0] === "Array"){
		types[a] = [var_type(input_lang,"java",b[1][0]),"[]"];
	}
}

function is_statically_typed(lang){
	return member(lang,["c","d","ada","mysql","transact-sql","fortran","minizinc","go","swift","ada","seed7",'gnu pascal',"pascal","chapel","rust","algol 68","coq","glsl"]);
}
function is_dynamically_typed(lang){
	return member(lang,["javascript",'english',"php","ruby","lua","perl","common lisp","racket","scheme","rebol","mathematica","r","prolog","tcl","clojure","erlang","julia","elixir",'octave']);
}

function parameter(input_lang,lang,x){
	if(defined_vars.indexOf(x) === -1){
		defined_vars.push(x);
	}
	
	if(input_lang === "erlang"){
		x[0] = "Object";
		x[1] = x[1][0];
	}
	if(typeof(x) === "string"){
		return parameter(input_lang,lang,["Object",x]);
	}
	else if(x.length === 2){
		if(!(is_statically_typed(lang) && is_dynamically_typed(input_lang))){
			//
			set_var_type(input_lang,lang,x[1],x[0]);
		}
		var type = types[x[1]];
		var name = x[1];
		//console.log("types: "+JSON.stringify(types));
		if(input_lang === "prolog" && !member(lang,["mysql",'c',"fortran"])){
			//alert(JSON.stringify(function_params));
			return parameter(input_lang,lang,["ref_parameter"].concat(x));
		}
		else if(input_lang === "prolog" && member(lang,["fortran","c"])){
			//alert(JSON.stringify(function_params));
			return parameter(input_lang,lang,["ref_parameter"].concat(x));
		}
		if(member(lang,["java","thrift","c#","scriptol"])){
			return var_type(input_lang,lang,x[0])+" "+x[1];
		}
		else if(member(lang,["fortran"])){
			if(is_dynamically_typed(input_lang)){
				//alert(JSON.stringify(types));
				//alert("fortran parameter: " + JSON.stringify(x[1]) + " " + types[x[1]]);
				type = var_type(input_lang,lang,types[x[1]]);
				//alert(name);
				//alert(JSON.stringify(function_params[name]));
				function_params[function_name][param_index][0] = type;
				param_index += 1;
				return var_type(input_lang,lang,types[x[1]])+",intent(in) :: "+x[1];
				
			}
			else{
				return var_type(input_lang,lang,x[0])+",intent(in) :: "+x[1];
			}
		}
		if(member(lang,["cython"])){
			if(x[0] === "Object"){
				return name;
			}
			else{
				return var_type(input_lang,lang,x[0])+" "+name;
			}
		}
		else if(member(lang,["go","transact-sql","mysql","pl/sql"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
				type = types[x[1]];
				//alert(name);
				//alert(JSON.stringify(function_params[name]));
				function_params[function_name][param_index][0] = type;
				param_index += 1;
			}
			else{
				type = x[0];
			}
			return name+" "+var_type(input_lang,lang,type);
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
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
				type = var_type(input_lang,lang,types[x[1]]);
			}
			else{
				type = var_type(input_lang,lang,x[0]);
			}
			return "("+name+" "+type+")";
		}
		else if(member(lang,["typescript","haxe","standard ml"]) && member(x[0],["Object","object"])){
			return name;
		}
		else if(member(lang,["haxe","flix","standard ml","ada","ats","vhdl","dafny","chapel","pascal","rust","genie","hack","nim","typescript","gosu","delphi","nemerle","scala","swift"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
				type = var_type(input_lang,lang,types[x[1]]);
				function_params[function_name][param_index][0] = type;
				param_index += 1;
			}
			else{
				type = var_type(input_lang,lang,x[0]);
			}
			return name+":"+type;
		}
		else if(member(lang,["coq"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
				type = var_type(input_lang,lang,types[x[1]]);
			}
			else{
				type = var_type(input_lang,lang,x[0]);
			}
			return "(" + name+":"+type+ ")";
		}
		else if(member(lang,["alt-ergo"])){
			return "forall " + name+":"+var_type(input_lang,lang,x[0]) + ".";
		}
		else if(member(lang,["seed7"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
				type = var_type(input_lang,lang,types[x[1]]);
			}
			else{
				type = var_type(input_lang,lang,x[0]);
			}
			return "in " + name+":"+type;
		}
		else if(member(lang,["minizinc"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
				type = var_type(input_lang,lang,types[x[1]]);
			}
			else{
				type = var_type(input_lang,lang,x[0]);
			}
			return name+": var " +type;
		}
		else if(member(lang,["c","glsl","c++","d","algol 68","vala"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
				type = var_type(input_lang,lang,types[x[1]]);
				//alert(name);
				//alert(JSON.stringify(function_params[name]));
				function_params[function_name][param_index][0] = type;
				param_index += 1;
			}
			else{
				type = var_type(input_lang,lang,x[0]);
			}
			return type+" "+x[1];
		}
		else if(member(lang,["wolfram"])){
			return x[1]+"_";
		}
		else if(member(lang,["perl"])){
			return "$"+x[1];
		}
		else if(member(lang,["smalltalk"])){
			return ":"+x[1];
		}
		else if(member(lang,["tcl"])){
			return x[1];
		}
		else if(member(lang,["haskell",'logpy',"common prolog","ruby-prolog","agda","mercury","idris","lc++","emacs lisp","chr.js","reasoned-php","logicjs","yacas","elixir","erlang","elm","z3py","prolog","pddl","picat","definite clause grammars","nearley","sympy","sage","pydatalog","python","coffeequate","pari/gp","gdscript","picolisp","autoit","coconut","applescript","english","ruby","lua","inform 6","gap","hy","perl 6","cosmos","polish notation","reverse polish notation","scheme","mathematical notation","lispyscript","clips","clojure","f#","ml","racket","ocaml","common lisp","newlisp","frink","picat","idp","powershell","maxima","icon","coffeescript","octave","matlab","autohotkey","constraint handling rules","logtalk","awk","kotlin","dart","sentient","javascript","pythological",'simula',"setl","sidef","nemerle","erlang","php","autoit","r","bc"])){
			var to_return = var_name(lang,input_lang,x[1]);
			set_var_type(input_lang,lang,x[1],x[0]);
			return to_return;
		}
		else if(lang === "php"){
			if(input_lang === "prolog")
				return "&" + var_name(lang,input_lang,x[1]);
			else
				return var_name(lang,input_lang,x[1]);
		}
		else if(member(lang,["openoffice basic","gambas","visual basic .net"])){
			return name+" As "+var_type(input_lang,lang,x[0]);
		}
	}
	//optional parameters
	else if(x[0] === "default_parameter"){
		var type = x[1];
		var name = x[2];
		if(!(is_statically_typed(lang) && is_dynamically_typed(input_lang))){
			//
			set_var_type(input_lang,lang,name,type);
		}
		var body = generate_code(input_lang,lang,"",x[3]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			type = var_type(input_lang,lang,types[x[2]]);
		}
		else{
			type = var_type(input_lang,lang,x[1]);
		}
		if(member(lang,["c#","c++","vala"])){
			return var_type(input_lang,lang,type) + " "+name+"="+body;
		}
		else if(member(lang,["scala","swift","ada","delphi"])){
			return name + ":" + var_type(input_lang,lang,type) + "=" + body;
		}
		else if(member(lang,["python","coconut","octave","autohotkey","julia","nemerle","php","javascript","r"])){
			return name+"="+body;
		}
		else if(member(lang,["ruby"])){
			return name+":"+body;
		}
		else if(member(lang,["fortran"])){
			return var_type(input_lang,lang,type)+",optional :: " + name + " if(.not.  present(" + name + ")) then " + name+" = "+body + " endif"
		}
		else if(member(lang,["tcl"])){
			return "{"+name+" "+body+"}";
		}
		throw "default_parameter is not defined for "+lang;
	}
	else if(x[0] === "final_parameter"){
		var type = x[1];
		var name = x[2];
		if(!(is_statically_typed(lang) && is_dynamically_typed(input_lang))){
			set_var_type(input_lang,lang,name,type);
		}
		if(member(lang,["c++","c"])){
			return "const "+type+" "+name;
		}
		else if(member(lang,["java"])){
			return "final "+type+" "+name;
		}
		else if(is_declarative_language(lang)){
			//for all declarative languages
			return parameter(input_lang,lang,[x[1],x[2]]);
		}
		throw "final_parameter is not defined for "+lang;
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
		else if(member(lang,["javascript","coffeescript","typescript","php"])){
			return "..." + var_name(lang,input_lang,name);
		}
		else if(member(lang,["python","coconut","ruby"])){
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
	else if(x[0] === "protobuf_parameter"){
		var num = x[1];
		var type = x[2];
		var name = var_name(lang,input_lang,x[3]);
		types[name] = type;
		if(member(lang,["thrift"])){
			return num+":" + var_type(input_lang,lang,type) + " "+name;
		}
		else if(member(lang,["protobuf"])){
			return var_type(input_lang,lang,type) + " "+name+" = "+num;
		}
	}
	else if(x[0] === "in_parameter"){
		var type = x[1];
		var name = var_name(lang,input_lang,x[2]);
		if(!(is_statically_typed(lang) && is_dynamically_typed(input_lang))){
			set_var_type(input_lang,lang,name,type);
		}
		if(member(lang,["fortran"])){
			return var_type(input_lang,lang,type)+",intent(in) :: " + name;
		}
		else if(member(lang,["glsl","c#"])){
			return "in " + var_type(input_lang,lang,type) + " "+name;
		}
		else if(member(lang,["mysql"])){
			return name + " " + var_type(input_lang,lang,type);
		}
		else if(member(lang,["swift","ada","vhdl"])){
			return name + ": in " + var_type(input_lang,lang,type);
		}
		else if(member(lang,["php","perl","c","c++"])){
			//for other languages that don't distinguish input from output parameters
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
				type = var_type(input_lang,lang,types[x[2]]);
			}
			else{
				type = var_type(input_lang,lang,x[1]);
			}
			return parameter(input_lang,lang,["ref_parameter",type,x[2]]);
		}
		else if(is_declarative_language(lang) || member(input_lang,["fortran"])){
			//for all declarative languages
			return parameter(input_lang,lang,[x[1],x[2]]);
		}
	}
	else if(x[0] === "ref_parameter"){
		var type = x[1];
		var name = var_name(lang,input_lang,x[2]);
		if(!(is_statically_typed(lang) && is_dynamically_typed(input_lang))){
			set_var_type(input_lang,lang,name,type);
		}
		if(member(lang,["fortran"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
				type = var_type(input_lang,lang,types[x[2]]);
			}
			else{
				type = var_type(input_lang,lang,x[1]);
			}
			return var_type(input_lang,lang,type)+",intent(inout) :: "+name;
		}
		else if(member(lang,["c#"])){
			return "ref " + var_type(input_lang,lang,type) + " "+name;
		}
		else if(member(lang,["seed7","glsl"])){
			return "inout " + var_type(input_lang,lang,type) + " "+name;
		}
		else if(member(lang,["mysql"])){
			return "inout " + name + " " + var_type(input_lang,lang,type);
		}
		else if(member(lang,["swift"])){
			return name + ": inout " + var_type(input_lang,lang,type);
		}
		else if(member(lang,["ada"])){
			return name + ": in out " + var_type(input_lang,lang,type);
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
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
				type = var_type(input_lang,lang,types[x[2]]);
			}
			else{
				type = var_type(input_lang,lang,x[1]);
			}
			
			if(input_lang === "fortran"){
				return "restrict " + var_type(input_lang,lang,type) + " *"+name;
			}
			else{
				return var_type(input_lang,lang,type) + " *"+name;
			}
		}
		else if(member(lang,["prolog","perl","fortran"])){
			//in perl, the arguments in a function call should be preceded by
			return name;
		}
		else if(is_declarative_language(lang)){
			//for all declarative languages
			return parameter(input_lang,lang,[x[1],x[2]]);
		}
		throw "ref_parameter is not defined for "+lang;
	}
	else if(x[0] === "out_parameter"){
		var type = x[1];
		var name = var_name(lang,input_lang,x[2]);
		if(!(is_statically_typed(lang) && is_dynamically_typed(input_lang))){
			set_var_type(input_lang,lang,type,name);
		}
		if(member(lang,["c#"])){
			return "out " + var_type(input_lang,lang,type) + " "+name;
		}
		else if(member(lang,["seed7","glsl"])){
			return "out " + var_type(input_lang,lang,type) + " "+name;
		}
		else if(member(lang,["php"])){
			return "&"+name;
		}
		else if(member(lang,["ada","swift","vhdl"])){
			return name + ": out " + var_type(input_lang,lang,type);
		}
		else if(member(lang,["prolog","perl"])){
			//in perl, the arguments in a function call should be preceded by \
			return name;
		}
		else if(is_declarative_language(lang)){
			//for all declarative languages
			return parameter(input_lang,lang,[x[1],x[2]]);
		}
		throw "out_parameter is not defined for "+lang;
	}
	else if(x[0] === "out_parameter"){
		var type = x[1];
		var name = var_name(lang,input_lang,x[2]);
		if(!(is_statically_typed(lang) && is_dynamically_typed(input_lang))){
			set_var_type(input_lang,lang,name,type);
		}
		if(member(lang,["c#"])){
			return "out " + var_type(input_lang,lang,type) + " "+name;
		}
		else if(is_declarative_language(lang)){
			//for all declarative languages
			return parameter(input_lang,lang,[x[1],x[2]]);
		}
		throw "out_parameter is not defined for "+lang;
	}
	throw "parameter is not defined for "+lang+": "+x;
}

function function_call_parameters(input_lang,lang,name,params){
	if(params === ""){
		return params;
	}
	
	params = params.map(function(x){return generate_code(input_lang,lang,"",x)});
	if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
		//type inference for statically-typed target languages
		for(var i = 0; i < params.length; i++){
				types[params[i]] = function_params[name][i][0];
		}

	}
	if(member(lang,["pseudocode","alt-ergo","mysql","glsl","sage","kotlin","sentient","chrg","ruby-prolog","yacas","gosu","gap","awk","z3py","peg.js","english","ruby","definite clause grammars","nearley","sympy","systemverilog","vhdl","visual basic .net","perl","constraint handling rules","lua","ruby","python","coconut","javascript","logtalk","nim","seed7","pydatalog",'e',"vbscript","monkey x","livecode","ceylon","delphi","englishscript","cython","vala","dafny","wolfram","gambas",'d',"frink","chapel","swift","perl 6","janus","mathematical notation","pascal","rust","picat","autohotkey","maxima","octave","matlab","julia","r","prolog","fortran","go","minizinc","erlang","coffeescript","php","hack","java","c#",'c',"c++","typescript","dart","haxe","scala","visual basic"])){
		return params.join(",");
	}
	else if(member(lang,["hy","common prolog","pythological","pddl","newlisp","ocaml","f#","polish notation","reverse polish notation","smt-lib","scheme","racket","common lisp","clips","rebol","haskell","racket","clojure"])){
		return params.join(" ");
	}
	throw "function_call_parameters is not defined for "+lang;
}


function access_array_parameters(input_lang,lang,indent,params){
	params = params.map(function(x){return generate_code(input_lang,lang,"",x)});
	if(member(lang,["c#","minizinc","wolfram","fortran"])){
		return params.join(",");
	}
	else if(member(lang,["prolog"])){
		return params[1];
	}
	else if(member(lang,["scala","visual basic .net"])){
		return params.join(")(");
	}
	else if(member(lang,["smt-lib","smt-lib"])){
		return params.join(")(");
	}
	else if(member(lang,["haskell"])){
		return params.join("!!");
	}
	else if(member(lang,['c',"glsl","coffeescript","cython","javascript","go","julia","python","coconut","java","swift","typescript","c++","lua","ruby","perl","php","haxe"])){
		return params.join("][");
	}
	throw "access_array_parameters is not defined for "+lang;
}

function parameters(input_lang,lang,indent,params){
	//these parameters appear in a function's definition
	if(params === "" || (Array.isArray(params) && params.length === 0)){
		return "";
	}
	params = params.map(function(x){return parameter(input_lang,lang,x)});
	if(member(lang,["pseudocode","icon","coffeequate","protobuf","thrift","pari/gp","gdscript",'pl/sql',"flix","sage",'logpy',"sentient","scriptol",'simula',"setl","ruby-prolog","mysql","transact-sql","standard ml","glsl","bc","autoit","applescript","algol 68","ada","sidef","gosu","mercury","lc++","chr.js","reasoned-php","logicjs","yacas","gap","elixir","awk","ats","z3py","kotlin","english","ruby","definite clause grammars","nearley","sympy","systemverilog","vhdl","visual basic .net","perl","constraint handling rules","lua","ruby","python","coconut","javascript","logtalk","nim","seed7","pydatalog",'e',"vbscript","monkey x","livecode","ceylon","delphi","englishscript","cython","vala","dafny","wolfram","gambas",'d',"frink","chapel","swift","perl 6","janus","mathematical notation","pascal","rust","picat","autohotkey","maxima","octave","matlab","julia","r","prolog","go","minizinc","erlang","coffeescript","php","hack","java","c#",'c',"c++","typescript","dart","haxe","scala","visual basic"])){
		return params.join(",");
	}
	else if(member(lang,["alt-ergo","common prolog","pythological","inform 6","smalltalk","newlisp","picolisp","pddl","agda","idris","coq","emacs lisp","tcl","elm","hy","ocaml","f#","polish notation","reverse polish notation","smt-lib","scheme","racket","common lisp","clips","rebol","haskell","racket","clojure"])){
		return params.join(" ");
	}
	else if(member(lang,['fortran'])){
		return indent + "    " + params.join(indent+"    ");
	}
	throw "parameters is not defined for "+lang;
}


function statements(input_lang,lang,indent,arr){
		//console.log("statements: "+ JSON.stringify(arr[1]));
		var a = arr[1].map(function(a){
			return generate_code(input_lang,lang,indent,a);
		});
		//console.log(JSON.stringify(arr[1]));
		if(member(lang,["java","lemon","coffeequate","alt-ergo","gdscript","sage","thrift","pythological","sentient","scriptol","chrg","instaparse","parboiled","javacc","treetop","setl","ruby-prolog","mysql","smalltalk","picolisp","newlisp","regex","txl","english","glsl","applescript","sidef","tex","protobuf","chapel","idris","coq","lc++","chr.js","reasoned-php","logicjs","tcl","yacas","coconut","gap","lark","pypeg","canopy","ats","z3py","peg.js","antlr","nearley","jison","vhdl",'c',"pseudocode","perl 6","haxe","javascript","c++","c#","php","dart","actionscript","typescript","processing","vala","bc","ceylon","hack","perl"])){
			return a.join("");
		}
		else if(member(lang,["picat","transact-sql","maxima","lpeg","prolog","constraint handling rules","logtalk","erlang","lpeg"])){
			return a.join(",");
		}
		else if(member(lang,["minizinc"])){
			return a.join("/\\");
		}
		else if(member(lang,["wolfram"])){
			return a.join(";");
		}
		else if(member(lang,["pydatalog","python","coconut","pddl","visual basic .net","lua","ruby","hy",'pegjs',"racket","vbscript","monkey x","livecode","polish notation","reverse polish notation","clojure","clips","common lisp","emacs lisp","scheme","dafny","smt-lib","elm",'bash',"mathematical notation","katahdin","frink","minizinc","aldor",'cobol',"ooc","genie",'eclipse',"nools","agda","ooc","rexx","idp","falcon","processing","sympy","pyke","elixir","gnu smalltalk","seed7","standard ml","occam","boo","drools","icon","mercury","engscript","pike","oz","kotlin","pawn","freebasic","ada","powershell","gosu","nim","cython","openoffice basic","algol 68",'d',"ceylon","rust","coffeescript","fortran","octave","ml","autohotkey","delphi","pascal","f#",'self',"swift","nemerle","autoit","cobra","julia","groovy","scala","ocaml","gambas","matlab","rebol",'red',"go","awk","haskell","r","visual basic"])){
			return a.join(" ");
		}
		else{
			throw "statements is not defined for "+lang;
		}
}

function get_lang(lang){
	if(member(lang,["vb .net","vb.net"])){
		return "visual basic .net";
	}
	else if(lang === "mathematica"){
		return "wolfram";
	}
	else if(member(lang,["pascal","object pascal"])){
		return "delphi";
	}
	else if(member(lang,["scheme"])){
		return "racket";
	}
	else if(lang === "why3"){
		return "alt-ergo";
	}
	else if(lang === "giac"){
		return "xcas";
	}
	else if(lang === "constraint handling rule grammars"){
		return "chrg";
	}
	else if(member(lang,["regular expression","regular expressions"])){
		return "regex";
	}
	else if(member(lang,["syntax definition formalism"])){
		return "sdf";
	}
	else if(lang === "bison"){
		return "jison";
	}
	else if(lang === "latex"){
		return "tex";
	}
	else if(lang === "gallina"){
		return "coq";
	}
	else if(lang === "apache thrift"){
		return "thrift";
	}
	else if(lang === "protocol buffers"){
		return "protobuf";
	}
	else if(lang === "z3"){
		return "smt-lib";
	}
	else if(lang === "strips"){
		return "pddl";
	}
	else{
		return lang;
	}
}

function unparse(input_lang,lang,indent,pattern_array,matching_symbols){
	//console.log("unparse " + JSON.stringify(pattern_array));
	//console.log("unparse " + JSON.stringify(matching_symbols));
	console.log("Unparsing: "+JSON.stringify(pattern_array));
	var to_return = "";
	if(pattern_array.length === 1 && typeof(pattern_array[0]) === "string"){
		to_return = pattern_array[0];
	}
	else if(pattern_array[0] === "parentheses"){
		if(infix_arithmetic_lang(lang) || member(lang,["tex","regex","antlr","jison"])){
			to_return = "("+unparse(input_lang,lang,indent,pattern_array[1],matching_symbols)+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array[1],matching_symbols);
		}
	}
	else if(member(pattern_array[0],["-","*","/","+"])){
		var a = unparse(input_lang,lang,indent,pattern_array[1],matching_symbols);
		var b = unparse(input_lang,lang,indent,pattern_array[2],matching_symbols);
		if(infix_arithmetic_lang(lang)){
			to_return = a + pattern_array[0] + b;
		}
		else if(lang === "tex"){
			if(pattern_array[0] === "*")
				to_return = a + " \\times " + b;
			else if(pattern_array[0] === "+")
				to_return = a + " + " + b;
			else if(pattern_array[0] === "-")
				to_return = a + " - " + b;
			else if(pattern_array[0] === "/")
				to_return = "\\frac{"+a+"}{"+b+"}";
		}
		else if(prefix_arithmetic_lang(lang)){
			to_return =  "("+pattern_array[0] + " " + a + " " + b+")";
		}
		else if(member(lang,['forth',"reverse polish notation"])){
			to_return =  a + " " + b+" "+pattern_array[0];
		}
	}
	else if(member(pattern_array[0],[">","<",">=","<="])){
		var a = unparse(input_lang,lang,indent,pattern_array[1],matching_symbols);
		var b = unparse(input_lang,lang,indent,pattern_array[2],matching_symbols);
		if(infix_arithmetic_lang(lang)){
			to_return = a + pattern_array[0] + b;
		}
		else if(lang === "tex"){
			to_return = a + " " + {"<=":"\\leq",">=":"\\geq","<":"<",">":">"}[pattern_array[0]] + " " + b
		}
		else if(member(lang,["forth","reverse polish notation"])){
			to_return = a + " " + b+" "+pattern_array[0];
		}
		else if(prefix_arithmetic_lang(lang)){
			to_return = "("+pattern_array[0]+" "+a + " " + b+")";
		}
	}
	else if(pattern_array[0] === "." && pattern_array.length === 2){
		var dot_separator;
		if(member(lang,["erlang","prolog","logtalk"])){
			dot_separator = ":";
		}
		else if(lang === "clojure"){
			dot_separator = "/";
		}
		else if(lang === "php"){
			dot_separator = "->";
		}
		else{
			dot_separator = ".";
		}
		to_return = pattern_array[1].map(function(x){
			return unparse(input_lang,lang,indent,x,matching_symbols);
		}).join(dot_separator);
	}
	else if(pattern_array[0] === "function_call"){
		var name = pattern_array[1];
		var params = function_call_parameters(input_lang,lang,name,pattern_array[2].map(function(x){
			return unparse(input_lang,lang,indent,x,matching_symbols)
		}));
		to_return = function_call(lang,name,params);
	}
	else if(pattern_array[0] === "new"){
		var name = pattern_array[1];
		var params = function_call_parameters(input_lang,lang,name,pattern_array[2].map(function(x){
			return unparse(input_lang,lang,indent,x,matching_symbols)
		}));
		to_return = "new " + function_call(lang,name,params);
	}
	else if(pattern_array[0] === "=="){
		var a = unparse(input_lang,lang,indent,pattern_array[1],matching_symbols)
		var b = unparse(input_lang,lang,indent,pattern_array[2],matching_symbols)
		if(member(lang,["c","lua","c++","lua","python","ruby","coffeescript"])){
			to_return = "("+a+" == "+b+")";
		}
		else if(member(lang,["javascript","typescript","php","hack"])){
			to_return = "("+a+" === "+b+")";
		}
		else if(member(lang,["clips","clojure"])){
			to_return = "(= "+a+" "+b+")";
		}
	}
	else if(pattern_array[0] === "!="){
		var a = unparse(input_lang,lang,indent,pattern_array[1],matching_symbols)
		var b = unparse(input_lang,lang,indent,pattern_array[2],matching_symbols)
		if(member(lang,["lua"])){
			to_return = "("+a+" ~= "+b+")";
		}
		else if(member(lang,["javascript","typescript","php","hack"])){
			to_return = "("+a+" !== "+b+")";
		}
		else if(member(lang,["python","ruby"])){
			to_return = "("+a+" != "+b+")";
		}
		else if(member(lang,['ocanren'])){
			to_return = "("+a+" =/= "+b+")";
		}
	}
	else if(pattern_array[0] === "in"){
		var a = unparse(input_lang,lang,indent,pattern_array[1],matching_symbols)
		var b = unparse(input_lang,lang,indent,pattern_array[2],matching_symbols)
		if(member(lang,["javascript","typescript","python"])){
			to_return = "("+a+" in "+b+")";
		}
	}
	else if(pattern_array in matching_symbols){
		to_return = generate_code(input_lang,lang,indent,matching_symbols[pattern_array]);
	}
	else if(typeof pattern_array === 'string'){
		to_return = pattern_array;
	}
	if(to_return !== ""){
		console.log("Unparsed: "+to_return);
		return to_return;
	}
	else{
		throw("unparse is not defined for "+JSON.stringify(pattern_array) +" in "+lang);
	}
}

function generate_code(input_lang,lang,indent,arr){
	lang = get_lang(lang);
	var to_return;
	var pattern_array = {value:undefined};
	var matching_symbols = {"$a":undefined,"$b":undefined,"$c":undefined,"$d":undefined};
	console.log("Generating code: " + JSON.stringify(arr));
	
	if(arr[0] === "+" || arr[0] === ".." || (member(input_lang,["haskell","coq","picat"]) && arr[0] === "++") || arr[0] === ".." || (member(input_lang,["php","hack","perl"]) && arr[0] ==="." && arr.length === 3)){
		if(input_lang === "php"){
			alert(JSON.stringify(arr));
		}
		//add or concatenate strings
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			if(input_lang === "prolog"){
				types[a] = "double";
			}
			same_var_type(a,b);
		}
		if(input_lang === "lua" && arr[0] === ".." || member(input_lang,["php","hack","perl"])){
			if(arr[0] ==="."){
				types[a] = "String";
				types[b] = "String";
			}
			else if(arr[0] ==="+"){
				types[a] = "double";
				types[b] = "double";
			}
		}
		
		if(prefix_arithmetic_lang(lang) && (types[a] !== "String") && (types[b] !== "String")){
			to_return = "(+ " + a + " " + b + ")";
			same_var_type(to_return,a);
		}
		else if(member(lang,['forth',"reverse polish notation"])){
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

			else{
				to_return = inputs_to_outputs(lang,{a1:a,b1:b},[
					[['c',"ruby","python","coconut","cosmos","z3py","monkey x","englishscript","mathematical notation","go","java","chapel","frink","freebasic","nemerle",'d',"cython","ceylon","coffeescript","typescript","dart","gosu","groovy","scala","swift","f#","javascript","c#","haxe","c++","vala"],
						"a1 + b1"],
					[["visual basic","ada","applescript","seed7","visual basic .net","gambas","nim","autoit","openoffice basic","livecode","vbscript"],
						"(a1 & b1)"],
					[["rebol"],
						"join a1 b1"],
					[["delphi"],
						"Concat(a1,b1)"],
					[["yacas"],
						"ConcatStrings(a1,b1)"],
					[["maxima"],
						"sconcat(a1,b1)"],
					[["php","autohotkey","hack","perl"],
						"a1 . b1"],
					[["lua"],
						"a1 .. b1"],
					[["reverse polish notation"],
						"a1 b1 +"],
					[["perl 6"],
						"a1 ~ b1"],
					[["fortran"],
						"a1 // b1"],
					[["icon","maple","ooc","rexx"],
						"a1 || b1"],
					[["haskell","minizinc","picat","elm","coq"],
						"a1 ++ b1"],
					[["clojure"],
						"(str a1 b1)"],
					[["emacs lisp"],
						"(concat a1 b1)"],
					[["clips"],
						"(str-cat a1 b1)"],
					[["hy"],
						"(+ a1 b1)"],
					[["racket"],
						"(string-append a1 b1)"],
					[["common lisp"],
						"(concatenate-string a1 b1)"],
					[["julia","octave"],
						'string(a1,b1)'],
					[["erlang"],
						'string:concat(a1,b1)'],
					[["mysql"],
						'string:concat(a1,b1)'],
					[["octave"],
						'strcat(a1,b1)'],
					[["seed7"],
						'(a1 <& b1)'],
					[["ocaml","standard ml"],
						'(a1 ^ b1)'],
					[["r"],
						'paste0(a1,b1)'],
					[["elixir","wolfram","purescript"],
						"a1 <> b1"]
				]);
			}
			types[to_return] = "String";
		}
		else if((infix_arithmetic_lang(lang) || lang === "tex") && (types[a] !== "String") && (types[b] !== "String")){
			to_return = a + "+" + b;
			same_var_type(to_return,a);
		}
		else{
			throw "+ is not defined for " + types[a] + " and " + types[b] + " in " + lang;
		}
	}
	else if(arr[0] === "return" && arr.length === 1){
		types[function_name] = "void";
		if(member(lang,["java","c","c++","javascript","php","python","fortran"])){
			return "return";
		}
	}
	else if(arr === "true" || matches_pattern(arr,[".",["true"]],{})){
		if(member(lang,	["java","alt-ergo","maxima","standard ml",'forth',"reverse polish notation","sidef","mercury","coq","tcl","clojure","ruby","lua","constraint handling rules","livecode","gap","dafny","smt-lib","perl 6","chapel",'c',"frink","elixir","pseudocode","pascal","minizinc","engscript","picat","rust","clojure","nim","hack","ceylon",'d',"groovy","coffeescript","typescript","octave","prolog","julia","f#","swift","nemerle","vala","c++","dart","javascript","erlang","c#","haxe","go","ocaml","scala","php","rebol"])){
			to_return = "true";
		}
		else if(member(lang,["python","sage","z3py","coconut","idris","yacas","visual basic .net","pydatalog","hy","cython","autoit","haskell","vbscript","visual basic","monkey x","wolfram","delphi"])){
			to_return = "True";
		}
		else if(member(lang,["clips","r","ada"])){
			to_return = "TRUE";
		}
		else if(member(lang,['ocanren'])){
			to_return = "success";
		}
		else if(member(lang,["perl","mysql","transact-sql"])){
			to_return = "1";
		}
		else if(member(lang,["fortran"])){
			to_return = ".true.";
		}
		types[to_return] = "boolean";
	}
	else if(arr === "undefined" || matches_pattern(arr,[".",["undefined"]],{}) || matches_pattern(arr,[".",["nil"]],{})){
		if(member(lang,["javascript","typescript","coffeescript"]))
			return "undefined";
		else if(member(lang,["python","coconut"])){
			return "None";
		}
		else if(member(lang,["php"])){
			return "null";
		}
		else if(member(lang,["lua"])){
			return "nil";
		}
	}
	else if(arr === "false" || matches_pattern(arr,[".",["false"]],{}) || (lang === "common lisp" && (arr === "f" || matches_pattern(arr,[".",["f"]],{})))){
		if(member(lang,	["java","alt-ergo","lua","maxima","standard ml",'forth',"reverse polish notation","sidef","mercury","coq","tcl","clojure","ruby","lua","constraint handling rules","livecode","gap","dafny","smt-lib","perl 6","chapel",'c',"frink","elixir","pseudocode","pascal","minizinc","engscript","picat","rust","clojure","nim","hack","ceylon",'d',"groovy","coffeescript","typescript","octave","prolog","julia","f#","swift","nemerle","vala","c++","dart","javascript","erlang","c#","haxe","go","ocaml","scala","php","rebol"])){
			to_return = "false";
		}
		else if(member(lang,["python","sage","z3py","coconut","idris","yacas","visual basic .net","pydatalog","hy","cython","autoit","haskell","vbscript","visual basic","monkey x","wolfram","delphi"])){
			to_return = "False";
		}
		else if(member(lang,["clips","r","ada"])){
			to_return = "FALSE";
		}
		else if(member(lang,["fortran"])){
			to_return = ".false.";
		}
		else if(member(lang,['ocanren'])){
			to_return = "failure";
		}
		else if(member(lang,["perl","mysql","transact-sql"])){
			to_return = "0";
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"php"],[".",["M_PI"]]],
		[["yacas"],[".",["Pi"]]],
		[["java","pseudocode","javascript","typescript","c#"],[".",["Math","PI"]]],
		[["lua","python"],[".",["math","pi"]]],
		[["perl","perl 6","octave","rebol","symja","sage"],[".",["pi"]]],
		[["erlang"],[".",["math",["function_call","pi",[]]]]],
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(input_lang === "english" && matches_pattern(arr,[["$a","for",["$b","in","$c"]],"where","$d"], matching_symbols)){
		to_return = generate_code(input_lang,lang,indent,["list_comprehension",matching_symbols["$a"],matching_symbols["$b"],matching_symbols["$c"],matching_symbols["$d"]]);
		types[to_return] = "Object";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//represents undefined variables
		[['c',"c++","sql","transact-sql"],[".",["NULL"]]],
		[["java","c#"],['.',['null']]],
		[["python"],[".",['None']]],
		[["lua"],[".",['nil']]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//compile regular expression
		[["javascript"],["new","RegExp",[[".",["$a"]]]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "Pattern";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//compile regular expression
		[["javascript"],[".",["Pattern",["function_call","matches",["$a","$b"]]]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "Pattern";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//e^x
		[["c","yacas","mysql","r","hlsl","octave","php","python","maple","c++","common lisp","perl","minizinc"],["function_call","exp",["$a"]]],
		[["wolfram","gap"],["function_call","Exp",["$a"]]],
		[["javascript","java"],[".",["Math",["function_call","exp",["$a"]]]]],
		[["lua","erlang"],[".",["math",["function_call","exp",["$a"]]]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","pseudocode","ruby","javascript","coffeescript","typescript","haxe","coffeescript","clojure"],[".",["Math",["function_call","cos",["$a"]]]]],
		[["c#","pseudocode","visual basic .net"],[".",["Math",["function_call","Cos",["$a"]]]]],
		[["python","pseudocode","cython","coconut","lua","erlang"],[".",["math",["function_call","cos",["$a"]]]]],
		[["go","pseudocode","wolfram","yacas","autohotkey"],["function_call","Cos",["$a"]]],
		[["rebol","pseudocode"],["function_call","cos/radians",["$a"]]],
		[['c',"mysql","sage","algebrite","pari/gp","pseudocode","english","standard ml","opencl","glsl","mathematical notation","mathematical notation","reverse polish notation","reverse polish notation","ocaml","r","tcl","reduce","sympy","seed7","picat","mathematical notation","julia",'d',"php","perl","perl 6","maxima","fortran","minizinc","swift","prolog","octave","dart","haskell","c++","scala"],["function_call","cos",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["c"]) && types[output] === "double"){
				to_return = "cos("+output+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","pseudocode","ruby","javascript","coffeescript","typescript","haxe",'tan'],[".",["Math",["function_call","tan",["$a"]]]]],
		[["c#","pseudocode","visual basic .net"],[".",["Math",["function_call","Tan",["$a"]]]]],
		[["go","pseudocode"],[".",["math",["function_call","Tan",["$a"]]]]],
		[["wolfram","pseudocode","yacas","autohotkey"],["function_call","Tan",["$a"]]],
		[["rebol","pseudocode"],["function_call","tangent/radians",["$a"]]],
		[["python","pseudocode","coconut","cython","lua","erlang"],[".",["math",["function_call","tan",["$a"]]]]],
		[['c',"mysql","algebrite","pseudocode","pari/gp","english","standard ml","opencl","glsl","reverse polish notation","ocaml","seed7","r","tcl","picat","reduce","mathematical notation","maxima","sympy","julia",'d',"php","perl","perl 6","maxima","fortran","minizinc","swift","prolog","octave","dart","haskell","c++","scala"],["function_call","tan",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["c"]) && types[output] === "double"){
				to_return = "tan("+output+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//floor function
		[["java","javascript","coffeescript","typescript","haxe"],[".",["Math",["function_call","floor",["$a"]]]]],
		[["python","coconut","lua","erlang"],[".",["math",["function_call","floor",["$a"]]]]],
		[["c#","visual basic .net"],[".",["Math",["function_call","Floor",["$a"]]]]],
		[['c',"asciimath","mysql","pari/gp","mediawiki","hlsl","standard ml","reverse polish notation","tcl","minizinc","c++","perl","php","ooc","octave","matlab","prolog","swift","perl"],["function_call","floor",["$a"]]],
		[["go","wolfram","yacas","gap","autohotkey"],["function_call","Floor",["$a"]]],
		[["haskell","common lisp","julia","yacas"],["function_call","floor",["$a"]]],
		[["rebol"],["function_call","round/floor",["$a"]]],
		[["ruby","perl 6"],[".",[["$a"],"floor"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","javascript","coffeescript","typescript","haxe"],[".",["Math",["function_call","ceil",["$a"]]]]],
		[["python","coconut","lua","scala","nim","erlang"],[".",["math",["function_call","ceil",["$a"]]]]],
		[["rebol"],[".",["math",["function_call","round/ceiling",["$a"]]]]],
		[["c#","visual basic .net"],[".",["Math",["function_call","Ceiling",["$a"]]]]],
		[['c',"opl","mysql","mediawiki","standard ml","reverse polish notation","tcl","minizinc","c++","perl","php","ooc","octave","swift","julia"],["function_call","ceil",["$a"]]],
		[["perl 6","prolog"],["function_call","ceiling",["$a"]]],
		[["go"],[".",["math",["function_call","Ceil",["$a"]]]]],
		[["wolfram"],["function_call","Ceiling",["$a"]]],
		[["yacas","gap","autohotkey","frink","yacas"],["function_call","Ceil",["$a"]]],
		[["ruby"],[".",[["$a"],"ceil"]]]
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
		[["java","pseudocode","ruby","javascript","coffeescript","typescript","haxe","clojure"],[".",["Math",["function_call","asin",["$a"]]]]],
		[["c#","pseudocode","visual basic .net"],[".",["Math",["function_call","Asin",["$a"]]]]],
		[["c++","mysql","hlsl","pseudocode","opencl","glsl","perl 6","mathematical notation","reverse polish notation","tcl","haskell","maxima","sympy","c","perl","prolog","swift","php","julia","octave","minizinc"],["function_call","asin",["$a"]]],
		[["go","pseudocode"],["function_call","Asin",["$a"]]],
		[["rebol","pseudocode"],["function_call","arcsine/radians",["$a"]]],
		[["autohotkey","pseudocode"],["function_call","ASin",["$a"]]],
		[["wolfram","pseudocode","yacas"],["function_call","ArcSin",["$a"]]],
		[["python","pseudocode","coconut","lua","erlang"],[".",["math",["function_call","asin",["$a"]]]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","pseudocode","ruby","javascript","coffeescript","typescript","haxe","clojure"],[".",["Math",["function_call","acos",["$a"]]]]],
		[["c#","pseudocode","visual basic .net"],[".",["Math",["function_call","Acos",["$a"]]]]],
		[["c++","mysql","hlsl","pseudocode","opencl","glsl","perl 6","mathematical notation","reverse polish notation","tcl","haskell","c","sympy","perl","maxima","prolog","swift","php","minizinc","julia","octave"],["function_call","acos",["$a"]]],
		[["python","pseudocode","coconut","lua","erlang"],[".",["math",["function_call","acos",["$a"]]]]],
		[["wolfram","pseudocode","yacas"],["function_call","ArcCos",["$a"]]],
		[["go","pseudocode"],["function_call","Acos",["$a"]]],
		[["rebol","pseudocode"],["function_call","arccosine/radians",["$a"]]],
		[["autohotkey","pseudocode"],["function_call","ACos",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","pseudocode","ruby","javascript","coffeescript","typescript","haxe","clojure"],[".",["Math",["function_call","atan",["$a"]]]]],
		[["c#","english","pseudocode","visual basic .net"],[".",["Math",["function_call","Atan",["$a"]]]]],
		[["c++","mysql","hlsl","pseudocode","opencl","glsl","perl 6","mathematical notation","reverse polish notation","tcl","c","c++","haskell","sympy","perl","maxima","prolog","swift","php","minizinc","julia","octave"],["function_call","atan",["$a"]]],
		[["python","pseudocode","coconut","lua","erlang"],[".",["math",["function_call","atan",["$a"]]]]],
		[["go","pseudocode"],["function_call","Atan",["$a"]]],
		[["autohotkey","pseudocode"],["function_call","ATan",["$a"]]],
		[["rebol","pseudocode"],["function_call","arctangent/radians",["$a"]]],
		[["wolfram","pseudocode","yacas"],["function_call","ArcTan",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"mysql","pseudocode","octave","c++","perl","php","julia","minizinc"],["function_call","atanh",["$a"]]],
		[["erlang","pseudocode","python"],[".",["math",["function_call","atanh",["$a"]]]]],
		[["wolfram","pseudocode"],["function_call","ArcTanh",["$a"]]],
		[["javascript","pseudocode","ruby"],[".",["math",["function_call","atanh",["$a"]]]]],
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"mysql","pseudocode","octave","c++","perl","php","julia","minizinc","fortran"],["function_call","acosh",["$a"]]],
		[["erlang","pseudocode","python"],[".",["math",["function_call","acosh",["$a"]]]]],
		[["wolfram","pseudocode"],["function_call","ArcCosh",["$a"]]],
		[["javascript","pseudocode","ruby"],[".",["math",["function_call","acosh",["$a"]]]]],
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"mysql","pseudocode","octave","c++","perl","php","julia","minizinc","fortran"],["function_call","asinh",["$a"]]],
		[["erlang","pseudocode","python"],[".",["math",["function_call","asinh",["$a"]]]]],
		[["wolfram","pseudocode"],["function_call","ArcSinh",["$a"]]],
		[["javascript","pseudocode","ruby"],[".",["math",["function_call","asinh",["$a"]]]]],
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"mysql","pseudocode","mathematical notation","reverse polish notation","prolog","haskell","tcl","c++","minizinc","php","perl","julia","octave"],
			["function_call","sinh",["$a"]]],
		[["wolfram","pseudocode"],
			["function_call","Sinh",["$a"]]],
		[["java","pseudocode","ruby","javascript","typescript","coffeescript","haxe"],
			[".",["Math",["function_call","sinh",["$a"]]]]],
		[["erlang","pseudocode","python","coconut","lua"],
			[".",["math",["function_call","sinh",["$a"]]]]],
		[["c#","pseudocode"],
			[".",["Math",["function_call","Sinh",["$a"]]]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"mysql","english","pseudocode","mathematical notation","reverse polish notation","prolog","haskell","tcl","c++","minizinc","php","perl","octave","julia"],
			["function_call","cosh",["$a"]]],
		[["java","pseudocode","ruby","javascript","typescript","coffeescript","haxe"],
			[".",["Math",["function_call","cosh",["$a"]]]]],
		[["erlang","pseudocode","python","coconut","lua"],
			[".",["math",["function_call","cosh",["$a"]]]]],
		[["c#","pseudocode"],
			[".",["Math",["function_call","Cosh",["$a"]]]]],
		[["wolfram","pseudocode"],
			["function_call","Cosh",["$a"]]],
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"mysql","fortran","english","pseudocode","mathematical notation","reverse polish notation","prolog","haskell","tcl","c++","minizinc","php","perl","octave","julia"],
			["function_call","tanh",["$a"]]],
		[["java","pseudocode","ruby","javascript","coffeescript","typescript","haxe"],
			[".",["Math",["function_call","tanh",["$a"]]]]],
		[["erlang","pseudocode","python","coconut","lua"],
			[".",["math",["function_call","tanh",["$a"]]]]],
		[["c#","pseudocode"],
			[".",["Math",["function_call","Tanh",["$a"]]]]],
		[["wolfram","pseudocode"],
			["function_call","Tanh",["$a"]]],
		]
	,matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["octave","pseudocode"],["function_call","perms",["$a"]]],
		[["wolfram","pseudocode"],["function_call","Permutations",["$a"]]],
		[["python","pseudocode","coconut"],
			[".",["itertools",["function_call","permutations",["$a"]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = [types[a],"[]"];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["r","pseudocode"],
			["function_call","median",["$a"]]],
		[["wolfram","pseudocode"],
			["function_call","Median",["$a"]]]
		]
	,matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["r","pseudocode","english"],
			["function_call","mean",["$a"]]],
		[["mysql"],
			["function_call","avg",["$a"]]],
		[["wolfram","pseudocode"],
			["function_call","Mean",["$a"]]],
		[["python","pseudocode","coconut"],
			[".",["statistics",["function_call","mean",["$a"]]]]],
		[["c#"],[".",["$a",["function_call","Average",[]]]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//$a is the needle, $b is the haystack
		[["php","pseudocode"],
			["function_call","array_search",["$a","$b"]]],
		[["python","pseudocode"],
			[".",["$b",["function_call","index",["$a"]]]]]
	],matching_symbols)){
		//var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		//types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["prolog","pseudocode"],["function_call","nonvar",["$a"]]],
		[["php","hack","pseudocode"],["function_call","isset",["$a"]]],
		[["perl","pseudocode"],["function_call","defined",["$a"]]],
		[["julia","pseudocode"],["function_call","isdefined",["$a"]]],
		[["javascript","pseudocode"],
			["!=","$a",[".",["undefined"]]]],
		[["emacs lisp"],
			["!=",["function_call","boundp",["$a"]],[".",["nil"]]]],
		[["lua","pseudocode"],
			["!=","$a",[".",["nil"]]]],
		[["python","coconut","pseudocode"],
			["!=","$a",[".",["None"]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(lang === "ruby"){
			to_return = "(defined?" + a + ")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript","pseudocode"],
			["==","$a",[".",["undefined"]]]],
		[["lua","pseudocode"],
			["==","$a",[".",["nil"]]]],
		[["prolog","pseudocode"],
			["function_call","var",["$a"]]],
		[["python","coconut","pseudocode"],
			["==","$a",[".",["None"]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang["php","hack"])){
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
		[["prolog"],
			["function_call","integer",["$a"]]],
		[["php","pseudocode"],
			["function_call","is_int",["$a"]]],
		[["python","pseudocode"],
			["function_call","isinstance",["$a","\"int\""]]]
	]
	,matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(lang==="javascript"){
			to_return = "Number.isInteger("+a+")";
		}
		if(lang==="javascript"){
			to_return = "Number.isInteger("+a+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript","python","perl","php","frink","ruby"],
			["function_call","eval",["$a"]]],
		[['d'],
			["function_call","mixin",["$a"]]],
		[["mathematica"],
			["function_call","ToExpression",["$a"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "Object";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["python"],
			["function_call","float",["inf"]]],
		[["c++","c"],
			["INFINITY"]],
		[["php"],
			["INF"]],
		[["sage","sympy"],
			["oo"]],
		[["lua"],
			["/","1","0"]],
		[["matlab","julia","r"],
			["Inf"]],
		[["javascript","wolfram"],
			["Infinity"]],
		[["javascript"],
			[".",["Number","POSITIVE_INFINITY"]]],
		[["java","scala","kotlin","groovy"],
			[".",["Double","POSITIVE_INFINITY"]]],
		[["swift"],
			[".",["Double","infinity"]]],
		[["c#"],
			[".",["Double","PositiveInfinity"]]]
	],matching_symbols)){
		if(lang === "ruby"){
			to_return = "Float::INFINITY";
		}
		else if(lang === "scheme"){
			to_return = "+inf.0";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","kotlin"],
			[".",["Double","NEGATIVE_INFINITY"]]],
		[["c#"],
			[".",["Double","NegativeInfinity"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//derivative of a function
		//$a is the expression, $b is the variable
		[["sympy","maxima","maple","reduce"],
			["function_call","diff",["$a","$b"]]],
		[["sage","english"],
			["function_call","derivative",["$a","$b"]]],
		[["wolfram","symja"],
			["function_call","D",["$a","$b"]]],
		[["symbolicc++"],
			["function_call","df",["$a","$b"]]]
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
		//integrate 'a' with respect to 'b'
		[["maxima","english","sympy","sage","symbolicc++","symja"],
			["function_call","integrate",["$a","$b"]]],
		[["maple","reduce"],
			["function_call","int",["$a","$b"]]],
		[["wolfram"],
			["function_call","Integrate",["$a","$b"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//sum of items in array
		[["erlang"],
			[".",["lists",["function_call","sum",["$a"]]]]],
		[["fortran"],
			["function_call","sum",["$a"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//error function
		[["wolfram"],
			["function_call","Erf",["$a"]]],
		[["matlab","maple","fortran"],
			["function_call","erf",["$a"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//error function
		[["wolfram"],
			["function_call","Erfc",["$a"]]],
		[["maple","fortran"],
			["function_call","erfc",["$a"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//imaginary error function
		[["wolfram"],
			["function_call","Erfi",["$a"]]],
		[["maple"],
			["function_call","erfi",["$a"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	//prepend an item to an arraylist (in-place)
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["python"],[".",["$a",["function_call","insert",["0","$b"]]]]],
		[["perl"],["function_call","unshift",["$a","$b"]]],
		[["php"],["function_call","array_unshift",["$a","$b"]]],
		[["c#"],[".",["$a",["function_call","Insert",["0","$b"]]]]],
		[["javascript","ruby","haxe"],[".",["$a",["function_call","unshift",["$b"]]]]],
		[["c++"],[".",["$a",["function_call","push_front",["$b"]]]]]
	],matching_symbols)){
		if(lang === "scala"){
			to_return = generate_code(input_lang,lang,indent,matching_symbols["$a"]) + " :+ " + generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		}
		else if(lang === "wolfram"){
			var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
			var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
			to_return = a + " = Prepend["+a+","+b+"]";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "double";
	}
	//append an item to an arraylist (in-place)
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["$a",["function_call","add",["$b"]]]]],
		[["c++"],[".",["$a",["function_call","push_back",["$b"]]]]],
		[["lua"],[".",["table",["function_call","insert",["$a","$b"]]]]],
		[["javascript","typescript"],[".",["$a",["function_call","push",["$b"]]]]],
		[["php","hack","english"],["function_call","array_push",["$a","$b"]]],
		[["perl"],["function_call","push",["$a","$b"]]],
		[["wolfram"],["set_var","$a",["function_call","Append",["$a","$b"]]]]
	],matching_symbols)){
		if(lang === "scala"){
			to_return = generate_code(input_lang,lang,indent,matching_symbols["$a"]) + " +: " + generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		}
		else if(lang === "mysql"){
			to_return = "INSERT INTO " + generate_code(input_lang,lang,indent,matching_symbols["$a"]) + "(" + generate_code(input_lang,lang,indent,matching_symbols["$b"])+")";
		}
		else if(lang === "bash"){
			to_return = generate_code(input_lang,lang,indent,matching_symbols["$a"]) + " += " + generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		}
		else if(lang === "wolfram"){
			var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
			var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
			to_return = a + " = Append["+a+","+b+"]";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["english"],
			["&&",["distance","between","$a"],"$b"]],
		[["wolfram"],
			["function_call","EuclideanDistance",["$a","$b"]]],
		[["glsl","english"],
			["function_call","distance",["$a","$b"]]],
		[["octave"],["function_call","norm",[["-","$a","$b"],[".",["2"]]]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//array of parameters in the current function
		//[["javascript"],"arguments"],
		[["javascript"],["access_array","arguments",["$a"]]],
		[["perl"],["access_array","@_",["$a"]]],
		[["php"],["access_array",["function_call","func_get_args",[]],["$a"]]]
	],matching_symbols)){
		if(lang === "bash"){
			to_return = "$"+generate_code(input_lang,lang,indent,matching_symbols["$a"])
		}
		else{
			to_return = generate_code(input_lang,lang,indent,pattern_array.value);
		}
		types[to_return] = ["Object","[]"];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//array of parameters in the current function
		//[["javascript"],"arguments"],
		[["javascript"],[".",["arguments"]]],
		[["perl"],"@_"],
		[["perl"],[".",["@_"]]],
		[["php"],["function_call","func_get_args",[]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = ["Object","[]"];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
			//natural logarithm
			[["java","scala","javascript","haxe","ruby","typescript","coffeescript","typescript"],[".",["Math",["function_call","log",["$a"]]]]],
			[["c#","visual basic .net"],[".",["Math",["function_call","Log",["$a"]]]]],
			[["python","cython","coconut","lua","haskell","erlang"],[".",["math",["function_call","log",["$a"]]]]],
			[["c","mysql","tcl","c++","hlsl","r","perl","awk","sympy","maxima","php","prolog","swift","julia","common lisp","octave"],["function_call","log",["$a"]]],
			[["autohotkey","go","gap","wolfram"],["function_call","Log",["$a"]]],
			[["minizinc","standard ml","reverse polish notation","mathematical notation"],["function_call","ln",["$a"]]],
			[["yacas"],["function_call","Ln",["$a"]]],
			[["rebol"],["function_call","log-e",["$a"]]],
			[["perl 6"],[".",["$a","log"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["sql","mysql","seed7","sage","symja","pari/gp","pseudocode","english","standard ml","opencl","glsl","mathematical notation","reverse polish notation","r","tcl","sympy","reduce","minizinc",'c',"ocaml","erlang","picat","mathematical notation","julia",'d',"php","perl","perl 6","maxima","fortran","minizinc","swift","prolog","octave","dart","haskell","c++","scala"],
			["function_call","sin",["$a"]]],
		[["java","pseudocode","ruby","javascript","coffeescript","typescript","haxe","clojure"],
			[".",["Math",["function_call","sin",["$a"]]]]],
		[["rebol"],
			["function_call","sine/radians",["$a"]]],
		[["c#","visual basic .net","pseudocode"],
			[".",["Math",["function_call","Sin",["$a"]]]]],
		[["python","coconut","cython","lua","erlang","pseudocode"],
			[".",["math",["function_call","sin",["$a"]]]]],
		[["go","wolfram","yacas","autohotkey","pseudocode"],
			["function_call","Sin",["$a"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[['c',"c++","fortran","php"],
			["function_call","hypot",["$a"]]],
		[["java","ruby","javascript"],
			[".",["Math",["function_call","hypot",["$a"]]]]],
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript"],
			[".",["$a",["function_call","apply",[[".",["this"]],"$b"]]]]
		],
		[["php"],
			["function_call","call_user_func_array",["$a","$b"]]],
		[["prolog"],
			["function_call","call",["$a","$b"]]],
		[["lua"],
			["function_call","$a",[[".",[["function_call","unpack",["$b"]]]]]]
		]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["php"],
			["function_call","json_encode",["$a"]]],
		[["javascript"],
			[".",["JSON",["function_call","stringify",["$a"]]]]],
		[["python"],
			[".",["json",["function_call","dumps",["$a"]]]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["php"],
			["function_call","json_decode",["$a"]]],
		[["perl"],
			["function_call","decode_json",["$a"]]],
		[["javascript"],
			[".",["JSON",["function_call","parse",["$a"]]]]],
		[["python"],
			[".",["json",["function_call","loads",["$a"]]]]]
	]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "Object";
	}
	else if(input_lang === "javascript" && matches_pattern(arr,["==",["parentheses",["typeof","$a"]],"$b"],matching_symbols)){
		to_return = generate_code(input_lang,lang,indent,["instanceof",matching_symbols["$a"],matching_symbols["$b"]])
	}
	else if(input_lang === "javascript" && matches_pattern(arr,["==",["typeof","$a"],"$b"],matching_symbols)){
		to_return = generate_code(input_lang,lang,indent,["instanceof",matching_symbols["$a"],matching_symbols["$b"]])
	}
	else if(input_lang === "javascript" && matches_pattern(arr,["==",["typeof",[".",[["parentheses","$a"]]]],"$b"],matching_symbols)){
		to_return = generate_code(input_lang,lang,indent,["instanceof",matching_symbols["$a"],matching_symbols["$b"]])
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["mysql","pl/sql","matlab","maple",'c',"c++"],
			["function_call","sign",["$a"]]],
		[["yacas","wolfram"],
			["function_call","Sign",["$a"]]],
		[["javascript"],
			[".",["Math",["function_call","sign",["$a"]]]]],
		[['c',"c++"],[".",[["parentheses",["-",[".",[["parentheses",[">","$a",[".",["0"]]]]]],[".",[["parentheses",["<","$a",[".",["0"]]]]]]]]]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//see https://rosettacode.org/wiki/Factorial
		[["sage","maple","matlab","octave","frink"],
			["function_call","factorial",["$a"]]]
		]
	,matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["maxima","mathematica"])){
			to_return = "("+a + ")!";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "int";
	}
	
	
	else if(member(lang,["minizinc","smt-lib"]) &&
		matches_pattern(arr,["for",["initialize_var","int","$a","$c"],["<",[".",["$a"]],"$d"],["++","$a"],"$b"],matching_symbols)
	){
		types[matching_symbols["$a"]] = "int";
		types[var_name(lang,input_lang,matching_symbols["$a"])] = "int";
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		//alert(a);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		var d = generate_code(input_lang,lang,indent,matching_symbols["$d"]);

		//to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		if(member(lang,["minizinc"])){
			to_return = "forall("+a+" in ["+c+".."+d+"-1])("+b+")";
		}
		else if(member(lang,["smt-lib"])){
			to_return = "(forall ("+a+" (Int)) (=> ((>= "+a+" "+c+") (< "+a+" "+d+") +"+b+"))";
		}
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["prolog"],
			["function_call","append",["$a","$b","$c"]]],
		[["reasoned-php"],
			["function_call","appendo",["$a","$b","$c"]]],
		[["perl"],["==","$c",[".","$a","$b"]]],
		[["perl"],["==",[".","$a","$b"],"$c"]],
		[["lua"],["==","$c",["..","$a","$b"]]],
		[["lua"],["==",["..","$a","$b"],"$c"]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		if(lang === "haskell"){
			to_return = "("+a+"++"+b+" == "+c+")";
		}
		else if(lang === "lua"){
			//only works for strings
			to_return = "("+a+".."+b+" == "+c+")";
		}
		else if(lang === "java"){
			//only works for strings
			to_return = "("+a+" + "+b+").equals("+c+")";
		}
		else if(member(lang,["ruby"])){
			to_return = "("+a+" + "+b+" == "+c+")";
		}
		else if(member(lang,["javascript"])){
			//only works for strings
			to_return = "("+a+" + "+b+" === "+c+")";
		}
		else if(member(lang,["php","hack","perl"])){
			//only works for strings
			to_return = "("+a+"."+b+" == "+c+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["prolog"],
			["function_call","number_codes",["$a","$b"]]]
		]
	,matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(lang === "python"){
			to_return = "("+a+" == int("+b+"))";
		}
		else if(lang === "javascript"){
			to_return = "("+a+" === Number("+b+"))";
		}
		else if(lang === "c"){
			to_return =  "(" + a + " == ((int) strtol("+b+", (char **)NULL, 10)))";
		}
		else if(lang === "ruby"){
			to_return = "("+a+" == ("+b+").to_i)";
		}
		else if(lang === "java"){
			to_return = "("+a+" == Double.parseDouble("+b+"))";
		}
		else if(member(lang,["php","hack"])){
			to_return = "("+a+" === floatval("+b+"))";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["ruby","python","javascript","minizinc"],["parentheses",["==",[".",[["access_array","$b",["$a"]]]],"$c"]]],
		[["prolog"],
			["function_call","nth0",["$a","$b","$c"]]]
	]
	,matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["lua"],["parentheses",["==",[".",[["access_array","$b",["$a"]]]],"$c"]]],
		[["prolog"],
			["function_call","nth1",["$a","$b","$c"]]]
	]
	,matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["prolog"],
			["function_call","findall",["$a",["function_call","member",["$a","$b"]],"$c"]]]
	]
	,matching_symbols)){
		var the_var = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var result = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);

		if(member(lang,["haskell"])){
			to_return = "("+c+" == ["+the_var+" | "+the_var+"->"+result+"])";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["prolog"],
			["list_head_tail","Object","$a","$b"]]
	]
	,matching_symbols)){
		//alert(JSON.stringify(matching_symbols["$a"]));
		//alert(JSON.stringify(matching_symbols["$b"]));
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(lang==="prolog"){
			to_return = "["+a+"|"+b+"]";
		}
		else if(lang==="common prolog"){
			to_return = "("+a+" . "+b+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "Object";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["prolog"],
			["function_call","number",["$a"]]],
		[["php","pseudocode"],
			["function_call","is_numeric",["$a"]]],
		[["english","python"],
			["==",["function_call","type",["$a"]],"int"]]
	]
	,matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(lang==="javascript"){
			to_return = "(typeof "+a+" === \"number\")";
		}
		else if(lang==="lua"){
			to_return = "(type("+a+") === \"number\")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript","pseudocode","smt-lib","java","scala",'c',"c++","lua","swift","php","ceylon","clojure",'d'],
			["function_call","assert",["$a"]]],
		[["r"],
			["function_call","stopifnot",["$a"]]],
		[["minizinc"],
			["function_call","constraint",["$a"]]],
		[["visual basic .net","c#"],
			[".",["Debug",["function_call","Assert",["$a"]]]]],
		]
	,matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang, ["python","coconut","cython","haskell","java"])){
			to_return = "assert " + a;
		}
		else if(member(lang,["reverse polish notation","mathematical notation","prolog"])){
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
		[["maple","swift"],
			["function_call","readline",[]]],
		[["sidef"],
			["function_call","read",["String"]]],
		[["seed7"],
			["function_call","readln",["string_input"]]],
		[["ocaml"],
			["function_call","read_line",[]]],
		[["ruby"],
			[".","gets"]],
		[["perl"],
			[".","<>"]],
		[["scala"],[".",["console","readLine"]]],
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
		[["python","coconut","matlab"],
			["function_call","input",["$a"]]],
		[["erlang"],
			[".",["io",["function_call","fread",["$a","\"~s\""]]]]],
		[["wolfram"],
			["function_call","InputString",["$a"]]],
		[["perl 6"],
			["function_call","prompt",["$a"]]],
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//generate range of numbers from a (inclusive) to b (inclusive)
		[["php"],
			["function_call","range",["$a","$b"]]],
		[["wolfram"],
			["function_call","Range",["$a","$b"]]],
		]
	,matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["ruby"])){
			to_return = "("+a+" .. "+b+").to_a";
		}
		else if(member(lang,["perl","minizinc"])){
			to_return = "("+a+" .. "+b+")";
		}
		else if(member(lang,["r"])){
			to_return = "("+a+":"+b+")";
		}
		else if(member(lang,["haskell"])){
			to_return = "["+a+" .. "+b+"]";
		}
		else if(member(lang,["python","cython","coconut"])){
			to_return = "range("+a+", "+b+"+1)";
		}
		else if(member(lang,["php","hack"])){
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = ["int","[]"];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","javascript","typescript","coffeescript","haxe","ruby"],[".",["Math",["function_call","sqrt",["$a"]]]]],
		[["python","coconut","cython","lua"],[".",["math",["function_call","sqrt",["$a"]]]]],
		[["go","wolfram","yacas"],["function_call","Sqrt",["$a"]]],
		[["c#"],[".",["Math",["function_call","Sqrt",["$a"]]]]],
		[["sympy"],[".",["sympy",["function_call","sqrt",["$a"]]]]],
		[['c',"kotlin","fortran","mysql","english","algebrite","symja","tcl","c++","reduce","sidef","seed7","julia","perl","php","perl 6","maxima","minizinc","prolog","octave","matlab",'d',"haskell","swift","mathematical notation","dart","picat","reverse polish notation","rebol"],["function_call","sqrt",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript",'c',"c++","java"],[".",["Math",["function_call","cbrt",["$a"]]]]],
		[['c',"c++"],["function_call","cbrt",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript","pseudocode","coffeescript","java","typescript","haxe","actionscript","scala"],[".",["Math",["function_call","pow",["$a","$b"]]]]],
		[["erlang","pseudocode"],[".",["math",["function_call","pow",["$a","$b"]]]]],
		[["rebol","pseudocode"],[".",["math",["function_call","power",["$a","$b"]]]]],
		[["c#","pseudocode","visual basic .net"],[".",["Math",["function_call","Pow",["$a","$b"]]]]],
		[['c',"glsl","english","pseudocode","perl","tcl","c++","php","hack","swift","minizinc","dart",'d',"sidef"],["function_call","pow",["$a","$b"]]],
		[["hy","pseudocode","common lisp","racket","clojure"],["function_call","expt",["$a","$b"]]],
		[["clips","pseudocode","mathematical notation"],["function_call","**",["$a","$b"]]],
		[["lua","sage","pseudocode","julia","wolfram","english","asciimath"],["^","$a","$b"]],
		[["ruby","pseudocode","haskell","ada","fortran"],["**","$a","$b"]]
	],matching_symbols)){
		var arr1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var arr2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["seed7","coffeequate","mysql",'pl/sql',"prolog","sympy","python","coconut","cython","ruby","chapel","haskell",'cobol',"picat","ooc","ooc","rexx","maxima","awk","r","f#","autohotkey","tcl","autoit","groovy","octave","perl","perl 6","fortran"])){
			to_return = "(("+arr1+")**"+arr2+")";
		}
		else if(member(lang,["julia","sage","yacas","algebrite","symja","mathematical notation","matlab","english","reduce","lua","engscript","visual basic","gambas","ceylon","wolfram","mathematical notation"])){
			to_return = "((" + arr1 + ")^(" + arr2 + "))";
		}
		else if(member(lang,["tex"])){
			to_return = arr1 + "^{" + arr2 + "}";
		}
		else if(member(lang,["reverse polish notation"])){
			to_return = arr1 + " " + arr2 + " ^";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//reverse an array (not in-place)
		[["javascript","haxe","coffeescript","typescript"],[".",["$a",["function_call","split",[[".",["\"\""]]]],["function_call","reverse",[]],["function_call","join",[[".",["\"\""]]]]]]],
		[["php","pseudocode"],["function_call","array_reverse",["$a"]]],
		[["perl","pseudocode","julia","rebol","frink"],["function_call","reverse",["$a"]]],
		[["ruby"],[".",["$a","reverse"]]],
		[["python","pseudocode","coconut"],["function_call","reversed",["$a"]]],
		[["erlang"],[".",["lists",["function_call","reverse",["$a"]]]]],
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		//same_var_type(to_return,a);
	}
	else if(member(input_lang,["php","hack"]) && matches_pattern(arr,["function_call","array","$a"],matching_symbols)){
		return generate_code(input_lang,lang,indent,["initializer_list","Object",matching_symbols["$a"]]);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","pseudocode","javascript","haxe","typescript","coffeescript"],[".",["$a",["function_call","toUpperCase",[]]]]],
		[["rust","pseudocode","picat"],[".",["$a",["function_call","to_uppercase",[]]]]],
		[["lua","pseudocode"],[".",["string",["function_call","toUpperCase",["$a"]]]]],
		[["go","pseudocode"],[".",["string",["function_call","ToLower",["$a"]]]]],
		[["julia","rebol","pseudocode"],["function_call","uppercase",["$a"]]],
		[["transact-sql","mysql"],["function_call","upper",["$a"]]],
		[["c#","visual basic .net","pseudocode"],[".",["$a",["function_call","ToUpper",[]]]]],
		[["swift","pseudocode"],[".",["$a",["function_call","uppercased",[]]]]],
		[["python","coconut","cython","pseudocode"],[".",["$a",["function_call","upper",[]]]]],
		[["php","pseudocode"],["function_call","strtoupper",["$a"]]],
		[["wolfram","pseudocode"],["function_call","ToUpperCase",["$a"]]],
		[["r","octave","tcl","pseudocode"],["function_call","toupper",["$a"]]],
		[["haskell","pseudocode"],["function_call","toUpper",["$a"]]],
		[["perl","pseudocode"],["function_call","uc",["$a"]]],
		[["newlisp","pseudocode"],["function_call","upper-case",["$a"]]],
		[["erlang","pseudocode"],["function_call","string:uppercase",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["scala"])){
			to_return = a+".toUpperCase";
		}
		else if(member(lang,["ruby"])){
			to_return = a+".upcase";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "String";
	}
		else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//convert a string to uppercase or lowercase
		[["java","pseudocode","javascript","haxe","typescript","coffeescript"],[".",["$a",["function_call","toLowerCase",[]]]]],
		[["rust","pseudocode","picat"],[".",["$a",["function_call","to_lowercase",[]]]]],
		[["c#","pseudocode","visual basic .net"],[".",["$a",["function_call","ToLower",[]]]]],
		[["swift","pseudocode"],[".",["$a",["function_call","lowercased",[]]]]],
		[["python","pseudocode","cython","coconut"],[".",["$a",["function_call","lower",[]]]]],
		[["php","pseudocode"],["function_call","strtolower",["$a"]]],
		[["julia","pseudocode","rebol"],["function_call","lowercase",["$a"]]],
		[["perl","pseudocode"],["function_call","lc",["$a"]]],
		[["transact-sql","mysql"],["function_call","lc",["$a"]]],
		[["haskell","pseudocode"],["function_call","toLower",["$a"]]],
		[["octave","pseudocode","r","tcl"],["function_call","tolower",["$a"]]],
		[["lua","pseudocode"],[".",["string",["function_call","lower",["$a"]]]]],
		[["go","pseudocode"],[".",["strings",["function_call","ToLower",["$a"]]]]],
		[["wolfram","pseudocode"],[".",["strings",["function_call","ToLowerCase",["$a"]]]]],
		[["erlang","pseudocode"],["function_call","string:lowercase",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["scala"])){
			to_return = a+".toLowerCase";
		}
		else if(member(lang,["ruby"])){
			to_return = a+".downcase";
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
		//$a is the list, $b is in the list
		matching_patterns(pattern_array,input_lang,lang,arr,[
			[["java","pseudocode"],[".",[[".",["Arrays",["function_call","asList",["$a"]]]],["function_call","contains",["$b"]]]]],
			[["javascript","typescript","coffeescript","pseudocode"],["!=",[".",["$a",["function_call","indexOf",["$b"]]]],["-",[".",["1"]]]]],
			[["php","hack","pseudocode"],["function_call","in_array",["$b","$a"]]],
			[["wolfram","pseudocode"],["function_call","MemberQ",["$a","$b"]]],
			[["prolog"],["function_call","member",["$a","$b"]]]
		],matching_symbols)
	){
		var a2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(matching_symbols["$a"][0] === "initializer_list" && member(lang,["smt-lib","clips"])){
			to_return = "(or " + matching_symbols["$a"][2].map(function(a){
			return "(= "+a2+" " +generate_code(input_lang,lang,indent,a)+")";
		}).join(" ")+")";
		}
		else{
			var a1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
			to_return = array_contains(lang,a1,a2);
		}
		types[to_return] = "boolean";
	}
	else if(
		//get last index of a substring
		matching_patterns(pattern_array,input_lang,lang,arr,[
			[["haxe","javascript","typescript","coffeescript","java","pseudocode"],[".",["$a",["function_call","LastIndexOf",["$b"]]]]],
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
			[["java","haxe","javascript","typescript","coffeescript","pseudocode"],[".",["$a",["function_call","indexOf",["$b"]]]]],
			[["go","pseudocode"],[".",["strings",["function_call","Index",["$a","$b"]]]]],
			[["ruby","pseudocode"],[".",["strings",["function_call","index",["$a","$b"]]]]],
			[["lua","pseudocode"],[".",["string",["function_call","find",["$a","$b"]]]]],
			[["c#","visual basic .net","pseudocode"],[".",["$a",["function_call","IndexOf",["$b"]]]]],
			[["python","coconut","ruby","pseudocode"],[".",["$a",["function_call","index",["$b"]]]]],
			[["perl","pseudocode"],["function_call","index",["$a","$b"]]],
			[["php","pseudocode"],["function_call","strpos",["$a","$b"]]]
		],matching_symbols)
	){
		var a1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var a2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(arr[0] === "iff"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["alt-ergo","minizinc","prover9"])){
			to_return = a+" <-> "+b;
		}
		if(member(lang,["asciimath"])){
			to_return = a+" <=> "+b;
		}
		else if(member(lang,["smt-lib"])){
			to_return = "(= "+a+" "+b+")";
		}
		types[to_return] = "boolean";
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
		else if(member(lang,["java",'prover9',"sentient","glsl","yacas","minizinc","ruby","python","coconut","cosmos","nim","octave","r","picat","englishscript","perl 6","wolfram",'c',"c++",'d',"c#","julia","perl","haxe","cython","minizinc","scala","swift","go","rust","vala"])){
			to_return = a + " != " + b;
		}
		else if(member(lang,["lua","matlab","inform 6"])){
			to_return = a + " ~= " + b;
		}
		else if(member(lang,["mysql",'autohotkey',"alt-ergo",'pl/sql',"elixir","rebol","wolfram","purescript","ocaml","standard ml","coq","seed7"])){
			to_return = a + " <> " + b;
		}
		else if(member(lang,["haskell"])){
			to_return = a + " /= " + b;
		}
		else if(member(lang,["fortran"])){
			to_return = a + " .ne. " + b;
		}
		else if(member(lang,["haskell"])){
			to_return = "neq(" + a + "," + b + ")";
		}
		else if(member(lang,["clips"])){
			to_return = "(neq " + a + " " + b + ")";
		}
		else if(member(lang,["prolog","constraint handling rules"])){
			to_return = "dif(" + a + "," + b + ")";
		}
		else if(member(lang,["php","javascript","typescript","coffeescript"])){
			to_return = a + " !== " + b;
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "continue" && arr.length === 1){
		if(member(lang,["javascript","java","python","coconut","php","hack","haxe","c","c++","c#"])){
			to_return = "continue";
		}
		if(member(lang,["ruby","perl"])){
			to_return = "next";
		}
	}
	else if(arr[0] === "break" && arr.length === 1){
		if(member(lang,["javascript","typescript","coffeescript","java","python","coconut","php","hack","haxe","c","c++","c#"])){
			to_return = "break";
		}
	}
	else if(arr[0] === "!"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			set_var_type(input_lang,lang,a,"boolean");
		}
		if(member(lang,["java","chapel","tcl","autohotkey","ruby","perl 6","katahdin","coffeescript","frink",'d',"ooc","ceylon","processing","janus","pawn","autohotkey","groovy","scala","hack","rust","octave","typescript","julia","awk","swift","scala","vala","nemerle","pike","perl",'c',"c++","objective-c","tcl","javascript","r","dart","java","go","php","haxe","c#","wolfram"])){
			to_return = "!"+a;
		}
		else if(member(lang,["python","alt-ergo","coconut","scheme","smt-lib","lua","cython","pddl","mathematical notation","emacs lisp","minizinc","picat","genie","seed7","smt-lib","idp","maxima","clips","engscript","hy","ocaml","clojure","erlang","pascal","delphi","f#","ml","racket","common lisp","rebol","haskell","sibilant"])){
			to_return = "(not "+a+")";
		}
		else if(member(lang,["visual basic","visual basic .net","autoit","livecode","monkey x","vbscript"])){
			to_return = "(Not "+a+")";
		}
		else if(member(lang,["coq","matlab"])){
			to_return = "~"+a;
		}
		else if(member(lang,["prolog"])){
			to_return = "\\+"+a;
		}
		else if(member(lang,["reverse polish notation"])){
			to_return = a+" not";
		}
		else if(member(lang,["z3py","yacas"])){
			to_return = "Not("+a+")";
		}
		types[to_return] = types[a];
	}
	else if(arr[0] === "function_call_ref"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,["c#"])){
			to_return = "ref "+a;
		}
		else if(member(lang,["php","prolog","pydatalog","minizinc","fortran","glsl"])){
			//for all declarative programming languages
			to_return = a;
		}
		else if(member(lang,['c',"c++"])){
			to_return = "&"+a;
		}
		types[to_return] = types[a];
	}
	else if(arr[0] === "await"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,["c#","javascript","python","coconut","typescript"])){
			to_return = "await "+a;
		}
		same_var_type(to_return,a);
	}
	else if(arr[0] === "parentheses"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(infix_arithmetic_lang(lang) || member(lang,["tex","regex","antlr","jison"])){
			to_return = "("+a+")";
		}
		else{
			to_return = a;
		}
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",[[".",[["new","StringBuilder",["$a"]],["function_call","reverse",[]]]],["function_call","toString",[]]]]],
		[["javascript","haxe","coffeescript","typescript"],[".",["$a",["function_call","split",[[".",["\"\""]]]],["function_call","reverse",[]],["function_call","join",[[".",["\"\""]]]]]]],
		[["php"],["function_call","strrev",["$a"]]],
		[["python","coconut","common lisp","haskell"],["function_call","reversed",["$a"]]],
		[["mysql"],["function_call","reverse",["$a"]]],
		[["scala"],[".",["$a","reverse"]]],
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
		if(member(lang,["javascript","python","coconut","ruby","lua"])){
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
		if(member(lang,["javascript","coffeescript","typescript","php","lua","c++","haxe","c#","ruby","python","coconut","haxe","swift"])){
			to_return = a+"["+b+"] ="+c;
		}
		else if(member(lang,["scala"])){
			to_return = a+"("+b+") ="+c;
		}
		else if(member(lang,["prolog"])){
			to_return = "member("+b+":"+c+","+a+")";
		}
		else if(member(lang,["perl"])){
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
		if(member(lang,["javascript","python","coconut"])){
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
		else if(member(lang,["python","coconut"])){
			to_return = "(type("+a+") == list)";
		}
		else if(member(lang,["php","hack"])){
			to_return = "is_array("+a+")";
		}
		else if(member(lang,["ruby"])){
			to_return = "("+a+".instance_of? Array)";
		}
		types[to_return] = "boolean";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//javascript array concatenation
		[["javascript"],[".",["$a",["function_call","concat",["$b"]]]]],
		[["r"],["function_call","c",["$a","$b"]]]
	],matching_symbols)){
		var a = matching_symbols["$a"];
		var b = matching_symbols["$b"];
		if(member(lang, ["python","coconut","ruby"])){
			return generate_code(input_lang,lang,indent,["+",a,b]);
		}
		else if(member(lang, ["javascript","r"])){
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
		[["javascript","java"],[".",["$a",["function_call","trim",[]]]]],
		[["c#"],[".",["$a",["function_call","Trim",[]]]]],
		[["python","coconut"],[".",["$a",["function_call","strip",[]]]]],
		[["ruby"],[".",["$a","strip"]]],
		[["perl 6"],[".",["$a","trim"]]],
		[["php","mysql"],["function_call","trim",["$a"]]],
		[["octave"],["function_call","strtrim",["$a"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript","typescript"],
			[".",["$a",["function_call","hasOwnProperty",["$b"]]]]],
		[["ruby"],
			[".",["$a",["function_call","key?",["$b"]]]]],
		[["haxe"],
			[".",["$a",["function_call","exists",["$b"]]]]],
		[["php"],
			["function_call","array_key_exists",["$b","$a"]]],
		[["c#"],
			[".",["$a",["function_call","containsKey",["$b"]]]]],
		[["c++","scala"],
			[".",["$a",["function_call","find",["$b"]]]]],
		[["javascript","typescript","python"],
			["in","$b","$a"]],
		[["swift"],
			["!=",[".",[["access_array","$a",["$b"]]]],[".",["nil"]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["python","coconut","mysql"])){
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
		[["c#"],[".",["$a",["function_call","TrimEnd",[]]]]],
		[["python","coconut"],[".",["$a",["function_call","rstrip",[]]]]],
		[["ruby"],[".",["$a","rstrip"]]],
		[["php","mysql"],["function_call","rtrim",["$a"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["c#"],[".",["$a",["function_call","TrimStart",[]]]]],
		[["python","coconut"],[".",["$a",["function_call","lstrip",[]]]]],
		[["ruby"],[".",["$a","lstrip"]]],
		[["php","mysql"],["function_call","ltrim",["$a"]]]
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
		[["javascript","coffeescript","haxe","groovy","java","typescript","rust","dart","ruby"],
			[".",["$a",["function_call","join",["$b"]]]]],
		[["python","hy","coconut"],
			[".",["$b",["function_call","join",["$a"]]]]],
		[["scala"],
			[".",["$a",["function_call","mkstring",["$b"]]]]],
		[["go"],
			[".",["Strings",["function_call","join",["$a","$b"]]]]],
		[["c#"],
			[".",["String",["function_call","Join",["$b","$a"]]]]],
		[["erlang"],
			[".",["String",["function_call","join",["$b","$a"]]]]],
		[["php"],
			["function_call","implode",["$b","$a"]]],
		[["coq"],
			["function_call","concat",["$a","$b"]]],
		[["perl"],
			["function_call","join",["$b","$a"]]],
		[['d',"julia"],
			["function_call","join",["$a","$b"]]],
		[["haskell"],
			["function_call","intersperse",["$b","$a"]]],
	],matching_symbols)){
		var a_string_list = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var a_separator = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["ocaml"])){
			to_return = "(String.join "+a_string_list+" ~sep:"+a_separator+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		// $a is the string, $b is the separator
		[["javascript","ruby","coffeescript","java","dart","scala","groovy","haxe","rust","typescript","python","coconut","cython","vala"],
			[".",["$a",["function_call","split",["$b"]]]]],
		[["go"],
			[".",["strings",["function_call","split",["$a","$b"]]]]],
		[["erlang"],
			[".",["string",["function_call","tokens",["$a","$b"]]]]],
		[["visual basic .net"],
			[".",["$a",["function_call","Split",["$b"]]]]],
		[["visual basic .net"],
			[".",["string",["function_call","split",["$a","$b"]]]]],
		[["swift"],
			[".",["$a",["function_call","componentsSeparatedByString",["$b"]]]]],
		[["perl","processing"],
			["function_call","split",["$b","$a"]]],
		[["picat",'d',"julia","maxima"],
			["function_call","split",["$a","$b"]]],
		[["haskell"],
			["function_call","splitOn",["$a","$b"]]],
		[["octave"],
			["function_call","strsplit",["$a","$b"]]],
		[["transact-sql"],
			["function_call","string_split",["$a","$b"]]],
		[["wolfram"],
			["function_call","StringSplit",["$a","$b"]]],
		[["php","hack"],
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
		else if(member(lang,["ocaml"])){
			to_return = "(String.split "+a_string+" ~on:"+a_separator+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = ["String","[]"];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//get random from a (inclusive) to b (exclusive)
		[["python","coconut"],[".",["random",["function_call","randrange",["$a","$b"]]]]],
		[["php","hack"],["function_call","rand",["$a","$b"]]],
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
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//shuffle array without modifying original array
		[["ruby"],[".",["$a","shuffle"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//shuffle array in-place
		[["php","hack"],["function_call","shuffle",["$a"]]],
		[["python","coconut"],[".",["random",["function_call","shuffle",["$a"]]]]],
		[["haxe"],[".",["Random",["function_call","shuffle",["$a"]]]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//get random number between 0 and 1
		[["octave"],["function_call","random",["1"]]],
		[["java","javascript","coffeescript","typescript"],[".",["Math",["function_call","random",[]]]]],
		[["python","coconut"],[".",["random",["function_call","random",[]]]]],
		[["ruby",'c',"c++"],["function_call","rand",[]]],
		[["perl"],["function_call","rand",["1"]]],
		[["wolfram"],["function_call","RandomReal",[]]],
		[["tcl"],["function_call","rand",[]]]
	],matching_symbols)){
		if(member(lang,['c'])){
			to_return = "((double)rand() / (double)RAND_MAX)";
		}
		else if(member(lang,["php"])){
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
	else if(input_lang === "javascript" && (arr[0] === "typeof")){
		var expr = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,["python","lua"])){
			to_return = "type("+expr+")";
		}
		else if(member(lang,["php"])){
			to_return = "gettype("+expr+")";
		}
		else if(member(lang,["javascript"])){
			to_return = "(typeof "+expr+")";
		}
		types[to_return] = "String";
	}
	else if(arr[0] === "instanceof"){
		var expr = generate_code(input_lang,lang,indent,arr[1]);
		var type = arr[2];
		if(type[0] === "\""){
			type = type.substring(1,type.length-1);
		}
		types[expr] = type;
		console.log(type);
		if(member(lang,["python","coconut"])){
			if(type === "function"){
				to_return = "callable("+expr+")";
			}
			else{
				to_return = "type("+expr+") == "+var_type(input_lang,lang,type);
			}
		}
		else if(member(lang,["prolog"])){
			to_return = var_type(input_lang,lang,type)+"("+expr+")";
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
		else if(member(lang,["javascript","typescript","coffeescript"])){
			to_return = "typeof("+expr+") == \""+var_type(input_lang,lang,type)+"\"";
		}
		else if(member(lang,["haskell"])){
			to_return = "(typeOf "+expr+") =="+var_type(input_lang,lang,type)+"";
		}
		else if(member(lang,["c#","kotlin"])){
			to_return = "("+expr+" is "+var_type(input_lang,lang,type)+")";
		}
		else if(member(lang,["ceylon"])){
			to_return = "(is "+expr+" "+var_type(input_lang,lang,type)+")";
		}
		else if(member(lang,["scala"])){
			to_return = "("+expr+" as? "+var_type(input_lang,lang,type)+")";
		}
		else if(member(lang,["clips"])){
			to_return = "(eq (type "+expr+")F "+var_type(input_lang,lang,type)+")";
		}
		else if(member(lang,["java"])){
			to_return = expr+" instanceof "+var_type(input_lang,lang,type);
		}
		else if(member(lang,["scala"])){
			to_return = expr+".isInstanceOf["+var_type(input_lang,lang,type)+"]";
		}
		else if(member(type,["String","string"])){
			if(member(lang,["php","hack"])){
				to_return = "is_string("+expr+")";
			}
			else if(member(lang,["yacas"])){
				to_return = "IsString("+expr+")";
			}
		}
		else if(member(type,["function"])){
			if(member(lang,["python"])){
				to_return = "callable("+expr+")";
			}
			else if(member(lang,["javascript"])){
				to_return = "(typeof "+expr+" === )";
			}
		}
		else if(type === "int"){
			if(member(lang,["perl"])){
				to_return = "Scalar::Util::looks_like_number("+expr+")";
			}
			else if(member(lang,["php","hack"])){
				to_return = "is_int("+expr+")";
			}
			else if(member(lang,["elixir"])){
				to_return = "is_integer("+expr+")";
			}
			else if(member(lang,["prolog"])){
				to_return = "integer("+expr+")";
			}
			else if(member(lang,["javascript"])){
				to_return = "Number.isInteger("+expr+")";
			}
		}
		else if(type === "boolean"){
			if(member(lang,["php","hack"])){
				to_return = "is_boolean("+expr+")";
			}
		}
		else if(type === "number"){
			if(member(lang,["php"])){
				to_return = "is_numeric("+expr+")";
			}
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "ternary_operator"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		var c = generate_code(input_lang,lang,indent+"    ",arr[2]);
		if(member(lang,["java","vala","sidef","dart","tcl","autohotkey","javascript","typescript","c","c#","haxe","c++","perl","ruby","julia","awk","swift"])){
			to_return = a+"?"+b+":"+c;
		}
		else if(member(lang,["php","hack"])){
			to_return = "("+a+"?"+b+":"+c+")";
		}
		else if(member(lang,["perl 6"])){
			to_return = "("+a+"??"+b+"!!"+c+")";
		}
		else if(member(lang,["algol 68"])){
			to_return = "("+a+"|"+b+"|"+c+")";
		}
		else if(member(lang,["coffeescript","standard ml","ada","coq","chapel","haskell","ada","mercury"])){
			to_return = "(if "+a+" then "+b+" else "+c+")";
		}
		else if(member(lang,["python","coconut"])){
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
		else if(member(lang,["smt-lib"])){
			to_return = "(ite "+a+" "+b+" "+c+")";
		}
		else if(member(lang,["coffeescript","kotlin","r","scala"])){
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
			if(member(lang,['d',"glsl","kotlin",'e',"php","perl","mathematical notation","chapel","pawn","ceylon","scala","typescript","autohotkey","awk","r","groovy","gosu","katahdin","java","swift","nemerle",'c',"dart","vala","javascript","c#","c++","haxe"])){
				to_return = "if(" + if_statement1 + "){" + if_statement2 +indent+ "}";
			}
			else if(member(lang,["rust","go"])){
				to_return = "if " + if_statement1 + " {" + if_statement2 +indent+ "}";
			}
			else if(member(lang,["mysql"])){
				to_return = "IF " + if_statement1 + " THEN " + if_statement2 +indent+ " END IF;";
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
			else if(member(lang,["prolog","alt-ergo"])){
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
			else if(member(lang,["sage"])){
				to_return = "piecewise(("+if_statement2+","+if_statement1+"))";
			}
			else if(member(lang,["rebol"])){
				to_return = "case [" +indent+""+ if_statement1 + "["+if_statement2+"]"+indent+ "]";
			}
			else if(lang === "fortran"){
				to_return = "if("+if_statement1+") then "+if_statement2 + indent+ "end if";
			}
			else if(lang === "minizinc"){
				to_return = "if "+if_statement1+" then "+if_statement2 + indent+ "endif";
			}
			else if(lang === "octave"){
				to_return = "if "+if_statement1+if_statement2+indent+"endif";
			}
			else if(lang === "scriptol"){
				to_return = "If "+if_statement1+if_statement2+indent+"/if";
			}
			else if(member(lang,["python","coconut"])){
				to_return = "if "+if_statement1+":"+if_statement2;
			}
			else if(member(lang,["coffeescript"])){
				to_return = "if "+if_statement1+if_statement2;
			}
			else if(lang === "ocaml"){
				to_return = "(if "+if_statement1+" then "+if_statement2 + indent+ ")";
			}
			else if(member(lang,["ruby","lua","picat","gap"])){
				to_return = "if " + if_statement1 + " then "  + if_statement2 +indent+ "end";
			}
			else if(member(lang,["julia"])){
				to_return = "if " + if_statement1 + if_statement2 +indent+ "end";
			}
			else if(member(lang,["visual basic .net"])){
				to_return = "If " + if_statement1 + " Then "  + if_statement2 +indent+ "End If";
			}
			else if(member(lang,["applescript"])){
				to_return = "if " + if_statement1 + " then "  + if_statement2 +indent+ "end if";
			}
			else if(member(lang,['forth'])){
				to_return = "begin " + if_statement1 + " if " + if_statement2 + indent+ "then";
			}
			else if(member(lang,["haskell","standard ml","elm","maxima"])){
				to_return = "(if " + if_statement1 + " then "  + if_statement2 + ")";
			}
			else if(member(lang,["smt-lib"])){
				to_return = "(=> " + if_statement1 + " "  + if_statement2 + ")";
			}
		}
		else{
			var elif_or_else = generate_code(input_lang,lang,indent,arr[3]);
			if(member(lang,['d',"dafny","kotlin",'e',"php","perl","mathematical notation","chapel","pawn","ceylon","scala","typescript","autohotkey","awk","r","groovy","gosu","katahdin","java","swift","nemerle",'c',"dart","vala","javascript","c#","c++","glsl","haxe"])){
				to_return = "if(" + if_statement1 + "){" + if_statement2 +indent+ "}" + elif_or_else;
			}
			else if(member(lang,["rust","go"])){
				to_return = "if " + if_statement1 + " {" + if_statement2 +indent+ "}" + elif_or_else;
			}
			else if(member(lang,["mysql"])){
				to_return = "IF " + if_statement1 + " THEN " + if_statement2+elif_or_else+indent+"END IF;";
			}
			else if(member(lang,["seed7"])){
				to_return = "if " + if_statement1 + " then " + if_statement2+elif_or_else+indent+"end if;";
			}
			else if(member(lang,["smalltalk"])){
				to_return = "("+if_statement1+") ifTrue: [" + if_statement2 +"]"+indent+"ifFalse: ["+ elif_or_else+"]";
			}
			else if(member(lang,["algol 68"])){
				to_return = "if " + if_statement1 + "then " + if_statement2 + elif_or_else +indent+ "fi";
			}
			else if(member(lang,["common lisp"])){
				to_return = "(cond (" + if_statement1 + if_statement2 +")"+ elif_or_else +indent+ ")";
			}
			else if(member(lang,["elixir"])){
				to_return = "cond do " + if_statement1 +" -> "+ if_statement2 + elif_or_else;
			}
			else if(member(lang,["clojure"])){
				to_return = "(cond " + if_statement1 + if_statement2+ elif_or_else +indent+ ")";
			}
			else if(member(lang,["prolog"])){
				to_return = "(" + if_statement1 + "-> (" + if_statement2 + ");" + elif_or_else+")";
			}
			else if(member(lang,["alt-ergo"])){
				to_return = "(" + if_statement1 + "-> (" + if_statement2 + ") or " + elif_or_else+")";
			}
			else if(member(lang,["erlang"])){
				to_return = "if " + if_statement1 + " ->" + if_statement2 + ";" + elif_or_else+indent+"end";
			}
			else if(member(lang,["sympy"])){
				to_return = "Piecewise(("+if_statement2+","+if_statement1+"),"+elif_or_else+")";
			}
			else if(member(lang,["sage"])){
				to_return = "piecewise(("+if_statement2+","+if_statement1+"),"+elif_or_else+")";
			}
			else if(member(lang,["rebol"])){
				to_return = "case [" +indent+""+ if_statement1 + "["+if_statement2+"]"+ elif_or_else +indent+ "]";
			}
			else if(lang === "fortran"){
				to_return = "if("+if_statement1+") then "+if_statement2 + " " + elif_or_else + indent+ "end if";
			}
			else if(lang === "octave"){
				to_return = "if "+if_statement1+if_statement2+elif_or_else+indent+"endif";
			}
			else if(lang === "scriptol"){
				to_return = "If "+if_statement1+if_statement2+elif_or_else+indent+"/if";
			}
			else if(lang === "minizinc"){
				to_return = "if "+if_statement1+" then "+if_statement2 + " " + elif_or_else + indent+ "endif";
			}
			else if(member(lang,["python","coconut"])){
				to_return = "if "+if_statement1+":"+if_statement2 + elif_or_else;
			}
			else if(member(lang,["coffeescript"])){
				to_return = "if "+if_statement1+if_statement2 + elif_or_else;
			}
			else if(lang === "ocaml"){
				to_return = "(if "+if_statement1+" then "+if_statement2 + " " + elif_or_else + indent+ ")";
			}
			else if(member(lang,["ruby","lua","picat","gap"])){
				to_return = "if " + if_statement1 + " then "  + if_statement2 + " " + elif_or_else +indent+ "end";
			}
			else if(member(lang,["julia"])){
				to_return = "if " + if_statement1 + if_statement2 + " " + elif_or_else +indent+ "end";
			}
			else if(member(lang,["visual basic .net"])){
				to_return = "If " + if_statement1 + " Then "  + if_statement2 + " " + elif_or_else +indent+ "End If";
			}
			else if(member(lang,["applescript"])){
				to_return = "if " + if_statement1 + " then "  + if_statement2 + " " + elif_or_else +indent+ "end if";
			}
			else if(member(lang,["haskell","standard ml","elm","maxima","clips"])){
				to_return = "(if " + if_statement1 + " then "  + if_statement2 + " " + elif_or_else + ")";
			}
			else if(member(lang,["smt-lib"])){
				to_return = "(ite " + if_statement1 + " "  + if_statement2 + " " + elif_or_else + ")";
			}
			else if(member(lang,["z3py"])){
				to_return = "If(" + if_statement1 + ","  + if_statement2 + "," + elif_or_else + ")";
			}
			else if(member(lang,["wolfram"])){
				to_return = "If[" + if_statement1 + ",(" + if_statement2 + "),(" + elif_or_else + ")]";
			}
			else if(member(lang,["yacas"])){
				to_return = "If(" + if_statement1 + ",[" + if_statement2 + "],[" + elif_or_else + "])";
			}
		}
	}
	else if(arr[0] === "else"){
		var statements1 = generate_code(input_lang,lang,indent+"    ",arr[1]);
		to_return = inputs_to_outputs(lang,{statements1:statements1," indent ":indent},[
			[["hack","glsl","kotlin",'e',"ooc","englishscript","mathematical notation","dafny","perl 6","frink","chapel","katahdin","pawn","powershell",'puppet',"ceylon",'d',"rust","typescript","scala","autohotkey","gosu","groovy","java","swift","dart","awk","javascript","haxe","php","c#","go","perl","c++",'c',"tcl","r","vala","bc"],
				"else{statements1 indent }"],
			[["visual basic .net"],
				"Else statements1"],
			[["clojure"],
				":else statements1"],
			[["python","coconut"],
				"else:statements1"],
			[["seed7","applescript","standard ml","elixir","gap","elm","coffeescript","fortran","vhdl","ruby","lua","livecode","janus","haskell","clips","minizinc","julia","octave","picat","pascal","delphi","maxima","ocaml","f#"],
				"else statements1"],
			[["common lisp"],
				"(t statements1)"],
			[["wolfram","prolog","smalltalk"],
				"(statements1)"],
			[["smt-lib","z3py"],
				"statements1"],
			[["alt-ergo"],
				" or (statements1)"],
			[["mysql"],
				"ELSE statements1"],
			[["erlang"],
				"true-> statements1 indent "],
			[["sympy","sage"],
				"(statements1,True)"],
			[["rebol"],
				"true [statements1 indent ]"]
		]);
	}
	else if(arr[0] === "switch"){
		first_case = true;
		var expr = generate_code(input_lang,lang,indent,arr[1]);
		switch_stack.push(expr);
		var statements1 = arr[2].map(function(a){
			if(member(lang,["python","prolog","perl"])){
				return generate_code(input_lang,lang,indent,a);
			}
			else{
				return generate_code(input_lang,lang,indent+"    ",a);
			}
		});
		if(member(lang,["ocaml"])){
			statements1 = statements1.join(indent + "    |");
		}
		else if(member(lang,["prolog"])){
			statements1 = "("+statements1.join(indent + ";")+")";
		}
		else{
			statements1 = statements1.join("");
		}
		
		if(member(lang,["java",'d',"powershell","nemerle","typescript","hack","swift","groovy","dart","awk","c#","javascript","c++","php",'c',"go","haxe","vala"])){
			to_return = "switch("+expr+"){"+statements1+indent+"}";
		}
		else if(member(lang,["tcl"])){
			to_return = "switch "+expr+"{"+statements1 +indent+ "}";
		}
		else if(member(lang,["mediawiki"])){
			to_return = "{{#switch: "+expr+"|"+statements1+indent+"}}"
		}
		else if(member(lang,["ring"])){
			to_return = "switch " + expr + statements1 +indent+ "off";
		}
		else if(member(lang,["octave"])){
			to_return = "switch("+expr+")"+statements1+indent+ "endswitch";
		}
		else if(member(lang,["ruby"])){
			to_return = "case "+expr+" "+statements1 +indent+ "end";
		}
		else if(member(lang,["python","prolog","perl"])){
			to_return = statements1;
		}
		else if(member(lang,["vhdl"])){
			to_return = "case "+expr+" "+is+indent+ "end case;";
		}
		else if(member(lang,["transact-sql"])){
			to_return = "CASE "+expr+" "+statements1 +indent+ "END";
		}
		else if(member(lang,["mysql"])){
			to_return = "CASE "+expr+" "+statements1 +indent+ "END CASE";
		}
		else if(member(lang,["forth"])){
			to_return = expr+" case"+statements1 +indent+ "endcase";
		}
		else if(member(lang,["gnu setl"])){
			to_return = expr+" case"+statements1 +indent+ "end case";
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
		else if(member(lang,["rust"])){
			to_return = "match "+expr+" with {"+statements1+indent+"}";
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
		switch_stack.pop();
		first_case = false;
	}
	else if(arr[0] === "case"){
		var expr = generate_code(input_lang,lang,indent+"",arr[1]);
		var statements1 = generate_code(input_lang,lang,indent+"    ",arr[2]);
		if(member(lang,["javascript",'d',"java","c#",'c',"c++","typescript","dart","php","hack"])){
			to_return = "case "+expr+": "+statements1+indent+"    break;";
		}
		else if(member(lang,["go","haxe","swift"])){
			to_return = "case "+expr+": "+statements1;
		}
		else if(member(lang,["python"])){
			if(first_case){
				to_return = "if ("+switch_stack[switch_stack.length-1]+") == ("+expr+"): "+statements1;
			}
			else{
				to_return = "elif ("+switch_stack[switch_stack.length-1]+") == ("+expr+"): "+statements1;
			}
		}
		else if(member(lang,["perl"])){
			if(first_case){
				to_return = "if("+generate_code(input_lang,lang,indent,["==",switch_stack[switch_stack.length-1],expr])+"){"+statements1+indent+"}";
			}
			else{
				to_return = "elsif("+generate_code(input_lang,lang,indent,["==",switch_stack[switch_stack.length-1],expr])+"){"+statements1+indent+"}";
			}
		}
		else if(member(lang,["prolog"])){
			to_return = "(("+switch_stack[switch_stack.length-1]+") == ("+expr+")) -> "+statements1;
		}
		else if(member(lang,["flix"])){
			to_return = "case "+expr+" => "+statements1;
		}
		else if(member(lang,["ring"])){
			to_return = "on "+expr+" "+statements1;
		}
		else if(member(lang,['forth'])){
			to_return = expr+" of "+statements1+"endof";
		}
		else if(member(lang,["visual basic .net"])){
			to_return = "Case "+expr+statements1;
		}
		else if(member(lang,["awk"])){
			to_return = "case "+expr+": "+statements1+indent+"    break";
		}
		else if(member(lang,["octave","fortran"])){
			to_return = "case "+expr+statements1;
		}
		else if(member(lang,["coffeescript"])){
			to_return = "when "+expr+" then"+statements1;
		}
		else if(member(lang,["gnu setl"])){
			to_return = "when "+expr+" => "+statements1;
		}
		else if(member(lang,["transact-sql","mysql"])){
			to_return = "WHEN "+expr+" THEN "+statements1;
		}
		else if(member(lang,["ruby"])){
			to_return = "when "+expr+statements1;
		}
		else if(member(lang,["perl 6","chapel"])){
			to_return = "when "+expr+"{"+statements1+indent+"}";
		}
		else if(member(lang,["coconut"])){
			to_return = "match "+expr+":"+statements1;
		}
		else if(member(lang,["rebol"])){
			to_return = expr+" ["+statements1+"]";
		}
		else if(member(lang,["tcl"])){
			to_return = expr+" {"+statements1+indent+"}";
		}
		else if(member(lang,["clips"])){
			to_return = "(case "+expr+" then "+statements1+")";
		}
		else if(member(lang,["haskell","elixir","ocaml"])){
			to_return = expr+" ->"+statements1;
		}
		else if(member(lang,["erlang"])){
			to_return = expr + " ->"+statements1+";";
		}
		else if(member(lang,["scala","rust","vhdl"])){
			to_return = "when "+expr+" =>"+statements1;
		}
		else if(member(lang,["standard ml"])){
			to_return = expr+" => "+statements1 + "|";
		}
		else if(member(lang,["coq"])){
			to_return = "|" + expr+" =>"+statements1;
		}
		else if(member(lang,["clojure"])){
			to_return = expr+" "+statements1;
		}
		else if(member(lang,["wolfram"])){
			to_return = ","+expr+","+statements1;
		}
	}
	else if(arr[0] === "default"){
		var statements1 = generate_code(input_lang,lang,indent+"    ",arr[1]);
		member(lang,["javascript","coconut","haxe","awk","swift",'d',"java","c#",'c',"c++","typescript","dart","go","php","hack"])
			&& (to_return = "default:" + statements1)
		|| member(lang,["haskell","erlang","ocaml","elixir","prolog"])
			&& (to_return = "_ ->" + statements1)
		|| member(lang,["wolfram"])
			&& (to_return = ";" + statements1)
		|| member(lang,["octave"])
			&& (to_return = "otherwise" + statements1)
		|| member(lang,["rust","scala","standard ml"])
			&& (to_return = "_ =>" + statements1)
		|| member(lang,["tcl"])
			&& (to_return = "default {" + statements1 + indent + "}")
		|| member(lang,["visual basic .net"])
			&& (to_return = "Case Else" + statements1)
		|| member(lang,["clips"])
			&& (to_return = "(default " + statements1+")")
		|| member(lang,["fortran"])
			&& (to_return = "case default " + statements1)
		|| member(lang,["perl 6"])
			&& (to_return = "default{" + statements1+indent+"}")
		|| member(lang,["rebol"])
			&& (to_return = "][" + statements1)
		|| member(lang,["clojure"])
			&& (to_return = statements1)
		|| member(lang,["ruby","coffeescript","pascal","delphi"])
			&& (to_return = "else" + statements1)
		|| member(lang,["python"])
			&& (to_return = "else:" + statements1)
		|| member(lang,["perl"])
			&& (to_return = "else{" + statements1+indent+"}")
		|| member(lang,["transact-sql"])
			&& (to_return = "ELSE" + statements1)
		|| member(lang,["mediawiki"])
			&& (to_return = "default" + statements1)
		|| member(lang,["vhdl"])
			&& (to_return = "when others =>" + statements1);
	}
	else if(arr[0] === "defrule"){
		//equivalent to propagation rules in CHR
		defined_vars = [];
		var name = arr[1];
		var condition = generate_code(input_lang,lang,indent,arr[2]);
		var body = generate_code(input_lang,lang,indent,arr[3]);
		
		if(member(lang,["drools"])){
			to_return = "rule \"" +name + "\" when " + condition + " then " + body+indent+"end";
		}
		else if(member(lang,["constraint handling rules","prolog"])){
			to_return = name + " @ " + condition + " ==> " + body;
		}
		else if(member(lang,["clips"])){
			to_return = "(defrule " + name + " " + condition + " => (assert " + body + "))";
		}
		else if(member(lang,["pddl"])){
			if(member(input_lang,["prolog"])){
				to_return = "(:action " +name + " :parameters ("+defined_vars.map(function(x){return var_name(lang,input_lang,x)}).join(" ")+") :precondition " + condition + " :effect (and "+ condition + " " + body + "))";
			}
			else{
				to_return = "(:action " +name + " :parameters ("+defined_vars.map(function(x){return var_name(lang,input_lang,x)}).join(" ")+") :precondition " + condition + " :effect " + body + ")";
			}
		}
		defined_vars = [];
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
		
		member(lang,["javascript","php","hack"])
			&& (to_return = "..." + name)
		|| member(lang,["perl"])
			&& (to_return = ".." + name)
		|| member(lang,["python","coconut","ruby"])
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
		else if(member(lang,["prolog","asciimath","alt-ergo","minizinc","gams","abella"])){
			to_return = condition + " -> " + body;
		}
		else if(member(lang,["mizar"])){
			to_return = condition + " implies " + body;
		}
		else if(member(lang,["sympy"])){
			to_return = "Piecewise(("+body+","+condition+"))";
		}
		else if(member(lang,["smt-lib"])){
			to_return = "(=> " + condition + " " + body+")";
		}
		else if(member(lang,["lua","php","c#"])){
			//for imperative languages without logic-programming features
			to_return = generate_code(input_lang,lang,indent,["||",arr[1],arr[2]]);
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
		if(member(lang,['d','e',"mathematical notation","chapel","pawn","ceylon","scala","typescript","autohotkey","awk","r","groovy","gosu","katahdin","java","swift","nemerle",'c',"dart","vala","javascript","c#","c++","glsl","haxe"])){
			to_return = "else if("+a+"){"+b+indent+"}"+c;
		}
		else if(member(lang,["smalltalk"])){
			to_return = "("+a+") ifTrue: [" + b +"]"+indent+"ifFalse: ["+c+"]";
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
		else if(member(lang,["python","coconut","cython"])){
			to_return = "elif " + a + ":" + b + c;
		}
		else if(member(lang,["prolog"])){
			(c === "")
				&& (to_return = a + "-> (" + b + ")")
				|| (to_return = a + "-> (" + b + ");" + c);
		}
		else if(member(lang,["rebol"])){
			to_return = a + "["+b+"]"+c;
		}
		else if(member(lang,["coffeescript"])){
			to_return = "else if " + a + b + c;
		}
		else if(member(lang,["minizinc","picat","lua","mysql"])){
			to_return = "elseif "+a+" then "+b + " " + c;
		}
		else if(member(lang,["gap"])){
			to_return = "elif "+a+" then "+b + " " + c;
		}
		else if(member(lang,["julia"])){
			to_return = "elseif "+a+" "+b + " " + c;
		}
		else if(member(lang,["ocaml","applescript","haskell","standard ml","elm","pascal","maxima","delphi","f#","livecode"])){
			to_return = "else if "+a+" then "+b + " " + c;
		}
		else if(lang === "fortran"){
			to_return = "else if("+a+") then "+b + " " + c;
		}
		else if(member(lang,["php","hack","perl"])){
			to_return = "elseif("+a+"){"+b+indent+"}"+c;
		}
		else if(member(lang,["ruby"])){
			to_return = "elsif " +a + " " + b+ " " + c;
		}
		else if(member(lang,["perl 6"])){
			to_return = "elsif " +a + "{" + b+ "}" + c;
		}
		else if(member(lang,["visual basic .net"])){
			to_return = "ElseIf " +a + " Then " + b + " " + c;
		}
		else if(member(lang,["wolfram"])){
			to_return = "If[" +a + ",(" + b + "),(" + c+")]";
		}
		else if(member(lang,["yacas"])){
			to_return = "If(" +a + ",[" + b + "],[" + c+"])";
		}
		else if(member(lang,["smt-lib"])){
			(c === "")
				&& (to_return = "(=> "+a+" "+b+")")
				|| (to_return = "(ite "+a+" "+b+" "+c+")");
		}
		else if(member(lang,["z3py"])){
			(c === "")
				&& (to_return = "Implies("+a+","+b+")")
				|| (to_return = "If("+a+","+b+","+c+")");
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
		|| member(lang,["haxe","php","javascript","dart","typescript"])
			&& (to_return = "class "+name+" extends "+name1+"{"+body+indent+"}")
		|| member(lang,['stone'])
			&& (to_return = "struct "+name+" extends "+name1+body)
		|| member(lang,["c++"])
			&& (to_return = "class "+name+": public "+name1+"{"+body+indent+"};")
		|| member(lang,["swift","chapel",'d',"swift"])
			&& (to_return = "class "+name+":"+name1+"{"+body+indent+"}")
		|| member(lang,["python","coconut"])
			&& (to_return = "class "+name+"("+name1+"):"+body)
		|| member(lang,["ruby"])
			&& (to_return = "class "+name+" << "+name1+" "+body+indent+"end")
		|| member(lang,["clips"])
			&& (to_return = "(defclass "+name+" (is-a "+name1+") "+body+")");
	}
	else if(arr[0] === "interface_extends"){
		//return arr.toString();
		var access_modifier = arr[1];
		var name = arr[2];
		var name1 = arr[3];
		var body = generate_code(input_lang,lang,indent+"    ",arr[4]);
		
		member(lang,["java"])
			&& (to_return = access_modifier + " interface "+name+" extends "+name1+"{"+body+indent+"}")
		||
		member(lang,["typescript","php"])
			&& (to_return = "interface "+name+" extends "+name1+"{"+body+indent+"}")
		||
		member(lang,["thrift"])
			&& (to_return = "service "+name+" extends "+name1+"{"+body+indent+"}")
		||
		member(lang,["c"])
			&& (to_return = "typedef struct "+name+"{struct "+name1+";"+body+indent+"} "+name+";");
	}
	else if(arr[0] === "algebraic_data_type"){
		//return arr.toString();
		var name = arr[1];
		var body = generate_code(input_lang,lang,indent+"    ",arr[2]);
		if(member(lang,["haskell","idris"])){
			to_return = "data "+name+" = "+body;
		}
		else if(member(lang,["ocaml"])){
			to_return = "type "+name+" = "+body;
		}
		else if(member(lang,["haxe"])){
			to_return = "enum "+name+"{"+body+";}";
		}
		else if(member(lang,["prolog"])){
			to_return = name+" ---> "+body;
		}
	}
	else if(arr[0] === "data_type_or"){
		//return arr.toString();
		var a = generate_code(input_lang,lang,"",arr[1]);
		var b = generate_code(input_lang,lang,"",arr[2]);
		if(member(lang,["haskell","ocaml","idris"])){
			to_return = a+" | "+b;
		}
		else if(member(lang,["prolog","haxe"])){
			to_return = a +";"+ b;
		}
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
		var name = arr[2];
		var body = generate_code(input_lang,lang,indent+"    ",arr[3]);
		
		member(lang,["java","c#"])
			&& (to_return = access_modifier + " interface "+name+"{"+body+indent+"}")
		|| member(lang,["c++"])
			&& (to_return = "class "+name+"{"+body+indent+"};")
		|| member(lang,["protobuf"])
			&& (to_return = "message "+name+"{"+body+indent+"}")
		|| member(lang,["thrift"])
			&& (to_return = "service "+name+"{"+body+indent+"}")
		|| member(lang,["swift","haxe","php"])
			&& (to_return = "interface "+name+"{"+body+indent+"}");
	}
	else if(arr[0] === "protobuf_service"){
		//return arr.toString();
		var name = arr[1];
		var body = generate_code(input_lang,lang,indent+"    ",arr[2]);
		if(member(lang,["thrift"])){
			to_return = "service "+name+"{"+body+indent+"}";
		}
	}
	else if(arr[0] === "enum_statement"){
		//return arr.toString();
		if(member(lang,["java","seed7","vala","perl 6","swift","c++","c#","haxe","fortran","typescript",'c',"ada","scala"])){
			return arr[1];
		}
		else if(member(lang,["go"])){
			return arr[1]+"=iota";
		}
		else if(member(lang,["c","thrift","protobuf"])){
			return arr[1]+"="+arr[2];
		}
	}
	else if(arr[0] === "enum"){
		//return arr.toString();
		var access_modifier = arr[1];
		var name = arr[2];
		var body;
		if(member(lang,["alt-ergo"])){
			body = indent + "    " + arr[3].map(function(x){types[x] = name; return generate_code(input_lang,lang,"",x)}).join(" | ");
		}
		else{
			body = indent + "    " + arr[3].map(function(x){types[x] = name; return generate_code(input_lang,lang,"",x)}).join(",");
		}
		
		if(member(lang,["java"])){
			return access_modifier + " enum "+name+"{"+body+indent+"}";
		}
		else if(member(lang,["c#"])){
			return access_modifier + " enum "+name+"{"+body+indent+"}";
		}
		else if(member(lang,["haxe","typescript","thrift","protobuf"])){
			return "enum "+name+"{"+body+indent+"}";
		}
		else if(member(lang,["alt-ergo"])){
			return "type "+name+" = "+body;
		}
		else if(member(lang,["c","c++"])){
			return "enum "+name+"{"+body+indent+"};";
		}
	}
	else if(Array.isArray(arr[0])){
		return generate_code(input_lang,lang,indent,arr[0]);
	}
	else if(arr[0] === "struct"){
		//return arr.toString();
		var name = arr[1];
		var body = generate_code(input_lang,lang,indent+"    ",arr[2]);
		if(member(lang,["java"])){
			to_return = "class "+name+"{"+body+indent+"}";
		}
		else if(member(lang,["sql","mysql","transact-sql"])){
			to_return = "CREATE TABLE "+name+"("+body+indent+");";
		}
		else if(member(lang,["c","c++","glsl","hlsl"])){
			to_return = "struct "+name+"{"+body+indent+"};";
		}
		else if(member(lang,["protobuf"])){
			to_return = "message "+name+"{"+body+indent+"}";
		}
		else if(member(lang,["thrift","swift"])){
			to_return = "struct "+name+"{"+body+indent+"}";
		}
		else if(member(lang,["erlang"])){
			to_return = "-record("+name+", {"+body+indent+"})";
		}
		else if(member(lang,["stone"])){
			to_return = "struct "+name+body;
		}
		else if(member(lang,["haskell"])){
			to_return = "data "+name+" = "+name+"{"+body+indent+"}";
		}
		else if(member(lang,["go"])){
			to_return = "type "+name+" struct{"+body+indent+"}";
		}
		else if(member(lang,["fortran"])){
			to_return = "type "+name+body+indent+"end type "+name;
		}
	}
	else if(arr[0] === "namespace"){
		//return arr.toString();
		var access_modifier = arr[1];
		var name = arr[2];
		class_name = name;
		var body = generate_code(input_lang,lang,indent+"    ",arr[3]);
		member(lang,["c#"])
			&& (to_return = access_modifier + " interface "+name+"{"+body+indent+"}")
		|| member(lang,["php"])
			&& (to_return = access_modifier + " interface "+name+"{"+body+indent+"}");
	}
	else if(arr[0] === "generic_interface"){
		//return arr.toString();
		var access_modifier = arr[1];
		var name = arr[2];
		class_name = name;
		var body = generate_code(input_lang,lang,indent+"    ",arr[3]);
		for(var i = 0; i < arr[4].length; i++){
			types[arr[4][i]] = arr[4][i];
			type_parameters.push(arr[4][i]);
		}
		var type_params = arr[4].join(",");
		if(member(lang,["java","c#"])){
			to_return = access_modifier +" interface "+ name+"<"+type_params+">{"+body+indent+"}";
		}
		else if(member(lang,["typescript"])){
			to_return = "interface "+ name+"<"+type_params+">{"+body+indent+"}";
		}
	}
	else if(arr[0] === "generic_class"){
		//return arr.toString();
		var access_modifier = arr[1];
		var name = arr[2];
		class_name = name;
		var body = generate_code(input_lang,lang,indent+"    ",arr[3]);
		for(var i = 0; i < arr[4].length; i++){
			types[arr[4][i]] = arr[4][i];
			type_parameters.push(arr[4][i]);
		}
		var type_params = arr[4].join(",");
		if(member(lang,["typescript","haxe","swift"])){
			to_return = "class "+ name+"<"+type_params+">{"+body+indent+"}";
		}
		else if(member(lang,["scala"])){
			to_return = "class "+ name+"["+type_params+"]{"+body+indent+"}";
		}
		else if(member(lang,["c++"])){
			to_return = "template<"+type_params+"> class "+ name+"{"+body+indent+"}";
		}
		else if(member(lang,["java","c#"])){
			to_return = access_modifier +" class "+ name+"<"+type_params+">{"+body+indent+"}";
		}
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
		|| member(lang,["c"])
			&& (to_return = "typedef struct "+name+"{"+body+indent+"} "+name+";")
		|| member(lang,["transact-sql","sql"])
			&& (to_return = "CREATE TABLE "+name+"("+body+indent+")")
		|| member(lang,["coffeescript"])
			&& (to_return = "class "+name+body)
		|| member(lang,["sather"])
			&& (to_return = "class "+name+" is "+body+indent+"end;")
		|| member(lang,["scriptol"])
			&& (to_return = "class "+name+body+indent+"/class")
		|| member(lang,["visual basic .net"])
			&& (to_return = access_modifier.charAt(0).toUpperCase() + access_modifier.slice(1) +" Class " + name + body+indent+"End Class")
		|| member(lang,["perl"])
			&& (to_return = "{package "+name+";"+body+indent+"}")
		|| member(lang,["c++"])
			&& (to_return = "class "+name+"{"+body+indent+"};")
		|| member(lang,["f#"])
			&& (to_return = "type "+name+" = "+body)
		|| member(lang,["python","coconut","gdscript"])
			&& (to_return = "class "+name+":"+body)
		|| member(lang,["ruby"])
			&& (to_return = "class "+name+" "+body+indent+"end")
		|| member(lang,["javascript","hack","php","scala","haxe","chapel","swift",'d',"typescript","dart","perl 6"])
			&& (to_return = "class "+name+"{"+body+indent+"}");
	}
	else if(arr[0] === "interface_static_method"){
		//return arr.toString();
		var type = arr[2];
		var name = arr[3][1];
		var params = parameters(input_lang,lang,indent,arr[4]);
		var access_modifier = arr[1];
		types[name] = type;
		
		member(lang,["java","c#"])
			&& (to_return = access_modifier + " static " + var_type(input_lang,lang,type) + " " + name + "("+params+")"+";")
		|| member(lang,["thrift"])
			&& (to_return = var_type(input_lang,lang,type) + " " + name + "("+params+")")
		|| member(lang,["c++"])
			&& (to_return = "static virtual " + var_type(input_lang,lang,type) + " " + name + "("+params+")"+"=0;")
		|| member(lang,["haxe"])
			&& (to_return = "static "+access_modifier+" function " + name + "("+params+"): "+var_type(input_lang,lang,type)+";")
		|| member(lang,["php"])
			&& (to_return = access_modifier + " static function " + name + "("+params+");");
	}
	else if(arr[0] === "interface_instance_method"){
		//return arr.toString();
		var type = arr[2];
		var name = arr[3][1];
		var params = parameters(input_lang,lang,indent,arr[4]);
		var access_modifier = arr[1];
		types[name] = type;
		
		member(lang,["java","c#"])
			&& (to_return = access_modifier + " " + var_type(input_lang,lang,type) + " " + name + "("+params+")"+";")
		|| member(lang,["thrift"])
			&& (to_return = var_type(input_lang,lang,type) + " " + name + "("+params+")"+";")
		|| member(lang,["haxe"])
			&& (to_return = access_modifier + " function " + name + "("+params+"):"+var_type(input_lang,lang,type)+";")
		|| member(lang,["php"])
			&& (to_return = access_modifier + " function " + name + "("+params+");")
		|| member(lang,["c++"])
			&& (to_return = "virtual " + var_type(input_lang,lang,type) + " " + name + "("+params+")"+"=0;");
		types[to_return] = type;
	}
	//This overloading method is defined outside of a class
	else if(arr[0] === "overload_operator"){
		//return arr.toString();
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,indent,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["c++"])){
			type = var_type(input_lang,lang,type);
			to_return = type +" operator" + name + "("+params+"){"+body+indent+"}";
		}
	}
	else if(arr[0] === "static_overload_operator"){
		//This method is defined inside a class
		//takes two parameters
		//return arr.toString();
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,indent,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["c#"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier + " static " + type + " operator " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["f#"])){
			type = var_type(input_lang,lang,type);
			to_return = "static member (" + name + ")("+params+") ="+body;
		}
		else if(member(lang,["visual basic .net"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier +" Public Shared Operator " + name + "("+params+") As " + type + body+indent+"End Operator";
		}
		else if(member(lang,["swift"])){
			type = var_type(input_lang,lang,type);
			to_return = "func " + name + "("+params+") -> " +type+ "{"+body+indent+"}";
		}
	}
	else if(arr[0] === "instance_overload_operator"){
		//defined inside a class
		//takes one parameter
		//return arr.toString();
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,indent,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["ruby"])){
			to_return = "def " + name + "("+params+")"+body+indent+"end";
		}
		else if(member(lang,["scala"])){
			type = var_type(input_lang,lang,type);
			to_return = "def " + name + "("+params+"): " +type+ "= {"+body+indent+"}";
		}
		else if(member(lang,["c++"])){
			type = var_type(input_lang,lang,type);
			to_return = type +" operator" + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["kotlin"])){
			name==="+"
				&& (name1="plus")
			|| name==="-"
				&& (name1="minus")
			|| name==="/"
				&& (name1="div")
			|| name==="*"
				&& (name1="times")
			|| name==="+="
				&& (name1="plusAssign")
			|| name==="-="
				&& (name1="minusAssign")
			|| name==="/="
				&& (name1="divAssign")
			|| name==="*="
				&& (name1="timesAssign")
			|| name==="%"
				&& (name1="mod")
			|| name==="%="
				&& (name1="modAssign");
			to_return = name1;
			type = var_type(input_lang,lang,type);
			to_return = "operator fun " + name + "("+params+"): " +type+ " {"+body+indent+"}";
		}
		else if(member(lang,["python","coconut"])){
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
	else if(arr[0] === "generic_static_method"){
		//return arr.toString();
		for(var i = 0; i < arr[6].length; i++){
			types[arr[6][i]] = arr[6][i];
			type_parameters.push(arr[6][i]);
		}
		var type_params = arr[6].join(",");
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,indent,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["java"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier + " static <" + type_params + "> "+ type + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["c#"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier + " static "+ type + " " + name + "<"+type_params+">("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["swift"])){
			to_return = ["class ","func ",name,"<",type_params,">(",params,ws,")","->",var_type(input_lang,lang,type),,"{",ws,body,indent,"}"].join("");
		}
		else if(member(lang,["swift"])){
			to_return = ["class ","function ",name,"<",type_params,">(",params,ws,")","->",var_type(input_lang,lang,type),,"{",ws,body,indent,"}"].join("");
		}
	}
	else if(arr[0] === "generic_function"){
		//return arr.toString();
		for(var i = 0; i < arr[6].length; i++){
			types[arr[5][i]] = arr[6][i];
			type_parameters.push(arr[6][i]);
		}
		var type_params;
		if(lang === "c++"){
			type_params = arr[6].map(function(x){return "typename " + x;})
		}
		else{
			type_params = arr[6].join(",");
		}
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,indent,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["typescript"])){
			type = var_type(input_lang,lang,type);
			to_return = "function " + name + "<"+type_params+">("+params+")->"+type+"{"+body+indent+"}";
		}
		else if(member(lang,["swift"])){
			type = var_type(input_lang,lang,type);
			to_return = "func " + name + "<"+type_params+">("+params+")->"+type+"{"+body+indent+"}";
		}
		else if(member(lang,["rust"])){
			type = var_type(input_lang,lang,type);
			to_return = "fn" + name + "<"+type_params+">("+params+")->"+type+"{"+body+indent+"}";
		}
		else if(member(lang,["java"])){
			type = var_type(input_lang,lang,type);
			to_return = "public <"+type_params+"> static" + name + " " +type+ "("+params+")"+"{"+body+indent+"}";
		}
		else if(member(lang,["c#"])){
			type = var_type(input_lang,lang,type);
			to_return = "public static " + type + " " + name + " <"+type_params+">("+params+")"+"{"+body+indent+"}";
		}
		else if(member(lang,["c++"])){
			type = var_type(input_lang,lang,type);
			to_return = "template<"+type_params+"> "+type+" "+name+"("+params+")"+"{"+body+indent+"}";
		}
	}
	else if(arr[0] === "generic_instance_method"){
		//return arr.toString();
		for(var i = 0; i < arr[6].length; i++){
			types[arr[5][i]] = arr[6][i];
			type_parameters.push(arr[6][i]);
		}
		var type_params = arr[6].join(",");
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,indent,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["java"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier + " <" + type_params + "> "+ type + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["c#"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier + " "+ type + " " + name + "<"+type_params+">("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["swift"])){
			type = var_type(input_lang,lang,type);
			to_return = "func " + name + "<"+type_params+">("+params+")->"+type+"{"+body+indent+"}";
		}
		else if(member(lang,["typescript"])){
			type = var_type(input_lang,lang,type);
			to_return = "function " + name + "<"+type_params+">("+params+")->"+type+"{"+body+indent+"}";
		}
	}
	else if(arr[0] === "static_method"){
		//return arr.toString();
		var type = arr[2];
		var name = arr[3];
		var params = parameters(input_lang,lang,indent,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		var access_modifier = arr[1];
		types[name] = type;
		if(member(lang,["java","c#"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier + " static " + type + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["coffeescript"])){
			to_return ="@" + name + ": ("+params+") ->"+body;
		}
		else if(member(lang,["perl"])){
			to_return = "sub " + name + "{my ("+params+") = @_; "+body+indent+"}";
		}
		else if(member(lang,["visual basic .net"])){
			to_return = access_modifier.charAt(0).toUpperCase() + access_modifier.slice(1) + " Shared " + name + "("+params+")"+" As "+var_type(input_lang,lang,type)+body+indent+"End Function";
		}
		else if(member(lang,["python","coconut"])){
			to_return = "@staticmethod"+indent+"def " + name + "("+params+"):"+body;
		}
		else if(member(lang,["c++","dart"])){
			to_return = "static " + var_type(input_lang,lang,type) + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["swift"])){
			to_return = ["class",ws_,"func",ws_,name,ws,"(",ws,params,ws,")",ws,"->",ws,var_type(input_lang,lang,type),ws,"{",ws,body,indent,"}"].join("");
		}
		else if(member(lang,["php","hack"])){
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
		var params = parameters(input_lang,lang,indent,arr[3]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[4]);
		if(member(lang,["java","c#","vala"])){
			to_return = "public " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["c++","dart"])){
			to_return = name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["python","coconut"])){
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
		else if(member(lang,["php","hack"])){
			to_return = "function __construct("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["gosu"])){
			to_return = "construct("+params+"){"+body+indent+"}";
		}
	}
	else if(arr[0] === "instance_method"){
		types[arr[3]] = arr[2];
		arr[4] = parameters(input_lang,lang,indent,arr[4]);
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
		else if(member(lang,["f#"])){
			to_return = "member this."+name+" "+params+" = "+body;
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
		else if(member(lang,["coffeescript"])){
			to_return =name + ": ("+params+") ->"+body;
		}
		else if(member(lang,["perl"])){
			to_return = "sub " + name + "{my ("+params+") = @_; "+body+indent+"}";
		}
		else if(member(lang,["visual basic .net"])){
			type = var_type(input_lang,lang,type);
			to_return = access_modifier.charAt(0).toUpperCase() + access_modifier.slice(1) + " " + name + "("+params+")"+" As "+type+body+indent+"End Function";
		}
		else if(member(lang,["python","coconut"])){
			to_return = "def " + name + "(self,"+params+"):"+body;
		}
		else if(member(lang,["swift"])){
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
		else if(member(lang,["php","hack"])){
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
		else if(member(lang,["javascript","c++","c#","haxe","typescript","python","coconut","php","lua","ruby","swift"])){
			to_return = a+"["+b+"]";
		}
		else if(member(lang,["scala","visual basic .net"])){
			to_return = a+"("+b+")";
		}
		else if(member(lang,["perl"])){
			to_return = a+"{"+b+"}";
		}
		else if(member(lang,["haskell"])){
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
		
		if((types[name] !== undefined) && (types[name][0] === "dict")){
			//alert("dict");
			return generate_code(input_lang,lang,indent,["access_dict",arr[1],arr[2]]);
		}
		
		var params = access_array_parameters(input_lang,lang,arr[2]);
		if(member(lang,["ruby","alt-ergo","glsl","yacas","python","coconut","c#","julia",'d',"swift","julia","janus","minizinc","picat","nim","autoit",'python_temp',"cython","coffeescript","dart","typescript","awk","vala","perl","javascript","go","c++","php","haxe",'c'])){
			to_return = name + "["+params+"]";
		}
		else if(member(lang,["java"])){
			//this is for ArrayLists
			to_return = name + ".get("+params+")";
		}
		else if(member(lang,["hy"])){
			to_return = name + "(get "+name+" "+params+")";
		}
		else if(member(lang,["lua"])){
			to_return = name + "["+params+"+ 1]";
		}
		else if(member(lang,["fortran"])){
			to_return = name + "("+params+"+ 1)";
		}
		else if(member(lang,["wolfram"])){
			to_return = name + "[["+params+"]]";
		}
		else if(member(lang,["haskell"])){
			to_return = "(" + name + " !! "+params+")";
		}
		else if(member(lang,["smt-lib","smt-lib"])){
			to_return = "(select " + name + " "+params+")";
		}
		else if(member(lang,["smt-lib"])){
			to_return = name + "(select "+name+" "+params+")";
		}
		else if(member(lang,["scala","visual basic .net"])){
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
		var params = parameters(input_lang,lang,indent,arr[2]);
		var body;
		
		//lambdas should contain only one return statement
		
		member(lang,["python","coconut"])
			&& (body = generate_code(input_lang,lang,indent+"    ",arr[3][1][0][1][1]))
		||
			(body = generate_code(input_lang,lang,indent+"    ",arr[3]));
		
		types[name] = type;
		
		member(lang,["javascript","typescript","haxe","r","php"])
			&& (to_return = "function("+params+"){"+body+indent+"}")
		|| member(lang,["go"])
			&& (to_return = "func("+params+"){"+body+indent+"}")
		|| member(lang,["python","coconut"])
			&& (to_return = "lambda "+params+":"+body)
		|| member(lang,["smalltalk"])
			&& (to_return = "["+params+"|"+body+"]")
		|| member(lang,["c++"])
			&& (to_return = "[](" + params + ") -> " + var_type(input_lang,lang,type) + "{"+body+indent+"}")
		|| member(lang,["lua","julia"])
			&& (to_return = "function("+params+")"+body+indent+"end")
		|| member(lang,["erlang"])
			&& (to_return = "fun("+params+")"+body+indent+"end")
		|| member(lang,["f#"])
			&& (to_return = "(fun "+params+" -> "+body+indent+")")
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
		|| member(lang,["maxima"])
			&& (to_return = "lambda(["+params+"],"+body+")")
		|| member(lang,["java"])
			&& (to_return = "("+params+") -> {"+body+indent+"}")
		|| member(lang,["scala"])
			&& (to_return = "("+params+") => {"+body+indent+"}");
		types[to_return] = type;
	}
	else if(arr[0] === "grammar_statement"){
		grammar_num = 0;
		var name = arr[1];
		var body = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,["jison","antlr","lark"])
			&& (to_return = name+":"+body+";")
		|| member(lang,["pypeg"])
			&& (to_return = "def "+name+"():"+indent+"    return "+body)
		|| member(lang,["clips"])
			&& (to_return = "(defrule " + name + " " + body + " => (assert (" + name + " A0 A" + grammar_num + ")))")
		|| member(lang,["parboiled"])
			&& (to_return = "public Rule "+name+"(){"+indent+"    return "+body+";}")
		|| member(lang,["treetop"])
			&& (to_return = "rule "+name+" "+body+" end")
		|| member(lang,["rebol"])
			&& (to_return = name+": ["+body+"]")
		|| member(lang,["chrg"])
			&& (to_return = body+" ::> "+name+".")
		|| member(lang,['constraint'])
			&& (to_return = body+" ::> "+name+".")
		|| member(lang,["lemon"])
			&& (to_return = name+" ::= "+body+".")
		|| member(lang,["txl"])
			&& (to_return = "define expression " + name+" "+body+" end define")
		|| member(lang,["perl 6"])
			&& (to_return = "rule "+name+"{"+body+"}")
		|| member(lang,["peg.js","lpeg","abnf","instaparse"])
			&& (to_return = name+" = "+body)
		|| member(lang,["regex"])
			&& (to_return = name+" = \""+body+"\"")
		|| member(lang,["coco/r"])
			&& (to_return = name+": "+body+".")
		|| member(lang,["prolog"])
			&& (to_return = name+"(["+grammar_vars+"])"+"-->"+body) && (grammar_vars = "")
		|| member(lang,["waxeye","canopy"])
			&& (to_return = name+"<-"+body)
		|| member(lang,["marpa"])
			&& (to_return = name+"::="+body)
		|| member(lang,["nearley","javacc","yecc"])
			&& (to_return = name+"->"+body)
		|| member(lang,["perl 6"])
			&& (to_return = "rule " + name+"{"+body+"}");
	}
	else if(arr[0] === "grammar_macro"){
		var name = arr[1];
		var params = arr[2].join(",");
		var body = generate_code(input_lang,lang,indent+"    ",arr[3]);
		
		member(lang,["prolog"])
			&& (to_return = name+"("+params+") -->"+body)
		|| member(lang,["chrg"])
			&& (to_return = body + " ::> " + name+"("+params+").")
		|| member(lang,["lemon"])
			&& (to_return = name+"("+params+") ::= "+body+".")
		|| member(lang,["clips"])
			&& (to_return = "(defrule " + name + " " + body + " => (assert " + "("+name + " " + params+")" + "))")
		|| member(lang,["nearley"])
			&& (to_return = name+"["+params+"] ->"+body)
		|| member(lang,["peg.js"])
			&& (to_return = name+" = "+body+" {return [\""+name+"\","+params+"];}");
	}
	else if(arr[0] === "grammar_var"){
		grammar_num += 1;
		if(grammar_num > 1){
			grammar_vars += ","
		}
		grammar_vars += "A"+grammar_num;
		member(lang,["perl 6"])
			&& (to_return = "<"+arr[1]+">")
		|| member(lang,["lpeg"])
			&& (to_return = "lpeg.V\""+arr[1]+"\"")
		|| member(lang,["parboiled"])
			&& (to_return = arr[1]+"()")
		|| member(lang,["prolog"])
			&& (to_return = arr[1]+"(A"+grammar_num+")")
		|| member(lang,["clips"])
			&& (to_return = "("+arr[1]+" A"+grammar_num+" A"+ (grammar_num+1) + ")")
		|| (to_return = arr[1]);
	}
	else if(arr[0] === "logic_or"){
		if(member(lang,["nearley","lemon",'parsec',"peggy",'happy',"chrg","instaparse","parboiled","javacc","rebol","lpeg","waxeye","txl","treetop","abnf","peg.js","antlr","marpa","wirth syntax notation","jison"])){
			//for all metalanguages
			to_return = generate_code(input_lang,lang,indent,["grammar_or",arr[1],arr[2]]);
		}
		
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,["prolog"])
			&& (to_return = a+";"+b)
		|| member(lang,["sympy","lua"])
			&& (to_return = a+" or "+b)
		|| member(lang,["minizinc","abella"])
			&& (to_return = a+" \\/ "+b)
		|| member(lang,["javascript"])
			&& (to_return = "logic.or("+a+","+b+")")
		|| member(lang,["smt-lib"])
			&& (to_return = "(or "+a+" "+b+")")
		|| member(lang,["java","c#","lua","php","perl","mysql","fortran",'c'])
			&& (to_return = generate_code(input_lang,lang,indent,["||",arr[1],arr[2]]));
		types[to_return] = "boolean";
	}
	else if(arr[0] === "logic_and"){
		if(member(lang,["nearley","pyparsing","lemon","chrg","instaparse","parboiled","javacc","waxeye","rebol","lpeg","txl","treetop","abnf","peg.js","antlr","marpa","wirth syntax notation","jison"])){
			to_return = generate_code(input_lang,lang,indent,["grammar_and",arr[1],arr[2]]);
		}
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,["prolog"])
			&& (to_return = a+","+b)
		|| member(lang,["sympy"])
			&& (to_return = a+" and "+b)
		|| member(lang,["pydatalog"])
			&& (to_return = a+" & "+b)
		|| member(lang,["javascript"])
			&& (to_return = "logic.and("+a+","+b+")")
		|| member(lang,["smt-lib","clips"])
			&& (to_return = "(and "+a+" "+b+")")
		|| member(lang,["java","fortran",'c',"c#","lua","php","perl","mysql","minizinc"])
			&& (to_return = generate_code(input_lang,lang,indent,["&&",arr[1],arr[2]]));
		
		types[to_return] = "boolean";
	}
	else if(arr[0] === "logic_equals"){
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,["prolog"])
			&& (to_return = a+"="+b)
		|| member(lang,["sympy"])
			&& (to_return = "Eq("+a+","+b+")")
		|| member(lang,["python","coconut"])
			&& (to_return = "sympy.Eq("+a+","+b+")")
		|| member(lang,["javascript"])
			&& (to_return = "logic.eq("+a+","+b+")")
		|| member(lang,["minizinc"])
			&& (to_return = a+"=="+b)
		|| member(lang,["smt-lib","clips"])
			&& (to_return = "(= "+a+" "+b+")");
		types[to_return] = "grammar";
	}
	else if(arr[0] === "grammar_or"){
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,["marpa","instaparse",'happy',"javacc","regex","txl","lark","coco/r","pest","wirth syntax notation","rebol","yapps","antlr","jison","waxeye","ometa","ebnf","nearley","parslet","yacc","perl 6","rebol","hampi",'earley-parser-js'])
			&& (to_return = a+"|"+b)
		|| member(lang,["prolog","chrg"])
			&& (to_return = a+";"+b)
		|| member(lang,["pypeg"])
			&& (to_return = "["+a+","+b+"]")
		|| member(lang,["parboiled"])
			&& (to_return = "AnyOf("+a+","+b+")")
		|| member(lang,["peg.js","abnf","treetop","canopy","peggy"])
			&& (to_return = a+"/"+b)
		|| member(lang,["lpeg"])
			&& (to_return = a+" + "+b);
		types[to_return] = "grammar";
	}
	else if(arr[0] === "grammar_and"){
		var a = generate_code(input_lang,lang,indent+"    ",arr[1]);
		var b = generate_code(input_lang,lang,indent+"    ",arr[2]);
		
		member(lang,["nearley","lemon","yecc","peggy","instaparse","javacc","treetop","txl","perl 6","canopy","coco/r","abnf","peg.js","antlr","marpa","wirth syntax notation","jison"])
			&& (to_return = a+" "+b)
		|| member(lang,["prolog","chrg","constraint handling rules"])
			&& (to_return = a+","+b)
		|| member(lang,["clips"])
			&& (to_return = "(and " + a+" "+b+")")
		|| member(lang,["regex"])
			&& (to_return = a+b)
		|| member(lang,["pypeg"])
			&& (to_return = "("+a+","+b+")")
		|| member(lang,["parboiled"])
			&& (to_return = "Sequence("+a+","+b+")")
		|| member(lang,["lpeg"])
			&& (to_return = a+" * "+b);
			
		types[to_return] = "grammar";
	}
	else if(arr[0] === "predicate"){
		if(member(lang,["clips"])){
			return generate_code(input_lang,lang,indent,["defrule",arr[1],arr[3],["function_call",arr[1],arr[2]]]);
		}
		var name = arr[1];
		var params = parameters(input_lang,lang,indent,arr[2]);
		var body = generate_code(input_lang,lang,"",arr[3]);
		
		member(lang,["pddl"])
			&& (to_return = "(:action " +name + " :parameters ("+params+") :precondition " + body + " :effect (" +name+" " + params + "))")
		|| member(lang,["fortran"])
			&& (to_return = "LOGICAL function " + name + "("+params+") "+body+indent+"end function "+name)
		|| member(lang,["prolog","logtalk","flix"])
			&& (to_return = name+"("+params+") :- "+body)
		|| member(lang,["constraint handling rules"])
			&& (to_return = name+"("+params+") :- "+body)
		|| member(lang,["common prolog"])
			&& (to_return = "(defrel " + name+" (("+params+") "+body+")")
		|| member(lang,["wolfram"])
			&& (to_return = name+"["+params+"] := "+body)
		|| member(lang,["ruby-prolog"])
			&& (to_return = name+"["+params+"] << "+body)
		|| member(lang,["alt-ergo"])
			&& (to_return = "predicate("+params+") ="+body)
		|| member(lang,["sympy"])
			&& (to_return = "def("+params+"):"+"\n    return "+body)
		|| member(lang,["javascript","php","hack"])
			&& (to_return = "function "+name+"("+params+"){"+indent+"return "+body+";}")
		|| member(lang,["python"])
			&& (to_return = "def "+name+"("+params+"):"+indent+"return "+body)
		|| member(lang,["ruby"])
			&& (to_return = "def "+name+"("+params+")"+indent+"return "+body+"end")
		|| member(lang,["haskell"])
			&& (to_return = name+" "+params+" = "+body)
		|| member(lang,["lua"])
			&& (to_return = "function "+name+"("+params+") return "+indent+"return "+body+" end")
		|| member(lang,["pydatalog"])
			&& (to_return = name + "(" + params + ")" + "<=" + body);
	}
	else if(arr[0] === "async_function"){
		//return arr.toString();
		var access_modifier = arr[1];
		var type = arr[2];
		var name = arr[3];
		function_name = name;
		var params = parameters(input_lang,lang,indent,arr[4]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		set_var_type(input_lang,lang,name,type);
		
		member(lang,["c#"])
			&& (to_return = access_modifier + " static async " + var_type(input_lang,lang,type) + " " + name + "("+params+"){"+body+indent+"}")
		|| member(lang,["javascript"])
			&& (to_return = "async function "+name+"("+params+"){"+body+"}")
		|| member(lang,["python","coconut"])
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
			var params = parameters(input_lang,lang,indent,arr[4]);
			var body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		}
	}
	else if(arr[0] === "macro"){
		//return arr.toString();
		var name = arr[1];
		var params = parameters(input_lang,lang,indent,arr[2]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[3]);
		if(member(lang,["c"])){
			to_return = "#define " + name + "("+params+") ("+body+")";
		}
		else if(member(lang,["common lisp"])){
			to_return = "(defmacro " + name + " ("+params+")"+body+")";
		}
		else if(member(lang,["hy"])){
			to_return = "(defmacro " + name + " ["+params+"]"+body+")";
		}
		else if(member(lang,["racket"])){
			to_return = "(define-syntax-rule " + name + " ("+params+")"+body+")";
		}
		else if(member(lang,["racket"])){
			to_return = "(define-syntax " + name + " ("+params+")"+body+")";
		}
		else if(member(lang,["julia"])){
			to_return = "macro " + name + " ("+params+")"+body+indent+"end";
		}
	}
	else if(arr[0] === "function_with_retval"){
		retval = arr[1];
		return generate_code(input_lang,lang,indent,["function",arr[2],arr[3],arr[4],arr[5],arr[6]]);
		
	}
	else if(arr[0] === "function"){
		//see https://rosettacode.org/wiki/Function_definition
		//return arr.toString();		
		var access_modifier = arr[1];
		var type = arr[2];
		var name = arr[3];
		set_var_type(input_lang,lang,name,type);
		function_name = name;
		global_vars.push(name);
		
		for (var key in types) {
			//clear types of objects that are not global vars
			if (types.hasOwnProperty(key) && global_vars.indexOf(key) === -1) {
				types[key] = undefined;
			}
		}
		
		function_params[name] = arr[4];
		if(input_lang === "prolog"){
			function_params[name] = function_params[name].map(function(a){
				return ["Object",a];
			});
		}
		//alert(JSON.stringify(function_params));
		
		param_index = 0;

		if(member(lang,["fortran","haskell","smt-lib","erlang"])){
			//in fortran, all parameters are passed by reference
			//in purely-functional languages, there is no difference between pass-by-reference and pass-by-value
			for(var i = 0; i < arr[4].length; i++){
				if(arr[4][i][0] === "ref_parameter"){
					arr[4][i] = [arr[4][i][1],arr[4][i][2]];
				}
			}
		}
		var params;
		if(is_statically_typed(lang) && is_dynamically_typed(input_lang)){
			//alert(JSON.stringify(types));
			body = generate_code(input_lang,lang,indent+"    ",arr[5]);
			//alert(JSON.stringify(types));
			params = parameters(input_lang,lang,indent,arr[4]);
		}
		else{
			params = parameters(input_lang,lang,indent,arr[4]);
		}
		var body;
		if(lang !== "smt-lib" && body === undefined){
			body = generate_code(input_lang,lang,indent+"    ",arr[5]);
		}
		if(member(lang,["java","c#"])){
			to_return = access_modifier + " static " + var_type(input_lang,lang,type) + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["mysql","transact-sql"])){
			if(type !== undefined || type === "Object"){
				type = types[function_name];
			}
			else{
				type = var_type(input_lang,lang,type);
			}
			if(var_type(input_lang,"java",type) === "void"){
				to_return = "CREATE PROCEDURE " + name + "("+params+") BEGIN " +body+indent+"END";
			}
			else{
				to_return = "CREATE FUNCTION " + name + "("+params+") RETURNS " + var_type(input_lang,lang,type) + " BEGIN " +body+indent+"END";
			}
		}
		else if(member(lang,["pl/sql"])){
			to_return = "CREATE FUNCTION " + name + "("+params+") RETURN " + var_type(input_lang,lang,type) + " BEGIN " +body+indent+"END";
		}
		else if(member(lang,["pddl"])){
			to_return = "(:action " +name + " :parameters ("+params+") :precondition " + body + " :effect (" +name+" " + params + "))";
		}
		else if(member(lang,["algol 68"])){
			to_return = "PROC "+name+" = (" + params + ") " +var_type(input_lang,lang,type)+ ": (" + body +indent+ ")";
		}
		else if(member(lang,["simula"])){
			to_return = "BEGIN "+var_type(input_lang,lang,type)+"PROCEDURE"+name+"(" + params + ");"+ body +indent+ "END";
		}
		else if(member(lang,["seed7"])){
			to_return = "const func "+var_type(input_lang,lang,type)+": "+name+"(" + params + ") is func begin"+ body + indent + "end func;";
		}
		else if(member(lang,["setl","gnu setl"])){
			to_return = "proc "+name+"(" + params + ");" + body+indent+ "end proc;";
		}
		else if(member(lang,["icon"])){
			to_return = "procedure "+name+"(" + params + ")" + body+indent+ "end";
		}
		else if(member(lang,["smalltalk"])){
			to_return = "|"+name+"|"+indent+ "name := [" + params + "|" + body +indent+ "].";
		}
		else if(member(lang,["clojure"])){
			to_return = "(defn "+name+"["+params+"] "+body+")";
		}
		else if(member(lang,["inform 6"])){
			to_return = "[ "+name+" "+params+";"+body+"];";
		}
		else if(member(lang,["reverse polish notation"])){
			to_return = "("+params+") "+name+" "+body+" =";
		}
		else if(member(lang,["coq"])){
			if(type !== undefined || type === "Object"){
				type = types[function_name];
			}
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
		else if(member(lang,["picolisp"])){
			to_return = "(de "+name+"("+params+") "+body+")";
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
		else if(member(lang,["ats"])){
			type = var_type(input_lang,lang,type);
			to_return = "fun " + name + "("+params+"):"+type+" = "+body+indent+"end";
		}
		else if(member(lang,["common lisp","emacs lisp"])){
			to_return = "(defun " + name + "("+params+")"+body+indent+")";
		}
		else if(member(lang,["newlisp","racket"])){
			to_return = "(define " + name + "("+params+")"+body+indent+")";
		}
		else if(member(lang,["hy"])){
			to_return = "(defn " + name + "["+params+"]"+body+indent+")";
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
		else if(member(lang,["sage","coffeequate"])){
			to_return = name + "("+params+") = "+body;
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
		else if(member(lang,["pythological"])){
			to_return =  name + " "+params+" <- "+body;
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
			to_return = name + " <- function("+params+"){"+body+indent+"}";
		}
		else if(lang === "fortran"){
			var words_list = arr[4].map(function(x){
				if(x.length === 2){
					return x[1];
				}
				else{
					return x[2];
				}
			}).join(", ");
			if(type !== undefined || type === "Object"){
				type = types[function_name];
			}
			type = types[function_name];
			//alert("type of "+function_name+": "+type);
			if(type === "void"){
				to_return = "subroutine " + name + "("+words_list+") "+params+" "+body+indent+"return end";
			}
			else{
				to_return = var_type(input_lang,lang,type) + " function " + name + "("+words_list+") "+params+" "+body+indent+"end function "+name;
				if(is_recursive){
					to_return = "recursive " + to_return;
				}
			}
		}
		else if(member(lang,["visual basic","visual basic .net"])){
			to_return = "Function " + name + "("+params+") As "+var_type(input_lang,lang,type)+" "+body+indent+"End Function";
		}
		else if(member(lang,["minizinc"])){
			if(type !== undefined || type === "Object"){
				type = types[function_name];
			}
			else{
				type = var_type(input_lang,lang,type);
			}
			to_return = "function var " + type + ":" + name + "("+params+") = "+body;
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
			if(type !== undefined || type === "Object"){
				type = types[function_name];
			}
			else{
				type = var_type(input_lang,lang,type);
			}
			to_return = "func " + name + "("+params+") -> "+var_type(input_lang,lang,type)+"{"+body+indent+"}";
		}
		else if(member(lang,["smt-lib"])){
			var words_list = arr[4].map(function(x){return x[1]}).join(" ");
			function_name = "(" + name + " " + words_list + ")";
			body = generate_code(input_lang,lang,indent+"    ",arr[5]);
			var types_list = arr[4].map(function(x) {
				return var_type(input_lang,lang,x[0]);
			}).join(" ");
			to_return = "(declare-fun " + name + "("+types_list+") "+var_type(input_lang,lang,type)+")"+" (assert (forall ("+params+") "+body+"))";
		}
		else if(member(lang,["rust"])){
			to_return = "fn " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["go"])){
			if(type !== undefined || type === "Object"){
				type = types[function_name];
			}
			to_return = "func " + name + "("+params+") "+var_type(input_lang,lang,type)+"{"+body+indent+"}";
		}
		else if(member(lang,["sidef"])){
			to_return = "func " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,['c',"glsl","vala"])){
			if(type !== undefined || type === "Object"){
				type = var_type(input_lang,lang,types[function_name]);
			}
			else{
				type = var_type(input_lang,lang,type)
			}
			to_return = type + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["c++","dart","pari/gp","ceylon","pike",'d'])){
			to_return = var_type(input_lang,lang,type) + " " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["ada","vhdl"])){
			to_return = "function " + name + "("+params+") return " +var_type(input_lang,lang,type)+ " is begin "+body+indent+"end function "+name+";";
		}
		else if(member(lang,["javascript","logicjs","php","hack","reasoned-php","awk"])){
			to_return = "function " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["autohotkey"])){
			to_return = name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["bash"])){
			to_return = "function " + name + "() {"+body+indent+"}";
		}
		else if(member(lang,["sentient"])){
			to_return = "function " + name + "("+params+"){"+body+indent+"};";
		}
		else if(member(lang,["english"])){
			to_return = "function " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["bc"])){
			to_return = "define " + name + "("+params+"){"+body+indent+"}";
		}
		else if(member(lang,["python","coconut","cython"])){
			to_return = "def " + name + "("+params+"):"+body;
		}
		else if(member(lang,["gdscript"])){
			to_return = "func " + name + "("+params+"):"+body;
		}
		else if(member(lang,["nim"])){
			to_return = "proc " + name + "("+params+"): "+var_type(input_lang,lang,type)+" ="+body;
		}
		else if(member(lang,["sympy","z3py"])){
			to_return = "def " + name + "("+params+"):"+"\n    return ("+body+")";
		}
		else if(member(lang,["typescript","hack"])){
			if(type === "Object"){
				to_return = "function " + name + "("+params+"){"+body+indent+"}";
			}
			else{
				to_return = "function " + name + "("+params+"):"+var_type(input_lang,lang,type)+"{"+body+indent+"}";
			}
		}
		else if(member(lang,["standard ml"])){
			if(type === "Object"){
				to_return = "fun " + name + "("+params+") ="+body;
			}
			else{
				to_return = "fun " + name + "("+params+"):"+var_type(input_lang,lang,type)+" = "+body;
			}
		}
		else if(member(lang,["dafny"])){
			to_return = "function " + name + "("+params+"):"+var_type(input_lang,lang,type)+"{"+body+indent+"}";
		}
		else if(member(lang,["delphi"])){
			to_return = "function " + name + "("+params+"):"+var_type(input_lang,lang,type)+"; begin"+body+indent+"end;";
		}
		else if(member(lang,["haskell"])){
			if(types[name] !== "Object"){
				var types_list = arr[4].map(function(x) {
					return var_type(input_lang,lang,x[0]);
				});
				to_return = name + "::" + types_list.join(" -> ") + " -> " + var_type(input_lang,lang,type) + indent + name + " " + params+" = "+body;
			}
			else{
				to_return = name + " " + params+" = "+body;
			}
		}
		else if(member(lang,["alt-ergo"])){
			var types_list = arr[4].map(function(x) {
				return var_type(input_lang,lang,x[0]);
			});
			var function_to_call = name + "(" + arr[4].map(function(x) {
				return var_name(lang,input_lang,x[1]);
			}).join(",")+")";
			to_return = "logic " + name + ":" + types_list.join(",") + " -> " + var_type(input_lang,lang,type) + indent +"axiom "+ name + ": " + params + " " + function_to_call + " = ("+body+")";
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
		else if(member(lang,["ocaml",'f#'])){
			if(is_recursive){
				to_return = "let rec "  + name + " " + params+" = "+body;
			}
			else{
				to_return = "let "  + name + " " + params+" = "+body;
			}
		}
		else if(member(lang,["lua","julia"])){
			to_return = "function " + name + "("+params+") "+body+indent+"end";
		}
		else if(member(lang,["octave"])){
			to_return = "function retval = " + name + "("+params+") "+body+indent+"endfunction";
		}
		else if(member(lang,["matlab"])){
			to_return = "function " + name + "("+params+") "+body+indent+"end";
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
		retval = undefined;
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
		if(member(lang, ["php","hack"])){
			to_return = access_modifier + " " + name + "=" + expr;
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[[["java"],[".",["this","$a"]]]],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["java","engscript","dart","groovy","typescript","javascript","c#","c++","haxe","chapel","julia"])){
			to_return = "this."+a;
		}
		else if(member(lang,["php","hack"])){
			to_return = "$this->"+a;
		}
		else if(member(lang,["perl"])){
			to_return = "$self->"+a;
		}
		else if(member(lang,["coffeescript","ruby"])){
			to_return = "@"+a;
		}
		else if(member(lang,["python","coconut"])){
			to_return = "self."+a;
		}
		set_var_type(input_lang,lang,to_return,a);
	}
	else if(arr[0] === "for"){
		var initial = generate_code(input_lang,lang,"",arr[1]);
		var condition = generate_code(input_lang,lang,"",arr[2]);
		var update = generate_code(input_lang,lang,"",arr[3]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[4]);
		if(member(lang,["java","glsl","c++",'d',"pawn","groovy","javascript","dart","typescript","php","hack","c#","perl","c++","awk","pike"])){
			to_return = "for("+initial+";"+condition+";"+update+"){"+body+indent+"}";
		}
		else if(member(lang,["inform 6"])){
			to_return = "for("+initial+": "+condition+": "+update+"){"+body+indent+"}";
		}
		else if(member(lang,['c'])){
			to_return = generate_code(input_lang,lang,"",["semicolon",["initialize_empty_vars",arr[1][1],[arr[1][2]]]]) +indent+ "for("+generate_code(input_lang,lang,"",["set_var",arr[1][2],arr[1][3]])+"; "+condition+"; "+update+"){"+body+indent+"}";
		}
		else if(member(lang,["go"])){
			to_return = "for "+initial+";"+condition+";"+update+"{"+body+indent+"}";
		}
		else if(member(lang,["tcl"])){
			to_return = "for {"+initial+"} {"+condition+"} {"+update+"} {"+body+indent+"}";
		}
		else if(member(lang,["yacas"])){
			to_return = "For("+initial+","+condition+","+update+")["+body+indent+"];";
		}
		else if(member(lang,["wolfram"])){
			to_return = "For["+initial+","+condition+","+update+", "+body+indent+"]";
		}
		
		//for languages that have while-loops but not for-loops
		else if(member(lang,["haxe","mysql","r","rebol","picat","julia","python","coconut","kotlin","lua","ruby","scala","swift","visual basic .net"])){
			to_return = indent+semicolon(lang,initial) +indent+ while_loop(lang,condition, indent+"    "+semicolon(lang,update)+body,indent);
		}
		else if(member(lang,["picat"])){
			to_return = indent+semicolon(lang,initial)+indent+ while_loop(lang,condition, indent+"    "+semicolon(lang,update)+body,indent);
		}
	}
	else if(arr[0] === "array_length"){
		var array = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,["javascript","java"])){
			to_return = array+".length";
		}
		else if(member(lang,"python","coconut")){
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
		else if(member(lang,["haxe","nim"])){
			if(type === "Object"){
				to_return = "var "+name;
			}
			else{
				to_return = "var "+name+":"+var_type(input_lang,lang,types[name]);
			}
		}
		else if(member(lang,["php"])){
			to_return = access_modifier + " "+name;
		}
		else if(member(lang,["c++"])){
			to_return = var_type(input_lang,lang,types[name]) + " " + name;
		}
		else if(member(lang,["ruby","python","coconut","javascript"])){
			return "";
		}
	}
	else if(arr[0] === "set_array_size"){
		//console.log(JSON.stringify(arr));
		var type = var_type(input_lang,lang,arr[1]);
		var name = var_name(lang,input_lang,arr[2]);
		var size = generate_code(input_lang,lang,indent,arr[3]);
		if(member(lang,["java","c#"])){
			to_return = type + " " +name+"["+size+"]";
		}
		if(member(lang,["fortran"])){
			to_return = type + "(len="+size+")::"+name;
		}
		else if(member(lang,["perl"])){
			to_return = "my @"+name+"; $"+name+"["+size+"] = 0";
		}
		else if(member(lang,["prolog"])){
			to_return = "length("+name+","+size+")";
		}
		else if(member(lang,["minizinc"])){
			to_return = ["array",ws,"[",ws,"1",ws,"..",ws,size,ws,"]",ws_,"of",ws_,type,ws,":",ws,name].join("");
		}
		else if(member(lang,["go"])){
			to_return = ["var",ws_,name,ws_,"[",ws,size,ws,"]",ws,type].join("");
		}
		else if(member(lang,['c',"c++"])){
			to_return = type+" "+name+"["+size+"]";
		}
		else if(member(lang,["glsl"])){
			if(type === "float"){
				to_return = "vec"+size+" "+name;
			}
			else if(type === "double"){
				to_return = "dvec"+size+" "+name;
			}
			else if(type === "int"){
				to_return = "ivec"+size+" "+name;
			}
			else if(type === "uint"){
				to_return = "uvec"+size+" "+name;
			}
			else if(type === "bool"){
				to_return = "bvec"+size+" "+name;
			}
		}
		set_var_type(input_lang,lang,name,[type,"[]"]);
	}
	else if(arr[0] === "initialize_constant"){
		//console.log(JSON.stringify(arr));
		var name = var_name(lang,input_lang,arr[2]);
		var expr = generate_code(input_lang,lang,indent,arr[3]);
		//console.log("initialize_var: "+ name + " "+arr[1]);
		types[name] = arr[1];
		
		if(is_declarative_language(lang)){			// for all declarative programming languages
			return generate_code(input_lang,lang,indent,["initialize_var",arr[1],arr[2],arr[3]]);
		}
		else if(member(lang, ["java"])){
			to_return = "final " + var_type(input_lang,lang,arr[1]) + " " + name + "=" + expr;
		}
		else if(member(lang, ["c++","thrift","glsl",'c','d',"c#"])){
			to_return = "const " + var_type(input_lang,lang,arr[1]) + " " + name + "=" + expr;
		}
		else if(member(lang, ["fortran"])){
			to_return = var_type(input_lang,lang,arr[1]) + ", parameter :: " + name + "=" + expr;
		}
		else if(member(lang, ["perl 6"])){
			to_return = "constant " + var_type(input_lang,lang,arr[1]) + " " + name + "=" + expr;
		}
		else if(member(lang, ["php","javascript","dart","julia"])){
			to_return = "const " + name + "=" + expr;
		}
		else if(member(lang, ["rust"])){
			to_return = "let " + name + "=" + expr;
		}
		else if(member(lang, ["typescript","chapel"])){
			to_return = "const " + name + ":" + var_type(input_lang,lang,arr[1]) + "=" + expr;
		}
		else if(member(lang, ["VHDL"])){
			to_return = "CONSTANT " + name + ":" + var_type(input_lang,lang,arr[1]) + "=" + expr;
		}
		else if(member(lang,["swift","nim"])){
			if(var_type(input_lang,"java",arr[1]) === "Object"){
				to_return = "let "+name+"="+expr;
			}
			else{
				to_return = "let "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
			}
		}
		else if(member(lang,["scala","kotlin"])){
			if(var_type(input_lang,"java",arr[1]) === "Object"){
				to_return = "val "+name+"="+expr;
			}
			else{
				to_return = "val "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
			}
		}
	}
	else if(arr[0] === "protobuf_parameter"){
		var num = arr[1];
		var type = arr[2];
		var name = var_name(lang,input_lang,arr[3]);
		if(arr.length === 5){
			
		}
		types[name] = type;
		if(member(lang,["thrift"])){
			return num+":" + var_type(input_lang,lang,type) + " "+name;
		}
		else if(member(lang,["protobuf"])){
			return var_type(input_lang,lang,type) + " "+name+" = " +num+";";
		}
	}
	else if(arr[0] === "protobuf_optional_parameter"){
		var num = arr[1];
		var required_or_optional = arr[2];
		var type = arr[3];
		var name = var_name(lang,input_lang,arr[4]);
		types[name] = type;
		if(member(lang,["thrift"])){
			return num+":"+ required_or_optional + " " + var_type(input_lang,lang,type) + " "+name;
		}
		else if(member(lang,["protobuf"])){
			return required_or_optional + " " + var_type(input_lang,lang,type) + " "+name+" = " +num+";";
		}
	}
	else if(arr[0] === "lexically_scoped_vars"){
		var the_variables;
		var the_statements;
		var declare_vars;
		if(member(lang,["common lisp","racket"])){
			the_variables = arr[1].map(function(x){return generate_code(input_lang,lang,indent,x)});
			the_statements = generate_code(input_lang,lang,indent+"    ",arr[2]);
			to_return = "(let ("+the_variables.join(" ")+") "+the_statements+")";
		}
		else if(member(lang,["haskell"])){
			the_variables = arr[1].map(function(x){return generate_code(input_lang,lang,indent,x)});
			the_statements = generate_code(input_lang,lang,indent+"    ",arr[2]);
			to_return = "let "+the_variables.join(indent)+" in "+the_statements;
		}
		else if(member(lang,["smt-lib"])){
			the_variables = arr[1].map(function(x){return generate_code(input_lang,lang,indent,x)});
			the_statements = generate_code(input_lang,lang,indent+"    ",arr[2]);
			to_return = the_variables.join(indent)+" "+the_statements;
			for(var i = 0; i < arr[1].length;i++){
				to_return += ")";
			}
		}
		else{
			the_variables = arr[1].map(function(x){return generate_code(input_lang,lang,"",x)}).join(indent);
			the_statements = generate_code(input_lang,lang,indent,arr[2]);
			if(lang === "wolfram"){
				the_variables += ";"
			}
			else if(member(lang,["erlang","prolog"])){
				the_variables += ","
			}
			to_return = the_variables + the_statements;
		}
	}
	else if(arr[0] === "lexically_scoped_var"){
		var name = var_name(lang,input_lang,arr[2]);
		var expr = generate_code(input_lang,lang,indent,arr[3]);
		if(member(lang,["common lisp","racket"])){
			to_return = "("+name+" "+expr+")";
		}
		else if(member(lang,["smt-lib"])){
			to_return = "(let (("+name+" "+expr+"))";
		}
		else if(member(lang,["haskell"])){
			to_return = generate_code(input_lang,lang,indent,["initialize_var",arr[1],arr[2],arr[3]]);
		}
		else{
			to_return = generate_code(input_lang,lang,indent,["semicolon",["initialize_var",arr[1],arr[2],arr[3]]]);
		}
	}
	else if(arr[0] === "initialize_var"){
		//console.log(JSON.stringify(arr));
		var name = var_name(lang,input_lang,arr[2]);
		if(defined_vars.indexOf(arr[2]) === -1){
			defined_vars.push(arr[2]);
		}
		var expr = generate_code(input_lang,lang,indent,arr[3]);
		var type;
		//console.log("initialize_var: "+ name + " "+arr[1]);
		
		if(arr[1] !== "Object"){
			//arr[1] = get_type[arr[1]];
			set_var_type(input_lang,lang,name,arr[1]);
			set_var_type(input_lang,lang,expr,arr[1]);
		}
		else{
			same_var_type(name,expr);
			//alert("type of "+expr+" is "+types[expr]);
		}
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			same_var_type(name,expr);
		}
		
		if(member(lang, ["java","glsl","c","c++","c#","vala"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			    type = types[expr];
		    }
		    else{
				type = arr[1];
			}
			to_return = var_type(input_lang,lang,type) + " " + name + "=" + expr;
		}
		else if(member(lang, ["transact-sql"])){
			to_return = "DECLARE " + name + " AS " + var_type(input_lang,lang,arr[1]) + "=" + expr;
		}
		else if(member(lang, ["mysql"])){
			to_return = "DECLARE " + name + " " + var_type(input_lang,lang,arr[1]) + " DEFAULT " + expr;
		}
		else if(member(lang, ["rust"])){
			to_return = "let mut " + name + "=" + expr;
		}
		else if(member(lang,["newlisp","common lisp"])){
			to_return = "(setf "+name+" "+expr+")";
		}
		else if(member(lang, ["hypertalk"])){
			to_return = "put " + expr + " into " + name;
		}
		else if(member(lang,["hy"])){
			to_return = "(setv "+name+" "+expr+")";
		}
		else if(member(lang, ["tcl"])){
			to_return = "set " + name.substring(1) + " [expr {" + expr+"}]";
		}
		else if(member(lang, ["applescript"])){
			to_return = "set " + name + " to " + expr;
		}
		else if(member(lang, ["minizinc"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			    type = types[expr];
		    }
		    else{
				type = arr[1];
			}
			to_return = var_type(input_lang,lang,type) + ":" + name + "=" + expr;
		}
		else if(member(lang, ["reverse polish notation"])){
			to_return = name +" "+ expr + " =";
		}
		else if(member(lang,["ruby","matlab","tex","frink","coffeescript","erlang","php","prolog","constraint handling rules","logtalk","picat","octave","wolfram","elm","haskell","python","rexx","mathematical notation","coconut","cython","julia","awk"])){
			to_return = name + "=" + expr;
		}
		else if(member(lang,["sympy"])){
			to_return = "Symbol(" +name+ ")" +"\n"+ indent + "Eq("+name+","+expr+")";
		}
		else if(member(lang,["logicjs"])){
			to_return = "eq("+name+","+expr+")";
		}
		else if(member(lang,["r"])){
			to_return = name + " <- " + expr;
		}
		else if(member(lang,["rebol",'red',"maxima"])){
			to_return = name + ": " + expr;
		}
		else if(member(lang,["visual basic","visual basic .net","openoffice basic",'libreoffice basic'])){
			to_return = "Dim "+name+" As "+var_type(input_lang,lang,arr[1]) +"="+expr;
		}
		else if(member(lang, ["javascript","dart","sidef","gdscript"])){
			to_return = "var " + name + "=" + expr;
		}
		else if(member(lang, ["ocaml","standard ml"])){
			to_return = "let " + name + "=" + expr;
		}
		else if(member(lang, ["algol 68"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			    type = types[expr];
		    }
		    else{
				type = arr[1];
			}
			to_return = var_type(input_lang,lang,type) + " " + name + ":=" + expr;
		}
		else if(member(lang, ["seed7"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			    type = types[expr];
		    }
		    else{
				type = arr[1];
			}
			to_return = "var "+var_type(input_lang,lang,type) + ":" + name + " is " + expr;
		}
		else if(member(lang, ["go","autohotkey","gnu smalltalk","smalltalk"])){
			to_return =  name + ":=" + expr;
		}
		else if(member(lang, ["ada"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			    type = types[expr];
		    }
		    else{
				type = arr[1];
			}
			to_return = name + ":" + var_type(input_lang,lang,type) + ":=" + expr;
		}
		else if(member(lang, ["perl","perl 6"])){
			to_return = "my " + name + "=" + expr;
			console.log(JSON.stringify(["types",name,types[name],expr,types[expr]]));
		}
		else if(member(lang, ["pari/gp"])){
			to_return = "my (" + name + "=" + expr+")";
		}
		else if(member(lang, ["smt-lib"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			    type = types[expr];
		    }
		    else{
				type = arr[1];
			}
			to_return = "(define-fun " + name + " () " + var_type(input_lang,lang,type) + " " + expr + ")";
		}
		else if(member(lang,["systemverilog","java","scriptol",'c',"cosmos","c++",'d',"englishscript","ceylon"])){
			to_return = name + "=" + expr;
		}
		else if(member(lang,["chapel"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			    type = types[expr];
		    }
		    else{
				type = arr[1];
			}
			to_return = "var "+name+":"+var_type(input_lang,lang,type)+"="+expr;
		}
		else if(member(lang,["vhdl"])){
			to_return = "variable "+name+":"+var_type(input_lang,lang,arr[1])+" := "+expr;
		}
		else if(member(lang,["nim"])){
			if(var_type(input_lang,"java",arr[1]) === "Object"){
				to_return = "var "+name+"="+expr;
			}
			else{
				to_return = "var "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
			}
		}
		else if(member(lang,["kotlin"])){
			if(var_type(input_lang,"java",arr[1]) === "Object"){
				to_return = "val "+name+"="+expr;
			}
			else{
				to_return = "val "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
			}
		}
		else if(member(lang,["haxe","gosu","scala","typescript","swift"])){
			if(arr[1] === "Object"){
				to_return =  "var "+name+"="+expr;
			}
			else{
				to_return =  "var "+name+":"+var_type(input_lang,lang,arr[1])+"="+expr;
				set_var_type(input_lang,lang,name,arr[1])
			}
		}
		else if(member(lang,["fortran"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			    type = types[expr];
		    }
		    else{
				type = arr[1];
			}
			to_return =  var_type(input_lang,lang,type)+"::"+name+"="+expr;
		}
		else if(member(lang,["sather"])){
			if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			    type = types[expr];
		    }
		    else{
				type = arr[1];
			}
			to_return =  name+": "+var_type(input_lang,lang,type)+" := "+expr;
		}
		else if(member(lang,["lua","julia","gap","bash"])){
			to_return =  "local " + name + "=" + expr;
		}
		else if(member(lang,["yacas","icon"])){
			to_return =  name + ":=" + expr;
		}
		else if(member(lang,["ruby","erlang","php","prolog","constraint handling rules","logtalk","picat","octave","wolfram"])){
			to_return =  name + "=" + expr;
		}
	}
	else if(arr[0] === "initialize_static_instance_var_with_value"){

		
		//console.log(JSON.stringify(arr));
		var name = var_name(lang,input_lang,arr[3]);
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
		var name = var_name(lang,input_lang,arr[3]);
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
		else if(member(lang, ["php","hack"])){
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
		var name = var_name(lang,input_lang,arr[3]);
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
		
		if(member(lang,["swift","c","c++","haxe","transact-sql","sql"])){
			return indent+semicolon(lang,generate_code(input_lang,lang,indent,["initialize_empty_vars",arr[2],[arr[3]]]));
		}
		
		//console.log(JSON.stringify(arr));
		var name = var_name(lang,input_lang,arr[3]);
		//console.log("initialize_var: "+ name + " "+arr[1]);
		types[name] = arr[2];
		types[arr[3]] = arr[2];
		if(member(lang, ["java","protobuf","c#"])){
			to_return = arr[1] + " " + var_type(input_lang,lang,types[name]) + " " + name + ";";
		}
		else if(member(lang, ["thrift"])){
			to_return = "required " + arr[1] + " " + var_type(input_lang,lang,types[name]) + " " + name + ";";
		}
		else if(member(lang, ["clips"])){
			to_return = "(slot " + name + ")";
		}
		else if(member(lang, ["javascript","python","coconut","ruby"])){
			to_return = "";
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","javascript"],[".",["$a",["function_call","endsWith",["$b"]]]]],
		[["cython","python","coconut"],[".",["$a",["function_call","endsWith",["$b"]]]]],
		[["ruby"],[".",["$a",["function_call","end_with?",["$b"]]]]],
		[["swift"],[".",["$a",["function_call","hasSuffix",["$b"]]]]],
		[["c#","f#"],[".",["$a",["function_call","EndsWith",["$b"]]]]]
	],matching_symbols)){
		var Str1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var Str2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
        if(member(lang,["haxe"]))
                to_return = ["StringTools.endsWith(",ws,Str1,ws,",",ws,Str2,ws,")"].join("");
        else if(member(lang,["go"]))
                to_return = ["strings.hasSuffix(",ws,Str1,ws,",",ws,Str2,ws,")"].join("");
        else if(member(lang,["prolog"]))
                to_return = "("+Str1+" = [_|"+Str2+"])";
        else if(member(lang,["julia"]))
                to_return = ["endswith(",ws,Str1,ws,",",ws,Str2,ws,")"].join("");
        else if(member(lang,["haskell"]))
                to_return = ["(isSuffixOf",ws_,Str1,ws_,Str2,ws,")"].join("");
        else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//global replace $b in the string $a with $c (not in-place)
		[["java","cython","python","coconut","ruby"],[".",["$a",["function_call","replace",["$b","$c"]]]]],
		[["c#"],[".",["$a",["function_call","Replace",["$b","$c"]]]]],
		[["english"],["function_call","replace",["$a","$b","$c"]]],
		[["php","hack"],["function_call","str_replace",["$b","$c","$a"]]],
		[["haxe"],[".",["StringTools",["function_call","replace",["$a","$b","$c"]]]]]
	],matching_symbols)){
		//console.log("matched replace");
		var Str1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var Str2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var Str3 = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		types[Str1] = "String";
		types[Str2] = "String";
		types[Str3] = "String";
		if(lang === "wolfram"){
			to_return = "StringReplace["+Str1+","+Str2+"->"+Str3+"]";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		if(to_return !== undefined){
			types[to_return] = "String";
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//check if $a starts with $b
		[["java","javascript"],[".",["$a",["function_call","startsWith",["$b"]]]]],
		[["ruby"],[".",["$a",["function_call","start_with?",["$b"]]]]],
		[["python","coconut"],[".",["$a",["function_call","startswith",["$b"]]]]],
		[["c#","f#"],[".",["$a",["function_call","StartsWith",["$b"]]]]],
		[["swift"],[".",["$a",["function_call","hasPrefix",["$b"]]]]],
		[["haxe"],[".",["StringTools",["function_call","startsWith",["$a","$b"]]]]],
		[["go"],[".",["strings",["function_call","hasPrefix",["$a","$b"]]]]],
		[["julia"],["function_call","startswith",["$a","$b"]]],
		[["coq"],["function_call","prefix",["$b","$a"]]]
	],matching_symbols)){
		var Str1 = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var Str2 = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
        if(member(lang,["php"])){
			to_return = "(substr(Str1, 0, strlen("+Str2+")) === "+Str1+")";
		}
		if(member(lang,["prolog"])){
			to_return = "append("+Str2+",_,"+Str1+")";
		}
        else if(member(lang,["haskell"]))
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
	else if(arr[0] === "parallel_lhs"){
		var list_inner = arr[1][0].map(function(x){return generate_code(input_lang,lang,indent,x)});
		to_return = list_inner.join(",");
	}
	else if(arr[0] === "parallel_rhs"){
		var list_inner = arr[1][0].map(function(x){return generate_code(input_lang,lang,indent,x)});
		to_return = list_inner.join(",");
	}
	else if(arr[0] === "associative_array"){
		var key_type = arr[1];
		var value_type = arr[2];
		var list_inner = arr[3].map(function(x){return generate_code(input_lang,lang,indent,["key_value",x])});
		if(member(lang,["python","coconut", "coffeescript", "english_temp", "cosmos", "ruby", "lua", "dart","javascript","typescript","c++","engscript"])){
			to_return = "{"+list_inner.join(",")+"}";
		}
		else if(member(lang,["haxe","frink","swift","elixir",'d',"wolfram","prolog","constraint handling rules"])){
			to_return = "["+list_inner.join(",")+"]";
		}
		else if(member(lang,["picat"])){
			to_return = "new_map(["+list_inner.join(",")+"])";
		}
		else if(member(lang,["julia"])){
			to_return = "Dict("+list_inner.join(",")+")";
		}
		else if(member(lang,["smt-lib"]) && list_inner.length === 0){
			var key_type = var_type(input_lang,lang,arr[1]);
			var value_type = var_type(input_lang,lang,arr[2]);
			to_return = "(Array "+key_type+" "+value_type+")";
		}
		else if(member(lang,["php"])){
			to_return = "array("+list_inner.join(",")+")";
		}
		else if(member(lang,["haskell"])){
			to_return = "(Data.Map.fromlist ["+list_inner.join(",")+"])";
		}
		else if(member(lang,["scala","perl"])){
			to_return = "("+list_inner.join(",")+")";
		}
		else if(member(lang,["octave"])){
			to_return = "struct("+list_inner.join(",")+")";
		}
		else if(member(lang,["hy"])){
			to_return = "{"+list_inner.join(" ")+"}";
		}
		else if(member(lang,["rebol"])){
			to_return = "to-hash ["+list_inner.join(" ")+"]";
		}
		else if(member(lang,["prolog"])){
			if(list_inner.length === 0){
				to_return = "[_|_]";
			}
		}
		else if(member(lang,["c#","java","swift"])){
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
		if(member(lang,["javascript","typescript","swift","python","cython","coconut","applescript"])){
			return the_key+":"+the_value;
		}
		else if(member(lang,["php","haxe","perl","ruby","julia"])){
			return the_key+"=>"+the_value;
		}
		else if(member(lang,["scala","wolfram"])){
			return the_key+"->"+the_value;
		}
		else if(member(lang,["picat","lua"])){
			return the_key+"="+the_value;
		}
		else if(member(lang,["rebol","hy"])){
			return the_key+" "+the_value;
		}
		else if(member(lang,["c#","c++","haskell"])){
			return "{"+the_key+","+the_value+"}";
		}
		else if(member(lang,["java"])){
			return "put("+the_key+","+the_value+")";
		}
	}
	else if(arr[0] === "named_parameter"){
		var the_key = arr[1];
		var the_value = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["c#","ruby","swift"])){
			return the_key+":"+the_value;
		}
		else if(member(lang,["modula-3"])){
			return the_key+":"+the_value;
		}
		if(member(lang,["python","cython","coconut","fortran","kotlin","r","nim","nemerle"])){
			return the_key+"="+the_value;
		}
	}
	else if(arr[0] === "initialize_struct"){
		var list_inner = arr[2].map(function(x){return generate_code(input_lang,lang,indent,x)});
		if(member(lang,["c"])){
			to_return = "{"+list_inner.join(",")+"}";
		}
		else if(member(lang,["fortran","swift"])){
			to_return = arr[1]+"("+list_inner.join(",")+")";
		}
		else if(member(lang,["haskell"])){
			to_return = arr[1]+"{"+list_inner.join(",")+"}";
		}
		else if(member(lang,["erlang"])){
			to_return = "#"+arr[1]+"{"+list_inner.join(",")+"}";
		}
		types[to_return] = arr[1];
	}
	else if(arr[0] === "initializer_list"){
		var list_inner = arr[2].map(function(x){return generate_code(input_lang,lang,indent,x)});
		if(member(lang,["ruby","icon","asciimath","standard ml","coq","erlang","maxima","elm","cosmos", "python","sage","coconut", "cython", "nim",'d',"frink","octave","julia","prolog","constraint handling rules","minizinc","engscript","cython","groovy","dart","typescript","coffeescript","nemerle","javascript","haxe","haskell","rebol","polish notation","swift"])){
			to_return = "["+list_inner.join(",")+"]";
		}
		else if(member(lang,["rebol"])){
			to_return = "["+list_inner.join(" ")+"]";
		}
		else if(member(lang,["perl","mysql","chapel","glsl"])){
			to_return = "("+list_inner.join(",")+")";
		}
		else if(member(lang,["fortran"])){
			to_return = "("+list_inner.join(",")+")";
		}
		else if(member(lang,["emacs lisp","common lisp","scheme"])){
			to_return = "(list "+list_inner.join(" ")+")";
		}
		else if(member(lang,["ocaml"])){
			//This is a list, not an array
			to_return = "["+list_inner.join(";")+";]";
		}
		else if(member(lang,["php","hack"])){
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
			to_return = "list("+list_inner.join(",")+")";
		}
		else if(member(lang,["scala"])){
			to_return = "Array("+list_inner.join(",")+")";
		}
		else if(member(lang,["tcl"])){
			to_return = "{"+list_inner.join(" ")+"}";
		}
		else if(member(lang,["bash","common prolog"])){
			to_return = "("+list_inner.join(" ")+")";
		}
		else if(member(lang,["lua","scriptol","applescript","gosu","yacas","pseudocode","picat","c#","c++",'c',"visual basic","visual basic .net","wolfram"])){
			to_return = "{"+list_inner.join(",")+"}";
		}
		//console.log(JSON.stringify(arr));
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			//type inference for statically-typed target languages
			var current_type;
			for(var i of list_inner){
				if(types[i] === undefined || types[i] !== Object){
					current_type = types[i];
				}
			}
			for(var j of list_inner){
				types[j] = current_type;
			}
		}
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
		if(member(lang, ["python","coconut"])){
			to_return =  "for "+index+","+item+" in enumerate("+the_list+"):"+body;
		}
		else if(member(lang, ["javascript"])){
			to_return = "var item; for(var "+index+"=0; "+index+"<"+the_list+".length;"+index+"++){item="+the_list+"["+index+"]; "+body+indent+"}";
		}
		else if(member(lang, ["go"])){
			to_return = "for "+index+","+item+" := range "+the_list+"{"+body+indent+"}";
		}
		else if(member(lang, ["prolog"])){
			to_return = "forall(nth0("+index+","+the_list+","+item+"),("+body+indent+"))";
		}
		else if(member(lang, ["php","hack"])){
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
			else if(member(lang,["php","hack"])){
				to_return ="array_map(function(" + variable + "){return " + result + ";}, " + the_list + ")";
			}
			else if(member(lang,["c#"])){
				to_return = "(from " + variable + " in " + the_list + " select " + result+")";
			}
			else if(member(lang,["minizinc"])){
				to_return = "["+ result + "|" + variable + " in " + the_list + "]";
			}
			else if(member(lang,["python","sage","cython","coconut","julia"])){
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
			if(member(lang,["python","sage","cython","coconut","julia"])){
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
	else if(arr[0] === "forall"){
		var item = generate_code(input_lang,lang,indent,arr[1]);
		var body = generate_code(input_lang,lang,indent+"    ",arr[2]);
		types[item] = "boolean";
		types[body] = "boolean";
		if(member(lang, ["prolog"])){
			to_return = "forall("+item+","+body+")";
		}
		else if(member(lang, ["wolfram"])){
			to_return = "ForAll["+item+","+body+"]";
		}
		else if(member(lang, ["z3py"])){
			to_return = "ForAll("+item+","+body+")";
		}
		else if(member(lang, ["minizinc"])){
			to_return = "forall("+item+")("+body+")";
		}
		types[to_return] = "boolean";
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
		else if(member(lang, ["scriptol"])){
			to_return = "for "+var_type(input_lang,lang,arr[1])+" "+item+" in "+the_list+body+indent+"/for";
		}
		else if(member(lang, ["alt-ergo"])){
			to_return = "forall "+item+" "+var_type(input_lang,lang,arr[1])+". "+the_list+body+indent;
		}
		else if(member(lang, ["coq"])){
			to_return = "(forall ("+item+":"+var_type(input_lang,lang,arr[1])+") ("+the_list+":list "+var_type(input_lang,lang,arr[1])+"), "+body+")";
		}
		else if(member(lang,["erlang"])){
			to_return = "lists:foreach(fun(" + item + ") ->" +
                      body+indent+
            "end,"+the_list+")";
		}
		else if(member(lang, ["c#"])){
			to_return = "foreach("+var_type(input_lang,lang,arr[1])+" "+item+" in "+the_list+"){"+body+indent+"}";
		}
		else if(member(lang, ["visual basic .net"])){
			to_return = "For Each "+item+" as "+ var_type(input_lang,lang,arr[1]) +" in "+the_list+body+indent+"Next";
		}
		else if(member(lang,["c++"])){
			to_return = "for(" + var_type(input_lang,lang,arr[1]) + " & " + item + ":" + the_list + "){"+body+indent+"}";
		}
		else{
			to_return = inputs_to_outputs(lang,{item:item,the_list:the_list,body:body," indent ":indent},[
				[["r"],"for(item in the_list){body indent }"],
				[["dart"],"for(var item in the_list){body indent }"],
				[["php","hack"],"forall(the_list as item){body indent }"],
				[['minzinc'],"forall(item in the_list){body indent }"],
				[["perl"],"foreach item(the_list){body indent }"],
				[["lua"],"for _,item in pairs(the_list) do body indent end"],
				[["javascript","typescript"],"(the_list).forEach(function(item){body indent })"],
				[["python","cython","coconut"],"for item in the_list:body"],
				[["swift","chapel"],"for item in the_list{body indent }"],
				[["haxe","groovy","sidef"],"for(item in the_list){body indent }"],
				[["applescript"],"repeat with item in the_list body indent end repeat"],
				[["coffeescript"],"for item in the_list body"],
				[["julia"],"for item=the_list body indent end"],
				[["wolfram"],"Do[(body),{item,the_list}]"],
				[["common lisp"],"(loop for item in the_list do body)"],
				[["smalltalk"],"the_list do: [ :item | body indent ]."],
				[["rebol"],"foreach item the_list [body indent ]"],
				[["octave"],"foreach item = the_list body indent endfor"],
				[["tcl"],"foreach item the_list{body indent}"],
				[["ring"],"for item in the_list body indent next"],
				[["scala"],"for(item <- the_list){body indent }"],
				[["ruby"],"the_list.each do|item|body indent end"],
				[["go"],"for _, item := range the_list{body indent }"],
				[["prolog"],"forall(member(item,the_list),(body indent ))"],
				[["picat"],"foreach(item in the_list) body indent end"],
				[["d"],"foreach(item;the_list){body indent }"]
			]);
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
		if(member(lang,["ruby"])){
			to_return = "loop do" + a +indent+"    "+ "break if " + b + indent +"end";
		}
		else{
			to_return = inputs_to_outputs(lang,{a1:a,b1:b," indent ":indent},[
				[["common lisp"],
					"(loop do a1 while b1)"],
				[["scriptol"],
					"while a1 b1 indent /while"],
				[["java","c","c#","php","glsl","c++","javascript","perl"],
					"do {a1 indent } indent while(b1);"],
				[["mysql"],
					"REPEAT a2 UNTIL a1 indent END REPEAT;"],
				[["yacas"],
					"Until (a1) [ b1 indent ];"]
			]);
		}
	}
	else if(Array.isArray(arr) && arr.length === 1){
		to_return = generate_code(input_lang,lang,indent,arr[0]);
	}
	else if(arr[0] === "semicolon"){
		return indent+semicolon(lang,generate_code(input_lang,lang,indent,arr[1]));
	}
	else if(arr[0] === "parallel_assignment"){
		//console.log(JSON.stringify(arr));
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		//console.log("initialize_var: "+ arr[2] + " "+arr[1]);
		same_var_type(a,b);
		to_return = inputs_to_outputs(lang,{a1:a,b1:b},[
			[["lua","ruby"],
				"a1 = b1"],
			[["go"],
				"a1 := b1"],
			[["javascript","prolog","coffeescript"],
				"[a1] = [b1]"],
			[["perl"],
				"(a1) = (b1)"],
			[["php"],
				"array(a1) = b1"]
		]);
	}
	else if(arr[0] === "set_var"){
		//console.log(JSON.stringify(arr));
		if(member(lang,["prolog","logtalk","constraint handling rules","logicjs","smt-lib","sympy"])){
			return generate_code(input_lang,lang,indent,["==",arr[1],arr[2]]);
		}
		else if(member(input_lang,["fortran"]) && function_name === generate_code(input_lang,lang,indent,arr[1])){
			//alert(function_name);
			return generate_code(input_lang,lang,indent,["return",arr[2]]);
		}
		
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		//console.log("initialize_var: "+ arr[2] + " "+arr[1]);
		same_var_type(a,b);
		if(retval === a){
			same_var_type(retval,a);
			types[function_name] = types[retval];
		}
		if(member(lang,["tcl"])){
			to_return = "set "+a.substring(1)+" [expr {"+b+"}]";
		}
		else{
			to_return = inputs_to_outputs(lang,{a1:a,b1:b},[
				[["javascript","glsl","sentient","sage","english","ring","tex","coffeescript","cython","haskell","python","coconut","minizinc","systemverilog","elixir","visual basic .net","lua","ruby","scriptol","mathematical notation","perl 6","wolfram","chapel","katahdin","frink","picat","ooc","d","genie","janus","ceylon","idp","processing","java","boo","gosu","pike","kotlin","powershell","engscript","pawn","freebasic","hack","nim","openoffice basic","groovy","typescript","rust","fortran","awk","go","swift","vala","c","julia","scala","cobra","erlang","autoit","dart","java","ocaml","haxe","c#","matlab","c++","php","perl","gambas","octave","visual basic","bc"],
					"a1 = b1"],
				[["rebol","maxima"],
					"a1: b1"],
				[["r"],
					"a1 <- b1"],
				[["applescript"],
					"set a1 to b1"],
				[["reverse polish notation"],
					"a1 b1 ="],
				[["mysql"],
					"set a1 = b1"],
				[["newlisp","common lisp"],
					"(setf a1 b1)"],
				[["hy"],
					"(setv a1 b1)"],
				[["gap",'autohotkey',"sather","setl","gnu setl","smalltalk","ada","algol 68","seed7","delphi","vhdl","yacas","icon"],
					"a1 := b1"]
			]);
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
		types[arr] = "double";
		to_return = arr;
	}
	else if(typeof arr === 'string' && arr.startsWith("\"")){
		//detect string literals
		types[arr] = "String";
		if(lang === "regex"){
			arr = arr.substring(1,arr.length-1);
		}
		to_return = arr;
	}
	else if(typeof arr === 'string' && arr.startsWith("\'")){
		//detect character literals
		types[arr] = "char";
		to_return = arr;
	}
	//do this if it's an identifier
	else if(typeof arr === 'string' && /^[$A-Z_][0-9A-Z_$]*$/i.test(arr)){
		to_return = var_name(lang,input_lang,arr);
	}
	else if(arr.length === 2 && arr[0] === "." && (arr[1].length === 1)){
		if(!isNaN(arr[1])){
			to_return = arr[1][0];
			types[to_return] = "double"
		}
		else if(typeof arr[1][0] === 'string' && /^[$A-Z_][0-9A-Z_$]*$/i.test(arr[1][0])){
			return var_name(lang,input_lang,arr[1][0]);
		}
		else{
			return generate_code(input_lang,lang,indent,arr[1]);
		}
	}
	else if(member(input_lang, ["java"]) && (matches_pattern(arr,[".",["Arrays",["function_call","deepEquals",["$a","$b"]]]],matching_symbols) || matches_pattern(arr,[".",["Arrays",["function_call","equals",["$a","$b"]]]],matching_symbols))){
		//console.log("Equals "+ matching_symbols["$a"] + " "+ matching_symbols["$b"]);
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["java"])){
			to_return = "Arrays.deepEquals("+a+","+b+")";
		}
		else if(member(lang,["php","hack",'ocanren'])){
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
			to_return = inputs_to_outputs(lang,{a1:a,b1:b},[
				[["c++","systemverilog"],
					"a1.compare(b1)"],
				[["c#"],
					"a1.Equals(b1)"]
				[["java"],
					"a1.equals(b1)"],
				[["logicjs"],
					"eq(a1,b1)"],
				[["sympy"],
					"Eq(a1,b1)"],
				[["perl"],
					"(a1 eq b1)"],
				[["javascript","php","typescript","hack"],
					"(a1 === b1)"],
				[["visual basic","mathematical notation","visual basic .net","delphi","vbscript","f#","prolog","mathematical notation","ocaml","livecode","monkey x"],
					"(a1 = b1)"],
				[["pydatalog","ruby","lua","perl 6","python","coconut","cython","englishscript","chapel","julia","fortran","minizinc","picat","go","vala","autoit","rebol","ceylon","groovy","scala","coffeescript","awk","haskell","haxe","dart","swift"],
					"(a1 == b1)"]
			]);
			types[to_return] = "boolean";
		}
	}
	else if(arr[0] === "=="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		same_var_type(a,b);
		if(member(lang,["nim","pari/gp","z3py","sage","kotlin","sentient","english","mathematical notation","lc++","cython","lua","python","coconut",'smt-libpy',"pydatalog",'e',"ceylon","perl 6","englishscript","cython","dafny","wolfram",'d',"rust","r","minizinc","frink","picat","pike","pawn","processing","c++","glsl","ceylon","coffeescript","octave","swift","awk","julia","groovy","erlang","haxe","scala","vala","dart","c#",'c',"go","haskell"])){
			to_return = a + arr[0] + b;
		}
		else if(member(lang,["sympy"])){
			to_return = "Eq("+a + "," + b + ")";
		}
		else if(member(lang,["reverse polish notation"])){
			to_return = a + " " + b + " =";
		}
		else if(member(lang,["fortran"])){
			to_return = a + " .eq. " + b;
		}
		else if(member(lang,["logicjs","reasoned-php"])){
			to_return = "eq("+a + "," + b + ")";
		}
		else if(member(lang,["maxima"])){
			to_return = "is(equal("+a + "," + b + "))";
		}
		else if(member(lang,["perl"])){
			if(member("String",[types[a],types[b]])){
				to_return = a +" eq "+ b;
			}
			else if(member(types[a],["int","double","float"]) || member(types[b],["int","double","float"])){
				to_return = a +" == "+ b;
			}
		}
		else if(member(lang,["coq"])){
			if(member("String",[types[a],types[b]])){
				to_return = "(string_dec "+a +" "+ b+")";
			}
		}
		else if(member(lang,["java"])){
			if(member("String",[types[a],types[b]])){
				to_return = a +".equals("+b+")";
			}
			else if(member(types[a],["int","double","float"])){
				to_return = a +" == "+ b;
			}
		}
		else if(member(lang,["prolog","constraint handling rules"])){
			to_return = a + " == " + b;
		}
		else if(member(lang,["ruby"])){
			to_return = a + " == " + b;
		}
		else if(member(lang,["mysql"])){
			to_return = a + " = " + b;
		}
		else if(member(lang,["rebol","tex","mathematical notation"])){
			to_return = a + " = " + b;
		}
		else if(member(types[a], ["int","float","double","long"]) && member(lang,["maxima","alt-ergo",'pl/sql',"standard ml","seed7","monkey x","gap","rebol","f#","autoit","pascal","delphi","visual basic","mysql","visual basic .net","ocaml","livecode","vbscript"])){
			to_return = a + " = " + b;
		}
		else if(member(lang,["javascript","chr.js","php","typescript","hack"])){
			to_return = a + "===" + b;
		}
		else if(member(lang,['c',"c++","c#","haskell","elixir"])){
			if(member(types[a],['int','double','char','float','boolean'])){
				to_return = a + arr[0] + b;
			}
		}
		else if(member(lang,["smt-lib","clojure","smt-lib","emacs lisp","common lisp","clips","racket"])){
			if(member(types[a],['int','double','char','float','boolean',"Object"])){
				to_return = "(= " + a + " " + b + ")";
			}
		}
		else{
			throw arr[0]+" is not defined for "+lang;
		}
		types[to_return] = "boolean";
;	}
	else if(member(arr[0],["-","*","/"])){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(types[a] === undefined){
			types[a] = "double";
		}
		if(types[b] === undefined){
			types[b] = "double";
		}
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
		else if(member(lang,['forth',"reverse polish notation"])){
			to_return =  a + " " + b+" "+arr[0];
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
		if(member(lang,["ruby","haxe"])){
			to_return = a + "..." + b;
		}
		else if(member(lang,["swift"])){
			to_return = a + ".." + b;
		}
		else if(member(lang,["haskell"])){
			to_return = a + "..(" + b+"-1)";
		}
		else if(member(lang,["python","cython","coconut"])){
			to_return = "range(" + a + "," + b + ")";
		}
		else if(member(lang,["php"])){
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
		if(member(lang,["ruby","perl","haskell"])){
			to_return = a + ".." + b;
		}
		else if(member(lang,["swift"])){
			to_return = a + "..." + b;
		}
		else if(member(lang,["haxe"])){
			to_return = a + "...(" + b + "+1)";
		}
		else if(member(lang,["python","cython","coconut"])){
			to_return = "range(" + a + "," + b + "+1)";
		}
		else if(member(lang,["php"])){
			to_return = "range(" + a + "," + b + ")";
		}
		types[to_return] = ["int","[]"];
	}
	else if(member(arr[0],["%"])){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["java","english","lua","ruby","perl 6","python","coconut","cython","rust","typescript","frink","ooc","genie","pike","ceylon","pawn","powershell","coffeescript","gosu","groovy","engscript","awk","julia","scala","f#","swift","r","perl","nemerle","haxe","php","hack","vala","tcl","go","dart","javascript",'c',"c++","c#"])){
			to_return = a + arr[0] + b;
		}
		else if(member(lang,["haskell","seed7","minizinc","ocaml","delphi","pascal","picat","livecode"])){
			to_return = a + " mod " + b;
		}
		else if(member(lang,["erlang"])){
			to_return = a + " rem " + b;
		}
		else if(member(lang,["visual basic","monkey x"])){
			to_return = a + " Mod " + b;
		}
		else if(member(lang,['forth'])){
			to_return = a + b + " mod";
		}
		else if(member(lang,["prolog","octave","matlab","autohotkey","fortran"])){
			to_return = "mod("+a + "," + b+")";
		}
		else if(member(lang,["rebol"])){
			to_return = "mod "+a + " " + b;
		}
		else if(member(lang,["wolfram"])){
			to_return = "Mod["+a + "," + b+"]";
		}
		else if(member(lang, ["clips","clojure","common lisp","smt-lib"])){
			to_return = "(mod "+a + " " + b+")";
		}
		else{
			throw arr[0]+" is not defined for "+lang;
		}
		types[a] = "int";
		types[b] = "int";
		types[to_return] = "int";
	}
	else if(member(arr[0],[">","<",">=","<="])){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			set_var_type(input_lang,lang,a,"double");
			set_var_type(input_lang,lang,b,"double");
		}
		same_var_type(a,b);
		to_return = unparse(input_lang,lang,indent,arr,matching_symbols);
		types[to_return] = "boolean";
	}
	else if(arr[0] === "eager_or"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["javascript","python","c++","c#","php","smalltalk","perl","ruby","java","julia","matlab","r","swift"])){
			to_return = a + "|" + b;
		}
		else if(member(lang,["erlang","pascal"])){
			to_return = a + " or " + b;
		}
		else if(member(lang,["prolog"])){
			to_return = a + "; " + b;
		}
		else if(member(lang,["erlang","pascal"])){
			to_return = a + " Or " + b;
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "eager_and"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["javascript","python","c++","c#","php","smalltalk","perl","ruby","java","julia","matlab","r","swift"])){
			to_return = a + "&" + b;
		}
		else if(member(lang,["erlang","pascal"])){
			to_return = a + " and " + b;
		}
		else if(member(lang,["prolog"])){
			to_return = a + ", " + b;
		}
		else if(member(lang,["erlang","pascal"])){
			to_return = a + " And " + b;
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "||"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(is_statically_typed(lang)){
			types[arr[1]] = "boolean";
			types[arr[2]] = "boolean";
			types[a] = "boolean";
			types[b] = "boolean";
			//alert(a+"||"+b);
			//alert(types[a]);
		}
		
		if(member(lang,["javascript","sidef","coq","lc++","tcl","autohotkey","katahdin","perl 6","ruby","wolfram","chapel","elixir","frink","ooc","picat","janus","processing","pike","nools","pawn","matlab","hack","gosu","rust","autoit","autohotkey","typescript","ceylon","groovy",'d',"octave","awk","julia","scala","f#","swift","nemerle","vala","go","perl","java","haskell","haxe",'c',"c++","c#","dart","r"])){
			to_return = a + "||" + b;
		}
		else if(member(lang,["reverse polish notation"])){
			to_return = a + " " + b+" or";
		}
		else if(member(lang,["reasoned-php"])){
			to_return = "conde([" + a + "," + b+"])";
		}
		else if(member(lang,["minizinc","abella"])){
			to_return = a + "\\/" + b;
		}
		else if(member(lang,["algol 68"])){
			to_return = a + " orelse " + b;
		}
		else if(member(lang,["visual basic","monkey x","visual basic .net","yacas"])){
			to_return = a + " Or " + b;
		}
		else if(member(lang,["logicjs","reasoned-php"])){
			to_return = "or(" + a + "," + b + ")";
		}
		else if(member(lang,["mathematical notation"])){
			to_return = a + "\u2228" + b;
		}
		else if(member(lang,["cosmos","gams","alt-ergo",'pl/sql',"mysql","cython","vhdl","python","coconut","lua","seed7","livecode","englishscript","cython","gap","mathematical notation","genie","idp","maxima","engscript","ada","newlisp","ocaml","nim","coffeescript","pascal","delphi","erlang","rebol","php"])){
			to_return = a + " or " + b;
		}
		else if(member(lang,["smt-lib","common lisp","clips","pddl","clojure","common lisp","emacs lisp","clojure","racket"])){
			to_return = "(or "+a+" "+b+")";
		}
		else if(member(lang,["z3py"])){
			to_return = "Or("+a+","+b+")";
		}
		else if(member(lang,["prolog","constraint handling rules"])){
			to_return = a+";"+b;
		}
		else if(member(lang,["fortran"])){
			to_return = a+" .or. "+b;
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "&&"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(is_statically_typed(lang)){
			types[arr[1]] = "boolean";
			types[arr[2]] = "boolean";
			types[a] = "boolean";
			types[b] = "boolean";
			//alert(a+"||"+b);
			//alert(types[a]);
		}
		if(member(lang,["javascript","coq","lc++","tcl","autohotkey","ats","ruby","katahdin","perl 6","wolfram","chapel","elixir","frink","ooc","picat","janus","processing","pike","nools","pawn","matlab","hack","gosu","rust","autoit","autohotkey","typescript","ceylon","groovy",'d',"octave","awk","julia","scala","f#","swift","nemerle","vala","go","perl","java","haskell","haxe",'c',"c++","c#","dart","r"])){
			to_return = a + "&&" + b;
		}
		else if(member(lang,["logicjs","reasoned-php"])){
			to_return = "and("+a + "," + b+")";
		}
		else if(member(lang,["algol 68"])){
			to_return = a + " andif " + b;
		}
		else if(member(lang,["tex"])){
			to_return = "(" + a + " \\land " + b + ")";
		}
		else if(member(lang,["visual basic","monkey x","visual basic .net","yacas"])){
			to_return = a + " And " + b;
		}
		else if(member(lang,["mathematical notation"])){
			to_return = a + "\u2227" + b;
		}
		else if(member(lang,["prolog","constraint handling rules","logtalk","pythological"])){
			to_return = a + "," + b;
		}
		else if(member(lang,["minizinc"])){
			to_return = a + "/\\" + b;
		}
		else if(member(lang,["reverse polish notation"])){
			to_return = a + " " + b+" and";
		}
		else if(member(lang,["pydatalog"])){
			to_return = a + " & " + b;
		}
		else if(member(lang,["fortran"])){
			to_return = a + " .and. " + b;
		}
		else if(member(lang,["cosmos","gams","alt-ergo","cython",'pl/sql',"vhdl","python","mysql","coconut","lua","seed7","livecode","englishscript","cython","gap","mathematical notation","genie","idp","maxima","engscript","ada","newlisp","ocaml","nim","coffeescript","pascal","delphi","erlang","rebol","php"])){
			to_return = a + " and " + b;
		}
		else if(member(lang,["common lisp","common prolog","smt-lib","clips","pddl","clojure","common lisp","emacs lisp","clojure","racket"])){
			return "(and "+a+" "+b+")";
		}
		else if(member(lang,["z3py"])){
			to_return = "And("+a+" "+b+")";
		}
		types[to_return] = "boolean";
	}
	else if(arr[0] === "*="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["javascript","pari/gp","glsl","sentient","english","glsl","chapel","nim","octave","coffeescript","cython","julia","kotlin","swift","typescript","go","php","ruby","haxe","java","c","c++","c#","perl","perl 6","visual basic .net","scala","python","coconut"])){
			to_return = a + "*=" + b;
		}
		else if(member(lang,["lua","fortran","mysql","ada","delphi","tcl","wolfram","rebol","ocaml","picat","maxima","r"])){
			return generate_code(input_lang,lang,indent,["set_var",a,["*",a,b]]);
		}
	}
	else if(arr[0] === "/="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			set_var_type(input_lang,lang,a,"double");
			same_var_type(a,b);
		}
		if(member(lang,["javascript","glsl","sentient","english","glsl","vala","chapel","nim","cython","julia","kotlin","scala","typescript","go","swift","java","c","c++","c#","perl","python","coconut","ruby","visual basic .net","php","coffeescript","haxe"])){
			to_return = a + "/=" + b;
		}
		else if(member(lang,["lua","fortran","ada","delphi","tcl","octave","wolfram","rebol","ocaml","picat","maxima","r"])){
			return generate_code(input_lang,lang,indent,["set_var",a,["/",a,b]]);
		}
	}
	else if(arr[0] === "+="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			same_var_type(a,b);
		}
		console.log(JSON.stringify(["types",a,types[a],b,types[b]]));
		if(member(lang,["javascript","gdscript","sentient","english","bash","python","coconut","haxe","awk","kotlin","visual basic .net","java","c++","c#","c","glsl","ruby","typescript"])){
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
		else if(member(lang,["lua","fortran","mysql","r","common lisp","wolfram","rebol","ocaml","picat","maxima","yacas","delphi","ada"])){
			//for languages that don't have the += operator
			return generate_code(input_lang,lang,indent,["set_var",a,["+",a,b]]);
		}
		else if(member(lang,["perl","php","hack"])){
			if(types[a] === "String" || types[b] === "String"){
				to_return =  a + ".=" + b;
			}
			else if(member(types[a],["int","double","long","float"])){
				to_return =  a + "+=" + b;
			}
		}
		else if(member(types[a],["int","double","long","float",])){
			if(member(lang,["janus","octave","chapel","julia","coffeescript","visual basic","visual basic .net","nim","cython","vala","perl 6","dart","typescript","java",'c',"c++","c#","javascript","haxe","chapel","perl","julia","scala","rust","go","swift"])){
				to_return = a + " += " + b;
			}
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java"],[".",["System","out",["function_call","print",["$a"]]]]],
		[["prolog","constraint handling rules"],["function_call","write",["$a"]]]
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
		//print without newline
		[["java"],[".",[[".",["System","out"]],["function_call","print",["$a"]]]]],
		[["prolog"],["function_call","write",["$a"]]],
		[["ruby","newlisp"],["function_call","print",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["c++"])){
			to_return = "cout << "+a;
		}
		else if(member(lang,["c"])){
			if(types[a] === "String"){
				to_return =  "printf(\"%s\","+a+")";
			}
			else if(types[a] === "double" || !isNaN(a)){
				to_return =  "printf(\"%f\","+a+")";
			}
			else if(types[a] === "int" || !isNaN(a)){
				to_return =  "printf(\"%d\","+a+")";
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
		//open a file
		//$a is the file name, $b is the variable name
		[["prolog"],["function_call","open",["$a","read","$b"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);

		if(member(lang,["c#"])){
			to_return = "StreamReader "+a+" = new StreamReader("+b+")";
		}
		else if(member(lang,["php","hack"])){
			to_return = b+" = open("+a+")"
		}
		else if(member(lang,["python"])){
			to_return = b+" = open("+a+", \"r\")";
		}
		else if(member(lang,["perl"])){
			to_return = "open "+b+", \"<\", "+a+" or die $!";
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
		//close a file
		[["prolog","perl"],["function_call","close",["$a"]]],
		[["php"],["function_call","fclose",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["c#"])){
			to_return =  a+".Close()";
		}
		else if(member(lang,["python"])){
			to_return =  a+".close()";
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
		//check if file exists
		[["lua","php"],["function_call","file_exists",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["c"])){
			to_return = "(access("+a+",F_OK ) != -1)";
		}
		else if(member(lang,["java"])){
			to_return = "new File("+a+").isFile()";
		}
		else if(member(lang,["perl"])){
			to_return = "-e "+a;
		}
		else if(member(lang,["python"])){
			to_return = "os.path.isFile("+a+")";
		}
		else if(member(lang,["ruby"])){
			to_return = "File.file?("+a+")";
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
		[["java","pseudocode"],[".",[[".",["System","out"]],["function_call","println",["$a"]]]]],
		[["c#","visual basic .net","pseudocode"],[".",[[".",["System","Console"]],["function_call","WriteLine",["$a"]]]]],
		[["javascript","typescript","coffeescript","pseudocode"],[".",["console",["function_call","log",["$a"]]]]],
		[["erlang","pseudocode"],[".",["io",["function_call","frwite",["$a"]]]]],
		[["go","pseudocode"],[".",["fmt",["function_call","Println",["$a"]]]]],
		[["cython","rebol","lua","ceylon","r","gosu","dart","vala","perl","php","hack","awk","pseudocode"],["function_call","print",["$a"]]],
		[["ruby","tcl","pseudocode"],["function_call","puts",["$a"]]],
		[["python","english","cython","coconut","haskell","common lisp","pseudocode"],["function_call","print",["$a"]]],
		[["prolog","seed7","pseudocode"],["function_call","writeln",["$a"]]],
		[["picolisp"],["function_call","prin",["$a"]]],
		[["scala","julia","swift","picat","kotlin","newlisp","hy","pseudocode"],["function_call","println",["$a"]]],
		[["haxe","pseudocode"],["function_call","trace",["$a"]]],
		[["octave","pseudocode"],["function_call","disp",["$a"]]],
		[["wolfram","pseudocode"],["function_call","Print",["$a"]]],
		[["yacas","pseudocode"],["function_call","Write",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["c++"])){
			to_return = "cout << "+a+"<< \"\\n\"";
		}
		else if(member(lang,["smalltalk"])){
			to_return = "Transcript print: "+a+"; nl";
		}
		else if(member(lang,["bash"])){
			to_return = "echo "+a;
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
		[["javascript"], [".",[[".",["Math","max"]],["function_call","apply",[[".",["Math"]],"$a"]]]]],
		[["javascript"],[".",[[".",["Math","apply"]],["function_call","max",[[".",["null"]],"$a"]]]]],
		[["python","mysql","cython","coconut","php","hack","fortran"],["function_call","max",["$a"]]],
		[["maxima"],["function_call","lmax",["$a"]]],
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
		[["javascript"], [".",[[".",["Math","max"]],["function_call","apply",[[".",["Math"]],"$a"]]]]],
		[["javascript"],[".",[[".",["Math","apply"]],["function_call","min",[[".",["null"]],"$a"]]]]],
		[["python","sql","coconut","cython","php","hack","fortran"],["function_call","min",["$a"]]],
		[["yacas","wolfram"],["function_call","Min",["$a"]]],
		[["lua"],[".",["math",["function_call","min",["$a"]]]]],
		[["c#"],[".",["$a",["function_call","Min",[]]]]],
		[["maxima"],["function_call","lmin",["$a"]]],
		[["ruby"],[".",["$a","min"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(arr[0] === "function_call"){
		var name = arr[1];
		if(name === function_name){
			is_recursive = true;
		}
		var params = function_call_parameters(input_lang,lang,name,arr[2]);
		to_return = function_call(lang,name,params);
		same_var_type(to_return,name);
	}
	else if(arr[0] === "grammar_output"){
		if(params === ""){
			return params;
		}
		arr[1] = generate_code(input_lang,lang,indent,arr[1]);
		arr[2] = arr[2].map(function(x){return generate_code(input_lang,lang,"",x)});
		if(member(lang,["jison"])){
			to_return = arr[1]+"{$$ = ["+arr[2]+"];}";
		}
		else if(member(lang,["peg.js"])){
			to_return = arr[1]+"{return ["+arr[2]+"];}";
		}
		else if(member(lang,["nearley"])){
			to_return = arr[1]+"{%function(d){return ["+arr[2]+"];}%}";
		}
	}
	else if(arr[0] === "grammar_index"){
		if(member(lang,["jison"])){
			to_return = "$"+arr[1];
		}
		else if(member(lang,["nearley"])){
			to_return = "d["+arr[1]+"]";
		}
	}
	else if(arr[0] === "-="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			set_var_type(input_lang,lang,a,"double");
			same_var_type(a,b);
		}
		if(member(lang,["javascript","pari/gp","glsl","sentient","english","glsl","vala","chapel","nim","coffeescript","dart","cython","awk","go","julia","kotlins","haxe","typescript","swift","picat","php","ruby","java","c","c++","c#","perl","python","coconut","scala","visual basic .net"])){
			to_return = a + "-=" + b;
		}
		else if(member(lang,["lua","common lisp","ada","delphi","tcl","octave","maxima","wolfram","rebol","ocaml","picat","r","yacas"])){
			return generate_code(input_lang,lang,indent,["set_var",a,["-",a,b]]);
		}
	}
	else if(arr[0] === "%="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			set_var_type(input_lang,lang,a,"double");
			same_var_type(a,b);
		}
		if(member(lang,["java","c","php","hack","perl","c++","javascript","c#"])){
			to_return = a + "%=" + b;
		}
	}
	else if(arr[0] === "&="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			set_var_type(input_lang,lang,a,"boolean");
			same_var_type(a,b);
		}
		if(member(lang,["c","c++","java","ruby","perl","php","hack","haxe","javascript"])){
			to_return = a + "&=" + b;
		}
	}
	else if(arr[0] === "|="){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		var b = generate_code(input_lang,lang,indent,arr[2]);
		if(member(lang,["c","c++","java","ruby","perl","php","hack","haxe","javascript"])){
			to_return = a + "|=" + b;
		}
	}
	else if(arr[0] === "import" && arr.length === 2){
		to_return = inputs_to_outputs(lang,{name:arr[1]},[
			[['c'],
				"#include \"name.h\""],
			[["prolog"],
				":-use_module(name)"],
			[["php"],
				"require_once('name.php')"],
			[["lua","ruby"],
				"require \"name\""],
			[["java","julia","python","coconut",'d',"haxe","ceylon","haskell","purescript","scala","go","groovy","picat","elm","swift","monkey x"],
		"		import name"],
			[["seed7"],
				"include \"name.s7i\""],
			[["thrift"],
				"include \"name.thrift\""],
			[["protobuf"],
				"import \"name.proto\""]
		]);
	}
	else if(arr[0] === "import_from" && arr.length === 3){
		to_return = inputs_to_outputs(lang,{the_function:arr[1],the_file:arr[2]},[
			[["javascript"],
				'import the_function from the_file'],
			[["python"],
				'from the_file import the_function'],
			[["c#"],
				"using static the_file.the_function"],
			[["java"],
				"import the_file.the_function"]
		]);
	}
	else if(arr[0] === "++" && arr.length === 2){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			set_var_type(input_lang,lang,a,"double");
		}
		if(member(lang,["javascript","inform 6","octave","glsl","gosu","yacas","typescript","php","kotlin","dart","java","c","c++","c#","perl","perl 6","haxe","go","wolfram"])){
			to_return = a + "++";
		}
		else if(member(lang,["tcl"])){
			to_return = "incr " + a.substring(1);
		}
		else if(member(lang,["seed7"])){
			to_return = "incr(" + a + ")";
		}
		else if(member(lang,["common lisp"])){
			to_return = "(incf " + a+")";
		}
		else if(member(lang,["python","coconut","julia","ruby","swift","lua","visual basic .net","ruby","scala"])){
			to_return = a + " += 1";
		}
		else if(member(lang,["lua","mysql","r","maxima","wolfram","rebol","ocaml","picat"])){
			//for languages that don't have the incrmement operator
			to_return = generate_code(input_lang,lang,indent,["set_var",a,["+",a,"1"]]);
		}
	}
	else if(arr[0] === "--"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			set_var_type(input_lang,lang,a,"double");
		}
		
		if(member(lang,["javascript","glsl","perl 6","vala","gosu","octave","coffeescript","yacas","typescript","php","kotlin","haxe","scala","java","c","c++","c#","perl","go"])){
			to_return = a + "--";
		}
		else if(member(lang,["tcl"])){
			to_return = "incr " + a.substring(1) + " -1";
		}
		else if(member(lang,["common lisp"])){
			to_return = "(decf " + a + ")";
		}
		else if(member(lang,["python","coconut","cython","julia","ruby","swift","lua","visual basic .net","ruby","scala","chapel"])){
			to_return = a + "-= 1";
		}
		else if(member(lang,["lua","r","maxima","wolfram","rebol","ocaml","picat"])){
			//for languages that don't have a -- or -= operator
			to_return = generate_code(input_lang,lang,indent,["set_var",a,["-",a,"1"]]);
		}
	}
	else if(arr[0] === "yield"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,["c#"])){
			to_return = "yield return " + a;
		}
		else if(member(lang,["ruby","python","cython","coconut","javascript","scala","php"])){
			to_return = "yield " + a;
		}
		else if(member(lang,["haskell"])){
			to_return = a;
		}
		//console.log(to_return);
	}
	else if(arr[0] === "throw"){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,	["javascript","dart","java","c++","swift","rebol","haxe","c#","picat","scala"])){
			to_return = "throw " + a;
		}
		else if(member(lang,["julia","r"])){
			to_return = "throw("+a+")";
		}
		else if(member(lang,["php"])){
			to_return = "throw  new Exception("+a+")";
		}
		else if(member(lang,["python","cython","coconut","ruby"])){
			to_return = "raise "+a;
		}
		else if(member(lang,["standard ml"])){
			to_return = "raise Fail "+a;
		}
		else if(member(lang,["perl","sidef"])){
			to_return = "die "+a;
		}
		//console.log(to_return);
	}
	else if(arr[0] === "return" && arr.length === 2){
		var a = generate_code(input_lang,lang,indent,arr[1]);
		if(member(lang,	["pseudocode","gdscript","sentient","scriptol","setl","gnu setl","inform 6","picolisp","english","matlab","glsl","applescript","sidef","reasoned-php","logicjs","coconut","ats","cython","kotlin","coffeescript","systemverilog","vhdl","lua","ruby","java","seed7",'xl','e',"livecode","englishscript","gap","kal","engscript","pawn","ada","powershell","rust",'d',"ceylon","typescript","hack","autohotkey","gosu","swift","pike","objective-c",'c',"groovy","scala","julia","dart","c#","javascript","go","haxe","php","c++","perl","vala","rebol","awk","bc","chapel","perl 6","python"])){
			to_return = "return " + a;
		}
		else if(member(lang,["r","maxima","pari/gp"])){
			to_return = "return("+a+")";
		}
		else if(member(lang,["transact-sql","mysql"])){
			to_return = "RETURN "+a;
		}
		else if(member(lang,["tcl"])){
			to_return = "return [expr {"+a+"}]";
		}
		//else if(member(lang,["wolfram"])){
		//	to_return = "Return["+a+"]";
		//}
		else if(member(lang,["pseudocode","visual basic","visual basic .net","autoit","monkey x"])){
			to_return = "Return " + a;
		}
		else if(member(lang,["octave"])){
			if(retval === "undefined"){
				to_return = "retval = " + a;
			}
			else{
				to_return = retval + " = " + a;
			}
		}
		else if(member(lang,["fortran"])){
			to_return = function_name + " = " + a;
		}
		else if(member(lang,["pascal"])){
			to_return = function_name + " := " + a;
		}
		else if(member(lang,["smt-lib"])){
			to_return = "(= "+function_name + " " + a+")";
		}
		else if(member(lang,["picat"])){
			to_return = "Return = " + a;
		}
		else if(member(lang,["delphi"])){
			to_return = "Result := " + a;
		}
		else if(member(lang,["nim"])){
			to_return = "result = " + a;
		}
		else if(member(lang,["prolog","dafny","alt-ergo", "sage", "coffeequate", "pythological", "smalltalk", "pddl", "mercury", "idris", "coq", "lc++", "chr.js", "constraint handling rules", "yacas", "wolfram", "elixir", "elm", "sympy", "haskell","z3py","flix","agda","scheme","minizinc","logtalk","pydatalog","polish notation","reverse polish notation","mathematical notation","emacs lisp","erlang","standard ml","icon","oz","clips","newlisp","hy","sibilant","lispyscript","algol 68","clojure","common lisp","f#","ocaml","ml","racket","nemerle"])){
			to_return = a;
		}
		if(is_dynamically_typed(input_lang) && is_statically_typed(lang)){
			types[function_name] = types[a];
		}
		//console.log(to_return);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//convert one character to uppercase
		[["java"],[".",["Character",["function_call","toUpperCase",["$a"]]]]],
		[["c#"],[".",["Char",["function_call","ToUpper",["$a"]]]]],
		[['c',"c++"],["function_call","toupper",["$a"]]],
		[["haskell"],["function_call","ToUpper",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "String";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//convert one character to lowercase
		[["java"],[".",["Character",["function_call","toLowerCase",["$a"]]]]],
		[['c',"c++"],["function_call","tolower",["$a"]]],
		[["haskell"],["function_call","ToLower",["$a"]]],
		[["c#"],[".",["Char",["function_call","ToLower",["$a"]]]]],
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "char";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["php"],["function_call","md5",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "char";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//array lengths
		[["java","picat","scala",'d',"typescript","dart","vala","javascript","coffeescript","haxe","cobra","ruby"],[".",["$a","length"]]],
		[["python","cython","coconut"],["function_call","len",["$a"]]],
		[["haskell","emacs lisp","scheme","racket","minizinc","julia","r","octave","seed7","glsl"],["function_call","length",["$a"]]],
		[["php","hack"],["function_call","sizeof",["$a"]]],
		[["common lisp"],["function_call","list-length",["$a"]]],
		[["perl"],["function_call","scalar",["$a"]]],
		[["wolfram"],["function_call","Length",["$a"]]],
		[["clojure"],["function_call","count",["$a"]]]
	],matching_symbols)){
		var text = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["java","picat","scala",'d',"typescript","dart","vala","javascript","haxe","cobra","ruby"])){
			to_return = text + ".length";
		}
		else if(member(lang,["c#"])){
			to_return = text + ".Length";
		}
		else if(member(lang,["python","cython","coconut"])){
			to_return = "len(" + text + ")";
		}
		else if(member(lang,["lua"])){
			to_return = "#(" + text + ")";
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
			else if(member(lang,["python","cython","coconut"])){
				to_return = "len("+a+")";
			}
		}
		types[to_return]="int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//string length
		[["java","c++","kotlin"],[".",["$a",["function_call","length",[]]]]],
		[["lua"],[".",["string",["function_call","len",["$a"]]]]],
		[["python","cython","coconut","fortran"],["function_call","len",["$a"]]],
		[["gambas","visual basic .net"],["function_call","Len",["$a"]]],
		[["wolfram"],["StringLength",["$a"]]],
		[["javascript","coffeescript","typescript","scala","gosu","picat","haxe","ocaml",'d',"dart","ruby"],[".",["$a","length"]]],
		[["c#","nemerle"],[".",["$a","Length"]]],
		[["racket","scheme"],["string-length",["$a"]]],
		[["minizinc","julia","perl","seed7","octave","common lisp","haskell","coq"],["function_call","length",["$a"]]],
		[["php",'c',"pawn","hack"],["function_call","strlen",["$a"]]],
		[["autohotkey"],["function_call","StrLen",["$a"]]],
		[["swift"],["function_call","countElements",["$a"]]],
		[["rebol"],["function_call","length?",["$a"]]],
		[["yacas"],["function_call","Length",["$a"]]],
		[["erlang"],["function_call","string:length",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int"
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//substring of a from b to c
		[["javascript","coffeescript","typescript","java","scala","dart"],[".",["$a",["function_call","substring",["$b","$c"]]]]],
		[["c#","nemerle"],[".",["$a",["function_call","Substring",["$b","$c"]]]]],
		[["erlang"],[".",["string",["function_call","sub_string",["$a","$b","$c"]]]]],
		[["haxe","perl 6"],[".",["$a",["function_call","substr",["$b","$c"]]]]],
		[["php","awk","perl","hack"],["function_call","substr",["$a","$b","$c"]]],
		[["clojure"],["function_call","subs",["$a","$b","$c"]]],
		[["racket"],["function_call","substring",["$a","$b","$c"]]],
		[["lua"],["function_call","sub",["$a","$b","$c"]]],
		[["common lisp"],["function_call","subseq",["$a","$b","$c"]]]
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
		[["javascript","haxe","coffeescript","typescript",],[".",["$a",["function_call","slice",["$b","$c"]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		if(member(lang,["python","cython","coconut","cobra","go"])){
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
			return arr[2].map(function(x){types[x] = arr[1]; return var_type(input_lang,lang,arr[1])+"("+var_name(lang,input_lang,x)}).join(",")+")";
		}
		else{
			arr[2] = arr[2].map(function(x){types[x] = arr[1]; return var_name(lang,input_lang,x)}).join(",");
		}
		if(member(lang, ["java"])){
			to_return = "final " + var_type(input_lang,lang,arr[1]) + " " + arr[2];
		}
		else if(member(lang, ["c","c++","c#","glsl"])){
			to_return = "const " + var_type(input_lang,lang,arr[1]) + " " + arr[2];
		}
	}
	else if(arr[0] === "struct_statement"){
		if(member(lang, ["c","c++","glsl","hlsl","haskell","swift"])){
			to_return = indent + semicolon(lang,generate_code(input_lang,lang,indent,["initialize_empty_vars",arr[1],arr[2]]));
		}
		else if(member(lang, ["stone"])){
			to_return = indent + arr[2]+" "+var_type(input_lang,lang,arr[1]);
		}
		else if(member(lang, ["erlang"])){
			//for Erlang records
			to_return = indent + arr[2];
		}
		else if(member(lang, ["java"])){
			to_return = indent + "public " + semicolon(lang,generate_code(input_lang,lang,indent,["initialize_empty_vars",arr[1],arr[2]]));
		}
		else if(member(lang, ["fortran","mysql"])){
			to_return = indent+var_type(input_lang,lang,arr[1]) + " " + arr[2];
		}
	}
	else if(arr[0] === "initialize_struct_"){
		if(member(lang,["c"])){
			return "." + arr[1] + " = " + generate_code(input_lang,lang,indent,arr[2]);
		}
		else if(member(lang,["haskell","erlang"])){
			return arr[1] + " = " + generate_code(input_lang,lang,indent,arr[2]);
		}
		else if(member(lang,["swift"])){
			return arr[1] + ":" + generate_code(input_lang,lang,indent,arr[2]);
		}
	}
	else if(arr[0] === "initialize_empty_vars"){
		if(lang === "prolog"){
			return arr[2].map(function(x){types[x] = arr[1]; return var_type(input_lang,lang,arr[1])+"("+var_name(lang,input_lang,x)+")"}).join(",");
		}
		else if(lang === "smt-lib"){
			return arr[2].map(function(x){types[x] = arr[1]; return "(declare-const " + var_name(lang,input_lang,x) + " " + var_type(input_lang,lang,arr[1]) + ")"}).join("\n");
		}
		else if(lang === "haskell"){
			return arr[2].map(function(x){types[x] = arr[1]; return var_name(lang,input_lang,x) + "::" + var_type(input_lang,lang,arr[1])}).join("\n");
		}
		else if(lang === "php"){
			return arr[2].map(function(x){types[x] = arr[1]; return var_name(lang,input_lang,x)}).join(" = null;"+indent)+"= null;";
		}
		else if(member(lang,["smalltalk","gnu smalltalk"])){
			arr[2] = arr[2].map(function(x){
				types[x] = arr[1];
				return var_name(lang,input_lang,x)
			}).join(" ");
		}
		else{
			arr[2] = arr[2].map(function(x){
				set_var_type(input_lang,lang,x,arr[1]);
				return var_name(lang,input_lang,x);
			}).join(",");
		}
		
		if(member(lang, ["java","sentient","c","glsl","c++","c#","algol 68","simula"])){
			to_return = var_type(input_lang,lang,arr[1]) + " " + arr[2];
		}
		else if(member(lang, ["sage"])){
			to_return = "var('" + arr[2]+"')";
		}
		else if(member(lang, ["pari/gp"])){
			to_return = "my(" + arr[2]+")";
		}
		else if(member(lang, ["sympy"])){
			to_return = arr[2] + " = symbols('" + arr[2]+"')";
		}
		else if(member(lang, ["z3py"])){
			to_return = arr[2] + "=" + var_type(input_lang,"smt-lib",arr[1]) + "s(" + arr[2].split(",").join(" ") + ")";
		}
		else if(member(lang, ["minizinc"])){
			to_return = var_type(input_lang,lang,arr[1])+":"+arr[2];
		}
		else if(member(lang, ["haxe","typescript","scala","swift"])){
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
		else if(member(lang, ["fortran"])){
			to_return = arr[2]+" :: "+var_type(input_lang,lang,arr[1]);
		}
		else if(member(lang, ["go"])){
			to_return = "var "+arr[2]+" "+var_type(input_lang,lang,arr[1]);
		}
		else if(member(lang, ["transact-sql","sql"])){
			to_return = arr[2]+" "+var_type(input_lang,lang,arr[1]);
		}
		else if(member(lang, ["mysql"])){
			//for local variables
			to_return = "DECLARE " + arr[2]+" "+var_type(input_lang,lang,arr[1]);
		}
		else if(member(lang, ["javascript","ampl"])){
			to_return = "var " + arr[2];
		}
		else if(member(lang, ["perl"])){
			to_return = "my " + arr[2];
		}
		else if(member(lang, ["lua","bash","gap"])){
			to_return = "local " + arr[2];
		}
		else if(member(lang, ["smalltalk"])){
			to_return = "| " + arr[2] + " |";
		}
		else if(member(lang, ["python","cython","coconut"])){
			to_return = "";
		}
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
			[["c","tcl","glsl","hlsl","php","hack","d","fortran"],["function_call","log10",["$a"]]],
			[["gap"],["function_call","log10",["$a"]]],
			[["c#"],[".",["Math",["function_call","Log10",["$a"]]]]],
			[["java","javascript"],[".",["Math",["function_call","log10",["$a"]]]]],
			[["lua","python","cython","coconut","erlang"],[".",["math",["function_call","log10",["$a"]]]]]
		],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
			[["c","c++"],["function_call","log2",["$a"]]],
			[["gap"],["function_call","Log2",["$a"]]]
		],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
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
		[["java"],["new",["HashMap",["$a","$b"]],[]]]
	],matching_symbols)){
		var a = matching_symbols["$a"];
		var b = matching_symbols["$b"];
		return generate_code(input_lang,lang,indent,["associative_array",a,b,[]]);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//determinant of matrix
		[["wolfram"],["function_call","Det",["$a"]]],
		[["maxima","glsl","hlsl"],["function_call","determinant",["$a"]]],
		[["symja","algebrite"],["function_call","det",["$a"]]],
		[["pari/gp"],["function_call","matdet",["$a"]]],
		[["sympy"],[".",["$a",["function_call","det",[]]]]],
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "double";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//inverse of a matrix
		[["maxima"],["function_call","invert",["$a"]]],
		[["symja","glsl",'octave'],["function_call","inverse",["$a"]]],
		[["algebrite"],["function_call","inv",["$a"]]],
		[["sympy"],["**","$a","-1"]],
		[["symbolicc++"],[".",["$a",["function_call","inverse",[]]]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = types[a];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//inner product
		[["maxima"],["function_call","innerproduct",["$a"]]],
		[["maxima"],["function_call","inprod",["$a"]]],
		[["wolfram"],["function_call","Inner",["$a"]]],
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = types[a];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["maxima","fortran","glsl","transpose"], ["function_call","transpose",["$a"]]],
		[["wolfram"], ["function_call","Transpose",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = types[a];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["glsl"], ["function_call","normalize",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = types[a];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["sympy","maxima"], ["function_call","limit",["$a","$b","$c"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		if(lang === "wolfram"){
			to_return = "Limit["+a+","+b+"->"+c+"]"
		}
		else if(lang === "sage"){
			to_return = "limit("+a+","+b+"="+c+")"
		}
		else if(lang === "yacas"){
			to_return = "(limit("+b+","+c+") "+a+")"
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = types[a];
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["maxima"], ["function_call","Eigenvalues",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = types[a];
	}
	// see http://rosettacode.org/wiki/Real_constants_and_functions
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","javascript","coffeescript","typescript","haxe"],[".",["Math",["function_call","abs",["$a"]]]]],
		[["c#","f#"],[".",["Math",["function_call","Abs",["$a"]]]]],
		[["lua"],[".",["math",["function_call","abs",["$a"]]]]],
		[["vala"],[".",["$a",["function_call","abs",[]]]]],
		[["go","wolfram","yacas"],["function_call","Abs",["$a"]]],
		[["ruby","perl 6"],[".",["$a","abs"]]],
		[['c',"asciimath","opl","english","hlsl","symja","maxima","standard ml","octave","haskell","common lisp","reverse polish notation","rebol","c++","julia","tcl","perl","php","python","cython","coconut","erlang","prolog","swift","frink"],["function_call","abs",["$a"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		if(member(lang,["mathematical notation"])){
			to_return = "|"+output+"|";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript","coffeescript","typescript","java","haxe"],[".",["$a",["function_call","filter",["$b"]]]]],
		[["haskell","python","cython","coconut"],["function_call","filter",["$b","$a"]]],
		[["php","hack"],["function_call","array_filter",["$a","$b"]]],
	],matching_symbols)){
		var arr = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var callback = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		//types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["javascript","coffeescript","java","haxe"],[".",["$a",["function_call","map",["$b"]]]]],
		[["c#"],[".",["$a",["function_call","Select",["$b"]]]]],
		[["php","hack"],["function_call","array_map",["$b","$a"]]],
		[["haskell","python","cython","coconut","perl","julia"],["function_call","map",["$b","$a"]]],
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
		[["php","hack"],["function_call","array_reduce",["$b","$a"]]],
		[["python","coconut"],["function_call","reduce",["$b","$a"]]],
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
		// pick random from array
		// See here: https://rosettacode.org/wiki/Pick_random_element
		[["ruby"],[".",["$a","sample"]]],
		[["php"],["function_call","array_rand",["$a"]]],
		[["python","coconut"],[".",["random",["function_call","sample",["$a"]]]]],
		[["julia"],["function_call","rand",["$a"]]],
		[["wolfram"],["function_call","RandomChoice",["$a"]]],
		[["r"],["function_call","sample",["$a","1"]]],
		[["falcon"],["function_call","randomPick",["$a","1"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		member(lang,["javascript","coffeescript","typescript"]) && (to_return = a + "[Math.floor(Math.random() * " + a + ".length)]")
		|| lang === "erlang" && (to_return = "lists:nth(random:uniform(length("+a+")),"+a+")")
		|| lang === "lua" && (to_return = a + "[math.random(#"+a+")]")
		|| (to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols));
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["java","javascript","coffeescript","typescript","haxe"],[".",["Math",["function_call","round",["$a"]]]]],
		[["c#","visual basic .net"],[".",["Math",["function_call","Round",["$a"]]]]],
		[["yacas","gap"],["function_call","Round",["$a"]]],
		[["prolog","mediawiki","standard ml","reverse polish notation","julia","tcl","minizinc","php","c","c++","perl","haskell","python","coconut","octave","yacas","rebol","frink"],["function_call","round",["$a"]]],
		[["ruby","perl 6"],[".",["$a","round"]]]
	],matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["wolfram"],
			["function_call","LaplaceTransform",["$a","$b","$c"]]],
		[["maxima"],
			["function_call","laplace",["$a","$b","$c"]]],
		[["sympy"],
			["function_call","laplace_transform",["$a","$b","$c"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["sympy"],
			["function_call","fourier_transform",["$a","$b","$c"]]],
		[["wolfram"],
			["function_call","FourierTransform",["$a","$b","$c"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["sympy"],
			["function_call","InverseFunction",["$a"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//solve a differential equation
		[["maple","matlab","sympy"],
			["function_call","dsolve",["$a"]]],
		[["wolfram"],
			["function_call","DSolve",["$a","$b","$c"]]],
		[["maxima"],
			["function_call","desolve",["$a","$b"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//solve an algebraic equation
		//$a is the equation, $b is the list of variables
		[["wolfram","maxima","sympy","sage"],
			["function_call","solve",["$a","$b"]]]
	],matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		//cartesian product
		[["wolfram"],
			["function_call","CartesianProduct",["$a","$b"]]],
		[["racket"],
			["function_call","cartesian_product",["$a","$b"]]],
		[["python"],
			[".",["itertools",["function_call","product",["$a","$b"]]]]],
		[["ruby"],
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
		[["maxima"],
		["function_call","integrate",["$a","$b","$c","$d"]]],
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		var c = generate_code(input_lang,lang,indent,matching_symbols["$c"]);
		var d = generate_code(input_lang,lang,indent,matching_symbols["$d"]);
		if(lang === "sympy"){
			to_return = "integrate(" + a + ", (" + b +","+ c +","+ d + "))";
		}
		else if(lang === "sage"){
			to_return = "integral(" + a + "," + b +","+ c +","+ d + ")";
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
		[["maple"],
			["function_call","CrossProduct",["$a","$b"]]],
		[["wolfram"],
			["function_call","Cross",["$a","$b"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["maple"],
			["function_call","DotProduct",["$a","$b"]]],
		[["glsl"],
			["function_call","dot",["$a","$b"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		var b = generate_code(input_lang,lang,indent,matching_symbols["$b"]);
		if(member(lang,["sympy"])){
			return a + ".cross("+b+")";
		}
		else{
			to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		}
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["wolfram","sympy"],
			["function_call","TensorProduct",["$a","$b"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["wolfram"],
			["function_call","KroneckerProduct",["$a","$b"]]],
		[["matlab"],
			["function_call","kron",["$a","$b"]]]
	],matching_symbols)){
		var a = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		same_var_type(to_return,a);
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["wolfram"],
			["function_call","Variance",["$a"]]],
		[["r"],
			["function_call","var",["$a"]]]
		]
	,matching_symbols)){
		var output = generate_code(input_lang,lang,indent,matching_symbols["$a"]);
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(matching_patterns(pattern_array,input_lang,lang,arr,[
		[["wolfram"],
			["function_call","StandardDeviation",["$a"]]],
		[["r"],
			["function_call","sd",["$a"]]]
		]
	,matching_symbols)){
		to_return = unparse(input_lang,lang,indent,pattern_array.value,matching_symbols);
		types[to_return] = "int";
	}
	else if(member(arr[0],["statements"])){
		return statements(input_lang,lang,indent,arr);
	}
	else if(member(arr[0],["struct_statements"])){
		var a = arr[1].map(function(a){
			return generate_code(input_lang,lang,indent,a);
		});
		if(member(lang,["mysql","sql","thrift","erlang"])){
			return a.join(",");
		}
		else{
			return a.join("");
		}
	}
	else if(arr[0] === "class_statements"){
		//console.log("class statements: " + JSON.stringify(arr));
		if(member(lang,["sql","transact-sql"])){
			return arr[1].map(function(a){
				return generate_code(input_lang,lang,indent,a);
			}).join(",");
		}
		else{
			return arr[1].map(function(a){
				return generate_code(input_lang,lang,indent,a);
			}).join("");
		}
	}
	else if(arr[0] === "top_level_statements"){
		if(member(lang,["picat","erlang","coq","english","prolog","pythological","constraint handling rules","logtalk","erlang","mercury"])){
			var a = arr[1].map(function(a1){
				return generate_code(input_lang,lang,indent,a1);
			});
			return a.join(". ")+".";
		}
		else if(member(lang,["english"])){
			var a = arr[1].map(function(a1){
				return generate_code(input_lang,lang,indent,a1);
			});
			return a.join(".\n")+".";
		}
		else if(member(lang,["tex"])){
			var a = arr[1].map(function(a1){
				return generate_code(input_lang,lang,indent,a1);
			});
			return a.join(" \\newline ");
		}
		if(member(lang,["minizinc","maxima","ocaml","mysql"])){
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
		if(!member(input_lang,["php","r","standard ml","pseudocode","perl","common lisp","julia","octave","newlisp","hy","regex","txl","erlang","prolog","pddl","mathematical notation","reverse polish notation","wolfram","english","ruby","haskell","constraint handling rules","clips","prolog","lua","javascript","jison"]) && types[to_return] == undefined && !is_a_statement(arr[0])){
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
	return is_semicolon_statement(the_statement) || member(the_statement,["overload_operator","lexically_scoped_vars","lexically_scoped_var","protobuf_service","enum",'initialize_constant',"interface_static_method","generic_function","generic_instance_method","generic_static_method","do_while","struct","interface","unless","default","case","switch","async_function","named_parameter","static_overload_operator","instance_overload_operator","class_extends","interface_extends","constructor","defrule","grammar_macro","predicate","grammar_statement","foreach_with_index","function","else","else if","elif","if","if_statement","instance_method","static_method","class","while","for","foreach"]);
}

function is_semicolon_statement(the_statement){
	return member(the_statement,["initialize_var","protobuf_parameter","interface_static_method","generic_class","generic_interface","struct_statement","initialize_empty_constants","yield","initialize_static_instance_var","initialize_instance_var","initialize_instance_var_with_value","initialize_static_instance_var_with_value","++","--","+=","-=","*=","/=","return","set_var","set_array_size","initialize_empty_constants","throw","continue","break","import","initialize_empty_vars","return"])
}

function parse_lang(input_lang,output_lang,input_text){
	//translate code from one language to another
	input_lang = input_lang.trim().toLowerCase();
	output_lang = output_lang.trim().toLowerCase();
	var to_return;
	if(member(input_lang,["detect language",""])){
		for(var lang of Object.keys(parsers)){
			try{
				to_return = parse_lang_(lang,output_lang,input_text)
			}
			catch(e){
				console.log(e);console.log("The language isn't "+lang);
			}
		}
	}
	else{
		to_return = parse_lang_(input_lang,output_lang,input_text);
	}
	return to_return;
}

function parse_lang_(input_lang,output_lang,input_text){
	var parsed_text;
	input_lang = get_lang(input_lang);
	if(parsers.hasOwnProperty(input_lang)){
		if(input_lang === "english"){
			parsed_text = understand_text(input_text);
		}
		else{
			parsed_text = parsers[input_lang].parse(input_text);
		}
	}
	else{
		throw "Input language \""+input_lang+"\" not recognized";
	}
	
	//clear var types before generating code
	Object.keys(types).forEach(function (prop) {
		delete types[prop];
	});
	
	Object.keys(function_params).forEach(function (prop) {
		delete function_params[prop];
	});
	
	var generated_code = generate_code(input_lang,output_lang,"\n",parsed_text);
	
	return generated_code;
}

function type_conversion(input_lang,lang,type1, type2, expr){
		var to_return;
		
		if(type1 === type2){
			return expr;
		}
		
		if(member(lang,["python","coconut","swift"])){
			to_return = var_type(input_lang,lang,type2) +"("+expr+")";
		}
		if(member(lang,["mysql","transact-sql"])){
			to_return = "CAST("+expr+" as "+var_type(input_lang,lang,type2)+")";
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
		else if(member(lang,["php","hack"])){
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
	if(member(lang,["go","autohotkey"])){
		return "for " + arr1 + "{" + arr2 + indent+ "}";
	}
	else if(member(lang,["applescript"])){
		return "repeat while " + arr1 + arr2 + indent+ "end repeat";
	}
	else if(member(lang,["english"])){
		return "while(" + arr1 + "){" + arr2 + indent+ "}.";
	}
	else if(member(lang,["smalltalk"])){
		return "[" + arr1 + "] whileTrue: [" + arr2 + indent +"].";
	}
	else if(member(lang,["algol 68"])){
		return "while " + arr1 + " do" + arr2 + indent+ "od";
	}
	else if(member(lang,["ada"])){
		return "while " + arr1 + " loop " + arr2 + indent+ "end loop;";
	}
	else if(member(lang,["fortran"])){
		return "while " + arr1 + " do " + arr2 + indent+ "enddo";
	}
	else if(member(lang,["tcl"])){
		return "while{" + arr1 + "}{" + arr2 + indent + "}";
	}
	else if(member(lang,["rust","frink","dafny"])){
		return "for " + arr1 + "{" + arr2 + indent+ "}";
	}
	else if(member(lang,["yacas"])){
		return "While (" + a + ") [" + b + indent +"];";
	}
	else if(member(lang,["rebol"])){
			return "while[" + arr1 + "] [" + arr2 + indent+ "]";
	}
	else if(member(lang,["python","gdscript","coconut","cython","nim"])){
		return "while " + arr1 + ":" + arr2;
	}
	else if(member(lang,["coffeescript"])){
		return "while " + arr1 + arr2;
	}
	else if(member(lang,["visual basic","visual basic .net","vbscript"])){
		return "While " + arr1 + arr2 + indent + "End While";
	}
	else if(member(lang,["mysql"])){
		return "WHILE " + arr1 +" DO "+ arr2 + indent + "END WHILE";
	}
	else if(member(lang,["seed7"])){
		return "while " + arr1 +" do "+ arr2 + indent + "end while;";
	}
	else if(member(lang,["transact-sql"])){
		return "WHILE " + arr1 + " BEGIN " + arr2 + indent + "END;";
	}
	else if(member(lang,["wolfram"])){
		return "While[" + arr1 +","+ arr2 + indent + "]";
	}
	else if(member(lang,["yacas"])){
		return "While(" + arr1 +") ["+ arr2 + indent + "]";
	}
	return inputs_to_outputs(lang,{arr1:arr1,arr2:arr2," indent ":indent},[
		[['c',"glsl","typescript","perl 6","katahdin","chapel","ooc","processing","pike","kotlin","pawn","powershell","hack","gosu","autohotkey","ceylon",'d',"typescript","actionscript","nemerle","dart","swift","groovy","scala","java","javascript","php","c#","perl","c++","haxe","r","awk","vala"],
			"while(arr1){arr2 indent }"],
		[["julia","picat"],
			"while arr1 arr2 indent end"],
		[["ocaml"],
			"while arr1 do arr2 indent done"],
		[["gap"],
			"while arr1 do arr2 indent od;"],
		[["delphi","lua","ruby"],
			"while arr1 do arr2 indent end"],
		[["octave"],
			"while(arr1)arr2 indent endwhile"],
		[["wolfram"],
			"While[arr1,arr2, indent ]"],
		["maxima"],
			"while arr1 do (arr2 indent )"
		["coffeescript"],
			"while arr1arr2"
	]);
}

function substring_(lang,a,b,c){
		if(member(lang,["c#","nemerle"])){
			return a+".Substring("+b+","+c+"-"+b+"+1)";
		}
		else if(member(lang,["perl"])){
			return "substr("+a+","+b+","+c+"-"+b+"+1)";
		}
		else if(member(lang,["lua"])){
			return a+".sub("+b+"+1,"+c+"+1)";
		}
		else if(member(lang,["pike","groovy","nim"])){
			return a+"["+b+".."+c+"]";
		}
		else{
		return inputs_to_outputs(lang,{a1:a,b1:b,c1:c},[
			[["javascript","coffeescript","typescript","java","scala","dart"],
				"a1.substring(b1,c1)"],
			[["haxe"],	
				"a1.substr(b1,c1)"],
			[["python","coconut","cython","icon","go"],
				"a1[b1:c1]"]
		]);
		}
}

function array_contains(lang,a1,a2){
		//$a1 is the list, $a2 is in the list
		if(member(lang,["c++"])){
			return ["(",ws,"std",ws,"::",ws,"find",ws,"(",ws,"Std",ws,"(",ws,a1,ws,")",ws,",",ws,"std",ws,"::",ws,"end",ws,"(",ws,a1,ws,")",ws,",",ws,a2,ws,")",ws,"!=",ws,"std",ws,"::",ws,"end",ws,"(",ws,a1,ws,")",ws,")"].join("");
		}
		else{
			return inputs_to_outputs(lang,{a1:a1,a2:a2},[
				[["php"],"in_array(a1,a2)"],
				[["ruby"],"a1.include?(a2)"],
				[["java","swift"],"a1.contains(a2)"],
				[["scala"],"(a1 contains a2)"],
				[["ocaml"],"(List.mem a2 a1)"],
				[["haxe"],"Lambda.has(a1,a2)"],
				[["perl"],"(a1 ~~ a2)"],
				[["python","coconut","julia","minizinc","mysql"],"(a2 in a1)"],
				[["coq"],"(In a1 a2)"],
				[["haskell"],"(elem a1 a2)"],
				[["wolfram"],"MemberQ[a1,a2]"],
				[["lua"],"a1[a2] !== nil"],
				[["c#"],"(Array.indexOf(a1,a2) > -1)"],
				[["rebol"],"not none? find a1 a2"],
				[["reasoned-php"],"membero(a2,a1)"],
				[["erlang"],"lists:member(a2,a1)"],
				[["javascript","typescript"],"(a1.indexOf(a2) !== -1)"],
				[["coffeescript"],"(a1.indexOf(a2) != -1)"],
				[["prolog","minizinc"],"member(a2,a1)"],
			]);
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

function function_call(lang, name, params){
	return inputs_to_outputs(lang,{name:name,params:params},[
		[['c',"yacas","coffeequate","asciimath","alt-ergo","mysql","glsl","symja","sage","chrg","pydatalog","tex","sidef","z3py","constraint handling rules","prolog","visual basic .net","english_temp","sympy","lua","cython","definite clause grammars","python","coconut","ruby","logtalk","nim","seed7","gap","mathematical notation","chapel","elixir","janus","perl 6","pascal","rust","hack","katahdin","minizinc","pawn","aldor","picat",'d',"genie","ooc","delphi","standard ml","rexx","falcon","idp","processing","maxima","swift","boo","r","matlab","autoit","pike","gosu","awk","autohotkey","gambas","kotlin","nemerle","engscript","groovy","scala","coffeescript","julia","typescript","fortran","octave","c++","go","cobra","vala","f#","java","ceylon","erlang","c#","haxe","javascript","dart","bc","visual basic","php","perl"],
			"name(params)"],
		[["reverse polish notation"],
			"params name"],
		[["rebol"],
			"name params"],
		[["english"],
			"name{params}"],
		[["peg.js"],
			"params:name"],
		[["wolfram","ruby-prolog","nearley"],
			"name[params]"],
		[["haskell","common prolog","hy","clips","pddl","ocaml","smt-lib","clips","clojure","common lisp","clips","racket","scheme"],
			"(name params)"]
	]);
}

function inputs_to_outputs(lang,keys,arrays){
	for(var i = 0; i < arrays.length;i++){
		if(member(lang,arrays[i][0])){
			return replaceAll(arrays[i][1],keys);
		}
	}
	return undefined;
}

function replaceAll(str,mapObj){
    var re = new RegExp(Object.keys(mapObj).join("|"),"gi");

    return str.replace(re, function(matched){
        return mapObj[matched.toLowerCase()];
    });
}
