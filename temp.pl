% This is a program that translates several programming languages into several other languages.
% For example:
%    translate("int add(a){ if(g){ return a; } }",E,c,java)
% will translate a short C program into the equivalent Java syntax. Conversely, we can write
%    translate("public static int add(a){ if(g){ return a; } }",E,java,c)
% to translate a Java function into C.

:- initialization(main).
:-set_prolog_flag(double_quotes, chars).  % This is for SWI 7+ to revert to the prior interpretation of quoted strings.

%Use this rule to define operators for various languages
infix_operator(Data,Type,Symbol,Exp1,Exp2) -->
	(parentheses_expr(Data,Type,Exp1)),ws,Symbol,ws,expr(Data,Type,Exp2).

parentheses_expr(Data,Type,["(",A,")"]) -->
	"(",ws,expr(Data,Type,A),ws,")".

parentheses_expr(Data,Type,var_name(Name)) -->
	var_name(Data,Type,Name).

var_name(Data,Type,Name) -->
	symbol(Name).
expr(Data,Type,parentheses_expr(A)) --> parentheses_expr(Data,Type,A).

expr(_,Type,var_name(Data,Type,A)) --> var_name(Data,Type,A).

expr(Data,int,add(Exp1,Exp2)) -->
	infix_operator(Data,int,"+",Exp1,Exp2).

expr(Data,int,subtract(Exp1,Exp2)) -->
	infix_operator(Data,int,"-",Exp1,Exp2).

statement(Data,Return_type,function(Name1,Params1,Body1)) -->
	{
		Data = [Lang|_],
		Type = type(Lang,Return_type),
		Body = statements(Data,Return_type,Body1),
		Params = parameters(Data,Params1),
		Name = symbol(Name1)
	},
	function(Lang,[Name,Type,Params,Body]).


function(c,[Name,Type,Params,Body]) -->
	Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}".

function('c++',A) --> function('c',A).

function(java,[Name,Type,Params,Body]) -->
	"public",ws_,"static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}".

function('c#',A) --> function("java",A).

function(javascript,[Name,_,Params,Body]) -->
	"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}".

function(ruby,[Name,_,Params,Body]) -->
	"def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end".

function(lua,[Name,_,Params,Body]) -->
	"function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end".

function('c++',A) --> function('c',A).

%java-like class statements
statement(Data,_,class(Name1,Body1)) --> 
	{
		Data = [Lang|_],
		Name = var_name(Data,_,Name1),
		Body=statements(Data,_,Body1)
	},
	class(Lang,[Name,Body]).

class(java,[Name,Body]) -->
	"public",ws_,"class",ws_,ws,Name,ws,"{",ws,Body,ws,"}".
class('c#',A) --> class('java',A).

class(javascript,[Name,Body]) -->
	"class",ws_,ws,Name,ws,"{",ws,Body,ws,"}".

statement(Data,Return_type,if_statement(M1,N1)) -->
	{
		Data = [Lang|_],
		N=statements(Lang,Return_type,N1),
		M=expr(Lang,bool,M1)
	},
	({member(Lang,[lua,ruby])},
		"if ",ws,M,ws," then ",ws,N,ws," end";
	{member(Lang,[java,javascript,c,perl,pseudocode,php,c_sharp])},
		"if",ws,"(",ws,M,ws,")",ws,"{",ws,N,ws,"}";
	{member(Lang,[prolog])},
		M,ws,"->",ws,N;
	{member(Lang,[english])},
		((N,ws," then ",ws,M);("if ",ws,M,ws," then ",ws,N))).


statement(Data,Return_type,return(To_return1)) --> 
	{
		Data = [Lang|_],
		To_return = expr(Lang,Return_type,To_return1)
	},
	return(Lang,[To_return]).

return(c,[To_return]) -->
	"return",ws_,To_return,ws,";".

return(lua,[To_return]) -->
	"return",ws_,To_return.

return(java,A) --> return(c,A).
return('c++',A) --> return(c,A).
return(javascript,A)-->return(java,A).
return(perl,A) --> return(c,A).
return(ruby,A) --> return(lua,A).

statement(Data,_,initialize_var(Type1,Name1,Expr1)) -->
	{
		Data = [Lang|_],
		Expr = expr(Data,Type1,Expr1),
		Type = type(Lang,Type1),
		Name = var_name(Data,Type1,Name1)
	},
	initialize_var(Lang,[Type,Name,Expr]).

initialize_var(javascript,[_,Name,Expr]) --> "var",ws_,Name,ws,"=",ws,Expr,ws,";".

initialize_var(lua,[_,Name,Expr]) --> "local",ws_,Name,ws,"=",ws,Expr.
initialize_var(perl,[_,Name,Expr]) --> "my",ws_,Name,ws,"=",ws,Expr,ws,";".


initialize_var(java,[Type,Name,Expr]) --> Type,ws_,Name,ws,"=",ws,Expr,ws,";".

initialize_var(c,A) --> initialize_var(java,A).

initialize_var('c#',A) --> initialize_var(c,A).
initialize_var('c++',A) --> initialize_var(c,A).
initialize_var('typescript',A) --> initialize_var('javascript',A).

statement(Data,_,set_var(Name1,Type1,Expr1)) -->
	{
		Data = [Lang|_],
		Expr = expr(Data,Type1,Expr1),
		Name = var_name(Data,Type1,Name1)
	},
	set_var(Lang,[Expr,Name]).

set_var(c,[Expr,Name]) --> Name,ws,"=",ws,Expr,ws,";".
set_var(java,A)--> set_var(c,A).
set_var(javascript,A) --> set_var('c#',A).
set_var('c#',A) --> set_var('c++',A).
set_var('c++',A) --> set_var('java',A).

set_var(ruby,[Expr,Name]) --> Name,ws,"=",ws,Expr.
set_var(lua,A) --> set_var(ruby,A).

parameter(Data,[Type1,Name1]) -->
	{
		Data = [Lang|_],
		Type = type(Lang,Type1),
		Name = symbol(Name1)
	},
	({member(Lang,[lua,javascript,php,ruby])},
		Name;
	{member(Lang,[java,c,'c#','c++'])},
		Type,ws_,Name).

parameters(Data,[A]) --> parameter(Data,A).
parameters(Data,[A|B]) --> parameter(Data,A),ws,",",ws,parameters(Data,B).


type(c,string) --> "char*".

type(java,int) --> "int".
type(ruby,int) --> "fixnum".
type(javascript,int) --> "number".
type(c,int) --> "int".

type(java,bool) --> "boolean".

type('c#',bool) --> "bool".

type(c,void) --> "void".
type(java,void) --> type(c,void).
type('c++',void) --> type(c,void).
type('c#',void) --> type(c,void).

statements(Data,Return_type,[A]) --> statement(Data,Return_type,A).
statements(Data,Return_type,[A|B]) --> statement(Data,Return_type,A),(" ";"\n";""),ws,statements(Data,Return_type,B).

identifier(A) --> symbol(A).

% whitespace
ws --> "";((" ";"\t";"\n";"\r"),ws).
ws_ --> (" ";"    ";"\n";"\r"),ws.

python_ws --> "";((" ";"    "),python_ws).
python_ws_ --> (" ";"    "),python_ws.

symbol([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([])     --> [].
letter(Let)     --> [Let], { code_type(Let, alpha) }.


translate(Input,Output1,Lang1,Lang2) :-
	phrase(statements([Lang1|Rest],Return_type,Ls), Input),
	phrase(statements([Lang2|Rest],Return_type,Ls), Output),
	atom_chars(Output1, Output).
	
translate(Input,Output,Lang2) :-
	member(Lang1,[perl,java,javascript,lua,ruby,prolog,c]), translate(Input,Output,Lang1,Lang2).

main :- 
   File='input.txt',read_file_to_codes(File,Input_,[]),atom_codes(Input,Input_),
   writeln(Input),translate_langs(Input).

translate_langs(Input_) :-
	atom_chars(Input_,Input),
	list_of_langs(X),
	member(Lang,X), phrase(statements_with_ws([Lang,true,[],Var_types,"\n"],Ls), Input),
	translate_langs(Var_types,Ls,X).

translate_langs(_,_,[]) :-
	true.
	
translate_langs(Var_types,Ls,[Lang|Langs]) :-
    phrase(statements_with_ws([Lang,false,[],Var_types,"\n"],Ls), Output),
    atom_chars(Output_,Output),writeln(''),writeln(Lang),writeln(''),writeln(Output_),writeln(''),
    translate_langs(Var_types,Ls,Langs).

statements_with_ws(Data,A) -->
    ws,statements(Data,_,A),ws.

list_of_langs(X) :-
	X = [javascript,ruby,lua,c].
