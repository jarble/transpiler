/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"forall"              return 'forall'
"copy_term"           return 'copy_term'
"if"                  return "if"
"is"                  return "is"
","                   return ','
"&"                   return '&'
"|"                   return '|'
"<=>"                 return '<=>'
"!"                   return "!"
"?"                   return "?"
"@"                   return '@'
"=>"                  return '=>'
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
"~"                   return '~'
"\\="                 return '\\='
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

%left '=>' '<=>'
%left '|'
%left '&'
%left '<' '=<' '>' '>=' '=' '==' '\\=' 'is'
%left '+' '-'
%left '*' '/'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: top_level_statements_ EOF {return ["top_level_statements",$1]};

top_level_statements_: top_level_statement "." top_level_statements_ {$$ = [$1].concat($3);} | top_level_statement "." {$$ =
 [$1];};
 
top_level_statements: top_level_statements_ {$$ = ["top_level_statements",$1]};

top_level_statement
    : forall_statement | function_call;
e
    :
    e '<=>' e
        {$$ = ['iff',$1,$3];}
    |e '=>' e
        {$$ = ["implies",$1,$3]}
    |e '|' e
        {$$ = ['logic_or',$1,$3];}
    |e '&' e
        {$$ = ['logic_and',$1,$3];}
    |e '=' e
        {$$ = ['logic_equals',$1,$3];}
    |e '\\=' e
        {$$ = ['!=',$1,$3];}
    |e '=<' e
        {$$ = ['<=',$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
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
    | not_expr
    ;

not_expr: "~" parentheses_expr {$$ = ["!",$2];} | parentheses_expr {$$ = $1;};

parameter: IDENTIFIER {$$ = ["Object", $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};

function_call:
    IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];} | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];};

forall_statement: "(" "!" "[" e "]" ":" e ")" {$$ = ["forall",$4,$7];};

parentheses_expr:
    forall_statement
    | function_call
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
