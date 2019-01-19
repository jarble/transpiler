/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"if"                  return "if"
"else"                return "else"
"return"              return "return"
"void"                return "void"
"case"                return "case"
"printf"              return "printf"
"while"               return "while"
"const"               return "const"
"struct"              return "struct"
"switch"              return "switch"
"for"                 return "for"
","                   return ','
"\u00ac"              return '\u00ac'
"\u2200"              return '\u2200'
"\u221e"              return '\u221e'
"\u03c0"              return '\u03c0'
"forall"              return 'forall'
";"                   return ';'
"."                   return '.'
":"                   return ':'
"&&"                  return '&&'
"\u2227"              return '\u2227'
"||"                  return '||'
"\u2228"              return '\u2228'
"\u2260"              return '\u2260'
"!="                  return '!='
'!'                   return '!'
">="                  return '>='
">>"                  return '>>'
">"                   return '>'
"<->"                 return '<->'
"->"                  return '->'
"\u2192"              return '\u2192'
"\u2194"              return '\u2194'
"<="                  return '<='
"<"                   return '<'
"="                   return '='
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

%left '<->' '->' '\u2194' '\u2192'
%left '||' "\u2228"
%left '&&' "\u2227"
%left '<' '<=' '>' '>=' '=' '!=' '\u2260'
%left '+' '-'
%left '*' '/' '%'
%left '^'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};

statements: statements_ {$$ = ["statements",$1]};

statement
    :
	IDENTIFIER "(" parameters ")" "=" "{" e "}" {$$ = ["function","public","double",$1,$3,["statements",[["semicolon",["return",$7]]]]];};

e
    :
    e "\u2194" e
        {$$ = ["iff",$1,$3];}
    |e "<->" e
        {$$ = ["iff",$1,$3];}
    |e "\u2192" e
        {$$ = ["implies",$1,$3];}
    |e "->" e
        {$$ = ["implies",$1,$3];}
    | e '\u2228' e
        {$$ = ["||",$1,$3];}
    | e "||" e
        {$$ = ["||",$1,$3];}
    |e '\u2227' e
        {$$ = ["&&",$1,$3];}
    |e '&&' e
        {$$ = ["&&",$1,$3];}
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
    | e '!=' e
        {$$ = [$2,$1,$3];}
    | e '\u2260' e
        {$$ = ['!=',$1,$3];}
    | arithmetic_expr;

arithmetic_expr:
	e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '%' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | e '^' e
        {$$ = ["function_call","**",[$1,$3]];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | not_expr
    ;


not_expr: "!" parentheses_expr {$$ = ["!", [".",$2]];} | "\u00ac" parentheses_expr {$$ = ["!", [".",$2]];} | parentheses_expr;

forall_: "forall" | "\u2200";

parentheses_expr:
    NUMBER parentheses_expr_ {$$ = ["*",$1,$2];}
    | forall_ IDENTIFIER parentheses_expr {$$ = ['forall',$2,$3];}
    | IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];}
    | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | parentheses_expr_;

parentheses_expr_:
	'(' e ')' {$$ = ["parentheses",$2];}
	| NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | '\u221e'
        {$$ = yytext;}
    | '\u03c0'
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};


parameter: IDENTIFIER {$$ = ["double",$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | "void" {$$ = [];} | {$$ = [];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
