/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
":"                   return ':'
";"                   return ';'
","                   return ','
"."                   return '.'
"!="                  return '!='
">="                  return '>='
">"                   return '>'
"<="                  return '<='
"=="                  return '=='
"="                   return '='
"||"                  return '||'
"&&"                  return '&&'
"<"                   return '<'
"+"                   return '+'
"-"                   return '-'
"*"                   return '*'
"/"                   return '/'
"function"            return 'function'
"between"             return 'between'
"implies"             return 'implies'
"plus"                return 'plus'
"minus"               return 'minus'
"than"                return 'than'
"then"                return 'then'
"means"               return 'means'
"return"              return 'return'
"every"               return 'every'
"contains"            return 'contains'
"equals"              return 'equals'
"each"                return 'each'
"and"                 return 'and'
"the"                 return 'the'
"not"                 return 'not'
"no"                  return 'no'
"or"                  return 'or'
"of"                  return 'of'
"is"                  return 'is'
"if"                  return 'if'
"to"                  return 'to'
"a"                   return 'a'
"under"               return 'under'
"on"                  return 'on'
"in"                  return 'in'
"how"                 return 'how'
"are"                 return 'are'
"not"                 return 'not'
"an"                  return 'an'
"below"               return 'below'
"above"               return 'above'
"does"                return 'does'
"did"                return 'did'
"("                   return '('
")"                   return ')'
"["                   return '['
"]"                   return ']'
"{"                   return '{'
"}"                   return '}'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex
/* operator associations and precedence */


%start expressions

%% /* language grammar */

expressions
    : statements_ EOF
        {return ["top_level_statements", $1];}
    ;

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};
 
statements: statements_ {$$ = ["statements",$1]};

statements_conjunction: statements_conjunction "and" if_then_expr {$$=["&&",$1,$3];} | if_then_expr;

statement:
    if_then_expr "." {$$ = $1;};

if_then_expr:
	statement_with_semicolon {$$ = ["semicolon",$1];}
	| or_expr {$$ = $1;}
	| "function" grammar_var "{" parameters "}" "{" statements "}" {$$ = ["function","public","Object",$2,$4,$7]} 
	| or_expr "if" or_expr {$$ = [$1,$2,$3];}
	| "if" or_expr "then" or_expr {$$ = [$1,$2,$3,$4]}
	| or_expr "implies" or_expr {$$ = [$1,$2,$3];}
	| or_expr "means" or_expr {$$ = [$1,$2,$3]};

or_expr: and_expr "or" or_expr {$$ = [$1,$2,$3];} | and_expr "||" or_expr {$$ = [$2,$1,$3];} | and_expr;
and_expr: bool_expr "and" bool_expr {$$ = [$1,$2,$3];} | bool_expr "but" bool_expr {$$ = [$1,$2,$3];} | bool_expr "&&" bool_expr {$$ = [$2,$1,$3];} | bool_expr;


statement_with_semicolon:
	"return" or_expr {$$ = [$1,$2];}
	| grammar_var "=" or_expr {$$ = ["set_var",$1,$3];};

parameter: grammar_var {$$ = ["Object", $1];} | grammar_var grammar_var {$$ = [$1,$2];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};

linking_verb: "is"|"are"|"does"|"did";

bool_expr:
the_mul_expr "is" "no" IDENTIFIER "than" the_mul_expr {$$= [$1,$2,$3,$4,$5];}
| the_mul_expr linking_verb "not" IDENTIFIER the_mul_expr {$$= [$1,$2,$3,$4,$5];}
| the_mul_expr linking_verb "not" verb_phrase {$$= [$1,$2,$3,$4];}
| the_mul_expr linking_verb verb_phrase {$$= [$1,$2,$3];}
| mul_expr ">" mul_expr {$$= [$2,$1,$3];} 
| mul_expr "<" mul_expr {$$=[$2,$1,$3];} 
| mul_expr "<=" mul_expr {$$=[$2,$1,$3];} 
| mul_expr ">=" mul_expr {$$=[$2,$1,$3];}
| mul_expr "==" mul_expr {$$=[$2,$1,$3];} 
| mul_expr "equals" mul_expr {$$=[$2,$1,$3];}
| mul_expr "contains" mul_expr {$$=[$2,$1,$3];}
| mul_expr "!=" mul_expr {$$=[$2,$1,$3];} | the_mul_expr;

preposition: "between" | "under" | "over" | "below" | "above" | "beneath" | "on" | "in" | "onto" | "to";

verb_phrase: preposition the_mul_expr {$$ = [$1,$2];} | grammar_var preposition the_mul_expr {$$ = [$1,$2,$3];} | the_mul_expr {$$ = $1} | grammar_var "than" the_mul_expr {$$ = [$1,$2,$3];};

not_verb_phrase: verb_phrase;

comparison_operator: (">" | "<" | ">=" | ">=") {$$ = $1};

the_mul_expr: "each" mul_expr {$$ = [$1,$2];}  | "every" mul_expr {$$ = [$1,$2];}  | "a" mul_expr {$$ = [$1,$2];} | "an" mul_expr {$$ = ["a",$2];} | "the" mul_expr {$$ = $2;} | mul_expr;
the_parentheses_expr: "a" parentheses_expr {$$ = ["a", $2];}  | "the" parentheses_expr {$$ = $2;} | parentheses_expr;

mul_expr: parentheses_expr "*" the_mul_expr {$$= [$2,$1,$3]} | parentheses_expr "/" the_mul_expr {$$= [$2,$1,$3]} | add_expr;
add_expr: parentheses_expr "minus" add_expr {$$= [$1,$2,$3]} | parentheses_expr "plus" add_expr {$$= [$1,$2,$3]} | parentheses_expr "+" add_expr {$$= [$2,$1,$3]} | parentheses_expr "-" add_expr {$$= [$2,$1,$3]} | parentheses_expr "of" add_expr {$$=[$1,$2,$3]} | parentheses_expr;

parentheses_expr: array | function_call | "(" if_then_expr ")" {$$ = ["parentheses",$2];} | grammar_var | NUMBER | STRING_LITERAL
        {$$ = yytext;};

grammar_var: (IDENTIFIER | "a") {$$=$1;};

array: "[" or_exprs "]" {$$ = ["initializer_list","Object",$2];};
or_exprs: or_exprs "," or_expr {$$ = $1.concat([$3]);} | or_expr {$$ = [$1];};


function_call: grammar_var "{" or_exprs "}" {$$ = ["function_call",$1,$3]};
