
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
	return ".TRUE.";
}%}
false -> "false"{%function(d){
	return ".FALSE.";
}%}
compareInts -> expression _ "==" _ expression{%function(d){
	return d[0] + ".eq." + d[4];
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
	return d[12];
}%}
this -> "this" _ "." _ varName{%function(d){
	return "";
}%}
pow -> "Math" _ "." _ "pow" _ "(" _ expression _ "," _ expression _ ")"{%function(d){
	return d[8] + "**" + d[12];
}%}
_or -> expression _ "||" _ expression{%function(d){
	return d[0] + ".OR." + d[4];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> expression _ "&&" _ expression{%function(d){
	return d[0] + ".AND." + d[4];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "!" _ expression{%function(d){
	return ".NOT." + d[2];
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
concatenateString -> expression _ "+" _ expression{%function(d){
	return d[0] + "//" + d[4];
}%}
initializeVar -> type _ __ _ varName _ "=" _ expression _ ";"{%function(d){
	return d[0] + "::" + d[4] + "=" + d[8];
}%}
return -> "return" _ __ _ expression _ ";"{%function(d){
	return "retval" + "=" + "a";
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "public" _ __ _ "static" _ __ _ type _ __ _ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "FUNC" + " " + d[12] + " " + "(" + d[16] + ")" + " " + "RESULT" + "(" + "retval" + ")" + " " + d[8] + "::" + "retval" + " " + d[22] + " " + "END" + " " + "FUNCTION" + " " + d[12];
}%}
if -> "if" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}" _ elifOrElse{%function(d){
	return "IF" + " " + d[4] + " " + "THEN" + " " + d[10] + " " + d[14] + " " + "END" + " " + "IF";
}%}
elif -> "else" _ __ _ "if" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "ELSE" + " " + "IF" + " " + d[8] + " " + "THEN" + " " + d[14];
}%}
else -> "else" _ "{" _ series_of_statements _ "}"{%function(d){
	return "ELSE" + " " + d[4];
}%}
while -> "while" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "WHILE" + " " + "(" + d[4] + ")" + " " + "DO" + " " + d[10] + " " + "ENDDO";
}%}
forInRange -> "for" _ "(" _ "int" _ varName _ "=" _ expression _ ";" _ varName _ "<" _ "endWith" _ ";" _ varName _ "++" _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "do" + " " + d[6] + "=" + d[10] + "," + d[NaN] + " " + d[30] + " " + "end" + " " + "do";
}%}
listComprehension -> _{%function(d){
	return "";
}%}
import -> "import" _ __ _ expression _ ";"{%function(d){
	return "USE" + " " + d[4];
}%}
print -> "System" _ "." _ "out" _ "." _ "println" _ "(" _ expression _ ")" _ ";"{%function(d){
	return "print" + " " + d[12];
}%}
comment -> "//" _ _string _ "\n"{%function(d){
	return "!" + d[2] + "\n";
}%}
mod -> expression _ "%" _ expression{%function(d){
	return "mod" + "(" + d[0] + "," + d[4] + ")";
}%}
setVar -> varName _ "=" _ expression _ ";"{%function(d){
	return d[0] + "=" + d[4];
}%}
parameter -> type _ __ _ varName{%function(d){
	return d[4];
}%}
boolean -> "boolean"{%function(d){
	return "LOGICAL";
}%}
int -> "int"{%function(d){
	return "INTEGER";
}%}
string -> "String"{%function(d){
	return "CHARACTER";
}%}
functionCallStatement -> functionCall _ ";"{%function(d){
	return d[0];
}%}
switch -> "switch" _ "(" _ expression _ ")" _ "{" _ caseStatements _ __ _ default _ "}"{%function(d){
	return "SELECT" + " " + "CASE" + "(" + d[4] + ")" + " " + d[10] + " " + d[14] + " " + "END" + " " + "SELECT";
}%}
case -> "case" _ __ _ expression _ ":" _ series_of_statements{%function(d){
	return "CASE" + "(" + d[4] + ")" + " " + d[8];
}%}
break -> "break;"{%function(d){
	return "";
}%}
default -> "default" _ ":" _ series_of_statements{%function(d){
	return "CASE" + " " + "DEFAULT" + " " + d[4];
}%}
substring -> expression _ "." _ "substring" _ "(" _ expression _ "," _ expression _ ")"{%function(d){
	return d[0] + "(" + d[8] + ":" + d[12] + ")";
}%}
strcmp -> expression _ "." _ "equals" _ "(" _ expression _ ")"{%function(d){
	return d[0] + "==" + d[8];
}%}
strlen -> expression _ "." _ "length" _ "(" _ ")"{%function(d){
	return "LEN" + "(" + d[0] + ")";
}%}
parameter_separator -> ","{%function(d){
	return ",";
}%}
