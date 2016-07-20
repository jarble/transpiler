statement_with_semicolon(Data,_,prolog_concatenate_string(Mode,Output_,Str1_,Str2_)) --> 
{
	Data = [Lang|_],
	(Mode = return, Output = "Return";Output = parentheses_expr(Data,string,Output_)),
	Str1 = parentheses_expr(Data,string,Str1_),
	Str2 = parentheses_expr(Data,string,Str2_)
},
	({Lang='prolog'}-> ("string_concat",ws,"(",ws,Str1,ws,",",ws,Str2,ws,",",Output,")");
	set_or_initialize_var(Data, Mode, Output, concatenate_string(Data,Str1,Str2),string)).

statement_with_semicolon(Data,_,prolog_function_call(Mode,Type,Name1,Params1,Params2,Output_)) --> 
	{
		Data = [Lang|_],
		(Mode = return, Output = "Return";Output = parentheses_expr(Data,Type,Output_)),
		Name = function_name(Data,Type,Name1,Params2),
		(Args = function_call_parameters(Data,Params1,Params2))
	},
	({Lang='prolog'}-> (Name,ws,"(",ws,Args,ws,",",ws,Output,ws,")");
	set_or_initialize_var(Data, Mode, Output, function_call(Data,Name,Args),Type)).



statement_with_semicolon(Data,_,prolog_array_length(Mode,Type,Array_,Output_)) --> 
{
	Data = [Lang|_],
	(Mode = return, Output = "Return";Output = parentheses_expr(Data,int,Output_)),
	Array = parentheses_expr(Data,[array,Type],Array_)
},
	({Lang='prolog'}-> ("length",ws,"(",ws,Array,ws,",",ws,Output,ws,")");
	set_or_initialize_var(Data, Mode, Output, array_length(Data,Array),Type)).
	
statement_with_semicolon(Data,_,prolog_access_array(Mode,Type,Output_,Str1_,Str2_)) --> 
{
	Data = [Lang|_],
	(Mode = return, Output = "Return";Output = parentheses_expr(Data,Type,Output_)),
	Array = parentheses_expr(Data,[array,Type],Str1_),
	Index = parentheses_expr(Data,int,Str2_)
},
	({Lang='prolog'}-> ("nth0",ws,"(",ws,Index,ws,",",ws,Array,ws,",",ws,Output,ws,")");
	set_or_initialize_var(Data, Mode, Output, access_array(Data,Array,Index),Type)).

statement_with_semicolon(Data,_,prolog_access_array(Mode,Type,Output_,Str1_,Str2_)) --> 
{
	Data = [Lang|_],
	(Mode = return, Output = "Return";Output = parentheses_expr(Data,Type,Output_)),
	Array = parentheses_expr(Data,[array,Type],Str1_),
	Value = parentheses_expr(Data,Type,Str2_)
},
	({Lang='prolog'}-> ("nth0",ws,"(",ws,Value,ws,",",ws,Array,ws,",",ws,Output,ws,")");
	set_or_initialize_var(Data, Mode, Output, index_in_array(Data,Array,Value),int)).

statement_with_semicolon(Data,_,prolog_append_array(Mode,Type,Output_,A1_,A2_)) --> 
{
	Data = [Lang|_],
	(Mode = return, Output = "Return";Output = parentheses_expr(Data,[array,Type],Output_)),
	A1= parentheses_expr(Data,[array,Type],A1_),
	A2 = parentheses_expr(Data,[array,Type],A2_)
},
	({Lang='prolog'}-> ("append",ws,"(",ws,A1,ws,",",ws,A2,ws,",",ws,Output,ws,")");
	set_or_initialize_var(Data, Mode, Output, concatenate_arrays(Data,A1,A2),[array,Type])).

statement_with_semicolon(Data,_,prolog_split_string(Mode,Output_,Str1_,Str2_)) --> 
{
	Data = [Lang|_],
	(Mode = return, Output = "Return"; Output = parentheses_expr(Data,string,Output_)),
	Str1 = parentheses_expr(Data,string,Str1_),
	Str2 = parentheses_expr(Data,string,Str2_)
},
	({Lang='prolog'}-> ("split_string",ws,"(",ws,Str1,ws,",",ws,Str2,ws,",",ws,"\"\"",ws,",",ws,Output,ws,")");
	set_or_initialize_var(Data, Mode, Output, split(Data,Str1,Str2),string)).

statement_with_semicolon(Data,Return_type,return(To_return1)) --> 
	{
			A = expr(Data,Return_type,To_return1)
	},
	return(Data,A).
	
statement_with_semicolon(Data,_,plus_plus(Name1)) --> 
        {
                Name = var_name(Data,int,Name1)
        },
        langs_to_output(Data,plus_plus,[
        [javascript,java,c]:
			(Name,ws,"++")
        ]).

statement_with_semicolon(Data,_,minus_minus(Name1)) --> 
        {
			Name = var_name(Data,int,Name1)
        },
        langs_to_output(Data,minus_minus,[
        [javascript,java]:
			(Name,ws,"--")
		]).

statement_with_semicolon(Data,_,initialize_constant(Type1,Name1,Expr1)) -->
        {
                Value = expr(Data,Type1,Expr1),
                Type = type(Data,Type1),
                Name = var_name(Data,Type1,Name1)
        },
        initialize_constant(Data,Name,Type,Value).
        


statement_with_semicolon(Data,Type, function_call(Name1,Params1)) -->
	parentheses_expr(Data,Type, function_call(Name1,Params1)).

statement_with_semicolon(Data,_,set_array_size(Name1,Size1,Type1)) -->
		{
			Name = var_name(Data,Name1,[array,Type]),
			Size = expr(Data,int,Size1),
			Type = type(Data,Type1)
			
		},
		set_array_size(Data,Name,Size,Type).
		
		

statement_with_semicolon(Data,_,set_dict(Name1,Index1,Expr1,Type)) -->
	{
		Name = var_name(Data,[dict,Type],Name1),
		Index = symbol(Index1),
		Value = expr(Data,Type,Expr1)
	},
	langs_to_output(Data,set_dict,[
    ['javascript','lua','c++','haxe','c#','ruby']:
			(Name,ws,"[\"",ws,Index,ws,"\"]",ws,"=",ws,Value),
	['gnu smalltalk']:
			(Name,ws_,"at:",ws_,Index,ws_,"put:",ws_,Value),
	['prolog']:
			("member",ws,"(",ws,Name,ws,",",ws,Index,ws,"-",ws,Value,ws,")"),
	['java']:	
			(Name,ws,".",ws,"put",ws,"(",ws,Value,ws,")")
	]).

statement_with_semicolon(Data,_,set_array_index(Name1,Index1,Expr1,Type)) -->
	{
		Data = [Lang|_],
		Name = var_name(Data,[array,Type],Name1),
		Index = parentheses_expr(Data,int,Index1),
		Value = parentheses_expr(Data,Type,Expr1)
	},
	({Lang='prolog'}->
		("nth0",ws,"(",ws,Index,ws,",",ws,Name,ws,",",ws,Value,ws,")");
	set_var(Data,access_array(Data,Name,Index),Value)).


statement_with_semicolon(Data,_,set_var(Name1,Expr1,Type)) -->
	{
		Name = var_name(Data,Type,Name1),
		Value = expr(Data,Type,Expr1)
	},
	set_var(Data,Name,Value).
	
	

statement_with_semicolon(Data,_,initialize_empty_var(Type1,Name1)) -->
	{
			Name = var_name(Data,Type1,Name1),
			Type = type(Data,Type1)
	},
    langs_to_output(Data,initialize_empty_var,[
    ['swift','scala','typescript']:
			("var",ws_,Name,ws,":",ws,Type),
	['java','c#','c++','c','d','janus','fortran','dart']:
			(Type,ws_,Name),
	['prolog']:
			(Type,ws,"(",ws,Name,ws,")"),
	['javascript','haxe']:
			("var",ws_,Name),
	['minizinc']:
			(Type,ws,":",ws,Name),
	['pascal']:
			(Name,ws,":",ws,Type),
	['go']:
			("var",ws_,Name,ws_,Type),
	['z3']:
			("(",ws,"declare-const",ws_,Name,ws_,Type,ws,")"),
	['julia']:
			("local",ws_,Name),
	['perl']:
			("my",ws_,Name),
	['perl 6']:
			("my",ws_,Type,ws_,Name),
	['z3py']:
			(Name,ws,"=",ws,Type,ws,"(",ws,"'",ws,Name,ws,"'",ws,")")
	]).

statement_with_semicolon(Data,_,throw(Expr1)) -->
	{
			A = expr(Data,string,Expr1)
	},
	langs_to_output(Data,throw,[
	['ocaml']:
			("raise",ws_,A),
	['javascript','dart','java','c++','swift','rebol','haxe','c#','picat','scala']:
			("throw",ws_,A),
	['julia','e']:
			("throw",ws,"(",ws,A,ws,")"),
	['perl','perl 6']:
			("die",ws_,A),
	['octave']:
			("error",ws,"(",ws,A,ws,")"),
	['php']:
			("throw",ws_,"new",ws_,"Exception",ws,"(",ws,A,ws,")"),
	['pseudocode']:
			(statement_with_semicolon(Data,_,throw(Expr1)))
	]).

statement_with_semicolon(Data,_,initialize_var(Name1,Expr1,Type1)) -->
	{
		Name = var_name(Data,Type1,Name1),
		Type = type(Data,Type1),
		Expr = expr(Data,Type1,Expr1)
	},
	initialize_var(Data,Name,Expr,Type).

statement_with_semicolon(Data,_,append_to_array(Name1,Expr1)) -->
        {
                Expr = expr(Data,Type,Expr1),
                Name = var_name(Data,[array,Type],Name1)
        },
        langs_to_output(Data,append_to_array,[
        ['javascript']:
                (Name,ws,".",ws,"push",ws,"(",ws,Expr,ws,")"),
        [php]:
                ("array_push",ws,"(",ws,Expr,ws,")")
        ]).


statement_with_semicolon(Data,_,plus_equals(Name1,Expr1)) -->
        {
                A = var_name(Data,int,Name1),
                B = expr(Data,int,Expr1)
		},
        langs_to_output(Data,plus_equals,[
        ['janus','visual basic','visual basic .net','nim','python','vala','perl 6','dart','typescript','java','c','c++','c#','javascript','haxe','php','chapel','perl','julia','scala','rust','go','swift']:
                (A,python_ws,"+=",python_ws,B),
        ['haskell','ruby','lua','erlang','fortran','ocaml','minizinc','octave','delphi']:
                (A,ws,"=",ws,A,ws,"+",ws,B),
        ['picat']:
                (A,ws,":=",ws,A,ws,"+",ws,B),
        ['rebol']:
                (A,ws,":",ws,A,ws,"+",ws,B),
        ['livecode']:
                ("add",ws_,B,ws_,"to",ws_,A),
        ['seed7']:
                (A,ws,"+:=",ws,B)
        ]).
        
statement_with_semicolon(Data,_,minus_equals(Name1,Expr1)) -->
	{
		A = var_name(Data,int,Name1),
		B = expr(Data,int,Expr1)
	},
    langs_to_output(Data,minus_equals,[
    ['janus','visual basic','visual basic .net','vala','nim','perl 6','dart','perl','typescript','java','c','c++','c#','javascript','php','haxe','hack','julia','scala','rust','go','swift']:
			(A,python_ws,"-=",python_ws,B),
	['haskell','erlang','fortran','ocaml','minizinc','octave','delphi']:
			(A,ws,"=",ws,A,ws,"-",ws,B),
	['picat']:
			(A,ws,":=",ws,A,ws,"-",ws,B),
	['rebol']:
			(A,ws,":",ws,A,ws,"-",ws,B),
	['livecode']:
			("subtract",ws_,B,ws_,"from",ws_,A),
	['seed7']:
			(A,ws,"-:=",ws,B)
    ]).
statement_with_semicolon(Data,_,append_to_string(Name1,Expr1)) -->
        {
                Name = var_name(Data,string,Name1),
                Expr = expr(Data,string,Expr1)
        },
        langs_to_output(Data,append_to_string,[
        [c,java,'c#',javascript]:
                (Name,python_ws,"+=",python_ws,Expr),
        [php,perl]:
                (Name,ws,".=",ws,Expr)
        ]).

statement_with_semicolon(Data,_,times_equals(Name1,Expr1)) -->
        {
                Name = var_name(Data,int,Name1),
                Expr = expr(Data,int,Expr1)
        },
        langs_to_output(Data,times_equals,[
        [c,java,'c#',javascript,php,perl]:
                (Name,ws,"*=",ws,Expr)
        ]).

statement_with_semicolon(Data,_,assert(Expr1)) -->
        {
                A = expr(Data,bool,Expr1)
        },
        langs_to_output(Data,assert,[
		['javascript','scala','c','c++','lua','swift','php','ceylon']:
                ("assert",ws,"(",ws,A,ws,")"),
        ['c#','visual basic .net']:
                ("Debug",ws,".",ws,"Assert",ws,"(",ws,A,ws,")"),
        ['clojure']:
                ("(",ws,"assert",ws_,A,ws,")"),
        ['r']:
                ("stopifnot",ws,"(",ws,A,ws,")"),
		['python']:
				("assert",python_ws_,A),
		['java','haskell']:
				("assert",ws_,A)
		]).

%print without newline
statement_with_semicolon(Data,_,print(Expr1,Type)) -->
        {
                A = expr(Data,Type,Expr1)
        },
        langs_to_output(Data,print,[
        ['java']:
			("System",ws,".",ws,"out",ws,".",ws,"print",ws,"(",ws,A,ws,")"),
		['java']:
			("Console",ws,".",ws,"Write",ws,"(",ws,A,ws,")"),
		['prolog']:
			("write",ws,"(",ws,A,ws,")"),
		['perl']:
			("print",ws,"(",ws,A,ws,")"),
		['lua']:
			("io",ws,".",ws,"write",ws,"(",ws,A,ws,")"),
		['php']:
			("echo",ws_,A),
		['c++']:
			("cout",ws,"<<",ws,A)
        ]).

%print with newline
statement_with_semicolon(Data,Type,println(Expr1)) -->
        {
                A = expr(Data,Type,Expr1)
        },
		langs_to_output(Data,println,[
		['ocaml']:
                ("print_string",ws_,A),
        ['minizinc']:
                ("trace",ws,"(",ws,A,ws,",",ws,"true",ws,")"),
        ['perl 6']:
                ("say",ws_,A),
        ['erlang']:
                ("io",ws,":",ws,"fwrite",ws,"(",ws,A,ws,")"),
        ['c++']:
                ("cout",ws,"<<",ws,A,"<<",ws,"endl"),
        ['haxe']:
                ("trace",ws,"(",ws,A,ws,")"),
        ['go']:
                ("fmt",ws,".",ws,"Println",ws,"(",ws,A,ws,")"),
        ['c#','visual basic .net']:
                ("Console",ws,".",ws,"WriteLine",ws,"(",ws,A,ws,")"),
        ['rebol','fortran','perl','php']:
                ("print",ws_,A),
        ['ruby']:                            
                ("puts",ws,"(",ws,A,ws,")"),
        ['python']:                            
                ("print",python_ws,"(",python_ws,A,python_ws,")"),
        ['scala','julia','swift','picat']:
                ("println",ws,"(",ws,A,ws,")"),
        ['javascript','typescript']:
                ("console",ws,".",ws,"log",ws,"(",ws,A,ws,")"),
        ['englishscript','cython','ceylon','r','gosu','dart','vala','perl','php','hack','awk']:
                ("print",python_ws,"(",python_ws,A,python_ws,")"),
        ['java']:
                ("System",ws,".",ws,"out",ws,".",ws,"println",ws,"(",ws,A,ws,")"),
        ['c']:
                ("printf",ws,"(",ws,A,ws,")"),
        ['haskell']:
                ("(",ws,"putStrLn",ws_,A,ws,")"),
        ['hy','common lisp']:
                ("(",ws,"print",ws_,A,ws,")"),
        ['rust']:
                ("println!(",ws,A,ws,")"),
        ['octave']:
                ("disp",ws,"(",ws,A,ws,")"),
        ['chapel','d','seed7','prolog']:
                ("writeln",ws,"(",ws,A,ws,")"),
        ['delphi']:
                ("WriteLn",ws,"(",ws,A,ws,")"),
        ['frink']:
                ("print",ws,"[",ws,A,ws,"]"),
        ['wolfram']:
                ("Print",ws,"[",ws,A,ws,"]"),
        ['z3']:
                ("(",ws,"echo",ws_,A,ws,")"),
        ['monkey x']:
                ("Print",ws_,A)
        ]).
