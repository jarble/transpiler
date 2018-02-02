/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"predicate"           return 'predicate'
"function"            return "function"
"var"                 return "var"
"if"                  return "if"
"endif"               return "endif"
"elseif"              return "elseif"
"else"                return "else"
"then"                return "then"
"return"              return "return"
"constraint"          return "constraint"
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
"|"                   return '|'
"<->"                 return '<->'
"<-"                  return '<-'
"->"                  return '->'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"!="                  return '!='
"=="                  return '=='
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
"^"                   return '^'
"{"                   return '{'
"}"                   return '}'
"!!"                  return '!!'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '->' '<->' '<-'
%left '||'
%left '&&'
%left '==' '<' '<=' '>' '>=' '!='
%left '+' '-'
%left '*' '/'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement_ statements_ {$$ = [$1].concat($2);} | statement_ {$$ =
 [$1];};


statement_:
	"function" "var" IDENTIFIER ":" IDENTIFIER "(" parameters ")" "=" statement ";" {$$ = ["function","public",$3,$5,$7,$10];}
	| "predicate" IDENTIFIER "(" parameters ")" "=" statement ";" {$$ = ["predicate",$2,$4,$7];}
	| IDENTIFIER ":" IDENTIFIER "=" e ";" {$$ = ["semicolon",["initialize_var",$1,$3,$5]];}
	| "constraint" e ";" {$$ = ["semicolon",["function_call","constraint",[$2]]];};

statement:
    if_statement
    |statement_with_semicolon {$$ = ["semicolon",$1];};

statement_with_semicolon
   :
   e {$$ = ["return",$1];}
   ;
e
    :
    e '<->' e
        {$$ = ['iff',$1,$3];}
    |e '<-' e
        {$$ = ['implies',$3,$1];}
    |e '->' e
        {$$ = ['implies',$1,$3];}
    |e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e '==' e
        {$$ = [$2,$1,$3];}
    |e '!=' e
        {$$ = [$2,$1,$3];}
    |e '<=' e
        {$$ = [$2,$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e '>=' e
        {$$ = [$2,$1,$3];}
    | e '>' e
        {$$ = [$2,$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | IDENTIFIER "(" args ")"
        {$$ = ["function_call",$1,$3];}
    | parentheses_expr {$$ = $1;}
    ;


parentheses_expr:
    "(" e ")" {$$ = $2}
    | "[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
    | STRING_LITERAL
        {$$ = yytext;}
    ;

type: IDENTIFIER;
parameter: "var" IDENTIFIER ":" IDENTIFIER {$$ = [$2,$4];};
parameters: parameter ","  parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
args: e "," args {$$ = [$1].concat($3);} | e {$$ = [$1];};
elif: "elseif" e "then" statement elif {$$ = ["elif",$2,$4,$5]} | else_statement;
else_statement: "else" statement {$$ = ["else",$2];};
if_statement:
"if" e "then" statement elif "endif" {$$ = ["if",$2,$4,$5];}
| "if" e "then" statement "endif" {$$ = ["if",$2,$4];};
