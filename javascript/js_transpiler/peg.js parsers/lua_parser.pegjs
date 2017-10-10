top_level_statements = _ head:top_level_statement tail:top_level_statements {return ["top_level_statements",head,tail]} / _ a:top_level_statement _ {return a;}
top_level_statement = a:statement {return ["top_level_statement",a];}

statements = _ a:statement _ {return a;} /  _ head:statement tail:statements {return ["statements",head,tail]}

case_statements = head:case _ tail:case_statements {return ["statements",head,tail]} / a:case {return a;}

case = "default:" _ a:statements {return ["default",a];} / "case" _ a:expr _ ":" _ b:statements {return ["case",a,b];}

statement =  while / if_statements / function / foreach / a:statement_with_semicolon {return ["semicolon",a];}

foreach = "for" _ "(" _ a:type __ b:var_name _ ":" _ c:var_name _ ")" _ "{" _ d:statements _ "}" {return ["foreach",a,b,c,d];}
for = "for" _ "(" _ a:statement_with_semicolon _ ";" _  b:expr _ ";" _ c:statement_with_semicolon  _ "){" _ d:statements _ "}" {return ["for",a,b,c,d];}

function = "function" __ b:var_name _ "(" _ c:parameters _ ")" __ d:statement __ end_token {return ["function","public","Object",b[1],c,d];}
while = "while" __ a:dot_expr __ "do" __ b:statements __ end_token {return  ["while",a,b];}
do_while = "do" _ "{" b:statements "}" _ "while" _ "(" _ a:expr _ ")" _ ";" {return  ["do_while",a,b];}

if_statements =
	"if" __ a:expr __ "then" __ b:statements __ c:elif __ end_token {return ["if_statements",a,b,c]} /
	"if" _ "(" _ a:expr _ ")" __ "then" __ b:statements __ end_token {return  ["if_statement",a,b];}

elif = "elseif" _ "(" _ a:expr _ ")" _ "then" __ b:statements __ c:elif {return  ["else if",a,b,c];} / "else" __ "if" _ "(" _ a:expr _ ")" _ b:statement_with_semicolon ";" _ c:elif {return  ["else if",a,b,c];} / "else" __ a:statements {return  ["else",a];}

end_token = "end" !var_name

statement_with_semicolon =
	"return" __ a:expr {return ["return",a];} /
	"local" __ b:var_name _ "=" _ c:expr {return ["initialize_var","Object",b,c]} /
	"local" __ b:var_name {return ["initialize_empty_var","Object",b]} /
	name:(access_array / this / var_name) _ "=" _ exp:expr {return ["set_var",name,exp]} /
	name:var_name _ symbol:("++" / "--") {return [symbol,name];} /
	name:var_name _ symbol:("*=" / "+=" / "-=" / "/=") _ exp:expr {return [symbol,name,exp];} /
	"print" _ "(" _ a:expr _ ")" {return ["println",a];}


scalar_type = a:("number"/"string")
type = scalar_type

function_call_parameters = a:expr _ "," _ b:function_call_parameters {return [a].concat(b);} / a:expr {return [a];} / "";
access_array_parameters = a:expr _ "][" _ b:access_array_parameters {return [a].concat(b);} / a:expr {return [a];} / "";

parameters = a:parameter _ "," _ b:parameters {return [a].concat(b);} / a:parameter {return [a];} / "";
parameter = b:var_name {return ["Object",b[1]]};

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
var_name_ =  !end_token [a-zA-Z0-9_]+ {return text();}
string_literal = "\"\"" {return ["string_literal",text()];} /
 "\"" (("\\\"" / [a-zA-Z0-9_ \\\>|<\[\]\t\n\r\?\!\$\#\@\%\&\*\^\.\,\'\;\/\:\`\~\{\}\=\+\(\)\-])+) "\"" {return ["string_literal", text()];}


_ "whitespace"
  = [ \t\n\r]*

__ "whitespace"
  = [ \t\n\r] _
