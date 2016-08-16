expr(Data,[array,string],dict_keys(A1,Type1)) -->
        {
            A = expr(Data,[dict,Type1],A1)
        },
        dict_keys_(Data,[A]).
 
expr(Data,bool,compare([array,Type],Exp1_,Exp2_)) -->
        {
                A = parentheses_expr(Data,[array,Type],Exp1_),
                B = expr(Data,[array,Type],Exp2_)
        },
        compare_arrays_(Data,[A,B]).
 
expr(Data,string,global_replace_in_string(Str1,To_replace1,Replacement1)) -->
        {
                Str = parentheses_expr(Data,string,Str1),
                To_replace = parentheses_expr(Data,string,To_replace1),
                Replacement = parentheses_expr(Data,string,Replacement1)
        },
        global_replace_in_string_(Data,[Str,To_replace,Replacement]).
 
expr(Data,int,pi) -->
	pi_(Data).

expr(Data,grammar, grammar_or(Var1_,Var2_)) -->
    {
            Var1 = parentheses_expr(Data,grammar,Var1_),
            Var2 = expr(Data,bool,Var2_)
    },
    grammar_or_(Data,[Var1,Var2]).

 
expr(Data,bool, or(Var1_,Var2_)) -->
        {
                Var1 = parentheses_expr(Data,bool,Var1_),
                Var2 = expr(Data,bool,Var2_)
        },
    or_(Data,[Var1,Var2]).
 
expr(Data,int,last_index_of(Str1_,Str2_)) -->
        {
                String = parentheses_expr(Data,string,Str1_),
                Substring = parentheses_expr(Data,string,Str2_)
        },
		last_index_of_(Data,[String,Substring]).
 
expr(Data,int,index_of_substring(Str1_,Str2_)) -->
        {
                String = parentheses_expr(Data,string,Str1_),
                Substring = parentheses_expr(Data,string,Str2_)
        },
		index_of_substring_(Data,[String,Substring]).
 
expr(Data,int,index_in_array(Container_,Contained_,Type)) -->
        {
                Container = parentheses_expr(Data,[array,Type],Container_),
                Contained = parentheses_expr(Data,Type,Contained_)
        },
    index_in_array_(Data,[Container,Contained]).
 
expr(Data,string,substring(Str_,Index1_,Index2_)) -->
        {
                A = parentheses_expr(Data,string,Str_),
                B = parentheses_expr(Data,int,Index1_),
                C = parentheses_expr(Data,int,Index2_)
        },
        substring_(Data,[A,B,C]).
 
expr(Data,bool,not(A1)) -->
        {
                A = parentheses_expr(Data,bool,A1)
        },
        not(Data,[A]).
 
expr(Data,bool, and(A_,B_)) -->
        {A = parentheses_expr(Data,bool,A_),
        B = expr(Data,bool,B_)},
    and_(Data,[A,B]).
 
expr(Data,bool,int_not_equal(A_,B_)) -->
        {A = parentheses_expr(Data,int,A_),
        B = expr(Data,int,B_)},
        int_not_equal_(Data,[A,B]).           
expr(Data,bool,greater_than(A_,B_)) -->
        {
            A = expr(Data,int,A_),
            B = parentheses_expr(Data,int,B_),
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        greater_than_(Data,[A,B,Prefix_arithmetic_langs]).
expr(Data,bool,greater_than_or_equal(A_,B_)) -->
        {
            A = expr(Data,int,A_),
            B = parentheses_expr(Data,int,B_),
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        greater_than_or_equal_to_(Data,[A,B,Prefix_arithmetic_langs]).
expr(Data,bool,less_than_or_equal(A_,B_)) -->
        {
            A = expr(Data,int,A_),
            B = parentheses_expr(Data,int,B_),
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        less_than_or_equal_to_(Data,[A,B,Prefix_arithmetic_langs]).
expr(Data,bool,less_than(A_,B_)) -->
        {
            A = expr(Data,int,A_),
            B = parentheses_expr(Data,int,B_),
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        less_than_(Data,[A,B,Prefix_arithmetic_langs]).
 
expr(Data,bool,compare(int,Var1_,Var2_)) -->
        {Var1=parentheses_expr(Data,int,Var1_),Var2=expr(Data,int,Var2_)},
        compare_int_(Data,[Var1,Var2]).
        
expr(Data,bool,compare(bool,Exp1_,Exp2_)) -->
        {
            Exp1 = parentheses_expr(Data,bool,Exp1_),
            Exp2 = expr(Data,bool,Exp2_)
        },
        compare_bool_(Data,[Exp1,Exp2]).
 
expr(Data,bool,compare(string,Exp1_,Exp2_)) -->
        {
                A = parentheses_expr(Data,string,Exp1_),
                B = expr(Data,string,Exp2_)
        },
		compare_string_(Data,[A,B]).

expr(Data,[array,Type],array_slice(Str_,Index1_,Index2_)) -->
        {
                A = parentheses_expr(Data,[array,Type],Str_),
                B = parentheses_expr(Data,int,Index1_),
                C = parentheses_expr(Data,int,Index2_)
        },
        array_slice_(Data,[A,B,C]).
 
expr(Data,string,concatenate_string(A_,B_)) -->
        {
                B = expr(Data,string,B_),
                A = parentheses_expr(Data,string,A_)
        },
        concatenate_string_(Data,[A,B]).
 
expr(Data,int,mod(A_,B_)) -->
    {
        A = parentheses_expr(Data,int,A_),
        B = expr(Data,int,B_)
    },
    mod_(Data,[A,B]).
 
expr(Data,int,arithmetic(Exp1_,Exp2_,Symbol)) -->
        {
                Exp1 = parentheses_expr(Data,int,Exp1_),
                Exp2 = expr(Data,int,Exp2_),
                member(Symbol,["+","-","*","/"]),
                prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        arithmetic_(Data,[Exp1,Exp2,Symbol,Prefix_arithmetic_langs]).
 
expr(Data,int,pow(Exp1_,Exp2_)) -->
    {
        A = parentheses_expr(Data,int,Exp1_),
        B = parentheses_expr(Data,int,Exp2_)
    },
    pow_(Data,[A,B]).
 
 
expr(Data,[array,string],split(Exp1,Exp2)) -->
    {
        AString = parentheses_expr(Data,string,Exp1),
        Separator = parentheses_expr(Data,string,Exp2)
    },
    split_(Data,[AString,Separator]).

expr(Data,string,reverse_list_in_place(List_,Type)) -->
        {
                Data = [Lang|_],
                List = parentheses_expr(Data,[array,Type],List_)
        },
        reverse_in_place_(Data,[List]).

expr(Data,[array,Type],concatenate_arrays(A1_,A2_)) -->
        {
                A1 = parentheses_expr(Data,[array,Type],A1_),
                A2 = parentheses_expr(Data,[array,Type],A2_)
        },
        concatenate_arrays_(Data,[A1,A2]).
 
expr(Data,string,join_(Exp1,Exp2)) -->
        {
                Array = parentheses_expr(Data,[array,string],Exp1),
                Separator = parentheses_expr(Data,string,Exp2)
        },
        join_(Data,[Array,Separator]).
         
expr(Data,int,sqrt(Exp1)) -->
        {
                X = expr(Data,int,Exp1)
        },
        sqrt(Data,[X]).
 
expr(Data,Type1,list_comprehension(Result1,Var1,Condition1,Array1)) -->
        {
                Variable = var_name_(Data,Type,Var1),
                Array = expr(Data,[array,Type],Array1),
                Result = expr(Data,Type1,Result1),
                Condition = expr(Data,bool,Condition1)
        },
        list_comprehension_(Data,[Variable,Array,Result,Condition]).

expr(Data,string,charAt(Str_,Int_)) -->
        {
                AString = parentheses_expr(Data,string,Str_),
                Index = expr(Data,int,Int_)
        },
        charAt_(Data,[AString,Index]).

expr(Data,string,endswith(Str1_,Str2_)) -->
        {
                Str1 = parentheses_expr(Data,string,Str1_),
                Str2 = expr(Data,string,Str2_)
        },
        endswith_(Data,[Str1,Str2]).

expr(Data,string,reverse_list(List_,Type)) -->
        {
                List = parentheses_expr(Data,[array,Type],List_)
        },
        reverse_list_(Data,[List]).
        
 
expr(Data,string,reverse_string(Str_)) -->
        {
                Str = expr(Data,string,Str_)
        },
        reverse_string_(Data,[Str]).
 
%https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(string_functions)#trim
expr(Data,string,trim(Str_)) -->
        {
                Str = parentheses_expr(Data,string,Str_)
        },
        trim_(Data,[Str]).
 
%all characters to lowercase
expr(Data,string,lowercase(Str_)) -->
        {
                Str = parentheses_expr(Data,string,Str_)
        },
        lowercase_(Data,[Str]).
 
%all characters to uppercase
expr(Data,string,uppercase(Str_)) -->
        {
                Str = parentheses_expr(Data,string,Str_)
        },
        uppercase_(Data,[Str]).
 
expr(Data,bool,array_contains(Str1_,Str2_)) -->
        {
                Container = parentheses_expr(Data,[array,Type],Str1_),
                Contained = parentheses_expr(Data,Type,Str2_)
        },
        array_contains(Data,[Container,Contained]).
 
expr(Data,bool,string_contains(Str1_,Str2_)) -->
        {
                Str1 = parentheses_expr(Data,string,Str1_),
                Str2 = parentheses_expr(Data,string,Str2_)
        },
        string_contains_(Data,[Str1,Str2]).
 
 
expr(Data,string,startswith(Str1_,Str2_)) -->
        {
                Str1 = parentheses_expr(Data,string,Str1_),
                Str2 = parentheses_expr(Data,string,Str2_)
        },
        startswith_(Data,[Str1,Str2]).
         
expr(Data,Type,parentheses_expr(A)) --> parentheses_expr(Data,Type,A).
 
expr(Data,Type,access_array(Array_,Index_)) -->
        {
                Array = parentheses_expr(Data,[array,Type],Array_),
                dif(Array,"this"),
                Index = parentheses_expr(Data,int,Index_)
        },
        access_array_(Data,[Array,Index]).
 
 
expr(Data,Type,this(A_)) -->
    {A = var_name_(Data,Type,A_)},
    this_(Data,[A]).
 
expr(Data,Type,access_dict(Dict_,Index_)) -->
        {
                Dict = var_name_(Data,[dict,Type],Dict_),
                Index = expr(Data,int,Index_)
        },
        access_dict_(Data,[Dict,Dict_,Index]).
         
expr(Data,[array,string],command_line_args) -->
		command_line_args_(Data).


 
expr(Data,int,strlen(A1)) -->
        {
                A = parentheses_expr(Data,string,A1)
        },
        strlen_(Data,A).
 
expr(Data,regex,new_regex(A1)) -->
        {
                A = expr(Data,string,A1)
        },
        new_regex_(Data,[A]).
expr(Data,bool,regex_matches_string(Str1,Reg1)) -->
        {
                Str = parentheses_expr(Data,string,Str1),
                Reg = parentheses_expr(Data,regex,Reg1)
        },
        regex_matches_string_(Data,[Reg,Str]).
 
expr(Data,bool,string_matches_string(Str1,Reg1)) -->
        {
                Str = parentheses_expr(Data,string,Str1),
                Reg = parentheses_expr(Data,string,Reg1)
        },
        string_matches_string_(Data,[Str1,Reg1]).
 
expr(Data,int,array_length(A1,Type)) -->
        {
                A = parentheses_expr(Data,[array,Type],A1)
        },
        array_length_(Data,[A]).
