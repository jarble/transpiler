top_level_statements = _ head:top_level_statement tail:top_level_statements {return ["top_level_statements",head,tail]} / _ a:top_level_statement _ {return a;}

top_level_statement = a:statement {return ["top_level_statement",a];}

statements = _ head:statement tail:statements {return ["statements",head,tail]} / _ a:statement _ {return a;}

case_statements = head:case _ tail:case_statements {return ["statements",head,tail]} / a:case {return a;}

case = "default:" _ a:statements {return ["default",a];} / "case" _ a:expr _ ":" _ b:statements {return ["case",a,b];}

statement = a:statement_with_semicolon _ ";" {return ["semicolon",a];} / while / do_while / switch / if_statements / function / for

switch = "switch" _ "(" _ a:expr _ ")" _ "{" _  b:case_statements _ "}" {return ["switch",a,b];}

foreach = "for" _ "(" _ a:type __ b:var_name _ ":" _ c:var_name _ ")" _ "{" _ d:statements _ "}" {return ["foreach",a,b,c,d];}
for = "for" _ "(" _ a:statement_with_semicolon _ ";" _  b:expr _ ";" _ c:statement_with_semicolon  _ "){" _ d:statements _ "}" {return ["for",a,b,c,d];}

function = a:type __ b:var_name _ "(" _ c:parameters _ ")" _ "{" d:statements "}" {return ["function","public",a,b[1],c,d];}
while = "while" _ "(" _ a:expr _ ")" _ "{" b:statements "}" {return  ["while",a,b];} / "while" _ "(" _ a:expr _ ")" _ b:statement_with_semicolon _ ";" {return  ["while",a,b];}
do_while = "do" _ "{" b:statements "}" _ "while" _ "(" _ a:expr _ ")" _ ";" {return  ["do_while",a,b];}

if_statements =
	"if" _ "(" _ a:expr _ ")" _ b:statement_with_semicolon _ ";" _ c:elif {return ["if_statements",a,b,c]} /
	"if" _ "(" _ a:expr _ ")" _ "{" _ b:statements _ "}" _ c:elif {return ["if_statements",a,b,c]} / "if" _ "(" _ a:expr _ ")" _ "{" _ b:statements _ "}" {return ["if_statement",a,b];} /
	"if" _ "(" _ a:expr _ ")" _ "{" b:statements "}" {return  ["if",a,b];} / "if" _ "(" _ a:expr _ ")" _ b:statement_with_semicolon _ ";" {return  ["if",a,b];}
elif = "else" __ "if" _ "(" _ a:expr _ ")" _ "{" b:statements "}" _ c:elif {return  ["else if",a,b,c];} / "else" __ "if" _ "(" _ a:expr _ ")" _ b:statement_with_semicolon ";" _ c:elif {return  ["else if",a,b,c];} / "else" _ "{" a:statements "}" {return  ["else",a];} / "else" __ a:statement_with_semicolon _ ";" {return  ["else",a];}

statement_with_semicolon =
	a:scalar_type __ b:var_name _ "=" _ c:expr {return ["initialize_var",a,b,c]} /
	a:scalar_type __ b:var_name _ "[]" _ "=" _ c:expr {return ["initialize_var",[a,"[]"],b,c]} /
	a:type __ b:var_name {return ["initialize_empty_var",a,b]} /
	a:scalar_type __ b:var_name _ "[]" {return ["initialize_empty_var",[a,"[]"],b]} /
	name:(access_array / var_name) _ "=" _ exp:expr {return ["set_var",name,exp]} /
	name:var_name _ symbol:("++" / "--") {return [symbol,name];} /
	name:var_name _ symbol:("*=" / "+=" / "-=" / "/=") _ exp:expr {return [symbol,name,exp];} /
	"printf" _ "(" _ ("\"%" ("d" / "s" / "f") "\\n\"") _ "," _ a:expr _ ")" {return ["println",a];} /
	"printf" _ "(" _ ("\"%" ("d" / "s" / "f") "\"") _ "," _ a:expr _ ")" {return ["print",a];} /
	"return" __ a:expr {return ["return",a];}


scalar_type = a:("void"/"int"/"double"/("char*"/"char[]") {return "String";}/"char"/"bool"{return ["boolean"];}/"float")
type = scalar_type "[]" / scalar_type

function_call_parameters = a:expr _ "," _ b:function_call_parameters {return [a].concat(b);} / a:expr {return [a];} / "";
access_array_parameters = a:expr _ "][" _ b:access_array_parameters {return [a].concat(b);} / a:expr {return [a];} / "";


enum_statements = a:enum_statement _ "," _ b:enum_statements {return [a].concat(b);} / a:enum_statement {return [a];} / "";

enum_statement = a:var_name_ {return ["enum_statement",a];}

parameters = a:parameter _ "," _ b:parameters {return [a].concat(b);} / a:parameter {return [a];} / "";
parameter = a:type __ b:var_name {return [a,b[1]]};

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
	"pow" _ "(" _ a:expr _ "," _ b:expr _ ")" { return ["pow",a,b]; } /
	"floor" _ "(" _ a:expr _ ")" { rnurn ["floor",a]; } /
	"ceil" _ "(" _ a:expr _ ")" { return ["ceiling",a]; } /
	"strlen" _ "(" _ a:factor _ ")" {return ["string_length",a];} /
	name:("sin"/"cos"/"tan"/"asin"/"acos"/"atan"/"sqrt") _ "(" _ a:expr _ ")" {return [name,a];} /
	"!" a:dot_expr {return ["not",a];} /
	factor




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
