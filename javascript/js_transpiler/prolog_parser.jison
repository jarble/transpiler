/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"if"                  return "if"
"is"                  return "is"
","                   return ','
";"                   return ';'
"==>"                 return '==>'
"-->"                  return '-->'
"->"                  return '->'
":-"                  return ':-'
"."                   return '.'
":"                   return ':'
">="                  return '>='
">"                   return '>'
"=<"                  return '=<'
"<"                   return '<'
"=="                  return '=='
"="                   return '='
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
%left ';'
%left ','
%left '<' '=<' '>' '>=' '=' '==' 'is'
%left '+' '-'
%left '*' '/'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: top_level_statements_ EOF {return ["top_level_statements",$1]};

top_level_statements_: top_level_statement "." top_level_statements_ {$$ = [$1].concat($3);} | top_level_statement "." {$$ =
 [$1];};

statements: statements_ {return ["statements",$1]};

statements_: statement "," statements_ {$$ = [$1].concat($3);} | statement {$$ =
 [$1];};

statement: parentheses_expr | if_statement;
 
top_level_statements: top_level_statements_ {$$ = ["top_level_statements",$1]};

top_level_statement
    : predicate | grammar_statement | function_call;

predicate:
    IDENTIFIER "(" exprs ")" ":-" e {$$ = ["function","Object",$1,$3,$6]}
    | IDENTIFIER ":-" e {$$ = ["function","Object",$1,[],$3]};

grammar_statement:
    IDENTIFIER "-->" e {[$$ = ["grammar_statement",$1,$3]]}
    | IDENTIFIER "(" exprs ")" "-->" e {$$ = ["grammar_macro",$1,$3,$6]};

e
    :
    e '->' e
        {$$ = ["implies",$1,$3]}
    |e ';' e
        {$$ = ['logic_or',$1,$3];}
    |e ',' e
        {$$ = ['logic_and',$1,$3];}
    |e '=' e
        {$$ = ['logic_equals',$1,$3];}
    |e 'is' e
        {$$ = ['logic_equals',$1,$3];}
    |e '==' e
        {$$ = ['logic_equals',$1,$3];}
    |e '=<' e
        {$$ = ['<=',$1,$3];}
    |e '<' e
        {$$ = ['>',$1,$3];}
    | e '>=' e
        {$$ = ['>=',$1,$3];}
    |e '>' e
        {$$ = ['>',$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = ["-",$1,$3];}
    | e '*' e
        {$$ = ["*",$1,$3];}
    | e '/' e
        {$$ = ["/",$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | parentheses_expr
    ;

parameter: IDENTIFIER {$$ = ["Object", $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};

function_call:
    IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];} | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];};

parentheses_expr:
    function_call
    | '(' e ')' {$$ = $2;}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

exprs: parentheses_expr "," exprs {$$ = [$1].concat($3);} | parentheses_expr {$$ = [$1];};
if_statement:
e "==>" e {$$= ["implies",$1,$3]};

block_statements: "(" statements ")" {$$ = $2};

elif: e "->" block_statements ";" elif {$$ = ["elif",$1,$3,$5]} | else_statement;
else_statement: block_statements {$$ = ["else",$2];};
if_statement:
"(" e "->" statements ";" elif {$$ = ["if",$2,$4,$6];}
| "(" e "->" block_statements ")" {$$ = ["if",$2,$4];};
