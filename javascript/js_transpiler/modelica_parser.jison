/* lexical grammar */
%lex
%%

(\s+|\/\/+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"function"            return 'function'
"repeat"              return 'repeat'
"then"                return 'then'
"when"                return 'when'
"set"                 return 'set'
"if"                  return "if"
"do"                  return 'do'
"DO"                  return 'DO'
"else"                return "else"
"elseif"              return "elseif"
"RETURN"              return "RETURN"
"void"                return "void"
"case"                return "case"
"printf"              return "printf"
"while"               return "while"
"break"               return "break"
"default"             return "default"
"const"               return "const"
"struct"              return "struct"
"switch"              return "switch"
"inout"               return 'inout'
"out"                 return 'out'
"for"                 return "for"
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"&&"                  return '&&'
"&"                   return '&'
"||"                  return '||'
"<>"                  return '<>'
"!="                  return '!='
'!'                   return '!'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
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
[a-zA-Z_][a-zA-Z0-9_]* return 'identifier'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%right '?'
%left '||' 'OR'
%left '&&' 'AND'
%left '<' '<=' '>' '>=' '=' '<>' '!='
%left ('<' '<') ('>' '>')
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

IDENTIFIER: identifier {$$ = yytext.toLowerCase()};

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};

struct_statements: struct_statement struct_statements {$$ = [$1].concat($2);} | struct_statement {$$ =
 [$1];};
 
struct_statement: type identifiers ";" {$$ = ["struct_statement",$1,$2];};

statements: statements_ {$$ = ["statements",$1]};




statement
    :
	"function" IDENTIFIER parameters ";" "algorithm" statements "end" IDENTIFIER {$$ = ["function","public",$8,$3,$5,$10];}
    | statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | "while" e "do" statements "end" "while" ";" {$$ = ["while",$2,$4];}
    | "if" e "then" statements elif "end" "if" ";" {$$ = ["if",$2,$4,$5];}
	| "if" e "then" statements "end" "if" ";" {$$ = ["if",$2,$4];}
    ;

case_statement: "when" e "then" statements {$$ = ["case",$2,$4]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "else" statements {$$ = $1.concat([["default",$4]])} | case_statements_;

statement_with_semicolon
   : 
   IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];}
   | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];}
   | type IDENTIFIER "=" e {$$ = ["initialize_var",$1,$2,$4];}
   | access_array ":=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER ":=" e {$$ = ["set_var",$1,$3];}
   ;
e
    :
    e "?" e ":" e {$$ = ["ternary_operator",$1,$3,$5]}
    |e '||' e
        {$$ = [$2,$1,$3];}
    |e 'OR' e
        {$$ = ["||",$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e 'AND' e
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
        {$$ = ["==",$1,$3];}
    | e '!=' e
        {$$ = ["!=",$1,$3];}
    | e '<>' e
        {$$ = ["!=",$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '%' e
        {$$ = [$2,$1,$3];}
    | e ('>' '>') e
        {$$ = [">>",$1,$3];}
    | e ('<' '<') e
        {$$ = ["<<",$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
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

type: "void" | IDENTIFIER;
parameter: "input" type IDENTIFIER {$$ = [$2,$3];};
parameters: parameters ";" parameter {$$ = $1.concat([$3]);} | parameter {$$ =
 [$1];} | {$$ = [];};
exprs: expr "," exprs {$$ = [$1].concat($3);} | expr {$$ = [$1];};
expr: e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif:
	"elseif" e "then" statements elif {$$ = ["elif",$2,$4,$5]}
	| "else" statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

bracket_statements: statement_with_semicolon ";" {$$ = ["semicolon",$1];};
