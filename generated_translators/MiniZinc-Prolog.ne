
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
class -> series_of_statements{%function(d){
	return d[0];
}%}
this -> _{%function(d){
	return "";
}%}
pow -> "pow" _ "(" _ expression _ "," _ expression _ ")"{%function(d){
	return "";
}%}
_or -> expression _ "\\/" _ expression{%function(d){
	return d[0] + ";" + d[4];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> expression _ "/\\" _ expression{%function(d){
	return d[0] + "," + d[4];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "not" _ expression{%function(d){
	return "\\+" + d[2];
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
	return d[0] + "(" + d[4] + ")";
}%}
concatenateString -> expression _ "++" _ expression{%function(d){
	return "";
}%}
initializeVar -> type _ ":" _ varName _ "=" _ expression _ ";"{%function(d){
	return d[4] + "=" + d[8];
}%}
return -> expression{%function(d){
	return d[0];
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "function" _ __ _ type _ ":" _ identifier _ "(" _ parameterList _ ")" _ "=" _ series_of_statements _ ";"{%function(d){
	return d[8] + "(" + d[12] + ")" + ":-" + d[18] + ".";
}%}
if -> "if" _ __ _ expression _ __ _ "then" _ __ _ series_of_statements _ __ _ elifOrElse _ __ _ "endif"{%function(d){
	return "(" + d[4] + "->" + d[12] + ";" + d[16] + ")";
}%}
elif -> "else" _ __ _ "if" _ __ _ expression _ __ _ "then" _ __ _ series_of_statements _ __ _ "endif"{%function(d){
	return d[8] + "->" + d[16] + ";";
}%}
else -> "else" _ __ _ series_of_statements{%function(d){
	return d[4];
}%}
while -> _{%function(d){
	return "";
}%}
predicate -> "predicate" _ __ _ identifier _ "(" _ parameterList _ ")" _ "=" _ series_of_statements _ ";"{%function(d){
	return d[4] + "(" + d[8] + ")" + ":-" + d[14] + ".";
}%}
forInRange -> _{%function(d){
	return "";
}%}
listComprehension -> "[" _ expression _ "|" _ varName _ __ _ "in" _ __ _ expression _ __ _ "where" _ __ _ expression _ "]"{%function(d){
	return "";
}%}
import -> "include" _ __ _ "\'" _ expression _ ".mzn\'" _ ";"{%function(d){
	return ":-" + "consult(" + d[6] + ")" + ".";
}%}
print -> _{%function(d){
	return "write" + "(" + d[NaN] + ")";
}%}
comment -> "%" _ _string _ "\n"{%function(d){
	return "%" + d[2] + "\n";
}%}
mod -> expression _ __ _ "mod" _ __ _ expression{%function(d){
	return "mod" + "(" + d[0] + "," + d[8] + ")";
}%}
setVar -> type _ ":" _ varName _ "=" _ expression _ ";"{%function(d){
	return d[4] + "=" + d[8];
}%}
parameter -> "var" _ __ _ type _ ":" _ varName{%function(d){
	return d[8];
}%}
boolean -> "bool"{%function(d){
	return "atom";
}%}
int -> "int"{%function(d){
	return "integer";
}%}
string -> "string"{%function(d){
	return "string";
}%}
functionCallStatement -> functionCall _ ";"{%function(d){
	return d[0];
}%}
switch -> _{%function(d){
	return "";
}%}
case -> _{%function(d){
	return "";
}%}
break -> _{%function(d){
	return "";
}%}
default -> _{%function(d){
	return "";
}%}
substring -> _{%function(d){
	return "";
}%}
strcmp -> expression _ "==" _ expression{%function(d){
	return d[0] + "=" + d[4];
}%}
strlen -> "length" _ "(" _ expression _ ")"{%function(d){
	return "";
}%}
parameter_separator -> ","{%function(d){
	return ",";
}%}
