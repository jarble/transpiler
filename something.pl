% This is a program that translates several programming languages into several other languages.
% For example:
%    translate("int add(a){ if(g){ return a; } }",E,c,java)
% will translate a short C program into the equivalent Java syntax. Conversely, we can write
%    translate("public static int add(a){ if(g){ return a; } }",E,java,c)
% to translate a Java function into C.

:- initialization(main).
:-set_prolog_flag(double_quotes, chars).  % This is for SWI 7+ to revert to the prior interpretation of quoted strings.

%Use this rule to define operators for various languages
infix_operator(Lang,Symbol,Exp1,Exp2) -->
	(symbol(Exp1);parentheses_expr(Lang,Exp1)),ws,Symbol,ws,expr(Lang,Exp2).

parentheses_expr(Lang,A) -->
	{member(Lang,[c,java,javascript,perl,haxe,lua,ruby,rebol])},
	"(",ws,expr(Lang,A),ws,")".

expr(Lang,parentheses_expr(A)) --> parentheses_expr(Lang,A).

expr(Lang,symbol(A)) --> symbol(A).

expr(Lang,arithmetic(Exp1,Exp2,Symbol)) -->
	{member(Lang,[c,java,javascript,perl,haxe,lua,ruby,rebol,fortran]), member(Symbol,["+","-","*","/"])},
	infix_operator(Lang,Symbol,Exp1,Exp2).

expr(Lang,power(Exp1_,Exp2_)) -->
	{member(Lang,[c,java,javascript,perl,haxe,lua,ruby,rebol,fortran]), member(Symbol,["+","-","*","/"])},
	"Math",ws,".",ws,"pow",ws,"(",ws,expr(Lang,Exp1),ws,expr(Lang,Exp2),ws,")".

statement(Lang,function(Name1,Type1,Params1,Body1)) -->
	{
		Type = type(Lang,Type1),
		Body = statements(Lang,Body1),
		Params = parameters(Lang,Params1),
		Name = symbol(Name1)
	},
	({member(Lang,[c])},
		Type," ",ws,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
	{member(Lang,[javascript])},
		"function ",ws,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
	{member(Lang,[ruby])},
		"def ",ws,Name,ws,"(",ws,Params,ws,")",ws,Body,ws," end";
	{member(Lang,[lua])},
		"function ",ws,Name,ws,"(",ws,Params,ws,")",ws,Body,ws," end";
	{member(Lang,[java,c_sharp])},
		"public ",ws,"static ",ws,Type," ",ws,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}").
	


%java-like class statements
statement(Lang,class(Name1,Body1)) --> 
	{
		Name = statements(Name1),
		Body=statements(Body1)
	},
	({member(Lang,[java,c_sharp])},
		"public ", ws, "class ",ws,Name, "{", Body, "}";
	{member(Lang,[javascript,pseudocode])},
		"class ",ws,Name,ws,"{",ws,Body,ws,"}").

statement(Lang,if_statement(M1,N1)) -->
	{
		N=statements(Lang,N1),
		M=expr(Lang,M1)
	},
	({member(Lang,[lua,ruby])},
		"if ",ws,M,ws," then ",ws,N,ws," end";
	{member(Lang,[java,javascript,c,perl,pseudocode,php,c_sharp])},
		"if",ws,"(",ws,M,ws,")",ws,"{",ws,N,ws,"}";
	{member(Lang,[prolog])},
		M,ws,"->",ws,N;
	{member(Lang,[english])},
		((N,ws," then ",ws,M);("if ",ws,M,ws," then ",ws,N))).


statement(Lang,return(Name1,To_return1)) --> 
	{
		To_return = expr(Lang,To_return1)
	},
	({member(Lang,[java,perl,javascript,c,haxe,c_sharp])},
		"return ",ws,To_return,ws,";";
	{member(Lang,[lua,ruby,english,haxe])},
		"return ",ws,To_return).

statement(Lang,initialize_var(Type1,Name1,Expr1)) -->
	{
		Expr = expr(Lang,Expr1),
		Type = type(Lang,Type1),
		Name = symbol(Name1)
	},
	({member(Lang,[c,java,c_sharp])},
		Type," ",ws,Name,ws,"=",ws,Expr,ws,";";
	{member(Lang,[javascript])},
		"var ",ws,Name,ws,"=",ws,Expr,ws,";";
	{member(Lang,[lua])},
		"local ",ws,Name,ws,"=",ws,Expr,ws;
	{member(Lang,[ruby])},
		Name,ws,"=",ws,Expr,ws).
		
statement(Lang,set_var(Name1,Expr1)) -->
	{
		Expr = expr(Lang,Expr1),
		Name = symbol(Name1)
	},
	({member(Lang,[c,java,c_sharp])},
		Name,ws,"=",ws,Expr,ws,";";
	{member(Lang,[javascript])},
		Name,ws,"=",ws,Expr,ws,";";
	{member(Lang,[lua])},
		Name,ws,"=",ws,Expr,ws;
	{member(Lang,[ruby])},
		Name,ws,"=",ws,Expr,ws).

parameter(Lang,[Type1,Name1]) -->
	{
		Type = type(Lang,Type1),
		Name = symbol(Name1)
	},
	({member(Lang,[lua,javascript,php,ruby])},
		Name;
	{member(Lang,[java,c,c_sharp])},
		Type," ",ws,Name).

parameters(Lang,[A]) --> parameter(Lang,A).
parameters(Lang,[A,B]) --> parameter(Lang,A),ws,",",ws,parameters(Lang,B).

type(Lang,string) -->
	{member(Lang,[java])},
		"String";
	{member(Lang,[c_sharp])},
		"string";
	{member(Lang,[c])},
		"char*".

type(Lang,int) -->
	{member(Lang,[java,python,c,c_sharp])},
		"int";
	{member(Lang,[haxe])},
		"Int";
	{member(Lang,[javascript])},
		"number".

type(Lang, bool) -->
	{member(Lang,[java])},
		"boolean";
	{member(Lang,[c,c_sharp])},
		"bool".

type(Lang,void) -->
	{member(Lang,[c,c_sharp,java])},
		"void".

statements(Lang,[A]) --> statement(Lang,A).
statements(Lang,[A,B]) --> statement(Lang,A),(" ";"\n";""),ws,statements(Lang,B).

identifier(A) --> symbol(A).

% whitespace
ws --> "";((" ";"\n"),ws).

symbol([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([])     --> [].
letter(Let)     --> [Let], { code_type(Let, alpha) }.


translate(Input1,Output1,Lang1,Lang2) :-
	atom_chars(Input1, Input),
	phrase(statements(Lang1,Ls), Input),
	phrase(statements(Lang2,Ls), Output),
	atom_chars(Output1, Output).
	
translate(Input,Output,Lang2) :-
	member(Lang1,[java,javascript,lua,perl,ruby,prolog,c]), translate(Input,Output,Lang1,Lang2).

main :- translate('char* d = f; d = (g - a) + g;',E,c,javascript), writeln('\n'), writeln(E), writeln('\n').
