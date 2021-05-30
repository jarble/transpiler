/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"otherwise"           return "otherwise"
"if"                  return "if"
"of"                  return 'of'
"do"                  return 'do'
"in"                  return "in"
"let"                 return "let"
"val"                 return "val"
"for"                 return 'for'
"else"                return "else"
"loop"                return 'loop'
"case"                return "case"
"then"                return "then"
"data"                return "data"
"type"                return "type"
"return"              return "return"
"module"              return "module"
"mod"                 return 'mod'
","                   return ','
";"                   return ';'
"'"                   return "'"
"."                   return '.'
"::"                  return '::'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
"|"                   return '|'
"\\"                  return '\\'
">>"                  return '>>'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<-"                  return '<-'
"->"                  return '->'
"<<"                  return '<<'
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
data_type_and: data_type_and IDENTIFIER {$$ = ["data_type_and",$1,$2];} | IDENTIFIER {$$ = $1;};

class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};
class_statements: class_statements_ {$$ = ["class_statements",$1]} | {$$ = ["class_statements",[]]};
class_statement:
	"let" IDENTIFIER ":" IDENTIFIER "=" statements {$$ = ["instance_method","public",$4,$2,[],$6];}
	| "let" IDENTIFIER "=" statements {$$ = ["instance_method","public","Object",$2,[],$4];}
	| "let" IDENTIFIER parameters ":" IDENTIFIER "=" statements {$$ = ["instance_method","public",$5,$2,$3,$7];}
	| "let" IDENTIFIER parameters "=" statements {$$ = ["instance_method","public","Object",$2,$3,$5];}
	| "let" IDENTIFIER types parameters ":" type "=" statements {$$ = ["generic_instance_method","public",$6,$2,$4,$8,$3];}
	| "let" IDENTIFIER types parameters "=" statements {$$ = ["generic_instance_method","public","Object",$2,$4,$6,$3];}
	| "val" IDENTIFIER ":" type {$$ = ["initialize_instance_var","public",$4,$2]}
	;


OPERATOR: "<="|">="|"<"|">"|"=="|"+"|"-"|"*"|"/"|"!";


statement_:
	"data" IDENTIFIER "=" data_type_or {$$ = ["algebraic_data_type",$2,$4];}
	| "let" IDENTIFIER ":" IDENTIFIER "=" statements {$$ = ["function","public",$4,$2,[],$6];}
	| "let" IDENTIFIER "=" statements {$$ = ["function","public","Object",$2,[],$4];}
	| "let" IDENTIFIER parameters ":" IDENTIFIER "=" statements {$$ = ["function","public",$5,$2,$3,$7];}
	| "let" IDENTIFIER parameters "=" statements {$$ = ["function","public","Object",$2,$3,$5];}
	| "let" IDENTIFIER types parameters ":" type "=" statements {$$ = ["generic_function","public",$6,$2,$4,$8,$3];}
	| "let" IDENTIFIER types parameters "=" statements {$$ = ["generic_function","public","Object",$2,$4,$6,$3];}
	| "let" "(" op_or_identifier ")" parameters "=" statements {$$ = ["overload_operator","public","Object",$3,$5,$7];}
	| "let" "(" op_or_identifier ")" parameters ":" type "=" statements {$$ = ["overload_operator","public",$7,$3,$5,$9];}
	| "let" parallel_lhs "=" parallel_rhs {$$ = ["parallel_assignment",["parallel_lhs",$2],["parallel_rhs",$4]]}
	| "module" IDENTIFIER "=" "{" class_statements "}" {$$ = ["class","public",$2,$5];}
	| "module" IDENTIFIER parameters "=" "{" class_statements "}" {$$ = ["scala_class","public",$2,$3,$6];};

op_or_identifier: OPERATOR|IDENTIFIER;

types: "'" type types {$$ = [$2].concat($3);} | "'" type {$$ =
 [$2];};

parallel_lhs: parallel_lhs "," IDENTIFIER {$$ = [$1.concat([$3])];} | IDENTIFIER "," IDENTIFIER {$$ = [$1,$3]};
parallel_rhs: parallel_rhs "," e {$$ = [$1.concat([$3])];} | e "," e {$$ = [$1,$3]};




statement:
	statement_with_parentheses {$$ = $1;}
    | statement_with_semicolon {$$ = ["semicolon",$1];}
    | "loop" e "while" e "do" statements {$$ = ["futhark_while_loop",$2,$4,$6]}
    | "loop" e "=" e "while" e "do" statements {$$ = ["futhark_while_loop",$2,$4,$6,$8]}
    | "loop" e "for" e "in" e "do" statements {$$ = ["futhark_foreach",$2,$4,$6,$8]}
    | "loop" e "=" e "for" e "in" e "do" statements {$$ = ["futhark_foreach",$2,$4,$6,$8,$10]}
    | "loop" e "for" e "<" e "do" statements {$$ = ["futhark_for_loop",$2,$4,$6,$8]}
    | "loop" e "=" e "for" e "<" e "do" statements {$$ = ["futhark_for_loop",$2,$4,$6,$8,$10]}
;

statement_with_parentheses:
    "if" e "then" statements elif {$$ = ["if",$2,$4,$5];}
	| "case" parentheses_expr "of" case_statements {$$ = ["switch",$2,$4];}
	| declare_vars "in" statements {$$ = ["lexically_scoped_vars",$1,$3];}
	| "(" statement_with_parentheses ")" {$$ = $2};

case_statement: parentheses_expr "->" statements {$$ = ["case",$1,$3]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};

case_statements: case_statements_ "_" "->" statements {$$ = $1.concat([["default",["statements",$4]]])};


declare_var: "let" IDENTIFIER "=" e {$$ = ["lexically_scoped_var","Object",$2,$4]};
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

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: IDENTIFIER "=" e {$$ = ["\""+$1+"\"",$3]};


parentheses_expr:
    "(" "\\" parameters "->" e ")" {$$ = ["anonymous_function","Object",$3,["statements",[["semicolon",["return",$5]]]]];}
    | "{" key_values "}" {$$ = ["associative_array","Object","Object",$2];}
    | "(" "\\" parameters ":" IDENTIFIER "->" e ")" {$$ = ["anonymous_function",$5,$3,["statements",[["semicolon",["return",$7]]]]];}
    |"(" access_array ")" {$$ = $2}
    |"[" "]" {$$ = ["initializer_list","Object",[]];}
    |"[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    |"(" e "," exprs ")" {$$ = ["initialize_tuple","Object",[$2].concat($4)];}
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
parameter: "(" IDENTIFIER ":" IDENTIFIER ")" {$$ = [$4,$2];} | IDENTIFIER {$$ = ["Object",$1];};
parameters: parameter  parameters {$$ = [$1].concat($2);} | parameter {$$ =
 [$1];};
access_arr: parentheses_expr "!!" access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
args: parentheses_expr args {$$ = [$1].concat($2);} | parentheses_expr {$$ = [$1];};
elif: "else" statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};


statements: statement {$$ = ["statements",[$1]]};
