/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
"$"[0-9]+("."[0-9]+)?\b  return 'GRAMMAR_INDEX'
\"([^\\\"]|\\.)*\" return 'STRING_LITERAL'
"$$"                  return '$$'
";"                   return ';'
","                   return ','
":"                   return ':'
"/"                   return '/'
"="                   return '='
"*"                   return '*'
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

statements: grammar_statements {$$ = ["top_level_statements",$1]};

grammar_statements:
    IDENTIFIER "=" grammar_and_ {$$= [["grammar_statement",$1,$3]]} | IDENTIFIER "=" grammar_and_ grammar_statements {$$= [["grammar_statement",$1,$3]].concat($4)};

grammar_and_: grammar_and_ "/" e {$$= ["grammar_or",$1,$3]} | grammar_and_ e {
	if(Array.isArray($1) && $1[0] == "grammar_or"){
		$$ = ["grammar_or",$1[1],["grammar_and",$1[2],$2]];
	}
	else{
		$$ = ["grammar_and",$1,$2];
	}
} | e;

e: "*" e {$$= ["grammar_optional", $2];}  | "(" grammar_and_ ")" {$$= ["parentheses", $2];} | grammar_var ":" IDENTIFIER {$$ = ["function_call",$3,[$1]];} | grammar_var | STRING_LITERAL
        {$$ = yytext;};

grammar_var: IDENTIFIER {$$= ["grammar_var",$1];};
