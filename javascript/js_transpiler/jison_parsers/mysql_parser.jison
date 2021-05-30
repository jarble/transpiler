/* lexical grammar */
%lex
%options case-insensitive
%%

(\s+|\/\/+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"create"              return 'create'
"declare"             return 'declare'
"procedure"           return 'procedure'
"table"               return 'table'
"function"            return 'function'
"returns"             return 'returns'
"repeat"              return 'repeat'
"begin"               return 'begin'
"then"                return 'then'
"when"                return 'when'
"and"                 return 'and'
"or"                  return 'or'
"end"                 return 'end'
"set"                 return 'set'
"if"                  return "if"
"do"                  return 'do'
"else"                return "else"
"elseif"              return "elseif"
"return"              return "return"
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
%left '||' 'or'
%left '&&' 'and'
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

struct_statements: struct_statement "," struct_statements {$$ = [$1].concat($3);} | struct_statement {$$ =
 [$1];};
 
struct_statement: type IDENTIFIER {$$ = ["struct_statement",$2,$1];};

statements: statements_ {$$ = ["statements",$1]};


access_modifier: "public" | "private";


statement
    :
	"create" "function" IDENTIFIER "(" parameters ")" "returns" type "begin" statements "end" ";" {$$ = ["function","public",$8,$3,$5,$10];}
	| "create" "procedure" IDENTIFIER "(" parameters ")" "begin" statements "end" ";" {$$ = ["function","public","void",$3,$5,$8];}
    | "create" "table" IDENTIFIER "(" struct_statements ")" ";" {$$ = ["struct",$3,["struct_statements",$5]]}
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
   |"return" e  {$$ = ["return",$2];}
   | type IDENTIFIER "=" e {$$ = ["initialize_var",$1,$2,$4];}
   | "declare" IDENTIFIER type "(" parentheses_expr ")" {$$ = ["set_array_size",$3,$2,$5];}
   | "declare" IDENTIFIER type {$$ = ["initialize_empty_vars",$3,[$2]];}
   | "set" access_array "=" e {$$ = ["set_var",$2,$4];}
   | "set" IDENTIFIER "=" e {$$ = ["set_var",$2,$4];}
   ;
e
    :
    e "?" e ":" e {$$ = ["ternary_operator",$1,$3,$5]}
    |e '||' e
        {$$ = [$2,$1,$3];}
    |e 'or' e
        {$$ = ["||",$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e 'and' e
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
parameter: "out" IDENTIFIER type {$$ = ["out_parameter",$3,$2];} | "inout" IDENTIFIER type {$$ = ["ref_parameter",$3,$2];} | IDENTIFIER type {$$ = [$2,$1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = [];};
exprs: expr "," exprs {$$ = [$1].concat($3);} | expr {$$ = [$1];};
expr: e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
else_:"else"|"ELSE";
elif:
	"elseif" e "then" statements elif {$$ = ["elif",$2,$4,$5]}
	| "else" statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

bracket_statements: statement_with_semicolon ";" {$$ = ["semicolon",$1];};
