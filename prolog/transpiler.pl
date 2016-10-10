:- module('transpiler', [translate/2,translate/3,translate/4,translate_langs/1]).
:- use_module(library(chr)).
:- chr_constraint var_type/3.
var_type(Namespace,Var,Type) \ var_type(Namespace,Var,Type) <=> true.
var_type(Namespace,Var,Type1),var_type(Namespace,Var,Type2) ==> Type1=Type2. 

:- set_prolog_flag(double_quotes,chars).

% This is a program that translates several programming languages into several other languages.

% Edit this list to specify the languages that should be translated. Each language should be written in lowercase:
list_of_langs(X) :-
	%X = ['javascript','c#',ruby,c,'c++','go','php','swift','octave','lua','pydatalog',prolog,'constraint handling rules',perl,'haxe'].
	%X = ['lua','ruby','javascript','php','c#','java','c#','haxe','lua','python','constraint handling rules','prolog','perl'].
	X=['javascript','java','python'].

translate((Input,Lang2),Output) :-
	translate(Input,Lang2,Output).
translate((Input,Lang1,Lang2),Output) :-
	translate(Input,Lang1,Lang2,Output).
	
translate(Input_,Lang2,Output) :-
	atom_chars(Input_,Input), list_of_langs(X),member(Lang1,X),translate(Input,Lang1,Lang2,Output_), atom_chars(Output,Output_).
translate(Input,Lang1,Lang2,Output) :-
	parse(Lang1,Lang2,true,Input,Ls),
	parse(Lang2,Lang1,false,Output,Ls).

namespace(Data,Data1,Name1,Indent) :-
	Data = [Lang,Is_input,Namespace,Var_types,Indent,Lang2],
	Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent),Lang2].

namespace(Data,Data1,Name,Indent) -->
	    {
                namespace(Data,Data1,Name,Indent)
        },
		optional_indent(Data,Indent).

offside_rule_langs(X) :-
	X = ['python','cython','coffeescript','cosmos','cobra'].

prefix_arithmetic_langs(X) :-
	X = ['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript'].


%Use this rule to define operators for various languages

file_extension(java) --> "java".
file_extension(c) --> "c".
file_extension('c++') --> "cpp".

infix_operator(Symbol,Exp1,Exp2) -->
        Exp1,python_ws,Symbol,python_ws,Exp2.

prefix_operator(Data,Type,Symbol,Exp1,Exp2) -->
        "(",Symbol,ws_,expr(Data,Type,Exp1),ws_,expr(Data,Type,Exp2),")".


% this is from http://stackoverflow.com/questions/20297765/converting-1st-letter-of-atom-in-prolog
first_char_uppercase(WordLC, WordUC) :-
    atom_chars(WordLC, [FirstChLow|LWordLC]),
    atom_chars(FirstLow, [FirstChLow]),
    upcase_atom(FirstLow, FirstUpp),
    atom_chars(FirstUpp, [FirstChUpp]),
    atom_chars(WordUC, [FirstChUpp|LWordLC]).

function_name(Data,Type,A,Params) -->
        symbol(A),{is_var_type_(Data,[A,Params], Type)}.


indent(Indent) --> (Indent,("\t")).


else(Data,Return_type,Statements_) -->
        {
                indent_data(Indent,Data,Data1),
                A = statements(Data1,Return_type,Statements_)
        },
        optional_indent(Data,Indent),
        else(Data,[Indent,A]).


first_case(Data,Return_type,Switch_expr,int,[Expr_,Statements_,Case_or_default_]) -->
    {
            indent_data(Indent,Data,Data1),
            B=statements(Data1,Return_type,Statements_),
            Compare_expr = expr(Data,bool,compare(int,Switch_expr,Expr_)),
            Expr = expr(Data,int,Expr_),

            Case_or_default = (case(Data,Return_type,Switch_expr,int,Case_or_default_);default(Data,Return_type,int,Case_or_default_))
    },
    optional_indent(Data,Indent),
    first_case_(Data,[B,Compare_expr,Expr,Case_or_default]).

case(Data,Return_type,Switch_expr,int,[Expr_,Statements_,Case_or_default_]) -->
        {
                indent_data(Indent,Data,Data1),
                B=statements(Data1,Return_type,Statements_),
                A = expr(Data,bool,compare(int,Switch_expr,Expr_)),
                Expr = expr(Data,int,Expr_),
                Case_or_default = (case(Data,Return_type,Switch_expr,int,Case_or_default_);default(Data,Return_type,int,Case_or_default_))
        },
    optional_indent(Data,Indent),
    case(Data,[A,B,Expr,Case_or_default,Indent]).

default(Data,Return_type,int,Statements_) -->
        {
                indent_data(Indent,Data,Data1),
                A = statements(Data1,Return_type,Statements_)
        },
        optional_indent(Data,Indent),
        default(Data,[A,Indent]).



elif_or_else(Data,Return_type,[A]) --> elif(Data,Return_type,A).
elif_or_else(Data,Return_type,[A|B]) --> elif(Data,Return_type,A),ws(Data),elif_separator(Data),ws(Data),elif_or_else(Data,Return_type,B).

elif_separator([Lang|_]) -->
	{Lang = 'prolog'} -> ";";statement_separator([Lang|_]).

indent_data(Indent,Data,Data1) :-
    Data = [Lang,Is_input,Namespace,Var_types,Indent,Lang2],
    Data1 = [Lang,Is_input,Namespace,Var_types,indent(Indent),Lang2].

elif(Data,Return_type,[Expr_,Statements_]) -->
        {
                indent_data(Indent,Data,Data1),
                B=statements(Data1,Return_type,Statements_),
                A=expr(Data,bool,Expr_)
        },
        elif(Data,[Indent,A,B]).


is_var_type([_,_,Namespace,Var_types,_,_], Name, Type) :-
    var_type(Namespace,Name,Type).

%This is only for checking types of functions in global scope
is_var_type_([_,_,_,Var_types,_,_], [Name,Params], Type) :-
    var_type([],[Name,Params],Type).

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
		parameter_(Data,[Type,Name]).


varargs(Data,[Type1,Name1]) -->
        {
                Type = type(Data,Type1),
                Name = var_name_(Data,Type1,Name1)
        },
		varargs_(Data,[Type,Name]).



%these parameters are used in a function's definition
optional_parameters(Data,A) --> "",parameters(Data,A).

parameters(Data,Params) --> 
	{Params = []}, "";parameters_(Data,Params).
parameters_(Data,[A]) -->
	parameter(Data,A);default_parameter(Data,A);varargs(Data,A).
parameters_(Data,[A|B]) -->
	parameter(Data,A),python_ws,parameter_separator(Data),python_ws,parameters_(Data,B).

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
    top_level_statement_(Data,Type,A).

statements(Data,Return_type,[A]) --> statement(Data,Return_type,A).
statements(Data,Return_type,[A|B]) --> statement(Data,Return_type,A),statement_separator(Data),statements(Data,Return_type,B).


vars_list(Data,Type,[A]) --> var_name_(Data,Type,A).
vars_list(Data,Type,[A|B]) --> var_name_(Data,Type,A),",",vars_list(Data,Type,B).

initialize_vars_list(Data,Type,[A]) --> {A = [A1,A2],A1_=var_name_(Data,Type,A1),A2_=parentheses_expr(Data,Type,A2)},set_var_(Data,[A1_,A2_]).
initialize_vars_list(Data,Type,[A|B]) --> {A = [A1,A2],A1_=var_name_(Data,Type,A1),A2_=parentheses_expr(Data,Type,A2)},set_var_(Data,[A1_,A2_]),",",initialize_vars_list(Data,Type,B).

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



% whitespace
ws --> "";((" ";"\t";"\n";"\r"),ws).
ws_ --> (" ";"\n";"\r"),ws.

python_ws --> "";((" ";"\t"),python_ws).
python_ws_ --> (" ";"\t"),python_ws.

symbol([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([L|Ls]) --> csym(L), symbol_r(Ls).
symbol_r([])     --> [].
letter(Let)     --> [Let], { code_type1(Let, alpha) }.
csym(Let)     --> [Let], {code_type1(Let, csym)}.

code_type1(C,csym) :- code_type1(C,digit);code_type1(C,alpha);C='_'.
code_type1(C,digit) :- between_('0','9',C).
code_type1(C,alpha) :- between_('A','Z',C);between_('a','z',C).

between_(A,B,C) :- char_code(A,A1),char_code(B,B1),nonvar(C),char_code(C,C1),between(A1,B1,C1).

string_literal(S) --> "\"",string_inner(S),"\"".
string_literal1(S) --> "\'",string_inner1(S),"\'".
regex_literal(Data,S_) -->
    {S = regex_inner(S_)},
    regex_literal_(Data,[S]).

comment_inner([A]) --> comment_inner_(A).
comment_inner([A|B]) --> comment_inner_(A),comment_inner(B).
comment_inner_(A) --> {dif(A,'\n')},[A].
string_inner([A]) --> string_inner_(A).
string_inner([A|B]) --> string_inner_(A),string_inner(B).
string_inner_(A) --> {A="\\\""},A;{dif(A,'"'),dif(A,'\n')},[A].
regex_inner([A]) --> regex_inner_(A).
regex_inner([A|B]) --> regex_inner_(A),regex_inner(B).
regex_inner_(A) --> {A="\\\"";A="\\\'"},A;{dif(A,'"'),dif(A,'\n')},[A].

string_inner1([A]) --> string_inner1_(A).
string_inner1([A|B]) --> string_inner1_(A),string_inner1(B).
string_inner1_(A) --> {A="\\'"},A;{dif(A,'\''),dif(A,'\n')},[A].

a_number([A,B]) -->
        (a__number(A), ".", a__number(B)).

a_number(A) -->
        a__number(A).

a__number([L|Ls]) --> digit(L), a__number_r(Ls).
a__number_r([L|Ls]) --> digit(L), a__number_r(Ls).
a__number_r([])     --> [].
digit(Let)     --> [Let], { code_type1(Let, digit) }.


statements_with_ws(Data,A) -->
    (include_in_each_file(Data);""),ws_separated_statements(Data,A),ws.

include_in_each_file(Data) -->
	include_in_each_file_(Data).

print_var_types([A]) :-
    writeln(A).
print_var_types([A|Rest]) :-
    writeln(A),print_var_types(Rest).

translate_langs(Input_) :-
	atom_chars(Input_,Input),
	list_of_langs(X),
	member(Lang,X), parse(Lang,Lang2,true,Input,Ls),
	translate_langs(Ls,X,Lang2).

parse(Lang1,Lang2,Is_input,Input,Ls) :-
	phrase(statements_with_ws([Lang1,Is_input,[],_,"\n",Lang2],Ls), Input).

translate_langs(_,[],_) :-
	true.

translate_langs(Ls,[Lang|Langs],Lang2) :-
    parse(Lang,Lang2,false,Output,Ls),
    atom_chars(Output_,Output),writeln(''),writeln(Lang),writeln(''),writeln(Output_),writeln(''),
    translate_langs(Ls,Langs,Lang2).

:- include(grammars).
:- include(statement).
:- include(statement_with_semicolon).
:- include(class_statement).
:- include(expr).
:- include(dot_expr).
:- include(parentheses_expr).
