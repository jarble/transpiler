/* lexical grammar */
%lex
%%

\s+                                   /* IGNORE */
"//".*                                /* IGNORE */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* IGNORE */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
"func"                return "func"
"init"                return "init"
"inout"               return "inout"
"out"                 return 'out'
"end"                 return "end"
"then"                return 'then'
"case"                return 'case'
"let"                 return 'let'
"var"                 return 'var'
"if"                  return 'if'
"class"               return 'class'
"struct"              return 'struct'
"protocol"            return 'protocol'
"else"                return 'else'
"return"              return 'return'
"while"               return 'while'
"for"                 return 'for'
"repeat"              return 'repeat'
"until"               return 'until'
"of"                  return 'of'
"not"                 return 'not'
"+="                  return '+='
"*="                  return '*='
"-="                  return '-='
"/="                  return '/='
","                   return ','
".."                  return '..'
"."                   return '.'
":"                   return ':'
"and"                 return 'and'
"or"                  return 'or'
">"                   return '>'
"<"                   return '<'
"~="                  return '~='
"=="                  return '=='
"="                   return '='
"*="                  return '*='
"*"                   return '*'
"/"                   return '/'
"%"                   return '%'
"->"                  return '->'
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
%left '<' ('<' '=') '>'  ('>' '=') '==' '~='
%left '..' '+' '-'
%left '*' '/' '%'
%left '^'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: top_level_statements EOF {return ["top_level_statements",$1]};
top_level_statements: top_level_statements top_level_statement {$$ = $1.concat([$2]);} | top_level_statement {$$ =
 [$1];};
top_level_statement:
	statement | initialize_var1 {$$ = ["semicolon",$1]};
initialize_var1: initialize_var_ {$$ = ["initialize_var"].concat($1);};
initialize_var: initialize_var_ {$$ = ["lexically_scoped_var"].concat($1);};

statements_: statements_with_vars | initialize_var_ {$$ = [["semicolon",["initialize_var"].concat($1)]]} | initialize_var_ statements_with_vars {$$ = [["lexically_scoped_vars",[["lexically_scoped_var"].concat($1)],["statements",$2]]]};
statements_with_vars: statements_without_vars initialize_var1 {$$ = $1.concat([["semicolon",$2]]);} | statements_without_vars;
statements_without_vars: statements_without_vars statement {$$ = $1.concat([$2]);} | statement {$$ =
 [$1];};

statements: statements_ {$$ = ["statements",$1]};

class_statements: class_statements_ {$$ = ["class_statements",$1]} | {$$ = ["class_statements",[]]};
class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};

initialize_vars: initialize_vars initialize_var {$$ = $1.concat([$2]);} | initialize_var {$$ =
 [$1];};

statement
    :
    statement_with_semicolon {$$ = ["semicolon",$1];}
    | "while" "(" e ")" bracket_statements {$$ = ["while",$3,$5];}
    | "for" IDENTIFIER "in" parentheses_expr bracket_statements {$$ = ["foreach","Object",$2,$4,$5];}
    | "func" IDENTIFIER "(" parameters ")" "->" IDENTIFIER "{" statements "}" {$$ = ["function","public",$7,$2,$4,$9];}
    | "func" IDENTIFIER "<" type_params ">" "(" parameters ")" "->" IDENTIFIER "{" statements "}" {$$ = ["generic_function","public",$10,$2,$7,$12];}
    | "if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
	| "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];}
	| class_
    ;

class_:
	"class" IDENTIFIER "{" class_statements "}" {$$ = [$1,"public",$2,$4];}
	| "protocol" IDENTIFIER "{" class_statements "}" {$$ = ["interface","public",$2,$4];}
	| "enum" IDENTIFIER "{" "case" identifiers "}" {$$ = ["enum",$2,$5];}
	| "struct" IDENTIFIER "{" struct_statements "}" {$$ = ["struct",$2,["struct_statements",$4]];};

struct_statements: struct_statement struct_statements {$$ = [$1].concat($2);} | struct_statement {$$ =
 [$1];}; 
struct_statement:
	"var" identifiers {$$ = ["struct_statement","Object",$2];}
	| "var" identifiers ":" type {$$ = ["struct_statement",$4,$2];}
	;

class_statement:
	class_
	| "init" "(" parameters ")" "{" statements "}" {$$ = ["constructor","public",$3,$6];}
	| "func" IDENTIFIER "(" parameters ")" {$$ = ["interface_instance_method","public","Object",$2,$4];}
	| "var" IDENTIFIER ":" type {$$ = ["initialize_instance_var","public",$4,$2];}
	| "var" IDENTIFIER {$$ = ["initialize_instance_var","public","Object",$2];}
	| initialize_var_ {$$ = ["initialize_instance_var_with_value","public"].concat($1);}
	| "func" IDENTIFIER "(" parameters ")" "->" IDENTIFIER "{" statements "}" {$$ = ["instance_method","public",$7,$2,$4,$9];}
	| "class" "func" IDENTIFIER "(" parameters ")" "->" IDENTIFIER "{" statements "}" {$$ = ["instance_method","public",$8,$3,$5,$10];}
	;


statement_with_semicolon
   : 
   "return" e  {$$ = ["return",$2];}
   | "var" identifiers {$$ = ["initialize_empty_vars","Object",$2];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "." IDENTIFIER "=" e {$$ = ["set_var",[".",[$1,$3]],$5];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "." dot_expr {$$ = [".",[$1].concat($3)]}
   | "let" IDENTIFIER "=" e {$$ = ["initialize_constant","Object",$2,$4];}
   | "let" IDENTIFIER  ":" type "=" e  {$$ = ["initialize_constant",$4,$2,$6];}
   ;

initialize_var_:
	"var" IDENTIFIER "=" e {$$ = ["Object",$2,$4];}
	| "var" IDENTIFIER  ":" type "=" e  {$$ = [$4,$2,$6];};

e
    :
    e 'or' e
        {$$ = ['||',$1,$3];}
    |e 'and' e
        {$$ = ['&&',$1,$3];}
    |e ('<' '=') e
        {$$ = [$2,$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e ('>' '=') e
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
    | not_expr
    ;

named_parameters: named_parameters "," named_parameter {$$ = $1.concat([$3]);} | named_parameter {$$ = [$1];};
named_parameter: IDENTIFIER ":" e {$$ = ["named_parameter",$1,$3]};

not_expr: "!" dot_expr {$$ = ["!", [".",$2]];} | dot_expr {$$ = [".", $1];};


dot_expr: parentheses_expr "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: IDENTIFIER "[" e "]" {$$ = ["access_array",$1,[$3]];};

function_call:
    IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];}
    | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | IDENTIFIER "(" named_parameters ")" {$$ = ["function_call",$1,$3];}
	;
parentheses_expr_:
    NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

parentheses_expr:
    "function" "(" parameters ")" statements "end" {$$ = ["anonymous_function","Object",$3,$5];}
    | '(' e ')' {$$ = ["parentheses",$2];}
    | "[" "]" {$$ = ["initializer_list","Object",[]];} | "[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    | "[" key_values "]" {$$ = ["associative_array","Object","Object",$2];}
    | access_array
    | function_call
    | parentheses_expr_;



type: "[" type "]" {$$ = [$2,"[]"];} | IDENTIFIER "<" type ">" {$$ = [$1,$3]} | IDENTIFIER;
parameter: IDENTIFIER ":" "out" type {$$ = ["out_parameter",$4,$1];} | IDENTIFIER ":" "in" type {$$ = ["in_parameter",$4,$1];} | IDENTIFIER ":" "inout" type {$$ = ["ref_parameter",$4,$1];} | IDENTIFIER ":" type {$$ = [$3, $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = [];};

exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif: else_if "(" e ")" bracket_statements elif {$$ = ["elif",$3,$5,$6]} | else_if "(" e ")" bracket_statements {$$ = ["elif",$3,$5]} | "else" bracket_statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: STRING_LITERAL ":" e {$$ = [$1,$3]};

bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon {$$ = ["semicolon",$1];};
