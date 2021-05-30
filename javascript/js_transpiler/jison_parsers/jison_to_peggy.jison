/* lexical grammar */
%lex
%%

\s+                                   /* IGNORE */
"//".*                                /* IGNORE */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* IGNORE */

[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\"    return 'STRING_LITERAL'
"$"[0-9]+("."[0-9]+)?\b  return 'GRAMMAR_INDEX'
"%lex"                return "%lex"
"%%"                  return "%%"
"$$"                  return "$$"
"import"              return "import"
"from"                return "from"
"function"            return "function"
"extends"             return "extends"
"continue"            return "continue"
"typeof"              return "typeof"
"class"               return "class"
"constructor"         return "constructor"
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
"?"                   return '?'
"("                   return '('
")"                   return ')'
"["                   return '['
"]"                   return ']'
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

%start grammar_expressions

%% /* language grammar */

grammar_expressions
    : grammar_statements EOF
        {return $1;}
    ;

grammar_statements_: grammar_statement grammar_statements_ {$$ = $1+" "+$2;} | grammar_statement {$$ =
 $1;};

grammar_statements: grammar_statements_ {$$ = $1;};

grammar_statement:
    IDENTIFIER ":" grammar_or ";" {$$ = $1+"="+$3;};

grammar_or:
    grammar_and_ "|" grammar_or {$$= $1+"/"+$3;} | grammar_and_;

grammar_and_: grammar_and | grammar_and grammar_output_array {$$ = $1+" "+$2;};

grammar_output_array: "{" "$$" "=" e ";" "}" {$$ = "{return "+$4+";}";}
| "{" "return" e ";" "}" {$$ = "{return "+$3+";}";};

grammar_and:
    grammar_e grammar_and {$$= $1+" "+$2;} | grammar_e;

grammar_e: "(" grammar_or ")" {$$= "("+$2+")";} | grammar_var | STRING_LITERAL
        {$$ = yytext;};

grammar_var: IDENTIFIER {$$= $1;};


access_modifier: "public" | "private";

e
    :
     e "?" e ":" e {$$ = [$1,"?",$3,":",$5].join("")}
    | "..." e {$$="..."+$2}
    |e '||' e
        {$$ = [$1,$2,$3].join("");}
    |e '|' e
        {$$ = [$1,$2,$3].join("");}
    |e '&&' e
        {$$ = [$1,$2,$3].join("");}
    |e '&' e
        {$$ = [$1,$2,$3].join("");}
    |e '!==' e
        {$$ = [$1,"!==",$3].join("");}
    |e '===' e
        {$$ = [$1,"===",$3].join("");}
    |e 'in' e
        {$$ = [$1,$2,$3].join("");}
    |e 'instanceof' e
        {$$ = [$1," ",$2," ",$3].join("");}
    |e '<=' e
        {$$ = [$1,$2,$3].join("");}
    |e '<<' e
        {$$ = [$1,$2,$3].join("");}
    |e '<' e
        {$$ = [$1,$2,$3].join("");}
    | e '>=' e
        {$$ = [$1,$2,$3].join("");}
    |e '>>' e
        {$$ = [$1,$2,$3].join("");}
    |e '>' e
        {$$ = [$1,$2,$3].join("");}
    | e '+' e
        {$$ = [$1,$2,$3].join("");}
    | e '-' e
        {$$ = [$1,$2,$3].join("");}
    | e '*' e
        {$$ = [$1,$2,$3].join("");}
    | e '/' e
        {$$ = [$1,$2,$3].join("");}
    | e '%' e
        {$$ = [$1,$2,$3].join("");}
    | '-' e %prec UMINUS
        {$$ = ["-",$2].join("");}
    | not_expr
    ;

not_expr: "!" dot_expr {$$ = "!"+$2;} | "typeof" dot_expr {$$ = "typeof "+$2;} | "await" dot_expr {$$ = "await "+$2} | dot_expr {$$ = $1;};

dot_expr: parentheses_expr  "." dot_expr  {$$ = $1+"."+$3;} | parentheses_expr {$$ =
 $1;};

access_array: parentheses_expr "[" e "]" {$$ = $1+"["+$3+"]";};


parentheses_expr:
    IDENTIFIER "(" ")" {$$= $1+"()";}
    | IDENTIFIER "(" exprs ")" {$$= $1+"("+$3+")";}
    | "new" IDENTIFIER "(" ")" {$$= "new "+$2+"()";}
    | "new" IDENTIFIER "(" exprs ")" {$$= "new "+$2+"("+$4+")";}
    | access_array
    
    | parentheses_expr_;

parentheses_expr_:
    "(" e ")" {$$ = "("+$2+")";}
    | "{" "}" {$$ = "{}";}
    | "{" key_values "}" {$$ = "{"+$2+"}";}
    | "[" exprs "]" {$$ = "["+$2+"]";}
    | "[" "]" {$$ = "[]"}
    | NUMBER
        {$$ = yytext;}
    | IDENTIFIER
        {$$ = yytext;}
    | STRING_LITERAL
        {$$ = yytext;}
    | GRAMMAR_INDEX
        {$$ = "A"+$1.substring(1);};

exprs: e "," exprs {$$ = [$1].concat($3);} | e {$$ = [$1];};


key_values: key_values "," key_value {$$ = $1+","+$3;} | key_value {$$ = $1;};
key_value: STRING_LITERAL ":" e {$$ = $1+":"+$3;} | IDENTIFIER ":" e {$$ = "\""+$1+"\""+":"+$3;};

identifiers: IDENTIFIER "," identifiers {$$ = $1+","+$3;} | IDENTIFIER {$$ = $1;};
