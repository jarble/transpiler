/* lexical grammar */
%lex
%%

\s+                                   /* IGNORE */
"//".*                                /* IGNORE */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* IGNORE */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\"    return 'STRING_LITERAL'
"class"               return "class"
"yield"               return "yield"
"await"               return "await"
"case"                return 'case'
"enum"                return 'enum'
"break"               return 'break'
"struct"              return 'struct'
"public"              return "public"
"operator"            return 'operator'
"default"             return "default"
"import"              return "import"
"implements"          return "implements"
"interface"           return "interface"
"Dictionary"          return "Dictionary"
"private"             return "private"
"static"              return "static"
"if"                  return "if"
"do"                  return "do"
"in"                  return "in"
"ref"                 return "ref"
"out"                 return "out"
"else"                return "else"
"return"              return "return"
"throw"               return "throw"
"while"               return "while"
"switch"              return "switch"
"async"               return "async"
"foreach"             return "foreach"
"for"                 return "for"
"new"                 return "new"
"!="                  return '!='
'!'                   return '!'
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"&="                  return '&='
"&&"                  return '&&'
"|="                  return '|='
"||"                  return '||'
">="                  return '>='
'>>'                  return '>>'
">"                   return '>'
"<="                  return '<='
"<<"                  return '<<'
"<"                   return '<'
"=="                  return '=='
"="                   return '='
"%="                  return '%='
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
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%right '?'
%left '->'
%left 'is' '&&' '||'
%left '==' '!=' '<' '<=' '>' '>='
%left '>>' '<<'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statements_with_vars | initialize_var_ ";" {$$ = [["semicolon",["initialize_var"].concat($1)]]} | initialize_var_ ";" statements_ {$$ = [["lexically_scoped_vars",[["lexically_scoped_var"].concat($1)],["statements",$3]]]};
statements_without_vars: statements_without_vars statement {$$ = $1.concat([$2]);} | statement {$$ =
 [$1];};
statements_with_vars: statements_without_vars initialize_var1 ";" {$$ = $1.concat([["semicolon",$2]]);} | statements_without_vars; 

initialize_vars: initialize_vars ";" initialize_var {$$ = $1.concat([$3]);} | initialize_var {$$ =
 [$1];};

class_statements: class_statements_ {$$ = ["class_statements",$1]} | {$$ = ["class_statements",[]]};
statements: statements_ {$$ = ["statements",$1]};


class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};

access_modifier: "public" | "private";

class_:
	access_modifier "namespace" IDENTIFIER "{" class_statements "}" {$$ = [$2,$1,$3,$5];}
	| access_modifier "class" IDENTIFIER "<" types ">" "{" class_statements "}" {$$ = ["generic_class",$1,$3,$8,$5];}
	| access_modifier "class" IDENTIFIER "{" class_statements "}" {$$ = [$2,$1,$3,$5];}
	| access_modifier "abstract" "class" IDENTIFIER "{" class_statements "}" {$$ = ["abstract_class",$1,$4,$6];}
	| access_modifier "interface" IDENTIFIER "{" class_statements "}" {$$ = [$2,$1,$3,$5];}
	| access_modifier "interface" IDENTIFIER "<" types ">" "{" class_statements "}" {$$ = ["generic_interface",$1,$3,$8,$5];}	
	| access_modifier "enum" IDENTIFIER "{" identifiers "}" {$$ = ["enum",$1,$3,$5];}
	| access_modifier "class" IDENTIFIER ":" identifiers "{" class_statements "}" {$$ = ["class_extends",$1,$3,$5,$7];}
	;

struct_statements: struct_statement struct_statements {$$ = [$1].concat($2);} | struct_statement {$$ =
 [$1];};
 
struct_statement: type identifiers ";" {$$ = ["struct_statement",$1,$2];} |  access_modifier type identifiers ";" {$$ = ["struct_statement",$2,$3];} | set_array_size ";" {$$ = ["semicolon", $1];};


top_level_statement:
	statement | initialize_var1 ";" {$$ = ["semicolon",$1]};
top_level_statements: top_level_statements top_level_statement {$$ = $1.concat([$2]);} | top_level_statement {$$ =
 [$1];};
statement
    :
    "import" IDENTIFIER  {$$ = ["import",$2];}
    | statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | class_
    | "struct" IDENTIFIER "{" struct_statements "}" {$$ = ["struct",$2,["struct_statements",$4]]}
	| "struct" IDENTIFIER "<" IDENTIFIER ">" "{" struct_statements "}" {$$ = ["generic_struct",$2,$4,$7];}
	| access_modifier "struct" IDENTIFIER "<" IDENTIFIER ">" "{" struct_statements "}" {$$ = ["generic_struct",$3,$5,$8];}
    | "while" "(" e ")" bracket_statements {$$ = ["while",$3,$5];}
    | "do" bracket_statements "while" "(" e ")" ";" {$$ = ["do_while",$2,$5];}
    | "switch" "(" e ")" "{" case_statements "}" {$$ = ["switch",$3,$6];}
    | "for" "(" statement_with_semicolon_ ";" e ";" statement_with_semicolon_ ")" bracket_statements {$$ = ["for",$3,$5,$7,$9];}
    | "foreach" "(" type IDENTIFIER "in" IDENTIFIER ")" bracket_statements {$$ = ["foreach",$3,$4,$6,$8];}
    | "if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
	| "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];}
    | "public" "static" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["function",$1,$3,$4,$6,$9];}
    | "public" "static" "async" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["async_function",$1,$4,$5,$7,$10];}
    ;

statement_with_semicolon_: initialize_var1 | statement_with_semicolon;

case_statement: "case" e ":" statements "break" ";" {$$ = ["case",$2,$4]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};

case_statements: case_statements_ "default" ":" statements {$$ = $1.concat([["default",$4]])} | case_statements_;


class_statement:
	class_
	| access_modifier IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["constructor",$1,$2,$4,$7];}
	| access_modifier type IDENTIFIER "=" e ";" {$$ = ["initialize_instance_var_with_value",$1,$2,$3,$5];}
	| access_modifier type IDENTIFIER ";" {$$ = ["initialize_instance_var",$1,$2,$3];}
	| access_modifier "static" type IDENTIFIER "=" e ";" {$$ = ["initialize_static_instance_var",$1,$3,$4,$6];}
	| access_modifier "static" type IDENTIFIER "(" parameters ")" ";" {$$ = ["interface_static_method",$1,$3,$4,$6];}
	| access_modifier type IDENTIFIER "(" parameters ")" ";" {$$ = ["interface_instance_method",$1,$2,$3,$5];}
	| access_modifier "static" type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method",$1,$3,$4,$6,$9];}
	| access_modifier "static" type IDENTIFIER "<" types ">" "(" parameters ")" "{" statements "}" {$$ = ["generic_static_method",$1,$3,$4,$9,$12,$6];}
	| access_modifier type IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["instance_method",$1,$2,$3,$5,$8];}
	| access_modifier type IDENTIFIER "<" types ">" "(" parameters ")" "{" statements "}" {$$ = ["generic_instance_method",$1,$2,$3,$8,$11,$5];}
	| access_modifier "static" type "operator" OPERATOR "(" parameters ")" "{" statements "}" {$$ = ["static_overload_operator","public",$3,$5,$7,$10];}
;

OPERATOR: "+="|"-="|"*="|"/="|"++"|"--"|"<="|">="|"<"|">"|"&&"|"||"|"=="|"+"|"-"|"*"|"/"|"|="|"&="|"!";


statement_with_semicolon
   : 
   "yield" "return" e  {$$ = ["yield",$3];}
   | "return" e  {$$ = ["return",$2];}
   | "return" {$$ = ["return"];}
   | "continue"  {$$ = ["continue"];}
   | "throw" e  {$$ = ["throw",$2];}
   | "final" type IDENTIFIER "=" e {$$ = ["initialize_constant",$2,$3,$5];}
   | "final" type identifiers {$$ = ["initialize_empty_constants",$2,$3];}
   | type identifiers {$$ = ["initialize_empty_vars",$1,$2];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "++" {$$ = [$2,$1];}
   | IDENTIFIER "--" {$$ = [$2,$1];}
   | "++" IDENTIFIER {$$ = [$1,$2];}
   | "--" IDENTIFIER {$$ = [$1,$2];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "|=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "%=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "." dot_expr {$$ = [".",[$1].concat($3)]}
   ;

initialize_var1: initialize_var_ {$$ = ["initialize_var"].concat($1);};
initialize_var: initialize_var_ {$$ = ["lexically_scoped_var"].concat($1);};
initialize_var_: type IDENTIFIER "=" "{" exprs "}" {$$ = [$1,$2,["initializer_list",$1,$5]]}
   | type IDENTIFIER "=" e {$$ = [$1,$2,$4];};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: "{" STRING_LITERAL "," e "}" {$$ = [$2,$4]};

e:
    e "?" e ":" e {$$ = ["ternary_operator",$1,$3,$5]}
    |e "is" e
        {$$ = [$2,$1,$3];}
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
    | e '<<' e
        {$$ = ["<<",$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e '>=' e
        {$$ = [$2,$1,$3];}
    | e '>>' e
        {$$ = [">>",$1,$3];}
    |e '>' e
        {$$ = [$2,$1,$3];}
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
    | not_expr
    ;

not_expr: "!" dot_expr {$$ = ["!", [".",$2]];} | "await" dot_expr {$$ = ["await", [".",$2]]} | dot_expr {$$ = [".", $1];};


dot_expr: initializer_list  "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr  "." dot_expr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: IDENTIFIER "[" exprs "]" {$$ = ["access_array",$1,$3];};

initializer_list:
"new" type "{" "}" {$$ = ["initializer_list",$2,[]];} | "new" type "{" exprs "}" {$$ = ["initializer_list",$2,$4];};

parentheses_expr:
    "(" e ")" {$$= ["parentheses",$2];}
    | "new" "Dictionary" "<" type "," type ">" "{" key_values "}" {$$ = ["associative_array",$4,$6,$9]}
    | access_array
    | parentheses_expr "(" ")" {$$ = ["function_call",$1,[]];}
    | parentheses_expr "(" named_parameters ")" {$$ = ["function_call",$1,$3];}
    | parentheses_expr "(" exprs ")" {$$ = ["function_call",$1,$3];}
    | "new" IDENTIFIER "(" ")" {$$= ["new",$2,[]];}
    | "new" IDENTIFIER "(" exprs ")" {$$= ["new",$2,$4];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};



type: IDENTIFIER square_brackets {var the_output = $1; for(var i = 0; i < $2.length; i++){the_output = [the_output,"[]"];} $$ = the_output;} | IDENTIFIER "<" types ">" {$$ = [$1,$3]} | "Object" | "Dictionary" | IDENTIFIER;

square_brackets: square_brackets "[" "]" {$$ = $1.concat(["[]"]);} | "[" "]" {$$ = ["[]"]};

parameter: "ref" type IDENTIFIER {$$ = ["ref_parameter",$2,$3]} | "in" type IDENTIFIER {$$ = ["in_parameter",$2,$3]} | "out" type IDENTIFIER {$$ = ["out_parameter",$2,$3]} | type "..." IDENTIFIER {$$ = ["varargs",$1,$3]} | type IDENTIFIER "=" e {$$ = ["default_parameter",$1,$2,$4];} | type IDENTIFIER {$$ = [$1,$2];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$= []};

exprs: expr "," exprs {$$ = [$1].concat($3);} | expr {$$ = [$1];};
expr: "ref" e {$$ = ["function_call_ref",$2];} | e {$$ = [$1];};

named_parameters: named_parameters "," named_parameter {$$ = $1.concat([$3]);} | named_parameter {$$ = [$1];};
named_parameter: IDENTIFIER ":" e {$$ = ["named_parameter",$1,$3]};
types: type "," types {$$ = [$1].concat($3);} | type {$$ = [$1];};
elif:
	"else" "if" "(" e ")" bracket_statements elif {$$ = ["elif",$4,$6,$7]}
	| "else" bracket_statements {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};
add: e "+" add {$$ = [$1].concat($3);} | e {$$ = [$1];};
bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon ";" {$$ = ["semicolon",$1];};
