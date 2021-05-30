/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
"$"[0-9]+("."[0-9]+)?\b  return 'GRAMMAR_INDEX'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$$"                  return '$$'
"ometa"               return 'ometa'
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


statements_: IDENTIFIER "=" grammar_or statements_ {$$ = [["grammar_statement",$1,$3]].concat($4);} | statement {$$ =
 [$1];};
 
statements: grammar_statements {$$ = ["top_level_statements",[$1]]};

grammar_statements: IDENTIFIER "{" statements_ "}" {$$=["grammar_statements",$1,["statements",$3]];};


statement:
    IDENTIFIER "=" grammar_or {$$ = ["grammar_statement",$1,$3]};

parameters: IDENTIFIER "," parameters {$$ = [$1].concat($3);} | IDENTIFIER {$$ =
 [$1];} | {$$ = [];};

grammar_and:
    grammar_and "," e {$$= ["grammar_and",$1,$3]} | e;

grammar_or:
    grammar_or "|" grammar_and {$$= ["grammar_or",$1,$3]} | grammar_and;

e: grammar_var | STRING_LITERAL
        {$$ = yytext;};

grammar_var: IDENTIFIER {$$= ["grammar_var",$1];};
