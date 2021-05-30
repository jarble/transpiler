/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
"And"                 return 'And'
"Or"                  return 'Or'
"block"               return "block"
"typeof"              return "typeof"
"If"                  return 'If'
"case"                return "case"
"default"             return 'default'
"Return"              return 'Return'
"yield"               return 'yield'
"While"               return 'While'
"Do"                  return 'Do'
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
"=="                  return '=='
"!="                  return '!='
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
[a-zA-Z_][a-zA-Z0-9_]*_ return 'PARAMETER'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '||' 'Or'
%left '&&' 'And'
%left '<' '<=' '>' '>=' '==' '!='
%left '+' '-'
%left '*' '/'
%left '^'
%left UMINUS
%left '!'

%start expressions

%% /* language grammar */

expressions
    : top_level_statements EOF
        {return ["top_level_statements",$1];}
    ;

statements
    : statements_
        {$$ = ["statements",$1];}
    ;

top_level_statements: top_level_statements ";" function {$$ = $1.concat([$3]);} | function {$$ =
 [$1];};

statements_: statements_ ";" statement {$$ = $1.concat([$3]);} | statement {$$ =
 [$1];};


function:
IDENTIFIER "[" parameters "]" ":=" bracket_statements {$$ = ["function","public","Object",$1,$3,$6];};

statement
    :
    "While" "[" e "," statements "]" {$$ = ["while",$3,$5];}
    | "Do" "[" bracket_statements "," "{" e "," e "}" "]" {$$ = ["foreach","Object",$6,$8,$3];}
    | statement_with_semicolon {$$ = ["semicolon",$1];}
    | "If" "[" e "," bracket_statements "," bracket_statements "]" {$$ = ["if",$3,$5,["else",$7]];}
    ;

bracket_statements: "(" statement ";" statements_ ")" {$$ = ["statements",[$2].concat($4)];} | statement {$$ = ["statements",[$1]]} | "(" IDENTIFIER "=" e ")" {$$ = ["semicolon",["set_var",$2,$4]];};



statement_with_semicolon
   : 
   IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | "Return" "[" e "]" {$$ = ["return",$3];}
   | e {$$ = ["return",$1];}
   ;

e
    :
    e '||' e
        {$$ = [$2,$1,$3];}
    |e 'Or' e
        {$$ = ["||",$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e 'And' e
        {$$ = ["&&",$1,$3];}
    |e '!=' e
        {$$ = [$2,$1,$3];}
    |e '==' e
        {$$ = [$2,$1,$3];}
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
    | e '^' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | "!" e {$$ = ["!", [".",$2]];}
    | parentheses_expr {$$ = $1;};

parentheses_expr:
    IDENTIFIER "[" "]" {$$= ["function_call",$1,[]];}
    | IDENTIFIER "[" exprs "]" {$$= ["function_call",$1,$3];}
    | IDENTIFIER "[[" access_arr "]]" {$$ = ["access_array",$1,$4];}
    | "{" "}" {$$ = ["initializer_list","Object",[]];} | "{" exprs "}" {$$ = ["initializer_list","Object",$2];}
    | '(' e ')' {$$ = ["parentheses",$2];}
    | NUMBER
        {$$ = [yytext];}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

parameter:
	PARAMETER ":" e {$$ = ["default_parameter", "Object", $1.substring(0,($1.length)-1)],$3;}
	| PARAMETER {$$ = ["Object", $1.substring(0,($1.length)-1)];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};
access_arr: e "," access_arr {$$ = [$1].concat($3);} | e {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
