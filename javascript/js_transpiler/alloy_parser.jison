/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"otherwise"           return "otherwise"
"if"                  return "if"
"of"                  return 'of'
"in"                  return "in"
"let"                 return "let"
"else"                return "else"
"fun"                 return "fun"
"case"                return "case"
"then"                return "then"
"sig"                 return "sig"
"return"              return "return"
"mod"                 return 'mod'
","                   return ','
";"                   return ';'
"."                   return '.'
"::"                  return '::'
":"                   return ':'
"&&"                  return '&&'
"implies"             return '->'
"||"                  return '||'
"|"                   return '|'
"\\"                  return '\\'
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

%left '||' 'implies'
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
data_type_and: data_type_and IDENTIFIER {$$ = ["data_type_and",$1,$2];} | IDENTIFIER {$$ = $1;};

struct_statements: struct_statement "," struct_statements {$$ = [$1].concat($3);} | struct_statement {$$ =
 [$1];};
 
struct_statement: identifiers "::" type {$$ = ["struct_statement",$3,$1];};

statement_:
	"sig" IDENTIFIER "{" struct_statements "}" {$$ = ["struct",$2,["struct_statements",$4]]}
	| "fun" IDENTIFIER "[" parameters "]" ":" IDENTIFIER "{" statements "}" {$$ = ["function","public",$7,$2,$4,$9];}
        | IDENTIFIER "=" statements {$$ = ["function","public","Object",$1,[],$3];}
        | IDENTIFIER guard_if_statement {$$ = ["function","public","Object",$1,[],$2];};

types: IDENTIFIER "->" types {$$ = [$1].concat($3);} | IDENTIFIER {$$ =
 [$1];};

statement:
	statement_with_parentheses {$$ = $1;}
    | statement_with_semicolon {$$ = ["semicolon",$1];};

statement_with_parentheses:
    "if" e "then" statements elif {$$ = ["if",$2,$4,$5];}
	| "case" parentheses_expr "of" case_statements {$$ = ["switch",$2,$4];}
	| "let" declare_vars "in" statements {$$ = ["lexically_scoped_vars",$2,$4];}
	| "(" statement_with_parentheses ")" {$$ = $2};

case_statement: parentheses_expr "->" statements {$$ = ["case",$1,$3]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};

case_statements: case_statements_ "_" "->" statements {$$ = $1.concat([["default",["statements",$4]]])};


declare_var: IDENTIFIER "=" e {$$ = ["lexically_scoped_var","Object",$1,$3]};
declare_vars: declare_var declare_vars {$$ = [$1].concat($2);} | declare_var {$$ =
 [$1];};

statement_with_semicolon
   :
   e  {$$ = ["return",$1];}
   ;
e
    :
    e '||' e
        {$$ = [$2,$1,$3];}
    e 'implies' e
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
    "(" "\\" parameters "->" e ")" {$$ = ["anonymous_function","Object",$3,["statements",[["semicolon",["return",$5]]]]];}
    |"(" access_array ")" {$$ = $2}
    |"(" e "," exprs ")" {$$ = ["initialize_tuple","Object",[$2].concat($4)];}
    |"[" "]" {$$ = ["initializer_list","Object",[]];}
    |"[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    |"[" e "|" e "<-" list_comprehensions "]" {$$ = ["list_comprehension",$2,$4,$6];}
    |"[" e "|" e "<-" list_comprehensions "," e "]" {$$ = ["list_comprehension",$2,$4,$6,$8];}
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
parameter: IDENTIFIER ":" IDENTIFIER {$$ = [$3,$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];};
access_arr: parentheses_expr "!!" access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
args: parentheses_expr args {$$ = [$1].concat($2);} | parentheses_expr {$$ = [$1];};
elif: "else" statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

guard_if_statement:
	"|" e "=" statements guard_elif {$$ = ["if",$2,$4,$5];};
guard_elif:
	"|" e "=" statements guard_elif {$$ = ["elif",$2,$4,$5];}
	| "|" "otherwise" "=" statements {$$ = ["else",$4];};

statements: statement {$$ = ["statements",[$1]]};
