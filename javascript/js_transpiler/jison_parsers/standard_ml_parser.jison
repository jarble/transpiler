/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"otherwise"           return "otherwise"
"if"                  return 'if'
"of"                  return 'of'
"in"                  return "in"
"let"                 return "let"
"end"                 return "end"
"val"                 return 'val'
"fun"                 return 'fun'
"else"                return 'else'
"case"                return 'case'
"then"                return "then"
"data"                return "data"
"return"              return "return"
"mod"                 return 'mod'
","                   return ','
";"                   return ';'
"."                   return '.'
"::"                  return '::'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
"|"                   return '|'
"\\"                  return '\\'
">="                  return '>='
">"                   return '>'
"<>"                  return '<>'
"<="                  return '<='
"<-"                  return '<-'
"->"                  return '->'
"=>"                  return '=>'
"<"                   return '<'
"="                   return '='
"*="                  return '*='
"**"                  return '**'
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
"!!"                  return '!!'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
"~"                   return '~'
"_"                   return '_'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '||'
%left '&&'
%left '<' '<=' '>' '>=' '<>' '='
%left '+' '-' '++'
%left '*' '/' 'mod'
%left '**'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement_ statements_ {$$ = [$1].concat($2);} | statement_ {$$ =
 [$1];};
 
data_type_or: data_type_or "|" IDENTIFIER {$$ = ["data_type_or",$1,$3];} | IDENTIFIER;

statement_:
	"fun" IDENTIFIER "(" parameters ")" ":" type "=" statement {$$ = ["function","public",$7,$2,$4,$9];}
	| "fun" IDENTIFIER "(" parameters ")" "=" statement {$$ = ["function","public","Object",$2,$4,$7];}
	| initialize_var;

types: IDENTIFIER "->" types {$$ = [$1].concat($3);} | IDENTIFIER {$$ =
 [$1];};

statements: statement {$$ = ["statements",[$1]];};

statement:
    "case" e "of" case_statements {$$ = ["switch",$2,$4];}
    | "if" e "then" statements elif {$$ = ["if",$2,$4,$5];}
	| "let" declare_vars "in" statements "end" {$$ = ["lexically_scoped_vars",$2,["statements",$4]];}
    | statement_with_semicolon {$$ = ["semicolon",$1];};

initialize_var: "val" IDENTIFIER "=" e ":" type {$$ = ["lexically_scoped_var",$6,$2,$4]}
| "val" IDENTIFIER "=" e {$$ = ["lexically_scoped_var","Object",$2,$4]};
statement_with_semicolon
   :
   e  {$$ = ["return",$1];}
   | initialize_var
   ;

case_statement: e "=>" statements "|" {$$ = ["case",$1,$3]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};

case_statements: case_statements_ "_" "=>" statements {$$ = $1.concat([["default",$4]])};

declare_var: "val" IDENTIFIER "=" e ":" type {$$ = ["lexically_scoped_var",$6,$2,$4]} | "val" IDENTIFIER "=" e {$$ = ["lexically_scoped_var","Object",$2,$4]};
declare_vars: declare_var declare_vars {$$ = [$1].concat($2);} | declare_var {$$ =
 [$1];};

e
    :
    e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e '=' e
        {$$ = ['==',$1,$3];}
    |e '<>' e
        {$$ = ['!=',$1,$3];}
    |e '<=' e
        {$$ = [$2,$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e '>=' e
        {$$ = [$2,$1,$3];}
    |e '>' e
        {$$ = [$2,$1,$3];}
    | e '++' e
        {$$ = [$2,$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | e 'mod' e
        {$$ = ["%",$1,$3];}
	| e '**' e
        {$$ = [$2,$1,$3];}
    | '~' e %prec UMINUS
        {$$ = ["-",$2];}
    | parentheses_expr {$$ = $1;}
    ;


access_array: IDENTIFIER "!!" access_arr {$$ = ["access_array",$1,[$3]];};

parentheses_expr:
    "(" "\\" parameters "->" e ")" {$$ = ["anonymous_function","Object",$3,["statements",[["semicolon",["return",$5]]]]];}
    |"(" access_array ")" {$$ = $2}
    |"[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    |"[" e "|" e "<-" e "]" {$$ = ["list_comprehension",$2,$4,$6];}
    |"[" e "|" e "<-" e "," e "]" {$$ = ["list_comprehension",$2,$4,$6,$8];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
    | "(" e ")" {$$ = $2}
    | "(" IDENTIFIER args ")"
        {
			if($2 === "not"){
				$$ = ["!",$3];
			}
			else{
				$$ = ["function_call",$2,$3];
			}
		}
    | STRING_LITERAL
        {$$ = yytext;}
    ;

type: IDENTIFIER;
parameter: IDENTIFIER ":" IDENTIFIER {$$ = [$3, $1];} | IDENTIFIER {$$ = ["Object",$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];};
access_arr: parentheses_expr "!!" access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
args: parentheses_expr args {$$ = [$1].concat($2);} | parentheses_expr {$$ = [$1];};
elif: else_statement;

else_statement: "else" statement {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

