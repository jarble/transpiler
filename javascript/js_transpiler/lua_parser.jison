/* lexical grammar */
%lex
%%

\s+                                   /* IGNORE */
"--".*                                /* IGNORE */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
"function"            return "function"
"end"                 return "end"
"then"                return "then"
"elseif"              return 'elseif'
"if"                  return 'if'
"else"                return 'else'
"return"              return 'return'
"while"               return 'while'
"for"                 return 'for'
"local"               return 'local'
"repeat"              return 'repeat'
"until"               return 'until'
"of"                  return 'of'
"not"                 return 'not'
","                   return ','
".."                  return '..'
"."                   return '.'
":"                   return ':'
"and"                 return 'and'
"or"                  return 'or'
">="                  return '>='
">>"                  return '>>'
">"                   return '>'
"<="                  return '<='
"<<"                  return '<<'
"<"                   return '<'
"~="                  return '~='
"=="                  return '=='
"="                   return '='
"*="                  return '*='
"*"                   return '*'
"/"                   return '/'
"%"                   return '%'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"{"                   return '{'
"}"                   return '}'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
"_"                   return '_'
"pairs"               return 'pairs'
"in"                  return 'in'
"do"                  return 'do'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left 'or'
%left 'and'
%left '<' '<=' '>' '>=' '==' '~='
%right '..'
%left '+' '-'
%left '*' '/' '%'
%right '^'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : statements_ EOF
        {return ["top_level_statements",$1];}
    ;

statements_: statements_with_vars | initialize_var_ {$$ = [["semicolon",["initialize_var"].concat($1)]]} | initialize_var_ statements_ {$$ = [["lexically_scoped_vars",[["lexically_scoped_var"].concat($1)],["statements",$2]]]};
statements_without_vars: statements_without_vars statement {$$ = $1.concat([$2]);} | statement {$$ =
 [$1];};
statements_with_vars: statements_without_vars initialize_var1 {$$ = $1.concat([["semicolon",$2]]);} | statements_without_vars;
initialize_vars: initialize_vars initialize_var {$$ = $1.concat([$2]);} | initialize_var {$$ =
 [$1];};


statements: statements_ {$$ = ["statements",$1]};

top_level_statement:
	statement | initialize_var1 {$$ = ["semicolon",$1]};
top_level_statements: top_level_statements top_level_statement {$$ = $1.concat([$2]);} | top_level_statement {$$ =
 [$1];};
statement
    :
    statement_with_semicolon {$$ = ["semicolon",$1];}
    | "while" e "do" statements "end" {$$ = ["while",$2,$4];}
    | "repeat" bracket_statements "until" e {$$ = ["do_while",$4,$2];}
    | "for" "_" "," IDENTIFIER "in" "pairs" "(" dot_expr ")" "do" statements "end" {$$ = ["foreach","Object",$4,$8,$11];}
    | "for" IDENTIFIER "," IDENTIFIER "in" "pairs" "(" dot_expr ")" "do" statements "end" {$$ = ["foreach_with_index","Object",$2,$4,$8,$11];}
    | "for" IDENTIFIER "," e "," e "do" statements "end" {$$ = ["for",$2,["<",$2,$4],["+=",$2,$6],$8];}
    | "if" e "then" statements elif "end" {$$ = ["if",$2,$4,$5];}
	| "if" e "then" statements "end" {$$ = ["if",$2,$4];}
    | "function" IDENTIFIER "(" parameters ")" statements "end" {$$ = ["function","public","Object",$2,$4,$6];}
    ;

statement_with_semicolon
   : 
   "return" e  {$$ = ["return",$2];}
   | "local" identifiers {$$ = ["initialize_empty_vars","Object",$2];}
   | parallel_assignment
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "." dot_expr {$$ = [".",[$1].concat($3)]}
   | function_call
   ;

parallel_assignment:
	parallel_lhs,"=",parallel_rhs {$$ = ["parallel_assignment",["parallel_lhs",$1],["parallel_rhs",$3]]};

parallel_lhs: parallel_lhs "," IDENTIFIER {$$ = [$1.concat([$3])];} | IDENTIFIER "," IDENTIFIER {$$ = [$1,$3]};
parallel_rhs: parallel_rhs "," e {$$ = [$1.concat([$3])];} | e "," e {$$ = [$1,$3]};

initialize_var1: initialize_var_ {$$ = ["initialize_var"].concat($1);};
initialize_var: initialize_var_ {$$ = ["lexically_scoped_var"].concat($1);};
initialize_var_:
	"local" IDENTIFIER "=" e {$$ = ["Object",$2,$4];};

e
    :
    e 'or' e
        {$$ = ['||',$1,$3];}
    |e 'and' e
        {$$ = ['&&',$1,$3];}
    |e '<=' e
        {$$ = [$2,$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e '>=' e
        {$$ = [$2,$1,$3];}
    | e '==' e
        {$$ = [$2,$1,$3];}
    | e '~=' e
        {$$ = ["!=",$1,$3];}
    |e '>' e
        {$$ = [$2,$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '..' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | e '%' e
        {$$ = [$2,$1,$3];}
    | e '^' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | "not" dot_expr {$$ = ["!", [".",$2]];} | dot_expr {$$ = [".", $1];}
    ;



dot_expr: parentheses_expr "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: parentheses_expr_ "[" e "]" {$$ = ["access_array",$1,[$3]];};

function_call:
    parentheses_expr_ "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr_ "(" exprs ")" {$$ = ["function_call",$1,$3];};

parentheses_expr_:
    "{" "}" {$$ = ["initializer_list","Object",[]];} | "{" exprs "}" {$$ = ["initializer_list","Object",$2];}
    | "{" key_values "}" {$$ = ["associative_array","Object","Object",$2];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

parentheses_expr:
    "function" "(" parameters ")" statements "end" {$$ = ["anonymous_function","Object",$3,$5];}
    | '(' e ')' {$$ = ["parentheses",$2];}
    | access_array
    | function_call
    | parentheses_expr_;



type: IDENTIFIER;
parameter: IDENTIFIER {$$ = ["Object", $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = [];};

exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif:
	"elseif" e "then" statements elif {$$ = ["elif",$2,$4,$5]} | "elseif" e "then" statements {$$ = ["elif",$2,$4]}
	| "else" statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: STRING_LITERAL "=" e {$$ = [$1,$3]} | IDENTIFIER "=" e {$$ = [$1,$3]};

