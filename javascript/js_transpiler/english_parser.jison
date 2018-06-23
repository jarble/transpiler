/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
":"                   return ':'
"'s"                  return '\'s'
";"                   return ';'
","                   return ','
"."                   return '.'
"!="                  return '!='
">="                  return '>='
">"                   return '>'
"?"                   return '?'
"<="                  return '<='
"=="                  return '=='
"="                   return '='
"||"                  return '||'
"&&"                  return '&&'
"<"                   return '<'
"+="                  return '+='
"-="                  return '-='
"*="                  return '*='
"/="                  return '/='
"+"                   return '+'
"-"                   return '-'
"*"                   return '*'
"^"                   return '^'
"/"                   return '/'
"%"                   return '%'

"as"                  return 'as'
"large"               return 'large'
"largest"             return 'largest'
"small"               return 'small'
"smallest"            return 'smallest'
"big"                 return 'big'
"old"                 return 'old'
"using"               return 'using'
"prime"               return 'prime'
"square"              return 'square'
"composite"           return 'composite'
"male"                return 'male'
"female"              return 'female'
"carnivorous"         return 'carnivorous'
"herbivorous"         return 'herbivorous'
"same"                return 'same'
"different"           return 'different'
"function"            return 'function'
"between"             return 'between'
"into"                return 'into'
"toward"              return 'toward'
"during"              return 'during'
"after"               return 'after'
"from"                return 'from'
"onto"                return 'onto'
"who"                 return 'who'
"which"               return 'which'
"was"                 return 'was'
"up"                  return 'up'
"that"                return 'that'
"down"                return 'down'
"implies"             return 'implies'
"unless"              return 'unless'
"until"               return 'until'
"whenever"            return 'whenever'
"while"               return 'while'
"there"               return 'there'
"those"               return 'those'
"plus"                return 'plus'
"for"                 return 'for'
"times"               return 'times'
"even"                return 'even'
"odd"                 return 'odd'
"minus"               return 'minus'
"than"                return 'than'
"then"                return 'then'
"with"                return 'with'
"what"                return 'what'
"where"               return 'where'
"when"                return 'when'
"like"                return 'like'
"why"                 return 'why'
"means"               return 'means'
"return"              return 'return'
"add"                 return 'add'
"put"                 return 'put'
"let"                 return 'let'
"set"                 return 'set'
"sort"                return 'sort'
"append"              return 'append'
"prepend"             return 'prepend'
"swap"                return 'swap'
"print"               return 'print'
"shuffle"             return "shuffle"
"multiply"            return 'multiply'
"divide"              return 'divide'
"subtract"            return "subtract"
"replace"             return "replace"
"every"               return 'every'
"percent"             return 'percent'
"contains"            return 'contains'
"equals"              return 'equals'
"each"                return 'each'
"too"                 return 'too'
"his"                 return 'his'
"her"                 return 'her'
"its"                 return 'its'
"their"               return 'their'
"and"                 return 'and'
"but"                 return 'but'
"although"            return 'although'
"absolute"            return 'absolute'
"by"                  return 'by'
"yet"                 return 'yet'
"the"                 return 'the'
"this"                return 'this'
"will"                return 'will'
"not"                 return 'not'
"cannot"              return 'cannot'
"no"                  return 'no'
"or"                  return 'or'
"of"                  return 'of'
"is"                  return 'is'
"if"                  return 'if'
"to"                  return 'to'
"a"                   return 'a'
"under"               return 'under'
"on"                  return 'on'
"off"                 return 'off'
"in"                  return 'in'
"inside"              return 'inside'
"how"                 return 'how'
"are"                 return 'are'
"not"                 return 'not'
"an"                  return 'an'
"below"               return 'below'
"above"               return 'above'
"does"                return 'does'
"else"                return 'else'
"otherwise"           return 'otherwise'
"did"                 return 'did'
"do"                  return 'do'
"shall"               return 'shall'
"must"                return 'must'
"were"                return 'were'
"had"                 return 'had'
"has"                 return 'has'
"have"                return 'have'
"can"                 return 'can'
"am"                  return 'am'
"your"                return 'your'
"my"                  return 'my'
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


interrogative_pronoun: "who" | "what" | "where" | "when" | "why" | "that" | "which";

dot_or_semicolon: "."|";";

statement:
	"what" to_be or_expr '?' {$$ = [$1,$2,$3];}
    | means_expr dot_or_semicolon {$$ = $1;}
    | "if" parentheses_expr_ then_or_comma statement_with_semicolon dot_or_semicolon {$$ = [$1,$2,["statements",[["semicolon",$4]]]];}
    | "unless" or_expr "," statement_with_semicolon dot_or_semicolon {$$ = [$1,$2,["statements",[["semicolon",$4]]]];}
    | "if" parentheses_expr_ then_or_comma parentheses_expr dot_or_semicolon {$$ = ["if",$2,["statements",[["semicolon",$4]]]];}
    | "if" parentheses_expr_ then_or_comma bracket_statements elif {$$ = ["if",$2,$4,$5];}
    | "if" parentheses_expr_ bracket_statements elif {$$ = ["if",$2,$3,$4];}
    | "if" parentheses_expr_ bracket_statements {$$ = ["if",$2,$3];}
    | statement_with_semicolon dot_or_semicolon {$$ = ["semicolon",$1];}
    | "function" grammar_var "(" parameters ")" "{" statements "}" {$$ = ["function","public","Object",$2,$4,$7]}
	| if_then_expr dot_or_semicolon {$$ = $1;};

then_or_comma: "then"|";";
if_or_unless:"if";

bracket_statements:
	 "{" statements "}" {$$ = $2;} | while_loop {$$ = ["statements",[$1]];} | parentheses_expr dot_or_semicolon {$$ = ["statements",[["semicolon",$1]]];} | statement_with_semicolon dot_or_semicolon {$$ = ["statements",[["semicolon",$1]]];};

means_expr:
	statement_with_semicolon "means" the_add_expr {$$ = [$1,$2,$3]}
	| statement_with_semicolon "means" statement_with_semicolon {$$ = [$1,$2,$3]}
	| preposition "means" preposition {$$ = [$1,$2,$3]}
	| and_synonym "means" and_synonym {$$ = [$1,$2,$3]}
	| or_expr "means" or_expr {$$ = [$1,$2,$3]}
	;

conditional_conjunction: "unless" | "when" | "whenever" | "until" | "if";

if_then_expr:
	or_expr {$$ = $1;}
	| while_loop
	| "(" "if" or_expr then_or_comma or_expr ")" {$$ = [$2,$3,$4,$5]}
	| statement_with_semicolon conditional_conjunction or_expr {$$ = [$2,$3,["statements",[["semicolon",$1]]]];}
	| parentheses_expr_ conditional_conjunction or_expr {$$ = [$2,$3,["statements",[["semicolon",$1]]]];}
	| or_expr "implies" or_expr {$$ = [$2,$1,$3];};

or_operator: "or" | "where";

while_loop: "while" "(" or_expr ")" "{" statements "}" {$$ = ["while",$3,$6]} ;
or_expr: and_expr or_operator or_expr {$$ = [$1,$2,$3];} | and_expr "||" or_expr {$$ = [$2,$1,$3];} | and_expr;
and_expr: bool_expr and_synonym and_expr {$$ = [$1,$2,$3];} | bool_expr "&&" and_expr {$$ = [$2,$1,$3];} | bool_expr;

increment_operator: "+="|"-="|"*="|"/=";

statement_with_semicolon:
	verb or_expr {$$ = [$1,$2];}
	| grammar_var "=" or_expr {$$ = ["set_var",$1,$3];}
	| grammar_var increment_operator or_expr {$$ = [$2,$1,$3];}
	| IDENTIFIER article and_expr {$$ = [$1,$2,$3];};

parameter: grammar_var {$$ = ["Object", $1];} | grammar_var grammar_var {$$ = [$1,$2];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};

to_be: "is"|"are"|"does"|"did"|"do"|"should"|"must"|"shall"|"will"|"can"|"were"|"had"|"has"|"have"|"am";
to_be_: "is"|"are"|"was"|"were";
verb: "sort" | "shuffle" | "add" | "subtract" | "return" | "replace" | "divide" | "multiply" | "swap" | "print" | "append" | "prepend" | "put" | "let" | "set";

adjective_or_identifier: adjective|IDENTIFIER;

article_or_number: article | NUMBER;

bool_expr:
NUMBER IDENTIFIER verb_phrase {$$ = [$1,$2,$3];}
| IDENTIFIER IDENTIFIER preposition the_add_expr {$$= [$1,$2,$3,$4];} //"Bob walks up the stairs"
| the_add_expr verb_phrase {$$= [$1,$2];}
| "there" to_be_ the_add_expr {$$ = [$1,$2,$3];}
| the_add_expr "is" "as" adjective_or_identifier "as" the_add_expr {$$ = [$1,$2,$3,$4,$5,$6];}
| IDENTIFIER IDENTIFIER the_add_expr {$$ = [$1,$2,$3];}
| article IDENTIFIER IDENTIFIER article add_expr {$$ = [$1,$2,$3,$4,$5];}
| the_add_expr ">" the_add_expr {$$= [$2,$1,$3];} 
| the_add_expr "<" the_add_expr {$$=[$2,$1,$3];} 
| the_add_expr "<=" the_add_expr {$$=[$2,$1,$3];} 
| the_add_expr ">=" the_add_expr {$$=[$2,$1,$3];}
| the_add_expr "==" the_add_expr {$$=[$2,$1,$3];} 
| the_add_expr "equals" the_add_expr {$$=[$2,$1,$3];}
| the_add_expr "contains" the_add_expr {$$=[$2,$1,$3];}
| the_add_expr "!=" the_add_expr {$$=[$2,$1,$3];} | the_add_expr;

preposition: "than" preposition_ {$$ = [$1,$2];} | preposition_;

preposition_: "plus" | "minus" | "between" | "of" | "than" | "into" | "with" | "under" | "over" | "below" | "above" | "beneath" | "on" | "in" | "onto" | "to" | "by" | "inside" | "from" | "like" | "up" | "down" | "off" | "as" | "for" | "using" | "toward";

and_synonym: "and"|"although"|"but"|"yet";

verb_phrase:
	"cannot" the_add_expr {$$ = [$1,$2];}
	| to_be IDENTIFIER the_add_expr {$$ = [$1,$2,$3];}
	| to_be "not" IDENTIFIER the_add_expr {$$ = [$1,$2,$3,$4];}
	| to_be "not" the_add_expr {$$ = [$1,$2,$3];} 
	| to_be "no" IDENTIFIER preposition the_add_expr {$$ = [$1,$2,$3];} 
	| "cannot" IDENTIFIER the_add_expr {$$ = [$1,$2,$3];} 
	| to_be the_add_expr {$$ = [$1,$2]};

comparison_operator: (">" | "<" | ">=" | ">=") {$$ = $1};

the_add_expr: article add_expr {$$ = [$1,$2];} | add_expr;
the_mul_expr: article mul_expr {$$ = [$1,$2];} | mul_expr;

article: "each" | "every" | "an" | "a" | "this" | "his" | "her" | "its" | "their" | "the" | "those" | "your" | "my";

mul_operator: "*" | "/" | "%";

pow_expr: parentheses_expr "^" parentheses_expr {$$= [$2,$1,$3]} | parentheses_expr;
mul_expr: pow_expr "times" the_mul_expr {$$= [$1,$2,$3]} | pow_expr mul_operator the_mul_expr {$$= [$2,$1,$3]} | number pow_expr {$$ = [$1,$2];} | pow_expr;
add_expr:
	mul_expr "who" to_be add_expr {$$= [$1,$2,$3,$4];}
	| mul_expr "that" to_be add_expr {$$= [$1,$2,$3,$4];}
	| mul_expr "which" to_be add_expr {$$= [$1,$2,$3,$4];}
	| mul_expr "+" the_add_expr {$$= [$2,$1,$3]}
	| mul_expr "-" the_add_expr {$$= [$2,$1,$3]}
	| mul_expr "percent" "of" the_add_expr {$$=[$1,$2,$3,$4]}
	| mul_expr preposition the_add_expr {$$=[$1,$2,$3]}
	| mul_expr "that" "is" preposition the_add_expr {$$=[$1,$2,$3,$4,$5]}
	| mul_expr "that" "are" preposition the_add_expr {$$=[$1,$2,$3,$4,$5]}
	| mul_expr;

parentheses_expr:
	adjective_expr
	| (IDENTIFIER) "'s" IDENTIFIER {$$=[$3,"of",$1];}
	| array
	| function_call
	| parentheses_expr_;

parentheses_expr_:
	"(" if_then_expr ")" {$$ = ["parentheses",$2];} | grammar_var | NUMBER | STRING_LITERAL {$$ = yytext;};

adjective: "large" | "largest" | "smallest" | "even" | "odd" | "absolute" | "small" | "big" | "little" | "prime" | "composite" | "male" | "female" | "carnivorous" | "herbivorous" | "same" | "different" | "square" | "old";
adjective_expr:
	adjective parentheses_expr {$$ = [$1,$2];}
	| adjective
	;

grammar_var: (article | verb | IDENTIFIER) {$$=$1;};

array: "[" or_exprs "]" {$$ = ["initializer_list","Object",$2];};
or_exprs: or_exprs "," or_expr {$$ = $1.concat([$3]);} | or_expr {$$ = [$1];};

function_call: grammar_var "{" or_exprs "}" {$$ = ["function_call",$1,$3]};

elif: else_or_otherwise "if" parentheses_expr_ bracket_statements elif {$$ = ["elif",$3,$4,$5]} | else_or_otherwise "if" parentheses_expr_ bracket_statements {$$ = ["elif",$3,$4]} | else_or_otherwise bracket_statements {$$ = ["else",$2];};

else_or_otherwise: "else"|"otherwise";
