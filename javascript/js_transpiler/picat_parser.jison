/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"forall"              return 'forall'
"if"                  return "if"
"is"                  return "is"
","                   return ','
";"                   return ';'
"=>"                  return '=>'
"@"                   return '@'
"-->"                 return '-->'
"->"                  return '->'
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
"|"                   return '|'
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

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement "." statements_ {$$ = [$1].concat($3);} | statement "." {$$ =
 [$1];};
 
statements: statements_ {$$ = ["top_level_statements",$1]};

statement
    : predicate | function_call;

predicate:
    IDENTIFIER "(" exprs ")" "=>" e {$$ = ["predicate",$1,$3,$6]}
    | IDENTIFIER "=>" e {$$ = ["predicate",$1,[],$3]};

e
    :
    "forall" "(" "member" "(" IDENTIFIER "," IDENTIFIER ")" "," e ")" {$$ = ["foreach","Object",$5,$7,$10];}
    |e '->' e
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
        {$$ = [$2,$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
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
    | "[" "]" {$$ = ["initializer_list","Object",[]];}
    | "[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    | "[" dot_expr "|" exprs "]" {$$ = ["list_head_tail","Object",$2,["initializer_list","Object",$4]];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

exprs: exprs "," parentheses_expr {$$ = $1.concat([$3]);} | parentheses_expr {$$ = [$1];};
