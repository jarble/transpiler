[![Build Status](https://api.travis-ci.org/jarble/transpiler.svg)](https://travis-ci.org/jarble/transpiler)

# Universal-transpiler

*Universal-transpiler* is a source-to-source compiler that translates a subset of several programming languages into several others.
It is also able to translate [definite clause grammars](https://en.wikipedia.org/wiki/Definite_clause_grammar) into other metasyntax notations, such as EBNF and ABNF.

The [online version of this translator](https://jarble.github.io/transpiler/javascript/js_transpiler/test_parser.html) is written in JavaScript, but [an experimental version](https://github.com/jarble/transpiler/tree/master/prolog) is being written in Prolog.

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

# How to use the online translator

This translator can convert many languages into many others:
* [JavaScript to Prolog](file:///C:/Users/jarbl/Dropbox/All%20source%20code%20goes%20here%20-%20don't%20put%20this%20folder%20inside%20any%20other%20folder/Prolog%20projects/universal-transpiler/javascript/js_transpiler/test_parser.html#%7B%22inputText%22%3A%22function%20is_an_animal(thing)%7B%5Cn%20%20%20%20return%20%5B%5C%22cat%5C%22%2C%5C%22dog%5C%22%2C%5C%22horse%5C%22%5D.indexOf(thing)%20!%3D%3D%20-1%3B%5Cn%7D%22%2C%22inputLang%22%3A%22javascript%22%2C%22outputLang%22%3A%22prolog%22%7D)
* [JavaScript to Ruby](file:///C:/Users/jarbl/Dropbox/All%20source%20code%20goes%20here%20-%20don't%20put%20this%20folder%20inside%20any%20other%20folder/Prolog%20projects/universal-transpiler/javascript/js_transpiler/test_parser.html#%7B%22inputText%22%3A%22function%20is_an_animal(thing)%7B%5Cn%20%20%20%20return%20%5B%5C%22cat%5C%22%2C%5C%22dog%5C%22%2C%5C%22horse%5C%22%5D.indexOf(thing)%20!%3D%3D%20-1%3B%5Cn%7D%22%2C%22inputLang%22%3A%22javascript%22%2C%22outputLang%22%3A%22ruby%22%7D)
* [C into Java]
* [Ruby to Python](file:///C:/Users/jarbl/Dropbox/All%20source%20code%20goes%20here%20-%20don't%20put%20this%20folder%20inside%20any%20other%20folder/Prolog%20projects/universal-transpiler/javascript/js_transpiler/test_parser.html#%7B%22inputText%22%3A%22def%20add(a%2Cb)%20%5Cn%20%20%20%20return%20a%2Bb%5Cnend%22%2C%22inputLang%22%3A%22ruby%22%2C%22outputLang%22%3A%22python%22%7D)

# How to use the Prolog translator

The Prolog translator is still unfinished and experimental. You can install the package by typing `pack_install(transpiler)` in the SWI-Prolog console.
Now, you can use the translator to convert JavaScript source code into Lua:

	:- use_module(library(transpiler)).
	:- set_prolog_flag(double_quotes,chars).
	:- initialization(main).

	main :- 
		translate("function add(a,b){return a + b;}",javascript,lua,X),
		atom_chars(Y,X),
		writeln(Y).


# How to extend the Prolog translator

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

# Similar projects
There are several other source code generators that are similar to this one. This [universal code generator](http://codeworker.free.fr/) is one example.
