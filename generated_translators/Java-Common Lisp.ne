
#The following expressions are the same in every language.

chunk -> _ (_series_of_statements | class | class_extends) _ {%function(d){return d[1][0];}%}
_series_of_statements -> series_of_statements _ statement {%function(d){return d[0] +"\n"+ d[2];}%} | statement {%function(d){return d[0];}%} | null
series_of_statements -> statement {%function(d){return d[0];}%} | series_of_statements _ statement {%function(d){return d[0] + "\n" + d[2];}%}

arithmetic_expression -> expression
boolean_expression -> expression
string_expression -> expression
array_expression -> expression

expression ->  accessArray | this | functionCall | varName | dictionary | declare_new_object
| parentheses_expression | string_to_int | add | subtract | multiply | mod | divide | number | pow | strlen | sin | cos | tan | sqrt | array_length
| String | concatenateString | substring | int_to_string | split | join
| initializerList
| false | true | not_equal | greaterThan | compareInts | strcmp | lessThanOrEqual | greaterThanOrEqual | lessThan | and | or | not | arrayContains

statement -> constructor | plusEquals | minusEquals | declare_constant | instance_method | static_method | initializeArray | print | comment | switch | setVar | initializeVar | func | functionCallStatement | return | if | while | forInRange
type -> boolean | int | string | auto | arrayType | void
caseStatements -> caseStatements _ case {%function(d){return d[0] +"\n"+ d[2];}%} | case
elifStatements -> elifStatements _ elif {%function(d){return d[0] +"\n"+ d[2];}%} | elif #Match a series of elif statements
elifOrElse -> else | elifStatements _ else {%function(d){return d[0] +"\n"+ d[2];}%} #Match a series of elif statements followed by else

parameterList -> _parameterList | null
_parameterList -> _parameterList _ parameter_separator _ parameter {%function(d){return d[0]+d[2]+d[4]}%}
| parameter
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
declare_constant -> "final" _ __ _ type _ __ _ varName _ "=" _ expression _ ";"{%function(d){
	return "(" + "setf" + " " + d[8] + " " + d[12] + ")";
}%}
true -> "true"{%function(d){
	return "t";
}%}
false -> "false"{%function(d){
	return "nil";
}%}
parentheses_expression -> "(" _ expression _ ")"{%function(d){
	return d[2];
}%}
greaterThan -> arithmetic_expression _ ">" _ arithmetic_expression{%function(d){
	return "(" + ">" + " " + d[0] + " " + d[4] + ")";
}%}
lessThan -> arithmetic_expression _ "<" _ arithmetic_expression{%function(d){
	return "(" + "<" + " " + d[0] + " " + d[4] + ")";
}%}
class -> "public" _ __ _ "class" _ __ _ identifier _ "{" _ series_of_statements _ "}"{%function(d){
	return d[12];
}%}
pow -> "Math" _ "." _ "pow" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return "(" + "expt" + " " + "num1" + " " + "num2" + ")";
}%}
_or -> arithmetic_expression _ "||" _ arithmetic_expression{%function(d){
	return d[0] + " " + d[4];
}%}
or -> _or{%function(d){
	return "(" + "or" + " " + d[0] + ")";
}%}
_and -> boolean_expression _ "&&" _ boolean_expression{%function(d){
	return d[0] + " " + d[4];
}%}
and -> _and{%function(d){
	return "(" + "and" + " " + d[0] + ")";
}%}
not -> "!" _ boolean_expression{%function(d){
	return "not" + " " + d[2];
}%}
_multiply -> arithmetic_expression _ "*" _ arithmetic_expression{%function(d){
	return d[0] + " " + d[4];
}%}
multiply -> _multiply{%function(d){
	return "(" + "*" + " " + d[0] + ")";
}%}
_divide -> arithmetic_expression _ "/" _ arithmetic_expression{%function(d){
	return d[0] + " " + d[4];
}%}
divide -> _divide{%function(d){
	return "(" + "/" + " " + d[0] + ")";
}%}
_add -> arithmetic_expression _ "+" _ arithmetic_expression{%function(d){
	return d[0] + " " + d[4];
}%}
add -> _add{%function(d){
	return "(" + "+" + " " + d[0] + ")";
}%}
_subtract -> arithmetic_expression _ "-" _ arithmetic_expression{%function(d){
	return d[0] + " " + d[4];
}%}
subtract -> _subtract{%function(d){
	return "(" + "-" + " " + d[0] + ")";
}%}
functionCall -> identifier _ "(" _ functionCallParameters _ ")"{%function(d){
	return "(" + d[0] + " " + d[4] + ")";
}%}
concatenateString -> string_expression _ "+" _ string_expression{%function(d){
	return "(" + "concatenate" + " " + "'string" + " " + d[0] + " " + d[4] + ")";
}%}
initializeVar -> type _ __ _ varName _ "=" _ expression _ ";"{%function(d){
	return "(" + "setf" + " " + d[4] + " " + d[8] + ")";
}%}
return -> "return" _ __ _ expression _ ";"{%function(d){
	return d[4];
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "public" _ __ _ "static" _ __ _ type _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "(defun" + " " + d[12] + "(" + d[16] + ")" + d[22] + ")";
}%}
if -> "if" _ "(" _ boolean_expression _ ")" _ "{" _ series_of_statements _ "}" _ elifOrElse{%function(d){
	return "(" + "cond" + "(" + d[4] + " " + d[10] + ")" + " " + d[14] + ")";
}%}
elif -> "else" _ __ _ "if" _ "(" _ boolean_expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "(" + d[8] + " " + d[14] + ")";
}%}
else -> "else" _ "{" _ series_of_statements _ "}"{%function(d){
	return "(" + "t" + " " + d[4] + ")";
}%}
while -> "while" _ "(" _ boolean_expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "(" + "loop" + " " + "while" + " " + d[4] + " " + "do" + " " + d[10] + ")";
}%}
print -> "System" _ "." _ "out" _ "." _ "println" _ "(" _ expression _ ")" _ ";"{%function(d){
	return "(" + "print" + " " + d[12] + ")";
}%}
comment -> "//" _ _string _ "\n"{%function(d){
	return ";" + d[2] + "\n";
}%}
mod -> arithmetic_expression _ "%" _ arithmetic_expression{%function(d){
	return "(" + "mod" + " " + d[0] + " " + d[4] + ")";
}%}
setVar -> varName _ "=" _ expression _ ";"{%function(d){
	return "(" + "setf" + " " + d[0] + " " + d[4] + ")";
}%}
parameter -> type _ __ _ varName{%function(d){
	return d[4];
}%}
int -> "int"{%function(d){
	return "integer";
}%}
functionCallStatement -> functionCall _ ";"{%function(d){
	return d[0];
}%}
greaterThanOrEqual -> arithmetic_expression _ ">=" _ arithmetic_expression{%function(d){
	return "(" + ">=" + " " + d[0] + " " + d[4] + ")";
}%}
lessThanOrEqual -> arithmetic_expression _ "<=" _ arithmetic_expression{%function(d){
	return "(" + "<=" + " " + d[0] + " " + d[4] + ")";
}%}
substring -> string_expression _ "." _ "substring" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return "(" + "subseq" + " " + d[0] + " " + d[8] + " " + d[12] + ")";
}%}
strcmp -> string_expression _ "." _ "equals" _ "(" _ string_expression _ ")"{%function(d){
	return "(" + "equal" + " " + d[0] + " " + d[8] + ")";
}%}
array_length -> array_expression _ "." _ "length"{%function(d){
	return "(" + "list-length" + " " + d[0] + ")";
}%}
strlen -> string_expression _ "." _ "length" _ "(" _ ")"{%function(d){
	return "(" + "length" + " " + d[0] + ")";
}%}
parameter_separator -> ","{%function(d){
	return " ";
}%}
