:- module('transpiler', [translate/3,translate/4]).
:- use_module(parser).
:- use_module(tokenizer).

:- set_prolog_flag(double_quotes,chars).
:- use_module(library(chr)).
  
:- chr_constraint var_type(+,+,+).
var_type(Namespace,Var,Type) \ var_type(Namespace,Var,Type) <=> true.
var_type(Namespace,Var,Type1),var_type(Namespace,Var,Type2) <=> Type1=Type2. %,writeln('\ntype of'),writeln(Var),writeln('in'),writeln(Namespace),writeln('is'),writeln(Type1).
var_type(_,number(_),Type) <=> (Type=number;Type=int).
var_type(Namespace,Var,_) ==> type_inference(Namespace,Var).

:- chr_constraint return_type(+,+).
return_type(A,B) \ return_type(A,B) <=> true.
return_type(A,B), return_type(A,C) <=> B=C.

:- chr_constraint type_inference(+,+).
type_inference(+,+) \ type_inference(+,+) <=> true.
 
:- chr_constraint var_types(+,+,+).
var_types(Namespace,[Var],Type) <=> var_type(Namespace,Var,Type).
var_types(Namespace,[Var|Vars],Type) <=> var_type(Namespace,Var,Type),var_types(Namespace,Vars,Type).

:- chr_constraint same_var_type(+,+,+).
same_var_type(+,+,+) \ same_var_type(+,+,+) <=> true.
same_var_type(Namespace,Var1,Var2) ==> var_type(Namespace,Var1,Type),var_type(Namespace,Var2,Type).
 
:- chr_constraint function(+,+,+).
function(A,B,C) \ function(A,B,C) <=> true.
function(Type,Name,Params), function(Type1,Name,Params1) ==> Type=Type1,Params=Params1,writeln([function,Name]).

:- chr_constraint parse_lang(+,+,+).
parse_lang(A,B,C) \ parse_lang(A,B,C) <=> true.
parse_lang(Lang,Input,Output) ==>
	phrase(parser:statements_(Lang,"\n",Output),Input).

 
:- chr_constraint same_param_types(+,+,+).
same_param_types(A,B,C) \ same_param_types(A,B,C) <=> true.

:- chr_constraint type_inference_(+,+).
type_inference_(A,B) \ type_inference_(A,B) <=> true.
type_inference_(Namespace,[A]) <=>
    type_inference(Namespace,A).
type_inference_(Namespace,[A|B]) <=>
    type_inference(Namespace,A),type_inference_(Namespace,B).

translate(Lang2,Input,Output) :-
	member(Lang1,[python,php,ruby,javascript,lua,java,c,'c#']),
	translate(Lang1,Lang2,Input,Output).
	
translate(Lang1,Lang2,Input_,Output) :-
    append("\n",Input_,Input),parse_lang(Lang1,Input,Output1),writeln('finished parsing'),!,type_inference_('_',Output1),!,writeln('Type inference finished. Generating source code:'),parse_lang(Lang2,Output,Output1).
 
same_param_types(Namespace,[Params],[Params2]) ==>
    Params2 = symbol(Type,_),
    var_type(Namespace,Params,Type).
same_param_types(Namespace,[A|A1],[B|B1]) ==>
    same_param_types(Namespace,[A],[B]),same_param_types(Namespace,A1,B1).

%type_inference(Namespace,A) ==>
%	writeln(['infer types for',A,'in',Namespace]).

type_inference(Namespace,access_array(Type1,Arr,Index)) <=>
	var_type(Namespace,Index,int),
	writeln(access_array(Type1,Arr,Index)),
	(var_type(Namespace,Arr,[array,Type]),
	var_type(Namespace,access_array(Type1,Arr,Index),Type),
	Type1 = [array,Type];
	var_type(Namespace,Arr,string),
	var_type(Namespace,access_array(Type1,Arr,Index),char),
	Type1 = string).

type_inference(Namespace,random_from_list(Arr,Index)) <=>
	var_type(Namespace,Arr,[array,Type]),
	var_type(Namespace,random_from_list(Arr),Type).


type_inference(Namespace,replace(string,A,B,C)) <=>
	var_types(Namespace,[A,B,C,replace(string,A,B,C)],string).

type_inference(Namespace,set_array_size(Type,Name,Size)) <=>
	var_type(Namespace,Size,int),
	var_type(Namespace,Name,[array,Type]).

type_inference(Namespace,lstrip(A)) <=>
	var_types(Namespace,[A,lstrip(A)],string).
type_inference(Namespace,rstrip(A)) <=>
	var_types(Namespace,[A,rstrip(A)],string).
type_inference(Namespace,strip(A)) <=>
	var_types(Namespace,[A,strip(A)],string).
type_inference(Namespace,substring(A,B,C)) <=>
	var_types(Namespace,[A,substring(A,B,C)],string),
	var_types(Namespace,[B,C],int).

type_inference(Namespace,split(string,A,B)) <=>
	var_types(Namespace,[A,B],string),
	var_type(Namespace,split(string,A,B),[array,string]).

type_inference(Namespace,join(Arr,Sep)) <=>
	var_types(Namespace,[Sep,join(Arr,Sep)],string),
	var_type(Namespace,Arr,[array,string]).

type_inference(Namespace,this(Type,Name)) <=>
	Namespace = [_|Namespace1],type_inference(Namespace1,symbol(Type,var_name(Type,Name))).
	
type_inference(Namespace,symbol(Type,var_name(Type,Name))) <=>
	var_type(Namespace,symbol(Type,var_name(Type,Name)),Type),
	var_type(Namespace,var_name(Type,Name),Type),
	type_inference(Namespace,var_name(Type,Name)).
type_inference(Namespace,var_name(Type,Name)) <=>
    var_type(Namespace,symbol(Type,var_name(Type,Name)),Type),
	var_type(Namespace,var_name(Type,Name),Type).
type_inference(Namespace,function_call(Type,Name,Params)) <=>
    function(Type,Name,Params1),
    var_type(Namespace,function_call(Type,Name,Params),Type),
    same_param_types(Namespace,Params,Params1),
    type_inference_(Namespace,Params).
type_inference(Namespace,randint(A,B)) <=>
    var_types(Namespace,[A,B,randint(A,B)],int).
type_inference(Namespace,contains(Type1,Container,Contained)) <=>
    (Type1=[array,Type];Type1=string,Type=string),
    var_type(Namespace,contains(Type1,Container,Contained),bool),
    var_type(Namespace,Contained,Type),
    var_type(Namespace,Container,Type1),
    type_inference_(Namespace,[Container,Contained]).

type_inference(Namespace,constructor(Name,Params,Body)) <=>
	Namespace = [Name|_],
	writeln(Name),
	type_inference(Namespace,function(Name,Name,Params,Body)).

type_inference(Namespace,static_method(Type,Name,Params,Body)) <=>
	type_inference(Namespace,function(Type,Name,Params,Body)).
type_inference(Namespace,instance_method(Type,Name,Params,Body)) <=>
	type_inference(Namespace,function(Type,Name,Params,Body)).
type_inference(Namespace,function(Type,Name,Params,Body)) <=>
    function(Type,Name,Params),
    type_inference_([Name|Namespace],Body),
    type_inference_([Name|Namespace],Params),
    return_type([Name|Namespace],Type),
    writeln(function(Type,Name,Params)).
type_inference(Namespace,class(Name,Body)) <=>
    type_inference_([Name|Namespace],Body).
type_inference(Namespace,number(A)) <=>
    var_type(Namespace,number(A),_).
type_inference(Namespace,typeof(_,A)) <=>
    var_type(Namespace,typeof(_,A),type).
type_inference(Namespace,typeof(A)) <=>
    var_type(Namespace,typeof(A),type).
type_inference(Namespace,subtract(A,B)) <=>
    var_types(Namespace,[A,B,subtract(A,B)],Type),(Type=int;Type=number).
type_inference(Namespace,divide(A,B)) <=>
    var_types(Namespace,[A,B,divide(A,B)],Type),(Type=int;Type=number).
type_inference(Namespace,length(Type,A)) <=>
    var_type(Namespace,A,Type),
    var_type(Namespace,length(Type,A),int),
    (Type = [array,_]; Type=string).
type_inference(Namespace,println(Type,A)) <=>
    var_type(Namespace,A,Type).
type_inference(Namespace,assert(A)) <=>
    var_type(Namespace,A,bool).
type_inference(Namespace,initializer_list(Type,A)) <=>
	var_types(Namespace,A,Type),
    var_type(Namespace,initializer_list(Type,A),[array,Type]).
    
type_inference(Namespace,for(Initialize,Condition,Update,Body)) <=>
	var_type(Namespace,Condition,bool),
	type_inference_(Namespace,[Initialize,Update]),
	type_inference_(Namespace,Body).
	
type_inference(Namespace,char_literal(A)) <=>
    var_type(Namespace,char_literal(A),char).
type_inference(Namespace,string_literal(A)) <=>
    var_type(Namespace,string_literal(A),string).
type_inference(Namespace,not(A)) <=>
    var_types(Namespace,[not(A),A],bool).
type_inference(Namespace,range(A,B)) <=>
    var_types(Namespace,[A,B],int),
    var_type(Namespace,range(A,B),[array,int]).
type_inference(Namespace,sin(A)) <=>
    var_types(Namespace,[sin(A),A],number).
type_inference(Namespace,sqrt(A)) <=>
    var_types(Namespace,[sqrt(A),A],number).
type_inference(Namespace,pow(A,B)) <=>
    var_types(Namespace,[pow(A,B),A,B],number).
type_inference(Namespace,floor(A)) <=>
    var_types(Namespace,[floor(A),A],number).
type_inference(Namespace,ceiling(A)) <=>
    var_types(Namespace,[ceiling(A),A],number).
type_inference(Namespace,abs(Type,A)) <=>
    var_types(Namespace,[abs(A),A],Type),
    type_inference(Namespace,A).
type_inference(Namespace,cos(A)) <=>
    var_types(Namespace,[cos(A),A],number).
type_inference(Namespace,tan(A)) <=>
    var_types(Namespace,[tan(A),A],number).
type_inference(Namespace,multiply(A,B)) <=>
    var_types(Namespace,[A,B,multiply(A,B)],Type),
    (Type=int;Type=number).
type_inference(Namespace,greater_than(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type),
    var_type(Namespace,greater_than(Type,A,B),bool).
type_inference(Namespace,less_than(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type),
    var_type(Namespace,less_than(Type,A,B),bool).
type_inference(Namespace,less_than_or_equal(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type),
    var_type(Namespace,less_than_or_equal(A,B),bool).
type_inference(Namespace,greater_than_or_equal(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type),
    var_type(Namespace,less_than_or_equal(A,B),bool).
type_inference(Namespace,plus_plus(Type,A)) <=>
    var_type(Namespace,A,Type),
    (Type=int;Type=number).
type_inference(Namespace,reverse_in_place(Type,A)) <=>
    var_type(Namespace,A,Type).
type_inference(Namespace,sort_in_place(Type,A)) <=>
    var_type(Namespace,A,Type).
type_inference(Namespace,parentheses(A)) <=>
    var_types(Namespace,[parentheses(A),A],Type).
type_inference(Namespace,add(Type,A,B)) <=>
    var_types(Namespace,[A,B,add(Type,A,B)],Type).
type_inference(Namespace,or(A,B)) <=>
    var_types(Namespace,[A,B,or(A,B)],bool).
type_inference(Namespace,and(A,B)) <=>
    var_types(Namespace,[A,B,and(A,B)],bool).
type_inference(Namespace,set_var(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type).
type_inference(Namespace,return(Type,A)) <=>
    return_type(Namespace,Type),
    var_type(Namespace,A,Type).
type_inference(Namespace,initialize_var(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type).
type_inference(Namespace,initialize_constant(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type).
type_inference(Namespace,initialize_constant(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type).

type_inference(Namespace,plus_equals(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type).
 
type_inference(Namespace,divide_equals(A,B)) <=>
    var_types(Namespace,[A,B],number).

type_inference(Namespace,type_conversion(Type1,Type2,A)) <=>
    writeln('equals type inference'),
    var_type(Namespace,A,Type1),
    var_type(Namespace,type_conversion(Type1,Type2,A),Type2).
type_inference(Namespace,equals(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type),
    var_type(Namespace,equals(Type,A,B),bool).
%set index for dictionaries and arrays
type_inference(Namespace,set_array_index(A,B,C)) <=>
    var_type(Namespace,B,Type1),var_type(Namespace,C,Type2),var_type(Namespace,A,[dict,Type1,Type2]).
type_inference(Namespace,set_array_index(A,B,C)) <=>
    var_type(Namespace,B,number),var_type(Namespace,C,Type),var_type(Namespace,A,[array,Type]),
    type_inference_(Namespace,[A,B,C]).
type_inference(Namespace,not_equals(Type,A,B)) <=>
    var_types(Namespace,[A,B],Type),
    var_type(Namespace,not_equals(Type,A,B),bool).
type_inference(Namespace,'true') <=>
	var_type(Namespace,'true',bool).
type_inference(Namespace,'false') <=>
	var_type(Namespace,'false',bool).
type_inference(Namespace,times_equals(A,B)) <=>
    var_types(Namespace,[A,B],number).
type_inference(Namespace,minus_equals(A,B)) <=>
    var_types(Namespace,[A,B],number).
     
type_inference(Namespace,while(A,B)) <=>
    %writeln(['while',namespace,Namespace]),
    var_type(Namespace,A,bool),
    type_inference_(Namespace,B).

type_inference(Namespace,if(A,B)) <=>
    %writeln(['if',namespace,Namespace]),
    var_type(Namespace,A,bool),
    type_inference_(Namespace,B).


type_inference(Namespace,if_else(A,B,C)) <=>
    %writeln(['if',namespace,Namespace]),
    var_type(Namespace,A,bool),
    type_inference_(Namespace,B),
    type_inference_(Namespace,C).

type_inference(Namespace,if(A,B,C,D)) <=>
    %writeln(['if',namespace,Namespace]),
    var_type(Namespace,A,bool),
    type_inference_(Namespace,B),
    type_inference_(Namespace,C),
    type_inference_(Namespace,D).
 
type_inference(Namespace,foreach(Type,Var,Array,Body)) <=>
	var_type(Namespace,Array,[array,Type]),
	var_type(Namespace,Var,Type),
	type_inference_(Namespace,Body).

type_inference(Namespace,foreach_with_index(Array,Var,Index,Type,Body)) <=>
	writeln('infer foreach'),
	var_type(Namespace,Index,int),
	var_type(Namespace,Var,Type),
	var_type(Namespace,Array,[array,Type]),
	type_inference_(Namespace,Body).

type_inference(Namespace,elif(A,B)) <=>
    var_type(Namespace,A,bool),
    type_inference_(Namespace,B).
 
type_inference(Namespace,else(A)) <=>
    type_inference_(Namespace,A).
 
type_inference(Namespace,statement_with_semicolon(A)) <=>
    type_inference(Namespace,A).
