/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$"                   return "$"
"function"            return "function"
"continue"            return "continue"
"interface"           return "interface"
"export"              return 'export'
"private"             return 'private'
"public"              return 'public'
"extends"             return 'extends'
"typeof"              return "typeof"
"class"               return "class"
"static"              return "static"
"const"               return 'const'
"if"                  return 'if'
"new"                 return 'new'
"else"                return 'else'
"type"                return 'type'
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
"Math"                return "Math"
"number"              return 'number'
"boolean"             return 'boolean'
"Number"              return 'Number'
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
">"                   return '>'
"<="                  return '<='
"<"                   return '<'
"=>"                  return '=>'
"==="                 return '==='
"!=="                 return '!=='
"!"                   return "!"
"="                   return '='
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
"{"                   return '{'
"}"                   return '}'
"["                   return '['
"]"                   return ']'
"?"                   return '?'
"("                   return '('
")"                   return ')'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%right '?'

%left '...'
%left '||' '|'
%left '&&' '&'
%left '<' '<=' '>' '>=' '===' '!=='
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: top_level_statements EOF {return $1};

statements_: statements_without_vars;
statements_without_vars: statement statements_without_vars {$$ = $1+$2;} | statement {$$ =
 $1;};
 
statements: statements_ {$$ = $1};

case_statement: "case" e ":" statements "break" ";" {$$ = ["case",$2,":",$4,"break;"].join(" ")};
case_statements_: case_statement case_statements_ {$$ = $1+$2;} | case_statement {$$ =
 $1;};
case_statements: case_statements_ "default" ":" statements {$$ = $1+["default:",$4].join("");} | case_statements_;


access_modifier: "public" | "private";

top_level_statement:
	statement
	| "const" IDENTIFIER "=" e ";" {$$ = "#define "+$2+" "+$4;}
	| "var" IDENTIFIER "=" e ";" {$$ = "#define "+$2+" "+$4;}
	| initialize_var1 ";" {$$ = $1+";"}
	| "function" IDENTIFIER "(" identifiers ")" "{" "return" e ";" "}" {$$ = "#define "+$2+"("+$4+") "+$8;}
    | "function" IDENTIFIER "(" parameters ")" ":" type_ bracket_statements {$$ = [$7,$2,"(",$4,")",$8].join(" ");}
    | "class" IDENTIFIER "{" class_statements "}" {$$ = "struct "+$2+"{"+$4+"};";}
    ;
top_level_statements: top_level_statements top_level_statement {$$ = $1+"\\n"+$2;} | top_level_statement {$$ =
 $1;};
statement
    :
    statement_with_semicolon ";" {$$ = [$1,";"].join("");}
    | "switch" "(" e ")" "{" case_statements "}" {$$ = ["switch(",$3,"){",$6,"}"].join("");}
    | "while" "(" e ")" bracket_statements {$$ = ["while(",$3,")",$5].join("");}
    // | "for" "(" "var" IDENTIFIER "of" e ")" bracket_statements {$$ = ["for(int i = 0; i < "+$4+".length(),i++){"+$8+"}"]}
    | "for" "(" statement_with_semicolon_ ";" e ";" statement_with_semicolon_ ")" bracket_statements {$$ = ["for(",$3,";",$5,";",$7,")",$9].join("");}
    | if_statement
    ;

statement_with_semicolon_: initialize_var1 | statement_with_semicolon;

statement_with_semicolon
   : 
   "return" e  {$$ = ["return",$2].join(" ");}
   | "const" IDENTIFIER ":" type_ "=" e {$$ = ["const",$4,$2,"=",$6].join(" ");}
   | access_array "=" e {$$ = [$1,"=",$3].join(" ");}
   | "var" IDENTIFIER ":" type_ "=" e {$$ = $4 + " "+$2+" = "+$6}
   | "const" IDENTIFIER ":" type_ "[" "]" "=" "[" exprs "]" {$$ = "const " + $4 + "[] "+$2+" = "+$4+"[]("+$9+")"}
   | IDENTIFIER "=" e {$$ = [$1,"=",$3].join(" ");}
   | IDENTIFIER "." IDENTIFIER "=" e {$$ = ["set_var",[".",[$1,$3]],$5];}
   | IDENTIFIER "++" {$$ = [$1,$2].join(" ");}
   | IDENTIFIER "--" {$$ = [$1,$2].join(" ");}
   | IDENTIFIER "+=" e {$$ = [$1,$2,$3].join(" ");}
   | IDENTIFIER "-=" e {$$ = [$1,$2,$3].join(" ");}
   | IDENTIFIER "*=" e {$$ = [$1,$2,$3].join(" ");}
   | IDENTIFIER "/=" e {$$ = [$1,$2,$3].join(" ");}
   | IDENTIFIER "." dot_expr {$$ = $1+"."+$3;}
   ;

e
    :
     e "?" e ":" e {$$ = [$1,"?",$3,":",$5].join(" ")}
    |e '||' e
        {$$ = [$1,$2,$3].join(" ");}
    |e '|' e
        {$$ = [$1,$2,$3].join(" ");}
    |e '&&' e
        {$$ = [$1,$2,$3].join(" ");}
    |e '&' e
        {$$ = [$1,$2,$3].join(" ");}
    |e '!==' e
        {$$ = [$1,'!=',$3].join(" ");}
    |e '===' e
        {$$ = [$1,'==',$3].join(" ");}
    |e '<=' e
        {$$ = [$1,$2,$3].join(" ");}
    |e '<' e
        {$$ = [$1,$2,$3].join(" ");}
    | e '>=' e
        {$$ = [$1,$2,$3].join(" ");}
    |e '>' e
        {$$ = [$1,$2,$3].join(" ");}
    | e '+' e
        {$$ = [$1,$2,$3].join(" ");}
    | e '-' e
        {$$ = [$1,$2,$3].join(" ");}
    | e '*' e
        {$$ = [$1,$2,$3].join(" ");}
    | e '/' e
        {$$ = [$1,$2,$3].join(" ");}
    | e '%' e
        {$$ = [$1,$2,$3].join(" ");}
    | '-' e %prec UMINUS
        {$$ = "-"+$2;}
    | not_expr
    ;

not_expr: "!" dot_expr {$$ = "!"+$2;} | dot_expr {$$ = $1;};


dot_expr: parentheses_expr  "." dot_expr  {$$ = $1+"."+$3;} | parentheses_expr {$$ =
 $1;};

access_array: parentheses_expr "[" e "]" {$$ = $1+"["+$3+"]";};


parentheses_expr:
    IDENTIFIER "(" ")" {$$= $1+"()";}
    | "new" IDENTIFIER "(" exprs ")" {$$= [$2,"(",$4,")"].join("");}
    | IDENTIFIER "(" exprs ")" {$$= [$1,"(",$3,")"].join("");}
    | "Number" "(" exprs ")" {$$= ["float(",$3,")"].join("");}
    | "Math" "." IDENTIFIER "(" e ")" {$$ = $3+"("+$5+")";}
    | "Math" "." IDENTIFIER {
		if($3 == "E"){
			$$ = Math.E;
		}
		else if($3 == "LOG10E"){
			$$ = Math.LOG10E;
		}
		else if($3 == "SQRT1_2"){
			$$ = Math.SQRT1_2;
		}
		else if($3 == "SQRT2"){
			$$ = Math.SQRT2;
		}
		else if($3 == "PI"){
			$$ = Math.PI;
		}
	}
	| access_array
    | '(' e ')' {$$ = "("+$+")";}
    | parentheses_expr_;

parentheses_expr_:
    "[" "]" {$$ = "()";}
    | "[" exprs "]" {$$ = "("+$2+")";}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;};

parameter:
	IDENTIFIER ":" type_ {$$ = [$3, $1].join(" ");}
	| "(" IDENTIFIER ":" type_ ")" "=>" IDENTIFIER {$$ = ["function_parameter",$4,$3,$7];};
parameters: parameter "," parameters {$$ = $1+","+$3;} | parameter {$$ =
 $1;} | {$$ = ""};
exprs: e "," exprs {$$ = $1+","+$3;} | e {$$ = [$1];};

elif: "else" "if" "(" e ")" bracket_statements elif {$$ = ["else if(",$4,")",$6,$7].join(" ");} | "else" bracket_statements {$$ = ["else{",$2,"}"].join("");};
if_statement:
"if" "(" e ")" bracket_statements elif {$$ = ["if","(",$3,")",$5,$6].join(" ");}
|  "if" "(" e ")" bracket_statements {$$ = ["if","(",$3,")",$5].join(" ");};
identifiers: IDENTIFIER "," identifiers {$$ = $1+","+$3;} | IDENTIFIER {$$ = $1;};
bracket_statements: "{" statements "}" {$$= "{"+$2+"}";} | statement_with_semicolon ";" {$$ = $1+";";};

type_:"boolean" {$$= "bool";}|"number"{$$= "float";};

types: type_ "," types {$$ = [$1].concat($3);} | type_ {$$ = [$1];}; 

class_statement:
	IDENTIFIER ":" type_ ";" {$$ = $3+" "+$1+";";}
	;

class_statements: class_statement class_statements {$$ = $1+$2;} | class_statement {$$ =
 $1;};
