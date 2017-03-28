:-style_check(-discontiguous).
:-style_check(-singleton).

foreach_with_index(python,Indent,Array,Var,Index,_,Body) -->
	("for",python_ws_,Index,python_ws,",",python_ws,Var,python_ws_,"in",python_ws_,"enumerate",python_ws,"(",!,python_ws,Array,python_ws,"):",python_ws,Body).
foreach_with_index(javascript,Indent,Array,Var,Index,_,Body) -->
	(Array,ws,".",ws,"forEach",ws,"(",ws,"function",ws,"(",ws,Var,ws,",",!,ws,Index,ws,")",!,ws,"{",!,ws,Body,(Indent;ws),"}",ws,")",ws,";").
foreach_with_index(php,Indent,Array,Var,Index,_,Body) -->
	("foreach",ws,"(",ws,Array,ws_,"as",ws_,Index,ws,"=>",ws,Var,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}"),!.
foreach_with_index(ruby,Indent,Array,Var,Index,_,Body) -->
	(Array,ws,".",ws,"each_with_index",ws_,"do",ws,"|",ws,Var,ws,",",ws,Index,ws,"|",ws,Body,(Indent;ws_),"end").
foreach_with_index(swift,Indent,Array,Var,Index,_,Body) -->
	("for",ws,"(",ws,Index,ws,",",!,ws,Var,ws,")",!,ws_,"in",ws_,Array,ws,".",ws,"enumerated",ws,"(",ws,")",!,ws,"{",!,ws,Body,(Indent;ws),"}"),!.
foreach_with_index(lua,Indent,Array,Var,Index,_,Body) -->
	("for",ws_,Index,ws,",",ws,Var,ws_,"in",ws_,"pairs",ws,"(",ws,Array,ws,")",!,ws_,"do",ws_,Body,(Indent;ws_),"end"),!.
foreach_with_index('c#',Indent,Array,Var,Index,Type,Body) -->
	("for",ws,"(",ws,"int",ws_,Index,ws,"=",ws,"0",ws,";",ws,Index,ws,"<",ws,Array,ws,".",ws,"Length",ws,";",ws,Index,ws,"++",ws,")","{",(indent(Indent);ws),Var,ws,"=",ws,Array,ws,"[",ws,Index,ws,"]",ws,";",ws,Body,(Indent;ws),"}"),!.
foreach_with_index('java',Indent,Array,Var,Index,Type,Body) -->
	("for",ws,"(",ws,"int",ws_,Index,ws,"=",ws,"0",ws,";",ws,Index,ws,"<",ws,Array,ws,".",ws,"length",ws,";",ws,Index,ws,"++",ws,")",ws,"{",(indent(Indent);ws),Var,ws,"=",ws,Array,ws,"[",ws,Index,ws,"]",ws,";",ws,Body,(Indent;ws),"}"),!.
foreach_with_index('javascript',Indent,Array,Var,Index,Type,Body) -->
	("for",ws,"(",ws,"var",ws_,Index,ws,"=",ws,"0",ws,";",ws,Index,ws,"<",ws,Array,ws,".",ws,"length",ws,";",ws,Index,ws,"++",ws,")",ws,"{",(indent(Indent);ws),Var,ws,"=",ws,Array,ws,"[",ws,Index,ws,"]",ws,";",ws,Body,(Indent;ws),"}"),!.
foreach_with_index('c++',Indent,Array,Var,Index,Type,Body) -->
	("for",ws,"(",ws,"int",ws_,Index,ws,"=",ws,"0",ws,";",ws,Index,ws,"<",ws,Array,ws,".",ws,"size",ws,"(",ws,")",ws,";",ws,Index,ws,"++",ws,")","{",(indent(Indent);ws),Var,ws,"=",ws,Array,ws,"[",ws,Index,ws,"]",ws,";",ws,Body,(Indent;ws),"}"),!.


for_('c',Indent,Initialize,Condition,Update,Body) -->
	"for",ws,"(",!,ws,Initialize,ws,";",!,ws,Condition,ws,";",!,ws,Update,ws,")",!,ws,"{",!,ws,Body,(Indent;ws),"}",!.
for_('java',Indent,Initialize,Condition,Update,Body) --> for_('c',Indent,Initialize,Condition,Update,Body),!.
for_('c#',Indent,Initialize,Condition,Update,Body) --> for_('c',Indent,Initialize,Condition,Update,Body),!.
for_('c++',Indent,Initialize,Condition,Update,Body) --> for_('c',Indent,Initialize,Condition,Update,Body),!.
for_('perl',Indent,Initialize,Condition,Update,Body) --> for_('c',Indent,Initialize,Condition,Update,Body),!.
for_('javascript',Indent,Initialize,Condition,Update,Body) --> for_('c',Indent,Initialize,Condition,Update,Body),!.
for_('php',Indent,Initialize,Condition,Update,Body) --> for_('c',Indent,Initialize,Condition,Update,Body),!.
for_('typescript',Indent,Initialize,Condition,Update,Body) --> for_('c',Indent,Initialize,Condition,Update,Body),!.

range_(python,A,B) -->
	"range",ws,"(",!,ws,A,ws,",",!,ws,B,ws,")",!.

range_(ruby,A,B) -->
	A,ws,"..",ws,"(",ws,B,ws,"-",ws,"1",ws,")".

not_(python,A) --> "not",ws_,A.
not_(lua,A) --> "not",ws_,A.
not_(c,A) --> "!",!,ws,A.
not_(java,A) --> "!",!,ws,A.
not_(haxe,A) --> "!",!,ws,A.
not_('c++',A) --> "!",!,ws,A.
not_('c#',A) --> "!",!,ws,A.
not_('php',A) --> "!",!,ws,A.
not_(perl,A) --> "!",!,ws,A.
not_(ruby,A) --> "!",!,ws,A.
not_(javascript,A) --> "!",!,ws,A.
not_(typescript,A) --> "!",!,ws,A.

minus_minus('javascript',A) --> minus_minus('c',A).
minus_minus('c++',A) --> minus_minus('c',A).
minus_minus('c#',A) --> minus_minus('c',A).
minus_minus('java',A) --> minus_minus('c',A).
minus_minus('c',A) -->
	A,ws,"--".
minus_minus('ruby',A) --> A,ws,"=",ws,A,ws,"+",ws,"1".

plus_plus('javascript',A) --> plus_plus('c',A).
plus_plus('c++',A) --> plus_plus('c',A).
plus_plus('php',A) --> plus_plus('c',A).
plus_plus('c#',A) --> plus_plus('c',A).
plus_plus('java',A) --> plus_plus('c',A).
plus_plus('ruby',A) --> A,ws,"=",ws,A,ws,"+",ws,"1".
plus_plus('c',A) -->
	A,ws,"++".

top_level_statement('python',Indent,A) --> statement('python',Indent,A).
top_level_statement('c++',Indent,A) --> statement('c++',Indent,A).
top_level_statement('erlang',Indent,A) --> statement('erlang',Indent,A),".".
top_level_statement('prolog',Indent,A) --> statement('prolog',Indent,A),".".
top_level_statement('picat',Indent,A) --> statement('picat',Indent,A),".".
top_level_statement('c',Indent,A) --> statement('c',Indent,A).
top_level_statement('minizinc',Indent,A) --> statement('minizinc',Indent,A),";".
top_level_statement('d',Indent,A) --> statement('d',Indent,A).
top_level_statement('c#',Indent,A) --> statement('c#',Indent,A).
top_level_statement('lua',Indent,A) --> statement('lua',Indent,A).
top_level_statement('swift',Indent,A) --> statement('swift',Indent,A).
top_level_statement('ruby',Indent,A) --> statement('ruby',Indent,A).
top_level_statement('javascript',Indent,A) --> statement('javascript',Indent,A).
top_level_statement('php',Indent,A) --> statement('php',Indent,A).
top_level_statement('perl',Indent,A) --> statement('perl',Indent,A).
top_level_statement('java',Indent,A) --> statement('java',Indent,A).
top_level_statement('haxe',Indent,A) --> statement('haxe',Indent,A).
top_level_statement('dart',Indent,A) --> statement('dart',Indent,A).



top_level_statement_separator('python') --> ws.
top_level_statement_separator('c++') --> ws.
top_level_statement_separator('rust') --> ws.
top_level_statement_separator('erlang') --> ws.
top_level_statement_separator('prolog') --> ws.
top_level_statement_separator('c') --> ws.
top_level_statement_separator('minizinc') --> ws.
top_level_statement_separator('d') --> ws.
top_level_statement_separator('c#') --> ws.
top_level_statement_separator('lua') --> ws_.
top_level_statement_separator('swift') --> ws_.
top_level_statement_separator('ruby') --> ws_.
top_level_statement_separator('javascript') --> ws.
top_level_statement_separator('php') --> ws.
top_level_statement_separator('perl') --> ws.
top_level_statement_separator('java') --> ws.
top_level_statement_separator('haxe') --> ws.
top_level_statement_separator('dart') --> ws.

statement_separator('python') --> ws.
statement_separator('c++') --> ws.
statement_separator('rust') --> ws.
statement_separator('erlang') --> ws,",",ws.
statement_separator('prolog') --> ws,",",ws.
statement_separator('c') --> ws.
statement_separator('minizinc') --> ws.
statement_separator('d') --> ws.
statement_separator('c#') --> ws.
statement_separator('lua') --> ws_.
statement_separator('swift') --> ws_.
statement_separator('ruby') --> ws_.
statement_separator('javascript') --> ws.
statement_separator('php') --> ws.
statement_separator('perl') --> ws.
statement_separator('java') --> ws.
statement_separator('haxe') --> ws.
statement_separator('dart') --> ws.

scalar_type('minizinc',number) --> "float".
scalar_type('minizinc',int) --> "int".

scalar_type('java',char) --> "char".
scalar_type('c++',char) --> "char".
scalar_type('c',char) --> "char".
scalar_type('haxe',number) --> "Float".
scalar_type('haxe',string) --> "String".
scalar_type('haxe',int) --> "Int".
scalar_type('haxe',bool) --> "Bool".
scalar_type('python',string) --> "str".
scalar_type('c++',number) --> "double".
scalar_type('java',int) --> "int".
scalar_type('java',number) --> "double".
scalar_type('c',number) --> "double".
scalar_type('c',int) --> "int".
scalar_type('c++',int) --> "int".
scalar_type('c++',bool) --> "bool".
scalar_type('c#',int) --> "int".
scalar_type('python',int) --> "int".
scalar_type('python',number) --> "float".
scalar_type('c',bool) --> "bool".
scalar_type('java',bool) --> "boolean".
scalar_type('c#',bool) --> "bool".
scalar_type('c#',number) --> "double".
scalar_type('c#',string) --> "string".
scalar_type('c++',string) --> "string".
scalar_type('c',string) --> "char*".
scalar_type('java',string) --> "String".

type(Lang,A) --> scalar_type(Lang,A).

type('java',[array,Type]) --> scalar_type(java,Type),"[]".
type('c#',[array,Type]) --> scalar_type(java,Type),"[]".
type('c++',[array,Type]) --> "vector<",ws,scalar_type('c++',Type),">".

% this is from http://stackoverflow.com/questions/20297765/converting-1st-letter-of-atom-in-prolog
first_char_uppercase(WordLC, WordUC) :-
    atom_chars(WordLC, [FirstChLow|LWordLC]),
    atom_chars(FirstLow, [FirstChLow]),
    upcase_atom(FirstLow, FirstUpp),
    atom_chars(FirstUpp, [FirstChUpp]),
    atom_chars(WordUC, [FirstChUpp|LWordLC]).

%var_name_(prolog,_,symbol(A)) -->
%	{atom_string(B,A), first_char_uppercase(B, C),atom_chars(C,D)},
%	symbol(D).
var_name_(prolog,_,A) --> A.
var_name_('rust',_,A) --> A.
var_name_(erlang,_,A) --> A.
var_name_(minizinc,_,A) --> A.
var_name_(python,_,A) --> A.
var_name_(sympy,_,A) --> A.
var_name_(cython,_,A) --> A.
var_name_(java,_,A) --> A.
var_name_(dart,_,A) --> A.
var_name_(swift,_,A) --> A.
var_name_(javascript,_,A) --> A,!.
var_name_(ruby,_,A) --> A.
var_name_(haxe,_,A) --> A.
var_name_('c#',_,A) --> A.
var_name_(lua,_,A) --> A.
var_name_('c++',_,A) --> A.
var_name_(c,_,A) --> A.
var_name_(php,_,A) --> "$",A.
var_name_(perl,Type,A) --> "$",A,{member(Type,[int,double,string,number,bool])}.
var_name_(perl,[array,_],A) --> "@",A.

parameter_(cython,_,A) --> A.
parameter_(sympy,_,A) --> A.
parameter_(python,_,A) --> A.
parameter_(sympy,_,A) --> A.
parameter_(erlang,_,A) --> A.
parameter_(prolog,_,A) --> A.
parameter_(javascript,_,A) --> A.
parameter_(perl,_,A) --> A.
parameter_(php,_,A) --> A.
parameter_(lua,_,A) --> A.
parameter_(ruby,_,A) --> A.
parameter_(javascript,_,A) --> A,!.
parameter_('java',Type,A) --> Type,ws_,A.
parameter_('c#',Type,A) --> Type,ws_,A.
parameter_('c++',Type,A) --> Type,ws_,A.
parameter_('c',Type,A) --> Type,ws_,A.
parameter_('haxe',Type,A) --> A,ws,":",ws,Type.
parameter_('swift',Type,A) --> A,ws,":",ws,Type.
parameter_('typescript',Type,A) --> A,ws,":",ws,Type.
parameter_('visual basic',Type,A) --> A,ws_,"as",ws_,Type.

randint(python,A,B) -->
	"random",python_ws,".",python_ws,"randint",python_ws,"(",A,python_ws,",",python_ws,B,")".

minus_equals_(lua,A,B) --> A,ws,"=",ws,A,ws,"-",ws,B.
minus_equals_(cython,A,B) --> A,python_ws,"-=",python_ws,B.
minus_equals_(python,A,B) --> A,python_ws,"-=",python_ws,B.
minus_equals_(coffeescript,A,B) --> A,python_ws,"-=",python_ws,B.
minus_equals_(c,A,B) --> A,ws,"-=",!,ws,B.
minus_equals_(php,A,B) --> A,ws,"-=",!,ws,B.
minus_equals_('c++',A,B) --> A,ws,"-=",!,ws,B.
minus_equals_(java,A,B) --> A,ws,"-=",!,ws,B.
minus_equals_(perl,A,B) --> A,ws,"-=",!,ws,B.
minus_equals_('c#',A,B) --> A,ws,"-=",!,ws,B.
minus_equals_(javascript,A,B) --> A,ws,"-=",!,ws,B.
minus_equals_(c,A,B) --> A,ws,"-=",!,ws,B.
minus_equals_(haxe,A,B) --> A,ws,"-=",!,ws,B.
minus_equals_(ruby,A,B) --> A,ws,"-=",!,ws,B.

times_equals_(cython,A,B) --> A,python_ws,"*=",python_ws,B.
times_equals_(python,A,B) --> A,python_ws,"*=",python_ws,B.
times_equals_(lua,A,B) --> A,ws,"=",!,ws,A,ws,"*",ws,B.
times_equals_(coffeescript,A,B) --> A,python_ws,"*=",python_ws,B.
times_equals_(c,A,B) --> A,ws,"*=",!,ws,B.
times_equals_(php,A,B) --> A,ws,"*=",!,ws,B.
times_equals_(haxe,A,B) --> A,ws,"*=",!,ws,B.
times_equals_(java,A,B) --> A,ws,"*=",!,ws,B.
times_equals_('c#',A,B) --> A,ws,"*=",!,ws,B.
times_equals_('c++',A,B) --> A,ws,"*=",!,ws,B.
times_equals_(javascript,A,B) --> A,ws,"*=",!,ws,B.
times_equals_(perl,A,B) --> A,ws,"*=",!,ws,B.
times_equals_(c,A,B) --> A,ws,"*=",!,ws,B.
times_equals_(ruby,A,B) --> A,ws,"*=",!,ws,B.

divide_equals_(cython,A,B) --> A,python_ws,"/=",python_ws,B.
divide_equals_(lua,A,B) --> A,ws,"=",!,ws,A,ws,"/",ws,B.
divide_equals_(python,A,B) --> A,python_ws,"/=",python_ws,B.
divide_equals_('c++',A,B) --> A,ws,"/=",!,ws,B.
divide_equals_('java',A,B) --> A,ws,"/=",!,ws,B.
divide_equals_('c#',A,B) --> A,ws,"/=",!,ws,B.
divide_equals_(javascript,A,B) --> A,ws,"/=",!,ws,B.
divide_equals_(c,A,B) --> A,ws,"/=",!,ws,B.
divide_equals_(ruby,A,B) --> A,ws,"/=",!,ws,B.
divide_equals_(haxe,A,B) --> A,ws,"/=",!,ws,B.
divide_equals_(perl,A,B) --> A,ws,"/=",!,ws,B.


plus_equals_(perl,number,A,B) --> plus_equals_(c,number,A,B).
plus_equals_(c,number,A,B) --> A,ws,"+=",!,ws,B.
plus_equals_(haxe,Type,A,B) --> {member(Type,[string,number])},A,ws,"+=",!,ws,B.
plus_equals_(php,number,A,B) --> plus_equals_(c,number,A,B).
plus_equals_(php,string,A,B) --> A,ws,".=",ws,B.
plus_equals_(perl,string,A,B) --> A,ws,".=",ws,B.
plus_equals_(perl,[array,_],A,B) -->
	"push",ws_,A,ws,",",ws,B.
plus_equals_(php,[array,Type],A,B) -->
	A,ws,"=",ws,"array_merge",ws,"(",ws,A,ws,",",ws,B,ws,")".
plus_equals_(lua,string,A,B) --> A,ws,"=",!,ws,A,ws,"..",ws,B.
plus_equals_(lua,number,A,B) --> A,ws,"=",!,ws,A,ws,"+",ws,B.
plus_equals_(python,_,A,B) --> A,python_ws,"+=",python_ws,B.
plus_equals_(ruby,_,A,B) --> A,ws,"+=",!,ws,B.
plus_equals_(javascript,[array,_],A,B) -->
	A,ws,"=",ws,A,ws,".",ws,"concat",ws,"(",ws,B,ws,")".
plus_equals_(javascript,_,A,B) --> A,ws,"+=",!,ws,B.
plus_equals_(java,Type,A,B) --> {member(Type,[string,number])},A,ws,"+=",!,ws,B.
plus_equals_('c#',Type,A,B) --> {member(Type,[string,number])},A,ws,"+=",!,ws,B.
plus_equals_('c++',Type,A,B) --> {member(Type,[string,number])},A,ws,"+=",!,ws,B.
plus_equals_('c++',[array,_],A,B) --> A,ws,".",ws,"insert",ws,"(",ws,A,ws,".",ws,"end",ws,"(",ws,")",ws,",",ws,B,ws,".",ws,"begin",ws,"(",ws,")",ws,",",ws,B,ws,".",ws,"end",ws,"(",ws,")",ws,")".

floor_(python,A) -->
	("math",python_ws,".",python_ws,"floor",python_ws,"(",!,python_ws,A,python_ws,")"),!.

ceiling_(python,A) -->
	("math",python_ws,".",python_ws,"ceiling",python_ws,"(",!,python_ws,A,python_ws,")"),!.


random_from_list(python,Arr) -->
	("random",python_ws,".",python_ws,"choice",python_ws,"(",!,python_ws,Arr,python_ws,")"),!.
random_from_list(php,Arr) -->
	("array_rand",ws,"(",!,ws,Arr,ws,")"),!.
random_from_list(julia,Arr) -->
	("rand",ws,"(",!,ws,Arr,ws,")"),!.
random_from_list(ruby,Arr) -->
	(Arr,ws,".",ws,"sample").
random_from_list('perl 6',Arr) -->
	(Arr,ws,".",ws,"pick").
random_from_list(wolfram,Arr) -->
	("RandomChoice",ws,"[",ws,Arr,ws,"]").
random_from_list(coffeescript,Arr) -->
	random_from_list(javascript,Arr).
random_from_list(javascript,Arr) -->
	(Arr,python_ws,"[",ws,"Math",ws,".",ws,"floor",ws,"(",ws,"Math",ws,".",ws,"random",ws,"(",ws,")",ws,"*",python_ws,Arr,python_ws,".",ws,"length",ws,")",ws,"]").



split_(python,string,Str,Sep) --> 
	(Str,python_ws,".",python_ws,"split",python_ws,"(",!,python_ws,Sep,python_ws,")").
split_(java,string,Str,Sep) --> split_(python,string,Str,Sep).
split_(ruby,string,Str,Sep) --> split_(python,string,Str,Sep).
split_(haxe,string,Str,Sep) --> split_(python,string,Str,Sep).
split_(rust,string,Str,Sep) --> split_(python,string,Str,Sep).
split_(vala,string,Str,Sep) --> split_(python,string,Str,Sep).
split_(javascript,string,Str,Sep) --> split_(python,string,Str,Sep).
split_(cython,string,Str,Sep) --> split_(python,string,Str,Sep).
split_(dart,string,Str,Sep) --> split_(python,string,Str,Sep).
split_(go,string,Str,Sep) --> 
	("strings",ws,".",ws,"Split",ws,"(",!,ws,Str,ws,",",!,ws,Sep,ws,")").
split_('c#',string,AString,Separator) -->
	(AString,ws,".",ws,"Split",ws,"(",ws,"new",ws,"string[]",ws,"{",ws,Separator,ws,"}",ws,",",ws,"StringSplitOptions",ws,".",ws,"None",ws,")").
split_('php',string,AString,Separator) --> 
    ("explode",ws,"(",!,ws,Separator,ws,",",!,ws,AString,ws,")").
split_('haskell',string,AString,Separator) --> 
	("(",ws,"splitOn",ws_,AString,ws_,Separator,ws,")").
split_('perl',string,AString,Separator) --> 
	("split",ws,"(",!,ws,Separator,ws,",",!,ws,AString,ws,")").

join_(Lang,Array,Separator) -->
	{memberchk(Lang,['javascript','haxe','groovy','java','typescript','rust','dart','ruby'])},
	(Array,ws,".",ws,"join",ws,"(",!,ws,Separator,ws,")"),!.
join_(php,Array,Separator) -->
	("implode",ws,"(",!,ws,Separator,ws,",",!,ws,Array,ws,")").
join_(python,Arr,Sep) -->
	(Sep,python_ws,".",python_ws,"join",python_ws,"(",!,python_ws,Arr,python_ws,")").
join_('c#',Array,Separator) -->
	("String",ws,".",ws,"Join",ws,"(",!,ws,Separator,ws,",",!,ws,Array,ws,")").

replace_(swift,string,Str,Sub,Replacement) --> 
	(Str,ws,".",ws,"stringByReplacingOccurrencesOfString",ws,"(",!,ws,Sub,ws,",",!,ws,"withString:",ws,Replacement,ws,")").
replace_(python,string,A,B,C) -->
	A,python_ws,".",python_ws,"replace",python_ws,"(",!,python_ws,B,python_ws,",",!,python_ws,C,python_ws,")",!.
replace_(ruby,string,A,B,C) -->
	A,ws,".",ws,"gsub",ws,"(",!,ws,B,ws,",",!,ws,C,ws,")",!.
replace_(haxe,string,Str,Sub,Replacement) -->
	("StringTools",ws,".",ws,"replace",ws,"(",!,ws,Str,ws,",",!,ws,Sub,ws,Replacement,ws,")"),!.
replace_(java,string,A,B,C) -->
	replace_(python,string,A,B,C).
%replace_(javascript,string,Str,Sub,Replacement) --> 
%	(Str,ws,".",ws,"split",ws,"(",ws,Sub,ws,")",ws,".",ws,"join",ws,"(",ws,Replacement,ws,")"),!.
replace_('c++',string,Str,Sub,Replacement) --> 
	(Str,ws,".",ws,"replace",ws,"(",ws,"s",ws,".",ws,"find",ws,"(",ws,Sub,ws,")",ws,",",Sub,".",ws,"length",ws,"(",ws,")",ws,",",ws,Replacement,ws,")").
replace_('c#',string,Str,Sub,Replacement) --> 
	(Str,ws,".",ws,"Replace",ws,"(",!,ws,Sub,ws,",",!,ws,Replacement,ws,")"),!.
replace_('php',string,Str,Sub,Replacement) --> 	
	("str_replace",ws,"(",!,ws,Sub,ws,",",!,ws,Replacement,ws,",",!,ws,Str,ws,")"),!.

initialize_constant_(minizinc,Type,Name,Value) --> (Type,ws,":",ws,Name,ws,"=",!,ws,Value).
initialize_constant_(seed7,Type,Name,Value) --> ("const",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Value).
initialize_constant_('perl 6',Type,Name,Value) -->  ("constant",ws_,Type,ws_,Name,ws,"=",ws,Value).
initialize_constant_('php',Type,Name,Value) --> ("const",ws_,Name,ws,"=",ws,Value).
initialize_constant_('javascript',Type,Name,Value) --> ("const",ws_,Name,ws,"=",!,ws,Value).
initialize_constant_('dart',Type,Name,Value) --> ("const",ws_,Name,ws,"=",!,ws,Value).
initialize_constant_('go',Type,Name,Value) --> ("const",ws_,Type,ws_,Name,ws,"=",ws,Value).
initialize_constant_('rust',Type,Name,Value) --> ("let",ws_,Name,ws,"=",ws,Value).
initialize_constant_('swift',Type,Name,Value) --> ("let",ws_,Name,ws,"=",ws,Value).
initialize_constant_('java',Type,Name,Value) --> ("final",ws_,Type,ws_,Name,ws,"=",!,ws,Value).
initialize_constant_('dart',Type,Name,Value) --> ("final",ws_,Type,ws_,Name,ws,"=",!,ws,Value).
initialize_constant_('c',Type,Name,Value) --> ("static",ws_,"const",ws_,Name,ws,"=",!,ws,Value).
initialize_constant_(erlang,_,A,B) --> A,ws,"=",ws,B.
initialize_constant_(minizinc,_,A,B) -->
	(Type,ws,":",ws,Name,ws,"=",ws,Value).

initialize_constant_(minizinc,Type,Name) --> (Type,ws,":",ws,Name).
initialize_constant_('c',Type,Name) --> ("static",ws_,"const",ws_,Name).
initialize_constant_('javascript',Type,Name) --> ("const",ws_,Name).
initialize_constant_('typescript',Type,Name) --> ("const",ws_,Name).
initialize_constant_('php',Type,Name) --> ("const",ws_,Name).
initialize_constant_('dart',Type,Name) --> ("const",ws_,Name).
initialize_constant_('go',Type,Name) --> ("const",ws_,Name).
initialize_constant_('perl 6',Type,Name) -->  ("constant",ws_,Type,ws_,Name).
initialize_constant_('typescript',Type,Name) --> "const",ws_,Name,ws,":",ws,Type.
initialize_constant_('java',Type,Name) --> ("final",ws_,Type,ws_,Name).
initialize_constant_('c#',Type,Name) --> ("final",ws_,Type,ws_,Name).

assert_(python,A) --> "assert",python_ws,"(",!,python_ws,A,python_ws,")",!.
assert_(coffeescript,A) --> "assert",python_ws,"(",!,python_ws,A,python_ws,")",!.
assert_(javascript,A) --> "assert",ws,"(",!,ws,A,ws,")",!.
assert_(typescript,A) --> "assert",ws,"(",!,ws,A,ws,")",!.
assert_('c++',A) --> "assert",ws,"(",!,ws,A,ws,")",!.
assert_(lua,A) --> "assert",ws,"(",!,ws,A,ws,")",!.
assert_(swift,A) --> "assert",ws,"(",!,ws,A,ws,")",!.
assert_(php,A) --> "assert",ws,"(",!,ws,A,ws,")",!.
assert_(scala,A) --> "assert",ws,"(",!,ws,A,ws,")",!.
assert_(ceylon,A) --> "assert",ws,"(",!,ws,A,ws,")",!.

return_(coffeescript,_,A) --> return_(python,A).
return_(prolog,_,A) --> "Return",ws,"=",ws,A.
return_(python,_,A) --> "return",python_ws_,A.
return(sympy,_,A) --> return_(python,_,A).
return_(cython,_,A) --> "return",python_ws_,A.
return_(sympy,_,A) --> "return",python_ws_,A.
return_(c,_,A) --> "return",ws_,A.
return_(java,_,A) --> return_(c,_,A).
return_(erlang,_,A) --> A.
return_(php,_,A) --> return_(c,_,A).
return_(perl,_,A) --> return_(c,_,A).
return_('c++',_,A) --> return_(c,_,A).
return_(swift,_,A) --> return_(c,_,A).
return_('c#',_,A) --> return_(c,_,A).
return_('rust',_,A) --> return_(c,_,A).
return_(ruby,_,A) --> return_(c,_,A).
return_(lua,_,A) --> return_(c,_,A).
return_(javascript,_,A) --> return_(c,_,A).
return_(typescript,_,A) --> return_(c,_,A).
return_(haxe,_,A) --> return_(c,_,A).

initialize_var_(javascript,_,Name) --> 
	"var",ws_,Name.
initialize_var_(java,Type,Name) --> 
	Type,ws_,Name.
initialize_var_('c#',Type,Name) --> 
	Type,ws_,Name.
initialize_var_('lua',Type,Name) --> 
	"local",ws_,Name.
initialize_constant_(minizinc,Type,A,B) -->
	(Type,ws,":",ws,Name,ws,"=",ws,Value).
initialize_var_(rust,_,A,B) --> 
	("let",ws_,"mut",ws_,Name,ws,"=",!,ws,Expr).
initialize_var_(prolog,type(prolog,[array,_]),A,B) --> A,ws,"=",ws,B.
initialize_var_(prolog,type(prolog,number),A,B) --> A,ws_,"is",ws_,B.
initialize_var_(prolog,type(prolog,int),A,B) --> A,ws_,"is",ws_,B.
initialize_var_(sympy,type(sympy,Type),A,B) --> equals_(sympy,Type,A,B).
initialize_var_(python,_,A,B) --> A,python_ws,"=",python_ws,B.
initialize_var_(sympy,_,A,B) --> "Eq",python_ws,"(",A,python_ws,",",python_ws,B,python_ws,")".
initialize_var_(ruby,_,A,B) --> A,ws,"=",!,ws,B.
initialize_var_(erlang,_,A,B) --> A,ws,"=",ws,B.
initialize_var_(php,_,A,B) --> A,ws,"=",!,ws,B.
initialize_var_(swift,Type,A,B) --> initialize_var_(javascript,Type,A,B).
initialize_var_(javascript,_,A,B) --> "var",ws_,A,ws,"=",!,ws,B.
initialize_var_(haxe,Type,A,B) --> initialize_var_(javascript,Type,A,B).
initialize_var_(dart,Type,A,B) --> initialize_var_(javascript,Type,A,B).
initialize_var_(lua,_,A,B) --> "local",ws_,A,ws,"=",!,ws,B.
initialize_var_(perl,_,A,B) --> "my",ws_,A,ws,"=",!,ws,B.
initialize_var_('c++',Type,A,B) --> Type,ws_,A,ws,"=",!,ws,B.
initialize_var_('c#',Type,A,B) --> Type,ws_,A,ws,"=",!,ws,B.
initialize_var_('java',Type,A,B) --> Type,ws_,A,ws,"=",!,ws,B.
initialize_var_('c',Type,A,B) --> Type,ws_,A,ws,"=",!,ws,B.
initialize_var_('c',type(c,string),A,B) --> "char",ws_,A,"[]",ws,"=",!,ws,B.
initialize_var_('c',type(c,[array,Type]),A,B) --> type(c,Type),ws_,A,"[]",ws,"=",!,ws,B.

println_(prolog,_,A) --> ("writeln",ws,"(",!,ws,A,ws,")"),!.
println_(erlang,_,A) --> ("io",ws,":",ws,"fwrite",ws,"(",!,ws,A,ws,")").
println_(sympy,Type,A) --> println_(python,Type,A).
println_(python,_,A) -->
	"print",python_ws,"(",!,python_ws,A,python_ws,")",!.
println_(javascript,_,A) -->
	"console",ws,".",ws,"log",ws,"(",!,ws,A,ws,")",!.
println_(ruby,_,A) -->
	"puts",ws,"(",!,ws,A,ws,")",!.
println_('java',_,A) -->
	"System",ws,".",ws,"out",ws,".",ws,"println",python_ws,"(",!,python_ws,A,python_ws,")",!.
println_('c#',_,A) -->
	"Console",ws,".",ws,"WriteLn",python_ws,"(",!,python_ws,A,python_ws,")",!.
println_(dart,_,A) --> println_(lua,_,A).
println_(perl,_,A) --> println_(lua,_,A).
println_(lua,_,A) -->
	"print",ws,"(",!,ws,A,ws,")",!.
println_(haxe,_,A) -->
	println_(lua,_,A).
println_(swift_,A) --> println_(lua,_,A).
println_(c,int,A) -->
	"printf",ws,"(",!,ws,"\"%d\"",ws,",",!,ws,A,ws,")",!.
println_(c,string,A) -->
	"printf",ws,"(",!,ws,"\"%s\"",ws,",",!,ws,A,ws,")".
println_(php,_,A) -->
	"echo",ws,"(",!,ws,A,ws,")".
println_('c++',_,A) -->
	"cout",ws,"<<",ws,A,ws,"<<",ws,"endl".
println_('c',number,A) -->
	"printf",ws,"(",!,ws,"\"%.6f\"",ws,",",!,ws,A,ws,")".
println_('rust',_,A) -->
	("println!(",ws,A,ws,")").

substring_(python,Str,A,B) -->
	Str,python_ws,"[",python_ws,A,":",python_ws,B,python_ws,"]",!.
substring_(Lang,A,B,C) -->
	{memberchk(Lang,['javascript','coffeescript','typescript','java','scala','dart'])},
	(A,ws,".",ws,"substring",ws,"(",!,ws,B,ws,",",!,ws,C,ws,")"),!.
substring_(haxe,A,B,C) -->
	(A,ws,".",ws,"substr",ws,"(",!,ws,B,ws,",",!,ws,C,ws,")"),!.
substring_('c#',A,B,C) -->	
	(A,ws,".",ws,"Substring",ws,"(",!,ws,B,ws,",",!,ws,C,ws,")"),!.
substring_(Lang,A,B,C) -->
	{memberchk(Lang,['php','awk','perl','hack'])},
	("substr",ws,"(",!,ws,A,ws,",",!,ws,B,ws,",",!,ws,C,ws,")"),!.
substring_(lua,A,B,C) -->
	("string.sub",ws,"(",!,ws,A,ws,",",!,ws,B,ws,"+",ws,"1",ws,",",!,ws,C,ws,"+",ws,"1",ws,")"),!.
substring_('c++',A,B,C) -->
	(A,ws,".",ws,"substring",ws,"(",!,ws,B,ws,",",!,ws,C,ws,"-",ws,B,ws,")"),!.
set_array_size_('c#',Type,Name,Size) -->
	set_array_size_(java,Type,Name,Size).
set_array_size_('go',Type,Name,Size) -->	
	("var",ws_,Name,ws_,"[",ws,Size,ws,"]",ws,Type).

set_array_size_(java,Type,Name,Size) -->
	(Type,ws,"[]",ws_,Name,ws,"=",ws,"new",ws_,Type,ws,"[",ws,Size,ws,"]").

set_array_size_(c,Type,Name,Size) -->
	%{member(Lang,['c','c++'])},
	(Type,ws_,Name,ws,"[",ws,Size,ws,"]").

set_array_size_(minizinc,Type,Name,Size) -->
	("array",ws,"[",ws,"1",ws,"..",ws,Size,ws,"]",ws_,"of",ws_,Type,ws,":",ws,Name,ws,";").

this_(perl,A) -->
	("$self",ws,"->",ws,A).
this_('ruby',A) -->
	("@",A).
this_(php,A) -->
	("$",ws,"this",ws,"->",ws,A).
this_(python,A) -->
	("self",python_ws,".",python_ws,A).
this_(php,A) -->
	("$",ws,"this",ws,"->",ws,A).
this_(javascript,A) -->
	%{member(Lang,['java','engscript','dart','groovy','typescript','javascript','c#','c++','haxe','chapel','julia'])},
	("this",python_ws,".",python_ws,A).

class_('perl',Indent,Name,Body) -->
	("package",ws_,Name,";",ws,Body).
class_('ruby',Indent,Name,Body) -->
	("class",ws_,Name,ws_,Body,(Indent;ws_),"end").
class_('c#',Indent,Name,Body) -->
	class_(java,Indent,Name,Body).
class_('c++',Indent,Name,Body) -->
	("class",ws_,Name,ws,"{",!,ws,Body,(Indent;ws),"}",ws,";"),!.
class_(java,Indent,Name,Body) -->
	("public",ws_,"class",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}"),!.
class_(python,Indent,Name,Body) -->
	("class",python_ws_,Name,":",Body).
class_(Lang,Indent,Name,Body) -->
	{memberchk(Lang,['javascript','hack','php','scala','haxe','chapel','swift','d','typescript','dart','perl 6'])},
	("class",ws_,Name,ws,"{",!,ws,Body,(Indent;ws),"}"),!.

instance_method_('haxe',Name,Type,Params,Body,Indent) -->
	("public",ws_,"function",ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,":",ws,Type,ws,"{",!,ws,Body,(Indent;ws),"}"),!.
instance_method_('perl',Name,Type,Params,Body,Indent) -->
	("sub",ws_,Name,ws,"{",ws,"my",ws,"(",Params,")",!,ws,"=@_",ws,";",ws,Body,(Indent;ws),"}"),!.
instance_method_('ruby',Name,Type,Params,Body,Indent) -->
	("def",ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws_,Body,(Indent;ws_),"end").
instance_method_(php,Name,Type,Params,Body,Indent) -->
	("public",ws_,"function",ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.
instance_method_(python,Name,Type,Params,Body,Indent) -->
	("def",python_ws_,Name,"(",!,python_ws,"self",python_ws,",",Params,")",":",python_ws,Body).
instance_method_('c#',Name,Type,Params,Body,Indent) -->
	instance_method_(java,Name,Type,Params,Body,Indent).
instance_method_(java,Name,Type,Params,Body,Indent) -->
	("public",ws_,Type,ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.
instance_method_(javascript,Name,Type,Params,Body,Indent) -->
	(Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.
instance_method_(javascript,Name,Type,Params,Body,Indent) -->
	{memberchk(Lang,['c++','d','dart'])},
    (Type,ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.

static_method_(haxe,Name,Type,Params,Body,Indent) -->
	("public",ws_,"static",ws_,"function",ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.
static_method_(perl,Name,Type,Params,Body,Indent) -->
	("sub",ws_,Name,ws,"{",ws,"my",ws,"(",Params,")",ws,"=@_",ws,";",ws,Body,(Indent;ws),"}"),!.
static_method_(ruby,Name,Type,Params,Body,Indent) -->
	("def",ws_,"self.",Name,ws,"(",!,ws,Params,ws,")",!,ws_,Body,(Indent;ws_),"end").
static_method_(php,Name,Type,Params,Body,Indent) -->
	("public",ws_,"static",ws_,"function",ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.
static_method_(javascript,Name,Type,Params,Body,Indent) -->
	("static",ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.
static_method_('c#',Name,Type,Params,Body,Indent) --> static_method_(java,Name,Type,Params,Body,Indent).
static_method_(java,Name,Type,Params,Body,Indent) -->
	("public",ws_,"static",ws_,Type,ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.
static_method_(python,Name,Type,Params,Body,Indent) -->
	("@staticmethod",Indent,"def",python_ws_,Name,python_ws,"(",!,python_ws,Params,python_ws,")",":",python_ws,Body).
static_method_(Lang,Name,Type,Params,Body,Indent) -->
	{memberchk(Lang,['c++','d','dart'])},
	("static",ws_,Type,ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.

constructor_(haxe,Name,Params,Body,Indent) -->
	("public",ws_,"function",ws_,"new",ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.
constructor_(perl,Name,Params,Body,Indent) -->
	("sub",ws_,"new",ws,"{",ws,"my($class,",Params,") = @_;my $s = {};bless $s, $class;",Body,"return $s;",(Indent;ws),"}"),!.
constructor_(ruby,Name,Params,Body,Indent) -->
	("def",ws_,"initialize",ws,"(",!,ws,Params,ws,")",!,ws_,Body,(Indent;ws_),"end").
constructor_(php,Name,Params,Body,Indent) -->
	("function",ws_,"__construct",ws,"(",!,ws,Params,ws,")",!,ws,"{",ws,Body,(Indent;ws),"}"),!.
constructor_(d,Name,Params,Body,Indent) -->
	%{member(Lang,['d','c++'])},
	(Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",!,ws,Body,(Indent;ws),"}"),!.
constructor_(java,Name,Params,Body,Indent) -->
	%{member(Lang,['java','c#','vala'])},
	("public",ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",!,ws,Body,(Indent;ws),"}"),!.
constructor_(javascript,Name,Params,Body,Indent) -->
	("constructor",ws,"(",!,ws,Params,ws,")",!,ws,"{",!,ws,Body,(Indent;ws),"}"),!.
constructor_(python,Name,Params,Body,Indent) -->
	("def",python_ws_,"__init__",python_ws,"(",!,python_ws,"self",python_ws,",",python_ws,Params,python_ws,")",":",!,python_ws,Body).

strip_(Lang,Str) -->
	{memberchk(Lang,[java,javascript])},
	(Str,ws,".",ws,"trim",ws,"(",!,ws,")"),!.

strip_(python,Str) -->
	(Str,python_ws,".",python_ws,"strip",python_ws,"(",!,python_ws,")").

lstrip_(python,Str) -->
	(Str,python_ws,".",python_ws,"lstrip",python_ws,"(",!,python_ws,")").
lstrip_('ruby',Str) -->
	(Str,ws,".",ws,"lstrip").
lstrip_('java',Str) -->
	Str,".replaceAll(\"^\\s+\", \"\")".
lstrip_('javascript',Str) -->
	(Str,ws,".replace(/^\s+/,'')").
lstrip_('php',Str) -->
	("ltrim",ws,"(",!,ws,Str,ws,")").
lstrip_('c#',Str) -->
	(Str,ws,".",ws,"TrimStart",ws,"(",!,ws,")").

rstrip_('php',Str) -->
	("rtrim",ws,"(",!,ws,Str,ws,")").
rstrip_('java',Str) -->
	(Str,ws,".replaceAll(\"\\s+$\",\"\")").
rstrip_(python,Str) -->
	(Str,python_ws,".",python_ws,"rstrip",python_ws,"(",!,python_ws,")",!).
rstrip_(javascript,Str) -->
	(Str,ws,".replace(/\s+$/,'')").
rstrip_('c#',Str) -->
	(Str,ws,".",ws,"TrimEnd",ws,"(",!,ws,")").
rstrip_('ruby',Str) -->
	(Str,ws,".",ws,"rstrip").

type_conversion_(javascript,number,string,A) --> "toString",ws,"(",!,ws,A,ws,")",!.
type_conversion_(python,_,To,A) --> type(python,To),python_ws,"(",!,python_ws,A,python_ws,")",!.
type_conversion_(swift,_,To,A) --> type(swift,To),ws,"(",!,ws,A,ws,")",!.
type_conversion_(python,_,To,A) --> type(python,To),ws,"(",!,ws,A,ws,")",!.
type_conversion_(ruby,string,int,A) --> A,ws,".",ws,"to_i".
type_conversion_(ruby,int,string,A) --> A,ws,".",ws,"to_s".
type_conversion_('c++',int,string,Arg) -->
	("std::to_string",ws,"(",!,ws,Arg,ws,")").
type_conversion_(ruby,number,string,A) --> A,ws,".",ws,"to_s".
type_conversion_('c#',_,string,A) --> "Convert",ws,".",ws,"ToString",ws,"(",!,ws,A,ws,")",!.
type_conversion_('c#',_,int,A) --> "Convert",ws,".",ws,"ToInt32",ws,"(",!,ws,A,ws,")",!.
type_conversion_('java',string,int,A) --> "Integer",ws,".",ws,"parseInt",ws,"(",!,ws,A,ws,")",!.
type_conversion_('java',string,number,A) --> "Double",ws,".",ws,"parseDouble",ws,"(",!,ws,A,ws,")",!.
type_conversion_('java',int,string,A) -->
	"Integer",ws,".",ws,"toString",ws,"(",!,ws,A,ws,")";
	"String",ws,".",ws,"valueOf",ws,"(",!,ws,A,ws,")",!.
type_conversion_('lua',number,string,A) -->
	"tostring",ws,"(",!,ws,A,ws,")",!.
type_conversion_('lua',int,string,A) -->
	"tostring",ws,"(",!,ws,A,ws,")",!.
type_conversion_('java',int,double,A) -->
	"(double)",A.
type_conversion_('c',int,double,A) -->
	"(double)",A.
type_conversion_('java',number,string,A) -->
	"Double",ws,".",ws,"toString",ws,"(",!,ws,A,ws,")";
	"String",ws,".",ws,"valueOf",ws,"(",!,ws,A,ws,")".
type_conversion_('javascript',string,int,A) --> ("parseInt",ws,"(",!,ws,A,ws,")").
type_conversion_('javascript',string,number,A) --> ("Number",ws,"(",!,ws,A,ws,")").
type_conversion_('lua',string,number,A) --> ("tonumber",ws,"(",!,ws,A,ws,")").
type_conversion_('lua',string,int,A) --> ("tonumber",ws,"(",!,ws,A,ws,")").
type_conversion_('perl',string,number,A) --> A.
type_conversion_('perl',number,string,A) --> A.
type_conversion_(c,string,int,A) -->
	"(",ws,"int",ws,")",ws_,"strtol",ws,"(",ws,A,ws,",",ws,"(",ws,"char",ws_,"**",ws,")",ws,"NULL,",ws,"10",ws,")";
	"atoi",ws,"(",!,ws,A,ws,")".

pow_(lua,A,B) -->
	"(",ws,A,ws,")",ws,"^",!,ws,"(",ws,B,ws,")".
pow_(python,A,B) -->
	"(",python_ws,A,python_ws,")",python_ws,"**",python_ws,"(",python_ws,B,python_ws,")".
pow_(ruby,A,B) --> pow_(python,A,B).
pow_('c#',A,B) -->
	("Math",ws,".",ws,"Pow",ws,"(",!,ws,A,ws,",",!,ws,B,ws,")"),!.
pow_(javascript,A,B) --> pow_(java,A,B).
pow_(java,A,B) -->
	("Math",ws,".",ws,"pow",ws,"(",!,ws,A,ws,",",!,ws,B,ws,")"),!.
pow_(haxe,A,B) -->pow_(java,A,B).
pow_(erlang,A,B) --> 
	("math",ws,":",ws,"pow",ws,"(",!,ws,A,ws,",",!,ws,B,ws,")"),!.
pow_(c,A,B) --> 
	"pow",ws,"(",!,ws,A,ws,",",!,ws,B,ws,")",!.
pow_('c++',A,B) --> pow_(c,A,B).
pow_('perl',A,B) --> pow_(c,A,B).
pow_(php,A,B) --> pow_(c,A,B).

abs_(prolog,Type,A) --> abs_(python,Type,A).
abs_(erlang,Type,A) --> abs_(python,Type,A).
abs_(c,int,A) --> abs_(python,Type,A).
abs_(php,Type,A) --> abs_(python,Type,A).
abs_(c,number,A) --> "fabs",ws,"(",!,ws,A,ws,")",!.
abs_('c++',Type,A) --> abs_(python,Type,A).
abs_(perl,Type,A) --> abs_(python,Type,A).
abs_(python,_,A) -->
	"abs",python_ws,"(",!,python_ws,A,python_ws,")",!.
abs_(javascript,Type,A) --> abs_(java,Type,A).
abs_(java,_,A) -->
	"Math",ws,".",ws,"abs",ws,"(",!,ws,A,ws,")",!.
abs_('c#',_,A) -->
	"Math",ws,".",ws,"Abs",ws,"(",!,ws,A,ws,")",!.
abs_('f#',_,A) --> abs_('c#',A).
abs_(ruby,_,A) --> A,".abs".

sin_('c#',A) -->
	"Math",ws,".",ws,"Sin",ws,"(",!,ws,A,ws,")",!.
sin_(ruby,A) --> sin_(java,A).
sin_(javascript,A) --> sin_(java,A).
sin_(haxe,A) --> sin_(java,A).
sin_(java,A) -->
	"Math",ws,".",ws,"sin",ws,"(",!,ws,A,ws,")",!.
sin_(perl,A) -->
	sin_(c,A). 
sin_(php,A) -->
	sin_(c,A). 
sin_('c++',A) -->
	sin_(c,A).
sin_(c,A) -->
	"sin",ws,"(",!,ws,A,ws,")",!.
sin_(lua,A) --> sin_(python,A).
sin_(python,A) -->
	"math",ws,".",ws,"sin",ws,"(",!,ws,A,ws,")",!.

asin_('c++',A) --> asin_(c,A).
asin_(perl,A) --> asin_(c,A).
asin_(php,A) --> asin_(c,A).
asin_(c,A) -->
	"asin",ws,"(",!,ws,A,ws,")",!.
asin_('ruby',A) -->
	asin_('java',A).
asin_('javascript',A) -->
	asin_('java',A).
asin_('java',A) -->
	"Math",ws,".",ws,"asin",ws,"(",!,ws,A,ws,")",!.
asin_('haxe',A) -->
	asin_('java',A).
asin_('c#',A) -->
	"Math",ws,".",ws,"Asin",ws,"(",!,ws,A,ws,")",!.
asin_(lua,A) --> asin_(python,A).
asin_(python,A) -->
	"math",python_ws,".",python_ws,"asin",python_ws,"(",!,python_ws,A,python_ws,")",!.


acos_(python,A) -->
	"math",python_ws,".",python_ws,"acos",python_ws,"(",!,python_ws,A,python_ws,")",!.
acos_(perl,A) --> acos_(c,A).
acos_(php,A) --> acos_(c,A).
acos_('c++',A) --> acos_(c,A).
acos_(c,A) -->
	"acos",ws,"(",!,ws,A,ws,")",!.
acos_(lua,A) --> acos_(python,A).
acos_(python,A) -->
	"math",python_ws,".",python_ws,"acos",python_ws,"(",!,python_ws,A,python_ws,")",!.
acos_('c#',A) -->
	"Math",ws,".",ws,"Acos",ws,"(",!,ws,A,ws,")",!.
acos_(ruby,A) --> acos_(java,A),!.
acos_(javascript,A) --> acos_(java,A),!.
acos_(java,A) -->
	"Math",ws,".",ws,"acos",ws,"(",!,ws,A,ws,")",!.
acos_(haxe,A) --> acos_(java,A).


sqrt_(python,A) -->
	"math",python_ws,".",python_ws,"sqrt",python_ws,"(",!,python_ws,A,python_ws,")",!.
sqrt_(c,A) -->
	"sqrt",ws,"(",!,ws,A,ws,")",!.
	%{memberchk(Lang,['c','c++','seed7','julia','perl','php','perl 6','maxima','minizinc','prolog','octave','d','haskell','swift','mathematical notation','dart','picat'])},
sqrt_('c++',A) --> sqrt_(c,A).
sqrt_('perl',A) --> sqrt_(c,A).
sqrt_('php',A) --> sqrt_(c,A).
sqrt_('swift',A) --> sqrt_(c,A).
sqrt_('prolog',A) --> sqrt_(c,A).
sqrt_('octave',A) --> sqrt_(c,A).
sqrt_('d',A) --> sqrt_(c,A).
sqrt_(lua,A) -->
	"math",ws,".",ws,"sqrt",ws,"(",!,ws,A,ws,")",!.
sqrt_(go,A) -->
	"math",ws,".",ws,"Sqrt",ws,"(",!,ws,A,ws,")",!.
sqrt_(javascript,A) --> sqrt_(java,A),!.
sqrt_(haxe,A) --> sqrt_(java,A),!.
sqrt_(ruby,A) --> sqrt_(java,A),!.
sqrt_(java,A) -->
	"Math",ws,".",ws,"sqrt",ws,"(",!,ws,A,ws,")",!.
sqrt_('c#',A) -->
	("Math",ws,".",ws,"Sqrt",ws,"(",!,ws,A,ws,")").

asin_(haxe,A) --> asin_(java,A).	
asin_(ruby,A) --> asin_(java,A).
asin_(javascript,A) --> asin_(java,A).
asin_(java,A) -->
	"Math",ws,".",ws,"asin",ws,"(",!,ws,A,ws,")",!.
asin_(c,A) -->
	"asin",ws,"(",!,ws,A,ws,")",!.
asin_(php,A) --> asin_(c,A).
asin_(perl,A) --> asin_(c,A).


cos_(ruby,A) --> cos_(java,A).
cos_(haxe,A) --> cos_(java,A).
cos_(javascript,A) --> cos_(java,A).
cos_('c#',A) -->
	"Math",ws,".",ws,"Cos",ws,"(",!,ws,A,ws,")",!.
cos_(java,A) -->
	"Math",ws,".",ws,"cos",ws,"(",!,ws,A,ws,")",!.
cos_(c,A) -->
	"cos",ws,"(",!,ws,A,ws,")",!.
cos_(lua,A) --> cos_(python,A).
cos_(python,A) -->
	"math",python_ws,".",python_ws,"cos",python_ws,"(",!,python_ws,A,python_ws,")",!.
cos_(php,A) -->
	cos_(c,A).
cos_(perl,A) -->
	cos_(c,A).
cos_('c++',A) -->
	cos_(c,A).
	
tan_(ruby,A) --> tan_(java,A),!.
tan_(javascript,A) --> tan_(java,A),!.
tan_('perl',A) --> tan_('c',A),!.
tan_('php',A) --> tan_('c',A),!.
tan_('c',A) -->
	"tan",ws,"(",!,ws,A,ws,")",!.
tan_('c#',A) -->
	"Math",ws,".",ws,"Tan",ws,"(",!,ws,A,ws,")",!.
tan_(lua,A) --> tan_(python,A).
tan_(python,A) -->
	"math",python_ws,".",python_ws,"tan",python_ws,"(",!,python_ws,A,python_ws,")",!.
tan_(java,A) -->
	"Math",ws,".",ws,"tan",ws,"(",!,ws,A,ws,")",!.
tan_(haxe,A) --> tan_(java,A).

atan_('c#',A) -->
	"Math",ws,".",ws,"Atan",!,ws,"(",!,ws,A,ws,")",!.
atan_(ruby,A) --> atan_(java,A),!.
atan_(javascript,A) --> atan_(java,A),!.
atan_(java,A) -->
	"Math",ws,".",ws,"atan",ws,"(",!,ws,A,ws,")",!.
atan_(javascript,A) --> atan_(java,A),!.
atan_('c++',A) --> atan_(c,A),!.
atan_(php,A) --> atan_(c,A),!.
atan_(perl,A) --> atan_(c,A),!.
atan_(c,A) -->
	"atan",ws,"(",!,ws,A,ws,")",!.	
atan_(lua,A) --> atan_(python,A),!.
atan_(python,A) -->
	"math",python_ws,".",python_ws,"atan",python_ws,"(",!,python_ws,A,python_ws,")",!.
atan_(haxe,A) --> atan_(java,A),!.


initializer_list_(python,_,A) --> "[",python_ws,A,python_ws,"]",!.
initializer_list_(javascript,_,A) --> "[",ws,!,A,ws,"]",!.
initializer_list_(ruby,_,A) --> "[",!,ws,A,ws,"]",!.
initializer_list_(prolog,_,A) --> "[",!,ws,A,ws,"]",!.
initializer_list_(haxe,_,A) --> "[",!,ws,A,ws,"]",!.
initializer_list_(swift,_,A) --> "[",!,ws,A,ws,"]",!.
initializer_list_('c#',_,A) --> "{",!,ws,A,ws,"}",!.
initializer_list_('c++',_,A) --> "{",ws,A,ws,"}".
initializer_list_('c',_,A) --> "{",ws,A,ws,"}".
initializer_list_('lua',_,A) --> "{",ws,A,ws,"}".
initializer_list_(java,Type,A) --> "new",ws_,Type,ws,"[]",ws,"{",python_ws,A,python_ws,"}".
initializer_list_(perl,_,A) --> "(",!,python_ws,A,python_ws,")".
initializer_list_(php,_,A) --> ("array",ws,"(",ws,A,ws,")";"[",ws,A,ws,"]").

%this is valid for strings and arrays in Rust.
length_(rust,_,A) -->
	(A,ws,".",ws,"len",ws,"(",!,ws,")").
	
length_(lua,string,A) --> "string",ws,".",ws,"len",ws,"(",!,ws,A,ws,")",!.
length_(lua,[array,_],A) --> "#",A.

length_(python,_,A) --> "len",python_ws,"(",!,python_ws,A,python_ws,")",!.
length_(javascript,_,A) --> A,".",ws,"length".
length_(perl,[array,_],A) --> ("scalar",ws,"(",ws,A,ws,")").
length_(ruby,_,A) --> A,".",ws,("size";"length").
length_(java,[array,_],A) --> A,".",ws,"length".
length_(java,string,A) --> A,".",ws,"length",ws,"(",ws,")",!.
length_(c,string,A) --> "strlen",ws,"(",!,ws,A,ws,")",!.
length_(php,[array,_],A) --> "sizeof",ws,"(",!,ws,A,ws,")",!.
length_(php,string,A) --> length_(c,string,A).
length_(swift,[array,_],A) --> A,ws,".",ws,"count".
length_(c,[array,_],A) --> ("sizeof",ws,"(",ws,A,ws,")",ws,"/",ws,"sizeof",ws,"(",ws,A,ws,"[",ws,"0",ws,"]",ws,")").

%this is valid for strings and arrays in C#
length_('c#',_,A) -->
	A,ws,".",ws,"Length".

not_equals_(c,string,A,B) --> "(",ws,"strcmp",ws,"(",ws,A,ws,",",ws,B,ws,")",ws,"!=",ws,"0",ws,")",!.
not_equals_(python,_,A,B) --> A,python_ws,"!=",!,python_ws,B.
not_equals_(ruby,_,A,B) --> A,ws,"!=",!,ws,B.
not_equals_(c,number,A,B) --> A,ws,"!=",!,ws,B.
not_equals_(perl,number,A,B) --> A,ws,"!=",!,ws,B.
not_equals_('c++',string,A,B) --> A,ws,"!=",!,ws,B.
not_equals_('c#',string,A,B) --> A,ws,"!=",!,ws,B.
not_equals_(lua,Type,A,B) --> {member(Type,[int,number,string,bool])},A,ws,"~=",ws,B.
not_equals_(perl,string,A,B) --> A,ws_,"ne",ws_,B.
not_equals_(javascript,_,A,B) -->
	A,ws,"!==",!,
	%{writeln(['calling not_equals_',A])},
	ws,B.	
not_equals_(php,Type,A,B) --> A,ws,"!==",!,ws,B,{member(Type,[string,number,int,char])}.
not_equals_(c,string,A,B) -->	"(",ws,"strcmp",ws,"(",ws,A,ws,",",ws,B,ws,")",ws,"!=",ws,"0",ws,")",!.
not_equals_(java,char,A,B) --> not_equals_(c,number,A,B).
not_equals_(java,number,A,B) --> not_equals_(c,number,A,B).
not_equals_(java,string,A,B) --> "!",ws,equals_(java,string,A,B).
not_equals_('c++',number,A,B) --> not_equals_(c,number,A,B).
not_equals_(java,number,A,B) --> not_equals_(c,int,A,B).
not_equals_('c#',number,A,B) --> not_equals_(c,int,A,B).
not_equals_('haxe',Type,A,B) --> {member(Type,[int,number,string,bool])},not_equals_(c,int,A,B).
not_equals_(Lang,int,A,B) --> not_equals_(Lang,number,A,B).

equals_('c#',[array,_],A,B) --> A,ws,".",ws,"SequenceEqual",ws,"(",!,ws,B,ws,")",!.
equals_(java,[array,_],A,B) --> "Arrays",ws,".",ws,"equals",ws,"(",!,ws,A,ws,",",!,ws,B,ws,")",!.
equals_(erlang,_,A,B) --> A,ws,"===",ws,B.
equals_(python,_,A,B) --> A,python_ws,"==",python_ws,B.
equals_(sympy,_,A,B) --> "Eq",python_ws,"(",A,python_ws,",",python_ws,B,python_ws,")",!.
equals_(javascript,Type,A,B) --> A,ws,"===",!,ws,B.
equals_(php,Type,A,B) --> {member(Type,[bool,number,int,string,char,[array,_]])},A,ws,"===",!,ws,B.
equals_(c,Type,A,B) --> {member(Type,[bool,number,int,char])},A,ws,"==",!,ws,B.
equals_(c,string,A,B) --> "(",ws,"strcmp",ws,"(",ws,A,ws,",",ws,B,ws,")",ws,"==",!,ws,"0",ws,")",!.
equals_(sympy,A,B) -->	"Eq",python_ws,"(",!,python_ws,A,python_ws,",",python_ws,B,python_ws,")",!.
equals_(java,bool,A,B) --> A,ws,"==",!,ws,B.
equals_(java,number,A,B) --> A,ws,"==",!,ws,B.
equals_(java,char,A,B) --> A,ws,"==",!,ws,B.
equals_(java,string,A,B) --> A,ws,".",ws,"equals",ws,"(",!,ws,B,ws,")",!.
equals_('c#',number,A,B) --> A,ws,"==",!,ws,B.
equals_('c#',string,A,B) --> A,ws,"==",!,ws,B.
equals_('c++',string,A,B) --> A,ws,"==",!,ws,B.
equals_('haxe',string,A,B) --> A,ws,"==",!,ws,B.
equals_(lua,number,A,B) --> A,python_ws,"==",!,python_ws,B.
equals_(lua,bool,A,B) --> A,ws,"==",!,ws,B.
equals_(lua,string,A,B) --> A,ws,"==",!,ws,B.
equals_(lua,char,A,B) --> A,ws,"==",!,ws,B.
equals_(ruby,_,A,B) --> A,ws,"==",ws,B.
equals_(perl,string,A,B) --> A,ws_,"eq",ws_,B.
equals_(Lang,int,A,B) --> equals_(Lang,number,A,B).

access_array_(Lang,Array,Index) --> access_array_(Lang,_,Array,Index).

%this works with strings and arrays in php, python, 'c#', and c
access_array_('ruby',_,Array,Index) --> access_array_(c,Array,Index).
access_array_('php',_,Array,Index) --> access_array_(c,Array,Index).
access_array_('python',_,Array,Index) --> access_array_(c,Array,Index).
access_array_('c',_,Array,Index) --> Array,ws,"[",!,ws,Index,ws,"]",!.
access_array_('c#',_,Array,Index) --> access_array_(c,Array,Index).
access_array_('lua',_,Array,Index) --> Array,ws,"[",ws,Index,ws,"+",ws,"1",ws,"]",!.

access_array_('minizinc',[array,_],Array,Index) --> access_array_(c,Array,Index).
access_array_('perl',[array,_],Array,Index) --> access_array_(c,Array,Index).
access_array_('dart',[array,_],Array,Index) --> access_array_(c,Array,Index).
access_array_('ruby',[array,_],Array,Index) --> access_array_(c,Array,Index).
access_array_('c++',[array,_],Array,Index) --> access_array_(c,Array,Index).
access_array_('javascript',string,Array,Index) --> Array,ws,".",ws,"charAt",ws,"(",!,ws,Index,ws,")",!.
access_array_('javascript',_,Array,Index) --> access_array_(c,Array,Index).
access_array_('haxe',[array,_],Array,Index) --> access_array_(c,Array,Index).
access_array_('c++',[array,_],Array,Index) --> access_array_(c,Array,Index).
access_array_('java',string,Array,Index) --> Array,ws,".",ws,"charAt",ws,"(",!,ws,Index,ws,")",!.
access_array_('java',[array,_],Array,Index) --> access_array_(c,Array,Index).


set_array_index(ruby,A,B,C) --> set_array_index(python,A,B,C).
set_array_index(lua,A,B,C) --> set_array_index(python,A,B,C).
set_array_index('perl',A,B,C) --> set_array_index(python,A,B,C).
set_array_index('c#',A,B,C) --> set_array_index(python,A,B,C).
set_array_index('c++',A,B,C) --> set_array_index(python,A,B,C).
set_array_index(java,A,B,C) --> set_array_index(python,A,B,C).
set_array_index(python,A,B,C) -->
	A,python_ws,"[",python_ws,B,python_ws,"]",python_ws,"=",python_ws,C.

or_(python,A,B) --> A,python_ws_,"or",python_ws_,B.
or_(ruby,A,B) --> A,python_ws_,"or",python_ws_,B.
or_(lua,A,B) --> A,python_ws_,"or",python_ws_,B.
or_(c,A,B) --> A,ws,"||",!,{writeln('calling or_')},ws,B.
or_(prolog,A,B) --> A,python_ws,";",!,python_ws,B.
or_('haxe',A,B) --> or_(c,A,B).
or_(java,A,B) --> or_(c,A,B).
or_('c#',A,B) --> or_(c,A,B).
or_('c++',A,B) --> or_(c,A,B).
or_(javascript,A,B) --> or_(c,A,B).
or_(perl,A,B) --> or_(c,A,B).
or_(php,A,B) --> or_(c,A,B).


and_(c,A,B) --> A,ws,"&&",!,{writeln('calling and_')},ws,B.
and_(java,A,B) --> and_(c,A,B).
and_(javascript,A,B) --> and_(c,A,B).
and_(haxe,A,B) --> and_(c,A,B).
and_('c++',A,B) --> and_(c,A,B).
and_('php',A,B) --> and_(c,A,B).
and_('perl',A,B) --> and_(c,A,B).
and_('c#',A,B) --> and_(c,A,B).
and_(ruby,A,B) --> A,python_ws_,"and",python_ws_,B.
and_(lua,A,B) --> A,python_ws_,"and",python_ws_,B.
and_(python,A,B) --> A,python_ws_,"and",python_ws_,B.

add_(php,[array,_],A,B) -->
	("array_merge",ws,"(",!,ws,A,ws,",",!,ws,B,ws,")").
add_(python,_,A,B) -->
	A,python_ws,"+",python_ws,B.
add_('javascript',Type,A,B) -->
	%{dif(Type,[array,_])},
	A,ws,"+",!,ws,B.
add_('prolog',number,A,B) -->
	A,ws,"+",!,ws,B.
add_('minizinc',number,A,B) -->
	A,ws,"+",!,ws,B.
add_('rust',number,A,B) -->
	A,ws,"+",!,ws,B.
add_('c++',Type,A,B) -->
	{member(Type,[string,number])},A,ws,"+",!,ws,B.
add_('java',Type,A,B) -->
	{member(Type,[string,number])},A,ws,"+",!,ws,B.
add_('c#',Type,A,B) -->
	{member(Type,[string,number])},A,ws,"+",!,ws,B.
add_('perl',number,A,B) -->
	A,ws,"+",!,ws,B.
add_('perl',string,A,B) -->
	A,ws,".",ws,B.
add_('php',string,A,B) -->
	A,ws,".",ws,B.
add_('php',number,A,B) -->
	A,ws,"+",!,ws,B.
add_('ruby',Type,A,B) -->
	%{member(Type,[string,number])},
	A,ws,!,"+",ws,B.
add_('haskell',string,A,B) -->
	A,ws,"++",ws,B.
add_('haskell',number,A,B) -->
	A,ws,"+",ws,B.
add_('lua',string,A,B) -->
	A,ws,"..",!,ws,B.
add_('lua',number,A,B) -->
	A,ws,"+",!,ws,B.
add_('haxe',Type,A,B) -->
	%{member(Type,[string,number])},
	A,ws,"+",!,ws,B.
add_('c',number,A,B) -->
	A,ws,"+",!,ws,B.
add_('erlang',number,A,B) -->
	A,ws,"+",!,ws,B.
add_(Lang,int,A,B) -->
	add_(Lang,number,A,B).
	
else_(python,Indent,B) -->
	"else:",!,python_ws,B,(Indent;ws).
else_(perl,Indent,B) --> else_(c,Indent,B).
else_(php,Indent,B) --> else_(c,Indent,B).
else_('c++',Indent,B) --> else_(c,Indent,B).
else_(haxe,Indent,B) --> else_(c,Indent,B).
else_(java,Indent,B) --> else_(c,Indent,B).
else_(javascript,Indent,B) --> else_(c,Indent,B).
else_('c#',Indent,B) --> else_(c,Indent,B).
else_('d',Indent,B) --> else_(c,Indent,B).
else_(c,Indent,B) -->
	"else",ws,"{",!,ws,B,(Indent;ws),"}",!.
else_(lua,Indent,B) -->
	"else",ws_,B,(Indent;ws_),"end".
else_(ruby,Indent,B) --> else_(lua,Indent,B).

elif_(python,Indent,[A,B]) -->
	"elif",indented_block(A),!,python_ws,B.
elif_(lua,Indent,[A,B]) -->
	("elseif",ws_,A,ws_,"then",ws_,B).
elif_(ruby,Indent,[A,B]) -->
	("elsif",ws_,A,ws_,B).
elif_(java,Indent,[A,B]) --> elif_(c,Indent,[A,B]),!.
elif_(php,Indent,[A,B]) --> elif_(c,Indent,[A,B]),!.
elif_(javascript,Indent,[A,B]) --> elif_(c,Indent,[A,B]),!.
elif_('c++',Indent,[A,B]) --> elif_(c,Indent,[A,B]),!.
elif_('c#',Indent,[A,B]) --> elif_(c,Indent,[A,B]),!.
elif_('haxe',Indent,[A,B]) --> elif_(c,Indent,[A,B]),!.
elif_(c,Indent,[A,B]) -->
	"else",ws_,"if",ws,"(",!,ws,A,ws,")",!,ws,"{",!,ws,B,(Indent;ws),"}",!.
elif_(perl,Indent,[A,B]) -->
	"elsif",ws,"(",!,ws,A,ws,")",!,ws,"{",!,ws,B,(Indent;ws),"}",!.

function_(sympy,Indent,Type,Name,Params,Body) -->
	function_(python,Indent,Type,Name,Params,Body).
function_(python,Indent,_,Name,Params,Body) -->
	"def",python_ws_,Name,python_ws,"(",!,python_ws,Params,python_ws,"):",!,python_ws,Body.
function_(sympy,Indent,_,Name,Params,Body) -->
	function_(python,Indent,Type,Name,Params,Body).
function_(perl,Indent,_,Name,Params,Body) -->
	"sub",ws_,Name,ws,"{",ws,"my",ws,"(",Params,")",ws,"=@_",ws,";",ws,Body,(Indent;ws),"}",!.
function_('haxe',Indent,Type,Name,Params,Body) -->
	("public",ws_,"static",ws_,"function",ws_,Name,ws,"(",!,ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),!.
function_('erlang',Indent,Type,Name,Params,Body) -->
	(Name,ws,"(",!,ws,Params,ws,")",ws,"->",ws,Body).
function_('php',Indent,Type,Name,Params,Body) --> function_('javascript',Indent,Type,Name,Params,Body).
function_('javascript',Indent,_,Name,Params,Body) -->
	"function",ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",!,ws,Body,(Indent;ws),"}",!.
function_('c#',Indent,Type,Name,Params,Body) -->
	"public",ws_,"static",ws_,Type,ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws,"{",!,ws,Body,(Indent;ws),"}",!.
function_('java',Indent,Type,Name,Params,Body) -->
	function_('c#',Indent,Type,Name,Params,Body).
function_('c++',Indent,Type,Name,Params,Body) -->
	Type,ws_,Name,ws,"(",!,ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}",!.
function_('prolog',Indent,Type,Name,Params,Body) -->
	Name,ws,"(",!,ws,Params,ws,",",!,ws,"Return",ws,")",ws,":-",Body.
function_('c',Indent,Type,Name,Params,Body) -->
	Type,ws_,Name,ws,"(",!,ws,Params,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}",!.
function_('lua',Indent,_,Name,Params,Body) -->
	("function",ws_,Name,ws,"(",!,ws,Params,ws,")",!,ws_,Body,(Indent;ws_),"end"),!.
function_('ruby',Indent,_,Name,Params,Body) -->
	("def",ws_,Name,ws,"(",!,ws,Params,ws,")",ws_,Body,(Indent;ws_),"end"),!.

sort_in_place_(python,A) -->
	A,python_ws,".",python_ws,"sort",python_ws,"(",!,python_ws,")",!.
sort_in_place_(ruby,A) -->
	A,ws,".",ws,"sort!",!.
sort_in_place_(php,A) -->
	("sort",ws,"(",!,ws,A,ws,")").
sort_in_place_(lua,A) -->
	("table",ws,".",ws,"sort",ws,"(",!,ws,List,ws,")").
sort_in_place_('java',A) -->
	"Arrays",ws,".",ws,"sort",ws,"(",!,ws,A,ws,")",!.
sort_in_place_('c++',A) -->	
	("std::sort",ws,"(",!,ws,"std::begin",ws,"(",!,ws,List,ws,")",ws,",",ws,"std::end",ws,"(",!,ws,List,ws,")",ws,")").

reverse_in_place_(python,A) -->
	A,python_ws,".",python_ws,"reverse",python_ws,"(",!,python_ws,")",!.
reverse_in_place_(javascript,A) --> reverse_in_place_(python,A).
reverse_in_place_('c#',A) -->
	"Array",ws,".",ws,"Reverse",ws,"(",!,ws,A,ws,")",!.
reverse_in_place_('ruby',List) -->
	(List,ws,".",ws,"sort!").

while_(python,Indent,A,B) -->
	"while",indented_block(A),!,python_ws,B.

while_(php,Indent,A,B) --> while_(c,Indent,A,B),!.
while_(perl,Indent,A,B) --> while_(c,Indent,A,B),!.
while_(javascript,Indent,A,B) --> while_(c,Indent,A,B),!.
while_('c++',Indent,A,B) --> while_(c,Indent,A,B),!.
while_('c#',Indent,A,B) --> while_(c,Indent,A,B),!.
while_(java,Indent,A,B) --> while_(c,Indent,A,B),!.
while_(haxe,Indent,A,B) --> while_(c,Indent,A,B),!.
while_(c,Indent,A,B) -->
	"while",ws,"(",!,ws,A,ws,")",ws,"{",!,ws,B,(Indent;ws),"}",!.
while_(ruby,Indent,A,B) --> while_(lua,Indent,A,B).
while_(lua,Indent,A,B) -->
	"while",ws,"(",!,ws,A,ws,")",ws_,"do",ws_,B,(Indent;ws_),"end".

if_(python,Indent,A,B) -->
	"if",indented_block(A),!,B.
if_(perl,Indent,A,B) --> if_(c,Indent,A,B),!.
if_('c++',Indent,A,B) --> if_(c,Indent,A,B),!.
if_('java',Indent,A,B) --> if_(c,Indent,A,B),!.
if_('php',Indent,A,B) --> if_(c,Indent,A,B),!.
if_('haxe',Indent,A,B) --> if_(c,Indent,A,B),!.
if_('c#',Indent,A,B) --> if_(c,Indent,A,B),!.
if_('d',Indent,A,B) --> if_(c,Indent,A,B),!.
if_(javascript,Indent,A,B) -->
	"if",ws,"(",!,ws,A,ws,")",{writeln('calling if_')},!,ws,"{",!,ws,B,(Indent;ws),"}",!.
if_(c,Indent,A,B) -->
	"if",ws,"(",!,ws,A,ws,")",!,ws,"{",!,ws,B,(Indent;ws),"}",!.
if_(ruby,Indent,A,B) --> if_(lua,Indent,A,B).
if_(lua,Indent,A,B) -->
	("if",ws_,A,ws_,"then",ws_,B).

true_(python) --> "True".
true_(c) --> "true".
true_(php) --> "true".
true_(ruby) --> "true".
true_(haxe) --> "true".
true_(java) --> "true".
true_(javascript) --> "true".
true_(lua) --> "true".
true_('c++') --> "true".
true_('c#') --> "true".
true_('perl') --> "true".
true_('prolog') --> "true".


false_(python) --> "False".
false_(c) --> "false".
false_(php) --> "false".
false_(haxe) --> "false".
false_(java) --> "false".
false_(javascript) --> "false".
false_('c++') --> "false".
false_(perl) --> "false".
false_(lua) --> "false".
false_('c#') --> "false".
false_('ruby') --> "false".
false_(prolog) --> "false".


if_without_else(python,Indent,A,B) --> if_(python,Indent,A,B).
if_without_else(c,Indent,A,B) --> if_(c,Indent,A,B),!.
if_without_else(java,Indent,A,B) --> if_(c,Indent,A,B),!.
if_without_else(javascript,Indent,A,B) --> if_(c,Indent,A,B),!.
if_without_else('c#',Indent,A,B) --> if_(c,Indent,A,B),!.
if_without_else('c++',Indent,A,B) --> if_(c,Indent,A,B),!.
if_without_else('perl',Indent,A,B) --> if_(c,Indent,A,B),!.
if_without_else('haxe',Indent,A,B) --> if_(c,Indent,A,B),!.
if_without_else('php',Indent,A,B) --> if_(c,Indent,A,B),!.
if_without_else('ruby',Indent,A,B) --> if_(ruby,Indent,A,B),(Indent;ws_),"end".
if_without_else('lua',Indent,A,B) --> if_(lua,Indent,A,B),(Indent;ws_),"end".


contains_(python,_,Container,Contained) --> (Contained,ws_,"in",ws_,Container).
%this is valid for strings and arrays in javascript
contains_(javascript,_,Container,Contained) -->
	Container,ws,".",ws,"indexOf",ws,"(",!,ws,Contained,ws,")",ws,"!==",!,ws,"-1".
contains_(javascript,[array,_],Container,Contained) -->
	Container,ws,".",ws,"includes",ws,"(",!,ws,Contained,ws,")".
%this is valid for strings and arrays in Ruby
contains_(ruby,_,Container,Contained) -->
	(Container,ws,".",ws,"include?",!,ws,"(",!,ws,Contained,ws,")").
contains_(swift,[array,_],Container,Contained) -->
	("contains",ws,"(",!,ws,Container,ws,",",!,ws,Contained,ws,")").
contains_(prolog,[array,_],Container,Contained) -->
	("member",ws,"(",!,ws,Container,ws,",",!,ws,Contained,ws,")").
contains_('c#',[array,_],Container,Contained) -->
	(Container,ws,".",ws,"Contains",ws,"(",ws,Contained,ws,")").
contains_('haskell',[array,_],Container,Contained) -->
	("(",!,ws,"elem",ws_,Contained,ws_,Container,ws,")").
contains_('java',[array,_],Container,Contained) -->
	("Arrays",ws,".",ws,"asList",ws,"(",ws,Container,ws,")",ws,".",ws,"contains",ws,"(",ws,Contained,ws,")").
contains_('haxe',[array,_],Container,Contained) -->
	("Lambda",ws,".",ws,"has",ws,"(",!,ws,Container,ws,",",ws,Contained,ws,")").
contains_('php',[array,_],Container,Contained) -->
	("in_array",ws,"(",!,ws,Contained,ws,",",!,ws,Container,ws,")").
contains_('c++',[array,_],Container,Contained) -->
	%("(",ws,"std",ws,"::",ws,"find",ws,"(",ws,"std::begin",ws,"(",ws,Container,ws,")",ws,",",ws,"std",ws,"::",ws,"end",ws,"(",ws,Container,ws,")",ws,",",ws,Contained,ws,")",ws,"!=",ws,"std",ws,"::",ws,"end",ws,"(",ws,Contained,ws,")",ws,")").
	"(std::find(std::begin(",ws,Container,ws,"), std::end(",ws,Container,ws,"),",ws,Contained,ws,") != std::end(",ws,Contained,ws,"))".
contains_('lua',[array,_],Container,Contained) -->
	(Container,ws,"[",ws,Contained,ws,"]",ws,"~=",ws,"nil").

foreach_('python',Indent,Type,Var,Array,Body) -->
	("for",python_ws_,Var,python_ws_,"in",python_ws_,Array,python_ws,":",python_ws,Body).
foreach_('javascript',Indent,Type,Var,Array,Body) -->	
	(Array,ws,".",ws,"forEach",ws,"(",!,ws,"function",ws,"(",!,ws,Var,ws,")",ws,"{",ws,Body,(Indent;ws),"}",ws,")",ws,";").
foreach_('haxe',Indent,Type,Var,Array,Body) -->
	("for",ws,"(",!,ws,Var,ws_,"in",ws_,Array,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}"),!.
foreach_('ruby',Indent,_,Var,Array,Body) -->
	Array,ws,".",ws,"each",ws_,"do",ws,"|",ws,Var,ws,"|",ws,Body,(Indent;ws_),"end".
foreach_('c++',Indent,Type,Var,Array,Body) -->
	"for",ws,"(",!,ws,Type,ws_,Var,ws,":",ws,Array,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}",!.
foreach_('php',Indent,_,Var,Array,Body) -->
	"foreach",ws,"(",!,ws,Array,ws_,"as",ws_,Var,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}",!.
foreach_('c#',Indent,Type,Var,Array,Body) -->
	"foreach",ws,"(",!,ws,Type,ws_,Var,ws_,"in",ws_,Array,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}",!.
foreach_('java',Indent,Type,Var,Array,Body) -->
	"for",ws,"(",!,ws,Type,ws_,Var,ws,":",ws,Array,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}",!.
foreach_('perl',Indent,_,Var,Array,Body) -->
	"for",ws_,Var,ws_,"(",!,ws,Array,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}",!.
foreach_('lua',Indent,_,Var,Array,Body) -->
	("for",ws_,"_",ws,",",ws,Var,ws_,"in",ws_,"pairs",ws,"(",!,ws,Array,ws,")",ws_,"do",ws_,Body,(Indent;ws_),"end").

statement_with_semicolon_(prolog,_,A) --> A.
statement_with_semicolon_(python,_,A) --> A,python_ws.
statement_with_semicolon_(python,_,A) --> A,";",!,ws.
statement_with_semicolon_(swift,_,A) --> A.
statement_with_semicolon_(erlang,_,A) --> A.
statement_with_semicolon_(java,_,A) --> A,";",!.
statement_with_semicolon_(minizinc,_,A) --> A,";",!.
statement_with_semicolon_('c++',_,A) --> A,";",!.
statement_with_semicolon_('c',_,A) --> A,";",!.
statement_with_semicolon_(lua,_,A) --> A.
statement_with_semicolon_(ruby,_,A) --> A.
statement_with_semicolon_(perl,_,A) --> A,";",!.
statement_with_semicolon_('c#',_,A) --> A,";",!.
statement_with_semicolon_(haxe,_,A) --> A,";",!.
statement_with_semicolon_(dart,_,A) --> A,";",!.
statement_with_semicolon_(php,_,A) --> A,";",!.
statement_with_semicolon_(javascript,_,A) --> A,";",!.

optional_indent(prolog,Indent) --> (Indent;"").
optional_indent(sympy,Indent) --> Indent.
optional_indent(cython,Indent) --> Indent.
optional_indent(python,Indent) --> Indent.
optional_indent(swift,Indent) --> (Indent;"").
optional_indent(erlang,Indent) --> (Indent;"").
optional_indent(java,Indent) --> (Indent;ws).
optional_indent(minizinc,Indent) --> (Indent;ws).
optional_indent('c++',Indent) --> (Indent;ws).
optional_indent('c',Indent) --> (Indent;ws).
optional_indent(lua,Indent) --> (Indent;ws).
optional_indent(ruby,Indent) --> (Indent;ws).
optional_indent(perl,Indent) --> (Indent;ws).
optional_indent('c#',Indent) --> (Indent;ws).
optional_indent(haxe,Indent) --> (Indent;ws).
optional_indent(dart,Indent) --> (Indent;ws).
optional_indent(php,Indent) --> (Indent;ws).
optional_indent(javascript,Indent) --> (Indent;ws).

%random_int_in_range_(Lang,Type,Arr) -->
%	("random",python_ws,".",python_ws,"choice",python_ws,"(",python_ws,Arr,python_ws,")").

varargs_(javascript,Type,Name) --> "...",Name.
varargs_(php,Type,Name) -->
	Type,ws,"...",ws_,"$",ws,Name.
varargs_(java,Type,Name) -->
	Type,ws,"...",ws_,Name.
