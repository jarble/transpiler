# Universal-transpiler
A universal programming language translator

*Universal-transpiler* is a source-to-source compiler that translates a subset of most programming languages into several others.

The original version of this translator was written in JavaScript, but [a better version has been written in Prolog](transpiler-generator.pl).

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
* First, write some source code in input.txt. 
* Open transpiler-generator.pl in the SWI-Prolog console.
* Type the input and output languages. The translated source code will be saved in output.txt.

#How to extend the translator

A limited number of translation rules are provided here, but you can easily add your own rules to `universal-translator.pl`.
For example, the sine function is translated by this rule:

	%The type of this expression is double.
	parentheses_expr(Data,double,sin(Var1_)) -->
        {
			%The parameter of the sine function can be an integer or double.
			Var1 = expr(Data,double,Var1_)
		},
        langs_to_output(Data,sin,[
        [['java','javascript','typescript','ruby','haxe'],
                ("Math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")")],
        [['lua','python'],
                ("math",python_ws,".",python_ws,"sin",python_ws,"(",python_ws,Var1,python_ws,")")],
        [['english'],
                ("the sine of",ws_,Var1)],
        [['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'],
                ("sin",ws,"(",ws,Var1,ws,")")],
        [['c#','visual basic .net'],
                ("Math",ws,".",ws,"Sin",ws,"(",ws,Var1,ws,")")],
        [['wolfram'],
                ("Sin",ws,"[",ws,Var1,ws,"]")],
        [['rebol'],
                ("sine/radians",ws_,Var1)],
        [['go'],
                ("math",ws,".",ws,"Sin",ws,"(",ws,Var1,ws,")")],
        [['common lisp','racket'],
                ("(",ws,"sin",ws_,Var1,ws,")")],
        [['clojure'],
                ("(",ws,"Math/sin",ws_,Var1,ws,")")]
        ]).
