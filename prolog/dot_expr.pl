dot_expr(Data,Type,parentheses_expr(A)) --> 
	parentheses_expr(Data,Type,A).

dot_expr(Data,double,pi) -->
	pi_(Data).

dot_expr(Data,Type2,type_conversion(Type1,Arg1)) -->
        type_conversion_(Data,[Type1,Type2,parentheses_expr(Data,Type1,Arg1)]).

dot_expr(Data,double,sin(Var)) -->
	sin_(Data,[parentheses_expr(Data,double,Var)]).

dot_expr(Data,int,floor(Params1,int)) -->
        floor_(Data,[
			expr(Data,int,Params1)
		]).

dot_expr(Data,int,floor(Params1,double)) -->
        floor_(Data,[
			expr(Data,double,Params1)
		]).

dot_expr(Data,int,ceiling(Params1,int)) -->
        ceiling_(Data,[
			expr(Data,int,Params1)
		]).

dot_expr(Data,int,ceiling(Params1,double)) -->
        ceiling_(Data,[
			expr(Data,double,Params1)
		]).

dot_expr(Data,double,tan(Var)) -->
	tan_(Data,[
		expr(Data,double,Var)
	]).

dot_expr(Data,double,cos(Var1_)) -->
        cos_(Data,[
			expr(Data,double,Var1_)
        ]).

dot_expr(Data,double,abs(Var1)) -->
        abs_(Data,[
			expr(Data,double,Var1)
		]).
        
dot_expr(Data,double,cosh(Var1)) -->
        cosh_(Data,[
			expr(Data,double,Var1)
        ]).


dot_expr(Data,double,sinh(Var1)) -->
        sinh_(Data,[
			expr(Data,double,Var1)
        ]).

%inverse tangent or arctan
dot_expr(Data,double,atan(Var1)) -->
        atan_(Data,[
			expr(Data,double,Var1)
        ]).

%inverse sine or arcsine
dot_expr(Data,double,asin(Var)) -->
	asin_(Data,[
		expr(Data,double,Var)
	]).

%inverse cosine or arccosine
dot_expr(Data,double,acos(Var)) -->
	acos_(Data,[
		expr(Data,double,Var)
	]).

dot_expr(Data,[array,string],split(Exp1,Exp2)) -->
    split_(Data,[
		parentheses_expr(Data,string,Exp1),
        parentheses_expr(Data,string,Exp2)
	]).

dot_expr(Data,Type,access_array(Array_,Index_)) -->
        {
                Array = parentheses_expr(Data,[array,Type],Array_),
                dif(Array,"this")
        },
        access_array_(Data,[
			Array,
			dot_expr(Data,int,Index_)
		]).

dot_expr(Data,int,pow(Exp1,Exp2)) -->
    pow_(Data,[
		parentheses_expr(Data,int,Exp1),
		parentheses_expr(Data,int,Exp2)
	]).


dot_expr(Data,string,charAt(Str,Int)) -->
	charAt_(Data,[
		parentheses_expr(Data,string,Str),
		expr(Data,int,Int)
	]).

dot_expr(Data,bool,startswith(Str1,Str2)) -->
	startswith_(Data,[
		parentheses_expr(Data,string,Str1),
		parentheses_expr(Data,string,Str2)
	]).

dot_expr(Data,bool,endswith(Str1,Str2)) -->
	endswith_(Data,[
		parentheses_expr(Data,string,Str1),
		expr(Data,string,Str2)
	]).

dot_expr(Data,[array,Type],array_slice(Str,Index1,Index2)) -->
        array_slice_(Data,[
			parentheses_expr(Data,[array,Type],Str),
			parentheses_expr(Data,int,Index1),
			parentheses_expr(Data,int,Index2)
        ]).

dot_expr(Data,string,join_(Array,Separator)) -->
	join_(Data,[
		parentheses_expr(Data,[array,string],Array),
		parentheses_expr(Data,string,Separator)
	]).
        
dot_expr(Data,double,sqrt(Exp1)) -->
	sqrt(Data,[expr(Data,double,Exp1)]).


dot_expr(Data,Type,list_comprehension(Result,Var,Condition,Array)) -->
	list_comprehension_(Data,[
		var_name_(Data,Type,Var),
		expr(Data,[array,Type],Array),
		expr(Data,Type,Result),
		expr(Data,bool,Condition)
	]).

dot_expr(Data,Type,list_comprehension_1(Result,Var,Array)) -->
	list_comprehension_1_(Data,[
		var_name_(Data,Type,Var),
		expr(Data,[array,Type],Array),
		expr(Data,Type,Result)
	]).

dot_expr(Data,[array,Type],reverse_list(List,Type)) -->
	reverse_list_(Data,[
		parentheses_expr(Data,[array,Type],List)
	]).
 
dot_expr(Data,string,reverse_string(Str)) -->
	reverse_string_(Data,[
		expr(Data,string,Str)
	]).
 
%https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(string_functions)#trim
dot_expr(Data,string,trim(Str)) -->
	trim_(Data,[
		parentheses_expr(Data,string,Str)
	]).
 
%all characters to lowercase
dot_expr(Data,string,lowercase(Str)) -->
	lowercase_(Data,[
		parentheses_expr(Data,string,Str)
	]).
 
%all characters to uppercase
dot_expr(Data,string,uppercase(Str)) -->
	uppercase_(Data,[
		parentheses_expr(Data,string,Str)
	]).


dot_expr(Data,int,strlen(A)) -->
	strlen_(Data,[parentheses_expr(Data,string,A)]).

dot_expr(Data,int,array_length(A,Type)) -->
	array_length_(Data,[
		parentheses_expr(Data,[array,Type],A)
	]).
