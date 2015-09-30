
#The following expressions are the same in every language.

chunk -> _ (_series_of_statements | class) _ {%function(d){return d[1][0];}%}
_series_of_statements -> series_of_statements _ statement {%function(d){return d[0] +"\n"+ d[2];}%} | statement {%function(d){return d[0];}%} | null
series_of_statements -> statement {%function(d){return d[0];}%} | series_of_statements _ statement {%function(d){return d[0] + "\n" + d[2];}%}
expression -> parentheses_expression | false | true | this | compareInts | lessThanOrEqual | greaterThanOrEqual | lessThan | greaterThan | number | String | varName | add | subtract | multiply | divide | mod | functionCall
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
	return "true";
}%}
false -> "False"{%function(d){
	return "false";
}%}
compareInts -> expression _ "=" _ expression{%function(d){
	return d[0] + "==" + d[4];
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
	return "public" + " " + "class" + " " + d[NaN] + "{" + d[12] + "}";
}%}
this -> _{%function(d){
	return "this" + "." + d[NaN];
}%}
pow -> expression _ "^" _ expression{%function(d){
	return "Math" + "." + "pow" + "(" + d[0] + "," + d[4] + ")";
}%}
_or -> expression _ "Or" _ expression{%function(d){
	return d[0] + "||" + d[4];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> expression _ "And" _ expression{%function(d){
	return d[0] + "&&" + d[4];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "Not" _ expression{%function(d){
	return "!" + d[2];
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
	return d[0] + "+" + d[4];
}%}
initializeVar -> "Dim" _ __ _ varName _ __ _ "As" _ __ _ type _ "=" _ expression{%function(d){
	return d[12] + " " + d[4] + "=" + d[16] + ";";
}%}
return -> "Return" _ "a"{%function(d){
	return "return" + " " + d[NaN] + ";";
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> "Function" _ identifier _ "(" _ parameterList _ ")" _ "As" _ type _ series_of_statements _ "End" _ "Function"{%function(d){
	return "public" + " " + "static" + " " + d[12] + " " + d[2] + "(" + d[6] + ")" + "{" + d[14] + "}";
}%}
if -> "If" _ __ _ expression _ __ _ series_of_statements _ __ _ elifOrElse{%function(d){
	return "if" + "(" + d[4] + ")" + "{" + d[8] + "}" + d[12];
}%}
elif -> "ElseIf" _ __ _ expression _ __ _ "Then" _ __ _ series_of_statements{%function(d){
	return "else" + " " + "if" + "(" + d[4] + ")" + "{" + d[12] + "}";
}%}
else -> "Else" _ __ _ series_of_statements{%function(d){
	return "else" + "{" + d[4] + "}";
}%}
while -> "While" _ __ _ expression _ __ _ series_of_statements _ __ _ "End" _ "While"{%function(d){
	return "while" + "(" + d[4] + ")" + "{" + d[8] + "}";
}%}
forInRange -> "For" _ __ _ varName _ __ _ "As" _ __ _ "Integer" _ "=" _ expression _ __ _ "To" _ __ _ "endWith" _ __ _ series_of_statements _ __ _ "Next"{%function(d){
	return "for" + "(" + "int" + d[4] + "=" + d[16] + ";" + d[4] + "<" + "endWith" + ";" + d[4] + "++" + ")" + "{" + d[28] + "}";
}%}
listComprehension -> _{%function(d){
	return "";
}%}
import -> "Imports" _ __ _ expression{%function(d){
	return "import" + " " + d[4] + ";";
}%}
print -> "System" _ "." _ "Console" _ "." _ "WriteLine" _ "(" _ expression _ ")"{%function(d){
	return "System" + "." + "out" + "." + "println" + "(" + d[12] + ")" + ";";
}%}
comment -> "'" _ _string _ "\n"{%function(d){
	return "//" + d[2] + "\n";
}%}
mod -> expression _ __ _ "Mod" _ __ _ expression{%function(d){
	return d[0] + "%" + d[8];
}%}
setVar -> varName _ "=" _ expression{%function(d){
	return d[0] + "=" + d[4] + ";";
}%}
parameter -> varName _ __ _ "as" _ __ _ type{%function(d){
	return d[8] + " " + d[0];
}%}
boolean -> "Boolean"{%function(d){
	return "boolean";
}%}
int -> "Integer"{%function(d){
	return "int";
}%}
string -> "String"{%function(d){
	return "String";
}%}
functionCallStatement -> functionCall{%function(d){
	return d[0] + ";";
}%}
_greaterThanOrEqual -> expression _ ">=" _ expression{%function(d){
	return d[0] + ">=" + d[4];
}%}
greaterThanOrEqual -> expression{%function(d){
	return d[0];
}%}
_lessThanOrEqual -> expression _ "<=" _ expression{%function(d){
	return d[0] + "<=" + d[4];
}%}
lessThanOrEqual -> expression{%function(d){
	return d[0];
}%}
switch -> "Select" _ __ _ "Case" _ __ _ expression _ __ _ caseStatements _ __ _ default _ __ _ "End" _ __ _ "Select"{%function(d){
	return "switch" + "(" + d[8] + ")" + "{" + d[12] + " " + d[16] + "}";
}%}
case -> "Case" _ __ _ expression _ __ _ series_of_statements{%function(d){
	return "case" + " " + d[4] + ":" + d[8];
}%}
break -> _{%function(d){
	return "break;";
}%}
default -> "Case" _ __ _ "Else" _ __ _ series_of_statements{%function(d){
	return "default" + ":" + d[8];
}%}
substring -> expression _ "." _ "Substring" _ "(" _ expression _ "," _ expression _ ")"{%function(d){
	return d[0] + "." + "substring" + "(" + d[8] + "," + d[12] + ")";
}%}
strcmp -> expression _ "=" _ expression{%function(d){
	return d[0] + "." + "equals" + "(" + d[4] + ")";
}%}
strlen -> "Len" _ "(" _ expression _ ")"{%function(d){
	return d[4] + "." + "length" + "(" + ")";
}%}
parameter_separator -> ","{%function(d){
	return ",";
}%}
