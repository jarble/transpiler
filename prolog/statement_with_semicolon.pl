%The grammar files are saved in grammars.pl

statement_with_semicolon(Data,Return_type,return(To_return1)) -->
	return_(Data,[expr(Data,Return_type,To_return1)]).
	
statement_with_semicolon(Data,_,plus_plus(Name)) --> 
        plus_plus_(Data,[
			var_name_(Data,int,Name)
        ]).

statement_with_semicolon(Data,_,minus_minus(Name)) --> 
	minus_minus_(Data,[var_name_(Data,int,Name)]).

statement_with_semicolon(Data,_,initialize_constant(Type,Name,Expr)) -->
	initialize_constant_(Data,[
		var_name_(Data,Type,Name),
		type(Data,Type),
		expr(Data,Type,Expr)
	]).


statement_with_semicolon(Data,Type, function_call(Name,Params1,Params2)) -->
    function_call_(Data,[
		function_name(Data,Type,Name,Params2),
		function_call_parameters(Data,Params1,Params2)
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
		symbol(Index),
		expr(Data,Type,Expr)
	]).
statement_with_semicolon(Data,_,set_array_index(Name,Index,Expr,Type)) -->
	set_array_index_(Data,[
		var_name_(Data,[array,Type],Name),
		parentheses_expr(Data,int,Index),
		parentheses_expr(Data,Type,Expr)
	]).


statement_with_semicolon(Data,_,set_var(Name1,Expr1,Type)) -->
	set_var_(Data,[
		var_name_(Data,Type,Name1),
		expr(Data,Type,Expr1)
	]).
	
	

statement_with_semicolon(Data,_,initialize_empty_var(Type1,Name1)) -->
	initialize_empty_var_(Data,[
		var_name_(Data,Type1,Name1),
		type(Data,Type1)
	]).

statement_with_semicolon(Data,_,throw(Expr1)) -->
	throw_(Data,expr(Data,string,Expr1)).

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


statement_with_semicolon(Data,_,plus_equals(Name,Expr)) -->
		plus_equals_(Data,[
			var_name_(Data,int,Name),
            expr(Data,int,Expr)
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

%print without newline
statement_with_semicolon(Data,_,print(Expr,Type)) -->
        print_(Data,[expr(Data,Type,Expr)]).

%print with newline
statement_with_semicolon(Data,Type,println(Expr)) -->
        println_(Data,[
			expr(Data,Type,Expr)
		]).

statement_with_semicolon(Data,_,initialize_vars(Vars,Type)) -->
		initialize_vars_(Data,[
			initialize_vars_list(Data,Type,Vars),
			type(Data,Type)
		]).
statement_with_semicolon(Data,_,declare_vars(Vars,Type)) -->
		declare_vars_(Data,[
			vars_list(Data,Type,Vars),
			type(Data,Type)
		]).

%This is for parallel assignment.
statement_with_semicolon(Data,_,multiple_assignment(Vars,Exprs,Type)) -->
		multiple_assignment_(Data,[
			vars_list(Data,Type,Vars),
			initializer_list_(Data,Type,Exprs),
			type(Data,Type)
		]).
