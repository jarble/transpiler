/* lexical grammar */
%lex
%%

(\s+|\/\/+.*\n)        /* skip whitespace and line comments */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
\"([^\\\"]|\\.)*\"    return 'STRING_LITERAL'
"service"             return 'service'
"required"            return 'required'
"optional"            return 'optional'
"enum"                return 'enum'
"void"                return "void"
"const"               return "const"
"struct"              return "struct"
","                   return ','
";"                   return ';'
"."                   return '.'
":"                   return ':'
"--"                  return '--'
"-"                   return '-'
"{"                   return '{'
"}"                   return '}'
"["                   return '['
"]"                   return ']'
"("                   return '('
")"                   return ')'
"="                   return '='
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

comma_or_semicolon: "," | ";";

struct_statements: struct_statement comma_or_semicolon struct_statements {$$ = [$1].concat($3);} | struct_statement {$$ =
 [$1];};
 
struct_statement: parameter | type IDENTIFIER "(" parameters ")" {$$ = ["interface_static_method","public",$1,$2,$4]};

statements: statements_ {$$ = ["statements",$1]};

statement
    :
	"struct" IDENTIFIER "{" struct_statements "}" {$$ = ["struct",$2,["struct_statements",$4]]}
	| "service" IDENTIFIER "{" struct_statements "}" {$$ = ["protobuf_service",$2,["struct_statements",$4]]}
	| "enum" IDENTIFIER "{" enum_statements "}" {$$ = ["enum","public",$2,$4];}
    ;

required_or_optional:"required"|"optional";
type: "void" | IDENTIFIER;
parameter: NUMBER ":" type IDENTIFIER {$$ = ["protobuf_parameter",$1,$3,$4];} | NUMBER ":" required_or_optional type IDENTIFIER {$$ = ["protobuf_optional_parameter",$1,$3,$4,$5];};
parameters: parameter "," parameters {$$ = [$1].concat($3);} | parameter {$$ =
 [$1];} | {$$ = [];};

enum_statements: enum_statement "," enum_statements {$$ = [$1].concat($3);} | enum_statement {$$ = [$1];};
enum_statement: IDENTIFIER "=" NUMBER {$$ = ["enum_statement",$1,$3]};
