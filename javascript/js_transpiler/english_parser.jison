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

"large"               return 'large'
"small"               return 'small'
"big"                 return 'big'
"prime"               return 'prime'
"composite"           return 'composite'
"male"                return 'male'
"female"              return 'female'
"carnivorous"         return 'carnivorous'
"herbivorous"         return 'herbivorous'
"same"                return 'same'

"function"            return 'function'
"between"             return 'between'
"into"                return 'into'
"toward"              return 'toward'
"during"              return 'during'
"after"               return 'after'
"from"                return 'from'
"onto"                return 'onto'
"who"                 return 'who'
"was"                 return 'was'
"up"                  return 'up'
"that"                return 'that'
"down"                return 'down'
"implies"             return 'implies'
"while"               return 'while'
"there"               return 'there'
"those"               return 'those'
"plus"                return 'plus'
"times"               return 'times'
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
"every"               return 'every'
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
"by"                  return 'by'
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

statements_conjunction: statements_conjunction and_synonym if_then_expr {$$=["&&",$1,$3];} | if_then_expr;

interrogative_pronoun: "who" | "what" | "where" | "when" | "why";

statement:
	"what" to_be or_expr '?' {$$ = [$1,$2,$3];}
    | means_expr "." {$$ = $1;}
    | statement_with_semicolon "." {$$ = ["semicolon",$1];};

means_expr:
	statement_with_semicolon "means" statement_with_semicolon {$$ = [$1,$2,$3]}
	| statement_with_semicolon "means" if_then_expr {$$ = [$1,$2,$3]}
	| if_then_expr "means" if_then_expr {$$ = [$1,$2,$3]}
	| if_then_expr "means" statement_with_semicolon {$$ = [$1,$2,["semicolon",$3]]}
	| preposition "means" preposition {$$ = [$1,$2,$3]}
	| prepositional_phrase "means" prepositional_phrase {$$ = [$1,$2,$3]}
	| if_then_expr
	;


if_then_expr:
	or_expr {$$ = $1;}
	| "function" grammar_var "(" parameters ")" "{" statements "}" {$$ = ["function","public","Object",$2,$4,$7]}
	| "while" "(" or_expr ")" "{" statements "}" {$$ = ["while",$3,$6]} 
	| or_expr "if" or_expr {$$ = [$1,$2,$3];}
	| "if" or_expr "then" or_expr {$$ = [$1,$2,$3,$4]}
	| or_expr "implies" or_expr {$$ = [$1,$2,$3];};

or_expr: and_expr "or" or_expr {$$ = [$1,$2,$3];} | and_expr "||" or_expr {$$ = [$2,$1,$3];} | and_expr;
and_expr: bool_expr and_synonym and_expr {$$ = [$1,$2,$3];} | bool_expr "&&" and_expr {$$ = [$2,$1,$3];} | bool_expr;

increment_operator: "+="|"-="|"*="|"/=";

statement_with_semicolon:
	"return" or_expr {$$ = [$1,$2];}
	| grammar_var "=" or_expr {$$ = ["set_var",$1,$3];}
	| grammar_var increment_operator or_expr {$$ = [$2,$1,$3];}
	| IDENTIFIER article and_expr {$$ = [$1,$2,$3];};

parameter: grammar_var {$$ = ["Object", $1];} | grammar_var grammar_var {$$ = [$1,$2];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = []};

to_be: "is"|"are"|"does"|"did"|"do"|"should"|"must"|"shall"|"will"|"can"|"were"|"had"|"has"|"have"|"am";
to_be_: "is"|"are"|"was"|"were";

bool_expr:
the_add_expr verb_phrase {$$= [$1,$2];}
| "there" to_be_ the_add_expr {$$ = [$1,$2,$3];}
| "there" to_be_ the_add_expr prepositional_phrase {$$ = [$1,$2,$3,$4];}
| IDENTIFIER IDENTIFIER the_add_expr prepositional_phrase {$$ = [$1,$2,$3,$4];}
| IDENTIFIER parentheses_expr prepositional_phrase {$$ = [$1,$2,$3];}
| IDENTIFIER IDENTIFIER the_add_expr {$$ = [$1,$2,$3];}
| article IDENTIFIER IDENTIFIER article add_expr {$$ = [$1,$2,$3,$4,$5];}
| article IDENTIFIER IDENTIFIER prepositional_phrase {$$ = [$1,$2,$3,$4];}
| the_add_expr ">" the_add_expr {$$= [$2,$1,$3];} 
| the_add_expr "<" the_add_expr {$$=[$2,$1,$3];} 
| the_add_expr "<=" the_add_expr {$$=[$2,$1,$3];} 
| the_add_expr ">=" the_add_expr {$$=[$2,$1,$3];}
| the_add_expr "==" the_add_expr {$$=[$2,$1,$3];} 
| the_add_expr "equals" the_add_expr {$$=[$2,$1,$3];}
| the_add_expr "contains" the_add_expr {$$=[$2,$1,$3];}
| the_add_expr "!=" the_add_expr {$$=[$2,$1,$3];} | the_add_expr;

preposition: "between" | "than" | "into" | "with" | "under" | "over" | "below" | "above" | "beneath" | "on" | "in" | "onto" | "to" | "by" | "inside" | "from" | "like" | "up" | "down" | "off";

and_synonym: "and"|"although"|"but";

verb_phrases:
	verb_phrases and_synonym verb_phrase | verb_phrase;

verb_phrase:
	"cannot" the_add_expr {$$ = [$1,$2];}
	| to_be IDENTIFIER the_add_expr {$$ = [$1,$2,$3];}
	| to_be "not" IDENTIFIER the_add_expr {$$ = [$1,$2,$3,$4];}
	| to_be "not" the_add_expr prepositional_phrase {$$ = [$1,$2,$3];} 
	| to_be "not" the_add_expr {$$ = [$1,$2,$3];} 
	| to_be "no" IDENTIFIER "than" the_add_expr {$$ = [$1,$2,$3];} 
	| "cannot" IDENTIFIER the_add_expr {$$ = [$1,$2,$3];} 
	| to_be prepositional_phrase {$$ = [$1,$2];}
	| to_be grammar_var prepositional_phrase {$$ = [$1,$2,$3];}
	| to_be the_add_expr {$$ = [$1,$2]}
	| to_be IDENTIFIER the_add_expr prepositional_phrase {$$ = [$1,$2,$3,$4,$5];};

prepositional_phrase:
	preposition the_add_expr {$$ = [$1,$2];} | preposition the_add_expr prepositional_phrase {$$ = [$1,$2,$3];};

comparison_operator: (">" | "<" | ">=" | ">=") {$$ = $1};

the_add_expr: article add_expr {$$ = [$1,$2];} | add_expr;
the_mul_expr: article mul_expr {$$ = [$1,$2];} | mul_expr;

article: "each" | "every" | "an" | "a" | "this" | "his" | "her" | "its" | "their"|"the"|"those";
interrogative_pronoun: ("who"|"that");

mul_operator: "*" | "/" | "%";

pow_expr: parentheses_expr "^" parentheses_expr {$$= [$2,$1,$3]} | parentheses_expr;
mul_expr: pow_expr "times" the_mul_expr {$$= [$1,$2,$3]} | pow_expr mul_operator the_mul_expr {$$= [$2,$1,$3]} | pow_expr;
add_expr:
	pow_expr "who" to_be add_expr {$$= [$1,$2,$3,$4];}
	| mul_expr "minus" the_add_expr {$$= [$1,$2,$3];}
	| mul_expr "plus" the_add_expr {$$= [$1,$2,$3]}
	| mul_expr "+" the_add_expr {$$= [$2,$1,$3]}
	| mul_expr "-" the_add_expr {$$= [$2,$1,$3]}
	| mul_expr "of" the_add_expr {$$=[$1,$2,$3]}
	| mul_expr;

parentheses_expr:
	adjective_expr
	| (IDENTIFIER) "'s" IDENTIFIER {$$=[$3,"of",$1];}
	| array
	| function_call
	| "(" inside_parentheses_expr ")" {$$ = $2;}
	| "(" if_then_expr ")" {$$ = ["parentheses",$2];}
	| parentheses_expr_;

parentheses_expr_:
	grammar_var | NUMBER | STRING_LITERAL {$$ = yytext;};

adjective: "large" | "small" | "big" | "little" | "prime" | "composite" | "male" | "female" | "carnivorous" | "herbivorous" | "same";
adjective_expr:
	adjective IDENTIFIER {$$ = [$1,$2];}
	| adjective adjective_expr {$$ = [$1,$2];}
	| adjective
	;

inside_parentheses_expr:
	the_add_expr prepositional_phrase {$$ = [$1,$2];}
	;

grammar_var: (article | IDENTIFIER) {$$=$1;};

array: "[" or_exprs "]" {$$ = ["initializer_list","Object",$2];};
or_exprs: or_exprs "," or_expr {$$ = $1.concat([$3]);} | or_expr {$$ = [$1];};

function_call: grammar_var "{" or_exprs "}" {$$ = ["function_call",$1,$3]};
