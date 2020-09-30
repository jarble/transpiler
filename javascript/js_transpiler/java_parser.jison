/* lexical grammar */
%lex
%%

(\s+|\/\/+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\"    return 'STRING_LITERAL'
\'([^\\\']|\\.)*\'    return 'CHAR_LITERAL'
"HashMap"             return 'HashMap'
"import"              return 'import'
"default"             return 'default'
"assert"             return 'assert'
"Object"              return 'Object'
"class"               return 'class'
"enum"                return 'enum'
"case"                return 'case'
"public"              return 'public'
"extends"             return 'extends'
"final"               return 'final'
"abstract"            return 'abstract'
"implements"          return 'implements'
"interface"           return 'interface'
"instanceof"          return 'instanceof'
"private"             return 'private'
"static"              return 'static'
"if"                  return 'if'
"else"                return 'else'
"return"              return 'return'
"while"               return 'while'
"until"               return 'until'
"break"               return 'break'
"switch"              return 'switch'
"for"                 return 'for'
"new"                 return 'new'
"put"                 return 'put'
"do"                  return 'do'
","                   return ','
";"                   return ';'
"..."                 return '...'
"."                   return '.'
":"                   return ':'
"&="                  return '&='
"&&"                  return '&&'
"&"                   return '&'
"|="                  return '|='
"||"                  return '||'
"|"                   return '|'
"->"                  return '->'
">>"                  return '>>'
">="                  return '>='
">"                   return '>'
"<<"                  return '<<'
"<="                  return '<='
"<"                   return '<'
"=="                  return '=='
"!="                  return '!='
'!'                   return '!'
"="                   return '='
"%="                  return '%='
"%"                   return '%'
"*="                  return '*='
"*"                   return '*'
"/="                  return '/='
"/"                   return '/'
"-="                  return '-='
"--"                  return '--'
"-"                   return '-'
"++"                  return '++'
"+="                  return '+='
"+"                   return '+'
"^"                   return '^'
"{"                   return '{'
"}"                   return '}'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '->'
%left 'instanceof' '||' '|'
%left '&&' '&'
%left '==' '!=' '<' '<=' '>' '>='
%left '>>' ('<<'
%left '+' '-'
%left '<<' '>>'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

statements: statements_ {$$ = ["statements",$1]};
statements_: statements_with_vars | initialize_var_ ";" {$$ = [["semicolon",["initialize_var"].concat($1)]]} | initialize_var_ ";" statements_ {$$ = [["lexically_scoped_vars",[["lexically_scoped_var"].concat($1)],["statements",$3]]]};
statements_without_vars: statements_without_vars statement {$$ = $1.concat([$2]);} | statement {$$ =
 [$1];};
statements_with_vars: statements_without_vars initialize_var1 ";" {$$ = $1.concat([["semicolon",$2]]);} | statements_without_vars;
initialize_vars: initialize_vars ";" initialize_var {$$ = $1.concat([$3]);} | initialize_var {$$ =
 [$1];};


expressions: top_level_statements EOF {return ["top_level_statements",$1]};
top_level_statements: top_level_statements top_level_statement {$$ = $1.concat([$2]);} | top_level_statement {$$ =
 [$1];};
top_level_statement:
	statement | initialize_var1 ";" {$$ = ["semicolon",$1]};

initialize_var1: initialize_var_ {$$ = ["initialize_var"].concat($1);};
initialize_var: initialize_var_ {$$ = ["lexically_scoped_var"].concat($1);};
initialize_var_: 
   type IDENTIFIER "=" e {$$ = [$1,$2,$4];}
   | type IDENTIFIER "=" "{" exprs "}" {$$ = [$1,$2,[".",[["initializer_list","Object",$5]]]];}
   ;

class_statements: class_statements_ {$$ = ["class_statements",$1]} | {$$ = ["class_statements",[]]};
class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};

access_modifier: "public" | "private";

class_:
	access_modifier "class" IDENTIFIER "{" class_statements "}" {$$ = [$2,$1,$3,$5];}
	| access_modifier "class" IDENTIFIER "<" types ">" "{" class_statements "}" {$$ = ["generic_class",$1,$3,$8,$5];}
	| access_modifier "abstract" "class" IDENTIFIER "{" class_statements "}" {$$ = ["abstract_class",$1,$4,$6];}
	| access_modifier "interface" IDENTIFIER "<" types ">" "{" class_statements "}" {$$ = ["generic_interface",$1,$3,$8,$5];}	
	| access_modifier "interface" IDENTIFIER "extends" identifiers "{" class_statements "}" {$$ = ["interface_extends",$1,$3,$5,$7];}
	| access_modifier "interface" IDENTIFIER "{" class_statements "}" {$$ = [$2,$1,$3,$5];}
	| access_modifier "enum" IDENTIFIER "{" identifiers "}" {$$ = ["enum",$1,$3,$5];}
	| access_modifier "class" IDENTIFIER "extends" IDENTIFIER "{" class_statements "}" {$$ = ["class_extends",$1,$3,$5,$7];}
	| access_modifier "class" IDENTIFIER "implements" IDENTIFIER "{" class_statements "}" {$$ = ["class_implements",$1,$3,$5,$7];};

bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon ";" {$$ = ["semicolon",$1];};

statement
    :
    statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | "if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
	| "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];}
    | class_
    | "while" "(" e ")" bracket_statements {$$ = ["while",$3,$5];}
    | "do" bracket_statements "while" "(" e ")" ";" {$$ = ["do_while",$2,$5];}
    | "switch" "(" e ")" "{" case_statements "}" {$$ = ["switch",$3,$6];}
    | "for" "(" statement_with_semicolon_ ";" e ";" statement_with_semicolon_ ")" bracket_statements {$$ = ["for",$3,$5,$7,$9];}
    | "for" "(" type IDENTIFIER ":" IDENTIFIER ")" "{" statements "}" {$$ = ["foreach",$3,$4,$6,$9];}
    | "public" "static" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["function",$1,$3,$4,$6,$9];}
    ;

statement_with_semicolon_: initialize_var1 | statement_with_semicolon;

case_statement: "case" e ":" statements "break" ";" {$$ = ["case",$2,$4]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "default" ":" statements {$$ = $1.concat([["default",$4]])} | case_statements_;

class_statement:
	class_
	| access_modifier IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["constructor",$1,$2,$4,$7];}
	| access_modifier type IDENTIFIER "=" e ";" {$$ = ["initialize_instance_var_with_value",$1,$2,$3,$5];}
	| access_modifier type IDENTIFIER ";" {$$ = ["initialize_instance_var",$1,$2,$3];}
	| access_modifier "static" type IDENTIFIER ";" {$$ = ["initialize_static_instance_var",$1,$3,$4];}
	| access_modifier "static" type IDENTIFIER "=" e ";" {$$ = ["initialize_static_instance_var_with_value",$1,$3,$4,$6];}
	| access_modifier "static" type IDENTIFIER "(" parameters ")" ";" {$$ = ["interface_static_method",$1,$3,$4,$6];}
	| access_modifier type IDENTIFIER "(" parameters ")" ";" {$$ = ["interface_instance_method",$1,$2,$3,$5];}
	| access_modifier "static" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method",$1,$3,$4,$6,$9];}
	| access_modifier "static" "<" types ">" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["generic_static_method",$1,$6,$7,$9,$12,$4];}
	| access_modifier "<" types ">" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["generic_instance_method",$1,$5,$6,$8,$11,$3];}
	| access_modifier type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["instance_method",$1,$2,$3,$5,$8];};

statement_with_semicolon
   : 
   "import" IDENTIFIER  {$$ = ["import",$2];}
   | "return" e  {$$ = ["return",$2];}
   | "return"  {$$ = ["return"];}
   | "continue"  {$$ = ["continue"];}
   | "assert" e  {$$ = ["function_call","assert",[$2]];}
   | "final" type IDENTIFIER "=" e {$$ = ["initialize_constant",$2,$3,$5];}
   | "final" type identifiers {$$ = ["initialize_empty_constants",$2,$3];}
   | type identifiers {$$ = ["initialize_empty_vars",$1,$2];}
   | type access_array {$$ = ["set_array_size",$1,$2[1],$2[2]];}
   | type IDENTIFIER "=" "new" access_array {$$ = ["set_array_size",$1,$2,$5[2]];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "." IDENTIFIER "=" e {$$ = ["set_var",[".",[$1,$3]],$5];}
   | IDENTIFIER "++" {$$ = [$2,$1];}
   | IDENTIFIER "--" {$$ = [$2,$1];}
   | "++" IDENTIFIER {$$ = [$1,$2];}
   | "--" IDENTIFIER {$$ = [$1,$2];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "|=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "&=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "%=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "." dot_expr {$$ = [".",[$1].concat($3)]}
   ;

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: "put" "(" STRING_LITERAL "," e ")" {$$ = [$3,$5]};

lambda_parameters: IDENTIFIER "," lambda_parameters {$$ = [["Object",$1]].concat($3);} | IDENTIFIER {$$ = [["Object",$1]]};

e:
    IDENTIFIER "->" "{" statements "}" {$$= ["anonymous_function","Object",[["Object",$1]],$4]}
    |"(" IDENTIFIER "," lambda_parameters  ")" "->" "{" statements "}" {$$= ["anonymous_function","Object",[["Object",$2]].concat($4),$8]}
    |e "instanceof" e
        {$$ = [$2,$1,$3];}
    |e '||' e
        {$$ = [$2,$1,$3];}
    |e '|' e
        {$$ = ["eager_or",$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e '&' e
        {$$ = ["eager_and",$1,$3];}
    |e '==' e
        {$$ = [$2,$1,$3];}
    |e '!=' e
        {$$ = [$2,$1,$3];}
    |e '<=' e
        {$$ = [$2,$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e '>=' e
        {$$ = [$2,$1,$3];}
    |e '>' e
        {$$ = [$2,$1,$3];}
    | e '>>' e
        {$$ = [$2,$1,$3];}
    | e '<<' e
        {$$ = [$2,$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | e '%' e
        {$$ = [$2,$1,$3];}
    | initializer_list
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | not_expr
    ;

not_expr: "!" dot_expr {$$ = ["!", [".",$2]];} | dot_expr {$$ = [".", $1];};


dot_expr: initializer_list  "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr  "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: access_array "[" e "]" {$$ = ["access_array",$1,[$3]];} | IDENTIFIER "[" e "]" {$$ = ["access_array",$1,[$3]];};

initializer_list:
"new" type "{" "}" {$$ = ["initializer_list",$2,[]];} | "new" type "{" exprs "}" {$$ = ["initializer_list",$2,$4];} | "new" type "(" ")" {$$ = [$1,$2,[]];} | "new" type "(" exprs ")" {$$ = [$1,$2,$4];};

parentheses_expr:
    "(" e ")" {$$= ["parentheses",$2];}
    | access_array
    | parentheses_expr "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | "(" e "?" e ":" e ")" {$$ = ["ternary_operator",$2,$4,$6];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;}
    | CHAR_LITERAL
        {$$ = yytext;};

type: IDENTIFIER square_brackets {var the_output = $1; for(var i = 0; i < $2.length; i++){the_output = [the_output,"[]"];} $$ = the_output;} | type_ "<" types ">" {$$ = [$1,$3]} | type_;

square_brackets: square_brackets "[" "]" {$$ = $1.concat(["[]"]);} | "[" "]" {$$ = ["[]"]};

type_: "Object" | "HashMap" | IDENTIFIER;

parameter: type "..." IDENTIFIER {$$ = ["varargs",$1,$3]} | type IDENTIFIER {$$ = [$1,$2];} | "final" type IDENTIFIER {$$ = ["final_parameter",$2,$3];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$= []};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif:
	"else" "if" "(" e ")" bracket_statements elif {$$ = ["elif",$4,$6,$7]}
	| "else" bracket_statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};
add: e "+" add {$$ = [$1].concat($3);} | e {$$ = [$1];};
