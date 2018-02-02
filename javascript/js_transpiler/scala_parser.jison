/* lexical grammar */
%lex
%%

(\s+|\-\-+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
"def"                 return "def"
"end"                 return "end"
"Array"               return 'Array'
"if"                  return 'if'
"else"                return 'else'
"return"              return 'return'
"while"               return 'while'
"match"               return 'match'
"for"                 return 'for'
"var"                 return 'var'
"of"                  return 'of'
"not"                 return 'not'
","                   return ','
".."                  return '..'
"."                   return '.'
":"                   return ':'
";"                   return ';'
"and"                 return 'and'
"or"                  return 'or'
">="                  return '>='
">"                   return '>'
"<-"                  return '<-'
"<="                  return '<='
"<"                   return '<'
"!="                  return '!='
"=>"                  return '=>'
"=="                  return '=='
"="                   return '='
"*="                  return '*='
"*"                   return '*'
"/="                  return '/='
"/"                   return '/'
"%"                   return '%'
"-="                  return '-='
"-"                   return '-'
"+="                  return '+='
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
%left '<' '<=' '>' '>=' '==' '!='
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


statement
    :
    statement_with_semicolon {$$ = ["semicolon",$1];}
    | statement_with_semicolon ";" {$$ = ["semicolon",$1];}
	// | parentheses_expr "match" "{" case_statements "}" {$$ = ["switch",$1,$4];}
    | "while" "(" e ")" bracket_statements {$$ = ["while",$3,$5];}
    | "for" "(" dot_expr "<-" dot_expr ")" "{" statements "}" {$$ = ["foreach","Object",$3,$5,$8];}
    | "if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
	| "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];}
    | "def" IDENTIFIER "(" parameters ")" ":" IDENTIFIER "=" "{" statements "}" {$$ = ["function","public",$7,$2,$4,$10];}
    ;

case_statement: parentheses_expr "=>" statement {$$ = ["case",$1,["statements",[$3]]]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "_" "=>" statement {$$ = $1.concat([["default",$4]])} | case_statements_;

statement_with_semicolon
   : 
   "return" e  {$$ = ["return",$2];}
   | "var" IDENTIFIER  ":" type "=" e  {$$ = ["initialize_var",$4,$2,$6];}
   | "var" IDENTIFIER "=" e  {$$ = ["initialize_var","Object",$2,$4];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
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
    | e '!=' e
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


not_expr: "!" dot_expr {$$ = ["!", [".",$2]];} | dot_expr {$$ = [".", $1];};


dot_expr: parentheses_expr "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: parentheses_expr_ "[" e "]" {$$ = ["access_array",$1,[$3]];};

function_call:
    parentheses_expr_ "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr_ "(" exprs ")" {$$ = ["function_call",$1,$3];};

parentheses_expr_:
    "Array" "(" ")" {$$ = ["initializer_list","Object",[]];} | "Array" "(" exprs ")" {$$ = ["initializer_list","Object",$3];}
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



type: IDENTIFIER | "Array" "[" IDENTIFIER "]" {$$ = [$3,"[]"]};
parameter: IDENTIFIER ":" IDENTIFIER {$$ = [$3,$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = [];};

exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif:
	"else" "if" "(" e ")" "{" statements "}" elif {$$ = ["elif",$4,$7,$9]}
	| "else" "{" statements "}" {$$ = ["else",$3];};

identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: STRING_LITERAL "=" e {$$ = [$1,$3]};
bracket_statements: "{" statements "}" {$$= $2;};
