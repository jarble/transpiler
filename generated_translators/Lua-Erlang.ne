
#The following expressions are the same in every language.

chunk -> _ ( _series_of_statements | class | class_extends) _ {%function(d){
	toReturn = d[1][0];
	if(Array.isArray(toReturn)){
		return d.join("");
	}
	else{
		return d[1][0];
	}
}%}
_series_of_statements -> statement {%function(d){return d[0];}%} | series_of_statements __ statement {%function(d){return d[0] + "\n" + d[2];}%}

series_of_statements -> statement {%function(d){return d[0];}%} | series_of_statements statement_separator __ statement {%function(d){return d[0] + d[1] + "\n" + d[3];}%}

arithmetic_expression -> expression
boolean_expression -> expression
string_expression -> expression
array_expression -> expression

expression ->  accessArray | this | functionCall | varName | dictionary | declare_new_object
| parentheses_expression | string_to_int | add | subtract | multiply | mod | divide | number | pow | strlen | sin | cos | tan | sqrt | array_length
| String | concatenateString | substring | int_to_string | split | join
| initializerList | range
| false | true | not_equal | greaterThan | compareInts | strcmp | lessThanOrEqual | greaterThanOrEqual | lessThan | and | or | not | arrayContains

statement ->   func | typeless_function | typeless_variable_declaration | plusEquals | minusEquals | declare_constant | initializeArray | print | comment | switch | setVar | initializeVar | functionCallStatement | return | if | while | forInRange | exception
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
typeless_parameter -> identifier{%function(d){
	return d[0];
}%}
function_call_parameter_separator -> ","{%function(d){
	return ",";
}%}
declare_constant -> "local" _ __ _ varName _ "=" _ expression{%function(d){
	return d[4] + "=" + d[8];
}%}
anonymousFunction -> "function" _ "(" _ parameterList _ ")" _ __ _ series_of_statements _ __ _ "end"{%function(d){
	return "fun" + "(" + d[4] + ")" + " " + d[10] + " " + "end";
}%}
sin -> "math" _ "." _ "sin" _ "(" _ expression _ ")"{%function(d){
	return "math:sin" + "(" + d[8] + ")";
}%}
sqrt -> "math" _ "." _ "sqrt" _ "(" _ expression _ ")"{%function(d){
	return "math:sqrt" + "(" + d[8] + ")";
}%}
cos -> "math" _ "." _ "cos" _ "(" _ expression _ ")"{%function(d){
	return "math:cos" + "(" + d[8] + ")";
}%}
tan -> "math:tan" _ "(" _ expression _ ")"{%function(d){
	return "math:tan" + "(" + d[4] + ")";
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
class -> class_statements{%function(d){
	return d[0];
}%}
pow -> "math" _ "." _ "pow" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return "math:pow" + "(" + d[8] + "," + d[12] + ")";
}%}
_or -> arithmetic_expression _ __ _ "or" _ __ _ arithmetic_expression{%function(d){
	return d[0] + " " + "or" + " " + d[8];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> boolean_expression _ __ _ "and" _ __ _ boolean_expression{%function(d){
	return d[0] + " " + "and" + " " + d[8];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "not" _ __ _ boolean_expression{%function(d){
	return "not" + " " + d[4];
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
concatenateString -> string_expression _ ".." _ string_expression{%function(d){
	return "string:concat" + "(" + d[0] + "," + d[4] + ")";
}%}
initializeVar -> "local" _ __ _ varName _ "=" _ expression{%function(d){
	return d[4] + "=" + d[8];
}%}
return -> "return" _ __ _ expression{%function(d){
	return d[4];
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "function" _ __ _ identifier _ "(" _ parameterList _ ")" _ __ _ series_of_statements _ __ _ "end"{%function(d){
	return d[4] + "(" + d[8] + ")" + "->" + d[14];
}%}
if -> "if" _ __ _ boolean_expression _ __ _ "then" _ __ _ series_of_statements _ __ _ elifOrElse _ __ _ "end"{%function(d){
	return "if" + " " + d[4] + "->" + d[12] + " " + d[16] + " " + "end";
}%}
elif -> "elsif" _ __ _ boolean_expression _ __ _ "then" _ __ _ series_of_statements{%function(d){
	return d[4] + "->" + d[12];
}%}
else -> "else" _ __ _ series_of_statements{%function(d){
	return "true" + "->" + d[4];
}%}
print -> "print" _ "(" _ expression _ ")"{%function(d){
	return "io" + ":" + "fwrite" + "(" + d[4] + ")";
}%}
comment -> "--" _ _string{%function(d){
	return "%" + d[2];
}%}
mod -> arithmetic_expression _ "%" _ arithmetic_expression{%function(d){
	return d[0] + " " + "rem" + " " + d[4];
}%}
setVar -> varName _ "=" _ expression{%function(d){
	return d[0] + "=" + d[4];
}%}
parameter -> varName{%function(d){
	return d[0];
}%}
int -> "number"{%function(d){
	return "Integer";
}%}
string -> "string"{%function(d){
	return "string";
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
strcmp -> string_expression _ "==" _ string_expression{%function(d){
	return "string:equal" + "(" + d[0] + "," + d[4] + ")";
}%}
strlen -> "string" _ "." _ "len" _ "(" _ string_expression _ ")"{%function(d){
	return "string:len" + "(" + d[8] + ")";
}%}
parameter_separator -> ","{%function(d){
	return ",";
}%}
