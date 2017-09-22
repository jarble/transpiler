%The grammar files are saved in grammars.pl

statement_with_semicolon(Data,Type,println(Expr,Type)) -->
        println_(Data,[
			expr(Data,Type,Expr),
			Type
		]).

statement_with_semicolon(Data,Return_type,return(To_return)) -->
	return_(Data,[
		expr(Data,Return_type,To_return)
	]).
	
statement_with_semicolon(Data,_,plus_plus(Name)) --> 
        plus_plus_(Data,[
			var_name_(Data,int,Name)
        ]),!.

statement_with_semicolon(Data,_,minus_minus(Name)) --> 
	minus_minus_(Data,[var_name_(Data,int,Name)]),!.

statement_with_semicolon(Data,_,initialize_constant(Type,Name,Expr)) -->
	initialize_constant_(Data,[
		var_name_(Data,Type,Name),
		type(Data,Type),
		expr(Data,Type,Expr)
	]).


statement_with_semicolon(Data,_,set_array_size(Name,Size,Type)) -->
	set_array_size_(Data,[
		var_name_(Data,Name,[array,Type]),
		expr(Data,int,Size),
		type(Data,Type)
	]).

statement_with_semicolon(Data,_,set_dict(Name,Index,Expr,Type)) -->
	set_dict_(Data,[
		var_name_(Data,[dict,Type],Name),
		parentheses_expr(Data,string,Index),
		expr(Data,Type,Expr)
	]).
statement_with_semicolon(Data,_,set_array_index(Name,Index,Expr,Type)) -->
	set_array_index_(Data,[
		var_name_(Data,[array,Type],Name),
		parentheses_expr(Data,int,Index),
		parentheses_expr(Data,Type,Expr)
	]).


statement_with_semicolon(Data,_,set_var(Name,Expr,Type)) -->
	set_var_(Data,[
		var_name_(Data,Type,Name),
		expr(Data,Type,Expr)
	]).
	
statement_with_semicolon(Data,_,set_instance_var(Name,Expr,Type)) -->
	set_var_(Data,[
		expr(Data,Type,this(Name)),
		expr(Data,Type,Expr)
	]).	

statement_with_semicolon(Data,_,initialize_empty_var(Type,Name)) -->
	initialize_empty_var_(Data,[
		var_name_(Data,Type,Name),
		type(Data,Type)
	]).

statement_with_semicolon(Data,_,throw(Expr)) -->
	throw_(Data,expr(Data,string,Expr)).

statement_with_semicolon(Data,_,initialize_var(Name,Expr,Type)) -->
	initialize_var_(Data,[
		var_name_(Data,Type,Name),
		expr(Data,Type,Expr),
		type(Data,Type)
	]).

statement_with_semicolon(Data,_,append_to_array(Name,Expr,Type)) -->
        append_to_array_(Data,[
			var_name_(Data,[array,Type],Name),
            expr(Data,Type,Expr)
        ]).

statement_with_semicolon(Data,_,reverse_list_in_place(List,Type)) -->
	reverse_list_in_place_(Data,[
		parentheses_expr(Data,[array,Type],List)
	]).


statement_with_semicolon(Data,_,plus_equals(Name,Expr)) -->
		plus_equals_(Data,[
			var_name_(Data,int,Name),
            expr(Data,int,Expr)
		]).

statement_with_semicolon(Data,_,divide_equals(Name,Expr)) -->
		divide_equals_(Data,[
			var_name_(Data,int,Name),
            expr(Data,int,Expr)
		]).


statement_with_semicolon(Data,_,modulo_equals(Name,Expr)) -->
		modulo_equals_(Data,[
			var_name_(Data,int,Name),
            expr(Data,int,Expr)
		]).

statement_with_semicolon(Data,_,array_plus_equals(Name,Expr,Type)) -->
		array_plus_equals_(Data,[
			var_name_(Data,[array,Type],Name),
            expr(Data,[array,Type],Expr)
		]).

statement_with_semicolon(Data,_,string_plus_equals(Name,Expr)) -->
		string_plus_equals_(Data,[
			var_name_(Data,string,Name),
            expr(Data,string,Expr)
		]).

statement_with_semicolon(Data,_,minus_equals(Name,Expr)) -->
	minus_equals_(Data,[
		var_name_(Data,int,Name),
		expr(Data,int,Expr)
	]).
statement_with_semicolon(Data,_,append_to_string(Name,Expr)) -->
	append_to_string_(Data,[
		var_name_(Data,string,Name),
		expr(Data,string,Expr)
	]).


statement_with_semicolon(Data,_,times_equals(Name,Expr)) -->
	times_equals_(Data,[
		var_name_(Data,int,Name),
		expr(Data,int,Expr)
	]).

statement_with_semicolon(Data,_,assert(Expr)) -->
        assert_(Data,[expr(Data,bool,Expr)]).

statement_with_semicolon(Data,Type, function_call(Name,Params1,Params2)) -->
    function_call_(Data,[
		function_name(Data,Type,Name,Params2),
		function_call_parameters(Data,Params1,Params2)
	]).
