
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
function_call_parameter_separator -> ","{%function(d){
	return " ";
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
_or -> arithmetic_expression _ "||" _ arithmetic_expression{%function(d){
	return d[0] + " " + "or" + " " + d[4];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> boolean_expression _ "&&" _ boolean_expression{%function(d){
	return d[0] + " " + "and" + " " + d[4];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "!" _ boolean_expression{%function(d){
	return "not" + " " + d[2];
}%}
functionCall -> identifier _ "(" _ functionCallParameters _ ")"{%function(d){
	return "(" + d[0] + " " + d[4] + ")";
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
import -> "import" _ __ _ expression _ ";"{%function(d){
	return "(import" + " " + d[4] + ")";
}%}
print -> "System" _ "." _ "out" _ "." _ "println" _ "(" _ expression _ ")" _ ";"{%function(d){
	return "(" + "print" + " " + d[12] + ")";
}%}
comment -> "//" _ _string{%function(d){
	return "//" + d[2];
}%}
parameter -> type _ __ _ varName{%function(d){
	return "(" + "parameter" + " " + d[0] + " " + d[4] + ")";
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
functionCallStatement -> functionCall _ ";"{%function(d){
	return "(" + "functionCallStatement" + " " + d[0] + ")";
}%}
greaterThanOrEqual -> arithmetic_expression _ ">=" _ arithmetic_expression{%function(d){
	return d[0] + ">=" + d[4];
}%}
lessThanOrEqual -> arithmetic_expression _ "<=" _ arithmetic_expression{%function(d){
	return "(" + "<=" + " " + d[0] + " " + d[4] + ")";
}%}
switch -> "switch" _ "(" _ expression _ ")" _ "{" _ caseStatements _ __ _ default _ "}"{%function(d){
	return "(" + "switch" + " " + d[4] + " " + d[10] + " " + d[14] + ")";
}%}
case -> "case" _ __ _ expression _ ":" _ series_of_statements _ "break" _ ";"{%function(d){
	return "(" + "case" + " " + d[4] + " " + d[8] + ")";
}%}
foreach -> "for" _ "(" _ type _ __ _ expression _ ":" _ expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "(" + "foreach" + " " + d[12] + " " + d[8] + " " + d[4] + " " + d[18] + ")";
}%}
default -> "default" _ ":" _ series_of_statements{%function(d){
	return "(" + "default" + " " + d[4] + ")";
}%}
substring -> string_expression _ "." _ "substring" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return "(" + "substring" + " " + d[0] + " " + d[8] + " " + d[12] + ")";
}%}
strcmp -> string_expression _ "." _ "equals" _ "(" _ string_expression _ ")"{%function(d){
	return "(" + "strcmp" + " " + d[0] + " " + d[8] + ")";
}%}
array_length -> array_expression _ "." _ "length"{%function(d){
	return "(" + "array_length" + " " + d[0] + ")";
}%}
instance_method -> "public" _ __ _ type _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "(" + "instance_method" + " " + d[8] + " " + d[12] + " " + d[4] + " " + d[18] + ")";
}%}
static_method -> "public" _ __ _ "static" _ __ _ type _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "(" + "staticmethod" + " " + d[12] + " " + d[8] + " " + d[16] + " " + d[22] + ")";
}%}
constructor -> "public" _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "(constructor" + " " + d[4] + " " + d[8] + " " + "body)";
}%}
