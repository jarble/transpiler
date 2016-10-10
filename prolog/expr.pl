expr(Data,[array,string],dict_keys(A,Type)) -->
	dict_keys_(Data,[
		expr(Data,[dict,Type],A)
	]).
expr(Data,bool,compare([array,Type],Exp1,Exp2)) -->
	compare_arrays_(Data,[
		dot_expr(Data,[array,Type],Exp1),
		expr(Data,[array,Type],Exp2)
	]).
expr(Data,string,global_replace_in_string(Str1,To_replace1,Replacement1)) -->
	global_replace_in_string_(Data,[
		parentheses_expr(Data,string,Str1),
		parentheses_expr(Data,string,To_replace1),
		parentheses_expr(Data,string,Replacement1)
	]).
expr(Data,int,pi) -->
	pi_(Data).
expr(Data,grammar, grammar_or(Var1,Var2)) -->
    grammar_or_(Data,[
		dot_expr(Data,grammar,Var1),
		expr(Data,bool,Var2)
	]).
expr(Data,bool, or(Var1,Var2)) -->
    or_(Data,[
		dot_expr(Data,bool,Var1),
		expr(Data,bool,Var2)
	]).
expr(Data,int,last_index_of(Str1,Str2)) -->
		last_index_of_(Data,[
			parentheses_expr(Data,string,Str1),
			parentheses_expr(Data,string,Str2)
		]).
expr(Data,int,index_of_substring(Str1,Str2)) -->
		index_of_substring_(Data,[
			parentheses_expr(Data,string,Str1),
			parentheses_expr(Data,string,Str2)
		]).
expr(Data,int,index_in_array(Container,Contained,Type)) -->
    index_in_array_(Data,[
		parentheses_expr(Data,[array,Type],Container),
        parentheses_expr(Data,Type,Contained)
    ]).
expr(Data,string,substring(Str_,Index1_,Index2_)) -->
        substring_(Data,[
			parentheses_expr(Data,string,Str_),
			parentheses_expr(Data,int,Index1_),
			parentheses_expr(Data,int,Index2_)
        ]).
expr(Data,bool,not(A1)) -->
        not(Data,[
			parentheses_expr(Data,bool,A1)
		]).
expr(Data,bool, and(A,B)) -->
    and_(Data,[
		dot_expr(Data,bool,A),
		expr(Data,bool,B)
	]).
expr(Data,bool,int_not_equal(A,B)) -->
        int_not_equal_(Data,[
			dot_expr(Data,int,A),
			expr(Data,int,B)
        ]).           
expr(Data,bool,greater_than(A,B)) -->
        {
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        greater_than_(Data,[
			expr(Data,int,A),
			dot_expr(Data,int,B),
			Prefix_arithmetic_langs
		]).
expr(Data,bool,greater_than_or_equal(A,B)) -->
        {
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        greater_than_or_equal_to_(Data,[
			expr(Data,int,A),
			dot_expr(Data,int,B),
			Prefix_arithmetic_langs
        ]).
expr(Data,bool,less_than_or_equal(A,B)) -->
        {
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        less_than_or_equal_to_(Data,[
			expr(Data,int,A),
			dot_expr(Data,int,B),
			Prefix_arithmetic_langs
		]).
expr(Data,bool,less_than(A,B)) -->
        {
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        less_than_(Data,[
            expr(Data,int,A),
            dot_expr(Data,int,B),
            Prefix_arithmetic_langs
        ]).
 
expr(Data,bool,compare(int,Var1,Var2)) -->
        compare_int_(Data,[
			dot_expr(Data,int,Var1),
			expr(Data,int,Var2)
		]).
        
expr(Data,bool,compare(bool,Exp1,Exp2)) -->
        compare_bool_(Data,[
			dot_expr(Data,bool,Exp1),
			expr(Data,bool,Exp2)
		]).
 
expr(Data,bool,compare(string,Exp1,Exp2)) -->
		compare_string_(Data,[
                dot_expr(Data,string,Exp1),
                expr(Data,string,Exp2)
		]).

expr(Data,[array,Type],array_slice(Str,Index1,Index2)) -->
        array_slice_(Data,[
			parentheses_expr(Data,[array,Type],Str),
			parentheses_expr(Data,int,Index1),
			parentheses_expr(Data,int,Index2)
        ]).
 
expr(Data,string,concatenate_string(A,B)) -->
        concatenate_string_(Data,[
			dot_expr(Data,string,A),
			expr(Data,string,B)
		]).
 
expr(Data,int,mod(A,B)) -->
    mod_(Data,[
		dot_expr(Data,int,A),
        expr(Data,int,B)
    ]).
 
expr(Data,int,arithmetic(Exp1,Exp2,Symbol)) -->
        {
                member(Symbol,["+","-","*","/"]),
                prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        arithmetic_(Data,[
			dot_expr(Data,int,Exp1),
			expr(Data,int,Exp2),
			Symbol,
			Prefix_arithmetic_langs
		]).

expr(Data,int,pow(Exp1,Exp2)) -->
    pow_(Data,[
		parentheses_expr(Data,int,Exp1),
		parentheses_expr(Data,int,Exp2)
	]).


expr(Data,[array,Type],concatenate_arrays(A1,A2)) -->
	concatenate_arrays_(Data,[
		dot_expr(Data,[array,Type],A1),
		expr(Data,[array,Type],A2)
	]).
 
expr(Data,string,join_(Array,Separator)) -->
	join_(Data,[
		parentheses_expr(Data,[array,string],Array),
		parentheses_expr(Data,string,Separator)
	]).
        
expr(Data,int,sqrt(Exp1)) -->
	sqrt(Data,[expr(Data,int,Exp1)]).
 
expr(Data,Type,list_comprehension(Result,Var,Condition,Array)) -->
	list_comprehension_(Data,[
		var_name_(Data,Type,Var),
		expr(Data,[array,Type],Array),
		expr(Data,Type,Result),
		expr(Data,bool,Condition)
	]).

expr(Data,Type,list_comprehension_1(Result,Var,Array)) -->
	list_comprehension_1_(Data,[
		var_name_(Data,Type,Var),
		expr(Data,[array,Type],Array),
		expr(Data,Type,Result)
	]).

expr(Data,string,charAt(Str,Int)) -->
	charAt_(Data,[
		parentheses_expr(Data,string,Str),
		expr(Data,int,Int)
	]).

expr(Data,bool,endswith(Str1,Str2)) -->
	endswith_(Data,[
		parentheses_expr(Data,string,Str1),
		expr(Data,string,Str2)
	]).

expr(Data,[array,Type],reverse_list(List,Type)) -->
	reverse_list_(Data,[
		parentheses_expr(Data,[array,Type],List)
	]).
 
expr(Data,string,reverse_string(Str)) -->
	reverse_string_(Data,[
		expr(Data,string,Str)
	]).
 
%https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(string_functions)#trim
expr(Data,string,trim(Str)) -->
	trim_(Data,[
		parentheses_expr(Data,string,Str)
	]).
 
%all characters to lowercase
expr(Data,string,lowercase(Str)) -->
	lowercase_(Data,[
		parentheses_expr(Data,string,Str)
	]).
 
%all characters to uppercase
expr(Data,string,uppercase(Str)) -->
	uppercase_(Data,[
		parentheses_expr(Data,string,Str)
	]).
 
expr(Data,bool,array_contains(Str1,Str2)) -->
	array_contains(Data,[
		parentheses_expr(Data,[array,Type],Str1),
		parentheses_expr(Data,Type,Str2)
	]).
 
expr(Data,bool,string_contains(Str1,Str2)) -->
	string_contains_(Data,[
			parentheses_expr(Data,string,Str1),
			parentheses_expr(Data,string,Str2)
	]).
 

expr(Data,bool,startswith(Str1,Str2)) -->
	startswith_(Data,[
		parentheses_expr(Data,string,Str1),
		parentheses_expr(Data,string,Str2)
	]).
 
expr(Data,Type,access_array(Array_,Index_)) -->
        {
                Array = parentheses_expr(Data,[array,Type],Array_),
                dif(Array,"this")
        },
        access_array_(Data,[
			Array,
			parentheses_expr(Data,int,Index_)
		]).
 
 
expr(Data,Type,this(A)) -->
    this_(Data,[
		var_name_(Data,Type,A)
	]).
 
expr(Data,Type,access_dict(Dict,Index)) -->
	access_dict_(Data,[
		var_name_(Data,[dict,Type],Dict),
		Dict,
		expr(Data,int,Index)
	]).
         
expr(Data,[array,string],command_line_args) -->
	command_line_args_(Data).

 
expr(Data,regex,new_regex(A)) -->
	new_regex_(Data,[
		expr(Data,string,A)
	]).
expr(Data,bool,regex_matches_string(Str,Reg)) -->
	regex_matches_string_(Data,[
		parentheses_expr(Data,regex,Reg),
		parentheses_expr(Data,string,Str)
	]).

expr(Data,bool,instanceof(Expr,Type1,Type2)) -->
	instanceof_(Data,[
		parentheses_expr(Data,Type1,Expr),
		Type1,
		type(Data,Type2)
	]).

expr(Data,int,strlen(A)) -->
	strlen_(Data,[parentheses_expr(Data,string,A)]).

expr(Data,int,array_length(A,Type)) -->
	array_length_(Data,[
		parentheses_expr(Data,[array,Type],A)
	]).

expr(Data,Type,dot_expr(A)) --> 
	dot_expr(Data,Type,A).
