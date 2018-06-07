/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
"$"[0-9]+("."[0-9]+)?\b  return 'GRAMMAR_INDEX'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$$"                  return '$$'
":"                   return ':'
";"                   return ';'
","                   return ','
"|"                   return '|'
"="                   return '='
"("                   return '('
")"                   return ')'
"{"                   return '{'
"}"                   return '}'
"["                   return '['
"]"                   return ']'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex
/* operator associations and precedence */


%start expressions

%% /* language grammar */

expressions
    : statements EOF
        {return $1;}
    ;

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};
 
statements: statements_ {$$ = ["top_level_statements",$1]};




statement:
    IDENTIFIER ":" grammar_or ";" {$$ = ["grammar_statement",$1,$3]};

grammar_or:
    grammar_and_ "|" grammar_or {$$= ["grammar_or",$1,$3]} | grammar_and_;

grammar_and_: grammar_and | grammar_and output_array {$$ = ["grammar_output",$1,$2]};

output_array: "{" "$$" "=" "[" grammar_indices "]" ";" "}" {$$ = $5;};

grammar_indices: grammar_index_ "," grammar_indices {$$ = [$1].concat($3);} | grammar_index_ {$$ = [$1];};
grammar_index_: GRAMMAR_INDEX {$$ = ["grammar_index", $1.substring(1)];} | STRING_LITERAL;

grammar_and:
    e grammar_and {$$= ["grammar_and",$1,$2]} | e;

e: "(" grammar_or ")" {$$= ["parentheses", $2];} | grammar_var | STRING_LITERAL
        {$$ = yytext;};

grammar_var: IDENTIFIER {$$= ["grammar_var",$1];};
