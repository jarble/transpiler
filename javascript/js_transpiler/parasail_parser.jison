/* lexical grammar */
%lex
%%

(\s+|\/\/+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"if"                  return "if"
"is"                  return 'is'
"else"                return "else"
"elsif"               return "elsif"
"loop"                return "loop"
"function"            return "function"
"begin"               return "begin"
"return"              return "return"
"void"                return "void"
"case"                return "case"
"printf"              return "printf"
"while"               return "while"
"const"               return "const"
"struct"              return "struct"
"switch"              return "switch"
"for"                 return "for"
"end"                 return "end"
"when"                return "when"
","                   return ','
";"                   return ';'
"."                   return '.'
":="                  return ':='
":"                   return ':'
"&&"                  return '&&'
"&"                   return '&'
"||"                  return '||'
"/="                  return '/='
'!'                   return '!'
">="                  return '>='
">>"                  return '>>'
">"                   return '>'
"<="                  return '<='
"<<"                  return '<<'
"<"                   return '<'
"=>"                  return '=>'
"="                   return '='
"*="                  return '*='
"*"                   return '*'
"%"                   return '%'
"/="                  return '/='
"/"                   return '/'
"-="                  return '-='
"--"                  return '--'
"-"                   return '-'
"++"                  return '++'
"+="                  return '+='
"+"                   return '+'
"^"                   return '^'
"?"                   return '?'
"{"                   return '{'
"}"                   return '}'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%right '?'
%left '||'
%left '&&'
%left '<' '<=' '>' '>=' '=' '/='
%left '+' '-'
%left '*' '/' '%'
%left '**'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};
 

statements: statements_ {$$ = ["statements",$1]};


access_modifier: "public" | "private";


statement
    :
        "function" IDENTIFIER "(" parameters ")" "return" IDENTIFIER "is" "begin" statements "end" "function" IDENTIFIER ";" {$$ = ["function","public",$7,$2,$4,$10];}
    | "function" IDENTIFIER "(" parameters ")" "return" IDENTIFIER "is" "begin" statements "end" IDENTIFIER ";" {$$ = ["function","public",$7,$2,$4,$10];}
    | statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | "while" e "loop" statements "end" "loop" ";" {$$ = ["while",$2,$4];}
    | "case" e "is" case_statements "end" "case" ";" {$$ = ["switch",$2,$4];}
    | "for" "(" statement_with_semicolon ";" e ";" statement_with_semicolon ")" bracket_statements {$$ = ["for",$3,$5,$7,$9];}
    | "if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
	| "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];};

case_statement: "when" e "=>" statements {$$ = ["case",$2,$4]};
case_statements: case_statement case_statements {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};

statement_with_semicolon
   : 
   IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];}
   | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];}
   |"return" e  {$$ = ["return",$2];}
   | IDENTIFIER ":" type ":=" e {$$ = ["initialize_var",$3,$1,$5];}
   | "const" type IDENTIFIER "=" e {$$ = ["initialize_constant",$2,$3,$5];}
   | type access_array {$$ = ["set_array_size",$1,$2[1],$2[2]];}
   | type identifiers {$$ = ["initialize_empty_vars",$1,$2];}
   | access_array ":=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER ":=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "++" {$$ = [$2,$1];}
   | IDENTIFIER "--" {$$ = [$2,$1];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   ;
e
    :
    e "?" e ":" e {$$ = ["ternary_operator",$1,$3,$5]}
    |e '||' e
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
    | e '=' e
        {$$ = [$2,$1,$3];}
    | e '/=' e
        {$$ = [$2,$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '%' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | e '**' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | not_expr
    ;


not_expr: "!" dot_expr {$$ = ["!", [".",$2]];} | dot_expr {$$ = [".", $1];};


dot_expr: parentheses_expr "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: IDENTIFIER "[" e "]" {$$ = ["access_array",$1,[$3]];};

parentheses_expr:
    access_array
    | function_call
    | '(' e ')' {$$ = ["parentheses",$2];}
    | parentheses_expr_;

parentheses_expr_:
	"{" "}" {$$ = ["initializer_list","Object",[]];}
	| "{" exprs "}" {$$ = ["initializer_list","Object",$2];}
	| NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

function_call: parentheses_expr "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr "(" exprs ")" {$$ = ["function_call",$1,$3];};

type: IDENTIFIER "[" "]" {$$ = [$1,"[]"];} | "void" | IDENTIFIER;
parameter: IDENTIFIER ":" type {$$ = [$3,$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = [];};
exprs: expr "," exprs {$$ = [$1].concat($3);} | expr {$$ = [$1];};
expr: "&" e {$$ = ["function_call_ref",$2];} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif:
	"else" "if" "(" e ")" "{" statements "}" elif {$$ = ["elif",$4,$7,$9]}
	| "else" "{" statements "}" {$$ = ["else",$3];};

identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon ";" {$$ = ["semicolon",$1];};
