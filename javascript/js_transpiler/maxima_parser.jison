/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
"block"               return "block"
"typeof"              return "typeof"
"do"                  return "do"
"if"                  return 'if'
"else"                return 'else'
"then"                return 'then'
"case"                return "case"
"default"             return 'default'
"return"              return 'return'
"yield"               return 'yield'
"while"               return 'while'
"switch"              return 'switch'
"break"               return 'break'
"for"                 return 'for'
"var"                 return 'var'
"of"                  return 'of'
","                   return ','
";"                   return ';'
"."                   return '.'
":="                  return ":="
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"==="                 return '==='
"!=="                 return '!=='
"!"                   return "!"
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
"instanceof"          return 'instanceof'
"in"                  return 'in'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '||'
%left '&&'
%left '<' '<=' '>' '>=' '===' '!==' 'in' 'instanceof'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : statements_ EOF
        {return ["top_level_statements",$1];}
    ;

statements
    : statements__
        {$$ = ["statements",$1];}
    ;

statements_: statement ";" statements_ {$$ = [$1].concat($3);} | statement ";" {$$ =
 [$1];};
 

statements__: statement "," statements__ {$$ = [$1].concat($3);} | statement {$$ =
 [$1];};


statement
    :
    statement_with_semicolon {$$ = ["semicolon",$1];}
    | "(" if_statement ")" {$$ = $2;}
    | "while" e "do" "(" statements ")" {$$ = ["while",$2,$5];}
    | IDENTIFIER "(" parameters ")" ":=" "block" "(" "[" "]" "," statements ")" {$$ = ["function","public","Object",$1,$3,$11];}
    ;

bracket_statements: statement {$$ = $1};

elif: "else" "if" e "then" bracket_statements elif {$$ = ["elif",$3,$5,$6]} | "else" bracket_statements {$$ = ["else",$2];};
if_statement:
"if" e "then" bracket_statements elif {$$ = ["if",$2,$4,$5];}
|  "if" e "then" bracket_statements {$$ = ["if",$2,$4];};


statement_with_semicolon
   : 
   IDENTIFIER ":" e {$$ = ["set_var",$1,$3];}
   ;
e
    :
    e 'or' e
        {$$ = [$2,$1,$3];}
    |e 'and' e
        {$$ = [$2,$1,$3];}
    |e '!=' e
        {$$ = ['!=',$1,$3];}
    |e '=' e
        {$$ = ['==',$1,$3];}
    |e 'in' e
        {$$ = ['in',$1,$3];}
    |e 'instanceof' e
        {$$ = ['in',$1,$3];}
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
    | e '^' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | not_expr
    ;

not_expr: "!" parentheses_expr {$$ = ["!", [".",$2]];} | "typeof" parentheses_expr {$$ = [$1, [".",$2]];} | "await" parentheses_expr {$$ = ["await", [".",$2]]} | parentheses_expr {$$ = [".", $1];};


access_array: parentheses_expr "[" access_arr "]" {$$ = ["access_array",$1,$3];};


parentheses_expr:
    "function" "(" parameters ")" "{" statements "}" {$$ = ["anonymous_function","Object",$3,$6]}
    | IDENTIFIER "(" ")" {$$= ["function_call",$1,[]];}
    | IDENTIFIER "(" exprs ")" {$$= ["function_call",$1,$3];}
    | access_array
    | "[" "]" {$$ = ["initializer_list","Object",[]];} | "[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    | '(' e ')'} {$$ = ["parentheses",$2];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

parameter: IDENTIFIER {$$ = ["Object", $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};
access_arr: parentheses_expr "][" access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};

types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
