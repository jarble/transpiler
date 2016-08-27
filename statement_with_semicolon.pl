%The grammar files are saved in grammars_old.pl

statement_with_semicolon(Data,Return_type,return(To_return1)) -->
	{
			A = expr(Data,Return_type,To_return1)
	},
	return_(Data,[A]).
	
statement_with_semicolon(Data,_,plus_plus(Name1)) --> 
        {
                Name = var_name_(Data,int,Name1)
        },
        plus_plus_(Data,[Name]).

statement_with_semicolon(Data,_,minus_minus(Name1)) --> 
        {
			Name = var_name_(Data,int,Name1)
        },minus_minus_(Data,[Name]).

statement_with_semicolon(Data,_,initialize_constant(Type1,Name1,Expr1)) -->
        {
                Value = expr(Data,Type1,Expr1),
                Type = type(Data,Type1),
                Name = var_name_(Data,Type1,Name1)
        },
        initialize_constant_(Data,[Name,Type,Value]).

statement_with_semicolon(Data,Type, function_call(Name1,Params1)) -->
	parentheses_expr(Data,Type, function_call(Name1,Params1)).

statement_with_semicolon(Data,_,set_array_size(Name1,Size1,Type1)) -->
		{
			Name = var_name_(Data,Name1,[array,Type]),
			Size = expr(Data,int,Size1),
			Type = type(Data,Type1)
			
		},
		set_array_size_(Data,[Name,Size,Type]).
		
		

statement_with_semicolon(Data,_,set_dict(Name1,Index1,Expr1,Type)) -->
	{
		Name = var_name_(Data,[dict,Type],Name1),
		Index = symbol(Index1),
		Value = expr(Data,Type,Expr1)
	},
	set_dict_(Data,[Name,Index,Value]).
statement_with_semicolon(Data,_,set_array_index(Name1,Index1,Expr1,Type)) -->
	{
		Name = var_name_(Data,[array,Type],Name1),
		Index = parentheses_expr(Data,int,Index1),
		Value = parentheses_expr(Data,Type,Expr1)
	},
	set_array_index_(Data,[Name,Index,Value]).


statement_with_semicolon(Data,_,set_var(Name1,Expr1,Type)) -->
	{
		Name = var_name_(Data,Type,Name1),
		Value = expr(Data,Type,Expr1)
	},
	set_var_(Data,[Name,Value]).
	
	

statement_with_semicolon(Data,_,initialize_empty_var(Type1,Name1)) -->
	{
			Name = var_name_(Data,Type1,Name1),
			Type = type(Data,Type1)
	},
	initialize_empty_var_(Data,[Name,Type]).

statement_with_semicolon(Data,_,throw(Expr1)) -->
	{
			A = expr(Data,string,Expr1)
	},
	throw_(Data,A).

statement_with_semicolon(Data,_,initialize_var(Name1,Expr1,Type1)) -->
	{
		Name = var_name_(Data,Type1,Name1),
		Type = type(Data,Type1),
		Expr = expr(Data,Type1,Expr1)
	},
	initialize_var_(Data,[Name,Expr,Type]).

statement_with_semicolon(Data,_,append_to_array(Name1,Expr1)) -->
        {
                Expr = expr(Data,Type,Expr1),
                Name = var_name_(Data,[array,Type],Name1)
        },
        append_to_array_(Data,[Name,Expr]).


statement_with_semicolon(Data,_,plus_equals(Name1,Expr1)) -->
        {
                A = var_name_(Data,int,Name1),
                B = expr(Data,int,Expr1)
		},
		plus_equals_(Data,[A,B]).
        
statement_with_semicolon(Data,_,minus_equals(Name1,Expr1)) -->
	{
		A = var_name_(Data,int,Name1),
		B = expr(Data,int,Expr1)
	},
	minus_equals_(Data,[A,B]).
statement_with_semicolon(Data,_,append_to_string(Name1,Expr1)) -->
        {
                Name = var_name_(Data,string,Name1),
                Expr = expr(Data,string,Expr1)
        },
        append_to_string_(Data,[Name,Expr]).

statement_with_semicolon(Data,_,times_equals(Name1,Expr1)) -->
        {
                Name = var_name_(Data,int,Name1),
                Expr = expr(Data,int,Expr1)
        },
        times_equals_(Data,[Name,Expr]).

statement_with_semicolon(Data,_,assert(Expr1)) -->
        {
                A = expr(Data,bool,Expr1)
        },
        assert_(Data,[A]).

%print without newline
statement_with_semicolon(Data,_,print(Expr1,Type)) -->
        {
                A = expr(Data,Type,Expr1)
        },
        print_(Data,[A]).

%print with newline
statement_with_semicolon(Data,Type,println(Expr1)) -->
        {
                A = expr(Data,Type,Expr1)
        },
        println_(Data,[A]).

statement_with_semicolon(Data,_,initialize_vars(Vars1,Type1)) -->
		{Type = type(Data,Type1),
		Vars = initialize_vars_list(Data,Type1,Vars1)},
		initialize_vars_(Data,[Vars,Type]).
statement_with_semicolon(Data,_,declare_vars(Vars1,Type1)) -->
		{Type = type(Data,Type1),
		Vars = vars_list(Data,Type1,Vars1)},
		declare_vars_(Data,[Vars,Type]).

%This is for parallel assignment.
statement_with_semicolon(Data,_,multiple_assignment(Vars1,Exprs1,Type1)) -->
		{
			Type = type(Data,Type1),
			Vars = vars_list(Data,Type1,Vars1),
			Exprs = initializer_list_(Data,Type1,Exprs1)
		},
		multiple_assignment_(Data,[Vars,Exprs,Type]).

statement_with_semicolon(Data,_,set_same_value(Vars1,Expr1,Type1)) -->
		{
			Type = type(Data,Type1),
			Vars = set_same_value(Data,Type1,Vars1),
			Exprs = expr(Data,Type1,Expr1)
		},
		set_same_value_(Data,[Vars,Expr,Type]).
