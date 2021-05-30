/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"predicate"           return 'predicate'
"function"            return "function"
"include"             return 'include'
"var"                 return "var"
"div"                 return 'div'
"if"                  return "if"
"endif"               return "endif"
"elseif"              return "elseif"
"else"                return "else"
"then"                return "then"
"return"              return "return"
"constraint"          return "constraint"
"forall"              return "forall"
"union"               return "union"
"intersect"           return "intersect"
"superset"            return "superset"
"subset"              return "subset"
","                   return ','
";"                   return ';'
".."                  return '..'
"."                   return '.'
":"                   return ':'
"/\\"                 return '/\\'
"\\/"                 return '\\/'
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
%left '\\/'
%left '/\\'
%left '==' '<' '<=' '>' '>=' '!='
%left '+' '-'
%left '*' '/' 'div'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement_ statements_ {$$ = [$1].concat($2);} | statement_ {$$ =
 [$1];};

statement_:
	"function" "var" IDENTIFIER ":" IDENTIFIER "(" parameters ")" "=" e ";" {$$ = ["function","public",$3,$5,$7,$10];}
	| "function" IDENTIFIER ":" IDENTIFIER "(" parameters ")" "=" e ";" {$$ = ["function","public",$2,$4,$6,$9];}
	| "predicate" IDENTIFIER "(" parameters ")" "=" e ";" {$$ = ["predicate",$2,$4,$7];}
	| statement_with_semicolon ";" {$$ = ["semicolon",$1]}
	;

statement_with_semicolon:
	"include" STRING_LITERAL {$$ = ["import",$2.substring(1,$2.length-5)];}
	| "var" IDENTIFIER ":" IDENTIFIER {$$ = ["initialize_empty_vars",$2,[$4]];}
	| IDENTIFIER ":" IDENTIFIER {$$ = ["initialize_empty_vars",$1,[$3]]}
	| "var" IDENTIFIER ":" IDENTIFIER "=" e {$$ = ["initialize_var",$2,$4,$6];}
	| IDENTIFIER ":" IDENTIFIER "=" e {$$ = ["initialize_var",$1,$3,$5];}
	| "constraint" e {$$ = ["function_call","constraint",[$2]];}
	| "constraint" IDENTIFIER "=" e {$$ = ["function_call","constraint",[["logic_equals",$2,$4]]];}
	;

e
    :
    if_statement
    |e '<->' e
        {$$ = ['iff',$1,$3];}
    |"forall" "(" e "in" e ")" "(" e ")"
		{$$ = ["foreach","Object",$3,$5,$8];}
    |e '<-' e
        {$$ = ['implies',$3,$1];}
    |e '->' e
        {$$ = ['implies',$1,$3];}
    |e '\\/' e
        {$$ = ["||",$1,$3];}
    |e '/\\' e
        {$$ = ["&&",$1,$3];}
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
    | e 'div' e
        {$$ = ["/",$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | IDENTIFIER "(" args ")"
        {$$ = ["function_call",$1,$3];}
    | parentheses_expr {$$ = $1;}
    ;

set_operator: "union" | "intersection" | "subset" | "superset";

parentheses_expr:
    "(" e ")" {$$ = $2}
    | "(" parentheses_expr ".." parentheses_expr ")" {$$ = ["inclusive_range",$2,$4]}
    | "[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    |"{" exprs "}" {$$ = ["initialize_set","Object",$2];}
    | "(" e set_operator e ")" {$$ = [$3,$2,$4];}
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
elif: "elseif" e "then" e elif {$$ = ["ternary_operator",$2,$4,$5]} | else_statement;
else_statement: "else" e {$$ = $2;};
if_statement:
"if" e "then" e elif "endif" {$$ = ["ternary_operator",$2,$4,$5];};
