/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"@staticmethod"       return '@staticmethod'
"class"               return 'class'
"def"                 return "def"
"dict"                return "dict"
"pass"                return "pass"
"if"                  return "if"
"of"                  return 'of'
"for"                 return 'for'
"in"                  return "in"
"else"                return "else"
"elif"                return "elif"
"while"               return "while"
"return"              return "return"
"lambda"              return "lambda"
","                   return ','
"."                   return '.'
":"                   return ':'
";"                   return ';'
"and"                 return 'and'
"or"                  return 'or'
"+="                  return '+='
"-="                  return '-='
"*="                  return '*='
"/="                  return '/='
">="                  return '>='
">>"                  return '>>'
">"                   return '>'
"<="                  return '<='
"<<"                  return '<<'
"<"                   return '<'
"!="                  return '!='
"=="                  return '=='
"="                   return '='
"**"                  return '**'
"*="                  return '*='
"*"                   return '*'
"/"                   return '/'
"%"                   return '%'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"{"                   return '{'
"}"                   return '}'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
"_"                   return '_'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left 'or'
%left 'and'
%left '>>' '<<'
%left '!=' '<' '<=' '>' '>=' '=='
%left '+' '-' '++'
%left '*' '/' 'mod'
%left '**' '^'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement_ statements_ {$$ = [$1].concat($2);} | statement_ {$$ =
 [$1];};

class_statements: class_statements_ {$$ = ["class_statements",$1]} | "pass" {$$ = ["class_statements",[]];};
class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};
class_statement:
	"@staticmethod" "def" IDENTIFIER "(" parameters ")" ":" statements {$$ = ["static_method","public","Object",$3,$5,$8];};

statement_:
	function
	| if_statement
	| "class" IDENTIFIER ":" class_statements {$$ = [$1,"public",$2,$4];}
	| "class" IDENTIFIER "(" IDENTIFIER ")" ":" class_statements {$$ = ["class_extends","public",$2,$4,$7];}
	| foreach
	| statement_with_semicolon {$$ = ["semicolon",$1];};

function:
	"def" IDENTIFIER "(" ")" ":" statements {$$ = ["function","public","Object",$2,[],$6];}
	| "def" IDENTIFIER "(" parameters ")" ":" statements {$$ = ["function","public","Object",$2,$4,$7];};
    
types: IDENTIFIER "->" types {$$ = [$1].concat($3);} | IDENTIFIER {$$ =
 [$1];};

statement:
    if_statement
    | while_loop
    | foreach
    | statement_with_semicolon {$$ = ["semicolon",$1];}
    | function;

if_statement: "if" e ":" statements elif_statement {$$ = ["if",$2,$4,$5];};

while_loop: "while" e ":" statements {$$ = ["while",$2,$4];};

foreach: "for" IDENTIFIER "in" e ":" statements {$$ = ["foreach","Object",$2,$4,$6];};

declare_var: IDENTIFIER "=" e {$$ = ["lexically_scoped_var","Object",$1,$3]};
declare_vars: declare_var declare_vars {$$ = [$1].concat($2);} | declare_var {$$ =
 [$1];};

statement_with_semicolon:
	statement_with_semicolon_ ";" {$$=$1;}	
	| statement_with_semicolon_;

statement_with_semicolon_
   :
   "return" e {$$ = ["return",$2];}
   | access_array_ "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   ;
e
    :
    e 'or' e
        {$$ = ["||",$1,$3];}
    |e 'and' e
        {$$ = ["&&",$1,$3];}
    |e '==' e
        {$$ = [$2,$1,$3];}
    |e '<=' e
        {$$ = [$2,$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e '>=' e
        {$$ = [$2,$1,$3];}
    |e '>' e
        {$$ = [$2,$1,$3];}
    |e '!=' e
        {$$ = [$2,$1,$3];}
    | e '++' e
        {$$ = [$2,$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | e 'mod' e
        {$$ = ["%",$1,$3];}
	| e '**' e
        {$$ = [$2,$1,$3];}
    | e '^' e
        {$$ = ["**",$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | parentheses_expr {$$ = $1;}
    ;


access_array: parentheses_expr_ "[" e "]" {$$ = ["access_array",$1,[$3]];};
access_array_: IDENTIFIER "[" e "]" {$$ = ["access_array",$1,[$3]];};

parentheses_expr: access_array | IDENTIFIER "." function_call {$$= [".",[$1,$3]];}
| parentheses_expr_;

named_parameters: named_parameters "," named_parameter {$$ = $1.concat([$3]);} | named_parameter {$$ = [$1];};
named_parameter: IDENTIFIER "=" e {$$ = ["named_parameter",$1,$3]};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: e ":" e {$$ = [$1,$3]};

key_values_: key_values_ "," key_value_ {$$ = $1.concat([$3]);} | key_value_ {$$ = [$1];};
key_value_: IDENTIFIER "=" e {$$ = ["\""+$1+"\"",$3]};

ternary_operator: e "if" e "else" e {$$ = ["ternary_operator",$3,$1,$5];} | e "if" e "else" ternary_operator {$$ = ["ternary_operator",$3,$1,$5];};

parentheses_expr_:
    "(" ternary_operator ")" {$$ = $2;}
    |"(" "lambda" parameters ":" e ")" {$$ = ["anonymous_function","Object",$3,["statements",[["semicolon",["return",$5]]]]];}
    |"[" "]" {$$ = ["initializer_list","Object",[]];}
    |"[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    |"{" "}" {$$ = ["associative_array","Object","Object",[]];}
    | "{" key_values "}" {$$ = ["associative_array","Object","Object",$2];}
    | "dict" "(" key_values_ ")" {$$ = ["associative_array","Object","Object",$3];}
    |"{" exprs "}" {$$ = ["initialize_set","Object",$2];}
    |"(" e "," exprs ")" {$$ = ["initialize_tuple","Object",[$2].concat($4)];}
    |"(" parentheses_expr "in" parentheses_expr ")"  {$$ = ["in",$2,$4];}
    |"[" e "for" e "in" list_comprehensions "]" {$$ = ["list_comprehension",$2,$4,$6];}
    |"[" e "for" e "in" list_comprehensions "if" e "]" {$$ = ["list_comprehension",$2,$4,$6,$8];}
    | function_call
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
    | "(" e ")" {$$ = ["parentheses",$2]}
    | STRING_LITERAL
        {$$ = yytext;}
    ;

function_call: IDENTIFIER "(" ")" {$$= ["function_call",$1,[]];}
    | IDENTIFIER "(" named_parameters ")" {$$ = ["function_call",$1,$3];}
    | IDENTIFIER "(" exprs ")" {$$= ["function_call",$1,$3];};

list_comprehensions: e "for" e "in" list_comprehensions {$$ = ["list_comprehensions",$1,$3,$5];} | e;

parameter: IDENTIFIER {$$ = ["Object",$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];};

exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
args: parentheses_expr args {$$ = [$1].concat($2);} | parentheses_expr {$$ = [$1];};
elif_statement: "elif" e ":" statements elif_statement {$$ = ["elif",$2,$4,$5]} | "else" ":" statements {$$ = ["else",$3];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};


statements: statement {$$ = ["statements",[$1]]} | "pass" {$$ = ["statements",[]]};
