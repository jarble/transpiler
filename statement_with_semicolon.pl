
statement_with_semicolon(Data,_,prolog_concatenate_string(Output_,Str1_,Str2_)) --> 
{
	Data = [Lang|_],
	Output = expr(Data,string,Output_),
	Str1 = expr(Data,string,Str1_),
	Str2 = expr(Data,string,Str2_)
},
	({memberchk(Lang,['javascript'])}->
		Output,ws,"=",ws,Str1,ws,"+",ws,Str2;
	{not_defined_for(Data,'prolog_concatenate_string')}).

statement_with_semicolon(Data,Return_type,return(To_return1,Function_name)) --> 
        {
                Data = [Lang|_],
                A = expr(Data,Return_type,To_return1)
        },
    ({memberchk(Lang,['vbscript'])}->
			Function_name,ws,"=",ws,A;
	{memberchk(Lang,['pseudocode','java','seed7','xl','e','livecode','englishscript','cython','gap','kal','engscript','pawn','ada','powershell','rust','d','ceylon','typescript','hack','autohotkey','gosu','swift','pike','objective-c','c','groovy','scala','coffeescript','julia','dart','c#','javascript','go','haxe','php','c++','perl','vala','lua','python','rebol','ruby','tcl','awk','bc','chapel','perl 6'])}->
			"return",ws_,A;
	{memberchk(Lang,['minizinc','prolog','logtalk','pydatalog','polish notation','reverse polish notation','mathematical notation','emacs lisp','z3','erlang','maxima','standard ml','icon','oz','clips','newlisp','hy','sibilant','lispyscript','algol 68','clojure','common lisp','f#','ocaml','haskell','ml','racket','nemerle'])}->
			A;
	{memberchk(Lang,['pseudocode','visual basic','visual basic .net','autoit','monkey x'])}->
			"Return",ws_,A;
	{memberchk(Lang,['octave','fortran','picat'])}->
			"retval",ws,"=",ws,A;
	{memberchk(Lang,['cosmos'])}->
			"Return",python_ws,"=",python_ws,A;
	{memberchk(Lang,['pascal'])}->
			"Exit",ws,"(",ws,A,ws,")";
	{memberchk(Lang,['pseudocode','r'])}->
			"return",ws,"(",ws,A,ws,")";
	{memberchk(Lang,['wolfram'])}->
			"Return",ws,"[",ws,A,ws,"]";
	{memberchk(Lang,['pop-11'])}->
			A,ws,"->",ws,"Result";
	{memberchk(Lang,['delphi','pascal'])}->
			"Result",ws,"=",ws,A;
	{memberchk(Lang,['pseudocode','sql'])}->
			"RETURN",ws_,A;
	{not_defined_for(Data,'return')}).

statement_with_semicolon(Data,_,plus_plus(Name1)) --> 
        {
                Data = [Lang|_],
                Name = var_name(Data,int,Name1)
        },
        ({memberchk(Lang,[javascript,java,c])} ->
                Name,ws,"++";
        {memberchk(Lang,[python])} ->
                Name,ws,"+=",ws,"1";
        {not_defined_for(Data,'plus_plus')}).

statement_with_semicolon(Data,_,minus_minus(Name1)) --> 
        {
                Data = [Lang|_],
                Name = var_name(Data,int,Name1)
        },
        ({memberchk(Lang,[javascript,java])} ->
                Name,ws,"--";
        {not_defined_for(Data,'minus_minus')}).

statement_with_semicolon(Data,_,initialize_constant(Type1,Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Value = expr(Data,Type1,Expr1),
                Type = type(Lang,Type1),
                Name = var_name(Data,Type1,Name1)
        },
        ({memberchk(Lang,['seed7'])}->
                "const",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Value;
        {memberchk(Lang,['polish notation'])}->
                "=",ws_,Name,ws_,Value;
        {memberchk(Lang,['reverse polish notation'])}->
                Name,ws_,Value,ws_,"=";
        {memberchk(Lang,['fortran'])}->
                Type,ws,",",ws,"PARAMETER",ws,"::",ws,Name,ws,"=",ws,"expression";
        {memberchk(Lang,['go'])}->
                "const",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['perl 6'])}->
                "constant",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['php','javascript','dart'])}->
                "const",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['z3'])}->
                "(",ws,"declare-const",ws_,Name,ws_,Type,ws,")",ws,"(",ws,"assert",ws_,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Const",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
        {memberchk(Lang,['rust','swift'])}->
                "let",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['c++','c','d','c#'])}->
                "const",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"setf",ws_,Name,ws_,Value,ws,")";
        {memberchk(Lang,['minizinc'])}->
                Type,ws,":",ws,Name,ws,"=",ws,Value;
        {memberchk(Lang,['scala'])}->
                "val",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
        {memberchk(Lang,['python','ruby','haskell','erlang','julia','picat','prolog'])}->
                Name,ws,"=",ws,Value;
        {memberchk(Lang,['lua'])}->
                "local",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['perl'])}->
                "my",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['rebol'])}->
                Name,ws,":",ws,Value;
        {memberchk(Lang,['haxe'])}->
                "static",ws_,"inline",ws_,"var",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['java','dart'])}->
                "final",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['c'])}->
                "static",ws_,"const",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['chapel'])}->
                "var",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
        {memberchk(Lang,['typescript'])}->
                "const",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
        {not_defined_for(Data,'declare_constant')}).



statement_with_semicolon(Data,Type, function_call(Name1,Params1)) -->
	parentheses_expr(Data,Type, function_call(Name1,Params1)).

statement_with_semicolon(Data,_,set_array_size(Name1,Size1,Type1)) -->
		{
			Data = [Lang|_],
			Name = var_name(Data,Name1,[array,Type]),
			Size = expr(Data,int,Size1),
			Type = type(Lang,Type1)
			
		},
		({memberchk(Lang,['scala'])}->
                "var",ws_,Name,ws,"=",ws,"Array",ws,".",ws,"fill",ws,"(",ws,Size,ws,")",ws,"{",ws,"0",ws,"}";
        {memberchk(Lang,['octave'])}->
                Name,ws,"=",ws,"zeros",ws,"(",ws,Size,ws,")";
        {memberchk(Lang,['minizinc'])}->
                "array",ws,"[",ws,"1",ws,"..",ws,Size,ws,"]",ws_,"of",ws_,Type,ws,":",ws,Name,ws,";";
        {memberchk(Lang,['dart'])}->
                "List",ws_,Name,ws,"=",ws,"new",ws_,"List",ws,"(",ws,Size,ws,")";
        {memberchk(Lang,['java','c#'])}->
                Type,ws,"[]",ws_,Name,ws,"",ws,"=",ws,"new",ws_,Type,ws,"[",ws,Size,ws,"]";
        {memberchk(Lang,['fortran'])}->
                Type,ws,"(",ws,"LEN",ws,"=",ws,Size,ws,")",ws,"",ws,"::",ws,Name;
        {memberchk(Lang,['go'])}->
                "var",ws_,Name,ws_,"[",ws,Size,ws,"]",ws,Type;
        {memberchk(Lang,['swift'])}->
                "var",ws_,Name,ws,"=",ws,"[",ws,Type,ws,"]",ws,"(",ws,"count:",ws,Size,ws,",",ws,"repeatedValue",ws,":",ws,"0",ws,")";
        {memberchk(Lang,['c','c++'])}->
                Type,ws_,Name,ws,"[",ws,Size,ws,"]";
        {memberchk(Lang,['rebol'])}->
                Name,ws,":",ws,"array",ws_,Size;
        {memberchk(Lang,['visual basic .net'])}->
                "Dim",ws_,Name,ws,"(",ws,Size,ws,")",ws_,"as",ws_,Type;
        {memberchk(Lang,['php'])}->
                Name,ws,"=",ws,"array_fill",ws,"(",ws,"0",ws,",",ws,Size,ws,",",ws,"0",ws,")";
        {memberchk(Lang,['haxe'])}->
                "var",ws_,"vector",ws,"=",ws,"",ws_,"haxe",ws,".",ws,"ds",ws,".",ws,"Vector",ws,"(",ws,Size,ws,")";
        {memberchk(Lang,['javascript'])}->
                "var",ws_,Name,ws,"=",ws,"Array",ws,".",ws,"apply",ws,"(",ws,"null",ws,",",ws,"Array",ws,"(",ws,Size,ws,")",ws,")",ws,".",ws,"map",ws,"(",ws,"function",ws,"(",ws,")",ws,"{",ws,"}",ws,")";
        {memberchk(Lang,['vbscript'])}->
                "Dim",ws_,Name,ws,"(",ws,Size,ws,")";
        {not_defined_for(Data,'set_array_size')}).

statement_with_semicolon(Data,_,set_dict(Name1,Index1,Expr1,Type)) -->
	{
		Data = [Lang|_],
		Name = var_name(Data,[dict,Type],Name1),
		Index = var_name(Data,string,Index1),
		Value = expr(Data,Type,Expr1)
	},
    ({memberchk(Lang,['javascript','python','c++','haxe','c#'])}->
			Name,"[",Index,"]",ws,"=",ws,Value;
	{memberchk(Lang,['java'])}->	
			Name,ws,".",ws,"put",ws,"(",ws,Value,ws,")";
	{not_defined_for(Data,'set_dict')}).

statement_with_semicolon(Data,_,set_var(Name1,Expr1,Type)) -->
	{
		Data = [Lang|_],
		Name = var_name(Data,Type,Name1),
		Value = expr(Data,Type,Expr1)
	},
    ({memberchk(Lang,['javascript','mathematical notation','perl 6','wolfram','chapel','katahdin','frink','picat','ooc','d','genie','janus','ceylon','idp','sympy','processing','java','boo','gosu','pike','kotlin','icon','powershell','engscript','pawn','freebasic','hack','nim','openoffice basic','groovy','typescript','rust','coffeescript','fortran','awk','go','swift','vala','c','julia','scala','cobra','erlang','autoit','dart','java','ocaml','haxe','c#','matlab','c++','php','perl','python','lua','ruby','gambas','octave','visual basic','visual basic .net','bc'])}->
			Name,ws,"=",ws,Value;
	%depends on the type of Value
	{memberchk(Lang,['prolog'])}->
			Name,ws,"=",ws,Value;
	{memberchk(Lang,['minizinc'])}->
			"constraint",ws_,Name,ws,"=",ws,Value;
	{memberchk(Lang,['rebol'])}->
			Name,ws,":",ws,Value;
	{memberchk(Lang,['z3'])}->
			"(",ws,"assert",ws,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")";
	{memberchk(Lang,['gap','seed7','delphi'])}->
			Name,ws,":=",ws,Value;
	{memberchk(Lang,['livecode'])}->
			"put",ws_,"expression",ws_,"into",ws_,Name;
	{memberchk(Lang,['vbscript'])}->
			"Set",ws_,"a",ws,"=",ws,"b";
	{not_defined_for(Data,'set_var')}).

statement_with_semicolon(Data,_,initialize_empty_var(Type1,Name1)) -->
	{
			Data = [Lang|_],
			Name = var_name(Data,Type1,Name1),
			Type = type(Lang,Type1)
	},
    ({memberchk(Lang,['swift','scala','typescript'])}->
			"var",ws_,Name,ws,":",ws,Type;
	{memberchk(Lang,['java','c#','c++','c','d','janus','fortran','dart'])}->
			Type,ws_,Name;
	{memberchk(Lang,['prolog'])}->
			Type,ws,"(",ws,Name,ws,")";
	{memberchk(Lang,['javascript','haxe'])}->
			"var",ws_,Name;
	{memberchk(Lang,['minizinc'])}->
			Type,ws,":",ws,Name;
	{memberchk(Lang,['pascal'])}->
			Name,ws,":",ws,Type;
	{memberchk(Lang,['go'])}->
			"var",ws_,Name,ws_,Type;
	{memberchk(Lang,['z3'])}->
			"(",ws,"declare-const",ws_,Name,ws_,Type,ws,")";
	{memberchk(Lang,['lua','julia'])}->
			"local",ws_,Name;
	{memberchk(Lang,['visual basic .net'])}->
			"Dim",ws_,Name,ws_,"As",ws_,Type;
	{memberchk(Lang,['perl'])}->
			"my",ws_,Name;
	{memberchk(Lang,['perl 6'])}->
			"my",ws_,Type,ws_,Name;
	{memberchk(Lang,['z3py'])}->
			Name,ws,"=",ws,Type,ws,"(",ws,"'",ws,Name,ws,"'",ws,")";
	{not_defined_for(Data,'initialize_empty_var')}).

statement_with_semicolon(Data,_,throw(Expr1)) -->
	{
			Data = [Lang|Rest],
			Data1 = [_|Rest],
			A = expr(Data,string,Expr1)
	},
	({memberchk(Lang,['python'])}->
			"raise",python_ws_,"Exception",python_ws,"(",python_ws,A,python_ws,")";
	{memberchk(Lang,['ruby','ocaml'])}->
			"raise",ws_,A;
	{memberchk(Lang,['javascript','dart','java','c++','swift','rebol','haxe','c#','picat','scala'])}->
			"throw",ws_,A;
	{memberchk(Lang,['julia','e'])}->
			"throw",ws,"(",ws,A,ws,")";
	{memberchk(Lang,['visual basic .net'])}->
			"Throw",ws_,A;
	{memberchk(Lang,['perl','perl 6'])}->
			"die",ws_,A;
	{memberchk(Lang,['octave'])}->
			"error",ws,"(",ws,A,ws,")";
	{memberchk(Lang,['php'])}->
			"throw",ws_,"new",ws_,"Exception",ws,"(",ws,A,ws,")";
	{memberchk(Lang,['pseudocode'])}->
			statement_with_semicolon(Data1,_,throw(Expr1));
	{not_defined_for(Data,'throw')}).

statement_with_semicolon(Data,_,initialize_var(Type1,Name1,Value1)) -->
	{
		Data = [Lang|_],
		Name = var_name(Data,Type1,Name1),
		Type = type(Lang,Type1),
		Value = expr(Data,Type1,Value1)
	},
	({memberchk(Lang,[pseudocode])}->
		("var",ws_,Name,ws,"=",ws,Value;
		Type,ws,":",ws,Name,ws,"=",ws,Value;
		"var",ws,Name,ws,":",ws,Type,ws,":=",ws,Value;
		"let",ws_,"mutable",ws_,Name,ws,"=",ws,Value;
		"local",ws_,Name,ws,"=",ws,Value;
		"Dim",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
		(Type;"var"),ws_,Name,ws,"=",ws,Value;
		Type,ws_,Name,ws,"=",ws,Value;
		"my",ws_,Type,ws_,Name,ws,"=",ws,Value;
		"local",ws_,(Type,ws_;""),Name,ws,"=",ws,Value);
	{memberchk(Lang,['polish notation'])}->
        "=",ws_,Name,ws_,Value;
    {memberchk(Lang,['reverse polish notation'])}->
        Name,ws_,Value,ws_,"=";
    {memberchk(Lang,['go'])}->
        "var",ws_,Name,ws_,Type,ws,"=",ws,Value;
    {memberchk(Lang,['rust'])}->
        "let",ws_,"mut",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','dafny'])}->
        "var",ws,Name,ws,":",ws,Type,ws,":=",ws,Value;
    {memberchk(Lang,['z3'])}->
        "(",ws,"declare-const",ws_,Name,ws_,Type,ws,")",ws,"(",ws,"assert",ws_,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")";
    {memberchk(Lang,['f#'])}->
        "let",ws_,"mutable",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['common lisp'])}->
        "(",ws,"setf",ws_,Name,ws_,Value,ws,")";
    {memberchk(Lang,['minizinc'])}->
        Type,ws,":",ws,Name,ws,"=",ws,Value;
    {memberchk(Lang,['python','ruby','haskell','erlang','prolog','logtalk','julia','picat','octave','wolfram'])}->
        Name,ws,"=",ws,Value;
    {memberchk(Lang,['javascript','hack','swift'])}->
        "var",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','lua'])}->
        "local",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','janus'])}->
        "local",ws_,Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','perl'])}->
        "my",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','perl 6'])}->
        "my",ws_,Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','c','java','cosmos','c++','d','dart','englishscript','ceylon'])}->
        Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','c#','vala'])}->
        (Type;"var"),ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['rebol'])}->
        Name,ws,":",ws,Value;
    {memberchk(Lang,['pseudocode','visual basic','visual basic .net','openoffice basic'])}->
        "Dim",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
    {memberchk(Lang,['r'])}->
        Name,ws,"<-",ws,Value;
    {memberchk(Lang,['pseudocode','fortran'])}->
        Type,ws,"::",ws,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','chapel','haxe','scala','typescript'])}->
        "var",ws_,Name,(ws,":",Type,ws,ws;ws),"=",ws,Value;
    {memberchk(Lang,['monkey x'])}->
        "Local",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
    {memberchk(Lang,['vbscript'])}->
        "Dim",ws_,Name,ws_,"Set",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','seed7'])}->
        "var",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Value;
	{not_defined_for(Data,'initialize_var')}).

statement_with_semicolon(Data,_,append_to_array(Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Expr = expr(Data,Type,Expr1),
                Name = var_name(Data,[array,Type],Name1)
        },
        ({memberchk(Lang,[javascript])} ->
                Name,ws,".",ws,"push",ws,"(",ws,Expr,ws,")";
        {memberchk(Lang,[python])} ->
                Name,"+=","[",Expr,"]";
        {memberchk(Lang,[php])} ->
                "array_push",ws,"(",ws,Expr,ws,")";
        {memberchk(Lang,[lua])} ->
                Name,"[#",Name,ws,"+",ws,"1",ws,"]",ws,"=",ws,Expr;
        {not_defined_for(Data,'append_to_array')}).


statement_with_semicolon(Data,_,plus_equals(Name1,Expr1)) -->
        {
                Data = [Lang|_],
                A = var_name(Data,int,Name1),
                B = expr(Data,int,Expr1)
        },
        ({memberchk(Lang,['janus','nim','vala','perl 6','dart','visual basic .net','typescript','python','lua','java','c','c++','c#','javascript','haxe','php','chapel','perl','julia','scala','rust','go','swift'])}->
                A,ws,"+=",ws,B;
        {memberchk(Lang,['ruby','haskell','erlang','fortran','ocaml','minizinc','octave','delphi'])}->
                A,ws,"=",ws,A,ws,"+",ws,B;
        {memberchk(Lang,['picat'])}->
                A,ws,":=",ws,A,ws,"+",ws,B;
        {memberchk(Lang,['rebol'])}->
                A,ws,":",ws,A,ws,"+",ws,B;
        {memberchk(Lang,['livecode'])}->
                "add",ws_,B,ws_,"to",ws_,A;
        {memberchk(Lang,['seed7'])}->
                A,ws,"+:=",ws,B;
        {not_defined_for(Data,'plus_equals')}).
        
statement_with_semicolon(Data,_,minus_equals(Name1,Expr1)) -->
	{
		Data = [Lang|_],
		A = var_name(Data,int,Name1),
		B = expr(Data,int,Expr1)
	},
    ({memberchk(Lang,['janus','vala','nim','perl 6','dart','perl','visual basic .net','typescript','python','lua','java','c','c++','c#','javascript','php','haxe','hack','julia','scala','rust','go','swift'])}->
			A,ws,"-=",ws,B;
	{memberchk(Lang,['ruby','haskell','erlang','fortran','ocaml','minizinc','octave','delphi'])}->
			A,ws,"=",ws,A,ws,"-",ws,B;
	{memberchk(Lang,['picat'])}->
			A,ws,":=",ws,A,ws,"-",ws,B;
	{memberchk(Lang,['rebol'])}->
			A,ws,":",ws,A,ws,"-",ws,B;
	{memberchk(Lang,['livecode'])}->
			"subtract",ws_,B,ws_,"from",ws_,A;
	{memberchk(Lang,['seed7'])}->
			A,ws,"-:=",ws,B;
	{not_defined_for(Data,'minus_equals')}).

statement_with_semicolon(Data,_,append_to_string(Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Name = var_name(Data,string,Name1),
                Expr = expr(Data,string,Expr1)
        },
        ({memberchk(Lang,[c,java,'c#',javascript,python])} ->
                Name,ws,"+=",ws,Expr;
        {memberchk(Lang,[php,perl])} ->
                Name,ws,".=",ws,Expr;
        {memberchk(Lang,[lua])} ->
                Name,ws,"=",ws,Name,ws,"..",ws,Expr;
        {not_defined_for(Data,'append_to_string')}).

statement_with_semicolon(Data,_,times_equals(Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Name = var_name(Data,int,Name1),
                Expr = expr(Data,int,Expr1)
        },
        ({memberchk(Lang,[c,java,'c#',javascript,php,perl])} ->
                Name,ws,"*=",ws,Expr;
        {not_defined_for(Data,'*=')}).



statement_with_semicolon(Data,Type,print(Expr1)) -->
        {
                Data = [Lang|_],
                A = expr(Data,Type,Expr1)
        },
        ({memberchk(Lang,['ocaml'])}->
                "print_string",ws_,A;
        {memberchk(Lang,['minizinc'])}->
                "trace",ws,"(",ws,A,ws,",",ws,"true",ws,")";
        {memberchk(Lang,['perl 6'])}->
                "say",ws_,A;
        {memberchk(Lang,['erlang'])}->
                "io",ws,":",ws,"fwrite",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c++'])}->
                "cout",ws,"<<",ws,A;
        {memberchk(Lang,['haxe'])}->
                "trace",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['go'])}->
                "fmt",ws,".",ws,"Println",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c#'])}->
                "Console",ws,".",ws,"WriteLine",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['rebol','fortran','perl','php'])}->
                "print",ws_,A;
        {memberchk(Lang,['ruby'])}->
                "puts",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "System",ws,".",ws,"Console",ws,".",ws,"WriteLine",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['scala','julia','swift','picat'])}->
                "println",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['javascript','typescript'])}->
                "console",ws,".",ws,"log",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['python','englishscript','cython','ceylon','r','gosu','dart','vala','perl','php','hack','awk','lua'])}->
                "print",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['java'])}->
                "System",ws,".",ws,"out",ws,".",ws,"println",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c'])}->
                "printf",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['haskell'])}->
                "(",ws,"putStrLn",ws_,A,ws,")";
        {memberchk(Lang,['hy','common lisp','crosslanguage'])}->
                "(",ws,"print",ws_,A,ws,")";
        {memberchk(Lang,['rust'])}->
                "println!(",ws,A,ws,")";
        {memberchk(Lang,['octave'])}->
                "disp",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['chapel','d','seed7','prolog'])}->
                "writeln",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['delphi'])}->
                "WriteLn",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['frink'])}->
                "print",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['wolfram'])}->
                "Print",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['z3'])}->
                "(",ws,"echo",ws_,A,ws,")";
        {memberchk(Lang,['monkey x'])}->
                "Print",ws_,A;
        {not_defined_for(Data,'print')}).
