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
"If"                  return 'If'
"case"                return "case"
"default"             return 'default'
"Return"              return 'Return'
"yield"               return 'yield'
"While"               return 'While'
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
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
"instanceof"          return 'instanceof'
"in"                  return 'in'
[a-zA-Z_][a-zA-Z0-9_]*_ return 'PARAMETER'
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
 

statements__: statement ";" statements__ {$$ = [$1].concat($3);} | statement {$$ =
 [$1];};


statement
    :
    IDENTIFIER "[" parameters "]" ":=" bracket_statements {$$ = ["function","public","Object",$1,$3,$6];}
    | statement_with_semicolon {$$ = ["semicolon",$1];}
    | if_statement {$$ = $1;}
    | "While" "[" e "," statements "]" {$$ = ["while",$3,$5];}
    ;

bracket_statements: statement {$$ = $1} | "(" statements ")" {$$ = $2};

elif: bracket_statements {$$ = ["else",$1];};
if_statement:
"If" "[" e "," bracket_statements "," elif "]" {$$ = ["if",$3,$5,$7];};


statement_with_semicolon
   : 
   "Return" "[" e "]" {$$ = ["return",$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   ;
e
    :
    e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e '!==' e
        {$$ = ['!=',$1,$3];}
    |e '===' e
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
        {$$ = ["-",$1,$3];}
    | e '*' e
        {$$ = ["*",$1,$3];}
    | e '/' e
        {$$ = ["/",$1,$3];}
    | e '%' e
        {$$ = ["/",$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | not_expr
    ;

not_expr: "!" parentheses_expr {$$ = ["!", [".",$2]];} | "typeof" parentheses_expr {$$ = [$1, [".",$2]];} | "await" parentheses_expr {$$ = ["await", [".",$2]]} | parentheses_expr {$$ = [".", $1];};


access_array: parentheses_expr "[[" access_arr "]]" {$$ = ["access_array",$1,$4];};


parentheses_expr:
    IDENTIFIER "[" "]" {$$= ["function_call",$1,[]];}
    | IDENTIFIER "[" exprs "]" {$$= ["function_call",$1,$3];}
    | access_array
    | "{" "}" {$$ = ["initializer_list","Object",[]];} | "{" exprs "}" {$$ = ["initializer_list","Object",$2];}
    | '(' e ')'} {$$ = ["parentheses",$2];}
    | NUMBER
        {$$ = [yytext];}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

parameter: PARAMETER {$$ = ["Object", $1.substring(0,($1.length)-1)];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};
access_arr: parentheses_expr "," access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
