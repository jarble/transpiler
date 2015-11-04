
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
series_of_statements -> statement {%function(d){return d[0];}%} | series_of_statements "\n" _ statement {%function(d){return d[0] + "\n" + d[3];}%}

arithmetic_expression -> expression
boolean_expression -> expression
string_expression -> expression
array_expression -> expression

expression ->  accessArray | this | functionCall | varName | dictionary | declare_new_object
| parentheses_expression | string_to_int | add | subtract | multiply | mod | divide | number | pow | strlen | sin | cos | tan | sqrt | array_length
| String | concatenateString | substring | int_to_string | split | join
| initializerList | range
| false | true | not_equal | greaterThan | compareInts | strcmp | lessThanOrEqual | greaterThanOrEqual | lessThan | and | or | not | arrayContains

statement ->  exception | func | typeless_function | typeless_variable_declaration | plusEquals | minusEquals | declare_constant | initializeArray | print | comment | switch | setVar | initializeVar | functionCallStatement | return | if | while | forInRange
class_statement -> constructor | initialize_static_variable_with_value | initialize_instance_variable_with_value | initialize_static_variable | initialize_instance_variable | instance_method | static_method | comment

_class_statements -> class_statements _ class_statement {%function(d){return d[0] +"\n"+ d[2];}%} | class_statement {%function(d){return d[0];}%} | null
class_statements -> class_statement {%function(d){return d[0];}%} | class_statements _ class_statement {%function(d){return d[0] + "\n" + d[2];}%}


type -> boolean | int | string | auto | arrayType | void
caseStatements -> caseStatements _ case {%function(d){return d[0] +"\n"+ d[2];}%} | case
elifStatements -> elifStatements _ elif {%function(d){return d[0] +"\n"+ d[2];}%} | elif #Match a series of elif statements
elifOrElse -> else | elifStatements _ else {%function(d){return d[0] +"\n"+ d[2];}%} #Match a series of elif statements followed by else

parameterList -> _parameterList | null
_parameterList -> _parameterList _ parameter_separator _ parameter {%function(d){return d[0]+d[2]+d[4]}%}
| parameter

typeless_parameters -> _typeless_parameters | null
_typeless_parameters -> _typeless_parameters _ parameter_separator _ typeless_parameter {%function(d){return d[0]+d[2]+d[4]}%}
| typeless_parameter

functionCallParameters -> functionCallParameters _ function_call_parameter_separator _ expression {% function(d) {return d.join(""); } %} | expression | null

keyValueList -> _keyValueList
_keyValueList -> _keyValueList _ keyValueSeparator _ keyValue {%function(d){return d[0]+d[2]+d[4]}%}
| keyValue

_initializerList -> _initializerList _ initializerListSeparator _ expression {%function(d){return d[0]+d[2]+d[4]}%}
| expression

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
range -> expression _ ".." _ expression{%function(d){
	return d[0] + ".." + d[4];
}%}
typeless_parameter -> identifier{%function(d){
	return d[0];
}%}
split -> expression _ "." _ "split" _ "(" _ expression _ ")"{%function(d){
	return "split" + "(" + d[0] + "," + d[8] + ")";
}%}
function_call_parameter_separator -> ","{%function(d){
	return ",";
}%}
declare_constant -> varName _ "=" _ expression{%function(d){
	return d[0] + "=" + d[4] + ",";
}%}
initializeArray -> identifier _ "=" _ array_expression{%function(d){
	return d[0] + "=" + d[4];
}%}
accessArray -> identifier _ "[" _ arithmetic_expression _ "]"{%function(d){
	return d[0] + "[" + d[4] + "]";
}%}
initializerListSeparator -> ","{%function(d){
	return ",";
}%}
initializerList -> "[" _ _initializerList _ "]"{%function(d){
	return "{" + d[2] + "}";
}%}
void -> _{%function(d){
	return "";
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
class -> "class" _ __ _ identifier _ __ _ class_statements _ __ _ "end"{%function(d){
	return d[8];
}%}
pow -> arithmetic_expression _ "**" _ arithmetic_expression{%function(d){
	return d[0] + "**" + d[4];
}%}
_or -> arithmetic_expression _ __ _ "or" _ __ _ arithmetic_expression{%function(d){
	return d[0] + "||" + d[8];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> boolean_expression _ __ _ "and" _ __ _ boolean_expression{%function(d){
	return d[0] + "&&" + d[8];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "!" _ boolean_expression{%function(d){
	return "not" + " " + d[2];
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
initializeVar -> varName _ "=" _ expression{%function(d){
	return d[0] + "=" + d[4];
}%}
return -> "return" _ __ _ expression{%function(d){
	return "ToReturn" + "=" + d[4];
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "def" _ __ _ identifier _ "(" _ parameterList _ ")" _ __ _ series_of_statements _ __ _ "end"{%function(d){
	return d[4] + "(" + d[8] + ")" + "=" + "ToReturn" + "=>" + d[14] + ".";
}%}
if -> "if" _ __ _ boolean_expression _ __ _ "then" _ __ _ series_of_statements _ __ _ elifOrElse _ __ _ "end"{%function(d){
	return "if" + " " + d[4] + " " + "then" + " " + d[12] + " " + d[16] + " " + "end";
}%}
elif -> "elsif" _ __ _ boolean_expression _ __ _ "then" _ __ _ series_of_statements{%function(d){
	return "elseif" + " " + d[4] + " " + "then" + " " + d[12];
}%}
plusEquals -> expression _ "=" _ expression _ "+" _ expression{%function(d){
	return d[0] + "=" + d[0] + "+" + d[8];
}%}
else -> "else" _ __ _ series_of_statements{%function(d){
	return "else" + " " + d[4];
}%}
while -> "while" _ __ _ boolean_expression _ __ _ series_of_statements _ __ _ "end"{%function(d){
	return "while" + " " + "(" + d[4] + ")" + " " + d[8] + " " + "end";
}%}
listComprehension -> array_expression _ "." _ "select" _ "{" _ "|" _ varName _ "|" _ boolean_expression _ "}" _ "." _ "collect" _ "{" _ "|" _ varName _ "|" _ expression _ "}"{%function(d){
	return "[" + d[30] + ":" + d[10] + " " + "in" + " " + d[0] + "," + d[14] + "]";
}%}
import -> "require" _ __ _ "'" _ expression _ "'"{%function(d){
	return "import" + " " + d[6];
}%}
comment -> "#" _ _string{%function(d){
	return "%" + d[2];
}%}
mod -> arithmetic_expression _ "%" _ arithmetic_expression{%function(d){
	return d[0] + " " + "mod" + " " + d[4];
}%}
setVar -> varName _ "=" _ expression{%function(d){
	return d[0] + "=" + d[4];
}%}
parameter -> varName{%function(d){
	return d[0];
}%}
functionCallStatement -> functionCall{%function(d){
	return d[0];
}%}
greaterThanOrEqual -> arithmetic_expression _ ">=" _ arithmetic_expression{%function(d){
	return d[0] + ">=" + d[4];
}%}
lessThanOrEqual -> arithmetic_expression _ "<=" _ arithmetic_expression{%function(d){
	return d[0] + "<=" + d[4];
}%}
foreach -> expression _ "." _ "each" _ __ _ "do" _ "|" _ expression _ "|" _ __ _ series_of_statements _ __ _ "end"{%function(d){
	return "foreach" + "(" + d[12] + " " + "in" + " " + d[0] + ")" + " " + d[18] + " " + "end";
}%}
strcmp -> string_expression _ "==" _ string_expression{%function(d){
	return d[0] + "==" + d[4];
}%}
array_length -> array_expression _ "." _ "length"{%function(d){
	return d[0] + "." + "length";
}%}
strlen -> string_expression _ "." _ "length"{%function(d){
	return d[0] + "." + "length";
}%}
parameter_separator -> ","{%function(d){
	return ",";
}%}
static_method -> "def" _ __ _ "self" _ "." _ identifier _ "(" _ parameterList _ ")" _ __ _ series_of_statements _ __ _ "end"{%function(d){
	return "";
}%}
constructor -> "def" _ __ _ "initialize" _ "(" _ parameterList _ ")" _ __ _ series_of_statements _ __ _ "end"{%function(d){
	return "";
}%}
declare_new_object -> varName _ "=" _ identifier _ "." _ "new" _ "(" _ functionCallParameters _ ")"{%function(d){
	return "";
}%}
