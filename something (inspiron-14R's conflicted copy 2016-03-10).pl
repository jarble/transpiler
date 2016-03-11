:- initialization(main).
:-set_prolog_flag(double_quotes, chars).  % This is for SWI 7+ to revert to the prior interpretation of quoted strings.

%Lua-like if statements
if_statement(Lang,M,N) -->
	{member(Lang,[lua,ruby,pseudocode])},
	"if ",whitespace,expression(Lang,M),whitespace," then ",whitespace,statement(Lang,N),whitespace," end".

%Java-like if statements
if_statement(Lang,M,N) -->
	{member(Lang,[java,javascript,c,perl,pseudocode])},
	"if",whitespace,"(",whitespace,expression(Lang,M),whitespace,")",whitespace,"{",whitespace,statement(Lang,N),whitespace,"}".

%C-like functions
function(Lang,Name,Type,Params,Body) -->
	{member(Lang,[c])},
	type(Lang,Name)," ",whitespace,tkSym(Name),whitespace,"(",whitespace,statement(Lang,Params),whitespace,")",whitespace,"{",whitespace,statement(Lang,Body),whitespace,"}".

%java-like class statements
class(Lang,Name,Body) --> 
	{member(Lang,[java,pseudocode])},
	"public ", whitespace, "class ",whitespace,tkSym(Name), "{", statement(Body), "}".
	
%javascript-like class statements
class(Lang,Name,Body) --> 
	{member(Lang,[javascript,pseudocode])},
	"class", tkSym(Name), "{", statement(Body), "}".

%prolog if-statement
if_statement(Lang,M,N) --> 
	{member(Lang,[prolog])},
	expression(Lang,M),whitespace,"->",whitespace,statement(Lang,N).

%english if-statement
if_statement(Lang,M,N) -->
	{member(Lang,[english])},
	((statement(Lang,N),whitespace," then ",whitespace,expression(Lang,M));("if ",whitespace,expression(Lang,M),whitespace," then ",whitespace,statement(Lang,N))).


%java return statement
return(Lang,Name,To_return) --> 
	{member(Lang,[java,perl,javascript])},
	"return ",whitespace,expression(Lang,To_return),whitespace,";".

%lua return statement
return(Lang,Name,To_return) --> 
	{member(Lang,[lua,ruby,english,haxe])},
	"return ",whitespace,expression(Lang,To_return).
	
integer(Lang,A) --> 	{member(Lang,[java,python])}, "int".
boolean(Lang,A) --> 	{member(Lang,[java])}, "boolean".
boolean(Lang,A) --> 	{member(Lang,[c,c_sharp])}, "bool".
char(Lang,A) --> 	{member(Lang,[java])}, "char".
bool(Lang,A) --> boolean(Lang,A).
int(Lang,A) --> int(Lang,A).

type(Lang,A) --> int(Lang,A);bool(Lang,A);char(Lang,A).

statement(Lang, if_statement(M,N)) --> if_statement(Lang,M,N).
statement(Lang, class(Name,Body)) --> class(Lang,Name,Body).
statement(Lang, function(Name,Type,Params,Body)) --> function(Lang,Name,Type,Params,Body).

statement(Lang, return(Name,To_return)) --> return(Lang,Name,To_return).
expression(Lang,symbol(A)) --> symbol(A).

whitespace --> "";(" ",whitespace).
symbol([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([])     --> [].
letter(Let)     --> [Let], { code_type(Let, alpha) }.

statement(Lang, tkSym(Token)) --> symbol(Token).

translate(Input,Output,Lang1,Lang2) :-
	phrase(statement(Lang1,Ls), Input),
	phrase(statement(Lang2,Ls), Output).
	
translate(Input,Output,Lang2) :-
	member(Lang1,[java,javascript,lua,perl,ruby,prolog,c]), translate(Input,Output,Lang1,Lang2).

main :- translate("int doStuff(a){ return b; }",E,c,java), writeln('\n'), writeln(E), writeln('\n').
