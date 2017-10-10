/*
 * Simple Arithmetics Grammar
 * ==========================
 *
 * Accepts expressions like "2 * (3 + 4)" and computes their value.
 */

top_level_statements =
	a:top_level_statement "." _ b:top_level_statements {return ["statements",a,b]} /
    a:top_level_statement "." {return a;}


top_level_statement = predicate / dcg / function_call


predicate = a:var_name _ "(" _ b:initializer_list_ _ ")" _ ":-" _ c:expr {return ["predicate",a,b,c];}
dcg = a:var_name _ "(" _ b:initializer_list_ _ ")" _ "-->" _ c:expr {return ["dcg",a,b,c];}


set_var =
	a:factor _ "=" _ b:expr {return ["=",a,b];}


mul_expr = a:factor _ b:("*" / "/") _ c:mul_expr {return [b,a,c];} / factor
cmp_expr =
	a:add_expr _ b:(">=" / "=<" / ">" / "<" / "=") _ c:add_expr {return [b,a,c];} / add_expr
and_expr = 	a:cmp_expr _ b:(",") _ c:and_expr {return [b,a,c];} / cmp_expr
or_expr = 	a:and_expr _ b:(";") _ c:or_expr {return [b,a,c];} / and_expr

add_expr =
	a:mul_expr _ b:("+" / "-") _ c:add_expr {return [b,a,c];} / mul_expr


expr = set_var / or_expr / factor

function_call = a:var_name _ "(" _ b: _ ")" {return ["function_call",a,b];}

initializer_list_ = a:factor _ "," _ b:initializer_list_ {return [a,b];} / factor

factor
  = "(" _ a:expr _ ")" { return a; }
  / "[" _ a:initializer_list_ _ "]" {return ["[",a,"]"];}
  / var_name / integer / string_literal
  
integer "integer"
  = [0-9]+ { return parseInt(text(), 10); }
var_name = [a-zA-Z0-9\_]+ {return ["var_name", text()];}
string_literal = "\"" ("\\\"" / [a-zA-Z0-9_ \\\>|<\[\]\t\n\r\?\!\$\#\@\%\&\*\^\.\,\'\;\/\:\`\~\{\}\=\+\(\)\-])+ "\"" {return ["string_literal", text()];}


_ "whitespace"
  = [ \t\n\r]*
__ "whitespace"
  = [ \t\n\r] [ \t\n\r]*
