expr(Data,string,global_replace_in_string(Str1,To_replace1,Replacement1)) -->
	global_replace_in_string_(Data,[
		parentheses_expr(Data,string,Str1),
		parentheses_expr(Data,string,To_replace1),
		parentheses_expr(Data,string,Replacement1)
	]).
expr(Data,[array,Type],sort(List)) -->
	sort_(Data,[
		parentheses_expr(Data,[array,Type],List)
	]).

expr(Data,bool,type_is_string(Object)) -->
	type_is_string(Data,[
		parentheses_expr(Data,Type,Object)
	]).

expr(Data,bool,type_is_bool(Object)) -->
	type_is_bool(Data,[
		parentheses_expr(Data,Type,Object)
	]).


expr(Data,bool,type_is_list(Object)) -->
	type_is_list(Data,[
		parentheses_expr(Data,Type,Object)
	]).

dot_expr(Data,double,random_from_list(List,Type)) -->
	random_from_list(Data,[
		expr(Data,[array,Type],List)
	]).



expr(Data,bool, or(Var1,Var2)) -->
    or_(Data,[
		dot_expr(Data,bool,Var1),
		expr(Data,bool,Var2)
	]).
expr(Data,bool, eager_or(Var1,Var2)) -->
    eager_or_(Data,[
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
        not_(Data,[
			parentheses_expr(Data,bool,A1)
		]).
expr(Data,bool, and(A,B)) -->
    and_(Data,[
		dot_expr(Data,bool,A),
		expr(Data,bool,B)
	]).

expr(Data,bool, eager_and(A,B)) -->
    eager_and_(Data,[
		dot_expr(Data,bool,A),
		expr(Data,bool,B)
	]).
expr(Data,bool,int_not_equal(A,B)) -->
        int_not_equal_(Data,[
			dot_expr(Data,int,A),
			expr(Data,int,B)
        ]).    
expr(Data,bool,string_not_equal(A,B)) -->
        string_not_equal_(Data,[
			dot_expr(Data,string,A),
			expr(Data,string,B)
        ]).             
expr(Data,bool,greater_than(int,A,B)) -->
        greater_than_(Data,[
			expr(Data,int,A),
			dot_expr(Data,int,B)
		]).

%universal quantifications for arrays of ints
%expr(Data,bool,universal_quantifications(int,A,B,English_expr)) -->
%        universal_quantifications_(Data,int,[
%			expr(Data,[array,int],A),
%			dot_expr(Data,int,B),
%			English_expr
%		]).

expr(Data,bool,greater_than(double,A,B)) -->
        greater_than_(Data,[
			expr(Data,double,A),
			dot_expr(Data,double,B)
		]).

expr(Data,bool,greater_than_or_equal(A,B)) -->
        greater_than_or_equal_to_(Data,[
			expr(Data,int,A),
			dot_expr(Data,int,B)
        ]).
expr(Data,bool,less_than_or_equal(A,B)) -->
        less_than_or_equal_to_(Data,[
			expr(Data,int,A),
			dot_expr(Data,int,B)
		]).
expr(Data,bool,less_than(A,B)) -->
        less_than_(Data,[
            expr(Data,int,A),
            dot_expr(Data,int,B)
        ]).

expr(Data,bool,compare(Type,Exp1,Exp2)) -->
		compare_(Data,Type,[
                dot_expr(Data,Type,Exp1),
                expr(Data,Type,Exp2)
		]).

expr(Data,Type,arithmetic(Exp1,Exp2,Symbol)) -->
        {
                member(Symbol,["+","-","*","/"])
        },
        arithmetic_(Data,[
			dot_expr(Data,Type,Exp1),
			expr(Data,Type,Exp2),
			Symbol
		]),{Type=int;Type=double}.

expr(Data,string,arithmetic("+",A,B)) -->
        concatenate_string_(Data,[
			dot_expr(Data,string,A),
			expr(Data,string,B)
		]).

%expr(Data,string,concatenate_string_to_int(A,B)) -->
%        concatenate_string_to_int_(Data,[
%			dot_expr(Data,string,A),
%			expr(Data,int,B)
%		]).

expr(Data,int,mod(A,B)) -->
    mod_(Data,[
		dot_expr(Data,int,A),
        expr(Data,int,B)
    ]).
 
expr(Data,[array,Type],concatenate_arrays(A1,A2)) -->
	concatenate_arrays_(Data,[
		dot_expr(Data,[array,Type],A1),
		expr(Data,[array,Type],A2)
	]).

expr(Data,bool,array_contains(Array,Contained,Type)) -->
	array_contains(Data,[
		parentheses_expr(Data,[array,Type],Array),
		parentheses_expr(Data,Type,Contained)
	]).
 
expr(Data,bool,string_contains(Str1,Str2)) -->
	string_contains_(Data,[
			parentheses_expr(Data,string,Str1),
			parentheses_expr(Data,string,Str2)
	]).

expr(Data,Type,this(A)) -->
    this_(Data,[
		var_name_(Data,Type,A)
	]).
 
expr(Data,Type,access_dict(Dict,Index)) -->
	access_dict_(Data,[
		var_name_(Data,[dict,Type],Dict),
		Dict,
		expr(Data,string,Index)
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


expr(Data,[array,string],dict_keys(A,Type)) -->
	dict_keys_(Data,[
		expr(Data,[dict,Type],A)
	]).

expr(Data,double,random_number) -->
	random_number(Data).

expr(Data,Type,dot_expr(A)) --> 
	dot_expr(Data,Type,A).
