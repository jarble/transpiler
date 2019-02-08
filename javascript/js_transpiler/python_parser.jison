/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"@staticmethod"       return '@staticmethod'
"class"               return 'class'
"def"                 return "def"
"if"                  return "if"
"of"                  return 'of'
"for"                 return 'for'
"in"                  return "in"
"let"                 return "let"
"else"                return "else"
"elif"                return "elif"
"then"                return "then"
"while"               return "while"
"data"                return "data"
"return"              return "return"
"mod"                 return 'mod'
","                   return ','
"."                   return '.'
":"                   return ':'
"and"                 return 'and'
"or"                  return 'or'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"!="                  return '!='
"=="                  return '=='
"="                   return '='
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

%left '||'
%left '&&'
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

class_statements: class_statement class_statements {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};
class_statement:
	"@staticmethod" "def" IDENTIFIER "(" parameters ")" ":" statements {$$ = ["instance_method","public","Object",$3,$5,$8];};

statement_:
	"def" IDENTIFIER "(" ")" ":" statements {$$ = ["function","public","Object",$2,[],$6];}
	|"def" IDENTIFIER "(" parameters ")" ":" statements {$$ = ["function","public","Object",$2,$4,$7];}
	|"class" IDENTIFIER ":" class_statements {$$ = [$1,"public",$2,$4];};
    
types: IDENTIFIER "->" types {$$ = [$1].concat($3);} | IDENTIFIER {$$ =
 [$1];};

statement:
    "if" e ":" statements elif_statement {$$ = ["if",$2,$4,$5];}
    | "while" e ":" statements {$$ = ["while",$2,$4];}
    | "for" IDENTIFIER "in" e ":" statements {$$ = ["foreach","Object",$2,$4,$6];}
    | statement_with_semicolon {$$ = ["semicolon",$1];};


declare_var: IDENTIFIER "=" e {$$ = ["lexically_scoped_var","Object",$1,$3]};
declare_vars: declare_var declare_vars {$$ = [$1].concat($2);} | declare_var {$$ =
 [$1];};

statement_with_semicolon
   :
   "return" e  {$$ = ["return",$2];}
   ;
e
    :
    e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
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


access_array: parentheses_expr "[" e "]" {$$ = ["access_array",$1,[$3]];};

parentheses_expr:
    "(" "lambda" parameters ":" e ")" {$$ = ["anonymous_function","Object",$3,["statements",[["semicolon",["return",$5]]]]];}
    |"(" access_array ")" {$$ = $2}
    |"[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    |"{" exprs "}" {$$ = ["initialize_set","Object",$2];}
    |"(" parentheses_expr "in" parentheses_expr ")"  {$$ = ["in",$2,$4];}
    |"[" e "for" e "in" list_comprehensions "]" {$$ = ["list_comprehension",$2,$4,$6];}
    |"[" e "for" e "in" list_comprehensions "if" e "]" {$$ = ["list_comprehension",$2,$4,$6,$8];}
    | IDENTIFIER "(" ")" {$$= ["function_call",$1,[]];}
    | IDENTIFIER "(" exprs ")" {$$= ["function_call",$1,$3];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
    | "(" e ")" {$$ = ["parentheses",$2]}
    | STRING_LITERAL
        {$$ = yytext;}
    ;

list_comprehensions: e "for" e "in" list_comprehensions {$$ = ["list_comprehensions",$1,$3,$5];} | e;

parameter: IDENTIFIER {$$ = ["Object",$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];};
access_arr: parentheses_expr "!!" access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
args: parentheses_expr args {$$ = [$1].concat($2);} | parentheses_expr {$$ = [$1];};
elif_statement: "elif" e ":" statements elif_statement {$$ = ["elif",$2,$4,$5]} | "else" ":" statements {$$ = ["else",$3];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};


statements: statement {$$ = ["statements",[$1]]};
