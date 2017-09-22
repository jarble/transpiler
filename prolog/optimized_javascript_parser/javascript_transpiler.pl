:- module('javascript_transpiler', [parse/5]).
:- use_module(library(chr)).

:- set_prolog_flag(double_quotes,chars).

% This is a program that translates several programming languages into several other languages.

% Edit this list to specify the languages that should be translated. Each language should be written in lowercase:



namespace(Data,Data1,Name1,Indent) :-
	Data = [Lang,Is_input,Namespace,Indent],
	Data1 = [Lang,Is_input,[Name1|Namespace],indent(Indent)],!.

namespace(Data,Data1,Name,Indent) -->
	    {
                namespace(Data,Data1,Name,Indent)
        },
		optional_indent(Data,Indent),!.

offside_rule_langs(['python','cython','coffeescript','english','cosmos','cobra']).

prefix_arithmetic_langs(['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript']).
infix_arithmetic_langs(['pascal','sympy','vhdl','elixir','python','visual basic .net','ruby','lua','scriptol', 'z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']).


%Use this rule to define operators for various languages


infix_operator(Symbol,Exp1,Exp2) -->
        Exp1,python_ws,Symbol,python_ws,Exp2.

prefix_operator(Data,Type,Symbol,Exp1,Exp2) -->
        "(",Symbol,ws_,expr(Data,Type,Exp1),ws_,expr(Data,Type,Exp2),")".



function_name(Data,Type,A,Params) -->
        symbol(A),{reserved_words(A)}.


indent(Indent) --> (Indent,("\t")).


else(Data,Return_type,Statements_) -->
        {
                indent_data(Indent,Data,Data1),
                A = statements(Data1,Return_type,Statements_)
        },
        else(Data,[Indent,A]),!.


first_case(Data,Return_type,Switch_expr,int,[Expr_,Statements_,Case_or_default_]) -->
    {
            indent_data(Indent,Data,Data1),
            B=statements(Data1,Return_type,Statements_),
            Compare_expr = expr(Data,bool,compare(int,Switch_expr,Expr_)),
            Expr = expr(Data,int,Expr_),

            Case_or_default = (case(Data,Return_type,Switch_expr,int,Case_or_default_);default(Data,Return_type,int,Case_or_default_))
    },
    optional_indent(Data,Indent),
    first_case_(Data,[B,Compare_expr,Expr,Case_or_default]),!.

case(Data,Return_type,Switch_expr,int,[Expr_,Statements_,Case_or_default_]) -->
        {
                indent_data(Indent,Data,Data1),
                B=statements(Data1,Return_type,Statements_),
                A = expr(Data,bool,compare(int,Switch_expr,Expr_)),
                Expr = expr(Data,int,Expr_),
                Case_or_default = (case(Data,Return_type,Switch_expr,int,Case_or_default_);default(Data,Return_type,int,Case_or_default_))
        },
    optional_indent(Data,Indent),
    case(Data,[A,B,Expr,Case_or_default,Indent]),!.

default(Data,Return_type,int,Statements_) -->
        {
                indent_data(Indent,Data,Data1),
                A = statements(Data1,Return_type,Statements_)
        },
        optional_indent(Data,Indent),
        default(Data,[A,Indent]),!.



indent(Data,Indent) :-
	Data = [_,_,_,Indent].

lang(Data,Lang) :-
	Data = [Lang|_].

elif_statements(Data,Return_type,[A]) --> elif(Data,Return_type,A),!.
elif_statements(Data,Return_type,[A|B]) --> elif(Data,Return_type,A),elif_separator(Data),elif_statements(Data,Return_type,B),!.

elif_separator(Data) -->
	ws.

indent_data(Indent,Data,Data1) :-
    Data = [Lang,Is_input,Namespace,Indent],
    (
    Data1 = [Lang,Is_input,Namespace,indent(Indent)]).

elif(Data,Return_type,[Expr_,Statements_]) -->
        {
                indent_data(Indent,Data,Data1),
                B=statements(Data1,Return_type,Statements_),
                A=expr(Data,bool,Expr_)
        },
        elif(Data,[Indent,A,B]),!.


%also called optional parameters
default_parameter(Data,[Type1,Name1,Default1]) -->
        {
                Type = type(Data,Type1),
                Name = var_name_(Data,Type1,Name1),
                Value = var_name_(Data,Type1,Default1)
        },
        default_parameter_(Data,[Type,Name,Value]).

parameter(Data,[Type1,Name1]) -->
        {
                Type = type(Data,Type1),
                Name = var_name_(Data,Type1,Name1)
        },
		parameter_(Data,[Type,Name]),!.




%these parameters are used in a function's definition
optional_parameters(Data,A) --> "",parameters(Data,A).

parameter1(Data,parameter(A)) -->
	parameter(Data,A).
parameter1(Data,default_parameter(A)) -->
	default_parameter(Data,A).

parameters(Data,Params) --> 
	{Params = []}, "";parameters_(Data,Params).
parameters_(Data,[A]) -->
	parameter1(Data,A).
parameters_(Data,[A|B]) -->
	parameter1(Data,A),python_ws,parameter_separator(Data),python_ws,parameters_(Data,B).

function_call_parameters(Data,[Params1_],[[Params2_,_]]) -->
        parentheses_expr(Data,Params2_,Params1_).
function_call_parameters(Data,[Params1_|Params1__],[[Params2_,_]|Params2__]) -->
        (parentheses_expr(Data,Params2_,Params1_),function_call_parameter_separator(Data),function_call_parameters(Data,Params1__,Params2__)).

function_call_parameter_separator([Lang|_]) -->
    parameter_separator([Lang|_]).

top_level_statement_separator(Data) -->
	{Data = [Lang|_], memberchk(Lang,['picat','prolog','logtalk','erlang','constraint handling rules'])} -> ws;
	statement_separator(Data).

key_value(Data,Type,[Key_,Val_]) -->
        {
                A = symbol(Key_),
                B = expr(Data,Type,Val_)
        },
        key_value_(Data,[A,B]).

ws(Data) -->
	{Data = [Lang|_]},
	({Lang='python'} ->
	python_ws;
	ws).
ws_(Data) -->
	{Data = [Lang|_]},
	({Lang='python'} ->
	python_ws_;ws_).

top_level_statement(Data,Type,A_) -->
    {A = statement(Data,Type,A_)},
    top_level_statement_(Data,A).

statements(Data,Return_type,[A]) --> statement(Data,Return_type,A).
statements(Data,Return_type,[A|B]) --> statement(Data,Return_type,A),statement_separator(Data),statements(Data,Return_type,B).


vars_list(Data,Type,[A]) --> var_name_(Data,Type,A).
vars_list(Data,Type,[A|B]) --> var_name_(Data,Type,A),",",vars_list(Data,Type,B).

initialize_vars_list(Data,Type,[A]) --> {A = [A1,A2],A1_=var_name_(Data,Type,A1),A2_=parentheses_expr(Data,Type,A2)},set_var_(Data,[A1_,Type,A2_]).
initialize_vars_list(Data,Type,[A|B]) --> {A = [A1,A2],A1_=var_name_(Data,Type,A1),A2_=parentheses_expr(Data,Type,A2)},set_var_(Data,[A1_,Type,A2_]),",",initialize_vars_list(Data,Type,B).

ws_separated_statements(Data,[A]) --> top_level_statement(Data,_,A).
ws_separated_statements(Data,[A|B]) --> top_level_statement(Data,_,A),top_level_statement_separator(Data),ws_separated_statements(Data,B).

class_statements(Data,Class_name,[A]) --> class_statement(Data,Class_name,A).
class_statements(Data,Class_name,[A|B]) --> class_statement(Data,Class_name,A),statement_separator(Data),class_statements(Data,Class_name,B).

dict_(Data,Type,[A]) --> key_value(Data,Type,A).
dict_(Data,Type,[A|B]) --> key_value(Data,Type,A),key_value_separator(Data),dict_(Data,Type,B).

initializer_list_(Data,Type,[A]) --> expr(Data,Type,A).
initializer_list_(Data,Type,[A|B]) --> expr(Data,Type,A),initializer_list_separator(Data),initializer_list_(Data,Type,B).

enum_list(Data,[A]) --> enum_list_(Data,A).
enum_list(Data,[A|B]) --> enum_list_(Data,A),enum_list_separator(Data),enum_list(Data,B).

enum_list_(Data,A_) -->
			{
					A = symbol(A_)
			},
			enum_list_(Data,[A]).





between_(A,B,C) :- char_code(A,A1),char_code(B,B1),nonvar(C),char_code(C,C1),between(A1,B1,C1).


char_literal(A) --> "\'",{dif(A,"\'"),dif(A,"\n")},[A],"\'".

:-include(common_grammar).

regex_literal(Data,S_) -->
    {S = regex_inner(S_)},
    regex_literal_(Data,[S]).

comment_inner([A]) --> comment_inner_(A).
comment_inner([A|B]) --> comment_inner_(A),comment_inner(B).
comment_inner_(A) --> {dif(A,'\n')},[A].
regex_inner([A]) --> regex_inner_(A).
regex_inner([A|B]) --> regex_inner_(A),regex_inner(B).
regex_inner_(A) --> {A="\\\"";A="\\\'"},A;{dif(A,'"'),dif(A,'\n')},[A].


statements_with_ws(Data,A) -->
    (include_in_each_file(Data);""),ws_separated_statements(Data,A),ws.


print_var_types([A]) :-
    writeln(A).
print_var_types([A|Rest]) :-
    writeln(A),print_var_types(Rest).


parse(javascript,_,_,Input,Ls) :-
	phrase(statements_with_ws([Lang1,true,[],"\n"],Ls), Input),
	writeln(Ls).


:- include(grammars).
:- include(statement).
:- include(statement_with_semicolon).
:- include(class_statement).
:- include(expr).
:- include(dot_expr).
:- include(parentheses_expr).
