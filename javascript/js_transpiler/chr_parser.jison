/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"if"                  return "if"
"else"                return "else"
"return"              return "return"
"void"                return "void"
"printf"              return "printf"
"while"               return "while"
"for"                 return "for"
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"==>"                 return '==>'
"@"                   return '@'
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

%left ';'
%left ','
%left '<' '<=' '>' '>='
%left '+' '-'
%left '*' '/'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};
 

statements: statements_ {$$ = ["statements",$1]};



statement
    : if_statement ".";

e
    :
    e ';' e
        {$$ = ['||',$1,$3];}
    |e ',' e
        {$$ = ['&&',$1,$3];}
    |e '<=' e
        {$$ = ['>=',$1,$3];}
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

parentheses_expr:
    IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];}
    |  IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | '(' e ')' {$$ = $2;}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

exprs: parentheses_expr "," exprs {$$ = [$1].concat($3);} | parentheses_expr {$$ = [$1];};
if_statement:
    IDENTIFIER "@" e "==>" e {$$= ["defrule",$1,$3,$5]}
    | e "==>" e {$$= ["implies",$1,$3]};

