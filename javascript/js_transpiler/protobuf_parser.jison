/* lexical grammar */
%lex
%%

(\s+|\/\/+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\"    return 'STRING_LITERAL'
"service"             return 'service'
"enum"                return "enum"
"required"            return "required"
"optional"            return "optional"
"void"                return "void"
"const"               return "const"
"message"             return "message"
"switch"              return "switch"
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"="                   return '='
"-"                   return '-'
"{"                   return '{'
"}"                   return '}'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
[a-zA-Z_][a-zA-Z0-9_]* return 'IDENTIFIER'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%right '?'
%left '||'
%left '&&'
%left '<' '<=' '>' '>=' '==' '!='
%left ('<' '<') ('>' '>')
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: statements_ EOF {return ["top_level_statements",$1]};

statements_: statement statements_ {$$ = [$1].concat($2);} | statement {$$ =
 [$1];};

struct_statements: struct_statement struct_statements {$$ = [$1].concat($2);} | struct_statement {$$ =
 [$1];};
 
struct_statement: parameter ";";

statements: statements_ {$$ = ["statements",$1]};

statement
    :
	"message" IDENTIFIER "{" struct_statements "}" {$$ = ["struct",$2,["struct_statements",$4]]}
	| "enum" IDENTIFIER "{" enum_statements "}" {$$ = ["enum","public",$2,$4];};


type: "void" | IDENTIFIER;
parameter: type IDENTIFIER "=" NUMBER {$$ = ["protobuf_parameter",$4,$1,$2];};

enum_statements: enum_statement "," enum_statements {$$ = [$1].concat($3);} | enum_statement {$$ = [$1];};
enum_statement: IDENTIFIER "=" NUMBER {$$ = ["enum_statement",$1,$3]};
