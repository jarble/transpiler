/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"otherwise"           return "otherwise"
"if"                  return "if"
"else"                return "else"
"then"                return "then"
"data"                return "data"
"return"              return "return"
"mod"                 return 'mod'
","                   return ','
";"                   return ';'
"."                   return '.'
"::"                  return '::'
":"                   return ':'
"&&"                  return '&&'
"||"                  return '||'
"|"                   return '|'
"\\"                  return '\\'
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"<-"                  return '<-'
"->"                  return '->'
"<"                   return '<'
"=="                  return '=='
"="                   return '='
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
"!!"                  return '!!'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '||'
%left '&&'
%left '<' '<=' '>' '>=' '=='
%left '+' '-' '++'
%left '*' '/' 'mod'
%left '**'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement_ statements_ {$$ = [$1].concat($2);} | statement_ {$$ =
 [$1];};
 
data_type_or: data_type_or "|" IDENTIFIER {$$ = ["data_type_or",$1,$3];} | IDENTIFIER;

statement_:
	"data" IDENTIFIER "=" data_type_or {$$ = ["algebraic_data_type",$2,$4];}
	| IDENTIFIER parameters guard_if_statement {$$ = ["function","public","Object",$1,$2,$3];}
	| IDENTIFIER "::" types IDENTIFIER parameters "=" statement {
		var types = $3;
		var parameter_names = $5;
		var parameters = [];
		for(var i = 0; i < parameter_names.length; i++){
			parameters.push([types[i],parameter_names[i][1]]);
		}
		$$ = ["function","public",types[types.length-1],$1,parameters,$7];
	}
	| IDENTIFIER parameters "=" statement {$$ = ["function","public","Object",$1,$2,$4];}
        | IDENTIFIER "=" statement {$$ = ["function","public","Object",$1,[],$3];}
        | IDENTIFIER guard_if_statement {$$ = ["function","public","Object",$1,[],$2];};

types: IDENTIFIER "->" types {$$ = [$1].concat($3);} | IDENTIFIER {$$ =
 [$1];};

statement:
    "(" "if" e "then" statement elif ")" {$$ = ["if",$3,$5,$6];}
	| "(" "if" e "then" statement ")" {$$ = ["if",$3,$5];}
    |statement_with_semicolon {$$ = ["semicolon",$1];};

statement_with_semicolon
   :
   e  {$$ = ["return",$1];}
   ;
e
    :
    e '||' e
        {$$ = [$2,$1,$3];}
    |e '&&' e
        {$$ = [$2,$1,$3];}
    |e '==' e
        {$$ = [$2,$1,$3];}
    |e '<=' e
        {$$ = [$2,$1,$3];}
    |e '<' e
        {$$ = [$2,$1,$3];}
    | e '>=' e
        {$$ = [$2,$1,$3];}
    |e '>' e
        {$$ = [$2,$1,$3];}
    | e '++' e
        {$$ = [$2,$1,$3];}
    | e '+' e
        {$$ = [$2,$1,$3];}
    | e '-' e
        {$$ = [$2,$1,$3];}
    | e '*' e
        {$$ = [$2,$1,$3];}
    | e '/' e
        {$$ = [$2,$1,$3];}
    | e 'mod' e
        {$$ = ["%",$1,$3];}
	| e '**' e
        {$$ = [$2,$1,$3];}
    | '-' e %prec UMINUS
        {$$ = ["-",$2];}
    | parentheses_expr {$$ = $1;}
    ;


access_array: IDENTIFIER "!!" access_arr {$$ = ["access_array",$1,[$3]];};

parentheses_expr:
    "(" "\\" parameters "->" e ")" {$$ = ["anonymous_function","Object",$3,["statements",[["semicolon",["return",$5]]]]];}
    |"(" access_array ")" {$$ = $2}
    |"[" exprs "]" {$$ = ["initializer_list","Object",$2];}
    |"[" e "|" e "<-" e "]" {$$ = ["list_comprehension",$2,$4,$6];}
    |"[" e "|" e "<-" e "," e "]" {$$ = ["list_comprehension",$2,$4,$6,$8];}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
    | "(" e ")" {$$ = $2}
    | "(" IDENTIFIER args ")"
        {
			if($2 === "not"){
				$$ = ["!",$3];
			}
			else{
				$$ = ["function_call",$2,$3];
			}
		}
    | STRING_LITERAL
        {$$ = yytext;}
    ;

type: IDENTIFIER;
parameter: IDENTIFIER {$$ = ["Object",$1];};
parameters: parameter  parameters {$$ = [$1].concat($2);} | parameter {$$ =
 [$1];};
access_arr: parentheses_expr "!!" access_arr {$$ = [$1].concat($3);} | parentheses_expr {$$ =
 [$1];};
exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};
args: parentheses_expr args {$$ = [$1].concat($2);} | parentheses_expr {$$ = [$1];};
elif: "else" "if" e "then" statement elif {$$ = ["elif",$3,$5,$6]} | "else" statement {$$ = ["else",$2];};
identifiers: IDENTIFIER "," identifiers {$$ = [$1].concat($3);} | IDENTIFIER {$$ = [$1];};

guard_if_statement:
	"|" e "=" statement guard_elif {$$ = ["if",$2,$4,$5];};
guard_elif:
	"|" e "=" statement guard_elif {$$ = ["elif",$2,$4,$5];}
	| "|" "otherwise" "=" statement {$$ = ["else",$4];};
