%To do: find out why lists of string literals aren't being parsed correctly

:- module('parser', [statements_/5]).
:- set_prolog_flag(double_quotes,chars).
:-style_check(-discontiguous).
:-style_check(-singleton).

statements_(Lang,A,B) --> ws,"\n",{writeln('calling statements_')},top_level_statements(Lang,A,B),ws.

class_statement(Lang,Indent,constructor(Name,Params,Body)) -->
	optional_indent(Lang,Indent),constructor_(Lang,symbol(Name),parameters(Lang,Params),statements(Lang,indent(Indent),Body),Indent),!.

class_statement(Lang,Indent,instance_method(Type,Name,Params,Body)) -->
	optional_indent(Lang,Indent),instance_method_(Lang,symbol(Name),type(Lang,Type),parameters(Lang,Params),statements(Lang,indent(Indent),Body),Indent),!.

class_statement(Lang,Indent,static_method(Type,Name,Params,Body)) -->
	optional_indent(Lang,Indent),static_method_(Lang,symbol(Name),type(Lang,Type),parameters(Lang,Params),statements(Lang,indent(Indent),Body),Indent),!.

statement(Lang,Indent,if_else(A,B,C)) -->
	optional_indent(Lang,Indent),if_(Lang,Indent,expr(Lang,A),statements(Lang,indent(Indent),B)),else(Lang,Indent,C),!.

statement(Lang,Indent,if(A,B,C,D)) -->
	optional_indent(Lang,Indent),if_(Lang,Indent,expr(Lang,A),statements(Lang,indent(Indent),B)),elif_statements(Lang,Indent,C),else(Lang,Indent,D),!.

statement(Lang,Indent,if(A,B)) -->
	optional_indent(Lang,Indent),if_without_else(Lang,Indent,expr(Lang,A),statements(Lang,indent(Indent),B)),{writeln("if without else")},!.

statement(Lang,Indent,while(A,B)) -->
	optional_indent(Lang,Indent),while_(Lang,Indent,expr(Lang,A),statements(Lang,indent(Indent),B)),!.

statement(Lang,Indent,function(Type,Name,Params,Body)) -->
	optional_indent(Lang,Indent),function_(Lang,Indent,type(Lang,Type),symbol(Name),parameters(Lang,Params),statements(Lang,indent(Indent),Body)),!.

statement(Lang,Indent,for(Initialize,Condition,Update,Body)) -->
	optional_indent(Lang,Indent),for_(Lang,Indent,statement_with_semicolon(Lang,Initialize),expr(Lang,Condition),statement_with_semicolon(Lang,Update),statements(Lang,indent(Indent),Body)),!.

statement(Lang,Indent,class(Name,Body)) -->
	optional_indent(Lang,Indent),class_(Lang,Indent,symbol(Name),class_statements(Lang,indent(Indent),Body)),!.

statement(Lang,Indent,statement_with_semicolon(A)) --> optional_indent(Lang,Indent),statement_with_semicolon_(Lang,Indent,statement_with_semicolon(Lang,A)),!.

statement(Lang,Indent,foreach(Type,Var,Array,Body)) -->
	optional_indent(Lang,Indent),foreach_(Lang,Indent,type(Lang,Type),var_name(Lang,Type,Var),parentheses_expr(Lang,Array),statements(Lang,indent(Indent),Body)),!.
	
statement(Lang,Indent,foreach_with_index(Array,Var,Index,Type,Body)) -->
	optional_indent(Lang,Indent),foreach_with_index(Lang,Indent,parentheses_expr(Lang,Array),var_name(Lang,Type,Var),var_name(Lang,int,Index),type(Lang,Type),statements(Lang,indent(Indent),Body)),!.

indented_block(A) -->
	python_ws_,A,":";ws,"(",ws,A,ws,"):",!.

elif(Lang,Indent,elif(A,B)) -->
	optional_indent(Lang,Indent),elif_(Lang,Indent,[expr(Lang,A),statements(Lang,indent(Indent),B)]),!.


else(Lang,Indent,B) -->
	optional_indent(Lang,Indent),else_(Lang,Indent,statements(Lang,indent(Indent),B)),!.
	

elif_statements(Lang,Indent,[A]) --> elif(Lang,Indent,A).
elif_statements(Lang,Indent,[A|B]) --> elif(Lang,Indent,A),!,ws,elif_statements(Lang,Indent,B).

indent(Indent) --> Indent,"\t".

add_expr(Lang,A) --> mul_expr(Lang,A).
add_expr(Lang,add(Type,A,B)) --> add_(Lang,Type,mul_expr(Lang,A),add_expr(Lang,B)).
add_expr(Lang,subtract(A,B)) --> mul_expr(Lang,A),ws,"-",!,ws,add_expr(Lang,B).

mul_expr(Lang,A) --> dot_expr(Lang,A).
mul_expr(Lang,multiply(A,B)) --> parentheses_expr(Lang,A),ws,"*",!,ws,mul_expr(Lang,B).
mul_expr(Lang,divide(A,B)) --> parentheses_expr(Lang,A),ws,"/",!,ws,mul_expr(Lang,B).

expr(Lang,A) --> add_expr(Lang,A).
expr(Lang,not_equals(Type,A,B)) --> not_equals_(Lang,Type,add_expr(Lang,A),add_expr(Lang,B)).
expr(Lang,equals(Type,A,B)) --> equals_(Lang,Type,add_expr(Lang,A),add_expr(Lang,B)).
expr(Lang,or(A,B)) --> or_(Lang,add_expr(Lang,A),add_expr(Lang,B)).
expr(Lang,and(A,B)) --> and_(Lang,add_expr(Lang,A),add_expr(Lang,B)).
expr(Lang,less_than(Type,A,B)) --> add_expr(Lang,A),ws,"<",ws,add_expr(Lang,B).
expr(Lang,greater_than(Type,A,B)) --> add_expr(Lang,A),ws,">",ws,add_expr(Lang,B).
expr(Lang,less_than_or_equal(Type,A,B)) --> add_expr(Lang,A),ws,"<=",!,ws,add_expr(Lang,B).
expr(Lang,greater_than_or_equal(Type,A,B)) --> add_expr(Lang,A),ws,">=",!,ws,add_expr(Lang,B).


%This is valid for strings and arrays in python


%this is valid for strings and arrays
expr(Lang,contains(Type,Container,Contained)) -->
	contains_(Lang,Type,parentheses_expr(Lang,Container),parentheses_expr(Lang,Contained)).

infix_either_order(A,Op,B) -->
	A,ws,Op,ws,B;
	B,ws,Op,ws,A.

parentheses_expr(Lang,initializer_list(Type,S)) -->
	initializer_list_(Lang,type(Lang,Type),initializer_list_(Lang,S)),!.
parentheses_expr(Lang,parentheses(A)) -->
	"(",!,ws,expr(Lang,A),ws,")",!.
parentheses_expr(Lang,char_literal(S)) -->
	"\'",string_inner([S]),"\'".
parentheses_expr(Lang,string_literal(S)) -->
	string_literal(S),!.
parentheses_expr(Lang,string_literal(S)) -->
	string_literal1(S),!.
parentheses_expr(Lang,abs(Type,A)) -->
	abs_(Lang,number,expr(Lang,A)),!.
parentheses_expr(Lang,sqrt(A)) -->
	sqrt_(Lang,expr(Lang,A)),!.
parentheses_expr(Lang,sin(A)) -->
	sin_(Lang,expr(Lang,A)),!.
parentheses_expr(Lang,cos(A)) -->
	cos_(Lang,expr(Lang,A)),!.
parentheses_expr(Lang,acos(A)) -->
	acos_(Lang,expr(Lang,A)),!.
parentheses_expr(Lang,tan(A)) -->
	tan_(Lang,expr(Lang,A)),!.
parentheses_expr(Lang,atan(A)) -->
	atan_(Lang,expr(Lang,A)),!.
parentheses_expr(Lang,asin(A)) -->
	asin_(Lang,expr(Lang,A)),!.
parentheses_expr(Lang,floor(A)) -->
	floor_(Lang,expr(Lang,Arr)),!.
parentheses_expr(Lang,ceiling(A)) -->
	ceiling_(Lang,expr(Lang,Arr)),!.
parentheses_expr(Lang,'false') -->
	false_(Lang).
parentheses_expr(Lang,'true') -->
	true_(Lang).
parentheses_expr(Lang,number(A)) --> a_double(A).
parentheses_expr(Lang,A) --> var_name(Lang,Type,A).
parentheses_expr(Lang,function_call(_,Name,Params)) -->
	symbol(Name),ws,"(",!,ws,function_call_parameters(Lang,Params),ws,")",!.


dot_expr(Lang,A) --> parentheses_expr(Lang,A).
dot_expr(Lang,not(A)) -->
	not_(Lang,parentheses_expr(Lang,A)),!.
dot_expr(Lang,access_array(Type,Arr,In_arr)) -->
    access_array_(Lang,Type,parentheses_expr(Lang,Arr),expr(Lang,In_arr)),!.
dot_expr(Lang,range(A,B)) -->
	range_(Lang,parentheses_expr(Lang,A),parentheses_expr(Lang,B)).
dot_expr(Lang,length(Type,A)) --> length_(Lang,Type,parentheses_expr(Lang,A)),!.
dot_expr(Lang,this(Type,A)) -->
	this_(Lang,var_name(Lang,Type,A)).
dot_expr(Lang,randint(A,B)) -->
	randint(Lang,expr(Lang,A),expr(Lang,B)).
dot_expr(Lang,replace(string,A,B,C)) -->
	replace_(Lang,string,parentheses_expr(Lang,A),parentheses_expr(Lang,B),parentheses_expr(Lang,C)).
dot_expr(Lang,split(string,A,B)) -->
	split_(Lang,string,parentheses_expr(Lang,A),parentheses_expr(Lang,B)).
%dot_expr(Lang,join(A,B)) -->
%	join_(Lang,parentheses_expr(Lang,A),parentheses_expr(Lang,B)).
dot_expr(Lang,type_conversion(Type1,Type2,A)) -->
	type_conversion_(Lang,Type1,Type2,expr(Lang,Type1,A)).
dot_expr(python,Type,pow(A,B)) -->
	parentheses_expr(python,Type,A),ws,"**",ws,parentheses_expr(python,Type,B).
dot_expr(Lang,pow(A,B)) -->
	pow_(Lang,expr(Lang,A),expr(Lang,B)),!.
%dot_expr(Lang,random_int_in_range(Type,Arr)) -->
%	random_int_in_range(Lang,Type,expr(Arr)).
%dot_expr(Lang,random_from_list(Arr)) -->
%	random_from_list(Lang,expr(Lang,[array,Type],Arr)).
%dot_expr(Lang,substring(Str,A,B)) -->
%	substring_(Lang,parentheses_expr(Lang,Str),parentheses_expr(Lang,A),parentheses_expr(Lang,B)).
%dot_expr(Lang,lstrip(Str)) -->
%	lstrip_(Lang,parentheses_expr(Lang,Str)).
%dot_expr(Lang,strip(Str)) -->
%	strip_(Lang,parentheses_expr(Lang,Str)).
%dot_expr(Lang,rstrip(Str)) -->
%	rstrip_(Lang,parentheses_expr(Lang,Str)).


reserved_words(A) :-
	member(A,["end","float","sin","cos","tan","abs","type","writeln","indexOf","charAt","gets","sample","array","readline","array_rand","input","random","choice","randrange","list","print","print_int","print_string","String","string","int","sort","sorted","reverse","sha1","reversed","len","unique_everseen","True","Number","float","double","return","def","str","char","boolean","function","false","true","enumerate"]) -> false;true.

statement_with_semicolon(Lang,println(Type,A))-->
	println_(Lang,Type,expr(Lang,A)),!.
statement_with_semicolon(Lang,return(Type,A))-->
	return_(Lang,Type,expr(Lang,A)).
statement_with_semicolon(Lang,initialize_var(Type,A,B)) -->
	initialize_var_(Lang,type(Lang,Type),var_name(Lang,Type,A),expr(Lang,B)).
statement_with_semicolon(Lang,initialize_var(Type,A)) -->
	initialize_var_(Lang,type(Lang,Type),var_name(Lang,Type,A)).
statement_with_semicolon(Lang,assert(A)) -->
	assert_(Lang,expr(Lang,A)),!.
%statement_with_semicolon(Lang,set_array_size(Type,Name,Size)) -->
%	set_array_size_(Lang,type(Lang,Type),symbol(Name),dot_expr(Lang,Size)).
	
statement_with_semicolon(Lang,initialize_constant(Type,A)) -->
	initialize_constant_(Lang,type(Lang,Type),var_name(Lang,Type,A)).
statement_with_semicolon(Lang,initialize_constant(Type,A,B)) -->
	initialize_constant_(Lang,type(Lang,Type),var_name(Lang,Type,A),expr(Lang,B)).

statement_with_semicolon(Lang,set_var(Type,A,B)) -->
	var_name(Lang,Type,A),ws,"=",!,ws,expr(Lang,B).
statement_with_semicolon(Lang,reverse_in_place(Type,A)) -->
	reverse_in_place_(Lang,expr(Lang,A)).
statement_with_semicolon(Lang,sort_in_place(Type,A)) -->
	sort_in_place_(Lang,expr(Lang,A)).
statement_with_semicolon(Lang,set_array_index(A,B,C)) -->
	set_array_index(Lang,parentheses_expr(Lang,A),expr(Lang,B),expr(Lang,C)).
statement_with_semicolon(Lang,times_equals(A,B)) -->
	times_equals_(Lang,parentheses_expr(Lang,A),expr(Lang,B)).
statement_with_semicolon(Lang,plus_equals(Type,A,B)) -->
	plus_equals_(Lang,Type,parentheses_expr(Lang,A),expr(Lang,B)).
statement_with_semicolon(Lang,divide_equals(A,B)) -->
	divide_equals_(Lang,parentheses_expr(Lang,A),expr(Lang,B)).
statement_with_semicolon(Lang,minus_equals(A,B)) -->
	minus_equals_(Lang,parentheses_expr(Lang,A),expr(Lang,B)).
statement_with_semicolon(Lang,plus_plus(A)) -->
	plus_plus(Lang,dot_expr(Lang,A)),!.
statement_with_semicolon(Lang,minus_minus(A)) -->
	minus_minus(Lang,dot_expr(Lang,A)),!.

top_level_statements(Lang,Indent,[A]) --> top_level_statement(Lang,Indent,A).
top_level_statements(Lang,Indent,[A|B]) --> top_level_statement(Lang,Indent,A),!,top_level_statement_separator(Lang),top_level_statements(Lang,Indent,B).


statements(Lang,Indent,[A]) --> statement(Lang,Indent,A).
statements(Lang,Indent,[A|B]) --> statement(Lang,Indent,A),!,statement_separator(Lang),statements(Lang,Indent,B).


%initializer_list_(Lang,[]) --> "".
initializer_list_(Lang,[A]) --> parentheses_expr(Lang,A).
initializer_list_(Lang,[A|B]) --> parentheses_expr(Lang,A),ws,",",!,ws,initializer_list_(Lang,B).

class_statements(Lang,Indent,[A]) --> class_statement(Lang,Indent,A).
class_statements(Lang,Indent,[A|B]) --> class_statement(Lang,Indent,A),!,ws,class_statements(Lang,Indent,B).

function_call_parameters(Lang,[]) --> "".
function_call_parameters(Lang,[A]) --> expr(Lang,A).
function_call_parameters(Lang,[A|B]) --> expr(Lang,A),ws,",",!,ws,function_call_parameters(Lang,B).
parameters(Lang,[A]) --> parameter(Lang,A);varargs(Lang,A).
parameters(Lang,[A|B]) --> parameters(Lang,[A]),ws,",",!,ws,parameters(Lang,B).
parameter(Lang,symbol(Type,A)) --> parameter_(Lang,type(Lang,Type),var_name(Lang,Type,A)).
varargs(Lang,symbol(Type,A)) --> varargs_(Lang,type(Lang,Type),var_name(Lang,Type,A)).

var_name(Lang,Type,var_name(Type,A)) --> var_name_(Lang,Type,symbol(A)),!.


:- include(language_grammars).
:- include(common_grammar).
