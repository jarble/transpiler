
#The following expressions are the same in every language.

chunk -> _ (_series_of_statements | class) _ {%function(d){return d[1][0];}%}
_series_of_statements -> series_of_statements _ statement {%function(d){return d[0] +"\n"+ d[2];}%} | statement {%function(d){return d[0];}%} | null
series_of_statements -> statement {%function(d){return d[0];}%} | series_of_statements _ statement {%function(d){return d[0] + "\n" + d[2];}%}
expression -> parentheses_expression | false | true | this | compareInts | lessThan | greaterThan | number | String | varName | add | subtract | multiply | divide | mod | functionCall
statement -> print | comment | switch | setVar | initializeVar | func | functionCallStatement | return | if | while | forInRange
type -> boolean | int | string
caseStatements -> caseStatements _ case {%function(d){return d[0] +"\n"+ d[2];}%} | case
elifStatements -> elifStatements _ elif {%function(d){return d[0] +"\n"+ d[2];}%} | elif #Match a series of elif statements
elifOrElse -> else | elifStatements _ else {%function(d){return d[0] +"\n"+ d[2];}%} #Match a series of elif statements followed by else
parameterList -> _parameterList | null
_parameterList -> _parameterList _ parameter_separator _ parameter {%function(d){return d[0]+d[2]+d[4]}%}
| parameter
functionCallParameters -> functionCallParameters _ parameter_separator _ expression | expression | null

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
true -> "true"{%function(d){
	return "true";
}%}
false -> "false"{%function(d){
	return "false";
}%}
compareInts -> expression _ "==" _ expression{%function(d){
	return d[0] + "=" + d[4];
}%}
parentheses_expression -> "(" _ expression _ ")"{%function(d){
	return "(" + d[2] + ")";
}%}
greaterThan -> expression _ ">" _ expression{%function(d){
	return d[0] + ">" + d[4];
}%}
lessThan -> expression _ "<" _ expression{%function(d){
	return d[0] + "<" + d[4];
}%}
class -> "public" _ __ _ "class" _ __ _ identifier _ "{" _ series_of_statements _ "}"{%function(d){
	return "a:" + " " + "make" + " " + "object!" + "[" + d[12] + "]";
}%}
this -> "this" _ "." _ varName{%function(d){
	return "self" + "/" + d[4];
}%}
pow -> "Math" _ "." _ "pow" _ "(" _ expression _ "," _ expression _ ")"{%function(d){
	return "power" + " " + d[8] + " " + d[12];
}%}
_or -> expression _ "||" _ expression{%function(d){
	return d[0] + " " + "or" + " " + d[4];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> expression _ "&&" _ expression{%function(d){
	return d[0] + " " + "and" + " " + d[4];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "!" _ expression{%function(d){
	return "not" + d[2];
}%}
_multiply -> expression _ "*" _ expression{%function(d){
	return d[0] + "*" + d[4];
}%}
multiply -> _multiply{%function(d){
	return d[0];
}%}
_divide -> expression _ "/" _ expression{%function(d){
	return d[0] + "/" + d[4];
}%}
divide -> _divide{%function(d){
	return d[0];
}%}
_add -> expression _ "+" _ expression{%function(d){
	return d[0] + "+" + d[4];
}%}
add -> _add{%function(d){
	return d[0];
}%}
subtract -> expression _ "-" _ expression{%function(d){
	return d[0] + "-" + d[4];
}%}
functionCall -> identifier _ "(" _ functionCallParameters _ ")"{%function(d){
	return d[0] + " " + d[4];
}%}
concatenateString -> expression _ "+" _ expression{%function(d){
	return "append" + " " + d[0] + " " + d[4];
}%}
initializeVar -> type _ __ _ varName _ "=" _ expression _ ";"{%function(d){
	return d[4] + ":" + d[8];
}%}
return -> "return" _ __ _ expression _ ";"{%function(d){
	return "return" + " " + d[4];
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "public" _ __ _ "static" _ __ _ type _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return d[12] + ":" + " " + "func" + "[" + d[16] + "]" + "[" + d[22] + "]";
}%}
if -> "if" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}" _ elifOrElse{%function(d){
	return "case" + "[" + d[4] + "[" + d[10] + "]" + d[14] + "]";
}%}
elif -> "else" _ __ _ "if" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return d[8] + "[" + d[14] + "]";
}%}
else -> "else" _ "{" _ series_of_statements _ "}"{%function(d){
	return "true" + "[" + d[4] + "]";
}%}
while -> "while" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "while" + "[" + d[4] + "]" + "[" + d[10] + "]";
}%}
forInRange -> "for" _ "(" _ "int" _ varName _ "=" _ expression _ ";" _ varName _ "<" _ "endWith" _ ";" _ varName _ "++" _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "for" + " " + d[6] + " " + d[10] + " " + "endWith" + " " + "1" + "[" + d[30] + "]";
}%}
listComprehension -> _{%function(d){
	return "";
}%}
import -> "import" _ __ _ expression _ ";"{%function(d){
	return d[4] + ":" + " " + "load" + " " + "%" + d[4] + ".r";
}%}
print -> "System" _ "." _ "out" _ "." _ "println" _ "(" _ expression _ ")" _ ";"{%function(d){
	return "print" + " " + d[12];
}%}
comment -> "//" _ _string _ "\n"{%function(d){
	return "comment" + "[" + d[2] + "]";
}%}
mod -> expression _ "%" _ expression{%function(d){
	return "mod" + " " + d[0] + " " + d[4];
}%}
setVar -> varName _ "=" _ expression _ ";"{%function(d){
	return d[0] + ":" + " " + d[4];
}%}
parameter -> type _ __ _ varName{%function(d){
	return d[0] + "[" + d[4] + "]";
}%}
boolean -> "boolean"{%function(d){
	return "logic!";
}%}
int -> "int"{%function(d){
	return "integer!";
}%}
string -> "String"{%function(d){
	return "string!";
}%}
functionCallStatement -> functionCall _ ";"{%function(d){
	return d[0];
}%}
switch -> "switch" _ "(" _ expression _ ")" _ "{" _ caseStatements _ __ _ default _ "}"{%function(d){
	return "switch/default" + "[" + d[4] + " " + d[10] + "]";
}%}
case -> "case" _ __ _ expression _ ":" _ series_of_statements{%function(d){
	return d[4] + "[" + d[8] + "]";
}%}
break -> "break;"{%function(d){
	return "";
}%}
default -> "default" _ ":" _ series_of_statements{%function(d){
	return "][" + d[4];
}%}
substring -> expression _ "." _ "substring" _ "(" _ expression _ "," _ expression _ ")"{%function(d){
	return "copy/part" + " " + "skip" + " " + d[0] + " " + d[8] + " " + d[12];
}%}
strcmp -> expression _ "." _ "equals" _ "(" _ expression _ ")"{%function(d){
	return d[0] + "==" + d[8];
}%}
strlen -> expression _ "." _ "length" _ "(" _ ")"{%function(d){
	return "length?" + " " + d[0];
}%}
parameter_separator -> ","{%function(d){
	return " ";
}%}
