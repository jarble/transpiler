
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

series_of_statements -> statement {%function(d){return d[0];}%} | series_of_statements statement_separator __ statement {%function(d){return d[0] + d[1] + "\n" + d[3];}%}

dot_notation -> dot_notation _dot_notation identifier {%function(d){ return d[0] + d[1] + d[2] }%} | identifier

arithmetic_expression -> expression
boolean_expression -> expression
string_expression -> expression
array_expression -> expression

statement_with_semicolon -> statement_without_semicolon _ semicolon {% function(d){return d[0] + d[2]; }%}

expression -> string_to_regex | accessArray | this | functionCall | varName | dictionary | declare_new_object
| parentheses_expression | pi | natural_logarithm | absolute_value | floor | ceiling | string_to_int | add | subtract | multiply | mod | divide | number | pow | strlen | asin | acos | atan | sin | cos | tan | sqrt | array_length
| String | concatenateString | substring | int_to_string | split | join | startswith | endswith | globalReplace
| initializerList | range
| false | true | instanceof | not_equal | greaterThan | compareInts | strcmp | lessThanOrEqual | greaterThanOrEqual | lessThan | and | or | not | arrayContains | stringContains

statement_without_semicolon -> typeless_variable_declaration | setVar | increment | decrement | initializeEmptyVar | initializeVar | typeless_initializeVar | functionCall | exception | return | functionCallStatement | plusEquals | minusEquals | declare_constant | initializeArray | print
statement ->   func | statement_with_semicolon | for_loop | typeless_function | comment | switch | if | while | forInRange

class_statement_without_semicolon -> initialize_static_variable_with_value | initialize_instance_variable_with_value | initialize_static_variable | initialize_instance_variable
class_statement_with_semicolon -> class_statement_without_semicolon _ semicolon {% function(d){return d[0] + d[2]; }%}
class_statement -> constructor | instance_method | static_method | comment | class_statement_with_semicolon

_class_statements -> class_statements _ class_statement {%function(d){return d[0] +"\n"+ d[2];}%} | class_statement {%function(d){return d[0];}%} | null
class_statements -> class_statement {%function(d){return d[0];}%} | class_statements _ class_statement {%function(d){return d[0] + "\n" + d[2];}%}


type -> boolean | int | double | string | auto | arrayType | void | dictionary_type
caseStatements -> caseStatements _ case {%function(d){return d[0] +"\n"+ d[2];}%} | case
elifOrElse -> else | elif

parameterList -> _parameterList | null
_parameterList -> _parameterList _ parameter_separator _ ( parameter | default_parameter ) {%function(d){return d[0]+d[2]+d[4]}%}
| (parameter | default_parameter )

typeless_parameters -> _typeless_parameters | null
_typeless_parameters -> _typeless_parameters _ parameter_separator _ typeless_parameter {%function(d){return d[0]+d[2]+d[4]}%}
| typeless_parameter

functionCallParameters -> functionCallParameters _ function_call_parameter_separator _ ( expression | function_call_named_parameter) {% function(d) {return d.join(""); } %} | (expression | function_call_named_parameter) | null

keyValueList -> _keyValueList
_keyValueList -> _keyValueList _ keyValueSeparator _ keyValue {%function(d){return d[0]+d[2]+d[4]}%}
| keyValue

_initializerList -> _initializerList _ initializerListSeparator _ expression {%function(d){return d[0]+d[2]+d[4]}%}
| expression

array_access_list -> array_access_index | array_access_list array_access_separator array_access_index {%function(d){return d[0]+d[1]+d[2]}%}

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
increment -> expression _ "++"{%function(d){
	return d[0] + "" + "++";
}%}
decrement -> expression _ "--"{%function(d){
	return d[0] + "" + "--";
}%}
floor -> "floor" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "floor" + "" + "(" + "" + d[4] + "" + ")";
}%}
ceiling -> "ceil" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "ceil" + "" + "(" + "" + d[4] + "" + ")";
}%}
absolute_value -> "abs" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "abs" + "" + "(" + "" + d[4] + "" + ")";
}%}
natural_logarithm -> "log" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "log" + "" + "(" + "" + d[4] + "" + ")";
}%}
asin -> "asin" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "asin" + "" + "(" + "" + d[4] + "" + ")";
}%}
acos -> "acos" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "acos" + "" + "(" + "" + d[4] + "" + ")";
}%}
atan -> "atan" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "atan" + "" + "(" + "" + d[4] + "" + ")";
}%}
endswith -> "(" _ "strstr" _ "(" _ expression _ "," _ expression _ ")" _ "!=" _ "NULL" _ ")"{%function(d){
	return d[6] + "" + "." + "" + "endsWith" + "" + "(" + "" + d[10] + "" + ")";
}%}
statement_separator -> _{%function(d){
	return "";
}%}
for_loop -> "int" __ statement_without_semicolon _ ";" _ "for" _ "(" _ statement_without_semicolon _ ";" _ expression _ ";" _ statement_without_semicolon _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "for" + "" + "(" + "" + d[2] + "" + ";" + "" + d[14] + "" + ";" + "" + d[18] + "" + ")" + "" + "{" + "" + d[24] + "" + "}";
}%}
function_call_parameter_separator -> ","{%function(d){
	return ",";
}%}
string_to_int -> "atoi" _ "(" _ expression _ ")"{%function(d){
	return "Integer" + "" + "." + "" + "parseInt" + "" + "(" + "" + d[4] + "" + ")";
}%}
declare_constant -> "static" __ "const" __ varName _ "=" _ expression{%function(d){
	return "final" + " " + d[undefined] + " " + d[4] + "" + "=" + "" + d[8];
}%}
initializeArray -> arrayType __ identifier _ "=" _ array_expression{%function(d){
	return d[0] + " " + d[2] + "" + "=" + "" + d[6];
}%}
array_access_separator -> "]["{%function(d){
	return "][";
}%}
array_access_index -> expression{%function(d){
	return d[0];
}%}
accessArray -> identifier _ "[" _ array_access_list _ "]"{%function(d){
	return d[0] + "" + "[" + "" + d[4] + "" + "]";
}%}
arrayType -> type _ "[]"{%function(d){
	return d[0] + "" + "[]";
}%}
initializerListSeparator -> ","{%function(d){
	return ",";
}%}
initializerList -> "{" _ _initializerList _ "}"{%function(d){
	return "{" + "" + d[2] + "" + "}";
}%}
charAt -> expression _ "[" _ expression _ "]"{%function(d){
	return d[0] + "" + "." + "" + "charAt" + "" + "(" + "" + d[4] + "" + ")";
}%}
void -> "void"{%function(d){
	return "void";
}%}
sin -> "sin" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "sin" + "" + "(" + "" + d[4] + "" + ")";
}%}
sqrt -> "sqrt" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "sqrt" + "" + "(" + "" + d[4] + "" + ")";
}%}
cos -> "cos" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "cos" + "" + "(" + "" + d[4] + "" + ")";
}%}
tan -> "tan" _ "(" _ expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "tan" + "" + "(" + "" + d[4] + "" + ")";
}%}
true -> "true"{%function(d){
	return "true";
}%}
false -> "false"{%function(d){
	return "false";
}%}
compareInts -> arithmetic_expression _ "==" _ arithmetic_expression{%function(d){
	return d[0] + "" + "==" + "" + d[4];
}%}
parentheses_expression -> "(" _ expression _ ")"{%function(d){
	return "(" + "" + d[2] + "" + ")";
}%}
greaterThan -> arithmetic_expression _ ">" _ arithmetic_expression{%function(d){
	return d[0] + "" + ">" + "" + d[4];
}%}
lessThan -> arithmetic_expression _ "<" _ arithmetic_expression{%function(d){
	return d[0] + "" + "<" + "" + d[4];
}%}
class_extends -> "#include" __ "'" _ identifier _ ".h'" _ "\n" _ class_statements{%function(d){
	return "public" + " " + "class" + " " + d[undefined] + " " + "extends" + " " + d[4] + "" + "{" + "" + d[10] + "" + "}";
}%}
pow -> "pow" _ "(" _ arithmetic_expression _ "," _ arithmetic_expression _ ")"{%function(d){
	return "Math" + "" + "." + "" + "pow" + "" + "(" + "" + d[4] + "" + "," + "" + d[8] + "" + ")";
}%}
_or -> arithmetic_expression _ "||" _ arithmetic_expression{%function(d){
	return d[0] + "" + "||" + "" + d[4];
}%}
or -> _or{%function(d){
	return d[0];
}%}
_and -> boolean_expression _ "&&" _ boolean_expression{%function(d){
	return d[0] + "" + "&&" + "" + d[4];
}%}
and -> _and{%function(d){
	return d[0];
}%}
not -> "!" _ boolean_expression{%function(d){
	return "!" + "" + d[2];
}%}
_multiply -> arithmetic_expression _ "*" _ arithmetic_expression{%function(d){
	return d[0] + "" + "*" + "" + d[4];
}%}
multiply -> _multiply{%function(d){
	return d[0];
}%}
_divide -> arithmetic_expression _ "/" _ arithmetic_expression{%function(d){
	return d[0] + "" + "/" + "" + d[4];
}%}
divide -> _divide{%function(d){
	return d[0];
}%}
_add -> arithmetic_expression _ "+" _ arithmetic_expression{%function(d){
	return d[0] + "" + "+" + "" + d[4];
}%}
add -> _add{%function(d){
	return d[0];
}%}
_subtract -> arithmetic_expression _ "-" _ arithmetic_expression{%function(d){
	return d[0] + "" + "-" + "" + d[4];
}%}
subtract -> _subtract{%function(d){
	return d[0];
}%}
functionCall -> dot_notation _ "(" _ functionCallParameters _ ")"{%function(d){
	return d[0] + "" + "(" + "" + d[4] + "" + ")";
}%}
double -> "double"{%function(d){
	return "double";
}%}
initializeVar -> type __ varName _ "=" _ expression{%function(d){
	return d[0] + " " + d[2] + "" + "=" + "" + d[6];
}%}
return -> "return" __ expression{%function(d){
	return "return" + " " + d[2];
}%}
varName -> identifier{%function(d){
	return d[0];
}%}
func -> type __ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "public" + " " + "static" + " " + d[0] + " " + d[2] + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}";
}%}
if -> "if" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}" _ elifOrElse{%function(d){
	return "if" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + "" + "}" + "" + d[14];
}%}
elif -> "else" __ "if" _ "(" _ expression _ ")" _ "{" _ series_of_statements _ "}" _ elifOrElse{%function(d){
	return "else" + " " + "if" + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}" + "" + d[16];
}%}
plusEquals -> expression _ "+=" _ expression{%function(d){
	return d[0] + "" + "+=" + "" + d[4];
}%}
minusEquals -> expression _ "-=" _ expression{%function(d){
	return d[0] + "" + "-=" + "" + d[4];
}%}
else -> "else" _ "{" _ series_of_statements _ "}"{%function(d){
	return "else" + "" + "{" + "" + d[4] + "" + "}";
}%}
while -> "while" _ "(" _ boolean_expression _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "while" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + "" + "}";
}%}
forInRange -> "int" __ varName _ ";" _ "for" _ "(" _ varName _ "=" _ arithmetic_expression _ ";" _ varName _ "<" _ arithmetic_expression _ ";" _ varName _ "++" _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "for" + "" + "(" + "" + "int" + " " + d[2] + "" + "=" + "" + d[14] + "" + ";" + "" + d[2] + "" + "<" + "" + d[22] + "" + ";" + "" + d[2] + "" + "++" + "" + ")" + "" + "{" + "" + d[34] + "" + "}";
}%}
import -> "#include" __ "\"" _ expression _ ".h\""{%function(d){
	return "import" + " " + d[4] + "" + ";";
}%}
print -> "printf" _ "(" _ expression _ ")"{%function(d){
	return "System" + "" + "." + "" + "out" + "" + "." + "" + "println" + "" + "(" + "" + d[4] + "" + ")";
}%}
comment -> "//" _ _string{%function(d){
	return "//" + "" + d[2];
}%}
mod -> arithmetic_expression _ "%" _ arithmetic_expression{%function(d){
	return d[0] + "" + "%" + "" + d[4];
}%}
semicolon -> ";"{%function(d){
	return ";";
}%}
setVar -> varName _ "=" _ expression{%function(d){
	return d[0] + "" + "=" + "" + d[4];
}%}
parameter -> type __ varName{%function(d){
	return d[0] + " " + d[2];
}%}
_dot_notation -> "->"{%function(d){
	return ".";
}%}
initializeEmptyVar -> type __ varName{%function(d){
	return d[0] + " " + d[2];
}%}
boolean -> "bool"{%function(d){
	return "boolean";
}%}
int -> "int"{%function(d){
	return "int";
}%}
string -> "char*"{%function(d){
	return "String";
}%}
functionCallStatement -> functionCall _ semicolon{%function(d){
	return d[0] + "" + d[2];
}%}
greaterThanOrEqual -> arithmetic_expression _ ">=" _ arithmetic_expression{%function(d){
	return d[0] + "" + ">=" + "" + d[4];
}%}
lessThanOrEqual -> arithmetic_expression _ "<=" _ arithmetic_expression{%function(d){
	return d[0] + "" + "<=" + "" + d[4];
}%}
switch -> "switch" _ "(" _ expression _ ")" _ "{" _ caseStatements __ default _ "}"{%function(d){
	return "switch" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + " " + d[12] + "" + "}";
}%}
case -> "case" __ expression _ ":" _ series_of_statements _ "break" _ ";"{%function(d){
	return "case" + " " + d[2] + "" + ":" + "" + d[6] + "" + "break" + "" + ";";
}%}
default -> "default" _ ":" _ series_of_statements{%function(d){
	return "default" + "" + ":" + "" + d[4];
}%}
substring -> _{%function(d){
	return d[undefined] + "" + "." + "" + "substring" + "" + "(" + "" + d[undefined] + "" + "," + "" + d[undefined] + "" + ")";
}%}
strcmp -> "strcmp" _ "(" _ string_expression _ "," _ string_expression _ ")" _ "==" _ "0"{%function(d){
	return d[4] + "" + "." + "" + "equals" + "" + "(" + "" + d[8] + "" + ")";
}%}
array_length -> "sizeof" _ "(" _ array_expression _ ")" _ "/" _ "sizeof" _ "(" _ array_expression _ "[" _ "0" _ "]" _ ")"{%function(d){
	return d[4] + "" + "." + "" + "length";
}%}
strlen -> "strlen" _ "(" _ string_expression _ ")"{%function(d){
	return d[4] + "" + "." + "" + "length" + "" + "(" + "" + ")";
}%}
parameter_separator -> ","{%function(d){
	return ",";
}%}
not_equal -> expression _ "!=" _ expression{%function(d){
	return d[0] + "" + "!=" + "" + d[4];
}%}
instance_method -> _{%function(d){
	return "public" + " " + d[undefined] + " " + d[undefined] + "" + "(" + "" + d[undefined] + "" + ")" + "" + "{" + "" + d[undefined] + "" + "}";
}%}
static_method -> type __ identifier _ "(" _ parameterList _ ")" _ "{" _ series_of_statements _ "}"{%function(d){
	return "public" + " " + "static" + " " + d[0] + " " + d[2] + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}";
}%}
declare_new_object -> _{%function(d){
	return d[undefined] + " " + d[undefined] + "" + "=" + "" + "new" + " " + d[undefined] + "" + "(" + "" + d[undefined] + "" + ")";
}%}
