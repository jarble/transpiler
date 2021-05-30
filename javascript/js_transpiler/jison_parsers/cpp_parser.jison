/* lexical grammar */
%lex
%%

\s+                                   /* IGNORE */
"//".*                                /* IGNORE */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* IGNORE */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"typename"            return "typename"
"template"            return "template"
"class"               return "class"
"struct"              return "struct"
"enum"                return 'enum'
"cout"                return "cout"
"switch"              return "switch"
"case"                return 'case'
"break"               return "break"
"default"             return 'default'
"public"              return "public"
"extends"             return "extends"
"operator"            return "operator"
"implements"          return "implements"
"Dictionary"          return "Dictionary"
"private"             return "private"
"static"              return "static"
"if"                  return "if"
"do"                  return 'do'
"in"                  return "in"
"else"                return "else"
"return"              return "return"
"while"               return "while"
"foreach"             return "foreach"
"const"               return "const"
"for"                 return "for"
"new"                 return "new"
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"!="                  return '!='
"!"                   return '!'
"&&"                  return '&&'
"&"                   return '&'
"||"                  return '||'
">>"                  return '>>'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<<"                  return '<<'
"<"                   return '<'
"=="                  return '=='
"="                   return '='
"*="                  return '*='
"*"                   return '*'
"/="                  return '/='
"/"                   return '/'
"%"                   return '%'
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
%left '->'
%left '&&' '||'
%left '==' '!=' '<' '<=' '>' '>='
%left '>>' '<<'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statements_without_vars | initialize_var_ ";" {$$ = [["semicolon",["initialize_var"].concat($1)]]} | initialize_var_ ";" statements_with_vars {$$ = [["lexically_scoped_vars",[["lexically_scoped_var"].concat($1)],["statements",$3]]]};
statements_without_vars: statement statements_without_vars {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};
initialize_vars: initialize_vars ";" initialize_var {$$ = $1.concat([$3]);} | initialize_var {$$ =
 [$1];};


class_statements: class_statements_ {$$ = ["class_statements",$1]} | {$$ = ["class_statements",[]]};
statements: statements_ {$$ = ["statements",$1]};


class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};

access_modifier: "public" | "private";

class_:
	"namespace" IDENTIFIER "{" class_statements "}" {$$ = [$1,"public",$2,$4];}
	| "class" IDENTIFIER "{" class_statements "}" ";" {$$ = [$1,"public",$2,$4];}
	| "struct" IDENTIFIER "{" struct_statements "}" ";" {$$ = ["struct",$2,["struct_statements",$4]]}
	| "template" "<" type_params ">" "class" IDENTIFIER "{" class_statements "}" {$$ = ["generic_class","public",$6,$8,$3];}
	| "enum" IDENTIFIER "{" identifiers "}" {$$ = ["enum","public",$2,$4];}
	| "class" IDENTIFIER ":" "public" IDENTIFIER "{" class_statements "}" {$$ = ["class_extends","public",$2,$5,$7];}
	| "class" IDENTIFIER "implements" IDENTIFIER "{" class_statements "}" {$$ = ["class_implements","public",$2,$4,$6];};


top_level_statement:
	statement | initialize_var1 ";" {$$ = ["semicolon",$1]};
top_level_statements: top_level_statements top_level_statement {$$ = $1.concat([$2]);} | top_level_statement {$$ =
 [$1];};
 
struct_statements: struct_statement struct_statements {$$ = [$1].concat($2);} | struct_statement {$$ =
 [$1];};
 
struct_statement: type identifiers ";" {$$ = ["struct_statement",$1,$2];} | set_array_size ";" {$$ = ["semicolon", $1];};


statement
    :
    "template" "<" type_params ">" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["generic_function","public",$5,$6,$8,$11,$3];}
    | statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | class_
    | "while" "(" e ")" bracket_statements {$$ = ["while",$3,$5];}
    | "do" bracket_statements "while" "(" e ")" ";" {$$ = ["do_while",$2,$5];}
    | "switch" "(" e ")" "{" case_statements "}" {$$ = ["switch",$3,$6];}
    | "for" "(" statement_with_semicolon_ ";" e ";" statement_with_semicolon_ ")" bracket_statements {$$ = ["for",$3,$5,$7,$9];}
    | "for" "(" type IDENTIFIER ":" IDENTIFIER ")" bracket_statements {$$ = ["foreach",$3,$4,$6,$8];}
    | "if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
	| "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];}
    | type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["function","public",$1,$2,$4,$7];}
    ;

statement_with_semicolon_: initialize_var1 | statement_with_semicolon;

case_statement: "case" e ":" statements "break" ";" {$$ = ["case",$2,$4]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};

case_statements: case_statements_ "default" ":" statements {$$ = $1.concat([["default",$4]])} | case_statements_;


class_statement:
	class_
	IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["constructor","public",$1,$3,$6];}
	| type IDENTIFIER "=" e ";" {$$ = ["initialize_instance_var_with_value","public",$1,$2,$4];}
	| type IDENTIFIER ";" {$$ = ["initialize_instance_var","public",$1,$2];}
	| "static" type IDENTIFIER "=" e ";" {$$ = ["initialize_static_instance_var","public",$2,$3,$5];}
	| access_modifier "static" type IDENTIFIER "(" parameters ")" ";" {$$ = ["interface_static_method",$1,$3,$4,$6];}
	| access_modifier type IDENTIFIER "(" parameters ")" ";" {$$ = ["interface_instance_method",$1,$2,$3,$5];}
	| "static" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method","public",$2,$3,$5,$8];}
	| type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["instance_method","public",$1,$2,$4,$7];}
	| type "operator" OPERATOR "(" parameters ")" "{" statements "}" {$$ = ["static_overload_operator","public",$1,$3,$5,$8];};

OPERATOR: "+="|"-="|"*="|"/="|"++"|"--"|"<="|">="|"<"|">"|"&&"|"||"|"=="|"+"|"-"|"*"|"/"|"!";

statement_with_semicolon
   : 
   "return" e  {$$ = ["return",$2];}
   | "return"  {$$ = ["return"];}
   | "const" type IDENTIFIER "=" e {$$ = ["initialize_constant",$2,$3,$5];}
   | "const" type identifiers {$$ = ["initialize_empty_constants",$2,$3];}
   | type identifiers {$$ = ["initialize_empty_vars",$1,$2];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "." IDENTIFIER "=" e {$$ = ["set_var",[".",[$1,$3]],$5];}
   | IDENTIFIER "++" {$$ = [$2,$1];}
   | IDENTIFIER "--" {$$ = [$2,$1];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "." dot_expr {$$ = [".",[$1].concat($3)]}
   | function_call
   | "cout" "<<" parentheses_expr {$$ = ["<<",$1,$3];}
   | "cout" "<<" e "<<" parentheses_expr {$$ = ["<<",["<<",$1,$3],$5];}
   ;

initialize_var1: initialize_var_ {$$ = ["initialize_var"].concat($1);};
initialize_var: initialize_var_ {$$ = ["lexically_scoped_var"].concat($1);};
initialize_var_:
   type IDENTIFIER "=" "{" exprs "}" {$$ = [$1,$2,["initializer_list",$1,$5]]}
   | type IDENTIFIER "[" "]" "=" "{" exprs "}" {$$ = [[$1,"[]"],$2,["initializer_list",$1,$7]];}
   | type IDENTIFIER "=" e {$$ = [$1,$2,$4];};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: "{" STRING_LITERAL "," e "}" {$$ = [$2,$4]};

e:
    e "?" e ":" e {$$ = ["ternary_operator",$1,$3,$5]}
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
    |e '>' e
        {$$ = [$2,$1,$3];}
    | e ('>' '>') e
        {$$ = [">>",$1,$4];}
    | e ('<' '<') e
        {$$ = ["<<",$1,$4];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | e '%' e
        {$$ = [$2,$1,$3];}
    | initializer_list
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | dot_expr {$$ = [".", $1];}
    ;



dot_expr: initializer_list  "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr  "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: IDENTIFIER "[" access_arr "]" {$$ = ["access_array",$1,$3];};

initializer_list:
"new" type "{" "}" {$$ = ["initializer_list",$2,[]];} | "new" type "{" exprs "}" {$$ = ["initializer_list",$2,$4];} | "new" type "(" ")" {$$ = [$1,$2,[]];} | "new" type "(" exprs ")" {$$ = [$1,$2,$4];};

parentheses_expr:
    "(" e ")" {$$= $2;}
    |"new" "Dictionary" "<" type "," type ">" "{" key_values "}" {$$ = ["associative_array",$4,$6,$9]}
    |access_array
    |parentheses_expr "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

type: IDENTIFIER "[" "]" {$$ = [$1,"[]"];} | IDENTIFIER "<" types ">" {$$ = [$1,$3]} | "Object" | "Dictionary" | IDENTIFIER;
parameter: type "&" IDENTIFIER {$$ = ["ref_parameter",$1,$3]} | type "..." IDENTIFIER {$$ = ["varargs",$1,$3]} | type IDENTIFIER "=" e {$$ = ["default_parameter",$1,$2,$4];} | type IDENTIFIER {$$ = [$1,$2];} | "const" type IDENTIFIER {$$=["final_parameter",$2,$3]};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$= []};
access_arr: parentheses_expr "," access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: expr "," exprs {$$ = [$1].concat($3);} | expr {$$ = [$1];};
expr: "&" e {$$ = ["function_call_ref",$2];} | e {$$ = [$1];};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};

type_params: type_param "," type_params {$$ = [$1].concat($3);} | type_param {$$ = [$1];};

type_param: "class" type {$$ = $2;} | "typename" type {$$ = $2;} | type {$$ = $1;};

elif:
	"else" "if" "(" e ")" bracket_statements elif {$$ = ["elif",$4,$6,$7]}
	| "else" bracket_statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};
add: e "+" add {$$ = [$1].concat($3);} | e {$$ = [$1];};
bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon ";" {$$ = ["semicolon",$1];};
