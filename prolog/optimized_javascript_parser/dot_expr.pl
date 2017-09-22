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

dot_expr(Data,int,random_int_in_range(Start,End)) -->
	random_int_in_range(Data,[
		expr(Data,int,Start),
		expr(Data,int,End)
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

dot_expr(Data,[array,Type],reverse_list(List,Type)) -->
	reverse_list_(Data,[
		parentheses_expr(Data,[array,Type],List)
	]),!.
 
dot_expr(Data,string,reverse_string(Str)) -->
	reverse_string_(Data,[
		expr(Data,string,Str)
	]),!.
 
%https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(string_functions)#trim
dot_expr(Data,string,trim(Str)) -->
	trim_(Data,[
		parentheses_expr(Data,string,Str)
	]),!.

%https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(string_functions)#trim
dot_expr(Data,string,lstrip(Str)) -->
	lstrip_(Data,[
		parentheses_expr(Data,string,Str)
	]),!.

%https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(string_functions)#trim
dot_expr(Data,string,rstrip(Str)) -->
	rstrip_(Data,[
		parentheses_expr(Data,string,Str)
	]),!.

%all characters to lowercase
dot_expr(Data,string,lowercase(Str)) -->
	lowercase_(Data,[
		parentheses_expr(Data,string,Str)
	]),!.

%all characters to uppercase
dot_expr(Data,string,uppercase(Str)) -->
	uppercase_(Data,[
		parentheses_expr(Data,string,Str)
	]),!.

dot_expr(Data,int,strlen(A)) -->
	strlen_(Data,[parentheses_expr(Data,string,A)]).

dot_expr(Data,int,array_length(A,Type)) -->
	array_length(Data,[
		parentheses_expr(Data,[array,Type],A)
	]).

dot_expr(Data,Type,parentheses_expr(A)) --> 
	parentheses_expr(Data,Type,A).
