
#The following expressions are the same in every language.

chunk -> _ ( series_of_statements | class | class_extends) _ {%function(d){
	toReturn = d[1][0];
	if(Array.isArray(toReturn)){
		return d.join("");
	}
	else{
		return d[1][0];
	}
}%}

statement_without_semicolon -> _setVar | _initializeVar | functionCall

series_of_statements -> statement {%function(d){return d[0];}%} | series_of_statements statement_separator __ statement {%function(d){return d[0] + d[1] + "\n" + d[3];}%}

arithmetic_expression -> expression
boolean_expression -> expression
string_expression -> expression
array_expression -> expression

expression -> string_to_regex | accessArray | this | functionCall | varName | dictionary | declare_new_object
| parentheses_expression | pi | natural_logarithm | absolute_value | floor | ceiling | string_to_int | add | subtract | multiply | mod | divide | number | pow | strlen | asin | acos | atan | sin | cos | tan | sqrt | array_length
| String | concatenateString | substring | int_to_string | split | join | startswith | endswith | globalReplace
| initializerList | range
| false | true | not_equal | greaterThan | compareInts | strcmp | lessThanOrEqual | greaterThanOrEqual | lessThan | and | or | not | arrayContains | stringContains

statement ->   func | for_loop | typeless_function | typeless_variable_declaration | plusEquals | minusEquals | declare_constant | initializeArray | print | comment | switch | setVar | initializeVar | functionCallStatement | return | if | while | forInRange | exception
class_statement -> constructor | initialize_static_variable_with_value | initialize_instance_variable_with_value | initialize_static_variable | initialize_instance_variable | instance_method | static_method | comment

_class_statements -> class_statements _ class_statement {%function(d){return d[0] +"\n"+ d[2];}%} | class_statement {%function(d){return d[0];}%} | null
class_statements -> class_statement {%function(d){return d[0];}%} | class_statements _ class_statement {%function(d){return d[0] + "\n" + d[2];}%}


type -> boolean | int | string | auto | arrayType | void | dictionary_type
caseStatements -> caseStatements _ case {%function(d){return d[0] +"\n"+ d[2];}%} | case
elifOrElse -> else | elif

parameterList -> _parameterList | null
_parameterList -> _parameterList _ parameter_separator _ ( parameter | default_parameter ) {%function(d){return d[0]+d[2]+d[4]}%}
| (parameter | default_parameter )

typeless_parameters -> _typeless_parameters | null
_typeless_parameters -> _typeless_parameters _ parameter_separator _ typeless_parameter {%function(d){return d[0]+d[2]+d[4]}%}
| typeless_parameter

functionCallParameters -> functionCallParameters _ function_call_parameter_separator _ ( expression | function_call_named_parameter) {% function(d) {return d.join(""); } %} | (expression | function_call_named_parameter) | null

keyValueList -> _keyValueList
_keyValueList -> _keyValueList _ keyValueSeparator _ keyValue {%function(d){return d[0]+d[2]+d[4]}%}
| keyValue

_initializerList -> _initializerList _ initializerListSeparator _ expression {%function(d){return d[0]+d[2]+d[4]}%}
| expression

array_access_list -> array_access_index | array_access_list array_access_separator array_access_index {%function(d){return d[0]+d[1]+d[2]}%}

# Primitives
# ==========

identifier -> _name {% function(d) {return d[0]; } %}

_name -> [a-zA-Z_] {% id %}
	| _name [\w_] {% function(d) {return d[0] + d[1]; } %}

# Numbers

number -> _number {% function(d) {return parseFloat(d[0])} %}

_posint ->
	[0-9] {% id %}
	| _posint [0-9] {% function(d) {return d[0] + d[1]} %}

_int ->
	"-" _posint {% function(d) {return d[0] + d[1]; }%}
	| _posint {% id %}

_float ->
	_int {% id %}
	| _int "." _posint {% function(d) {return d[0] + d[1] + d[2]; }%}

_number ->
	_float {% id %}
	| _float "e" _int {% function(d){return d[0] + d[1] + d[2]; } %}


#Strings

String -> "\"" _string "\"" {% function(d) {return '"' + d[1] + '"'; } %}

_string ->
	null {% function() {return ""; } %}
	| _string _stringchar {% function(d) {return d[0] + d[1];} %}

_stringchar ->
	[^\\"] {% id %}
	| "\\" [^] {% function(d) {return JSON.parse("\"" + d[0] + d[1] + "\""); } %}

# Whitespace
_ -> null | _ [\s] {% function() {} %}
__ -> [\s] | __ [\s] {% function() {} %}


#The next two lines are the languages for the translator.
floor -> "Math" _ "." _ "Floor" _ "(" _ expression _ ")"{%function(d){
	return "floor" + "(" + d[8] + ")";
}%}
ceiling -> "Math" _ "." _ "Ceiling" _ "(" _ expression _ ")"{%function(d){
	return "ceil" + "(" + d[8] + ")";
}%}
natural_logarithm -> "Math" _ "." _ "Log" _ "(" _ expression _ ")"{%function(d){
	return "log" + "(" + d[8] + ")";
}%}
asin -> "Math" _ "." _ "Asin" _ "(" _ expression _ ")"{%function(d){
	return "std" + "::" + "asin" + "(" + d[8] + ")";
}%}
acos -> "Math" _ "." _ "Acos" _ "(" _ expression _ ")"{%function(d){
	return "std" + "::" + "acos" + "(" + d[8] + ")";
}%}
atan -> "Math" _ "." _ "Atan" _ "(" _ expression _ ")"{%function(d){
	return "std" + "::" + "atan" + "(" + d[8] + ")";
}%}
stringContains -> expression _ "." _ "Contains" _ "(" _ expression _ ")"{%function(d){
	return "(" + d[0] + "." + "find" + "(" + d[8] + ")" + "!=" + "std::string::npos" + ")";
}%}
startswith -> expression _ "." _ "StartsWith" _ "(" _ "contained" _ ")"{%function(d){
	return "(" + d[0] + "." + "rfind" + "(" + "contained" + "," + "0" + ")" + "==" + "0" + ")";
}%}
statement_separator -> _{%function(d){
	return "";
}%}
for_loop -> "for" _ "(" _ statement_without_semicolon _ ";" _ expression _ ";" _ statement_without_semicolon _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "for" + "(" + d[4] + ";" + d[8] + ";" + d[12] + ")" + "{" + d[18] + "}";
}%}
initialize_instance_variable -> "private" _ __ _ type _ __ _ identifier _ ";"{%function(d){
	return d[4] + " " + d[8] + ";";
}%}
initialize_instance_variable_with_value -> "private" _ __ _ type _ __ _ identifier _ "=" _ expression _ ";"{%function(d){
	return d[4] + " " + d[8] + "=" + d[12] + ";";
}%}
initialize_static_variable -> "public" _ __ _ "static" _ __ _ type _ __ _ identifier _ ";"{%function(d){
	return "static" + " " + d[8] + " " + d[12] + ";";
}%}
initialize_static_variable_with_value -> "public" _ __ _ "static" _ __ _ type _ __ _ identifier _ "=" _ expression _ ";"{%function(d){
	return "static" + " " + d[8] + " " + d[12] + "=" + d[16] + ";";
}%}
typeless_variable_declaration -> "var" _ __ _ varName _ "=" _ identifier _ ";"{%function(d){
	return "auto" + " " + d[4] + "=" + d[8] + ";";
}%}
int_to_string -> "Convert" _ "." _ "ToString" _ "(" _ expression _ ")"{%function(d){
	return "std" + "::" + "to_string" + "(" + d[8] + ")";
}%}
function_call_parameter_separator -> ","{%function(d){
	return ",";
}%}
string_to_int -> "Int32" _ "." _ "Parse(" _ expression _ ")"{%function(d){
	return "atoi" + "(" + d[6] + "." + "c_str" + "(" + ")" + ")";
}%}
declare_constant -> "const" _ __ _ type _ __ _ varName _ "=" _ expression _ ";"{%function(d){
	return "const" + " " + d[4] + " " + "a" + "=" + d[12] + ";";
}%}
initializeArray -> arrayType _ __ _ identifier _ "=" _ array_expression _ ";"{%function(d){
	return d[0] + " " + d[4] + "=" + d[8] + ";";
}%}
array_access_separator -> ","{%function(d){
	return "][";
}%}
array_access_index -> expression{%function(d){
	return d[0];
}%}
accessArray -> identifier _ "[" _ array_access_list _ "]"{%function(d){
	return d[0] + "[" + d[4] + "]";
}%}
arrayType -> type _ "[]"{%function(d){
	return d[0] + "[]";
}%}
initializerListSeparator -> ","{%function(d){
	return ",";
}%}
initializerList -> "{" _ _initializerList _ "}"{%function(d){
	return "{" + d[2] + "}";
}%}
keyValue -> "{" _ identifier _ "," _ expression _ "}"{%function(d){
	return "{" + d[2] + "," + d[6] + "}";
}%}
charAt -> expression _ "[" _ expression _ "]"{%function(d){
	return d[0] + "[" + d[4] + "]";
}%}
auto -> "var"{%function(d){
	return "auto";
}%}
void -> "void"{%function(d){
	return "void";
}%}
sin -> "Math" _ "." _ "Sin" _ "(" _ expression _ ")"{%function(d){
	return "std" + "::" + "sin" + "(" + d[8] + ")";
}%}
sqrt -> "Math" _ "." _ "Sqrt" _ "(" _ expression _ ")"{%function(d){
	return "std" + "::" + "sqrt" + "(" + d[8] + ")";
}%}
cos -> "Math" _ "." _ "Cos" _ "(" _ expression _ ")"{%function(d){
	return "std" + "::" + "cos" + "(" + d[8] + ")";
}%}
tan -> "Math" _ "." _ "Tan" _ "(" _ expression _ ")"{%function(d){
	return "std" + "::" + "tan" + "(" + d[8] + ")";
}%}
dictionary -> "new" _ __ _ "Dictionary" _ "<" _ type _ "," _ type _ ">" _ "{" _ keyValueList _ "}"{%function(d){
	return "{" + d[18] + "}";
}%}
keyValueSeparator -> ","{%function(d){
	return ",";
}%}
true -> "true"{%function(d){
	return "true";
}%}
false -> "false"{%function(d){
	return "false";
}%}
compareInts -> arithmetic_expression _ "==" _ arithmetic_expression{%function(d){
	return d[0] + "==" + d[4];
}%}
parentheses_expression -> "(" _ expression _ ")"{%function(d){
	return "(" + d[2] + ")";
}%}
greaterThan -> arithmetic_expression _ ">" _ arithmetic_expression{%function(d){
	return d[0] + ">" + d[4];
}%}
lessThan -> arithmetic_expression _ "<" _ arithmetic_expression{%function(d){
	return d[0] + "<" + d[4];
}%}
class_extends -> "public" _ __ _ "class" _ __ _ identifier _ __ _ "extends" _ __ _ identifier _ "{" _ class_statements _ "}"{%function(d){
	return "class" + " " + d[8] + ":" + "public" + " " + d[16] + "{" + d[20] + "}";
}%}
class -> "public" _ __ _ "class" _ __ _ identifier _ "{" _ class_statements _ "}"{%function(d){
	return "class" + " " + d[8] + "{" + d[12] + "}" + ";";
}%}
this -> "this" _ "." _ varName{%function(d){
	return "this" + "." + d[4];
}%}
pow -> "Math" _ "." _ "Pow" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return "pow" + "(" + d[8] + "," + d[12] + ")";
}%}
_or -> arithmetic_expression _ "||" _ arithmetic_expression{%function(d){
	return d[0] + "||" + d[4];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> boolean_expression _ "&&" _ boolean_expression{%function(d){
	return d[0] + "&&" + d[4];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "!" _ boolean_expression{%function(d){
	return "!" + d[2];
}%}
_multiply -> arithmetic_expression _ "*" _ arithmetic_expression{%function(d){
	return d[0] + "*" + d[4];
}%}
multiply -> _multiply{%function(d){
	return d[0];
}%}
_divide -> arithmetic_expression _ "/" _ arithmetic_expression{%function(d){
	return d[0] + "/" + d[4];
}%}
divide -> _divide{%function(d){
	return d[0];
}%}
_add -> arithmetic_expression _ "+" _ arithmetic_expression{%function(d){
	return d[0] + "+" + d[4];
}%}
add -> _add{%function(d){
	return d[0];
}%}
_subtract -> arithmetic_expression _ "-" _ arithmetic_expression{%function(d){
	return d[0] + "-" + d[4];
}%}
subtract -> _subtract{%function(d){
	return d[0];
}%}
functionCall -> identifier _ "(" _ functionCallParameters _ ")"{%function(d){
	return d[0] + "(" + d[4] + ")";
}%}
concatenateString -> string_expression _ "+" _ string_expression{%function(d){
	return d[0] + "+" + d[4];
}%}
_initializeVar -> type _ __ _ varName _ "=" _ expression{%function(d){
	return d[0] + " " + d[4] + "=" + d[8];
}%}
initializeVar -> _initializeVar _ semicolon{%function(d){
	return d[0] + d[2];
}%}
return -> "return" _ __ _ expression _ ";"{%function(d){
	return "return" + " " + d[4] + ";";
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "public" _ __ _ "static" _ __ _ type _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return d[8] + " " + d[12] + "(" + d[16] + ")" + "{" + d[22] + "}";
}%}
if -> "if" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}" _ elifOrElse{%function(d){
	return "if" + "(" + d[4] + ")" + "{" + d[10] + "}" + d[14];
}%}
elif -> "else" _ __ _ "if" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}" _ elifOrElse{%function(d){
	return "else" + " " + "if" + "(" + d[8] + ")" + "{" + d[14] + "}" + d[18];
}%}
plusEquals -> expression _ "+=" _ expression _ ";"{%function(d){
	return d[0] + "+=" + d[4] + ";";
}%}
minusEquals -> expression _ "-=" _ expression _ ";"{%function(d){
	return d[0] + "-=" + d[4] + ";";
}%}
else -> "else" _ "{" _ series_of_statements _ "}"{%function(d){
	return "else" + "{" + d[4] + "}";
}%}
while -> "while" _ "(" _ boolean_expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "while" + "(" + d[4] + ")" + "{" + d[10] + "}";
}%}
forInRange -> "for" _ "(" _ "int" _ __ _ varName _ "=" _ arithmetic_expression _ ";" _ varName _ "<" _ arithmetic_expression _ ";" _ varName _ "++" _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "for" + "(" + "int" + " " + d[8] + "=" + d[12] + ";" + d[8] + "<" + d[20] + ";" + d[8] + "++" + ")" + "{" + d[32] + "}";
}%}
import -> "using" _ __ _ expression _ ";"{%function(d){
	return "#include" + " " + "'" + d[4] + ".h'";
}%}
print -> "Console" _ "." _ "WriteLine" _ "(" _ expression _ ")" _ ";"{%function(d){
	return "cout" + "<<" + d[8] + ";";
}%}
comment -> "//" _ _string{%function(d){
	return "//" + d[2];
}%}
mod -> arithmetic_expression _ "%" _ arithmetic_expression{%function(d){
	return d[0] + "%" + d[4];
}%}
semicolon -> ";"{%function(d){
	return ";";
}%}
_setVar -> varName _ "=" _ expression{%function(d){
	return d[0] + "=" + d[4];
}%}
setVar -> _setVar _ semicolon{%function(d){
	return d[0] + d[2];
}%}
parameter -> type _ __ _ varName{%function(d){
	return d[0] + " " + d[4];
}%}
boolean -> "bool"{%function(d){
	return "bool";
}%}
int -> "int"{%function(d){
	return "int";
}%}
string -> "string"{%function(d){
	return "string";
}%}
functionCallStatement -> functionCall _ semicolon{%function(d){
	return d[0] + d[2];
}%}
greaterThanOrEqual -> arithmetic_expression _ ">=" _ arithmetic_expression{%function(d){
	return d[0] + ">=" + d[4];
}%}
lessThanOrEqual -> arithmetic_expression _ "<=" _ arithmetic_expression{%function(d){
	return d[0] + "<=" + d[4];
}%}
switch -> "switch" _ "(" _ expression _ ")" _ "{" _ caseStatements _ __ _ default _ "}"{%function(d){
	return "switch" + "(" + d[4] + ")" + "{" + d[10] + " " + d[14] + "}";
}%}
case -> "case" _ __ _ expression _ ":" _ series_of_statements _ "break" _ ";"{%function(d){
	return "case" + " " + d[4] + ":" + d[8] + "break" + ";";
}%}
foreach -> "foreach" _ "(" _ type _ __ _ expression _ __ _ "in" _ __ _ expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "for" + "(" + "getCorrespondingType" + " " + d[4] + " " + "&" + " " + d[8] + ":" + d[16] + "){" + d[22] + "}";
}%}
default -> "default" _ ":" _ series_of_statements{%function(d){
	return "default" + ":" + d[4];
}%}
substring -> string_expression _ "." _ "Substring" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return d[0] + "." + "substring" + "(" + d[8] + "," + d[12] + "-" + d[8] + ")";
}%}
strcmp -> string_expression _ "." _ "Equals" _ "(" _ string_expression _ ")"{%function(d){
	return d[0] + "." + "compare" + "(" + d[8] + ")";
}%}
array_length -> array_expression _ "." _ "Length"{%function(d){
	return d[0] + "." + "size" + "(" + ")";
}%}
strlen -> string_expression _ "." _ "Length"{%function(d){
	return d[0] + "." + "length" + "(" + ")";
}%}
parameter_separator -> ","{%function(d){
	return ",";
}%}
not_equal -> expression _ "!=" _ expression{%function(d){
	return d[0] + "!=" + d[4];
}%}
instance_method -> "public" _ __ _ type _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return d[4] + " " + d[8] + "(" + d[12] + ")" + "{" + d[18] + "}";
}%}
static_method -> "public" _ __ _ "static" _ __ _ type _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "static" + " " + d[8] + " " + d[12] + "(" + d[16] + ")" + "{" + d[22] + "}";
}%}
constructor -> "public" _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return d[4] + "(" + d[8] + ")" + "{" + d[14] + "}";
}%}
dictionary_type -> "Dictionary" _ "<" _ type _ "," _ type _ ">"{%function(d){
	return "std" + "::" + "map" + "<" + d[4] + "," + d[8] + ">";
}%}
declare_new_object -> identifier _ __ _ varName _ "=" _ "new" _ __ _ identifier _ "(" _ functionCallParameters _ ")" _ ";"{%function(d){
	return d[0] + " " + d[4] + "(" + d[16] + ")" + ";";
}%}
