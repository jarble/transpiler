[![Build Status](https://api.travis-ci.org/jarble/transpiler.svg)](https://travis-ci.org/jarble/transpiler)

# Universal-transpiler

*Universal-transpiler* is a source-to-source compiler that translates a subset of several programming languages into several others.
It is also able to translate [definite clause grammars](https://en.wikipedia.org/wiki/Definite_clause_grammar) into other metasyntax notations, such as EBNF and ABNF.

The original version of this translator was written in JavaScript, but [a better version has been written in Prolog](universal-transpiler.pl).

This is some JavaScript code:

	function add(a,b){
		var g = [3,4,5];
		return a+b+(g[0])+(g.length);
	}

	function divide(a,b){
		return a/b;
	}

and this is the Java code that it generates:

	public static int add(int a,int b){
		int[] g={3,4,5};
		return a+b+(g[0])+(g.length);
	} 
	 
	public static int divide(int a,int b){
		return a/b;
	}

#How to use this translator

Install the package by typing `pack_install(transpiler)` in the SWI-Prolog console.
Now, you can use the translator to convert JavaScript source code into Lua:

	:- use_module(library(transpiler)).
	:- set_prolog_flag(double_quotes,chars).
	:- initialization(main).

	main :- 
		translate("function add(a,b){return a + b;}",javascript,lua,X),
		atom_chars(Y,X),
		writeln(Y).


#How to extend the translator

A limited number of translation rules are provided here, but you can easily add your own rules to `transpiler.pl`.
This is a simplified version of one of its translation rules, implementing the sine function:

	%The type of this expression is double.
	parentheses_expr(Data,double,sin(Var1_)) -->
        {
			%The parameter of the sine function can be an integer or double.
			Var1 = expr(Data,double,Var1_)
		},
        langs_to_output(Data,sin,[
        ['java','javascript']:
                ("Math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")"),
        ['lua','python']:
                ("math",python_ws,".",python_ws,"sin",python_ws,"(",python_ws,Var1,python_ws,")"),
        ]).

#Similar projects
There are several other source code generators that are similar to this one. [http://codeworker.free.fr/]
