/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"'("                  return "'("
"defn"                return 'defn'
"not"                 return 'not'
"and"                 return 'and'
"cond"                return 'cond'
":else"               return ':else'
"?"                   return '?'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"=>"                  return '=>'
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

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};

statements: statements_ {$$ = ["top_level_statements",$1]};

statement:
	"(" "defn" IDENTIFIER "[" parameters "]" statement ")" {$$ = ["function","public","Object",$3,$5,$7]}
    | e {$$=["statements",[["semicolon",["return",$1]]]];}
    | "(" "if" e bracket_statements bracket_statements ")" {$$ = ["if",$3,$4];}
    | "(" "cond" e bracket_statements elif ")" {$$ = ["if",$3,$4,$5];};

elif:
	e bracket_statements elif {$$ = ["elif",$1,$2,$3]}
	| ":else" bracket_statements {$$ = ["else",$2];};

bracket_statements: statement {$$= ["statements",[$1]];};


operator:
	| "not" {$$ = "!"}
	| "or" {$$ = "logic_or";}
	| "and" {$$ = "logic_and";}
	| "*"
	| "/"
	| "+"
	| "-"
	| comparison_operator;

comparison_operator:
	">="
	| ">"
	| "<="
	| "<";

equal_exprs: equal_exprs e {$$ = ["logic_equals",$1,$2]} | e;
times_exprs: times_exprs e {$$ = ["*",$1,$2]}  | e;
divide_exprs: divide_exprs e {$$ = ["/",$1,$2]}  | e;
plus_exprs: plus_exprs e {$$ = ["+",$1,$2]} | e;
minus_exprs: minus_exprs e {$$ = ["-",$1,$2]} | e;
and_exprs: and_exprs e {$$ = ["logic_and",$1,$2]} | e;
or_exprs: or_exprs e {$$ = ["logic_or",$1,$2]} | e;

e:
    '(' '=' e equal_exprs ')' {$$ = [$2,$3,$4];}
    | '(' '*' e times_exprs ')' {$$ = [$2,$3,$4];}
    | '(' '+' e plus_exprs ')' {$$ = [$2,$3,$4];}
	| '(' '-' e minus_exprs ')' {$$ = [$2,$3,$4];}
    | '(' '/' e divide_exprs ')' {$$ = [$2,$3,$4];}
    | '(' 'or' e or_exprs ')' {$$ = ["||",$3,$4];}
    | '(' 'and' e and_exprs ')' {$$ = ["&&",$3,$4];}
    | '(' comparison_operator e e ')' {$$ = [$2,$3,$4];}
    | function_call
    | "'(" exprs ")" {$$ = ["initializer_list","Object",$2]}
    | NUMBER
        {$$ = yytext;}
    | var_name
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

parameter: var_name {$$ = ["Object", $1];};
parameters: parameters parameter {$$ = $1.concat([$2]);} | parameter {$$ =
 [$1];};

function_call:
    "(" IDENTIFIER ")" {$$ = ["function_call",$2,[]];} | "(" IDENTIFIER exprs ")" {$$ = ["function_call",$2,$3];};

var_name: IDENTIFIER;

exprs: exprs e {$$ = $1.concat([$2]);} | e {$$ = [$1];};
