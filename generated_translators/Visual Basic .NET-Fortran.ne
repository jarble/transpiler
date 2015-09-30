
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
true -> "True"{%function(d){
	return ".TRUE.";
}%}
false -> "False"{%function(d){
	return ".FALSE.";
}%}
compareInts -> expression _ "=" _ expression{%function(d){
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
class -> "Public" _ __ _ "Class" _ __ _ "name" _ __ _ series_of_statements _ __ _ "End" _ "Class"{%function(d){
	return d[12];
}%}
this -> _{%function(d){
	return "";
}%}
pow -> expression _ "^" _ expression{%function(d){
	return d[0] + "**" + d[4];
}%}
_or -> expression _ "Or" _ expression{%function(d){
	return d[0] + ".OR." + d[4];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> expression _ "And" _ expression{%function(d){
	return d[0] + ".AND." + d[4];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "Not" _ expression{%function(d){
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
concatenateString -> expression _ "&" _ expression{%function(d){
	return d[0] + "//" + d[4];
}%}
initializeVar -> "Dim" _ __ _ varName _ __ _ "As" _ __ _ type _ "=" _ expression{%function(d){
	return d[12] + "::" + d[4] + "=" + d[16];
}%}
return -> "Return" _ "a"{%function(d){
	return "retval" + "=" + "a";
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "Function" _ identifier _ "(" _ parameterList _ ")" _ "As" _ type _ series_of_statements _ "End" _ "Function"{%function(d){
	return "FUNC" + " " + d[2] + " " + "(" + d[6] + ")" + " " + "RESULT" + "(" + "retval" + ")" + " " + d[12] + "::" + "retval" + " " + d[14] + " " + "END" + " " + "FUNCTION" + " " + d[2];
}%}
if -> "If" _ __ _ expression _ __ _ series_of_statements _ __ _ elifOrElse{%function(d){
	return "IF" + " " + d[4] + " " + "THEN" + " " + d[8] + " " + d[12] + " " + "END" + " " + "IF";
}%}
elif -> "ElseIf" _ __ _ expression _ __ _ "Then" _ __ _ series_of_statements{%function(d){
	return "ELSE" + " " + "IF" + " " + d[4] + " " + "THEN" + " " + d[12];
}%}
else -> "Else" _ __ _ series_of_statements{%function(d){
	return "ELSE" + " " + d[4];
}%}
while -> "While" _ __ _ expression _ __ _ series_of_statements _ __ _ "End" _ "While"{%function(d){
	return "WHILE" + " " + "(" + d[4] + ")" + " " + "DO" + " " + d[8] + " " + "ENDDO";
}%}
forInRange -> "For" _ __ _ varName _ __ _ "As" _ __ _ "Integer" _ "=" _ expression _ __ _ "To" _ __ _ "endWith" _ __ _ series_of_statements _ __ _ "Next"{%function(d){
	return "do" + " " + d[4] + "=" + d[16] + "," + d[NaN] + " " + d[28] + " " + "end" + " " + "do";
}%}
listComprehension -> _{%function(d){
	return "";
}%}
import -> "Imports" _ __ _ expression{%function(d){
	return "USE" + " " + d[4];
}%}
print -> "System" _ "." _ "Console" _ "." _ "WriteLine" _ "(" _ expression _ ")"{%function(d){
	return "print" + " " + d[12];
}%}
comment -> "'" _ _string _ "\n"{%function(d){
	return "!" + d[2] + "\n";
}%}
mod -> expression _ __ _ "Mod" _ __ _ expression{%function(d){
	return "mod" + "(" + d[0] + "," + d[8] + ")";
}%}
setVar -> varName _ "=" _ expression{%function(d){
	return d[0] + "=" + d[4];
}%}
parameter -> varName _ __ _ "as" _ __ _ type{%function(d){
	return d[0];
}%}
boolean -> "Boolean"{%function(d){
	return "LOGICAL";
}%}
int -> "Integer"{%function(d){
	return "INTEGER";
}%}
string -> "String"{%function(d){
	return "CHARACTER";
}%}
functionCallStatement -> functionCall{%function(d){
	return d[0];
}%}
switch -> "Select" _ __ _ "Case" _ __ _ expression _ __ _ caseStatements _ __ _ default _ __ _ "End" _ __ _ "Select"case -> "Case" _ __ _ expression _ __ _ series_of_statements{%function(d){
	return "CASE" + "(" + d[4] + ")" + " " + d[8];
}%}
break -> _{%function(d){
	return "";
}%}
default -> "Case" _ __ _ "Else" _ __ _ series_of_statements{%function(d){
	return "CASE" + "DEFAULT" + " " + d[8];
}%}
substring -> expression _ "." _ "Substring" _ "(" _ expression _ "," _ expression _ ")"{%function(d){
	return d[0] + "(" + d[8] + ":" + d[12] + ")";
}%}
strcmp -> expression _ "=" _ expression{%function(d){
	return d[0] + "==" + d[4];
}%}
strlen -> "Len" _ "(" _ expression _ ")"{%function(d){
	return "LEN" + "(" + d[4] + ")";
}%}
parameter_separator -> ","{%function(d){
	return ",";
}%}
