/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"forall"              return 'forall'
"copy_term"           return 'copy_term'
"if"                  return "if"
"type"                return 'type'
"func"                return 'func'
"is"                  return "is"
","                   return ','
";"                   return ';'
"--->"                return '--->'
"==>"                 return '==>'
"<=>"                 return '<=>'
"@"                   return '@'
"-->"                 return '-->'
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

%left '->'
%left ';'
%left ','
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
    : ":-" "type" IDENTIFIER "--->" data_type_or {$$ = ["algebraic_data_type",$2,$5];}
| IDENTIFIER "(" exprs ")" "=" statements {
		$$ = ["function","public","Object",$1,$3,$6];
	}
 | predicate;

types: IDENTIFIER "," types {$$ = [$1].concat($3);} | IDENTIFIER {$$ =
 [$1];};

data_type_or: data_type_or ";" IDENTIFIER {$$ = ["data_type_or",$1,$3];} | IDENTIFIER;

predicate:
    IDENTIFIER "(" exprs ")" ":-" e {$$ = ["function","public","boolean",$1,$3,["statements",[["semicolon",["return",$6]]]]]}
    | IDENTIFIER ":-" e {$$ = ["function","public","boolean",$1,[],["statements",[["semicolon",["return",$3]]]]]};

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
        {$$ = ['set_var',$1,$3];}
    |e '\\=' e
        {$$ = ['!=',$1,$3];}
    |e '==' e
        {$$ = [$2,$1,$3];}
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
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | not_expr
    ;

not_expr: "\+" parentheses_expr {$$ = ["!",$2];} | parentheses_expr {$$ = $1;};

parameter: IDENTIFIER {$$ = ["Object", $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};

function_call:
    IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];} | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];};

forall_statement: "forall" "(" e "," e ")" {$$ = ["forall",$3,$5];};

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

chr_head: chr_head "," function_call {$$ = ["logic_and",$1,$3];} | function_call {$$ = [$1];};

chr_statement:
	function_call "," chr_head "==>" e {$$= ["propagation_rule",["&&",$1,$3],$5]}
	| function_call "==>" e {$$= ["propagation_rule",$1,$3]}
	| IDENTIFIER "@" function_call "," chr_head "==>" e {$$= ["defrule",$1,["&&",$3,$5],$7]}
	| IDENTIFIER "@" function_call "==>" e {$$= ["defrule",$1,$3,$5]}
	| function_call "," chr_head "<=>" e {$$= ["simplification_rule",["&&",$1,$3],$5]}
	| function_call "<=>" e {$$= ["simplification_rule",$1,$3]}
    | IDENTIFIER "@" function_call "," chr_head "<=>" e {$$= ["named_simplification_rule",$1,["&&",$3,$5],$7]}
    | IDENTIFIER "@" function_call "<=>" e {$$= ["named_simplification_rule",$1,$3,$5]};
