
expressions = statements_

statements_ = a1:statement _ a2:statements_ {return a1+a2;} / statement

class_statements = class_statements_ / "" {return "";}
statements= statements_


class_statements_= a1:class_statement _ a2:class_statements_ {return a1 + a2;} / class_statement
access_modifier= "public" / "private"

class_=
	"class" __ a2:IDENTIFIER _ "{" _ a4:class_statements _ "}" {return ["class ",a2,"{",a4,"}"].join("");}
	/ "trait" __ a2:IDENTIFIER _ "{" _ a4:class_statements _ "}" {return ["trait","public",a2,a4];}
	/ "class" __ a2:IDENTIFIER __ "extends" __ a4:IDENTIFIER _ "{" _ class_statements _ "}" {return ["class ",a2," extends ",a4,"{",a6,"}"].join();}
	/ "class" __ a2:IDENTIFIER __ "implements" __ a4:identifiers _ "{" _ a6:class_statements _ "}" {return ["class_implements","public",a2,a4,a6];}

statement
    =
    a1:statement_with_semicolon _ ";" {return a1+";";}
    / class_
    / "while" _ "(" _ a3:e _ ")" _ a5:bracket_statements {return ["while(",a3,"){",a5,"}"].join("");}
    / "do" _ a2:bracket_statements _ "while" _ "(" _ a5:e _ ")" _ ";" {return ["do ",a2," while(",a5,");"].join("");}
    / "switch" _ "(" _ a3:e _ ")" _ "{" _ a6:case_statements _ "}" {return ["switch(",a3,"){",a6,"}"].join("");}
    / "for" _ "(" _ a3:statement_with_semicolon _ ";" _ a5:e _ ";" _ a7:statement_with_semicolon _ ")" _ a9:bracket_statements {return ["for(",a3,";",a5,";",a7,"){",a9,"}"].join("");}
    / "foreach" _ "(" _ a3:var_name __ "as" __ a5:var_name _ "=>" _ a7:var_name _ ")" _ a9:bracket_statements {return ["foreach_with_index","Object",a5,a7,a3,a9];}
    / "foreach" _ "(" _ a3:var_name __ "as" __ a5:var_name _ ")" _ a7:bracket_statements {return ["for(",a3," in ",a5,"){",a7,"}"].join("");}
    / "if" _ "(" _ a3:e _ ")" _ a5:bracket_statements _ a6:elif {return ["if(",a3,"){",a5,"}",a6].join("");}
	/ "if" _ "(" _ a3:e _ ")" _ a5:bracket_statements {return ["if(",a3,"){",a5,"}"].join("");}
    / "function" __ a2:IDENTIFIER _ "(" _ a4:parameters _ ")" "{" a7:statements "}" {return ["function ",a2,"(",a4,"){",a7,"}"].join("");}
    

identifiers= a1:IDENTIFIER _ "," _ a3:identifiers {return [a1].concat(a3);} / IDENTIFIER

case_statement= "case" __ a2:e _ ":" _ a4:statements _ "break" _ ";" {return ["case ",a2,":",a4].join("")}
case_statements_= a1:case_statement _ a2:case_statements_ {return a1+a2;} / case_statement
case_statements= a1:case_statements_ _ "default" _ ":" _ a4:statements {return a1+["default:",a4].join("")} / case_statements_;

class_statement=
	a1:access_modifier _ "static" __ "function" _ a4:IDENTIFIER _ "(" _ a6:parameters _ ")" _ "{" _ a9:statements _ "}" {return ["static ",a4,"(",a6,"){",a9,"}"].join("");}
	/ a1:access_modifier _ "function" _ a3:IDENTIFIER _ "(" _ a5:parameters _ ")" _ "{" _ a8:statements _ "}" {return [a3,"(",a5,"){",a8,"}"].join("");}

statement_with_semicolon
   = 
   "return" _ a2:e  {return ["return ",a2].join("");}
   / "return"  {return "return";}
   / "continue"  {return "continue";}
   / a1:dot_expr _ a2:"=" _ a3:e {return [a1,a2,a3].join("");}
   / a1:dot_expr _ a2:("++" / "--") {return [a1,a2].join("");}
   / a1:dot_expr _ a2:("+=" / "%=" / "-=" / "*=" / "/=") _ a3:e {return [a1,a2,a3].join("");}
   / dot_expr

e
    =
     a1:e6 _ "?" _ a3:e6 _ ":" _ a5:e {return a1+"?"+a3+":"+a5;}
    / a1:"..." _ a2:e6 {return "..." + a2;}
    /e6

e6= a1:e5 _ a2:('||' / 'or') _ a3:e6
        {return [a1,a2,a3].join("");}
    /e5

e5=
    a1:e4 _ a2:('&&'/'and') _ a3:e5
        {return [a1,a2,a3].join("");}
    / e4

e4=
    a1:e3 _ a2:('!==') _ a3:e4
        {return [a1,a2,a3].join("");}
    /a1:e3 _ a2:'===' a3:e4
        {return [a1,"===",a3].join("");}
    /a1:e3 _ a2:('<='/'<'/'>='/'>') _ a3:e4
        {return [a1,a2,a3].join("");}
    / e3

e3=
    a1:e2 _ a2:('>>'/'<<') _ a3:e3
        {return [a1,a2,a3].join("");}
    / e2

e2= a1:e1 _ a2:('+'/'-') _ a3:e2
        {return [a1,a2,a3].join("");}
    / e1

e1= a1:not_expr _ a2:('*' / '/' / '%') _ a3:e1
        {return [a1,a2,a3].join("");}
    / '-' _ a2:e1
        {return ["-",a2].join("");}
    / not_expr

not_expr= a1:"!" _ a2:dot_expr {return "!"+a2;} / dot_expr

dot_expr= a1:parentheses_expr _ a2:"->" _ a3:parentheses_expr {return a1+"->"+a3} / parentheses_expr
parentheses_expr =
    "new" _ "class" _ "{" _ a4:statements _ "}" {return ["new class{",a4,"}"].join("")}
    / function_call
    / callable

function_call = a1:callable _ a2:function_call_ {return a1+a2;}
function_call_ = a1:function_call__ _ a2:function_call_ {return a1+a2;} / function_call__
function_call__ = "[" _ a2:exprs _ "]" {return "["+a2+"]";} / "(" _ a2:exprs _ ")" {return "("+a2+")";} / "(" _ ")" {return "()"}

callable=
	"function" "(" _ a3:parameters _ ")" _ "{" _ a6:statements _ "}" {return ["function(",a3,"){",a6,"}"].join("")}
	/ var_name
    / IDENTIFIER
    / STRING_LITERAL
    / '(' _ a2:e _ ')' {return "("+a2+")";}
    / "[" _ "]" {return "[]";} / "[" a2:exprs "]" {return "["+a2+"]";}
    / NUMBER

parameter= a1:var_name {return a1;} / "&" _ a2:var_name {return ["&", a2].join("");} / a1:var_name _ "=" _ a3:e {return [a1,"=",a3].join("");}
parameters= a1:parameter _ "," _ a3:parameters {return [a1].concat(a3);} / parameter / "" {return "";}

exprs= a1:e _ "," _ a3:exprs {return a1+","+a3;} / e
else_if= "else" _ "if" / "elseif";
elif= a1:else_if _ "(" _ a3:e _ ")" _ a5:bracket_statements _ a6:elif {return ["else if(",a3,"){",a5,"}",a6].join("")} / a1:else_if "(" a3:e ")" bracket_statements {return ["elif",a3,a5]} / "else" bracket_statements {return ["else ",a2].join("");}
var_name= "$" a2:IDENTIFIER {return a2;}
var_names= a1:var_name _ "," _ a3:var_names {return a1+","+a3;} / var_name
bracket_statements= "{" _ a2:statements _ "}" {return a2;} / a1:statement_with_semicolon _ ";" {return a1+";";}

IDENTIFIER = [a-zA-Z_][a-zA-Z0-9_]* {return text();}
STRING_LITERAL = '"' @$([^"\\] / "\\" .)* '"'

NUMBER = args:(Integer "." Integer) {$$ = args[0]+"."+args[2]} / Integer

Integer "integer"
  = _ [0-9]+ { return text(); }

_
  = [ \t\n\r]*
  
__
  = [ \t\n\r] [ \t\n\r]*
