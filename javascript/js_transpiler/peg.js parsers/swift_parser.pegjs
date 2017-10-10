top_level_statements = _ head:top_level_statement tail:top_level_statements {return ["top_level_statements",head,tail]} / _ a:top_level_statement _ {return a;}

top_level_statement = a:statement {return ["top_level_statement",a];}

statements = _ head:statement tail:statements {return ["statements",head,tail]} / _ a:statement _ {return a;}

case_statements = head:case _ tail:case_statements {return ["statements",head,tail]} / a:case {return a;}

case = "default:" _ a:statements {return ["default",a];} / "case" _ a:expr _ ":" _ b:statements {return ["case",a,b];}

statement = a:statement_with_semicolon {return ["semicolon",a];} / while / do_while / switch / if_statements / function / class / interface / enum / for / foreach

switch = "switch" _ "(" _ a:expr _ ")" _ "{" _  b:case_statements _ "}" {return ["switch",a,b];}

foreach = "for" _ "(" _ a:type __ b:var_name _ ":" _ c:var_name _ ")" _ "{" _ d:statements _ "}" {return ["foreach",a,b,c,d];}
for = "for" _ "(" _ a:statement_with_semicolon _ ";" _  b:expr _ ";" _ c:statement_with_semicolon  _ "){" _ d:statements _ "}" {return ["for",a,b,c,d];}

function = "func" __ b:var_name _ "(" _ c:parameters _ ")" _ "->" _ a:type  _ "{" d:statements "}" {return ["function","public",a,b[1],c,d];}
while = "while" _ "(" _ a:expr _ ")" _ "{" b:statements "}" {return  ["while",a,b];} / "while" _ "(" _ a:expr _ ")" _ b:statement_with_semicolon _ ";" {return  ["while",a,b];}
do_while = "do" _ "{" b:statements "}" _ "while" _ "(" _ a:expr _ ")" _ ";" {return  ["do_while",a,b];}

if_statements =
	"if" _ "(" _ a:expr _ ")" _ b:statement_with_semicolon _ ";" _ c:elif {return ["if_statements",a,b,c]} /
	"if" _ "(" _ a:expr _ ")" _ "{" _ b:statements _ "}" _ c:elif {return ["if_statements",a,b,c]} / "if" _ "(" _ a:expr _ ")" _ "{" _ b:statements _ "}" {return ["if_statement",a,b];} /
	"if" _ "(" _ a:expr _ ")" _ "{" b:statements "}" {return  ["if",a,b];} / "if" _ "(" _ a:expr _ ")" _ b:statement_with_semicolon _ ";" {return  ["if",a,b];}
elif = "else" __ "if" _ "(" _ a:expr _ ")" _ "{" b:statements "}" _ c:elif {return  ["else if",a,b,c];} / "else" __ "if" _ "(" _ a:expr _ ")" _ b:statement_with_semicolon ";" _ c:elif {return  ["else if",a,b,c];} / "else" _ "{" a:statements "}" {return  ["else",a];} / "else" __ a:statement_with_semicolon _ ";" {return  ["else",a];}

access_modifier = "public" / "private"

class =
	mod:access_modifier __ "class" __ a:var_name _ "{" _ b:class_statements _ "}" {return ["class",mod,a,b];} /
	mod:access_modifier __ "class" __ a:var_name __ "extends" __ b:var_name _ "{" _ c:class_statements _ "}" {return ["class_extends",mod,a,b,c];} /
	mod:access_modifier __ "class" __ a:var_name __ "implements" __ b:var_name _ "{" _ c:class_statements _ "}" {return ["class_implements",mod,a,b,c];} /
	mod:access_modifier __ "class" __ a:var_name __ "extends" __ b:var_name __ "implements" __ c:var_name _ "{" _ d:class_statements _ "}" {return ["class_extends_and_implements",mod,a,b,c,d];} /
	mod:access_modifier __ "abstract" __ "class" __ a:var_name _ "{" _ b:class_statements _ "}" {return ["abstract_class",mod,a,b];}

interface = mod:access_modifier __ "interface" __ a:var_name _ "{" _ b:interface_statements _ "}" {return ["interface",mod,a,b];}

enum = mod:access_modifier __ "enum" __ a:var_name _ "{" _ b:enum_statements _ "}" {return ["enum",mod,a,b];}
class_statements = _ head:class_statement tail:class_statements {return ["statements",head,tail]} / _ a:class_statement _ {return a;}


class_statement =
		mod:access_modifier __ a:var_name _ "(" _ b:parameters _ ")" _ "{" _ c:statements _ "}" {return ["constructor",a,b,c];} /
		mod:access_modifier __ a:type __ b:var_name "(" _ c:parameters _ ")" _ "{" d:statements "}" {return ["instance_method",mod,a,b[1],c,d];} /
		mod:access_modifier __ "static" __ a:type __ b:var_name "(" _ c:parameters _ ")" _ "{" d:statements "}" {return ["static_method",mod,a,b[1],c,d];} /
		mod:access_modifier __ a:type __ b:var_name _ "=" _ c:expr _ ";" {return ["member_variable",mod,a,b,c];} /
		mod:access_modifier __ "static" __ a:type __ b:var_name _ "=" _ c:expr _ ";" {return ["static_member_variable",mod,a,b,c];} /
		mod:access_modifier __ a:type __ b:var_name _ ";" {return ["empty_member_variable",mod,a,b];}

interface_statements = _ head:interface_statement tail:interface_statements {return ["statements",head,tail]} / _ a:interface_statement _ {return a;}

interface_statement =
	mod:access_modifier __ a:type __ b:var_name _ "(" _ c:parameters _ ")" _ ";" {return ["interface_instance_method",mod,a,b,c];} /
	mod:access_modifier __ "static" __ a:type __ b:var_name _ "(" _ c:parameters _ ")" _ ";" {return ["interface_static_method",mod,a,b,c];}
	

statement_with_semicolon =
	"var" __ b:var_name _ ":" _ a:type _ "=" _ c:expr {return ["initialize_var",a,b,c]} /
	"var" __ b:var_name _ ":" _ a:type {return ["initialize_empty_var",a,b]} /
	"var" __ b:var_name _ "=" _ c:expr {return ["initialize_var","Object",b,c]} /
	"var" __ b:var_name {return ["initialize_empty_var","Object",b]} /
	name:(access_array / this / var_name) _ "=" _ exp:expr {return ["set_var",name,exp]} /
	name:var_name _ symbol:("++" / "--") {return [symbol,name];} /
	name:var_name _ symbol:("*=" / "+=" / "-=" / "/=") _ exp:expr {return [symbol,name,exp];} /
	"trace" _ "(" _ a:expr _ ")" {return ["println",a];} / 
	"return" __ a:expr {return ["return",a];}


scalar_type = a:("void"/"Int" {return "int";}/"double"/"String"/"char"/"Bool" {return "boolean";}/"float"/"Object")
type = scalar_type "[]" / scalar_type / type1:("ArrayList" / "List") "<" a:type ">" {return [type1,a];} / type1:("Map" / "HashMap") "<" a:type "," b:type ">" {return [type1,a,b];}

function_call_parameters = a:expr _ "," _ b:function_call_parameters {return [a].concat(b);} / a:expr {return [a];} / "";
access_array_parameters = a:expr _ "][" _ b:access_array_parameters {return [a].concat(b);} / a:expr {return [a];} / "";


enum_statements = a:enum_statement _ "," _ b:enum_statements {return [a].concat(b);} / a:enum_statement {return [a];} / "";

enum_statement = a:var_name_ {return ["enum_statement",a];}

parameters = a:parameter _ "," _ b:parameters {return [a].concat(b);} / a:parameter {return [a];} / "";
parameter = b:var_name _ ":" _ a:type  {return [a,b[1]]};

expr = instanceof / cmp_expr


instanceof = a:add_expr __ "instanceof" __ b:type {return ["instanceof",a,b];}
cmp_expr = a:add_expr _ symbol:(">=" / "<=" / ">" / "<" / "==" / "!=" / "||" / "&&") _ b:add_expr {return [symbol,a,b];} / add_expr

add_expr
  = head:term _ symbol:("+" / "-") _ tail:add_expr {
    return	[symbol,head,tail];
    } / term

term
  = head:factor _ symbol:("*" / "/") _ tail:term {
    return	[symbol,head,tail];
    } / dot_expr

dot_expr =
	"Arrays" _ "." _ "asList" _ "(" _ a:expr _ ")" _ "." _ "contains" _ "(" _ b:expr _ ")" {return ["array_contains",a,b]} /
	a:factor "." _ "getClass" _ "." _ "isArray" _ "(" _ ")" {return ["is_array",a];} /
	a:factor "." _ "getClass" _ "(" _ ")" {return ["getClass",a];} /
	a:factor "." _ "split" _ "(" _ b:function_call_parameters _ ")" {return ["split",a,b];} /
	"Math" _ "." _ "pow" _ "(" _ a:expr _ "," _ b:expr _ ")" { return ["pow",a,b]; } /
	"Math" _ "." _ "floor" _ "(" _ a:expr _ ")" { rnurn ["floor",a]; } /
	"Math" _ "." _ "ceiling" _ "(" _ a:expr _ ")" { return ["ceiling",a]; } /
	a:factor _ "." _ "startsWith" _ "(" _ b:expr _ ")" { return ["startsWith",a,b]; } /
	a:factor _ "." _ "endsWith" _ "(" _ b:expr _ ")" { return ["endsWith",a,b]; } /
	//type conversions
	"Integer" _ "." _ "parseInt" _ "(" _ a:expr _ ")" {return ["convert","String","int",a];}
	/ "Double" _ "." _ "parseDouble" _ "(" a:expr _ ")" {return ["convert","String","double",a];}
	/ "Double" _ "." _ "valueOf" _ "(" a:expr _ ")" {return ["convert","String","double",a];}
	/ "new" __ "Double" _ "(" _ a:expr _ ")" _ "." _ "doubleValue" _ "(" _ ")" {return ["convert","String","double",a];}
	/ "String" _ "." _ "valueOf" _ "(" a:expr _ ")" {return ["convert","int","String",a];}
	/ "String" _ "." _ "format" _ "(" _ "%d" _ "," _ a:expr _ ")" {return ["convert","int","String",a];}
    / "new" __ "Integer" _ "(" _ a:expr _ ")" _ "." _ "toString" _ "(" _ ")" {return ["convert","int","String",a];}	
    / "Integer" _ "." _ "toString" _ "(" _ a:expr _ ")" {return ["convert","int","String",a];} /
	
	a:factor _ "." _ "equals" _ "(" _ b:factor _ ")" {return ["strcmp",a,b];} /
	a:factor _ "." _ "length" _ "(" _ ")" {return ["string_length",a];} /
	a:factor _ "." _ "length" {return ["array_length",a];} /
	"Math" _ "." _ name:("sin"/"cos"/"tan"/"asin"/"acos"/"atan"/"sqrt") _ "(" _ a:expr _ ")" {return [name,a];} /
	a:factor _ "." _ "replace" _ "(" _ b:expr _ "," _ c:expr _ ")" {return ["string_replace",a,b,c];} /
	a:factor _ "." _ "substring" _ "(" _ b:expr _ "," _ c:expr _ ")" {return ["substring",a,b,c];}/
	a:factor _ "." _ b:function_call {return ["method_call",a,b];} /
	"!" a:dot_expr {return ["not",a];} /
	this /
	factor






this = "this" _ "." _ a:factor {return ["this",a];}




factor
  = "(" _ expr:expr _ ")" { return expr; }
  / number / "true" / "false" / access_array / function_call / var_name / string_literal / initializer_list

access_array = a:var_name _ "[" _ b:access_array_parameters _ "]" {return ["access_array",a,b];}
function_call = a:var_name _ "(" _ b:function_call_parameters _ ")" {return ["function_call",a,b];}

initializer_list = "{" _ "}" {return ["initializer_list",[]];} / "{" a:initializer_list_ "}" {return ["initializer_list",a];}
initializer_list_ = a:expr _ "," _ b:initializer_list_ {return [a].concat(b);} / a:expr {return [a];}

number "number" =  [0-9]+ "." [0-9]+ {return ["number", text()];} / decimal

decimal "decimal" = positive_integer "." integer { return ["number", text()]; } / integer

integer "integer"
  = positive_integer / "-" positive_integer { return ["number", text()]; }

positive_integer = [0-9]+ { return ["number", text()]; }

true = "true"
false = "false"

var_name = a:var_name_ {return ["var_name", a];}
var_name_ = [a-zA-Z0-9_]+ {return text();}
string_literal = "\"\"" {return ["string_literal",text()];} /
 "\"" (("\\\"" / [a-zA-Z0-9_ \\\>|<\[\]\t\n\r\?\!\$\#\@\%\&\*\^\.\,\'\;\/\:\`\~\{\}\=\+\(\)\-])+) "\"" {return ["string_literal", text()];}


_ "whitespace"
  = [ \t\n\r]*

__ "whitespace"
  = [ \t\n\r] _
