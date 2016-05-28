parentheses_expr(Data,Type, function_call(Name1,Params1,Params2)) -->
	{
			Data = [Lang|_],
			Name = function_name(Data,Type,Name1,Params2),
			(Args = function_call_parameters(Data,Params1,Params2))
	},
    ({memberchk(Lang,['c','logtalk','nim','seed7','gap','mathematical notation','chapel','elixir','janus','perl 6','pascal','rust','hack','katahdin','minizinc','pawn','aldor','picat','d','genie','ooc','pl/i','delphi','standard ml','rexx','falcon','idp','processing','maxima','swift','boo','r','matlab','autoit','pike','gosu','awk','autohotkey','gambas','kotlin','nemerle','engscript','prolog','groovy','scala','coffeescript','julia','typescript','fortran','octave','c++','go','cobra','ruby','vala','f#','java','ceylon','ocaml','erlang','python','c#','lua','haxe','javascript','dart','bc','visual basic','visual basic .net','php','perl'])}->
			Name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['haskell','z3','clips','clojure','common lisp','clips','racket','scheme','crosslanguage','rebol'])}->
			"(",ws,Name,ws_,Args,ws,")";
	{memberchk(Lang,['polish notation'])}->
			Name,ws_,Args;
	{memberchk(Lang,['reverse polish notation'])}->
			Args,ws_,Name;
	{memberchk(Lang,['pydatalog','nearley'])}->
			Name,ws,"[",ws,Args,ws,"]";
	{not_defined_for(Data,'function_call')}).

parentheses_expr(Data,Type,instance_method_call(Function_name_,Class_name_,Instance_name_,Params1)) -->
	{
			Data = [Lang,Is_input,_|Rest],
			Data1 = [Lang,Is_input,[Class_name_]|Rest],
			Instance_name = var_name(Data,Class_name_,Instance_name_),
			Function_name = function_name(Data1,Type,Function_name_,Params2),
			Args = function_call_parameters(Data,Params1,Params2)
	},
    ({memberchk(Lang,['java','ruby','haxe','javascript','lua','c#','c++'])}->
		Instance_name,".",Function_name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['logtalk'])}->
		Instance_name,"::",Function_name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['perl'])}->
		Instance_name,"->",Function_name,ws,"(",ws,Args,ws,")";
	{not_defined_for(Data,'instance_method_call')}).

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
    ({memberchk(Lang,['java','ruby','javascript','lua','c#'])}->
		Class_name,".",Function_name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['php','c++'])}->
		Class_name,"::",Function_name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['perl'])}->
		Class_name,"->",Function_name,ws,"(",ws,Args,ws,")";
	{not_defined_for(Data,'static_method_call')}).


parentheses_expr(Data,string,type_conversion(string,Arg1)) -->
        {
                Data = [Lang|_],
                Arg = parentheses_expr(Data,int,Arg1)
        },
        (
        {memberchk(Lang,[python])} ->
                "str",python_ws,"(",python_ws,Arg,python_ws,")";
        {memberchk(Lang,['c#'])} ->
                Arg,ws,".",ws,"ToString",ws,"(",ws,")";
        {memberchk(Lang,[javascript])} ->
                "String",ws,"(",ws,Arg,ws,")";
        {not_defined_for(Data,'type_conversion')}).

parentheses_expr(Data,Type1,anonymous_function(Type1,Params1,Body1)) -->
        {
                Data = [Lang|_],
                B = statements(Data,Type1,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data,Params1)),
                Type = type(Lang,Type1)
        },
        ({memberchk(Lang,['matlab','octave'])}->
                "(",ws,"@",ws,"(",ws,Params,ws,")",ws,B,ws,")";
        {memberchk(Lang,['picat'])}->
                "lambda",ws,"(",ws,"[",ws,Params,ws,"]",ws,",",ws,B,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Function",ws,"(",ws,Params,ws,")",ws_,B,ws_,"End",ws_,"Function";
        {memberchk(Lang,['ruby'])}->
                "Proc",ws,".",ws,"new",ws,"{",ws,"|",ws,Params,ws,"|",ws,B,ws,"}";
        {memberchk(Lang,['javascript','typescript','haxe','r','php'])}->
                "function",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['haskell'])}->
                "(",ws,"\\",ws,Params,ws,"->",ws,B,ws,")";
        {memberchk(Lang,['frink'])}->
                "{",ws,"|",ws,Params,ws,"|",ws,B,ws,"}";
        {memberchk(Lang,['erlang'])}->
                "fun",ws,"(",ws,Params,ws,")",ws_,B,"end";
        {memberchk(Lang,['lua','julia'])}->
                "function",ws,"(",ws,Params,ws,")",ws_,B,"end";
        {memberchk(Lang,['swift'])}->
                "{",ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws_,"in",ws_,B,ws,"}";
        {memberchk(Lang,['go'])}->
                "func",ws,"(",ws,Params,ws,")",ws,Type,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['dart','scala'])}->
                "(",ws,"(",ws,Params,ws,")",ws,"=>",ws,B,ws,")";
        {memberchk(Lang,['c++'])}->
                "[",ws,"=",ws,"]",ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['java'])}->
                "(",ws,Params,ws,")",ws,"->",ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['haxe'])}->
                "(",ws,"name",ws_,Params,ws,"->",ws,B,ws,")";
        {memberchk(Lang,['python'])}->
                "(",ws,"lambda",ws_,Params,ws,":",ws,B,ws,")";
        {memberchk(Lang,['delphi'])}->
                "function",ws,"(",ws,Params,ws,")",ws,"begin",ws_,B,"end",ws,";";
        {memberchk(Lang,['d'])}->
                "(",ws,Params,ws,")",ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['rebol'])}->
                "func",ws_,"[",ws,Params,ws,"]",ws,"[",ws,B,ws,"]";
        {memberchk(Lang,['rust'])}->
                "fn",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}";
        {not_defined_for(Data,'anonymous_function')}).

parentheses_expr(Data,int,floor(Params1)) -->
        {       Data = [Lang|_],
                Params = expr(Data,int,Params1)},
        (
                {memberchk(Lang,[javascript,java])} ->
                        "Math",ws,".",ws,"floor",ws,"(",ws,Params,ws,")";
                {not_defined_for(Data,'floor')}
        ).

parentheses_expr(Data,int,ceiling(Params1)) -->
        {Data = [Lang|_], Params = expr(Data,int,Params1)},
        (
                {memberchk(Lang,[javascript,java])} ->
                        "Math",ws,".",ws,"ceil",ws,"(",ws,Params,ws,")";
                {not_defined_for(Data,'ceiling')}
        ).

parentheses_expr(Data,int,cos(Var1_)) -->
        {Data = [Lang|_], Var1 = expr(Data,int,Var1_)},
        (
		{memberchk(Lang,['java','javascript','typescript','ruby','haxe'])}->
                "Math",ws,".",ws,"cos",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['lua','python'])}->
                "math",ws,".",ws,"cos",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'])}->
                "cos",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Math",ws,".",ws,"Cos",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Cos",ws,"[",ws,Var1,ws,"]";
        {memberchk(Lang,['go'])}->
                "math",ws,".",ws,"Cos",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['rebol'])}->
                "cosine/radians",ws_,Var1;
        {memberchk(Lang,['english'])}->
                "the cosine of",ws_,Var1;
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"cos",ws_,Var1,ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/cos",ws_,Var1,ws,")";
        {not_defined_for(Data,'cos')}).
        
parentheses_expr(Data,int,sin(Var1_)) -->
        {Data = [Lang|_], Var1 = expr(Data,int,Var1_)},
        ({memberchk(Lang,['java','javascript','typescript','ruby','haxe'])}->
                "Math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['lua','python'])}->
                "math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['english'])}->
                "the sine of",ws_,Var1;
        {memberchk(Lang,['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'])}->
                "sin",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Math",ws,".",ws,"Sin",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Sin",ws,"[",ws,Var1,ws,"]";
        {memberchk(Lang,['rebol'])}->
                "sine/radians",ws_,Var1;
        {memberchk(Lang,['go'])}->
                "math",ws,".",ws,"Sin",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"sin",ws_,Var1,ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/sin",ws_,Var1,ws,")";
        {not_defined_for(Data,'sin')}).

parentheses_expr([Lang|_],bool,"true") -->
	{memberchk(Lang,['java','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pseudocode','pascal','minizinc','engscript','picat','rust','clojure','nim','hack','ceylon','d','groovy','coffeescript','typescript','octave','prolog','julia','f#','swift','nemerle','vala','c++','dart','javascript','ruby','erlang','c#','haxe','go','ocaml','lua','scala','php','rebol'])}->
			"true";
	{memberchk(Lang,['python','pydatalog','hy','cython','autoit','haskell','visual basic .net','vbscript','visual basic','monkey x','wolfram','delphi'])}->
			"True";
	{memberchk(Lang,['perl','awk','tcl'])}->
			"1";
	{memberchk(Lang,['racket'])}->
			"#t";
	{memberchk(Lang,['common lisp'])}->
			"t";
	{memberchk(Lang,['fortran'])}->
			".TRUE.";
	{memberchk(Lang,['r','seed7'])}->
			"TRUE";
	{not_defined_for([Lang|_],'true_')}.

parentheses_expr([Lang|_],bool,"false") -->
    {memberchk(Lang,['java','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pascal','rust','minizinc','engscript','picat','clojure','nim','groovy','d','ceylon','typescript','coffeescript','octave','prolog','julia','vala','f#','swift','c++','nemerle','dart','javascript','ruby','erlang','c#','haxe','go','ocaml','lua','scala','php','rebol','hack'])}->
			"false";
	{memberchk(Lang,['python','pydatalog','hy','cython','autoit','haskell','visual basic .net','vbscript','visual basic','monkey x','wolfram','delphi'])}->
			"False";
	{memberchk(Lang,['perl','awk','tcl'])}->
			"0";
	{memberchk(Lang,['common lisp'])}->
			"nil";
	{memberchk(Lang,['racket'])}->
			"#f";
	{memberchk(Lang,['fortran'])}->
			".FALSE.";
	{memberchk(Lang,['seed7','r'])}->
			"FALSE";
	{not_defined_for([Lang|_],'false_')}.

parentheses_expr(Data,int,tan(Var1_)) -->
        {Data = [Lang|_], Var1 = expr(Data,int,Var1_)},
        ({memberchk(Lang,['java','javascript','typescript','ruby','haxe'])}->
                "Math",ws,".",ws,"tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['lua','python'])}->
                "math",ws,".",ws,"tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'])}->
                "tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Tan",ws,"[",ws,Var1,ws,"]";
        {memberchk(Lang,['rebol'])}->
                "tangent/radians",ws_,Var1;
        {memberchk(Lang,['english'])}->
                "the tangent of",ws_,Var1;
        {memberchk(Lang,['go'])}->
                "math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"tan",ws_,"a",ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/tan",ws_,"a",ws,")";
        {not_defined_for(Data,'tan')}).

parentheses_expr(_,string,string_literal(A)) --> string_literal(A).
parentheses_expr([Lang|_],regex,regex_literal(A)) --> regex_literal(Lang,A).
parentheses_expr(_,string,string_literal1(A)) --> string_literal1(A).

parentheses_expr(Data,[array,Type],initializer_list(A_)) -->
        {
                Data = [Lang|_],
                A = initializer_list_(Data,Type,A_)
        },
        ({memberchk(Lang,['java','pseudocode','picat','c#','go','lua','c++','c','visual basic .net','visual basic','wolfram'])}->
                "{",ws,A,ws,"}";
        {memberchk(Lang,['python', 'cosmos', 'nim','d','frink','rebol','octave','julia','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','ruby','rebol','polish notation','swift'])}->
                "[",ws,A,ws,"]";
        {memberchk(Lang,['php'])}->
                "array",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['scala'])}->
                "Array",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['perl','chapel'])}->
                "(",ws,A,ws,")";
        {memberchk(Lang,['fortran'])}->
                "(/",ws,A,ws,"/)";
        {not_defined_for(Data,'initializer_list')}).
        
parentheses_expr(Data,[dict,Type1],dict(A_)) -->
        {
                Data = [Lang|_],
                A = dict_(Data,Type1,A_)
        },
        ({memberchk(Lang,['python', 'cosmos', 'dart','javascript','typescript','lua','ruby','julia','c++','engscript','visual basic .net'])}->
                "{",ws,A,ws,"}";
        {memberchk(Lang,['picat'])}->
                "new_map",ws,"(",ws,"[",ws,A,ws,"]",ws,")";
        {memberchk(Lang,['go'])}->
                "map",ws,"[",ws,"Input",ws,"]",ws,"Output",ws,"{",ws,A,ws,"}";
        {memberchk(Lang,['perl'])}->
                "(",ws,A,ws,")";
        {memberchk(Lang,['php'])}->
                "array",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['haxe','frink','swift','elixir','d','wolfram'])}->
                "[",ws,A,ws,"]";
        {memberchk(Lang,['scala'])}->
                "Map(",ws,A,ws,")";
        {memberchk(Lang,['octave'])}->
                "struct",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['rebol'])}->
                "to-hash",ws,"[",ws,A,ws,"]";
        {not_defined_for(Data,'dict')}).

%should be inclusive range
parentheses_expr(Data,[array,int],range(A_,B_)) -->
	{
		Data = [Lang|_],
		A = parentheses_expr(Data,int,A_),
		B = expr(Data,int,B_)
	},
	({memberchk(Lang,['swift','perl','picat','ruby','minizinc','chapel'])}->
		"(",ws,A,ws,"..",ws,B,ws,")";
	{memberchk(Lang,['rust'])}->
		"(",ws,A,ws,"...",ws,B,ws,")";
	{memberchk(Lang,"python")} ->
		"range",ws,"(",ws,A,ws,",",B,ws,"-",ws,"1",ws,")";
	{not_defined_for(Data,'range')}).

parentheses_expr(Data,Type,var_name(A)) -->
	var_name(Data,Type,A).
parentheses_expr(_,int,a_number(A)) -->
	a_number(A).
parentheses_expr(Data,Type,parentheses(A)) -->
	"(",ws,expr(Data,Type,A),ws,")".
