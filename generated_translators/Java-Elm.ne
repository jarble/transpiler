
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

statement_without_semicolon -> _setVar | _initializeVar | _return | functionCall
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

statement ->   func | for_loop | typeless_function | typeless_variable_declaration | plusEquals | minusEquals | declare_constant | initializeArray | print | comment | switch | setVar | initializeVar | functionCallStatement | return | if | while | forInRange | exception
class_statement -> constructor | initialize_static_variable_with_value | initialize_instance_variable_with_value | initialize_static_variable | initialize_instance_variable | instance_method | static_method | comment

_class_statements -> class_statements _ class_statement {%function(d){return d[0] +"\n"+ d[2];}%} | class_statement {%function(d){return d[0];}%} | null
class_statements -> class_statement {%function(d){return d[0];}%} | class_statements _ class_statement {%function(d){return d[0] + "\n" + d[2];}%}


type -> boolean | int | string | auto | arrayType | void
caseStatements -> caseStatements _ case {%function(d){return d[0] +"\n"+ d[2];}%} | case
elifStatements -> elifStatements _ elif {%function(d){return d[0] +"\n"+ d[2];}%} | elif #Match a series of elif statements
elifOrElse -> else | elifStatements _ else {%function(d){return d[0] +"\n"+ d[2];}%} #Match a series of elif statements followed by else

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

array_access_list -> arithmetic_expression | array_access_list array_access_separator arithmetic_expression {%function(d){return d[0]+d[1]+d[2]}%}

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
