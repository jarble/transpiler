/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"arrayOf"             return 'arrayOf'
"class"               return 'class'
"enum"                return 'enum'
"public"              return 'public'
"final"               return 'final'
"abstract"            return 'abstract'
"implements"          return 'implements'
"interface"           return 'interface'
"is"                  return 'is'
"private"             return 'private'
"static"              return 'static'
"fun"                 return 'fun'
"if"                  return 'if'
"else"                return 'else'
"case"                return "case"
"return"              return 'return'
"while"               return 'while'
"break"               return 'break'
"switch"              return 'switch'
"for"                 return 'for'
"new"                 return 'new'
"var"                 return 'var'
","                   return ','
";"                   return ';'
"..."                 return '...'
"."                   return '.'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
"=>"                  return '=>'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"=="                  return '=='
"!="                  return '!='
"="                   return '='
"*="                  return '*='
"*"                   return '*'
"%"                   return '%'
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
"]["                  return ']['
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '||'
%left '&&'
%left 'is'
%left '==' '!=' '<' '<=' '>' '>='
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};
 
class_statements: class_statements_ {$$ = ["class_statements",$1]};
statements: statements_ {$$ = ["statements",$1]};

case_statement: "case" e ":" statements "break" ";" {$$ = ["case",$2,$4]};
case_statements: case_statement case_statements {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};

access_modifier: "public" | "private";

class_:
	"class" IDENTIFIER "{" class_statements "}" {$$ = [$1,"public",$2,$4];}
	| access_modifier "abstract" "class" IDENTIFIER "{" class_statements "}" {$$ = ["abstract_class",$1,$4,$6];}
	| access_modifier "interface" IDENTIFIER "{" class_statements "}" {$$ = [$2,$1,$3,$5];}
	| access_modifier "enum" "class" IDENTIFIER "{" identifiers "}" {$$ = ["enum",$3,$1,$4,$6];}
	| access_modifier "class" IDENTIFIER ":" identifiers "{" class_statements "}" {$$ = ["class_extends",$1,$3,$5,$7];};

statement
    :
    statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | class_
    | "while" "(" e ")" bracket_statements {$$ = ["while",$3,$5];}
    | "switch" "(" e ")" "{" case_statements "}" {$$ = ["switch",$3,$6];}
    | "for" "(" IDENTIFIER "in" IDENTIFIER ")" "{" statements "}" {$$ = ["foreach","Object",$3,$5,$8];}
    | if_statement
    | "fun" IDENTIFIER "(" parameters ")" ":" type "{" statements "}" {$$ = ["function","public",$7,$2,$4,$9];}
    | "fun" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["function","public","Object",$2,$4,$7];}
    ;

class_statement:
	access_modifier type IDENTIFIER "=" e ";" {$$ = ["initialize_instance_var",$1,$2,$3,$5];}
	| access_modifier "static" type IDENTIFIER "=" e ";" {$$ = ["initialize_static_instance_var",$1,$3,$4,$6];}
	| access_modifier "static" type IDENTIFIER "(" parameters ")" ";" {$$ = ["interface_static_method",$1,$3,$4,$6];}
	| access_modifier type IDENTIFIER "(" parameters ")" ";" {$$ = ["interface_instance_method",$1,$2,$3,$5];}
	| access_modifier "static" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method",$1,$3,$4,$6,$9];}
	| "public" "function" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["instance_method",$1,"Object",$3,$5,$7];}
	| "static" "public" "function" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method",$2,"Object",$4,$6,$8];}
	| "operator" "fun" IDENTIFIER "(" parameters ")" ":" type "{" statements "}" {$$ = ["instance_overload_operator","public",$8,$3,$5,$10];}
;

statement_with_semicolon
   : 
   "return" e  {$$ = ["return",$2];}
   | "val" IDENTIFIER ":" type "=" e {$$ = ["initialize_constant",$4,$2,$6];}
   | "var" IDENTIFIER  ":" type "=" e  {$$ = ["initialize_var",$4,$2,$6];}
   | type identifiers {$$ = ["initialize_empty_vars",$1,$2];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "++" {$$ = [$2,$1];}
   | IDENTIFIER "--" {$$ = [$2,$1];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "." dot_expr {$$ = [".",[$1].concat($3)]}
   ;
e
    :
    e "is" e
        {$$ = [$2,$1,$3];}
    |e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
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
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | initializer_list
    | "[" key_values "]" {$$ = ["associative_array","Object","Object",$2];}

    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | dot_expr {$$ = [".", $1];}
    ;

key_values: key_values "," key_value {$$ = [$1].concat($3);} | key_value {$$ = [$1];};
key_value: STRING_LITERAL "=>" e {$$ = [$1,$3]};

dot_expr: initializer_list  "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr  "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: IDENTIFIER "[" access_arr "]" {$$ = ["access_array",$1,$3];};

initializer_list:
"arrayOf" "(" exprs ")" {$$ = ["initializer_list","Object",$2];};

parentheses_expr:
    access_array
    |parentheses_expr "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | '(' e ')'} {$$ = $2;}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

type: IDENTIFIER "[" "]" {$$ = [$1,"[]"];} | IDENTIFIER "<" types ">" {$$ = [$1,$3]} | IDENTIFIER;
parameter: IDENTIFIER ":" type {$$ = [$3,$1];} | IDENTIFIER {$$ = ["Object",$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$= []};
access_arr: parentheses_expr "][" access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif: "else" "if" "(" e ")" bracket_statements elif {$$ = ["elif",$4,$6,$7]} | "else" "if" "(" e ")" bracket_statements {$$ = ["elif",$4,$6]} | "else" bracket_statements {$$ = ["else",$2];};
if_statement:
"if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
|  "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};
add: e "+" add {$$ = [$1].concat($3);} | e {$$ = [$1];};
bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon ";" {$$ = ["semicolon",$1];};
