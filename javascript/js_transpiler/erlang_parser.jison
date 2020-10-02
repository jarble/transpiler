/* lexical grammar */
%lex
%%

\s+                                   /* IGNORE */
"%".*                                /* IGNORE */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"case"                return 'case'
"of"                  return 'of'
"or"                  return "or"
"if"                  return "if"
"and"                 return "and"
"andalso"             return "andalso"
"end"                 return "end"
","                   return ','
";"                   return ';'
"||"                  return '||'
"->"                  return '->'
"."                   return '.'
":"                   return ':'
">="                  return '>='
">"                   return '>'
"=<"                  return '=<'
"<-"                  return '<-'
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
"_"                   return '_'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '->'
%left 'or'
%left 'and'
%left '<' '=<' '>' '>=' '=='
%left '+' '-'
%left '*' '/'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: top_level_statements EOF {return ["top_level_statements",$1]};

statements: statements_ {$$ = ["statements",$1]};

statements_: statements_without_vars | initialize_vars "," statements_without_vars {$$ = [["lexically_scoped_vars",$1,["statements",$3]]]};
statements_without_vars: statements_without_vars "," statement {$$ = $1.concat([$3]);} | statement {$$ =
 [$1];};
initialize_vars: initialize_vars "," initialize_var {$$ = $1.concat([$3]);} | initialize_var {$$ =
 [$1];};

top_level_statements: top_level_statement "." top_level_statements {$$ = [$1].concat($3);} | top_level_statement "." {$$ =
 [$1];};

top_level_statement
    : IDENTIFIER "(" exprs ")" "->" statements {$$ = ["function","public","Object",$1,$3,$6]}
    | IDENTIFIER "(" ")" "->" statements {$$ = ["function","public","Object",$1,[],$5]}
    | IDENTIFIER "->" statements {$$ = ["function","public","Object",$1,[],$3]}
    | function_call
    ;
statement:
	statement_with_semicolon {$$ = ["semicolon",$1];}
	| if_statement
	| "case" e "of" case_statements "end" {$$ = ["switch",$2,$4];};

statement_with_semicolon:
	e {$$= ["return",$1];};

initialize_var1: initialize_var_ {$$ = ["initialize_var"].concat($1);};
initialize_var: initialize_var_ {$$ = ["lexically_scoped_var"].concat($1);};   
initialize_var_: IDENTIFIER "=" e {$$ = ["Object",$1,$3];};

e
    :
    e 'or' e
        {$$ = ['||',$1,$3];}
    |e 'and' e
        {$$ = ['&&',$1,$3];}
    |e '==' e
        {$$ = ['==',$1,$3];}
    |e '=<' e
        {$$ = ['<=',$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e '>=' e
        {$$ = [$2,$1,$3];}
    |e '>' e
        {$$ = [$2,$1,$3];}
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
    | dot_expr {$$ = [".",$1];}
    ;

function_call:
    IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];} | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];};

parentheses_expr:
	"[" e "||" e "<-" list_comprehensions "," e "]" {$$=["list_comprehension",$2,$4,$6,$8];}
    |"[" e "||" e "<-" list_comprehensions "]" {$$=["list_comprehension",$2,$4,$6];}
    | "[" "]" {$$ = ["initializer_list","Object",[]];}
    | "[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    | "[" e "|" exprs "]" {$$ = ["list_head_tail","Object",$2,["initializer_list","Object",$4]];}
    |function_call
    |"(" e "," exprs ")" {$$ = ["initialize_tuple","Object",[$2].concat($4)];}
    | '(' e ')' {$$ = $2;}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}  
    | STRING_LITERAL
        {$$ = yytext;};

list_comprehensions: list_comprehensions "," e "<-" e {$$ = ["list_comprehensions",$1,$3,$5];} | e;

dot_expr: parentheses_expr ":" dot_expr  {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

exprs: exprs "," e {$$ = $1.concat([$3]);} | e {$$ = [$1];};

elif: e "->" statements {$$ = ["elif",$1,$3];} | e "->" statements ";" elif {$$ = ["elif",$1,$3,$5]};
if_statement:
"if" e "->" statements ";" elif "end" {$$ = ["if",$2,$4,$6];};

case_statement: e "->" statements ";" {$$ = ["case",$1,$3]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "_" "->" statements {$$ = $1.concat([["default",$4]])};

