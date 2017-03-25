parentheses_expr(_,char,char_literal(A)) -->
	char_literal(A).

parentheses_expr(_,string,string_literal(A)) -->
	string_literal(A).


parentheses_expr(Data,Type1,anonymous_function(Type1,Params1,Body1)) -->
        anonymous_function_(Data,[
			type(Data,Type1),
			parameters(Data,Params1),
			statements(Data,Type1,Body1)
        ]).

parentheses_expr(Data,bool,"true") -->
	true_(Data).
parentheses_expr(Data,bool,"false") -->
	false_(Data).

parentheses_expr(Data,[array,Type],initializer_list(A)) -->
	initializer_list_(Data,[
		initializer_list_(Data,Type,A),
		type(Data,Type)
	]).

parentheses_expr(Data,[dict,Type1],dict(A)) -->
	dict_(Data,[
		dict_(Data,Type1,A),
		type(Data,Type1)
	]).

%should be inclusive range
parentheses_expr(Data,[array,int],range(A,B)) -->
	range_(Data,[
		parentheses_expr(Data,int,A),
		expr(Data,int,B)
	]).

parentheses_expr(Data,Type,var_name(A)) -->
	var_name_(Data,Type,A).

parentheses_expr(_,int,an_int(A)) -->
	an_int(A).
parentheses_expr(_,double,a_double(A)) -->
	a_double(A).

parentheses_expr(Data,Type,parentheses(A)) -->
	"(",ws,expr(Data,Type,A),ws,")".

parentheses_expr(Data,Type, function_call(Name,Params1,Params2)) -->
    function_call_(Data,[
		function_name(Data,Type,Name,Params2),
		function_call_parameters(Data,Params1,Params2)
	]),
	{reserved_words(Name)}.
