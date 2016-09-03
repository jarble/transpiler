parentheses_expr(_,string,string_literal(A)) -->
	string_literal(A).

parentheses_expr(Data,Type, function_call(Name1,Params1,Params2)) -->
    function_call_(Data,[
		function_name(Data,Type,Name1,Params2),
		function_call_parameters(Data,Params1,Params2)
	]).


parentheses_expr(Data,Type2,type_conversion(Type1,Arg1)) -->
        type_conversion_(Data,[Type1,Type2,parentheses_expr(Data,Type1,Arg1)]).

parentheses_expr(Data,Type1,anonymous_function(Type1,Params1,Body1)) -->
        {
                B = statements(Data,Type1,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data,Params1)),
                Type = type(Data,Type1)
        },
        anonymous_function_(Data,[Type,Params,B]).
        
parentheses_expr(Data,int,floor(Params1)) -->
        floor_(Data,[
			expr(Data,int,Params1)
		]).

parentheses_expr(Data,int,ceiling(Params1)) -->
        ceiling_(Data,[
			expr(Data,int,Params1)
		]).

parentheses_expr(Data,int,cos(Var1_)) -->
        cos_(Data,[
			expr(Data,int,Var1_)
        ]).
        
parentheses_expr(Data,double,sin(Var1_,Type1)) -->
        {member(Type1,[int,double])},
        sin_(Data,[expr(
			Data,Type1,Var1_)
		]).

parentheses_expr(Data,double,abs(Var1)) -->
        abs_(Data,[
			expr(Data,double,Var1)
		]).
        
parentheses_expr(Data,double,cosh(Var1)) -->
        cosh_(Data,[
			expr(Data,double,Var1)
        ]).


parentheses_expr(Data,double,sinh(Var1)) -->
        sinh_(Data,[
			expr(Data,double,Var1)
        ]).

%inverse tangent or arctan
parentheses_expr(Data,double,atan(Var1)) -->
        atan_(Data,[
			expr(Data,double,Var1)
        ]).

%inverse sine or arcsine
parentheses_expr(Data,double,asin(Var)) -->
	asin_(Data,[
		expr(Data,double,Var)
	]).

%inverse cosine or arccosine
parentheses_expr(Data,double,acos(Var)) -->
	acos_(Data,[
		expr(Data,double,Var)
	]).

parentheses_expr(Data,bool,"true") -->
	true_(Data).
parentheses_expr(Data,bool,"false") -->
	false_(Data).
	
parentheses_expr(Data,int,tan(Var)) -->
	tan_(Data,[
		expr(Data,int,Var)
	]).

parentheses_expr(Data,[array,Type],initializer_list(A)) -->
	initializer_list_(Data,[
		initializer_list_(Data,Type,A),
		type(Data,Type)
	]).

parentheses_expr(Data,[dict,Type1],dict(A)) -->
	dict_(Data,[
		dict_(Data,Type1,A)
	]).

%should be inclusive range
parentheses_expr(Data,[array,int],range(A,B)) -->
	range_(Data,[
		parentheses_expr(Data,int,A),
		expr(Data,int,B)
	]).

parentheses_expr(Data,Type,var_name(A)) -->
	var_name_(Data,Type,A).
parentheses_expr(_,int,a_number(A)) -->
	a_number(A).
parentheses_expr(Data,Type,parentheses(A)) -->
	"(",ws,expr(Data,Type,A),ws,")".
