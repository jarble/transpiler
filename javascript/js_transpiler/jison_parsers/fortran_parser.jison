/* lexical grammar */
%lex
%options case-insensitive
%%

\s+                                   /* IGNORE */
"!".*                                /* IGNORE */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
"double precision"    return 'double precision'
"subroutine"          return "subroutine"
"function"            return "function"
"type"                return 'type'
"dimension"           return "dimension"
"parameter"           return 'parameter'
"inout"               return 'inout'
"enddo"               return "enddo"
"intent"              return 'intent'
"end"                 return "end"
"out"                 return 'out'
"len"                 return 'len'
".true."              return '.true.'
".false."             return '.false.'
".and."               return '.and.'
".or."                return '.or.'
".eq."                return '.eq.'
".neq."               return '.neq.'
".ne."                return '.ne.'
".gt."                return '.gt.'
".lt."                return '.lt.'
".ge."                return '.ge.'
".le."                return '.le.'
"then"                return 'then'
"struct"              return 'struct'
"elseif"              return 'elseif'
"select"              return 'select'
"if"                  return 'if'
"else"                return 'else'
"case"                return 'case'
"call"                return 'call'
"return"              return 'return'
"while"               return 'while'
"for"                 return 'for'
"repeat"              return 'repeat'
"until"               return 'until'
"of"                  return 'of'
".not."               return '.not.'
","                   return ','
".."                  return '..'
"."                   return '.'
"::"                  return '::'
":"                   return ':'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"/="                  return '/='
"=="                  return '=='
"="                   return '='
"*="                  return '*='
"**"                  return '**'
"/"                   return '/'
"%"                   return '%'
"-"                   return '-'
"+"                   return '+'
"*"                   return '*'
"(/"                  return '(/'
"\)"                  return '/)'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
"_"                   return '_'
"pairs"               return 'pairs'
"in"                  return 'in'
"do"                  return 'do'
[a-zA-Z_][a-zA-Z0-9_]* return 'identifier'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '.or.'
%left '.and.'
%left '<' '<=' '>' '>=' '==' '/=' '.neq.' '.ge.' '.le.' '.gt.' '.lt.' '.eq.' '.ne.'
%left '..' '+' '-'
%left '*' '/' '%'
%left '**'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : top_level_statements EOF
        {return ["top_level_statements",$1];}
    ;

statements_: statements_without_vars | initialize_vars statements_without_vars {$$ = [["lexically_scoped_vars",$1,["statements",$2]]]};
statements_without_vars: statement statements_without_vars {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};
initialize_vars: initialize_vars initialize_var {$$ = $1.concat([$2]);} | initialize_var {$$ =
 [$1];};


statements: statements_ {$$ = ["statements",$1]};

top_level_statement:
	 var_type "," "parameter" "::" IDENTIFIER "=" e {$$ = ["semicolon",["initialize_constant",$1,$5,$7]];} | statement | initialize_var1 {$$ = ["semicolon",$1]};
top_level_statements: top_level_statements top_level_statement {$$ = $1.concat([$2]);} | top_level_statement {$$ =
 [$1];};
statement
    :
    statement_with_semicolon {$$ = ["semicolon",$1];}
    | "while" e "do" statements "enddo" {$$ = ["while",$2,$4];}
    | "type" IDENTIFIER struct_statements "end" "type" IDENTIFIER {$$ = ["struct",$2,["struct_statements",$3]]}
    | "do" "while" e bracket_statements "enddo" {$$ = ["do_while",$3,$4];}
    | "do" IDENTIFIER "=" IDENTIFIER "," IDENTIFIER statements "end" "do" {$$ = ["foreach_in_range",$2,$3,$5,$7];}
    | "do" statements "end" "do" {$$ = ["infinite_loop",$2];}
    | "if" e "then" statements elif "end" "if" {$$ = ["if",$2,$4,$5];}
	| "if" e "then" statements "end" "if" {$$ = ["if",$2,$4];}
	| "select" "case" e case_statements "end" "select" {$$ = ["switch",$3,$4];}
    | "subroutine" IDENTIFIER "(" ")" statements "end" "subroutine" IDENTIFIER {$$ = ["function","public","void",$2,[],$5];}
    | "subroutine" IDENTIFIER "(" identifiers ")" parameters statements "end" "subroutine" IDENTIFIER {$$ = ["function","public","void",$2,$6,$7];}
    | IDENTIFIER "function" IDENTIFIER "(" ")" statements "end" "function" IDENTIFIER {$$ = ["function","public",$1,$3,[],$6];}
    | IDENTIFIER "function" IDENTIFIER "(" identifiers ")" parameters statements "end" "function" IDENTIFIER {$$ = ["function","public",$1,$3,$7,$8];}
    ;


struct_statements: struct_statement struct_statements {$$ = [$1].concat($2);} | struct_statement {$$ =
 [$1];};

struct_statement:
	set_array_size {$$ = ["semicolon",$1];}
	| var_type "::" IDENTIFIER {$$ = ["struct_statement",$1,[$3]];};


case_statement: "case" e statements {$$ = ["case",$2,$3]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "default" statements {$$ = $1.concat([["default",$4]])} | case_statements_;


statement_with_semicolon
   : 
   var_type "::" identifiers {$$ = ["initialize_empty_vars",$1,$3];}
   | var_type identifiers {$$ = ["initialize_empty_vars",$1,[$2]];}
   | set_array_size
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | "call" function_call {$$ = $2;}
   | "return" {$$ = "return";}
   ;

set_array_size:
	var_type "," "dimension" "(" "0" ":" e ")" "::" IDENTIFIER {$$ = ["set_array_size",$1,$10,$7];}
	|var_type "(" "len" "=" e ")" "::" IDENTIFIER {$$ = ["set_array_size",$1,$8,$5];}
	;

initialize_var1: initialize_var_ {$$ = ["initialize_var"].concat($1);};
initialize_var: initialize_var_ {$$ = ["lexically_scoped_var"].concat($1);};
initialize_var_:
	var_type "::" IDENTIFIER "=" e {$$ = [$1,$3,$5];};

e
    :
    e '.or.' e
        {$$ = ['||',$1,$3];}
    |e '.and.' e
        {$$ = ['&&',$1,$3];}
    |e '>' e
        {$$ = [$2,$1,$3];}
    |e '.gt.' e
        {$$ = [">=",$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    |e '.lt.' e
        {$$ = ["<=",$1,$3];}
    |e '<=' e
        {$$ = [$2,$1,$3];}
    |e '.le.' e
        {$$ = ["<=",$1,$3];}
    | e ('>='|'.ge.') e
        {$$ = [$2,$1,$3];}
    | e '.ge.' e
        {$$ = [">=",$1,$3];}
    | e ('==') e
        {$$ = [$2,$1,$3];}
    | e ('.eq.') e
        {$$ = [$2,$1,$3];}
    | e '/=' e
        {$$ = ["!=",$1,$3];}
    | e '.neq.' e
        {$$ = ["!=",$1,$3];}
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
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | not_expr
    ;


not_expr: ".not." dot_expr {$$ = ["!", [".",$2]];} | dot_expr {$$ = [".", $1];};


dot_expr: parentheses_expr "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: parentheses_expr_ "[" e "]" {$$ = ["access_array",$1,[$3]];};

function_call:
    parentheses_expr_ "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr_ "(" function_call_exprs ")" {$$ = ["function_call",$1,$3];}
    | parentheses_expr_ "(" named_parameters ")" {$$ = ["function_call",$1,$3];};

named_parameters: named_parameters "," named_parameter {$$ = $1.concat([$3]);} | named_parameter {$$ = [$1];};
named_parameter: IDENTIFIER "=" function_call_expr {$$ = ["named_parameter",$1,$3]};

parentheses_expr_:
    "(/" "/)" {$$ = ["initializer_list","Object",[]];} | "(/" exprs "/)" {$$ = ["initializer_list","Object",$2];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext.toLowerCase();}
    | '.true.'
        {$$ = ['.',['true']];}
    | '.false.'
        {$$ = ['.',['false']];}
    | STRING_LITERAL
        {$$ = yytext;};

IDENTIFIER: identifier
        {$$ = yytext.toLowerCase();};

parentheses_expr:
    '(' e ')' {$$ = ["parentheses",$2];}
    | access_array
    | function_call
    | parentheses_expr_;


var_type: "double precision" | IDENTIFIER;
parameter:
	var_type "," "intent" "(" "in" ")" "::" identifiers {$$ = ["in_parameter",$1, $8];}
	| var_type "," "intent" "(" "out" ")" "::" identifiers {$$ = ["out_parameter",$1, $8];}
	| var_type "," "intent" "(" "inout" ")" "::" identifiers {$$ = ["ref_parameter",$1, $8];};
parameters: parameters parameter {$$ = $1.concat([$2]);} | parameter {$$ =
 [$1];};

exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
function_call_exprs: function_call_expr "," function_call_exprs {$$ = [$1].concat($3);} | function_call_expr {$$ = [$1];};
function_call_expr: e {$$ = ["function_call_ref",$1];};

types: var_type "," types {$$ = [$1].concat($3);} | var_type {$$ = [$1];};
elif:
	"elseif" e "then" statements elif {$$ = ["elif",$2,$4,$5]} | "elseif" e "then" statements {$$ = ["elif",$2,$4]}
	| "else" statements {$$ = ["else",$2];};
identifiers: identifiers "," IDENTIFIER {$$ = $1.concat([$3]);} | IDENTIFIER {$$ = [$1];};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: STRING_LITERAL "=" e {$$ = [$1,$3]};

