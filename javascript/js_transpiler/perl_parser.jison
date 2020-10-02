/* lexical grammar */
%lex
%%

\s+                                   /* IGNORE */
"#".*                                /* IGNORE */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\"    return 'STRING_LITERAL'
"$"                   return "$"
"@_"                  return "@_"
"@"                   return "@"
"foreach"             return 'foreach'
"unless"              return "unless"
"sub"                 return "sub"
"class"               return "class"
"public"              return "public"
"extends"             return "extends"
"implements"          return "implements"
"private"             return "private"
"static"              return "static"
"if"                  return 'if'
"else"                return 'else'
"elsif"               return 'elsif'
"return"              return 'return'
"sin"                 return "sin"
"tan"                 return "tan"
"cos"                 return "cos"
"while"               return 'while'
"for"                 return 'for'
"my"                  return 'my'
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
">="                  return '>='
">>"                  return '>>'
">"                   return '>'
"<>"                  return '<>'
"<="                  return '<='
"<<"                  return '<<'
"<"                   return '<'
"=>"                  return '=>'
"=="                  return '=='
"="                   return '='
"%"                   return '%'
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
"?"                   return '?'
"{"                   return '{'
"}"                   return '}'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
"PI"                  return 'PI'
"E"                   return 'E'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%right '?'
%left '&&' '||'
%left '<' '<=' '>' '>=' '=='
%left '>>' '<<'
%left '+' '-' '.'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: top_level_statements EOF {return ["top_level_statements",$1]};
top_level_statements: top_level_statements top_level_statement {$$ = $1.concat([$2]);} | top_level_statement {$$ =
 [$1];};
top_level_statement:
	statement | initialize_var1 ";" {$$ = ["semicolon",$1]};
initialize_var1: initialize_var_ {$$ = ["initialize_var"].concat($1);};
initialize_var: initialize_var_ {$$ = ["lexically_scoped_var"].concat($1);};

statements_: statements_with_vars | initialize_var_ ";" {$$ = [["semicolon",["initialize_var"].concat($1)]]} | initialize_var_ ";" statements_ {$$ = [["lexically_scoped_vars",[["lexically_scoped_var"].concat($1)],["statements",$3]]]};
initialize_vars: initialize_vars ";" initialize_var {$$ = $1.concat([$3]);} | initialize_var {$$ =
 [$1];};

statements_without_vars: statements_without_vars statement {$$ = $1.concat([$2]);} | statement {$$ =
 [$1];};
statements_with_vars: statements_without_vars initialize_var1 ";" {$$ = $1.concat([["semicolon",$2]]);} | statements_without_vars;


class_statements: class_statements_ {$$ = ["class_statements",$1]};
statements: statements_ {$$ = ["statements",$1]};


class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};

statement
    :
    statement_with_semicolon "if" e ";" {$$ = ["if",$3,["statements",["semicolon",$1]]];}
    | statement_with_semicolon "unless" e ";" {$$ = ["unless",$3,["statements",[["semicolon",$1]]]];}
    | statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | "while" "(" e ")" bracket_statements {$$ = ["while",$3,$5];}
    | "do" bracket_statements "while" "(" e ")" ";" {$$ = ["do_while",$2,$5];}
    | "foreach" var_name "(" var_name ")" "{" statements "}" {$$ = ["foreach","Object",$2,$4,$7];}
    | "for" "(" statement_with_semicolon_ ";" e ";" statement_with_semicolon_ ")" "{" statements "}" {$$ = ["for",$3,$5,$7,$10];}
    | "if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
	| "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];}
	| "unless" "(" e ")" "{" statements "}" {$$ = ["unless",$3,$6];}
    | "sub" IDENTIFIER "{" my "(" parameters ")" "=" "@_" ";" statements "}" {$$ = ["function","public","Object",$2,$6,$11];}
    ;

statement_with_semicolon_: initialize_var1 | statement_with_semicolon;

class_statement:
	"static" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method","public","Object",$2,$4,$7];}
	| IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["instance_method","public","Object",$1,$3,$6];}
	;

statement_with_semicolon
   : 
   parentheses_expr
   | "return" e  {$$ = ["return",$2];}
   | "my" var_names {$$ = ["initialize_empty_vars","Object",$2];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | var_name "=" e {$$ = ["set_var",$1,$3];}
   | var_name "++" {$$ = [$2,$1];}
   | var_name "--" {$$ = [$2,$1];}
   | var_name "+=" e {$$ = [$2,$1,$3];}
   | var_name "-=" e {$$ = [$2,$1,$3];}
   | var_name "*=" e {$$ = [$2,$1,$3];}
   | var_name "/=" e {$$ = [$2,$1,$3];}
   ;

initialize_var_:
	"my" var_name "=" e {$$ = ["Object",$2,$4];};

e
    :
    e "?" e ":" e {$$ = ["ternary_operator",$1,$3,$5]}
    |e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e '<=' e
        {$$ = [$2,$1,$3];}
    |e '<<' e
        {$$ = [$2,$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e '>=' e
        {$$ = [$2,$1,$3];}
    |e '>>' e
        {$$ = [$2,$1,$3];}
    |e '>' e
        {$$ = [$2,$1,$3];}
    | e '==' e
        {$$ = [$2,$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '.' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | e '%' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | not_expr
    ;


not_expr: "!" parentheses_expr {$$ = ["!", [".",$2]];} | parentheses_expr;

access_array: var_name "[" e "]" {$$ = ["access_array",$1,[$3]];};

parentheses_expr:
    access_array
    | IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];}
    | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | "(" ")" {$$ = ["initializer_list_or_parentheses",[]];} | "(" key_values ")" {$$ = ["associative_array","Object","Object",$2];} | "(" exprs ")" {$$ = ["initializer_list","Object",$2];}
    | NUMBER
        {$$ = yytext;}
    | var_name
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;}
    | "<>";

type: IDENTIFIER "[" "]" {$$ = [$1,"[]"];} | IDENTIFIER "<" types ">" {$$ = [$1,$3]} | IDENTIFIER;
parameter: var_name {$$ = ["Object", $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif:
	"elsif" "(" e ")" bracket_statements elif {$$ = ["elif",$3,$5,$6]}
	| "else" bracket_statements {$$ = ["else",$2];};


var_name: "$" IDENTIFIER {$$ = $2;} | "@" IDENTIFIER {$$ = $2;};
var_names: var_name "," var_names {$$ = [$1].concat($3);} | var_name {$$ = [$1];};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: STRING_LITERAL "=>" e {$$ = [$1,$3]} | IDENTIFIER ":" e {$$ = ["\""+$1+"\"",$3]};

bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon ";" {$$ = ["semicolon",$1];};
