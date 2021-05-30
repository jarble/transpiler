/* lexical grammar */
%lex
%%

(\s+|\-\-+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
"function"            return "function"
"public"              return 'public'
"static"              return 'static'
"class"               return 'class'
"func"                return "func"
"def"                 return "def"
"sub"                 return 'sub'
"end"                 return "end"
"then"                return "then"
"elseif"              return 'elseif'
"unless"              return 'unless'
"foreach"             return 'foreach'
"interface"           return 'interface'
"if"                  return 'if'
"else"                return 'else'
"return"              return 'return'
"while"               return 'while'
"let"                 return 'let'
"for"                 return 'for'
"var"                 return 'var'
"my"                  return 'my'
"local"               return 'local'
"repeat"              return 'repeat'
"until"               return 'until'
"of"                  return 'of'
"not"                 return 'not'
","                   return ','
"||"                  return '||'
"&&"                  return '&&'
".."                  return '..'
"."                   return '.'
":"                   return ':'
";"                   return ';'
"and"                 return 'and'
"or"                  return 'or'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"~="                  return '~='
"!"                   return '!'
"!=="                 return '!=='
"!="                  return '!='
"==="                 return '==='
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
"+="                  return '+='
"++"                  return '++'
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

%left 'or' '||'
%left 'and' '&&'
%left '<' '<=' '>' '>=' '==' '===' '~=' '!=' '!=='
%left '..' '+' '-'
%left '*' '/' '%'
%left '^'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : statements_ EOF
        {return ["top_level_statements",$1];}
    ;

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};


statements: statements_ {$$ = ["statements",$1]};


access_modifier: "public" | "private";

statement
    :
    class_
    | statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | statement_with_semicolon {$$ = ["semicolon",$1];}
    | "while" e "do" statements "end" {$$ = ["while",$2,$4];}
    | "do" bracket_statements "while" "(" e ")" ";" {$$ = ["do_while",$2,$5];}
    | "while" e "{" statements "}" {$$ = ["while",$2,$4];}
    | "repeat" bracket_statements "until" e {$$ = ["do_while",$4,$2];}
    | "for" "_" "," IDENTIFIER "in" "pairs" "(" dot_expr ")" "do" statements "end" {$$ = ["foreach","Object",$4,$8,$11];}
    | "for" IDENTIFIER "," IDENTIFIER "in" "pairs" "(" dot_expr ")" "do" statements "end" {$$ = ["foreach_with_index","Object",$2,$4,$8,$11];}
    | "unless" "(" e ")" "{" statements "}" {$$ = ["unless",$3,$6];}
    | "if" e "then" statements elif "end" {$$ = ["if",$2,$4,$5];}
    | "if" e "{" statements "}" {$$ = ["if",$2,$4];}
    | function_or_def IDENTIFIER "(" parameters ")" statements "end" {$$ = ["function","public","Object",$2,$4,$6];}
    | function_or_def IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["function","public","Object",$2,$4,$7];}
    | "sub" IDENTIFIER "{" my "(" parameters ")" "=" "@_" ";" statements "}" {$$ = ["function","public","Object",$2,$6,$11];}
    | "for" "(" statement_with_semicolon ";" e ";" statement_with_semicolon ")" bracket_statements {$$ = ["for",$3,$5,$7,$9];}
    | "foreach" "(" type IDENTIFIER "in" IDENTIFIER ")" bracket_statements {$$ = ["foreach",$3,$4,$6,$8];}
    | "public" "static" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["function",$1,$3,$4,$6,$9];}
    | "switch" "(" e ")" "{" case_statements "}" {$$ = ["switch",$3,$6];}
    ;

named_parameters: named_parameters "," named_parameter {$$ = $1.concat([$3]);} | named_parameter {$$ = [$1];};
named_parameter:
	IDENTIFIER "=" e {$$ = ["named_parameter",$1,$3]}
	| IDENTIFIER ":" e {$$ = ["named_parameter",$1,$3]};

bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon ";" {$$ = ["semicolon",$1];};

case_statement: "case" e ":" statements "break" ";" {$$ = ["case",$2,$4]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "default" ":" statements {$$ = $1.concat([["default",$4]])} | case_statements_;


type: IDENTIFIER;


local_or_var: "let"|"local"|"my"|"var";

class_:
    access_modifier "class" IDENTIFIER "{" class_statements "}" {$$ = [$2,"public",$3,$5];}
	| access_modifier "namespace" IDENTIFIER "{" class_statements "}" {$$ = [$2,$1,$3,$5];}
	| access_modifier "abstract" "class" IDENTIFIER "{" class_statements "}" {$$ = ["abstract_class",$1,$4,$6];}
	| access_modifier "interface" IDENTIFIER "{" class_statements "}" {$$ = [$2,$1,$3,$5];}
	| access_modifier "enum" IDENTIFIER "{" identifiers "}" {$$ = ["enum",$2,$1,$3,$5];}
	| access_modifier "class" IDENTIFIER "extends" IDENTIFIER "{" class_statements "}" {$$ = ["class_extends",$1,$3,$5,$7];}
	| access_modifier "class" IDENTIFIER "implements" IDENTIFIER "{" class_statements "}" {$$ = ["class_implements",$1,$3,$5,$7];}
	| "class" IDENTIFIER "{" class_statements "}" {$$ = [$1,"public",$2,$4];}
	| "class" IDENTIFIER class_statements "end" {$$ = [$1,"public",$2,$3];};


class_statements:
	class_statements_ {$$ = ["class_statements",$1]};
class_statements_:
    class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};

class_statement:
	"static" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method","public","Object",$2,$4,$7];}
	| IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["instance_method","public","Object",$1,$3,$6];}
	| access_modifier type IDENTIFIER "=" e ";" {$$ = ["initialize_instance_var_with_value",$1,$2,$3,$5];}
	| access_modifier type IDENTIFIER ";" {$$ = ["initialize_instance_var",$1,$2,$3];}
	| access_modifier "static" type IDENTIFIER "=" e ";" {$$ = ["initialize_static_instance_var",$1,$3,$4,$6];}
	| access_modifier "static" type IDENTIFIER "(" parameters ")" ";" {$$ = ["interface_static_method",$1,$3,$4,$6];}
	| access_modifier type IDENTIFIER "(" parameters ")" ";" {$$ = ["interface_instance_method",$1,$2,$3,$5];}
	| access_modifier "static" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method",$1,$3,$4,$6,$9];}
	| access_modifier type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["instance_method",$1,$2,$3,$5,$8];}
	;


statement_with_semicolon
   : 
   "return" e  {$$ = ["return",$2];}
   | local_or_var IDENTIFIER "=" e {$$ = ["initialize_var","Object",$2,$4];}
   | local_or_var identifiers {$$ = ["initialize_empty_vars","Object",$2];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "++" {$$ = [$2,$1];}
   | IDENTIFIER "--" {$$ = [$2,$1];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "." dot_expr {$$ = [".",[$1].concat($3)]}
   | function_call
   ;
e
    :
    e 'or' e
        {$$ = ['||',$1,$3];}
    |e '||' e
        {$$ = ['&&',$1,$3];}
    |e 'and' e
        {$$ = ['&&',$1,$3];}
    |e '&&' e
        {$$ = ['&&',$1,$3];}
    |e '<=' e
        {$$ = [$2,$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e '>=' e
        {$$ = [$2,$1,$3];}
    | e '==' e
        {$$ = [$2,$1,$3];}
    | e '===' e
        {$$ = [$2,$1,$3];}
    | e '~=' e
        {$$ = ["!=",$1,$3];}
    | e '!=' e
        {$$ = ["!=",$1,$3];}
    | e '!==' e
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


not_expr: "not" dot_expr {$$ = ["!", [".",$2]];} | "!" dot_expr {$$ = ["!", [".",$2]];} | dot_expr {$$ = [".", $1];};


dot_expr: parentheses_expr "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: parentheses_expr_ "[" e "]" {$$ = ["access_array",$1,[$3]];};

function_call:
    parentheses_expr_ "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr_ "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | parentheses_expr_ "(" named_parameters ")" {$$ = ["function_call",$1,$3];};

parentheses_expr_:
    NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

function_or_def: "function" | "func" | "def";

parentheses_expr:
    "function" "(" parameters ")" statements "end" {$$ = ["anonymous_function","Object",$3,$5];}
    | "function" "(" parameters ")" "{" statements "}" {$$ = ["anonymous_function","Object",$3,$6];}
    | '(' e ')' {$$ = ["parentheses",$2];}
    | access_array
    | function_call
    | parentheses_expr_;



parameter:
	type "..." IDENTIFIER {$$ = ["varargs",$1,$3]} | type IDENTIFIER {$$ = [$1,$2];} | "final" type IDENTIFIER {$$ = ["final_parameter",$2,$3];};
parameters: parameters "," parameter {$$ = $1.concat([$3]);} | parameter {$$ =
 [$1];} | {$$ = [];};

exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif:
	"elseif" e "then" statements elif {$$ = ["elif",$2,$4,$5]}
	| "elseif" e "then" statements {$$ = ["elif",$2,$4]}
	| "elseif" "(" e ")" "{" statements "}" {$$ = ["elif",$3,$6]}
	| "else" "{" statements "}" {$$ = ["else",$3];}
	| "else" statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: STRING_LITERAL "=" e {$$ = [$1,$3]};

