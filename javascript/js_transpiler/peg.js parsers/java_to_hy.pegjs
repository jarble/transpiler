statements = _ head:statement tail:statements {return head+" "+tail} / _ a:statement _ {return a;}

statement = a:statement_with_semicolon ";" {return a;} / while / if / elif / else / function / class / for / foreach

foreach = "for" _ "(" _ a:type __ b:var_name _ ":" _ c:var_name _ ")" _ "{" _ d:statements _ "}" {return "(for ["+b+" "+c+"] "+d+")";}
for = "for" _ "(" _ a:statement_with_semicolon _ ";" _  b:expr _ ";" _ c:statement_with_semicolon  _ "){" _ d:statements _ "}" {return ["for",a,b,c,d];}

function = "public" __ "static" __ type:type __ name:var_name "(" _ params:parameters _ ")" _ "{" body:statements "}" {return "(defn "+name+" ["+params+"] "+body+")";}
while = "while" _ "(" _ a:expr _ ")" _ "{" b:statements "}" {return  "(while "+a+" "+b+")";}
if = "if" _ "(" _ a:expr _ ")" _ "{" b:statements "}" {return  "(cond"+" ["+a+" "+b + "]";}
elif = "else if" _ "(" _ a:expr _ ")" _ "{" b:statements "}" {return  ["else if",a,b];}
else = "else" _ "{" a:statements "}" {return  ["else",a];}

class = 
    "public" __ "class" __ a:var_name _ "{" _ b:class_statements _ "}" {return "(class "+ a +" [object] "+b+")";} /
    "public" __ "class" __ a:var_name __ "extends" _ extend:var_name _ "{" _ b:class_statements _ "}" {return "(defclass "+ a +" [" + extend + "] "+b+")";}

class_statements = a:class_statement _ b:class_statements {return a + " " + b;} / class_statement
class_statement = function

statement_with_semicolon = initialize_var / initialize_empty_var / set_var / plus_plus / plus_equals / println / return


println = "System.out.println" _ "(" _ a:expr _ ")" {return "(print "+ a+")";}

return = "return" __ a:expr {return a;}
initialize_var = a:type __ b:var_name _ "=" _ c:expr {return "(setv "+b+" "+c+")";}
initialize_empty_var = a:type __ b:var_name {return "";}


set_var = name:dot_expr _ "=" _ exp:expr {return "(setv "+" "+name+" "+exp+")"}
plus_equals = name:var_name _ symbol:("*=" / "+=" / "-=" / "/=") _ exp:expr {return "("+symbol+" "+name+" "+exp+")";}
plus_plus =
    name:var_name _ "++" {return "(+= " + name + ")";} /
    name:var_name _ "--" {return "(-= " + name + ")";}


scalar_type = "int" / "double" {return "float"} / "String" {return "str"} / "boolean" / "char" / "void"
type = scalar_type "[]" {return "list"} / scalar_type

parameters = a:parameter _ "," _ b:parameters {return a+" "+b;} / parameter
parameter = type __ a:var_name {return a;}

expr = cmp_expr

cmp_expr = a:add_expr _ symbol:(">=" / "<=" / ">" / "<" / "==" / "!=" / "||" / "&&") _ b:add_expr {return "(" + symbol +" "+ a +" "+ b + ")";} / add_expr

add_expr
  = head:term _ symbol:("+" / "-") _ tail:add_expr {
    return	"("+symbol+" "+head+" "+tail+")";
    } / term

term
  = head:factor _ symbol:("*" / "/") _ tail:term {
    return	[symbol,head,tail];
    } / dot_expr

dot_expr =  strcmp / length / trig_function / string_replace / substring / not / this / factor

this = "this" _ "." _ a:var_name {return "self."+a;}
not = "!" a:dot_expr {return "(not "+a+")";}

strcmp = a:factor _ "." _ "equals" _ "(" _ b:factor _ ")" {return "(="+" "+a+" "+b+")";}
trig_function = "Math" _ "." _ name:("sin"/"cos"/"tan"/"asin"/"acos"/"atan"/"sqrt") _ "(" _ a:expr _ ")" {return [name,a];}
substring = a:factor _ "." _ "substring" _ "(" _ b:expr _ "," _ c:expr _ ")" {return ["substring",a,b,c];}
string_replace = a:factor _ "." _ "replace" _ "(" _ b:expr _ "," _ c:expr _ ")" {return ["string_replace",a,b,c];}
length = a:factor _ "." _ ("length" /  "length" _ "(" _ ")") {return "(len "+a+")";}


factor
  = "(" _ expr:expr _ ")" { return "("+expr+")"; }
  / number / "true" / "false" / var_name / string_literal / initializer_list

initializer_list = "[" _ a:initializer_list_ _ "]" {return "[" + a + "]";}
initializer_list_ = a:expr _ "," _ b:initializer_list_ {return a + " " + b;} / expr

number "number" =  [0-9]+ "." [0-9]+ {return text();} / decimal

decimal "decimal" = positive_integer "." integer { return text(); } / integer

integer "integer"
  = positive_integer / "-" positive_integer { return text(); }

positive_integer = [0-9]+ { return text(); }

true = "true"
false = "false"

var_name = [a-zA-Z0-9_]+ {return text();}
string_literal = "\"" ("\\\"" / [a-zA-Z0-9_ \\\>|<\[\]\t\n\r\?\!\$\#\@\%\&\*\^\.\,\'\;\/\:\`\~\{\}\=\+\(\)\-])+ "\"" {return ["string_literal", text()];}


_ "whitespace"
  = [ \t\n\r]*

__ "whitespace"
  = [ \t\n\r] _
