/* lexical grammar */
%lex
%%

(\s+|\/\/+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"CREATE"              return 'CREATE'
"DECLARE"             return 'DECLARE'
"FUNCTION"            return 'FUNCTION'
"RETURNS"             return 'RETURNS'
"REPEAT"              return 'REPEAT'
"repeat"              return 'repeat'
"BEGIN"               return 'BEGIN'
"THEN"                return 'THEN'
"then"                return 'then'
"END"                 return 'END'
"SET"                 return 'SET'
"set"                 return 'set'
"if"                  return "if"
"IF"                  return "IF"
"do"                  return 'do'
"DO"                  return 'DO'
"else"                return "else"
"ELSE"                return "ELSE"
"ELSEIF"              return "ELSEIF"
"elseif"              return "elseif"
"RETURN"              return "RETURN"
"void"                return "void"
"case"                return "case"
"printf"              return "printf"
"while"               return "while"
"WHILE"               return "WHILE"
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
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%right '?'
%left '||'
%left '&&'
%left '<' '<=' '>' '>=' '=' '<>'
%left ('<' '<') ('>' '>')
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};

struct_statements: struct_statement struct_statements {$$ = [$1].concat($2);} | struct_statement {$$ =
 [$1];};
 
struct_statement: type identifiers ";" {$$ = ["struct_statement",$1,$2];};

statements: statements_ {$$ = ["statements",$1]};


access_modifier: "public" | "private";


statement
    :
	"CREATE" "FUNCTION" IDENTIFIER "(" parameters ")" "RETURNS" type "BEGIN" statements end_ {$$ = ["function","public",$8,$3,$5,$10];}
	| type IDENTIFIER "(" "void" ")" "{" statements "}" {$$ = ["function","public",$1,$2,[],$7];}
    | statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | while_ e do_ statements end_ while_ ";" {$$ = ["while",$2,$4];}
    | if_ e then_ statements elif end_ if_ ";" {$$ = ["if",$2,$4,$5];}
	| if_ e then_ statements end_ if_ ";" {$$ = ["if",$2,$4];}
    ;

do_: "DO"|"do";
while_: "WHILE"|"while";
end_: "END"|"end";
then_:"then"|"THEN";
if_:"IF"|"if";
set_:"set"|"SET";
repeat_:"REPEAT"|"repeat";

case_statement: "case" e ":" statements "break" ";" {$$ = ["case",$2,$4]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "default" ":" statements {$$ = $1.concat([["default",$4]])} | case_statements_;

statement_with_semicolon
   : 
   IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];}
   | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];}
   |"RETURN" e  {$$ = ["return",$2];}
   | type IDENTIFIER "=" e {$$ = ["initialize_var",$1,$2,$4];}
   | "DECLARE" type IDENTIFIER {$$ = ["initialize_empty_vars",$3,[$2]];}
   | set_ access_array "=" e {$$ = ["set_var",$2,$4];}
   | set_ IDENTIFIER "=" e {$$ = ["set_var",$2,$4];}
   ;
e
    :
    e "?" e ":" e {$$ = ["ternary_operator",$1,$3,$5]}
    |e '||' e
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
        {$$ = ["==",$1,$3];}
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
parameter: "out" IDENTIFIER type {$$ = ["out_parameter",$3,$2];} | "inout" IDENTIFIER type {$$ = ["ref_parameter",$3,$2];} | IDENTIFIER type {$$ = [$2,$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = [];};
exprs: expr "," exprs {$$ = [$1].concat($3);} | expr {$$ = [$1];};
expr: e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elseif_:"ELSEIF"|"elseif";
else_:"else"|"ELSE";
elif:
	elseif_ e then_ statements elif {$$ = ["elif",$2,$4,$5]}
	| else_ statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

bracket_statements: statement_with_semicolon ";" {$$ = ["semicolon",$1];};
