parentheses_expr(_,string,string_literal(A)) -->
	string_literal(A).

parentheses_expr(Data,Type, function_call(Name1,Params1,Params2)) -->
	{
			Name = function_name(Data,Type,Name1,Params2),
			(Args = function_call_parameters(Data,Params1,Params2))
	},
    function_call_(Data,[Name,Args]).


parentheses_expr(Data,Type2,type_conversion(Type1,Arg1)) -->
        {
                Arg = parentheses_expr(Data,Type1,Arg1)
        },
        type_conversion_(Data,[Type1,Type2,Arg]).

parentheses_expr(Data,Type1,anonymous_function(Type1,Params1,Body1)) -->
        {
                B = statements(Data,Type1,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data,Params1)),
                Type = type(Data,Type1)
        },
        anonymous_function_(Data,[Type,Params,B]).
        
parentheses_expr(Data,int,floor(Params1)) -->
        {Params = expr(Data,int,Params1)},
        floor_(Data,[Params]).

parentheses_expr(Data,int,ceiling(Params1)) -->
        {Params = expr(Data,int,Params1)},
        ceiling_(Data,[Params]).

parentheses_expr(Data,int,cos(Var1_)) -->
        {Var1 = expr(Data,int,Var1_)},
        cos_(Data,[Var1]).     
        
parentheses_expr(Data,double,sin(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        sin_(Data,[Var1]).

parentheses_expr(Data,double,abs(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        abs_(Data,[Var1]).
        
parentheses_expr(Data,double,cosh(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        cosh_(Data,[Var1]).


parentheses_expr(Data,double,sinh(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        sinh_(Data,[Var1]).

%inverse tangent or arctan
parentheses_expr(Data,double,atan(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        atan_(Data,[Var1]).

%inverse sine or arcsine
parentheses_expr(Data,double,asin(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        asin_(Data,[Var1]).

%inverse cosine or arccosine
parentheses_expr(Data,double,acos(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        acos_(Data,[Var1]).

parentheses_expr(Data,bool,"true") -->
	true_(Data).
parentheses_expr(Data,bool,"false") -->
	false_(Data).
	
parentheses_expr(Data,int,tan(Var1_)) -->
        {Var1 = expr(Data,int,Var1_)},
        tan_(Data,[Var1]).

parentheses_expr(Data,[array,Type1],initializer_list(A_)) -->
        {
                A = initializer_list_(Data,Type1,A_),
                Type = type(Data,Type1)
        },
        initializer_list_(Data,[A,Type]).

parentheses_expr(Data,[dict,Type1],dict(A_)) -->
        {
                A = dict_(Data,Type1,A_)
        },
        dict_(Data,[A]).

%should be inclusive range
parentheses_expr(Data,[array,int],range(A_,B_)) -->
	{
		A = parentheses_expr(Data,int,A_),
		B = expr(Data,int,B_)
	},
	range_(Data,[A,B]).

parentheses_expr(Data,Type,var_name(A)) -->
	var_name_(Data,Type,A).
parentheses_expr(_,int,a_number(A)) -->
	a_number(A).
parentheses_expr(Data,Type,parentheses(A)) -->
	"(",ws,expr(Data,Type,A),ws,")".
