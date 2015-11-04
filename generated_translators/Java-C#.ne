
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

series_of_statements -> statement {%function(d){return d[0];}%} | series_of_statements statement_separator __ statement {%function(d){return d[0] + d[1] + "\n" + d[3];}%}

dot_notation -> dot_notation _dot_notation identifier {%function(d){ return d[0] + d[1] + d[2] }%} | identifier

arithmetic_expression -> expression
boolean_expression -> expression
string_expression -> expression
array_expression -> expression

statement_with_semicolon -> statement_without_semicolon _ semicolon {% function(d){return d[0] + d[2]; }%}

expression -> string_to_regex | accessArray | this | functionCall | varName | dictionary | declare_new_object
| parentheses_expression | pi | natural_logarithm | absolute_value | floor | ceiling | string_to_int | add | subtract | multiply | mod | divide | number | pow | strlen | asin | acos | atan | sin | cos | tan | sqrt | array_length
| String | concatenateString | substring | int_to_string | split | join | startswith | endswith | globalReplace
| initializerList | range
| false | true | instanceof | not_equal | greaterThan | compareInts | strcmp | lessThanOrEqual | greaterThanOrEqual | lessThan | and | or | not | arrayContains | stringContains

statement_without_semicolon -> typeless_variable_declaration | setVar | increment | decrement | initializeEmptyVar | initializeVar | typeless_initializeVar | functionCall | exception | return | functionCallStatement | plusEquals | minusEquals | declare_constant | initializeArray | print
statement ->   func | statement_with_semicolon | for_loop | typeless_function | comment | switch | if | while | forInRange

class_statement_without_semicolon -> initialize_static_variable_with_value | initialize_instance_variable_with_value | initialize_static_variable | initialize_instance_variable
class_statement_with_semicolon -> class_statement_without_semicolon _ semicolon {% function(d){return d[0] + d[2]; }%}
class_statement -> constructor | instance_method | static_method | comment | class_statement_with_semicolon

_class_statements -> class_statements _ class_statement {%function(d){return d[0] +"\n"+ d[2];}%} | class_statement {%function(d){return d[0];}%} | null
class_statements -> class_statement {%function(d){return d[0];}%} | class_statements _ class_statement {%function(d){return d[0] + "\n" + d[2];}%}


type -> boolean | int | double | string | auto | arrayType | void | dictionary_type
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
increment -> expression _ "++"{%function(d){
	return d[0] + "" + "++";
}%}
decrement -> expression _ "--"{%function(d){
	return d[0] + "" + "--";
}%}
floor -> "Math" _ "." _ "floor" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Floor" + "" + "(" + "" + d[8] + "" + ")";
}%}
ceiling -> "Math" _ "." _ "ceil" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Ceiling" + "" + "(" + "" + d[8] + "" + ")";
}%}
typeless_initializeVar -> "Object" __ varName _ "=" _ expression{%function(d){
	return "var" + " " + d[2] + "" + "=" + "" + d[6];
}%}
absolute_value -> "Math" _ "." _ "abs" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Abs" + "" + "(" + "" + d[8] + "" + ")";
}%}
natural_logarithm -> "Math" _ "." _ "log" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Log" + "" + "(" + "" + d[8] + "" + ")";
}%}
pi -> "Math" _ "." _ "PI"{%function(d){
	return "Math" + "" + "." + "" + "PI";
}%}
asin -> "Math" _ "." _ "asin" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Asin" + "" + "(" + "" + d[8] + "" + ")";
}%}
acos -> "Math" _ "." _ "acos" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Acos" + "" + "(" + "" + d[8] + "" + ")";
}%}
atan -> "Math" _ "." _ "atan" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Atan" + "" + "(" + "" + d[8] + "" + ")";
}%}
globalReplace -> expression _ "." _ "replaceAll" _ "(" _ expression _ "," _ expression _ ")"{%function(d){
	return d[0] + "" + "." + "" + "Replace" + "" + "(" + "" + d[8] + "" + "," + "" + d[12] + "" + ")";
}%}
stringContains -> expression _ "." _ "contains" _ "(" _ expression _ ")"{%function(d){
	return d[0] + "" + "." + "" + "Contains" + "" + "(" + "" + d[8] + "" + ")";
}%}
endswith -> expression _ "." _ "endsWith" _ "(" _ expression _ ")"{%function(d){
	return d[0] + "" + "." + "" + "Contains" + "" + "(" + "" + d[8] + "" + ")";
}%}
startswith -> expression _ "." _ "startsWith" _ "(" _ "contained" _ ")"{%function(d){
	return d[0] + "" + "." + "" + "StartsWith" + "" + "(" + "" + "contained" + "" + ")";
}%}
statement_separator -> _{%function(d){
	return "";
}%}
for_loop -> "for" _ "(" _ statement_without_semicolon _ ";" _ expression _ ";" _ statement_without_semicolon _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "for" + "" + "(" + "" + d[4] + "" + ";" + "" + d[8] + "" + ";" + "" + d[12] + "" + ")" + "" + "{" + "" + d[18] + "" + "}";
}%}
initialize_instance_variable -> "private" __ type __ identifier{%function(d){
	return "private" + " " + d[2] + " " + d[4];
}%}
initialize_instance_variable_with_value -> "private" __ type __ identifier _ "=" _ expression{%function(d){
	return "private" + " " + d[2] + " " + d[4] + "" + "=" + "" + d[8];
}%}
initialize_static_variable -> "public" __ "static" __ type __ identifier{%function(d){
	return "public" + " " + "static" + " " + d[4] + " " + d[6];
}%}
initialize_static_variable_with_value -> "public" __ "static" __ type __ identifier _ "=" _ expression{%function(d){
	return "public" + " " + "static" + " " + d[4] + " " + d[6] + "" + "=" + "" + d[10];
}%}
typeless_parameter -> "Object" __ identifier{%function(d){
	return "object" + " " + d[2];
}%}
typeless_function -> "Object" __ identifier _ "(" _ typeless_parameters _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "public" + " " + "static" + " " + "object" + " " + d[2] + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}";
}%}
typeless_variable_declaration -> "Object" __ varName _ "=" _ identifier{%function(d){
	return "var" + " " + d[2] + "" + "=" + "" + d[6];
}%}
int_to_string -> "Integer" _ "." _ "toString" _ "(" _ expression _ ")"{%function(d){
	return "Convert" + "" + "." + "" + "ToString" + "" + "(" + "" + d[8] + "" + ")";
}%}
split -> expression _ "." _ "split" _ "(" _ expression _ ")"{%function(d){
	return d[0] + "" + "." + "" + "Split" + "" + "(" + "" + "new" + "" + "string[]" + "" + "{" + "" + d[8] + "" + "}" + "" + "," + "" + "StringSplitOptions" + "" + "." + "" + "None" + "" + ")";
}%}
join -> "array" _ "." _ "join" _ "(" _ "separator" _ ")"{%function(d){
	return "String" + "" + "." + "" + "Join" + "" + "(" + "" + "separator" + "" + "," + "" + "array" + "" + ")";
}%}
function_call_parameter_separator -> ","{%function(d){
	return ",";
}%}
regex -> "Pattern"{%function(d){
	return "Regex";
}%}
string_to_int -> "Integer" _ "." _ "parseInt" _ "(" _ expression _ ")"{%function(d){
	return "Int32" + "" + "." + "" + "Parse(" + "" + d[8] + "" + ")";
}%}
declare_constant -> "final" __ type __ varName _ "=" _ expression{%function(d){
	return "const" + " " + d[2] + " " + d[4] + "" + "=" + "" + d[8];
}%}
initializeArray -> arrayType __ identifier _ "=" _ array_expression{%function(d){
	return d[0] + " " + d[2] + "" + "=" + "" + d[6];
}%}
array_access_separator -> "]["{%function(d){
	return ",";
}%}
array_access_index -> expression{%function(d){
	return d[0];
}%}
accessArray -> identifier _ "[" _ array_access_list _ "]"{%function(d){
	return d[0] + "" + "[" + "" + d[4] + "" + "]";
}%}
arrayType -> type _ "[]"{%function(d){
	return d[0] + "" + "[]";
}%}
initializerListSeparator -> ","{%function(d){
	return ",";
}%}
initializerList -> "{" _ _initializerList _ "}"{%function(d){
	return "{" + "" + d[2] + "" + "}";
}%}
keyValue -> "put" _ "(" _ identifier _ "," _ expression _ ")"{%function(d){
	return "{" + "" + d[4] + "" + "," + "" + d[8] + "" + "}";
}%}
charAt -> expression _ "." _ "charAt" _ "(" _ expression _ ")"{%function(d){
	return d[0] + "" + "[" + "" + d[8] + "" + "]";
}%}
auto -> "Object"{%function(d){
	return "object";
}%}
void -> "void"{%function(d){
	return "void";
}%}
sin -> "Math" _ "." _ "sin" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Sin" + "" + "(" + "" + d[8] + "" + ")";
}%}
sqrt -> "Math" _ "." _ "sqrt" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Sqrt" + "" + "(" + "" + d[8] + "" + ")";
}%}
cos -> "Math" _ "." _ "cos" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Cos" + "" + "(" + "" + d[8] + "" + ")";
}%}
tan -> "Math" _ "." _ "tan" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Tan" + "" + "(" + "" + d[8] + "" + ")";
}%}
dictionary -> "new" __ "HashMap" _ "<" _ type _ "," _ type _ ">" _ "(" _ ")" _ "{" _ "{" _ keyValueList _ "}" _ "}"{%function(d){
	return "new" + " " + "Dictionary" + "" + "<" + "" + d[6] + "" + "," + "" + d[10] + "" + ">" + "" + "{" + "" + d[22] + "" + "}";
}%}
keyValueSeparator -> ";"{%function(d){
	return ",";
}%}
true -> "true"{%function(d){
	return "true";
}%}
false -> "false"{%function(d){
	return "false";
}%}
compareInts -> arithmetic_expression _ "==" _ arithmetic_expression{%function(d){
	return d[0] + "" + "==" + "" + d[4];
}%}
parentheses_expression -> "(" _ expression _ ")"{%function(d){
	return "(" + "" + d[2] + "" + ")";
}%}
greaterThan -> arithmetic_expression _ ">" _ arithmetic_expression{%function(d){
	return d[0] + "" + ">" + "" + d[4];
}%}
lessThan -> arithmetic_expression _ "<" _ arithmetic_expression{%function(d){
	return d[0] + "" + "<" + "" + d[4];
}%}
class_extends -> "public" __ "class" __ identifier __ "extends" __ identifier _ "{" _ class_statements _ "}"{%function(d){
	return "public" + " " + "class" + " " + d[4] + " " + "extends" + " " + d[8] + "" + "{" + "" + d[12] + "" + "}";
}%}
class -> "public" __ "class" __ identifier _ "{" _ class_statements _ "}"{%function(d){
	return "public" + " " + "class" + " " + d[4] + "" + "{" + "" + d[8] + "" + "}";
}%}
arrayContains -> "Arrays" _ "." _ "asList" _ "(" _ array_expression _ ")" _ "." _ "contains" _ "(" _ expression _ ")"{%function(d){
	return d[8] + "" + "." + "" + "Contains" + "" + "(" + "" + d[18] + "" + ")";
}%}
this -> "this" _ "." _ varName{%function(d){
	return "this" + "" + "." + "" + d[4];
}%}
pow -> "Math" _ "." _ "pow" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "Pow" + "" + "(" + "" + d[8] + "" + "," + "" + d[12] + "" + ")";
}%}
_or -> arithmetic_expression _ "||" _ arithmetic_expression{%function(d){
	return d[0] + "" + "||" + "" + d[4];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> boolean_expression _ "&&" _ boolean_expression{%function(d){
	return d[0] + "" + "&&" + "" + d[4];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "!" _ boolean_expression{%function(d){
	return "!" + "" + d[2];
}%}
_multiply -> arithmetic_expression _ "*" _ arithmetic_expression{%function(d){
	return d[0] + "" + "*" + "" + d[4];
}%}
multiply -> _multiply{%function(d){
	return d[0];
}%}
_divide -> arithmetic_expression _ "/" _ arithmetic_expression{%function(d){
	return d[0] + "" + "/" + "" + d[4];
}%}
divide -> _divide{%function(d){
	return d[0];
}%}
_add -> arithmetic_expression _ "+" _ arithmetic_expression{%function(d){
	return d[0] + "" + "+" + "" + d[4];
}%}
add -> _add{%function(d){
	return d[0];
}%}
_subtract -> arithmetic_expression _ "-" _ arithmetic_expression{%function(d){
	return d[0] + "" + "-" + "" + d[4];
}%}
subtract -> _subtract{%function(d){
	return d[0];
}%}
functionCall -> dot_notation _ "(" _ functionCallParameters _ ")"{%function(d){
	return d[0] + "" + "(" + "" + d[4] + "" + ")";
}%}
double -> "double"{%function(d){
	return "double";
}%}
concatenateString -> string_expression _ "+" _ string_expression{%function(d){
	return d[0] + "" + "+" + "" + d[4];
}%}
initializeVar -> type __ varName _ "=" _ expression{%function(d){
	return d[0] + " " + d[2] + "" + "=" + "" + d[6];
}%}
return -> "return" __ expression{%function(d){
	return "return" + " " + d[2];
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "public" __ "static" __ type __ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "public" + " " + "static" + " " + d[4] + " " + d[6] + "" + "(" + "" + d[10] + "" + ")" + "" + "{" + "" + d[16] + "" + "}";
}%}
if -> "if" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}" _ elifOrElse{%function(d){
	return "if" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + "" + "}" + "" + d[14];
}%}
elif -> "else" __ "if" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}" _ elifOrElse{%function(d){
	return "else" + " " + "if" + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}" + "" + d[16];
}%}
plusEquals -> expression _ "+=" _ expression{%function(d){
	return d[0] + "" + "+=" + "" + d[4];
}%}
minusEquals -> expression _ "-=" _ expression{%function(d){
	return d[0] + "" + "-=" + "" + d[4];
}%}
else -> "else" _ "{" _ series_of_statements _ "}"{%function(d){
	return "else" + "" + "{" + "" + d[4] + "" + "}";
}%}
while -> "while" _ "(" _ boolean_expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "while" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + "" + "}";
}%}
forInRange -> "for" _ "(" _ "int" __ varName _ "=" _ arithmetic_expression _ ";" _ varName _ "<" _ arithmetic_expression _ ";" _ varName _ "++" _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "for" + "" + "(" + "" + "int" + " " + d[6] + "" + "=" + "" + d[10] + "" + ";" + "" + d[6] + "" + "<" + "" + d[18] + "" + ";" + "" + d[6] + "" + "++" + "" + ")" + "" + "{" + "" + d[30] + "" + "}";
}%}
import -> "import" __ expression _ ";"{%function(d){
	return "using" + " " + d[2] + "" + ";";
}%}
print -> "System" _ "." _ "out" _ "." _ "println" _ "(" _ expression _ ")"{%function(d){
	return "Console" + "" + "." + "" + "WriteLine" + "" + "(" + "" + d[12] + "" + ")";
}%}
comment -> "//" _ _string{%function(d){
	return "//" + "" + d[2];
}%}
mod -> arithmetic_expression _ "%" _ arithmetic_expression{%function(d){
	return d[0] + "" + "%" + "" + d[4];
}%}
semicolon -> ";"{%function(d){
	return ";";
}%}
setVar -> varName _ "=" _ expression{%function(d){
	return d[0] + "" + "=" + "" + d[4];
}%}
parameter -> type __ varName{%function(d){
	return d[0] + " " + d[2];
}%}
instanceof -> expression __ "instanceof" __ type{%function(d){
	return d[0] + " " + "as" + " " + d[4];
}%}
_dot_notation -> "."{%function(d){
	return ".";
}%}
initializeEmptyVar -> type __ varName{%function(d){
	return d[0] + " " + d[2];
}%}
boolean -> "boolean"{%function(d){
	return "bool";
}%}
int -> "int"{%function(d){
	return "int";
}%}
string -> "String"{%function(d){
	return "string";
}%}
functionCallStatement -> functionCall _ semicolon{%function(d){
	return d[0] + "" + d[2];
}%}
greaterThanOrEqual -> arithmetic_expression _ ">=" _ arithmetic_expression{%function(d){
	return d[0] + "" + ">=" + "" + d[4];
}%}
lessThanOrEqual -> arithmetic_expression _ "<=" _ arithmetic_expression{%function(d){
	return d[0] + "" + "<=" + "" + d[4];
}%}
switch -> "switch" _ "(" _ expression _ ")" _ "{" _ caseStatements __ default _ "}"{%function(d){
	return "switch" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + " " + d[12] + "" + "}";
}%}
case -> "case" __ expression _ ":" _ series_of_statements _ "break" _ ";"{%function(d){
	return "case" + " " + d[2] + "" + ":" + "" + d[6] + "" + "break" + "" + ";";
}%}
foreach -> "for" _ "(" _ type __ expression _ ":" _ expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "foreach" + "" + "(" + "" + d[4] + " " + d[6] + " " + "in" + " " + d[10] + "" + ")" + "" + "{" + "" + d[16] + "" + "}";
}%}
default -> "default" _ ":" _ series_of_statements{%function(d){
	return "default" + "" + ":" + "" + d[4];
}%}
substring -> string_expression _ "." _ "substring" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return d[0] + "" + "." + "" + "Substring" + "" + "(" + "" + d[8] + "" + "," + "" + d[12] + "" + ")";
}%}
strcmp -> string_expression _ "." _ "equals" _ "(" _ string_expression _ ")"{%function(d){
	return d[0] + "" + "." + "" + "Equals" + "" + "(" + "" + d[8] + "" + ")";
}%}
array_length -> array_expression _ "." _ "length"{%function(d){
	return d[0] + "" + "." + "" + "Length";
}%}
strlen -> string_expression _ "." _ "length" _ "(" _ ")"{%function(d){
	return d[0] + "" + "." + "" + "Length";
}%}
parameter_separator -> ","{%function(d){
	return ",";
}%}
not_equal -> expression _ "!=" _ expression{%function(d){
	return d[0] + "" + "!=" + "" + d[4];
}%}
instance_method -> "public" __ type __ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "public" + " " + d[2] + " " + d[4] + "" + "(" + "" + d[8] + "" + ")" + "" + "{" + "" + d[14] + "" + "}";
}%}
static_method -> "public" __ "static" __ type __ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "public" + " " + "static" + " " + d[4] + " " + d[6] + "" + "(" + "" + d[10] + "" + ")" + "" + "{" + "" + d[16] + "" + "}";
}%}
constructor -> "public" __ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "public" + " " + d[2] + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}";
}%}
dictionary_type -> "HashMap" _ "<" _ type _ "," _ type _ ">"{%function(d){
	return "Dictionary" + "" + "<" + "" + d[4] + "" + "," + "" + d[8] + "" + ">";
}%}
declare_new_object -> identifier __ varName _ "=" _ "new" __ identifier _ "(" _ functionCallParameters _ ")"{%function(d){
	return d[0] + " " + d[2] + "" + "=" + "" + "new" + " " + d[0] + "" + "(" + "" + d[12] + "" + ")";
}%}
