dot_expr(Data,Type2,type_conversion(Type1,Arg1)) -->
        type_conversion_(Data,[Type1,Type2,parentheses_expr(Data,Type1,Arg1)]).

dot_expr(Data,[array,string],split(Exp1,Exp2)) -->
    split_(Data,[
		parentheses_expr(Data,string,Exp1),
        parentheses_expr(Data,string,Exp2)
	]).

dot_expr(Data,Type,parentheses_expr(A)) --> 
	parentheses_expr(Data,Type,A).
