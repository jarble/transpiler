/* lexical grammar */
%lex
%%

(\s+|\;+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\"    return 'STRING_LITERAL'
"defrule"             return 'defrule'
"deffunction"         return 'deffunction'
"assert"              return 'assert'
"default"             return 'default'
"switch"              return 'switch'
"not"                 return 'not'
"and"                 return 'and'
"if"                  return 'if'
"then"                return 'then'
"else"                return 'else'
"case"                return 'case'
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

expressions: top_level_statements_ EOF {return ["top_level_statements",$1]};

top_level_statements_: top_level_statement top_level_statements_ {$$ = [$1].concat($2);} | top_level_statement {$$ =
 [$1];};
 
top_level_statements: top_level_statements_ {$$ = ["top_level_top_level_statements",$1]};

top_level_statement
    : defrule
    | "(" "deffunction" IDENTIFIER "(" parameters ")" statements ")" {$$ = ["function","public","Object",$3,$5,$7]};

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};
 
statements:
	statements_ {$$ = ["statements",$1]}
	;

statement:
	statement_with_semicolon {$$ = ["semicolon",$1]}
	| "(" "if" e "then" bracket_statements "else" bracket_statements ")" {$$ = ["if",$3,$5,["else",$7]];}
	| "(" "switch" e case_statements ")" {$$ = ["switch",$3,$4];}
	;

bracket_statements: statement {$$= ["statements",[$1]];};

case_statement: "(" "case" e "then" bracket_statements ")" {$$ = ["case",$3,$5]};
case_statements_: case_statements_ case_statement {$$ = $1.concat([$2]);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "(" "default" bracket_statements ")" {$$ = $1.concat([["default",$4]])} | case_statements_;

statement_with_semicolon:
	e {$$ = ["return",$1];}
	;

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
    | '(' comparison_operator e e ')' {$$ = [$2,$3,$4];}
    | '(' 'or' e or_exprs ')' {$$ = ["logic_or",$3,$4];}
    | '(' 'and' e and_exprs ')' {$$ = ["logic_and",$3,$4];}
    | function_call
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

var_name: "?" IDENTIFIER {$$ = $2};

exprs: exprs e {$$ = $1.concat([$2]);} | e {$$ = [$1];};

defrule:
	"(" "defrule" IDENTIFIER e "=>" "(" "assert" e ")" ")" {$$= ["defrule",$3,$4,$8]};
