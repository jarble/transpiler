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
";"                   return ';'
"."                   return '.'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
"!="                  return '!='
'!'                   return '!'
">="                  return '>='
">>"                  return '>>'
">"                   return '>'
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

%right '?'
%left '||'
%left '&&'
%left '<' '<=' '>' '>=' '=' '!='
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
	IDENTIFIER "(" parameters ")" "=" "{" e "}" {$$ = ["function","public","Object",$1,$3,["statements",[["semicolon",["return",$7]]]]];}
	| IDENTIFIER "(" parameters ")" "=" arithmetic_expr {$$ = ["function","public","Object",$1,$3,["statements",[["semicolon",["return",$6]]]]];};

e
    :
    e '||' e
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
    | e '!=' e
        {$$ = [$2,$1,$3];}
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


not_expr: "!" dot_expr {$$ = ["!", [".",$2]];} | dot_expr {$$ = [".", $1];};


dot_expr: parentheses_expr "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: IDENTIFIER "[" e "]" {$$ = ["access_array",$1,[$3]];};

parentheses_expr:
    access_array
    | parentheses_expr "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | '(' e ')' {$$ = ["parentheses",$2];}
    | parentheses_expr_;

parentheses_expr_:
	NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};


parameter: IDENTIFIER {$$ = ["Object",$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | "void" {$$ = [];} | {$$ = [];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
