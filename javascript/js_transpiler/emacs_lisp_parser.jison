/* lexical grammar */
%lex
%%

(\s+|\;+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"'("                  return "'("
"defmacro"            return 'defmacro'
"defun"               return 'defun'
"while"               return 'while'
"cond"                return 'cond'
"loop"                return 'loop'
"setf"                return 'setf'
"setq"                return 'setq'
"if"                  return 'if'
"do"                  return 'do'
"t"                   return 't'
"let"                 return 'let'
"not"                 return 'not'
"and"                 return 'and'
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
 
statements: statements_ {$$ = ["statements",$1]};

statement:
	"(" "defun" IDENTIFIER "(" parameters ")" statement ")" {$$ = ["function","public","Object",$3,$5,$7]}
    | "(" "defmacro" IDENTIFIER "(" exprs ")" statement ")" {$$ = ["macro",$3,$5,$7];}
    | statement_with_semicolon {$$=["semicolon",$1];}
    | "(" "cond" "(" e bracket_statements ")" elif ")" {$$ = ["if",$4,$5,$7];}
	| "(" "if" e bracket_statements ")" {$$ = ["if",$3,$4];}
	| "(" "if" e bracket_statements bracket_statements ")" {$$ = ["if",$3,$4];}
	| "(" "let" "(" declare_vars ")" bracket_statements ")" {$$ = ["lexically_scoped_vars",$4,["statements",$6]];}
	| "(" "loop" "while" e "do" statements ")" {$$ = ["while",$4,$6];}
	| "(" "loop" "do" statements "while" e ")" {$$ = ["do_while",$4,$6];}
	;

declare_var: "(" IDENTIFIER e ")" {$$ = ["lexically_scoped_var","Object",$2,$3]};
declare_vars: declare_var declare_vars {$$ = [$1].concat($2);} | declare_var {$$ =
 [$1];};
 

statement_with_semicolon:
	e {$$ = ["return",$1]}
	| "(" "setf" e e ")" {$$ = ["set_var",$3,$4];}
	| "(" "setq" e e ")" {$$ = ["set_var",$3,$4];};
	

bracket_statements: statement {$$= ["statements",[$1]];};


elif:
	"(" e bracket_statements ")" elif {$$ = ["elif",$2,$3,$5]}
	| "(" "t" bracket_statements ")" {$$ = ["else",$3];};

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
    '(' '=' e equal_exprs ')' {$$ = ["==",$3,$4];}
	| "(" "lambda" IDENTIFIER "(" parameters ")" statement ")" {$$ = ["function","public","Object",$3,$5,$7]}
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
