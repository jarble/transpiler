:- include(tokenizer).
:- set_prolog_flag(double_quotes,chars).
:- initialization(main).


%To do:
%Fix the precedence of '-' and '+'. Try to make the precedence equal for both of these operators.

main :- tokenize("return a1+b1; const r = g*b+g*2; r = 2-1+a; r = 2+1-a;",Result),atoms_to_codes(Result1,Result),parse(Result1,Result2),writeln(Result2).

atoms_to_codes([],[]).
atoms_to_codes([A|B],[A1|B1]) :- atom_chars(A,A1),atoms_to_codes(B,B1).

parse(List,Result) :-
	is_expr(A),is_expr(B),
	(
	member(To_parse,[
		['[',A,']'],
		['(',A,')'],
		['{',A,'}'],
		[A,'.',B],
		
		%the order of operations is wrong here
		[A,'*',B],
		[A,'/',B],
		[A,'+',B],
		[A,'-',B],
		
		[A,'!==',B],
		[A,'===',B],
		[A,',',B],
		['else','if',['(',A,')'],['{',B,'}']],
		['if',['(',A,')'],['{',B,'}']],
		['while',['(',A,')'],['{',B,'}']],
		['else',['{',A,'}']],
		['return',A,';'],
		['const',A,'=',B,';'],
		['let',A,'=',B,';'],
		['var',A,'=',B,';'],
		[A,'=',B,';'],
		[A,'*=',B,';'],
		['function',['(',A,')'],['{',B,'}']],
		['function',_,['(',A,')'],['{',B,'}']]
	]),parse(To_parse,List,Result1)
	),parse(Result1,Result);
	(
		Result=List
	).

is_expr(A) :- dif(A,'='),dif(A,'*'),dif(A,'['),dif(A,']'),dif(A,'('),dif(A,')').


parse(Sublist,List,Result) :-
	replace(Sublist,[Sublist],List,Result).

replace(ToReplace, ToInsert, List, Result) :-
    once(append([Left, ToReplace, Right], List)),
    append([Left, ToInsert, Right], Result).
