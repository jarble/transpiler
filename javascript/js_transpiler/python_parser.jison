/* lexical grammar */
%lex
%%

(\s+|\-\-+.*)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"\n"                  return "\n"
"$"                   return "$"
"def"                 return "def"
"end"                 return "end"
"then"                return "then"
"lambda"              return "lambda"
"if"                  return 'if'
"else"                return 'else'
"return"              return 'return'
"while"               return 'while'
"for"                 return 'for'
"local"               return 'local'
"repeat"              return 'repeat'
"until"               return 'until'
"of"                  return 'of'
"not"                 return 'not'
","                   return ','
".."                  return '..'
"."                   return '.'
":"                   return ':'
"and"                 return 'and'
"or"                  return 'or'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"~="                  return '~='
"=="                  return '=='
"="                   return '='
"**"                  return '**'
"*="                  return '*='
"*"                   return '*'
"/"                   return '/'
"%"                   return '%'
"-"                   return '-'
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
%left '<' '<=' '>' '>=' '==' '~='
%left '..' '+' '-'
%left '*' '/' '%'
%left '^' '**'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : statements_ EOF
        {return ["top_level_statements",$1];}
    ;

statements_: statements_without_vars;
statements_without_vars: statements_without_vars "\n" statement {$$ = $1.concat([$2]);} | statement {$$ =
 [$1];};


statements: statements_ {$$ = ["statements",$1]};

top_level_statement:
	statement {$$ = ["semicolon",$1]};
top_level_statements: top_level_statements top_level_statement {$$ = $1.concat([$2]);} | top_level_statement {$$ =
 [$1];};
statement
    :
    statement_with_semicolon {$$ = ["semicolon",$1];}
    ;

statement_with_semicolon
   : 
   "return" e  {$$ = ["return",$2];}
   | parallel_assignment
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "." dot_expr {$$ = [".",[$1].concat($3)]}
   | function_call
   ;

parallel_assignment:
	parallel_lhs,"=",parallel_rhs {$$ = ["parallel_assignment",["parallel_lhs",$1],["parallel_rhs",$3]]};

parallel_lhs: parallel_lhs "," IDENTIFIER {$$ = [$1.concat([$3])];} | IDENTIFIER "," IDENTIFIER {$$ = [$1,$3]};
parallel_rhs: parallel_rhs "," e {$$ = [$1.concat([$3])];} | e "," e {$$ = [$1,$3]};


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
    | e '~=' e
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
    | e '**' e
        {$$ = ["**",$1,$3];}
    | e '^' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | not_expr
    ;


not_expr: "not" dot_expr {$$ = ["!", [".",$2]];} | dot_expr {$$ = [".", $1];};


dot_expr: parentheses_expr "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: parentheses_expr_ "[" e "]" {$$ = ["access_array",$1,[$3]];};

function_call:
    parentheses_expr_ "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr_ "(" exprs ")" {$$ = ["function_call",$1,$3];};

parentheses_expr_:
    "{" "}" {$$ = ["initializer_list","Object",[]];} | "{" exprs "}" {$$ = ["initializer_list","Object",$2];}
    | "{" key_values "}" {$$ = ["associative_array","Object","Object",$2];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

parentheses_expr:
    "(" "lambda" parameters ":" e ")" {$$ = ["anonymous_function","Object",$3,["statements",[["return",$5]]]];}
    | '(' e ')' {$$ = ["parentheses",$2];}
    | access_array
    | function_call
    | parentheses_expr_;



type: IDENTIFIER;
parameter: IDENTIFIER {$$ = ["Object", $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = [];};

exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};

identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: STRING_LITERAL ":" e {$$ = [$1,$3]};

