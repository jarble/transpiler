/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
"function"            return "function"
"class"               return "class"
"public"              return "public"
"extends"             return "extends"
"implements"          return "implements"
"private"             return "private"
"static"              return "static"
"if"                  return "if"
"elseif"              return "elseif"
"else"                return "else"
"return"              return "return"
"as"                  return "as"
"while"               return "while"
"break"               return "break"
"switch"              return "switch"
"default"             return "default"
"case"                return "case"
"foreach"             return "foreach"
"for"                 return "for"
","                   return ','
"=>"                  return '=>'
"->"                  return '->'
";"                   return ';'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"==="                 return '==='
"!=="                 return '!=='
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
"..."                 return '...'
"."                   return '.'
"^"                   return '^'
"?"                   return '?'
"{"                   return '{'
"}"                   return '}'
"]["                  return ']['
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '?'
%left '||'
%left '&&'
%left '<' '<=' '>' '>=' '===' '!=='
%left '+' '-' '.'
%left '*' '/'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};
 
class_statements: class_statements_ {$$ = ["class_statements",$1]};
statements: statements_ {$$ = ["statements",$1]};


class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};

access_modifier: "public" | "private";

class_:
	access_modifier "class" IDENTIFIER "{" class_statements "}" {$$ = ["class",$1,$2,$3,$5];}
	| access_modifier "class" IDENTIFIER "extends" IDENTIFIER "{" class_statements "}" {$$ = ["class_extends",$1,$2,$3,$5,$7];}
	| access_modifier "class" IDENTIFIER "implements" IDENTIFIER "{" class_statements "}" {$$ = ["class_implements",$1,$2,$3,$5,$7];};

statement
    :
    statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | class_
    | "while" "(" e ")" bracket_statements {$$ = ["while",$3,$5];}
    | "do" bracket_statements "while" "(" e ")" ";" {$$ = ["do_while",$2,$5];}
    | "switch" "(" e ")" "{" case_statements "}" {$$ = ["switch",$3,$6];}
    | "for" "(" statement_with_semicolon ";" e ";" statement_with_semicolon ")" bracket_statements {$$ = ["for",$3,$5,$7,$9];}
    | "foreach" "(" var_name "as" var_name "=>" var_name ")" bracket_statements {$$ = ["foreach_with_index","Object",$5,$7,$3,$9];}
    | "foreach" "(" var_name "as" var_name ")" bracket_statements {$$ = ["foreach","Object",$5,$3,$7];}
    | if_statement
    | "function" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["function","public","Object",$2,$4,$7];}
    | "function" IDENTIFIER "(" parameters ")" ":" IDENTIFIER "{" statements "}" {$$ = ["function","public",$7,$2,$4,$9];}
    ;

case_statement: "case" e ":" statements "break" ";" {$$ = ["case",$2,$4]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "default" ":" statements {$$ = $1.concat([["default",$4]])} | case_statements_;


class_statement:
	access_modifier "static" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method",$1,$3,$4,$6,$8];};

statement_with_semicolon
   : 
   "System.out.println" "(" e ")" {$$ = ["println",$3];}
   | "return" e  {$$ = ["return",$2];}
   | type var_name "=" e {$$ = ["initialize_var",$1,$2,$4];}
   | var_name "[" "]" "=" e {$$ = ["function_call","array_push",[$1,$5]];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | var_name "=" e {$$ = ["set_var",$1,$3];}
   | var_name "++" {$$ = [$2,$1];}
   | var_name "--" {$$ = [$2,$1];}
   | var_name "+=" e {$$ = [$2,$1,$3];}
   | var_name "-=" e {$$ = [$2,$1,$3];}
   | var_name "*=" e {$$ = [$2,$1,$3];}
   | var_name "/=" e {$$ = [$2,$1,$3];}
   | function_call
   | var_name "." dot_expr
   ;
e
    :
    e "?" e ":" e {$$ = ["ternary_operator",$1,$3,$5]}
    |"..." parentheses_expr {$$ = ["unpack_array",$2]}
    |e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e '!==' e
        {$$ = ['!=',$1,$3];}
    |e '===' e
        {$$ = ['==',$1,$3];}
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
    | e '.' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | dot_expr {$$ = [".", $1];}
    ;



dot_expr: parentheses_expr "->" dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: var_name "[" access_arr "]" {$$ = ["access_array",$1,$3];};

function_call:
    IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];}
    | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];};

parentheses_expr:
    "function" "(" parameters ")" "{" statements "}" {$$ = ["anonymous_function","Object",$3,$6]}
    | access_array
    | function_call
    | "[" "]" {$$ = ["initializer_list","Object",[]];} | "[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    | '(' e ')'} {$$ = $2;}
    | NUMBER
        {$$ = yytext;}
    | var_name
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

type: IDENTIFIER "[" "]" {$$ = [$1,"[]"];} | IDENTIFIER "<" types ">" {$$ = [$1,$3]} | IDENTIFIER;
parameter: var_name {$$ = ["Object", $1];} | var_name ":" IDENTIFIER {$$ = [$3,$1]};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];}| {$$ = [];};
access_arr: e "][" access_arr {$$ = [$1].concat($3);} | e {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
else_if: "else" "if" | "elseif";
elif: else_if "(" e ")" bracket_statements elif {$$ = ["elif",$3,$5,$6]} | else_if "(" e ")" bracket_statements {$$ = ["elif",$3,$5]} | "else" bracket_statements {$$ = ["else",$2];};
if_statement:
"if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
|  "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];};
var_name: "$" IDENTIFIER {$$ = $2;};
var_names: var_name "," var_names {$$ = [$1].concat($3);} | var_name {$$ = [$1];};

bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon ";" {$$ = ["semicolon",$1];};
