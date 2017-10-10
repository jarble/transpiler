/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
"function"            return "function"
"class"               return "class"
"public"              return "public"
"extends"             return "extends"
"implements"          return "implements"
"private"             return "private"
"static"              return "static"
"if"                  return 'if'
"else"                return 'else'
"return"              return 'return'
"sin"                 return "sin"
"tan"                 return "tan"
"cos"                 return "cos"
"print"               return "print"
"while"               return 'while'
"for"                 return 'for'
"my"                  return 'my'
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"=="                  return '=='
"="                   return '='
"*="                  return '*='
"*"                   return '*'
"/="                  return '/='
"/"                   return '/'
"%"                   return '%'
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
"PI"                  return 'PI'
"E"                   return 'E'
[a-zA-Z][a-zA-Z0-9]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '&&' '||'
%left '<' '<=' '>' '>='
%left '+' '-' '.'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : statements EOF
        {return $1;}
    ;

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};
 
class_statements: class_statements_ {$$ = ["class_statements",$1]};
statements: statements_ {$$ = ["statements",$1]};


class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};

access_modifier: "public" | "private";

class_:
	"class" IDENTIFIER "{" class_statements "}" {$$ = [$1,$2,$4];};

statement
    :
    statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | class_
    | "while" "(" e ")" "{" statements "}" {$$ = ["while",$3,$6];}
    | "for" "(" statement_with_semicolon ";" e ";" statement_with_semicolon ")" "{" statements "}" {$$ = ["for",$3,$5,$7,$10];}
    | "for" "(" type var_name ":" var_name ")" "{" statements "}" {$$ = ["foreach",$3,$4,$6,$9];}
    | if_statement
    | "function" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["function","Object",$2,$4,$7];}
    ;

class_statement:
	"static" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method","public","Object",$2,$4,$7];}
	| IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["instance_method","public","Object",$1,$3,$6];}
	;

statement_with_semicolon
   : 
   "print" "(" e ")" {$$ = ["println",$3];}
   | "return" e  {$$ = ["return",$2];}
   | "my" var_name "=" e {$$ = ["initialize_var","Object",$2,$4];}
   | "my" var_names {$$ = ["initialize_empty_vars","Object",$2];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | var_name "=" e {$$ = ["set_var",$1,$3];}
   | var_name "++" {$$ = ["plus_plus",$1];}
   | var_name "--" {$$ = ["minus_minus",$1];}
   | var_name "+=" e {$$ = ["plus_equals",$1,$3];}
   | var_name "-=" e {$$ = ["minus_equals",$1,$3];}
   | var_name "*=" e {$$ = ["times_equals",$1,$3];}
   | var_name "/=" e {$$ = ["divide_equals",$1,$3];}
   ;
e
    :
    e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
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
    | e '.' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = ["-",$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | e '%' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | parentheses_expr {$$ = $1;}
    ;

access_array: var_name "[" access_arr "]" {$$ = ["access_array",$1,$3];};

parentheses_expr:
    access_array
    |parentheses_expr "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | "(" ")" {$$ = ["initializer_list_or_parentheses",[]];} | "(" exprs ")" {$$ = ["initializer_list",$2];}
    | NUMBER
        {$$ = yytext;}
    | var_name
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;}
    | E
        {$$ = Math.E;}
    | PI
        {$$ = Math.PI;};

type: IDENTIFIER "[" "]" {$$ = [$1,"[]"];} | IDENTIFIER "<" types ">" {$$ = [$1,$3]} | IDENTIFIER;
parameter: var_name {$$ = ["Object", $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];};
access_arr: parentheses_expr "][" access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif: "else" "if" "(" e ")" "{" statements "}" elif {$$ = ["elif",$4,$7,$9]} | else_statement;
else_statement: "else" "{" statements "}" {$$ = ["else",$3];};
if_statement:
"if" "(" e ")" "{" statements "}" elif {$$ = ["if",$3,$6,$8];}
|  "if" "(" e ")" "{" statements "}" {$$ = ["if",$3,$6];};

var_name: "$" IDENTIFIER {$$ = $2;};
var_names: var_name "," var_names {$$ = [$1].concat($3);} | var_name {$$ = [$1];};
