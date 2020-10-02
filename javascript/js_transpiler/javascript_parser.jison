/* lexical grammar */
%lex
%%

\s+                                   /* IGNORE */
"//".*                                /* IGNORE */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* IGNORE */

[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\"    return 'STRING_LITERAL'
"$"                   return "$"
"import"              return "import"
"from"                return "from"
"function"            return "function"
"extends"             return "extends"
"continue"            return "continue"
"typeof"              return "typeof"
"class"               return "class"
"const"               return 'const'
"static"              return 'static'
"get"                 return 'get'
"set"                 return 'set'
"if"                  return 'if'
"do"                  return 'do'
"new"                 return 'new'
"else"                return 'else'
"case"                return "case"
"default"             return 'default'
"return"              return 'return'
"yield"               return 'yield'
"while"               return 'while'
"switch"              return 'switch'
"break"               return 'break'
"for"                 return 'for'
"var"                 return 'var'
"of"                  return 'of'
","                   return ','
";"                   return ';'
"..."                 return '...'
"."                   return '.'
":"                   return ':'
"&&"                  return '&&'
"&"                   return '&'
"||"                  return '||'
"|"                   return '|'
">="                  return '>='
">>"                  return '>>'
">"                   return '>'
"<="                  return '<='
"<<"                  return '<<'
"<"                   return '<'
"=>"                  return '=>'
"==="                 return '==='
"!=="                 return '!=='
"!"                   return "!"
"="                   return '='
"%="                  return '%='
"%"                   return '%'
"*="                  return '*='
"**"                  return '**'
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
"["                   return '['
"]"                   return ']'
"?"                   return '?'
"("                   return '('
")"                   return ')'
"instanceof"          return 'instanceof'
"in"                  return 'in'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%right '?' "**"

%left '...'
%left '||' '|'
%left '&&' '&'
%left '<' '<=' '>' '>=' '===' '!==' 'in' 'instanceof'
%left '<<' '>>'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: top_level_statements EOF {return ["top_level_statements",$1]};
top_level_statements: top_level_statements top_level_statement {$$ = $1.concat([$2]);} | top_level_statement {$$ =
 [$1];};
top_level_statement:
	statement | initialize_var1 ";" {$$ = ["semicolon",$1]};

statements_: statements_with_vars | initialize_var_ ";" {$$ = [["semicolon",["initialize_var"].concat($1)]]} | initialize_var_ ";" statements_ {$$ = [["lexically_scoped_vars",[["lexically_scoped_var"].concat($1)],["statements",$3]]]};
statements_without_vars: statements_without_vars statement {$$ = $1.concat([$2]);} | statement {$$ =
 [$1];};
statements_with_vars: statements_without_vars initialize_var1 ";" {$$ = $1.concat([["semicolon",$2]]);} | statements_without_vars;
 
initialize_vars: initialize_vars ";" initialize_var {$$ = $1.concat([$3]);} | initialize_var {$$ =
 [$1];};
 
statements: statements_ {$$ = ["statements",$1]};

case_statement: "case" e ":" statements "break" ";" {$$ = ["case",$2,$4]};
case_statements_: case_statement case_statements_ {$$ = [$1].concat($2);} | case_statement {$$ =
 [$1];};
case_statements: case_statements_ "default" ":" statements {$$ = $1.concat([["default",$4]])} | case_statements_;


access_modifier: "public" | "private";

class_:
	 "class" IDENTIFIER "extends" IDENTIFIER "{" class_statements "}" {$$ = ["class_extends","public",$2,$4,$6];}
	 | "class" IDENTIFIER "{" class_statements "}" {$$ = [$1,"public",$2,$4];};

statement
    :
    statement_with_semicolon ";" {$$ = ["semicolon",$1];}
    | class_
    | "switch" "(" e ")" "{" case_statements "}" {$$ = ["switch",$3,$6];}
    | "while" "(" e ")" bracket_statements {$$ = ["while",$3,$5];}
    | "do" bracket_statements "while" "(" e ")" ";" {$$ = ["do_while",$2,$5];}
    | "for" "(" IDENTIFIER "of" dot_expr ")" bracket_statements {$$ = ["foreach","Object",$3,$5,$7];}
    | "for" "(" "var" IDENTIFIER "in" dot_expr ")" bracket_statements {$$ = ["foreach","Object",$4,$6,$8];}
    | "for" "(" statement_with_semicolon_ ";" e ";" statement_with_semicolon ")" bracket_statements {$$ = ["for",$3,$5,$7,$9];}
    | "if" "(" e ")" bracket_statements elif {$$ = ["if",$3,$5,$6];}
	| "if" "(" e ")" bracket_statements {$$ = ["if",$3,$5];}
    | "function" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["function","public","Object",$2,$4,$7];}
    | "function" "*" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["generator_function","public","Object",$3,$5,$8];}
    ;

statement_with_semicolon_: initialize_var1 | statement_with_semicolon;


class_statements: class_statements_ {$$ = ["class_statements",$1]} | {$$ = ["class_statements",[]]};
class_statements_: class_statement class_statements_ {$$ = [$1].concat($2);} | class_statement {$$ =
 [$1];};
class_statement:
	IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["instance_method","public","Object",$1,$3,$6];}
	| "set" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["setter_method","public","Object",$2,$4,$7];}
	| "get" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["getter_method","public","Object",$2,$4,$7];}
	| "static" IDENTIFIER "(" parameters ")" "{" statements "}" {$$ = ["static_method","public","Object",$2,$4,$7];}
	;

statement_with_semicolon
   : 
   "import" IDENTIFIER "from" STRING_LITERAL {$$ = ["import_from",$2,$4];}
   | "continue" {$$ = [$1];}
   | "return" e  {$$ = ["return",$2];}
   | "return"  {$$ = ["return"];}
   | "yield" e  {$$ = ["yield",$2];}
   | "const" IDENTIFIER "=" e {$$ = ["initialize_constant","Object",$2,$4];}
   | "var" identifiers {$$ = ["initialize_empty_vars","Object",$2];}
   | access_array "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "=" e {$$ = ["set_var",$1,$3];}
   | IDENTIFIER "++" {$$ = [$2,$1];}
   | IDENTIFIER "--" {$$ = [$2,$1];}
   | IDENTIFIER "%=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "+=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "-=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "*=" e {$$ = [$2,$1,$3];}
   | IDENTIFIER "/=" e {$$ = [$2,$1,$3];}
   | dot_expr {$$ = [".",$1]}
   ;

initialize_var1: initialize_var_ {$$ = ["initialize_var"].concat($1);};
initialize_var: initialize_var_ {$$ = ["lexically_scoped_var"].concat($1);};   
initialize_var_: "var" IDENTIFIER "=" e {$$ = ["Object",$2,$4];};

e
    :
     e "?" e ":" e {$$ = ["ternary_operator",$1,$3,$5]}
    | "..." e {$$=["unpack_array",$2]}
    |e '||' e
        {$$ = [$2,$1,$3];}
    |e '|' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e '&' e
        {$$ = [$2,$1,$3];}
    |e '!==' e
        {$$ = ['!=',$1,$3];}
    |e '===' e
        {$$ = ['==',$1,$3];}
    |e 'in' e
        {$$ = ['in',$1,$3];}
    |e 'instanceof' e
        {$$ = ['in',$1,$3];}
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
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | not_expr
    ;

not_expr: "!" dot_expr {$$ = ["!", [".",$2]];} | "typeof" dot_expr {$$ = [$1, [".",$2]];} | "await" dot_expr {$$ = ["await", [".",$2]]} | dot_expr {$$ = [".", $1];};

dot_expr: parentheses_expr  "." dot_expr  {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};

access_array: parentheses_expr "[" e "]" {$$ = ["access_array",$1,[$3]];};


parentheses_expr:
    "class" "{" class_statements "}" {$$= ["anonymous_class",$3]}
    | "function" "(" parameters ")" "{" statements "}" {$$ = ["anonymous_function","Object",$3,$6]}
    | IDENTIFIER "(" ")" {$$= ["function_call",$1,[]];}
    | IDENTIFIER "(" exprs ")" {$$= ["function_call",$1,$3];}
    | "new" IDENTIFIER "(" ")" {$$= ["new",$2,[]];}
    | "new" IDENTIFIER "(" exprs ")" {$$= ["new",$2,$4];}
    | access_array
    | '(' e ')' {$$ = ["parentheses",$2];}
    | parentheses_expr_;

parentheses_expr_:
    "{" "}" {$$ = ["associative_array","Object","Object",[]];}
    | "{" key_values "}" {$$ = ["associative_array","Object","Object",$2];}
    | "[" "]" {$$ = ["initializer_list","Object",[]];}
    | "[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

parameter: IDENTIFIER "=" e {$$ = ["default_parameter","Object",$1,$3];} | IDENTIFIER {$$ = ["Object", $1];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};

key_values: key_values "," key_value {$$ = $1.concat([$3]);} | key_value {$$ = [$1];};
key_value: STRING_LITERAL ":" e {$$ = [$1,$3]} | IDENTIFIER ":" e {$$ = ["\""+$1+"\"",$3]};

elif: "else" "if" "(" e ")" bracket_statements elif {$$ = ["elif",$4,$6,$7]} | "else" bracket_statements {$$ = ["else",$2];};

identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};
bracket_statements: "{" statements "}" {$$= $2;} | statement_with_semicolon ";" {$$ = ["semicolon",$1];};

