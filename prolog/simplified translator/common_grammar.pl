:- use_module(library(dcg/basics)).

string_literal("") --> "\"\"",!.
string_literal(S) --> "\"",string_inner(S),"\"",!.
string_literal1("") --> "\'\'",!.
string_literal1(S) --> "\'",string_inner(S),"\'".
string_inner([A]) --> string_inner_(A).
string_inner([A|B]) --> string_inner_(A),string_inner(B).
string_inner_(A) --> {A="\\\"";A="\\\'"},A;{dif(A,'"'),dif(A,'\''),dif(A,'\n')},[A].

ws --> "";blanks.
ws_ --> (" ";"\n";"\r";"\t"),blanks.

python_ws --> "";python_ws_.
python_ws_ --> (" ";"\t"),python_ws.

symbol([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([L|Ls]) --> csym(L), symbol_r(Ls).
symbol_r([])     --> [].
letter(Let)     --> [Let], { code_type(Let, alpha) }.
csym(Let)     --> [Let], {code_type(Let, csym)}.

a_double(A) --> a_double_(A).
a_double([-A]) --> "-",a_double_(A).
a_double_([A,['0']]) -->
        (an_int(A)).
a_double_([A,B]) -->
        (an_int(A), ".",!, an_int(B)).
an_int([L|Ls]) --> digit(L), an_int_r(Ls).
an_int_r([L|Ls]) --> digit(L), an_int_r(Ls).
an_int_r([])     --> [].
