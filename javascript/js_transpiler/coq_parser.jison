/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"Fixpoint"            return 'Fixpoint'
"Definition"          return 'Definition'
"Lemma"               return 'Lemma'
"forall"              return 'forall'
"if"                  return "if"
"is"                  return "is"
","                   return ','
"\\/"                  return '\\/'
"/\\"                 return '/\\'
"==>"                 return '==>'
"<=>"                 return '<=>'
"->"                  return '->'
":="                  return ':='
":-"                  return ':-'
":"                   return ':'
"."                   return '.'
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
%left '\\/'
%left '/\\'
%left '<' '=<' '>' '>=' '=' '==' 'is'
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
    : predicate
    | "Lemma" IDENTIFIER ":" e {$$ = ["lemma",$2,$4]}
    | "Class" IDENTIFIER ID;

statement:
	statement_with_semicolon {$$ = ["semicolon",$1];};

statement_with_semicolon:
	e {$$=["return", $1];};
	
statements: statement {$$ = ["statements",[$1]];};

predicate:
    "Fixpoint" IDENTIFIER parameters ":" IDENTIFIER ":=" statements {$$ = ["function","public",$5,$2,$3,$7]}
    | "Definition" IDENTIFIER parameters ":" IDENTIFIER ":=" statements {$$ = ["function","public",$5,$2,$3,$7]};


e
    :
    e '->' e
        {$$ = ["implies",$1,$3]}
    |e '\\/' e
        {$$ = ['||',$1,$3];}
    |e '/\\' e
        {$$ = ['&&',$1,$3];}
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
    | "(" "forall" IDENTIFIER ":" IDENTIFIER "," e ")" {$$ = ["forall",["instanceof",$5,$3],$7];}
    | "(" "forall" "(" IDENTIFIER ":" IDENTIFIER ")" "," e ")" {$$ = ["forall",["instanceof",$4,$6],$9];}
    | parentheses_expr
    ;

parameter: "(" IDENTIFIER ":" IDENTIFIER ")" {$$ = [$4, $2];};
parameters: parameter parameters {$$ = [$1].concat($2);} | parameter {$$ =
 [$1];};

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

exprs: exprs "," parentheses_expr {$$ = $1.concat([$3]);} | parentheses_expr {$$ = [$1];};
