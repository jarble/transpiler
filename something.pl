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

%java-like functions
function(Lang,Name,Type,Params,Body) -->
	{member(Lang,[java,c_sharp])},
	"public ",whitespace," static ",whitespace,type(Lang,Type)," ",whitespace,symbol(Name),whitespace,"(",whitespace,expression(Lang,Params),whitespace,")",whitespace,"{",whitespace,statement(Lang,Body),whitespace,"}".

%C-like functions
function(Lang,Name,Type,Params,Body) -->
	{member(Lang,[c])},
	type(Lang,Type)," ",whitespace,symbol(Name),whitespace,"(",whitespace,expression(Lang,Params),whitespace,")",whitespace,"{",whitespace,statement(Lang,Body),whitespace,"}".
	
%javascript-like functions
function(Lang,Name,Type,Params,Body) -->
	{member(Lang,[javascript])},
	"function ",whitespace,symbol(Name),whitespace,"(",whitespace,expression(Lang,Params),whitespace,")",whitespace,"{",whitespace,statement(Lang,Body),whitespace,"}".

%ruby-like functions
function(Lang,Name,Type,Params,Body) -->
	{member(Lang,[ruby])},
	"def ",whitespace,symbol(Name),whitespace,"(",whitespace,expression(Lang,Params),whitespace,")",whitespace,statement(Lang,Body),whitespace," end".


%java-like class statements
class(Lang,Name,Body) --> 
	{member(Lang,[java,pseudocode])},
	"public ", whitespace, "class ",whitespace,symbol(Name), "{", statement(Body), "}".
	
%javascript-like class statements
class(Lang,Name,Body) --> 
	{member(Lang,[javascript,pseudocode])},
	"class", symbol(Name), "{", statement(Body), "}".

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
	{member(Lang,[java,perl,javascript,c])},
	"return ",whitespace,expression(Lang,To_return),whitespace,";".

%lua return statement
return(Lang,Name,To_return) --> 
	{member(Lang,[lua,ruby,english,haxe])},
	"return ",whitespace,expression(Lang,To_return).
	
int(Lang,"int") --> {member(Lang,[java,python,c])},"int".
bool(Lang,"boolean") --> {member(Lang,[java])},"boolean".
bool(Lang,"bool") --> {member(Lang,[c,c_sharp])},"bool".
char(Lang,"char") --> {member(Lang,[java])},"char".
void(Lang,"void") --> {member(Lang,[java,c])},"void".

type(Lang,int(A)) --> int(Lang,A).
type(Lang,bool(A)) --> bool(Lang,A).
type(Lang,char(A)) --> char(Lang,A).
type(Lang,void(A)) --> void(Lang,A).

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

main :- translate("int add(a){ if(g){ return a; } }",E,c,java), writeln('\n'), writeln(E), writeln('\n').
