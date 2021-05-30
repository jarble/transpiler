/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"otherwise"           return "otherwise"
"if"                  return "if"
"of"                  return 'of'
"orelse"              return 'orelse'
"andalso"             return 'andalso'
"and"                 return 'and'
"in"                  return "in"
"let"                 return "let"
"else"                return "else"
"case"                return "case"
"then"                return "then"
"lam"                 return 'lam'
"inductive"           return "inductive"
"return"              return "return"
"end"                 return 'end'
"mod"                 return 'mod'
"def"                 return 'def'
","                   return ','
";"                   return ';'
"."                   return '.'
":="                  return ':='
"::"                  return '::'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
"|"                   return '|'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<-"                  return '<-'
"->"                  return '->'
"<"                   return '<'
"=="                  return '=='
"="                   return '='
"^"                   return '^'
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
"{"                   return '{'
"}"                   return '}'
"!!"                  return '!!'
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
%left '<' '<=' '>' '>=' '==' '/='
%left '+' '-' '++'
%left '*' '/' 'mod'
%left '**' '^'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement_ statements_ {$$ = [$1].concat($2);} | statement_ {$$ =
 [$1];};
 
data_type_or: data_type_or "|" IDENTIFIER {$$ = ["data_type_or",$1,$3];} | IDENTIFIER;

statement_:
	"inductive" IDENTIFIER "=" "|" data_type_or {$$ = ["algebraic_data_type",$2,$5];}
	| "def" IDENTIFIER "(" parameters ")" ":" IDENTIFIER ":=" statements {$$ = ["function","public",$7,$2,$4,$9];}
    | "def" IDENTIFIER ":=" statements {$$ = ["function","public","Object",$2,[],$4];};

statement:
	statement_with_parentheses {$$ = $1;}
    | statement_with_semicolon {$$ = ["semicolon",$1];};

statement_with_parentheses:
    "if" e "then" statements elif {$$ = ["if",$2,$4,$5];}
	| "case" parentheses_expr "of" case_statements {$$ = ["switch",$2,$4];}
	| "let" declare_vars "in" statements "end" {$$ = ["lexically_scoped_vars",$2,$4];}
	| "(" statement_with_parentheses ")" {$$ = $2};

case_statement: parentheses_expr "=>" statements {$$ = ["case",$1,$3]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};

case_statements: case_statements_ "_" "=>" statements {$$ = $1.concat([["default",["statements",$4]]])};


declare_var: IDENTIFIER "=" e {$$ = ["lexically_scoped_var","Object",$1,$3]};
declare_vars: declare_var "and" declare_vars {$$ = [$1].concat($3);} | declare_var {$$ =
 [$1];};

statement_with_semicolon
   :
   e  {$$ = ["return",$1];}
   ;
e
    :
    e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e '==' e
        {$$ = [$2,$1,$3];}
    |e '/=' e
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
    | e '^' e
        {$$ = ["**",$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | parentheses_expr {$$ = $1;}
    ;


access_array: IDENTIFIER "!!" access_arr {$$ = ["access_array",$1,[$3]];};

parentheses_expr:
    "(" "lam" "(" parameters ")" ":" IDENTIFIER "=>" e ")" {$$ = ["anonymous_function",$7,$4,["statements",[["semicolon",["return",$9]]]]];}
    |"(" access_array ")" {$$ = $2}
    |"[" "]" {$$ = ["initializer_list","Object",[]];}
    |"[" exprs "]" {$$ = ["initializer_list","Object",$2];}
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

list_comprehensions: list_comprehensions "," e "<-" e {$$ = ["list_comprehensions",$1,$3,$5];} | e;

type: IDENTIFIER;
parameter: IDENTIFIER ":" type {$$ = [$3, $1];};

parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];};
access_arr: parentheses_expr "!!" access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
args: parentheses_expr args {$$ = [$1].concat($2);} | parentheses_expr {$$ = [$1];};
elif: "else" statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

statements: statement {$$ = ["statements",[$1]]};
