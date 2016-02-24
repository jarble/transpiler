%This is a language translator written in Prolog. This query translates a JavaScript function into a Ruby function:
%	translate("function add(a) b end",ruby,X).


:- set_prolog_flag(double_quotes, chars).
whitespace --> [Space], { char_type(Space, space) }, whitespace.
whitespace --> [].

symbol([L|Ls]) --> letter(L), symbol_r(Ls).

symbol_r([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([])     --> [].
letter(Let)     --> [Let], { code_type(Let, alpha) }.

% similarly for numbers

digit(Dg)        --> [Dg], { code_type(Dg, digit) }.
digits([Dg|Dgs]) --> digit(Dg), digits(Dgs).
digits([Dg])     --> digit(Dg).

token(Lang,tkSym(Token)) -->
	symbol(Token).
tkSym(Lang,Token) -->
	token(Lang,tkSym(Token)).
tkSym(Token) --> tkSym(javascript,Token).

token(Lang,tkNum(Token)) -->
	digits(Digits), { number_chars(Token, Digits) }.
tkNum(Lang,Token) --> token(Lang,tkNum(Token)).
tkNum(Token) --> tkNum(javascript,Token).

tkFunction(javascript,Name,Type,Params,Body) -->
	"function",whitespace,tkSym(Name),whitespace,"(",whitespace, tkSym(Params),whitespace,")",whitespace,"{",whitespace,token(javascript,Body),"}".
tkFunction(lua,Name,Type,Params,Body) -->
	"function",whitespace,tkSym(Name),whitespace,"(",whitespace,tkSym(Params),whitespace,")",whitespace,token(lua,Body),whitespace,"end".
tkFunction(ruby,Name,Type,Params,Body) -->
	"def",whitespace,tkSym(Name),whitespace,"(",whitespace,tkSym(Params),whitespace,")",whitespace,token(ruby,Body),whitespace,"end",{[Name,Type,Params,Body]}.



token(Lang,tkFunction(Name,Type,Params,Body)) -->
	tkFunction(Lang,Name,Type,Params,Body).




token(javascript,tkSetVar(Token1, Token2)) --> (tkSym(Lang,Token1),whitespace,"=",whitespace,token(Lang,Token2),whitespace,";").


tkSetVar(Lang,Token1, Token2) --> token(Lang,tkSetVar(Token1,Token2)).

token(Lang,functionCallStatement(Name,Params)) -->
	tkSym(Name),"(",token(Lang,Params),";".

tokenize(Lang,[Token|Tokens]) --> whitespace, token(Lang,Token), tokenize(Lang,Tokens).
tokenize(Lang,[]) --> whitespace.																													

tokenize(Token) --> tokenize(java,Token);tokenize(ruby,Token);tokenize(javascript,Token);tokenize(lua,Token);tokenize(perl,Token).

concat_program([], "").
concat_program([L|Ls], Str) :-
    concat_program(Ls, Str0),
    append("", Str0, Str1),
    append(L, Str1, Str).

%generate the output for functions
output(Lang,tkFunction(Name,Type,Params,Body), Output) :-
	output(Lang,Body,BodyOutput),
	(Lang = javascript) ->
		concat_program(["function ",Name,"(",Params,"){",BodyOutput,"}"],Output);
	(Lang = ruby) ->
		concat_program(["def ",Name,"(",Params,"){",BodyOutput,"end"],Output);
	(Lang = lua) ->
		concat_program(["function ",Name,"(",Params,") ",BodyOutput," end"],Output).

output(Lang,tkSym(Param),Output) :-
	Output=Param.

output(Lang2,[A],Output) :- output(Lang2,A,Output).

translate(String1,Lang2,Output1) :-
	phrase(tokenize(Ts), String1),
	output(Lang2,Ts,Output),
	atom_string(Output1,Output),
	writeln(Output1).

%write queries like this one:
%	translate("function add(a) b end",ruby,X).
