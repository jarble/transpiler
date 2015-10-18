
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
functionCallParameters -> functionCallParameters _ parameter_separator _ expression {% function(d) {return d.join(""); } %} | expression | null

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
int_to_string -> "Integer" _ "." _ "toString" _ "(" _ expression _ ")"{%function(d){
	return "(" + "show" + " " + d[8] + ")";
}%}
split -> expression _ "." _ "split" _ "(" _ expression _ ")"{%function(d){
	return "(" + "splitOn" + " " + d[0] + " " + d[8] + ")";
}%}
string_to_int -> "Integer" _ "." _ "parseInt" _ "(" _ expression _ ")"{%function(d){
	return "(" + "read" + " " + d[8] + ")";
}%}
declare_constant -> "final" _ __ _ type _ __ _ varName _ "=" _ expression _ ";"{%function(d){
	return d[8] + "=" + d[12] + "\n";
}%}
initializeArray -> arrayType _ __ _ identifier _ "=" _ array_expression _ ";"{%function(d){
	return d[4] + "=" + d[8] + "\n";
}%}
accessArray -> identifier _ "[" _ arithmetic_expression _ "]"{%function(d){
	return "(a" + "!!" + "b)";
}%}
initializerListSeparator -> ","{%function(d){
	return ",";
}%}
initializerList -> "{" _ _initializerList _ "}"{%function(d){
	return "[" + d[2] + "]";
}%}
sin -> "Math" _ "." _ "sin" _ "(" _ expression _ ")"{%function(d){
	return "(" + "sin" + " " + d[8] + ")";
}%}
cos -> "Math" _ "." _ "cos" _ "(" _ expression _ ")"{%function(d){
	return "(" + "cos" + " " + d[8] + ")";
}%}
tan -> "Math" _ "." _ "tan" _ "(" _ expression _ ")"{%function(d){
	return "(" + "tan" + d[8] + ")";
}%}
true -> "true"{%function(d){
	return "True";
}%}
false -> "false"{%function(d){
	return "False";
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
class -> "public" _ __ _ "class" _ __ _ identifier _ "{" _ series_of_statements _ "}"{%function(d){
	return d[12];
}%}
arrayContains -> "Arrays" _ "." _ "asList" _ "(" _ array_expression _ ")" _ "." _ "contains" _ "(" _ expression _ ")"{%function(d){
	return "(" + "elem" + " " + d[18] + " " + d[8] + ")";
}%}
pow -> "Math" _ "." _ "pow" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return d[8] + "**" + d[12];
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
	return "not" + d[2];
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
	return "(" + d[0] + " " + d[4] + ")";
}%}
concatenateString -> string_expression _ "+" _ string_expression{%function(d){
	return d[0] + "++" + d[4];
}%}
initializeVar -> type _ __ _ varName _ "=" _ expression _ ";"{%function(d){
	return d[4] + "=" + d[8] + "\n";
}%}
return -> "return" _ __ _ expression _ ";"{%function(d){
	return d[4];
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "public" _ __ _ "static" _ __ _ type _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return d[12] + " " + d[16] + "=" + "\n" + d[22];
}%}
if -> "if" _ "(" _ boolean_expression _ ")" _ "{" _ series_of_statements _ "}" _ elifOrElse{%function(d){
	return "if" + " " + d[4] + " " + "then" + " " + d[10] + " " + d[14];
}%}
elif -> "else" _ __ _ "if" _ "(" _ boolean_expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "else" + " " + "if" + " " + d[8] + " " + "then" + " " + d[14] + " " + "c";
}%}
else -> "else" _ "{" _ series_of_statements _ "}"{%function(d){
	return "else" + " " + d[4];
}%}
import -> "import" _ __ _ expression _ ";"{%function(d){
	return "import" + " " + d[4];
}%}
print -> "System" _ "." _ "out" _ "." _ "println" _ "(" _ expression _ ")" _ ";"{%function(d){
	return "(" + "putStrLn" + " " + d[12] + ")";
}%}
comment -> "//" _ _string _ "\n"{%function(d){
	return "--" + d[2] + "\n";
}%}
mod -> arithmetic_expression _ "%" _ arithmetic_expression{%function(d){
	return d[0] + " " + "mod" + " " + d[4];
}%}
setVar -> varName _ "=" _ expression _ ";"{%function(d){
	return d[0] + "=" + d[4] + "\n";
}%}
parameter -> type _ __ _ varName{%function(d){
	return d[4];
}%}
boolean -> "boolean"{%function(d){
	return "Bool";
}%}
int -> "int"{%function(d){
	return "Num";
}%}
string -> "String"{%function(d){
	return "String";
}%}
functionCallStatement -> functionCall _ ";"{%function(d){
	return d[0] + ";";
}%}
greaterThanOrEqual -> arithmetic_expression _ ">=" _ arithmetic_expression{%function(d){
	return d[0] + ">=" + d[4];
}%}
lessThanOrEqual -> arithmetic_expression _ "<=" _ arithmetic_expression{%function(d){
	return d[0] + "<=" + d[4];
}%}
switch -> "switch" _ "(" _ expression _ ")" _ "{" _ caseStatements _ __ _ default _ "}"{%function(d){
	return "case" + " " + d[4] + " " + "of" + " " + d[10] + " " + d[14] + " " + "end";
}%}
case -> "case" _ __ _ expression _ ":" _ series_of_statements _ "break" _ ";"{%function(d){
	return d[4] + " " + "->" + "\n" + d[8];
}%}
default -> "default" _ ":" _ series_of_statements{%function(d){
	return "\_" + "->" + "\n" + " " + d[4];
}%}
substring -> string_expression _ "." _ "substring" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return "take" + "(" + d[12] + "-" + d[8] + ")" + "." + "drop" + d[8] + "$" + d[0];
}%}
strcmp -> string_expression _ "." _ "equals" _ "(" _ string_expression _ ")"{%function(d){
	return d[0] + "==" + d[8];
}%}
array_length -> array_expression _ "." _ "length"{%function(d){
	return "(" + "length" + " " + d[0] + ")";
}%}
strlen -> string_expression _ "." _ "length" _ "(" _ ")"{%function(d){
	return "(" + "length" + d[0] + ")";
}%}
parameter_separator -> ","{%function(d){
	return " ";
}%}
