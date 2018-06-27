/* lexical grammar */
%lex
%%

(\s+|\/\/+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"#define"             return '#define'
"if"                  return "if"
"do"                  return 'do'
"else"                return "else"
"enum"                return 'enum'
"return"              return "return"
"void"                return "void"
"case"                return "case"
"printf"              return "printf"
"while"               return "while"
"break"               return "break"
"default"             return "default"
"const"               return "const"
"struct"              return "struct"
"switch"              return "switch"
"for"                 return "for"
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"&&"                  return '&&'
"&"                   return '&'
"||"                  return '||'
"!="                  return '!='
'!'                   return '!'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"=="                  return '=='
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
%left '<' '<=' '>' '>=' '==' '!='
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
 
struct_statement: type identifiers ";" {$$ = ["struct_statement",$1,$2];} | set_array_size ";" {$$ = ["semicolon", $1];};

statements: statements_ {$$ = ["statements",$1]};


access_modifier: "public" | "private";


statement
    :
	"#define" IDENTIFIER "(" exprs ")" "(" expr ")" {$$ = ["macro",$2,$4,$7];}
	| "struct" IDENTIFIER "{" struct_statements "}" ";" {$$ = ["struct",$2,["struct_statements",$4]]}
	| "enum" IDENTIFIER "{" enum_statements "}" ";" {$$ = ["enum","public",$2,$4];}
	| type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["function","public",$1,$2,$4,$7];}
	| type IDENTIFIER "(" "void" ")" "{" statements "}" {$$ = ["function","public",$1,$2,[],$7];}
    | statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | "while" "(" e ")" bracket_statements {$$ = ["while",$3,$5];}
    | "do" bracket_statements "while" "(" e ")" ";" {$$ = ["do_while",$2,$5];}
    | "switch" "(" e ")" "{" case_statements "}" {$$ = ["switch",$3,$6];}
    | "for" "(" statement_with_semicolon ";" e ";" statement_with_semicolon ")" bracket_statements {$$ = ["for",$3,$5,$7,$9];}
    | "if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
	| "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];}
    ;

case_statement: "case" e ":" statements "break" ";" {$$ = ["case",$2,$4]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "default" ":" statements {$$ = $1.concat([["default",$4]])} | case_statements_;

statement_with_semicolon
   : 
   IDENTIFIER "(" ")" {$$ = ["function_call",$1,[]];}
   | IDENTIFIER "(" exprs ")" {$$ = ["function_call",$1,$3];}
   |"return" e  {$$ = ["return",$2];}
   | type IDENTIFIER "=" e {$$ = ["initialize_var",$1,$2,$4];}
   | type IDENTIFIER "[" "]" "=" e {$$ = ["initialize_var",[$1,"[]"],$2,$6];}
   | "const" type IDENTIFIER "=" e {$$ = ["initialize_constant",$2,$3,$5];}
   | "const" type IDENTIFIER "[" "]" "=" e {$$ = ["initialize_constant",[$2,"[]"],$3,$7];}
   | set_array_size
   | type identifiers {$$ = ["initialize_empty_vars",$1,$2];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "++" {$$ = [$2,$1];}
   | IDENTIFIER "--" {$$ = [$2,$1];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   ;

set_array_size:
	type access_array {$$ = ["set_array_size",$1,$2[1],$2[2]];};

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
    | e '==' e
        {$$ = [$2,$1,$3];}
    | e '!=' e
        {$$ = [$2,$1,$3];}
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
parameter: type "*" IDENTIFIER {$$ = ["ref_parameter",$1,$3]} | type IDENTIFIER {$$ = [$1,$2];} | type IDENTIFIER "[" "]" {$$ = [[$1,"[]"],$2];} | "const" type IDENTIFIER {$$ = ["final_parameter",$2,$3]};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = [];};
exprs: expr "," exprs {$$ = [$1].concat($3);} | expr {$$ = [$1];};
expr: "&" e {$$ = ["function_call_ref",$2];} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif:
	"else" "if" "(" e ")" bracket_statements elif {$$ = ["elif",$4,$6,$7]}
	| "else" bracket_statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};
enum_statements: enum_statement "," enum_statements {$$ = [$1].concat($3);} | enum_statement {$$ = [$1];};
enum_statement: IDENTIFIER "=" NUMBER {$$ = ["enum_statement",$1,$3]};

bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon ";" {$$ = ["semicolon",$1];};
