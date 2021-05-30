/* lexical grammar */
%lex
%%

\s+                                   /* IGNORE */
"//".*                                /* IGNORE */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* IGNORE */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
":="                  return ':='
"func"                return "func"
"type"                return "type"
"range"               return "range"
"struct"              return "struct"
"interface"           return 'interface'
"public"              return "public"
"extends"             return "extends"
"implements"          return "implements"
"private"             return "private"
"static"              return "static"
"if"                  return 'if'
"else"                return 'else'
"return"              return 'return'
"while"               return 'while'
"for"                 return 'for'
"var"                 return 'var'
"of"                 return 'of'
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
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
"%"                   return '%'
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

%left '||'
%left '&&'
%left '<' '<=' '>' '>='
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: top_level_statements EOF {return ["top_level_statements",$1]};

statements_: statements_with_vars | initialize_vars statements_with_vars {$$ = [["lexically_scoped_vars",$1,["statements",$2]]]};
statements_without_vars: statements_without_vars statement {$$ = $1.concat($3);} | statement {$$ =
 [$1];};
statements_with_vars: statements_without_vars initialize_var1 {$$ = $1.concat([["semicolon",$2]]);} | statements_without_vars;
initialize_vars: initialize_vars initialize_var {$$ = $1.concat([$2]);} | initialize_var {$$ =
 [$1];};
 

statements: statements_ {$$ = ["statements",$1]};
struct_statements: struct_statement struct_statements {$$ = [$1].concat($2);} | struct_statement {$$ =
 [$1];};
 
struct_statement: identifiers type_ {$$ = ["struct_statement",$2,$1];} | IDENTIFIER "(" parameters ")" IDENTIFIER {$$ = ["interface_instance_method","public",$5,$1,$3];}
;



access_modifier: "public" | "private";

top_level_statement:
	statement | initialize_var1 {$$ = ["semicolon",$1]};
top_level_statements: top_level_statements top_level_statement {$$ = $1.concat([$2]);} | top_level_statement {$$ =
 [$1];};
statement
    :
    statement_with_semicolon {$$ = ["semicolon",$1];}
    | "type" IDENTIFIER "struct" "{" struct_statements "}" {$$ = ["struct",$1,$5]}
    | "type" IDENTIFIER "interface" "{" struct_statements "}" {$$ = ["interface","public",$2,$5]}
    | "for" e "{" statements "}" {$$ = ["while",$2,$4];}
    | "for" "_" "," IDENTIFIER ":=" "range" dot_expr "{" statements "}" {$$ = ["foreach","Object",$4,$7,$9];}
    | "for" IDENTIFIER "," IDENTIFIER ":=" "range" dot_expr "{" statements "}" {$$ = ["foreach_with_index","Object",$2,$4,$7,$9];}
    | if_statement
    | "func" IDENTIFIER "(" parameters ")" "(" IDENTIFIER type_ ")" "{" statements "}" {$$ = ["function_with_retval",$7,"public",$8,$2,$4,$11];}
    | "func" IDENTIFIER "(" parameters ")" type_ "{" statements "}" {$$ = ["function","public",$6,$2,$4,$8];}
    ;



statement_with_semicolon
   : 
   "return" e  {$$ = ["return",$2];}
   | IDENTIFIER ":=" e {$$ = ["initialize_var","Object",$1,$3];}
   | "var" identifiers IDENTIFIER {$$ = ["initialize_empty_vars",$3,$2];}
   | parallel_assignment
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "++" {$$ = [$2,$1];}
   | IDENTIFIER "--" {$$ = [$2,$1];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   | function_call "." dot_expr {$$ = [".",[$1].concat($3)]}
   | IDENTIFIER "." dot_expr {$$ = [".",[$1].concat($3)]}
   | function_call
   ;

parallel_assignment:
	parallel_lhs,":=",parallel_rhs {$$ = ["parallel_assignment",["parallel_lhs",$1],["parallel_rhs",$3]]};

parallel_lhs: parallel_lhs "," IDENTIFIER {$$ = [$1.concat([$3])];} | IDENTIFIER "," IDENTIFIER {$$ = [$1,$3]};
parallel_rhs: parallel_rhs "," e {$$ = [$1.concat([$3])];} | e "," e {$$ = [$1,$3]};

initialize_var1: initialize_var_ {$$ = ["initialize_var"].concat($1);};
initialize_var: initialize_var_ {$$ = ["lexically_scoped_var"].concat($1);};
initialize_var_:
	"var" IDENTIFIER "=" e {$$ = ["Object",$2,$4];};
e
    :
    e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e '<=' e
        {$$ = [$2,$1,$3];}
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
    | e '%' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | dot_expr {$$ = [".", $1];}
    ;


dot_expr: parentheses_expr "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: IDENTIFIER "[" access_arr "]" {$$ = ["access_array",$1,$3];};


function_call: IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];}
    | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];};

parentheses_expr:
    "function" "(" parameters ")" "{" statements "}" {$$ = ["anonymous_function","Object",$3,$6]}
    | access_array
    | function_call
    | "[" "]" {$$ = ["initializer_list","Object",[]];} | "[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    | "(" e ")" {$$ = $2;}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

type_: IDENTIFIER "[" "]" {$$ = [$1,"[]"];} | IDENTIFIER;
parameter: identifiers type_ {$$ = [$2, $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};
access_arr: parentheses_expr "][" access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type_ "," types {$$ = [$1].concat($3);} | type_ {$$ = [$1];};
elif: "else" "if" e "{" statements "}" elif {$$ = ["elif",$3,$5,$7]}| "else" "{" statements "}" {$$ = ["else",$3];};
if_statement:
"if" e "{" statements "}" elif {$$ = ["if",$2,$4,$6];}
|  "if" e "{" statements "}" {$$ = ["if",$2,$4];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};
