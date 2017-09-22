:- style_check(-singleton).

return_(Data,[A]) -->
	("return",ws_,A).

initialize_constant_(Data,[Name,Type,Value]) -->
	("final",ws_,Type,ws_,Name,ws,"=",ws,Value).
set_array_size_(Data,[Name,Size,Type]) -->
	("var",ws_,Name,ws,"=",ws,"Array",ws,".",ws,"apply",ws,"(",ws,"null",ws,",",ws,"Array",ws,"(",ws,Size,ws,")",ws,")",ws,".",ws,"map",ws,"(",ws,"function",ws,"(",ws,")",ws,"{",ws,"}",ws,")").

        
set_var_(Data,[Name,Value]) -->
	(Name,ws,"=",ws,Value).


initialize_var_(Data,[Name,Expr,Type]) -->
    (Type,ws_,Name,ws,"=",ws,Expr).
index_in_array_(Data,[Container,Contained]) -->
	(Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")").

concatenate_string_(Data,[A,B]) -->
	(A,python_ws,"+",python_ws,B).

array_length(Data, [A])-->
	(A,ws,".",ws,"length").

strlen_(Data,[A]) -->
	(A,ws,".",ws,"length",ws,"(",ws,")").

access_array_(Data,[Array,Index]) -->
	(Array,python_ws,"[",python_ws,Index,python_ws,"]").

%not reversed in place
%list backwards
reverse_list_(Data,[List]) -->
	(List,ws,".",ws,"map",ws,"(",ws,"function",ws,"(",ws,"arr",ws,")",ws,"{",ws,"return",ws_,"arr",ws,".",ws,"slice()",ws,";",ws,"}",ws,")").

reverse_list_in_place_(Data,[List]) -->
	(List,python_ws,".",python_ws,"reverse",python_ws,"(",python_ws,")").

charAt_(Data,[AString,Index]) -->
	(AString,ws,".",ws,"charAt",ws,"(",ws,Index,ws,")").
join_(Data,[Array,Separator]) -->
	(Array,ws,".",ws,"join",ws,"(",ws,Separator,ws,")").

%Concatenate arrays, not in-place
concatenate_arrays_(Data,[A1,A2]) -->
                (A1,ws,".",ws,"concat",ws,"(",ws,A2,ws,")").
split_(Data,[AString,Separator]) -->
	(AString,python_ws,".",python_ws,"split",python_ws,"(",python_ws,Separator,python_ws,")").

function_call_(Data,[Name,Args]) -->
	(Name,python_ws,"(",python_ws,Args,python_ws,")").

minus_minus_(Data,[Name]) -->
	(Name,ws,"--").

initialize_static_var_with_value_(Data,[Type,Name,Value]) -->
			("var",ws_,Name,ws,"=",ws,Value).


instance_method_(Data,[Name,Type,Params,Body,Indent]) -->
	(Name,ws,"(",ws,Params,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}").

static_method_(Data, [Name,Type,Params,Body,Indent]) -->        
	("static",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}").


constructor_(Data,[Name,Params,Body,Indent]) -->
	("constructor",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}").

plus_equals_(Data,[A,B]) -->
	(A,python_ws,"+=",python_ws,B).

array_plus_equals_(Data,[A,B]) -->
	(A,ws,".",ws,"push",ws,".",ws,"apply",ws,"(",ws,A,ws,",",ws,B,ws,")").

string_plus_equals_(Data,[A,B]) -->
	(A,python_ws,"+=",python_ws,B).

divide_equals_(Data,[A,B]) -->
			(A,ws,"/=",ws,B).

modulo_equals_(Data,[A,B]) -->
	(A,ws,"%=",ws,B).

minus_equals_(Data,[A,B]) -->
	(A,python_ws,"-=",python_ws,B).
	
assert_(Data,[A]) -->
	("assert",ws,"(",ws,A,ws,")").

%logarithm with e as the base
log_base_e_(Data,[A]) -->
	("Math",ws,".",ws,"log",ws,"(",ws,A,ws,")",!).


println_(Data,[A,Type]) -->
	("System",ws,".",ws,"out",ws,".",ws,"println",ws,"(",ws,A,ws,")").

times_equals_(Data,[Name,Expr]) -->
	(Name,ws,"*=",ws,Expr).

append_to_string_(Data,[Name,Expr]) -->
        (Name,python_ws,"+=",python_ws,Expr).

append_to_array_(Data,[Name,Expr]) -->
	(Name,ws,".",ws,"push",ws,"(",ws,Expr,ws,")").

throw_(Data,[A]) -->
	("throw",ws_,A).


initialize_empty_var_(Data,[Name,Type]) -->
	("var",ws_,Name).
set_dict_(Data,[Name,Index,Value]) -->
			(Name,ws,"[",ws,Index,ws,"]",ws,"=",ws,Value).
	
initializer_list_(Data,[A,Type]) -->
	("[",python_ws,A,python_ws,"]").
%https://rosettacode.org/wiki/Associative_array

dict_(Data,[A,Type]) -->
	("{",python_ws,A,python_ws,"}").


tan_(Data,[Var1]) -->  

                ("Math",ws,".",ws,"tan",ws,"(",ws,Var1,ws,")").
        
false_(Data) -->
	"false".

true_(Data) --> 
	("true").
acos_(Data,[Var1]) -->
	("Math",ws,".",ws,"acos",ws,"(",ws,Var1,ws,")").

asin_(Data,[Var1]) -->
	("Math",ws,".",ws,"asin",ws,"(",ws,Var1,ws,")").

atan_(Data,[Var1]) -->
	("Math",ws,".",ws,"atan",ws,"(",ws,Var1,ws,")").


sinh_(Data,[Var1]) -->
	("Math",ws,".",ws,"sinh",ws,"(",ws,Var1,ws,")").
cosh_(Data,[Var1]) -->
	("Math",ws,".",ws,"cosh",ws,"(",ws,Var1,ws,")").

% see http://rosettacode.org/wiki/Real_constants_and_functions#Haskell
abs_(Data,[Var1]) -->

			("Math",ws,".",ws,"abs",ws,"(",ws,Var1,ws,")").

sin_(Data,[Var1]) -->
	("Math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")").
cos_(Data,[Var1]) -->
	("Math",ws,".",ws,"cos",ws,"(",ws,Var1,ws,")").

% see https://rosettacode.org/wiki/Real_constants_and_functions
ceiling_(Data,[Params]) -->
	("Math",ws,".",ws,"ceil",ws,"(",ws,Params,ws,")").
        
% see https://rosettacode.org/wiki/Real_constants_and_functions
floor_(Data,[Params]) -->
	("Math",ws,".",ws,"floor",ws,"(",ws,Params,ws,")").


anonymous_function_(Data,[Type,Params,B]) -->
	(
		"function",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}";
		%arrow functions
		"(",ws,Params,ws,")",ws,"=>",ws,"{",ws,B,ws,"}"
	).

type_conversion_(Data,[string,[array,char],Arg]) -->
	("Array",ws,".",ws,"from",ws,"(",ws,Arg,ws,")").

type_conversion_(Data,[int,string,Arg]) -->
	("String",ws,"(",ws,Arg,ws,")").

type_conversion_(Data,[string,int,Arg]) -->
	("parseInt",ws,"(",ws,Arg,ws,")").
type_conversion_(Data,[string,double,Arg]) -->
			("Number",ws,"(",ws,Arg,ws,")").
type_conversion_(Data,[double,string,Arg]) -->
			("toString",ws,"(",ws,Arg,ws,")").

static_method_call_(Data,[Class_name,Function_name,Args]) -->
		(Class_name,".",Function_name,ws,"(",ws,Args,ws,")").
instance_method_call_(Data,[Instance_name,Function_name,Args]) -->
		(Instance_name,".",Function_name,ws,"(",ws,Args,ws,")").

plus_plus_(Data,[Name]) -->
			(Name,ws,"++").
set_array_index_(Data,[Name,Index,Value]) -->
	set_var_(Data,[access_array_(Data,[Name,Index]),Value]).

mod_(Data,[A,B]) -->
	(A,python_ws,"%",python_ws,B).

synonym("greater") --> "more".
synonym("each") --> "every";"all".
synonym("print") --> "write".
synonym("=") --> "equals";"is".

synonym("+") --> python_ws_,"plus",python_ws_.
synonym("and") --> "and";"but";"although".
synonym("-") --> python_ws_,"minus",python_ws_.
synonym("*") -->
	python_ws_,"times",python_ws_;
	python_ws_,"multiplied",python_ws_,"by",python_ws_.
synonym("/") -->
	python_ws_,"divided",python_ws_,"by",python_ws_.
synonym(A) --> A.
synonym("does not equal") -->
	"does",ws_,"not",ws_,"equal";"is",ws_,"not";"cannot",ws_,"be";"!=";"!==".

arithmetic_(Data,[Exp1,Exp2,Symbol]) -->
	(Exp1,ws,Symbol,ws,Exp2).
new_regex_(Data,[A]) -->
            ("new",ws,"RegExp",ws,"(",ws,A,ws,")").
foreach_with_index_(Data,[Array,Var,Index,Type,Body,Indent]) -->
	(Array,ws,".",ws,"forEach",ws,"(",ws,"function",ws,"(",ws,Var,ws,",",ws,Index,ws,")",ws,"{",ws,Body,(Indent;ws),"}",ws,")",ws,";").
		

foreach_(Data,[Array,Var,Type,Body,Indent]) -->
	(Array,ws,".",ws,"forEach",ws,"(",ws,"function",ws,"(",ws,Var,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}",ws,")",ws,";").
switch_(Data,[A,B,Indent]) -->
	("switch",ws,"(",!,ws,A,ws,")",ws,"{",!,ws,B,(Indent;ws),"}").

if_without_else_(Data,[A,B,Indent]) -->
	("if",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}").
if(Data,[A,B,C,D,Indent]) -->
	(if_without_else_(Data,[A,B,Indent]),(Indent;ws),C,(Indent;ws),D).
do_while_(Data,[Condition,Body,Indent]) -->
	("do",ws,"{",!,ws,Body,(Indent;ws),"}",ws,"while",ws,"(",ws,Condition,ws,")",ws,";").


while_(Data,[A,B,Indent]) -->
	("while",ws,"(",ws,A,ws,")",ws,"{",!,ws,B,(Indent;ws),"}").
for_(Data,[Statement1,Condition,Statement2,Body,Indent]) -->
	("for",ws,"(",!,ws,Statement1,ws,";",ws,Condition,ws,";",ws,Statement2,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}").

semicolon_(Data,[A]) -->
	(A,ws,";",!).


class_extends_(Data,[C1,C2,B,Indent]) -->
	("public",ws_,"class",ws_,C1,ws_,"extends",!,ws_,C2,ws,"{",!,ws,B,(Indent;ws),"}").

class_(Data,[Name,Body,Indent]) -->
	("public",ws_,"class",ws_,Name,ws,"{",!,ws,Body,(Indent;ws),"}").


function_(Data,[Name,Type,Params,Body,Indent]) -->
                ("public",ws_,"static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}").
reserved_words(A) :-
	forall(member(B,["end","sin","cos","tan","abs","type","writeln","indexOf","charAt","gets","sample","array","readline","array_rand","input","random","choice","randrange","list","print","print_int","print_string","String","string","int","sort","sorted","reverse","sha1","reversed","len","unique_everseen","True","Number","float","double","return","def","str","char","boolean","function","false","true","enumerate"]),dif(A,B)).

var_name_(Data,Type,A) -->
	symbol(A),{is_var_type(Data, A, Type)},!.

else(Data,[Indent,A]) -->
	("else",ws,"{",!,ws,A,(Indent;ws),"}").

enum_list_separator(Data) -->
	",".

parameter_separator(Data) -->
 ",".
        
same_value_separator(Data) -->
        langs_to_output(Data,same_value_separator,[
        ['java','c#','perl']:
			"=",
		['haxe']:
			","
        ]).

varargs_(Data,[Type,Name]) -->
	(Type,ws,"...",ws_,Name).


parameter_(Data,[Type,Name]) -->
	Type,ws_,Name.


enum_(Data,[Name,Body,Indent]) -->
	("public",ws_,"enum",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}").

import_(Data,[A]) -->
	("import",ws_,"*",ws_,"as",ws_,A,ws_,"from",ws_,"'",ws,A,ws,"'",ws,";",!).

comment_(Data,[A]) -->
		("//",A).

first_case_(Data,[B,Compare_expr,Expr,Case_or_default]) -->
	("case",ws_,Expr,ws,":",!,ws,B,ws,"break",ws,";",!,ws,Case_or_default).

case(Data,[A,B,Expr,Case_or_default,Indent]) -->
	("case",ws_,Expr,ws,":",!,ws,B,ws,"break",ws,";",!,ws,Case_or_default).


default(Data,[A,Indent]) -->
	("default",ws,":",!,ws,A).

elif(Data,[Indent,A,B]) -->
	("else",ws_,"if",ws,"(",!,ws,A,ws,")",!,ws,"{",!,ws,B,(Indent;ws),"}").
default_parameter_(Data,[Type,Name,Value]) -->
	(Name,python_ws,"=",python_ws,Value).

%generate a random integer from Min (inclusive) to Max (exclusive)
random_int_in_range(Data,[Min,Max]) -->
	("(",ws,"Math",ws,".",ws,"floor",ws,"(",ws,"Math",ws,".",ws,"random",ws,"(",ws,")",ws,"*",ws,"(",ws,Max,ws,"-",ws,Min,ws,"+",ws,"1",ws,")",ws,"+",ws,Min,ws,")").

%see https://www.rosettacode.org/wiki/Pick_random_element
random_from_list(Data,[Arr]) -->
	(Arr,python_ws,"[Math.floor(Math.random()*",python_ws,Arr,python_ws,".length)]").

random_number(Data) -->
	"Math",ws,".",ws,"random",ws,"(",ws,")",!.

type(Data,auto_type) -->
	"Object".

type(Data,regex) -->
	"RegExp".

type(Data,[dict,Type_in_dict]) -->
	"Object".
type(Data,int) -->
	"int".

type(Data,string) -->
	"String".

type(Data, bool) -->
	"boolean".

type(Data,void) -->
	"void".

type(Data,double) -->
	"double".

% https://rosettacode.org/wiki/Arrays
type(Data,[array,Type]) -->
    {ground(Type)}, %Type contains no unknown variables
            "Array".


statement_separator(Data) -->
	ws.
initializer_list_separator(Data) -->
	",".
key_value_separator(Data) -->
	",".


top_level_statement_(Data,A) -->
	A.
% see rosettacode.org/wiki/Regular_expressions
regex_literal_(Data,[S]) -->
	("/",S,"/").

include_in_each_file(Data) -->
	"".

% spelled backwards
% reverse a string (not in-place)
% see https://www.rosettacode.org/wiki/Reverse_a_string
reverse_string_(Data,[Str]) -->
	("esrever",ws,".",ws,"reverse",ws,"(",ws,Str,ws,")").

key_value_(Data,[A,B]) -->
	(A,ws,":",!,ws,B).


compare_(Data,Type,[A,B]) -->
	(A,ws,"===",ws,B),{Type=int;Type=string;Type=bool}.

less_than_(_,[A,B]) -->
	(infix_operator("<",A,B)).

less_than_or_equal_to_(_,[A,B]) -->
	infix_operator("<=",A,B).


greater_than_or_equal_to_(_,[A,B]) -->
	A,ws,">=",ws,B.

greater_than_(_,[A,B]) -->
	infix_operator(">",A,B).

string_not_equal_(_,[A,B]) -->
	(infix_operator("!==",A,B)).

int_not_equal_(_,[A,B]) -->
	(infix_operator("!==",A,B)).

pow_(_,[A,B]) -->
("Math",ws,".",ws,"pow",ws,"(",!,ws,A,ws,",",ws,B,ws,")").

sqrt(_,[X]) -->
	("Math",ws,".",ws,"sqrt",ws,"(",!,ws,X,ws,")").
list_comprehension_(_,[Variable,Array,Result,Condition]) -->
	("[",ws,Result,ws_,"for",ws,"(",ws,Variable,ws_,"of",ws_,Array,ws,")",ws,"if",ws_,Condition,ws,"]").
   
startswith_(_,[Str1,Str2]) -->
	(Str1,ws,".",ws,"startsWith",ws,"(",!,ws,Str2,ws,")").
endswith_(_,[Str1,Str2]) -->
	(Str1,ws,".",ws,"endsWith",ws,"(",!,ws,Str2,ws,")").
%remove extra whitespace at beginning and end of string
% see https://www.rosettacode.org/wiki/Strip_whitespace_from_a_string
trim_(_,[Str]) -->
	(Str,ws,".",ws,"trim",ws,"(",!,ws,")").

% see https://www.rosettacode.org/wiki/Strip_whitespace_from_a_string
lstrip_(_,[Str]) -->
	(Str,ws,".replace(/^\s+/,'')").

% see https://www.rosettacode.org/wiki/Strip_whitespace_from_a_string
rstrip_(_,[Str]) -->
	(Str,ws,".replace(/\s+$/,'')").

lowercase_(_,[Str]) -->
	(Str,ws,".",ws,"toLowerCase",ws,"(",!,ws,")").

array_contains(_,[Container,Contained]) -->
	("(",ws,Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")",ws,"!==",ws,"-1",ws,")";
                Container,ws,".",ws,"includes",ws,"(",ws,Contained,ws,")").

%Str1 contains Str2
string_contains_(_,[Str1,Str2]) -->
("(",ws,Str1,ws,".",ws,"indexOf",ws,"(",ws,Str2,ws,")",ws,(">";"!==";"!="),ws,"-1",ws,")").

this_(_,[A]) -->
            ("this",ws,".",!,ws,A).

access_dict_(_,[Dict,Dict_,Index]) -->
	((Dict,ws,"[",ws,Index,ws,"]")).

command_line_args_(_) -->
	("process",ws,".",ws,"argv",ws,".",ws,"slice",ws,"(",ws,"2",ws,")").

call_constructor_(_,[Name,Args]) -->
        ("new",ws_,Name,ws,"(",ws,Args,ws,")").

regex_matches_string_(_,[Reg,Str]) -->
            (Reg,ws,".",ws,"test",ws,"(",ws,Str,ws,")").


dict_keys_(_,[A]) -->
	("Object",ws,".",ws,"keys",ws,"(",ws,A,ws,")").


%replace a string (not in-place)
global_replace_in_string_(_,[Str,Sub,Replacement]) -->
	(Str,ws,".",ws,"split",ws,"(",ws,Sub,ws,")",ws,".",ws,"join",ws,"(",ws,Replacement,ws,")").

%get the first index of a substring
index_of_substring_(_,[String,Substring]) -->
	(String,ws,".",ws,"indexOf",ws,"(",ws,Substring,ws,")").

substring_(_,[A,B,C]) -->
	(A,ws,".",ws,"substring",ws,"(",ws,B,ws,",",ws,C,ws,")").
not_(_,[A]) -->
	("!",A).

and_(_,[A,B]) -->
	(A,ws,"&&",ws,B).

sort_in_place_(_,[List]) -->
	(List,python_ws,".",python_ws,"sort",python_ws,"(",python_ws,")").
reverse_sort_in_place_(_,[List]) -->
	(List,ws,".",ws,"sort",ws,"(",ws,")",ws,".",ws,"reverse",ws,"(",ws,")").

uppercase_(_,[Str]) -->
	(Str,ws,".",ws,"toUpperCase",ws,"(",ws,")").


% see https://rosettacode.org/wiki/Real_constants_and_functions
pi_(_) -->
            ("Math",ws,".",ws,"PI").
     

eager_and_(_,[Var1,Var2]) -->
	(Var1,python_ws,"&",python_ws,Var2).
eager_or_(_,[Var1,Var2]) -->
	(Var1,python_ws,"|",python_ws,Var2).

or_(_,[Var1,Var2]) -->
	(Var1,ws,"||",!,ws,Var2).
last_index_of_(_,[String,Substring]) -->
	(String,ws,".",ws,"lastIndexOf",ws,"(",ws,Substring,ws,")").


optional_indent(Data,Indent) -->
	{Data = [Lang,_,_,Indent],
	offside_rule_langs(Offside_rule_langs)},
	{memberchk(Lang,Offside_rule_langs)}->
		Indent;
	(Indent;"").

%This creates variables without initializing them.
declare_vars_(_,[Vars,Type]) -->
		("var",ws_,Vars).
%This creates each variable with a value.
initialize_vars_(_,[Vars,Type]) -->
	("var",ws_,Vars).


try_catch_(Data,[Body1,Name,Body2,Indent]) -->
("try",ws,"{",ws,Body1,ws,"}",ws,"catch",ws,"(",ws,Name,ws,")",ws,"{",ws,Body2,ws,"}").
%see https://rosettacode.org/wiki/Sort_an_integer_array#C.23
%sort a list of integers (not in-place)
sort_(Data,[List]) -->
			(List,ws,".",ws,"sort",ws,"(",ws,")").


type_is_string(Data,[Object]) -->
	(Object,ws_,"instanceof",ws_,"String",ws,"||",ws,"typeof",ws_,Object,ws,"===",ws,"\"string\"").

type_is_bool(Data,[Object]) -->
	("typeof",ws,"(",ws,Object,python_ws,")",ws,"==",ws,"\"boolean\"";
	"\"boolean\"",ws,"==",ws,"typeof",ws,"(",ws,Object,ws,")").

type_is_list(Data,[Object]) -->
	("Array",ws,".",ws,"isArray(",ws,Object,ws,")").
