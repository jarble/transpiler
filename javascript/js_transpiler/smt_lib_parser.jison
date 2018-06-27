/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"Array"               return 'Array'
"implies"             return 'implies'
"define-fun"          return 'define-fun'
"declare-const"       return 'declare-const'
"forall"              return 'forall'
"not"                 return 'not'
"ite"                 return 'ite'
"if"                  return 'if'
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
 
statements: statements_ {$$ = ["top_level_statements",$1]};

statement:
	"(" "declare-const" IDENTIFIER type ")" {$$ = ["semicolon",["initialize_empty_vars",$4,[$3]]];}
	| "(" "define-fun" IDENTIFIER "(" parameters ")" type statement ")" {$$ = ["function","public",$7,$3,$5,$8]}
    | e {$$=["statements",[["semicolon",["return",$1]]]];}
    | "(" "if" e e e ")" {$$ = ["ternary_operator",$3,$4,$5];}
    | "(" "ite" e e e ")" {$$ = ["ternary_operator",$3,$4,$5];};

type:
	"(" "Array" type type ")" {$$ = ["Array",[$3,$4]];}
	| IDENTIFIER;


equal_exprs: equal_exprs e {$$ = ["logic_equals",$1,$2]} | e;
times_exprs: times_exprs e {$$ = ["*",$1,$2]}  | e;
divide_exprs: divide_exprs e {$$ = ["/",$1,$2]}  | e;
plus_exprs: plus_exprs e {$$ = ["+",$1,$2]} | e;
minus_exprs: minus_exprs e {$$ = ["-",$1,$2]} | e;
and_exprs: and_exprs e {$$ = ["logic_and",$1,$2]} | e;
or_exprs: or_exprs e {$$ = ["logic_or",$1,$2]} | e;

logic_operator: ">" | "<" | ">=" | "<=";

implication: "=>"|"implies";

e:
    '(' implication e e ')' {$$ = ["implies",$3,$4];}
    | '(' logic_operator e e ')' {$$ = [$2,$3,$4];}
    | '(' '=' e equal_exprs ')' {$$ = ["logic_equals",$3,$4];}
    | '(' '*' e times_exprs ')' {$$ = [$2,$3,$4];}
    | '(' '+' e plus_exprs ')' {$$ = [$2,$3,$4];}
	| '(' '-' e minus_exprs ')' {$$ = [$2,$3,$4];}
    | '(' '/' e divide_exprs ')' {$$ = [$2,$3,$4];}
    | '(' 'or' e or_exprs ')' {$$ = ["logic_or",$3,$4];}
    | '(' 'and' e and_exprs ')' {$$ = ["logic_and",$3,$4];}
    | '(' 'not' e ')' {$$ = ["!",$3];}
    | '(' "forall" '(' forall_parameters ')' e ')' {$$ = ['z3_forall',$4,$6];}
    | function_call
    | NUMBER
        {$$ = yytext;}
    | var_name
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

forall_parameter: IDENTIFIER type {$$ = ["forall_parameter", $2,$1];};
forall_parameters: forall_parameters forall_parameter {$$ = $1.concat([$2]);} | forall_parameter {$$ =
 [$1];};


parameter: '(' var_name type ')' {$$ = [$3, $2];};
parameters: parameters parameter {$$ = $1.concat([$2]);} | parameter {$$ =
 [$1];};

function_call:
    "(" IDENTIFIER ")" {$$ = ["function_call",$2,[]];} | "(" IDENTIFIER exprs ")" {$$ = ["function_call",$2,$3];};

var_name: IDENTIFIER;

exprs: exprs e {$$ = $1.concat([$2]);} | e {$$ = [$1];};
