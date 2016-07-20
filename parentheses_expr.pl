parentheses_expr(Data,Type, function_call(Name1,Params1,Params2)) -->
	{
			Name = function_name(Data,Type,Name1,Params2),
			(Args = function_call_parameters(Data,Params1,Params2))
	},
    function_call(Data,Name,Args).


parentheses_expr(Data,Type,instance_method_call(Function_name_,Class_name_,Instance_name_,Params1)) -->
	{
			Data = [Lang,Is_input,_|Rest],
			Data1 = [Lang,Is_input,[Class_name_]|Rest],
			Instance_name = var_name(Data,Class_name_,Instance_name_),
			Function_name = function_name(Data1,Type,Function_name_,Params2),
			Args = function_call_parameters(Data,Params1,Params2)
	},
    langs_to_output(Data,instance_method_call,[
    ['java','haxe','javascript','c#','c++']:
		(Instance_name,".",Function_name,ws,"(",ws,Args,ws,")"),
	['logtalk']:
		(Instance_name,"::",Function_name,ws,"(",ws,Args,ws,")"),
	['perl']:
		(Instance_name,"->",Function_name,ws,"(",ws,Args,ws,")")
    ]).

%call_static_method
parentheses_expr(Data,Type,static_method_call(Function_name_,Class_name_,Params1,Params2)) -->
	{
			Data = [Lang,Is_input,_|Rest],
			Data1 = [Lang,Is_input,[Class_name_]|Rest],
			Function_name = function_name(Data1,Type,Function_name_,Params2),
			nonvar(Type),
			Class_name = symbol(Class_name_),
			Args = function_call_parameters(Data,Params1,Params2)
	},
    langs_to_output(Data,static_method_call,[
    ['java','javascript','c#']:
		(Class_name,".",Function_name,ws,"(",ws,Args,ws,")"),
	['php','c++']:
		(Class_name,"::",Function_name,ws,"(",ws,Args,ws,")"),
	['perl']:
		(Class_name,"->",Function_name,ws,"(",ws,Args,ws,")")
    ]).


parentheses_expr(Data,string,type_conversion(string,Arg1)) -->
        {
                Arg = parentheses_expr(Data,int,Arg1)
        },
        langs_to_output(Data,type_conversion,[
        ['c#']:
                (Arg,ws,".",ws,"ToString",ws,"(",ws,")"),
        [javascript]:
                ("String",ws,"(",ws,Arg,ws,")")
        ]).

parentheses_expr(Data,Type1,anonymous_function(Type1,Params1,Body1)) -->
        {
                B = statements(Data,Type1,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data,Params1)),
                Type = type(Data,Type1)
        },
		langs_to_output(Data,anonymous_function,[
		['matlab','octave']:
                ("(",ws,"@",ws,"(",ws,Params,ws,")",ws,B,ws,")"),
        ['picat']:
                ("lambda",ws,"(",ws,"[",ws,Params,ws,"]",ws,",",ws,B,ws,")"),
        ['javascript','typescript','haxe','r','php']:
                ("function",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}"),
        ['haskell']:
                ("(",ws,"\\",ws,Params,ws,"->",ws,B,ws,")"),
        ['frink']:
                ("{",ws,"|",ws,Params,ws,"|",ws,B,ws,"}"),
        ['erlang']:
                ("fun",ws,"(",ws,Params,ws,")",ws_,B,"end"),
        ['julia']:
                ("function",ws,"(",ws,Params,ws,")",ws_,B,"end"),
        ['swift']:
                ("{",ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws_,"in",ws_,B,ws,"}"),
        ['go']:
                ("func",ws,"(",ws,Params,ws,")",ws,Type,ws,"{",ws,B,ws,"}"),
        ['dart','scala']:
                ("(",ws,"(",ws,Params,ws,")",ws,"=>",ws,B,ws,")"),
        ['c++']:
                ("[",ws,"=",ws,"]",ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,B,ws,"}"),
        ['java']:
                ("(",ws,Params,ws,")",ws,"->",ws,"{",ws,B,ws,"}"),
        ['haxe']:
                ("(",ws,"name",ws_,Params,ws,"->",ws,B,ws,")"),
        ['delphi']:
                ("function",ws,"(",ws,Params,ws,")",ws,"begin",ws_,B,"end",ws,"),"),
        ['d']:
                ("(",ws,Params,ws,")",ws,"{",ws,B,ws,"}"),
        ['rebol']:
                ("func",ws_,"[",ws,Params,ws,"]",ws,"[",ws,B,ws,"]"),
        ['rust']:
                ("fn",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}")
        ]).

parentheses_expr(Data,int,floor(Params1)) -->
        {Params = expr(Data,int,Params1)},
        langs_to_output(Data,floor,[
                [javascript,java]:
                        ("Math",ws,".",ws,"floor",ws,"(",ws,Params,ws,")")
        ]).


parentheses_expr(Data,int,ceiling(Params1)) -->
        {Params = expr(Data,int,Params1)},
        langs_to_output(Data,ceiling,[
                [javascript,java]:
					("Math",ws,".",ws,"ceil",ws,"(",ws,Params,ws,")")
        ]).

parentheses_expr(Data,int,cos(Var1_)) -->
        {Var1 = expr(Data,int,Var1_)},
        langs_to_output(Data,cos,[
        ['java','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"cos",ws,"(",ws,Var1,ws,")"),
        ['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala']:
                ("cos",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Cos",ws,"(",ws,Var1,ws,")"),
        ['wolfram']:
                ("Cos",ws,"[",ws,Var1,ws,"]"),
        ['go']:
                ("math",ws,".",ws,"Cos",ws,"(",ws,Var1,ws,")"),
        ['rebol']:
                ("cosine/radians",ws_,Var1),
        ['english']:
                ("the cosine of",ws_,Var1),
        ['common lisp','racket']:
                ("(",ws,"cos",ws_,Var1,ws,")"),
        ['clojure']:
                ("(",ws,"Math/cos",ws_,Var1,ws,")")
        ]).        
        
parentheses_expr(Data,double,sin(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,sin,[
        ['java','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")"),
        ['english']:
                ("the sine of",ws_,Var1),
        ['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala']:
                ("sin",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Sin",ws,"(",ws,Var1,ws,")"),
        ['wolfram']:
                ("Sin",ws,"[",ws,Var1,ws,"]"),
        ['rebol']:
                ("sine/radians",ws_,Var1),
        ['go']:
                ("math",ws,".",ws,"Sin",ws,"(",ws,Var1,ws,")"),
        ['common lisp','racket']:
                ("(",ws,"sin",ws_,Var1,ws,")"),
        ['clojure']:
                ("(",ws,"Math/sin",ws_,Var1,ws,")")
        ]).

parentheses_expr(Data,double,abs(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,abs,[
        ['java','javascript']:
                ("Math",ws,".",ws,"abs",ws,"(",ws,Var1,ws,")")
        ]).
        
parentheses_expr(Data,double,cosh(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,cosh,[
        ['c']:
                ("cosh",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Cosh",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Cosh",ws,"(",ws,Var1,ws,")")
        ]).        


parentheses_expr(Data,double,sinh(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,sinh,[
        ['c']:
                ("sinh",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Sinh",ws,"(",ws,Var1,ws,")")
        ]).

%inverse tangent or arctan
parentheses_expr(Data,double,atan(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,atan,[
        ['c']:
                ("atan",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Atan",ws,"(",ws,Var1,ws,")")
        ]).

%inverse sine or arcsine
parentheses_expr(Data,double,asin(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,asin,[
        ['c']:
                ("asin",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Asin",ws,"(",ws,Var1,ws,")")
        ]).

%inverse cosine or arccosine
parentheses_expr(Data,double,acos(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,acos,[
        ['c']:
                ("acos",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Acos",ws,"(",ws,Var1,ws,")")
        ]).

parentheses_expr(Data,bool,"true") -->
	langs_to_output(Data,'true',[
	['java','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pseudocode','pascal','minizinc','engscript','picat','rust','clojure','nim','hack','ceylon','d','groovy','coffeescript','typescript','octave','prolog','julia','f#','swift','nemerle','vala','c++','dart','javascript','erlang','c#','haxe','go','ocaml','scala','php','rebol']:
			("true"),
	['pydatalog','hy','cython','autoit','haskell','vbscript','visual basic','monkey x','wolfram','delphi']:
			("True"),
	['perl','awk','tcl']:
			("1"),
	['racket']:
			("#t"),
	['common lisp']:
			("t"),
	['fortran']:
			(".TRUE."),
	['r','seed7']:
			("TRUE")
    ]).
parentheses_expr(Data,bool,"false") -->
    langs_to_output(Data,'false',[
    ['java','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pascal','rust','minizinc','engscript','picat','clojure','nim','groovy','d','ceylon','typescript','coffeescript','octave','prolog','julia','vala','f#','swift','c++','nemerle','dart','javascript','erlang','c#','haxe','go','ocaml','scala','php','rebol','hack']:
			("false"),
	['pydatalog','hy','cython','autoit','haskell','vbscript','visual basic','monkey x','wolfram','delphi']:
			("False"),
	['perl','awk','tcl']:
			("0"),
	['common lisp']:
			("nil"),
	['racket']:
			("#f"),
	['fortran']:
			(".FALSE."),
	['seed7','r']:
			("FALSE")
    ]).
	
parentheses_expr(Data,int,tan(Var1_)) -->
        {Var1 = expr(Data,int,Var1_)},
        langs_to_output(Data,tan,[
        ['java','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"tan",ws,"(",ws,Var1,ws,")"),
        ['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala']:
                ("tan",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")"),
        ['wolfram']:
                ("Tan",ws,"[",ws,Var1,ws,"]"),
        ['rebol']:
                ("tangent/radians",ws_,Var1),
        ['english']:
                ("the tangent of",ws_,Var1),
        ['go']:
                ("math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")"),
        ['common lisp','racket']:
                ("(",ws,"tan",ws_,"a",ws,")"),
        ['clojure']:
                ("(",ws,"Math/tan",ws_,"a",ws,")")
        ]).

parentheses_expr(_,string,string_literal(A)) --> string_literal(A).
parentheses_expr(Data,regex,regex_literal(A)) --> regex_literal(Data,A).
parentheses_expr(_,string,string_literal1(A)) --> string_literal1(A).

parentheses_expr(Data,[array,Type1],initializer_list(A_)) -->
        {
                A = initializer_list_(Data,Type1,A_),
                Type = type(Data,Type1)
        },
        langs_to_output(Data,initializer_list,[
        ['java','lua','pseudocode','picat','c#','c++','c','visual basic','visual basic .net','wolfram']:
                ("{",ws,A,ws,"}"),
        ['go']:
				("[]",Type,"{",ws,A,ws,"}"),
        [ 'ruby', 'cosmos', 'python', 'nim','d','frink','rebol','octave','julia','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','rebol','polish notation','swift']:
                ("[",python_ws,A,python_ws,"]"),
        ['php']:
                ("array",ws,"(",ws,A,ws,")"),
        ['scala']:
                ("Array",ws,"(",ws,A,ws,")"),
        ['perl','chapel']:
                ("(",ws,A,ws,")"),
        ['fortran']:
                ("(/",ws,A,ws,"/)")
        ]).

parentheses_expr(Data,[dict,Type1],dict(A_)) -->
        {
                A = dict_(Data,Type1,A_)
        },
		langs_to_output(Data,dict,[
		[ 'cosmos', 'ruby', 'lua', 'dart','javascript','typescript','julia','c++','engscript']:
                ("{",python_ws,A,python_ws,"}"),
        ['picat']:
                ("new_map",ws,"(",ws,"[",ws,A,ws,"]",ws,")"),
        ['go']:
                ("map",ws,"[",ws,"Input",ws,"]",ws,"Output",ws,"{",ws,A,ws,"}"),
        ['perl']:
                ("(",ws,A,ws,")"),
        ['php']:
                ("array",ws,"(",ws,A,ws,")"),
        ['haxe','frink','swift','elixir','d','wolfram','prolog']:
                ("[",ws,A,ws,"]"),
        ['scala']:
                ("Map",ws,"(",ws,A,ws,")"),
        ['gnu smalltalk']:
                ("Dictionary",ws,"(",ws,A,ws,")"),
        ['octave']:
                ("struct",ws,"(",ws,A,ws,")"),
        ['rebol']:
                ("to-hash",ws,"[",ws,A,ws,"]")
        ]).

%should be inclusive range
parentheses_expr(Data,[array,int],range(A_,B_)) -->
	{
		A = parentheses_expr(Data,int,A_),
		B = expr(Data,int,B_)
	},
	langs_to_output(Data,range,[
	['swift','perl','picat','minizinc','chapel']:
		("(",ws,A,ws,"..",ws,B,ws,")"),
	['rust']:
		("(",ws,A,ws,"...",ws,B,ws,")"),
	["python"]:
		("range",python_ws,"(",python_ws,A,python_ws,",",B,python_ws,"-",python_ws,"1",python_ws,")")
    ]).

parentheses_expr(Data,Type,var_name(A)) -->
	var_name(Data,Type,A).
parentheses_expr(_,int,a_number(A)) -->
	a_number(A).
parentheses_expr(Data,Type,parentheses(A)) -->
	"(",ws,expr(Data,Type,A),ws,")".
